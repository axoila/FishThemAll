var p = new Player();

var waterCanvas = document.getElementById('canvas_water');
var waterContext = waterCanvas.getContext('2d');
var fishCanvas = document.getElementById('canvas_fish');
var fishContext = fishCanvas.getContext('2d');
var overlayCanvas = document.getElementById('canvas_overlay');
var overlayContext = overlayCanvas.getContext('2d');

var textures = new TextureHandler();
textures.appendImage("./cursor/cursor.png");
textures.appendImage("./ship/boot.png");
textures.appendImage("./fish/fish.png");

var delta = 0;
var d = new Date();
var lastFrame = d.getTime();
function ticker(){
  d = new Date();
  delta = (d.getTime() - lastFrame) / 1000.0;
  lastFrame = d.getTime();
  
  waterContext.clearRect(0, 0, waterCanvas.width, waterCanvas.height);
  fishContext.clearRect(0, 0, fishCanvas.width, fishCanvas.height);
  overlayContext.clearRect(0, 0, overlayCanvas.width, overlayCanvas.height);
  p.draw();

  window.requestAnimationFrame(ticker);
}

function Player(){
  this.pos = new Vector(210, 210);
  var speed = 0.001; //speed in pixels per second
  
  this.draw = function(){
    var velocity = new Vector(mousePos.x, mousePos.y);
    velocity.subtract(this.pos).normalize().scalarMultiply(speed);
    this.pos = (mousePos);
    
    //console.log(this.pos);
    
    textures.drawImage(this.pos, 0, overlayContext, true);
  }
}

function Vector(x, y){
  this.x = x;
  this.y = y;
  
  this.subtract = function(vec){
    this.x -= vec.x;
    this.y -= vec.y;
    return this;
  }
  
  this.add = function(vec){
    this.x += vec.x;
    this.y += vec.y;
    return this;
  }
  
  this.scalarMultiply = function(scalar){
    x *= scalar;
    y *= scalar;
    return this;
  }
  
  this.normalize = function(){
    var length = this.length();
    if (length > 0){
      x /= length;
      y /= length;
    }
    return this;
  }
  
  this.length = function(){
    return Math.sqrt(x*x + y*y);
  }
}

function TextureHandler(){
  this.images = [];

  this.appendImage = function(url){
    this.images.push(new Image());
    this.images[this.images.length - 1].onload = function(){
      var modCanvas = document.createElement('canvas');
      modCanvas.width = this.width;
      modCanvas.height = this.height;
      modCanvas.getContext('2d').drawImage(this, 0, 0, this.width, this.height);
      var modContext = modCanvas.getContext('2d');
      var imgd = modContext.getImageData(0, 0, this.width, this.height);
      var pix = imgd.data;
      for (var i = 0, n = pix.length; i < n; i += 4) {
        if(pix[i]==255&&pix[i+1]==0&&pix[i+2]==255){
          if(pix[i+3] == 0){
            console.log("second run?");
            return;
          }
          pix[i+3] = 0;
        }
      }
      modContext.putImageData(imgd, 0, 0);
      var imgUrl = modCanvas.toDataURL();
      this.src = imgUrl;
    }
    this.images[this.images.length - 1].src = url;
  }

  this.drawImage = function(pos, textureIndex, context, centered){
    var image = this.images[textureIndex];
    if(centered){
      context.drawImage(image, pos.x - image.width/2, pos.y-image.width/2);
    } else {
      context.drawImage(image, pos.x , pos.y);
    }
  }
}

var mousePos = new Vector(0, 0);
document.onmousemove = function(event){
  mousePos.x = (event.clientX - canvas_overlay.offsetLeft) * canvas_overlay.width / canvas_overlay.offsetWidth;
  mousePos.y = (event.clientY - canvas_overlay.offsetTop) * canvas_overlay.height / canvas_overlay.offsetHeight;
}



ticker();