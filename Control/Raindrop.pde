class Raindrop {
  PVector pos, vel, acc;
  float len;
  float wid;
  float wind;
  
  Raindrop() {
    reset();
  }
  
  void reset() {
    wind = 1;
    
    pos = new PVector(random(width), random(-width * 0.26, -width * 0.00521));
    vel = new PVector(wind, random(width * 0.00104, width * 0.0026));
    acc = new PVector(0, random(width * 0.000104, width * 0.00026));
    
    len = random(width * 0.00521, width * 0.026);
    wid = random(width * 0.00156, width * 0.0026);
  }
  
  void update() {
    pos.add(vel);
    vel.add(acc);
  }
  
  void display() {
    stroke(60, 81, 120, 7 * len); 
    strokeWeight(wid);
    
    line(pos.x, pos.y, pos.x - wind, pos.y - len);
  }
  
  boolean onScreen() {
    return pos.x >= 0 && pos.x <= width && pos.y >= -width * 0.26 && pos.y - len <= height;
  }
}
