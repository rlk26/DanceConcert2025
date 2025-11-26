class FeelingGood extends Scene {
  ArrayList<Line> lines;

  FeelingGood() {

    fullScreen();

    lines = new ArrayList<Line>();
  }


  void run() {
    background(0);
    frameRate(5);


    for (int u = 0; u < 10; u++) {
      lines.add(new Line(random(width), random(height), random(3, 15), random(50, 300)));
    }
    for (Line l : lines) {
      l.display();
      l.update();
    }
  }

  class Line {
    float x, y, w, h;
    color c;
    float speedX, speedY; // Separate speeds for precise diagonal control
    float rotation;

    // Constructor is simplified
    Line(float xIn, float yIn, float wIn, float hIn) {
      c = color(random(50, 255), 0, 0);
      x = xIn;
      y = yIn;
      w = wIn;
      h = hIn;
      rotation = PI/4; // 45 degrees
      speedX = 3.5;
      speedY = random(-20, -5);
    }

    void display() {
      pushMatrix();
      fill(c);
      noStroke();
      translate(x, y);
      rotate(rotation);
      rect(0, 0, w, h);
      popMatrix();
    }

    void update() {
      x += speedX;
      y += speedY;

      // 2. Wrap the lines when they go off-screen (bottom right corner)
      if (x > width + w || y > height + h) {
        x = -w; // Reset to the far left
        y = random(-h, height / 2); // Reset to a random position on the top-left area
      }
    }
  }
}
