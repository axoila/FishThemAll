var p = new Player();

var waterCanvas = document.getElementById('canvas_water');
var waterContext = waterCanvas.getContext('2d');
var fishCanvas = document.getElementById('canvas_fish');
var fishContext = fishCanvas.getContext('2d');
var overlayCanvas = document.getElementById('canvas_overlay');
var overlayContext = overlayCanvas.getContext('2d');

var textures = new TextureHandler();
textures.appendImage("./ship/boot.png");
textures.appendImage("./fish/fish.png");


ticker();

function ticker(){
  waterContext.clearRect(0, 0, waterCanvas.width, waterCanvas.height);
  fishContext.clearRect(0, 0, fishCanvas.width, fishCanvas.height);
  overlayContext.clearRect(0, 0, overlayCanvas.width, overlayCanvas.height);
  p.draw();

  window.requestAnimationFrame(ticker);
}

function Player(){
  this.pos = new Vector(210, 210);
  var speed = 1; //speed in pixels per second

  this.draw = function(){
    textures.drawImage(this.pos, 0, overlayContext, true);
  }
}

function Vector(x, y){
  this.x = x;
  this.y = y;
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
      modContext = modCanvas.getContext('2d');
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