class RedLight {
  float x, y;
  float size;
  float glow;
  float glowSpeed;
  float vx, vy;

  RedLight() {
    x = random(width);
    y = random(height);
    size = random(8, 20);
    glow = random(255);
    glowSpeed = random(2, 4);
    vx = random(-0.3, 0.3);
    vy = random(-0.3, 0.3);
  }


  void update() {
    glow += glowSpeed;
    x += vx + sin(frameCount * 0.015) * 0.2;
    y += vy + cos(frameCount * 0.015) * 0.2;
    if (x < -size) x = width + size;
    if (x > width + size) x = -size;
    if (y < -size) y = height + size;
    if (y > height + size) y = -size;
  }
  void display() {
    float brightness = map(sin(glow * 0.05), -1, 1, 80, 220);
    noStroke();


    for (int i = 6; i > 0; i--) {
      float alpha = brightness * 0.07 * i;
      fill(255, 60, 60, alpha);
      ellipse(x, y, size * i * 0.5, size * i * 0.5);
    }

    // Core light with soft shimmer
    fill(255, 100, 100, brightness);
    ellipse(x, y, size * 0.5, size * 0.5);
  }
}
