class SquareObj extends Shape {
  void display() {
    noStroke();
    fill(c);
    pushMatrix();
    translate(x, y);
    rectMode(CENTER);
    rect(0, 0, size, size);
    popMatrix();
  }
}
