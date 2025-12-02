class EllipseObj extends Shape {
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(c);
    noStroke();
    ellipse(0, 0, size, size);
    popMatrix();
  }
}
