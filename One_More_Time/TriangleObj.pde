class TriangleObj extends Shape {
  void display() {
    noStroke();
    fill(c);
    pushMatrix();
    translate(x, y);
    triangle(-size/2, size/2, 0, -size/2, size/2, size/2);
    popMatrix();
  }
}
