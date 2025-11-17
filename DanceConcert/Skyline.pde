class Skyline extends Scene {
  PImage skyline;
  int Y_AXIS = 1;
  color color1;
  color color2;
  color color3;
  int y = 0;
  PImage stars;
  Skyline (){
    background(0);
    skyline = loadImage ("skyline.png");
    skyline.resize(width, 500);

    stars = loadImage("stars.png");
    stars.resize(width, height);

    color1 = color(31, 35, 41);
    color2 = color(212, 187, 129);
    color3 = color(0, 0, 0);
    
    frameRate(10);
  }
  void run (){
    setGradient(0, y, width, height, color1, color2, Y_AXIS);
    y++;
        
    imageMode(CENTER);
    image(skyline, width/2, height-height/4);

    imageMode(CENTER);
    tint(255, 128);
  }
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis) {
  noFill();
  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(color1, color2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
}

}
