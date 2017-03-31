var p = new Player();

var waterCanvas = document.getElementById('canvas_water');
var waterContext = waterCanvas.getContext('2d');
var fishCanvas = document.getElementById('canvas_fish');
var fishContext = fishCanvas.getContext('2d');
var overlayCanvas = document.getElementById('canvas_overlay');
var overlayContext = overlayCanvas.getContext('2d');

function ticker(){
  p.draw();

  window.requestAnimationFrame(ticker);
}

function Player(){
  this.pos = new Vector(210, 210);
  var speed = 1; //speed in pixels per second

  //make player image
  this.image = new Image();
  this.image.src = "fish/fish.png";

  this.draw = function(){
    overlayContext.drawImage(this.image, this.pos.x - this.image.width/2, this.pos.y - this.image.height/2);
  }
}

function Vector(x, y){
  this.x = x;
  this.y = y;
}

ticker();
