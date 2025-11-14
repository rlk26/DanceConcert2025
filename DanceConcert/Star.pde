class Star {
  float x, y, z;
  float size;
  float twinkle;
  float twinkleSpeed;
  
  Star() {
    x = random(width);
    y = random(height);
    z = random(width);
    size = random(1, 3);
    twinkle = random(TWO_PI);
    twinkleSpeed = random(0.02, 0.08);
  }
  
  void update() {
    twinkle += twinkleSpeed;
    x += sin(frameCount * 0.001 + z * 0.01) * 0.5;
    y += cos(frameCount * 0.001 + z * 0.01) * 0.5;
    if (x < 0) x = width;
    if (x > width) x = 0;
    if (y < 0) y = height;
    if (y > height) y = 0;
  }
  
  void display() {
    float brightness = map(sin(twinkle), -1, 1, 100, 255);
    noStroke();
    fill(255, 255, 200, brightness);
    ellipse(x, y, size, size);
    fill(255, 255, 200, brightness * 0.3);
    ellipse(x, y, size * 3, size * 3);
  }
}
