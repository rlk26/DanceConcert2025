class StopSign {
  float x, y;
  float size;
  float rotation;
  float rotSpeed;
  float driftAngle;
  float driftSpeed;
  
  StopSign() {
    x = random(width);
    y = random(height);
    size = random(25, 50);
    rotation = random(TWO_PI);
    rotSpeed = random(-0.01, 0.01);
    driftAngle = random(TWO_PI);
    driftSpeed = random(0.2, 0.6);
  }
  
  void update() {
    rotation += rotSpeed;
    driftAngle += 0.01;
    x += cos(driftAngle) * driftSpeed;
    y += sin(driftAngle) * driftSpeed;
    if (x < -size) x = width + size;
    if (x > width + size) x = -size;
    if (y < -size) y = height + size;
    if (y > height + size) y = -size;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
   
    for (int i = 4; i > 0; i--) {
      float alpha = 25 * i;
      float blur = i * 2;
      fill(200, 0, 0, alpha);
      stroke(255);
      strokeWeight(2);
      drawOctagon(0, 0, size + blur);
    }
    
   
    stroke(255, 180);
    strokeWeight(1);
    line(-size * 0.3, -size * 0.3, size * 0.3, size * 0.3);
    line(size * 0.3, -size * 0.3, -size * 0.3, size * 0.3);
    
    popMatrix();
  }
  
  void drawOctagon(float x, float y, float r) {
    beginShape();
    for (int i = 0; i < 8; i++) {
      float angle = TWO_PI / 8 * i;
      float vx = x + cos(angle) * r;
      float vy = y + sin(angle) * r;
      vertex(vx, vy);
    }
    endShape(CLOSE);
  }
}
