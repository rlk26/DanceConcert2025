class StarObj extends Shape {
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(c);
    noStroke();
    beginShape();
    for (int i = 0; i < 10; i++) {
      float angle = i * PI / 5;
      float radius = (i % 2 == 0) ? size / 2 : size / 4;
      float px = cos(angle) * radius;
      float py = sin(angle) * radius;
      vertex(px, py);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
