class FlameParticle {
  PVector pos, vel;
  float size, maxSize, sizeInc;
  float alpha, maxAlpha, alphaInc;
  boolean entering;
  color col;
  
  FlameParticle(float x, float y) {
    reset(x, y);
  }
  
  void reset(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector(random(-WIDTH * 0.00104, WIDTH * 0.00104), random(-WIDTH * 0.00313, -WIDTH * 0.000521));
    
    maxSize = random(WIDTH * 0.0104, WIDTH * 0.0208);
    maxAlpha = 255;
    
    size = 0;
    alpha = 0;
    
    sizeInc = maxSize / 15;
    alphaInc = maxAlpha / 15;
    
    col = color(250, random(50, 230), 10);
    
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
    fill(col, alpha);
    noStroke();
    rect(pos.x, pos.y, size, size);
  }
  
  boolean done() {
    return alpha <= 5;
  }
}
