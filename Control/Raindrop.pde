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
    
    pos = new PVector(random(X, X + WIDTH), random(Y - WIDTH * 0.26, Y - WIDTH * 0.00521));
    vel = new PVector(wind, random(WIDTH * 0.00104, WIDTH * 0.0026));
    acc = new PVector(0, random(WIDTH * 0.000104, WIDTH * 0.00026));
    
    len = random(WIDTH * 0.00521, WIDTH * 0.026);
    wid = random(WIDTH * 0.00156, WIDTH * 0.0026);
  }
  
  void update() {
    pos.add(vel);
    vel.add(acc);
  }
  
  void display() {
    stroke(150, 180, 230, 7 * len); 
    strokeWeight(wid);
    
    line(pos.x, pos.y, pos.x - wind, pos.y - len);
  }
  
  boolean onScreen() {
    return pos.x >= X && pos.x <= X + WIDTH && pos.y >= Y - WIDTH * 0.26 && pos.y <= Y + HEIGHT;
  }
}
