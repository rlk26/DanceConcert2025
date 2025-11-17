class FlameParticle {
  PVector pos, vel;
  float size, maxSize, sizeInc;
  float alpha, maxAlpha, alphaInc;
  boolean entering;
  
  FlameParticle(float x, float y) {
    reset(x, y);
  }
  
  void reset(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(-width * 0.00104, width * 0.00104), random(-width * 0.00313, -width * 0.000521));
    
    maxSize = random(width * 0.0104, width * 0.0208);
    maxAlpha = 255;
    
    size = 0;
    alpha = 0;
    
    sizeInc = maxSize / 15;
    alphaInc = maxAlpha / 15;
    
    entering = true;
  }
  
  void update() {
    pos.add(vel);
    
    if (entering) {
      size += sizeInc;
      alpha += alphaInc;
      
      if (size >= maxSize) {
        size = maxSize;
        alpha = maxAlpha;
        entering = false;
      }
    } else {
      size *= 0.97;
      alpha *= 0.97;
    }
  }
  
  void display() {
    fill(250, random(90, 200), 45, alpha);
    noStroke();
    rect(pos.x, pos.y, size, size);
  }
  
  boolean done() {
    return alpha <= 5;
  }
}
