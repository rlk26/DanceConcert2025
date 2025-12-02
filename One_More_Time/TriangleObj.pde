class TriangleObj extends Shape {
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(c);
    noStroke();
    triangle(0, -size/2, -size/2, size/2, size/2, size/2);
    popMatrix();
  }
}
