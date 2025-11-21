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
    x = random(-WIDTH, WIDTH);
    y = random(-HEIGHT, HEIGHT);
    z = random(WIDTH * 0.104, WIDTH * 1.04);
    
    baseSpeed = WIDTH * 0.000781;
    curSpeed = baseSpeed;
    
    radius = random(WIDTH * 0.0026, WIDTH * 0.00521);
    alpha = random(20, 100);
    c = color(255);
  }

  void update(boolean beat, float amp) {
    if (beat) {
      curSpeed = lerp(curSpeed, baseSpeed * map(amp, 0, 0.5, WIDTH * 0.000521, WIDTH * 0.00573), 0.5);
    } else {
      curSpeed = lerp(curSpeed, baseSpeed, 0.5);
    }
    
    z -= curSpeed;
  }

  void display() {
    float scale = WIDTH * 0.26 / z;
    displayX = X + x * scale + WIDTH / 2;
    displayY = Y + y * scale + HEIGHT / 2;
    
    float alpha = map(z, WIDTH * 1.04, 0, 0, 150);
    fill(c, alpha);

    ellipse(displayX, displayY, radius, radius);
  }

  boolean onScreen() {
    return displayX >= 0 && displayX <= width && displayY >= 0 && displayY <= height;
  }
}
