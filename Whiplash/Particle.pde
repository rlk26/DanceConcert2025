class Particle {
  float x, y, z;
  float displayX, displayY;
  float curSpeed;
  float baseSpeed;
  float radius;
  float alpha;
  color c;
  
  Particle() {
    reset();
  }

  void reset() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width * 0.104, width * 1.04);
    
    baseSpeed = width * 0.000781;
    curSpeed = baseSpeed;
    
    radius = random(width * 0.0026, width * 0.00521);
    alpha = random(20, 100);
    c = color(255);
  }

  void update(boolean beat, float amp) {
    if (beat) {
      curSpeed = lerp(curSpeed, baseSpeed * map(amp, 0, 0.5, width * 0.000521, width * 0.00573), 0.5);
    } else {
      curSpeed = lerp(curSpeed, baseSpeed, 0.5);
    }
    
    z -= curSpeed;
  }

  void display() {
    float scale = width * 0.26 / z;
    displayX = x * scale + width / 2;
    displayY = y * scale + height / 2;
    
    float alpha = map(z, width * 1.04, 0, 0, 150);
    fill(c, alpha);

    ellipse(displayX, displayY, radius, radius);
  }

  boolean onScreen() {
    return displayX >= 0 && displayX <= width && displayY >= 0 && displayY <= height;
  }
}
