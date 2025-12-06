class PreshowLines extends Scene {
  float z = 0;

  PreshowLines() {
    noFill();
  }

  void run() {
    background(0);
    translate(width / 2, height / 2);
    stroke(255);

    int total = 200;
    float radius = width / 2 - 400;

    for (int i = 0; i < total; i++) {
      float angle = map(i, 0, total, 0, TWO_PI);
      float x = radius * cos(angle);
      float y = radius * sin(angle);
      point(x, y);
    }

    // Draw the lines between the points
    for (int i = 0; i < total; i++) {
      float startAngle = map(i, 0, total, 0, TWO_PI);
      float endAngle = map(i * z, 0, total, 0, TWO_PI);

      float startX = radius * cos(startAngle);
      float startY = radius * sin(startAngle);

      float endX = radius * cos(endAngle);
      float endY = radius * sin(endAngle);

      stroke(i, 255, 255);
      line(startX, startY, endX, endY);
    }

    z += 0.005;
  }
}
