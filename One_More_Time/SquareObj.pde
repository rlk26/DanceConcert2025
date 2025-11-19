class SquareObj extends Shape {
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(c);
    noStroke();
    rectMode(CENTER);
    rect(0, 0, size, size);
    popMatrix();
  }
}
