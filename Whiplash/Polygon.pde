class Polygon {
  float x, y, z;
  float displayX, displayY;
  float angle;
  float speed;
  float radius;
  float alpha;
  int sides;
  color c;

  Polygon(float amp) {
    x = random(1) < 0.5 ? random(-WIDTH * 0.6, -WIDTH * 0.3) : random(WIDTH * 0.3, WIDTH * 0.6);
    y = random(1) < 0.5 ? random(-HEIGHT * 0.6, -HEIGHT * 0.3) : random(HEIGHT * 0.3, HEIGHT * 0.6);
    z = random(WIDTH * 0.208, WIDTH * 0.781);
    
    angle = random(TWO_PI);
    speed = random(WIDTH * 0.0026, WIDTH * 0.00781);
    
    radius = map(amp, 0, 0.3, WIDTH * 0.00521, WIDTH * 0.026);
    alpha = random(150, 255);
    sides = int(random(3, 7));
    c = color(255);
  }

  void update() {
    z -= speed;
    alpha -= 7;
    radius += WIDTH * 0.00156;
  }
  
  void display() {
    float scale = WIDTH * 0.208 / z;
    displayX = X + x * scale + WIDTH / 2;
    displayY = Y + y * scale + HEIGHT / 2;

    fill(0, 80);
    stroke(c, alpha);
    strokeWeight(WIDTH * 0.00208);
    
    polygon(displayX, displayY, radius, sides);
  }

  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }

  boolean onScreen() {
    return displayX >= 0 && displayX <= width && displayY >= 0 && displayY <= height;
  }

  boolean shouldRemove() {
    return alpha <= 0;
  }
}
