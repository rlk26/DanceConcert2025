class Skyline extends Scene {
  PImage skyline;
  int Y_AXIS = 1;
  color color1;
  color color2;
  color color3;
  int y1, y2;
  float y3;
  PImage stars;
  Skyline () {
    background(0);
    skyline = loadImage ("skyline.png");
    skyline.resize(width, 500);

    stars = loadImage("stars.png");
    stars.resize(width, height);

    color1 = color(#373A5A);
    color2 = color(#F57723);
    color3 = color(#E8AE3B);

    y1 = 0;
    y2 = height-height/4;
    y3 = height-height/3.7;

    //frameRate(0.5);
  }
  void run () {
    // frameRate(0.5);

    if (frameCount % 120 == 0)
    {
      setGradient(0, y1, width, height, color1, color2, Y_AXIS);
      y1++;
      //setGradient(0, y2, width, height/2, color2, color3, Y_AXIS);
      // y2++;
      imageMode(CENTER);
      image(skyline, width/2, height-height/2);

      imageMode(CENTER);
      tint(255, 128);
      image(stars, width/2, height/2);

      fill(0);
      rectMode(CORNER);
      rect(0, y3, width, height/4);
    }
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
