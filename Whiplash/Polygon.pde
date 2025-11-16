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
    x = random(1) < 0.5 ? random(-width * 0.6, -width * 0.3) : random(width * 0.3, width * 0.6);
    y = random(1) < 0.5 ? random(-height * 0.6, -height * 0.3) : random(height * 0.3, height * 0.6);
    z = random(width * 0.208, width * 0.781);
    
    angle = random(TWO_PI);
    speed = random(width * 0.0026, width * 0.00781);
    
    radius = map(amp, 0, 0.3, width * 0.00521, width * 0.026);
    alpha = random(150, 255);
    sides = int(random(3, 7));
    c = color(255);
  }

  void update() {
    z -= speed;
    alpha -= 7;
    radius += width * 0.00156;
  }
  
  void display() {
    float scale = width * 0.208 / z;
    displayX = x * scale + width / 2;
    displayY = y * scale + height / 2;

    fill(0, 80);
    stroke(c, alpha);
    strokeWeight(width * 0.00208);
    
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
