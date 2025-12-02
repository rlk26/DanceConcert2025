class Lightning {
  int nextStart, nextEnd;
  boolean active;
  
  Lightning() {
    nextStart = int(random(2000, 9000));
    nextEnd = nextStart + int(random(500, 1000));
    active = false;
  }
  
  void update() {
    if (!active && millis() >= nextStart) {
      active = true;
    }
    
    if (active && millis() >= nextEnd) {
      active = false;
      nextStart = millis() + int(random(2000, 15000));
      nextEnd = nextStart + int(random(300, 1000));
    }
  }
  
  void display() {
    if (active) {
      noStroke();
      fill(200, 220, 255, random(20, 100));
      rect(X, Y, WIDTH, HEIGHT);
      
      if (random(1) < 0.5) {
        fill(60, 130, 230, random(40, 100));
        rect(X, Y, WIDTH, HEIGHT);
      }
      
      if (random(1) < 0.15) {
        fill(30, 90, 170, random(10, 50));
        rect(X, Y, WIDTH, HEIGHT);
      }
    }
  }
}
