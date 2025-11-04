class EllipseObj extends Shape {
  void display() {
    noStroke();
    fill(c);
    ellipse(x, y, size, size);
  }
}
