class Organic extends Scene {
  //organic lines
  ArrayList <Lines> grains;
  Organic() {
    grains = new ArrayList<Lines>();
    noFill();
    stroke(255, 100);
    background(0);

    // Create tiny grains
    for (int i = 0; i < 1000; i++) {
      float x = random(width);
      float y = random(height);
      grains.add(new Lines(x, y));
    }
  }


  void run() {
    for (Lines grain : grains) {
      grain.move();
      grain.display();
    }
  }

  class Lines {
    float x, y;
    float size, speed;
    Lines(float xIn, float yIn) {
      x = xIn;
      y= yIn;
      size = random(1, 4);
      speed = 1.2;
    }

    void move() {
      float noiseX = noise(this.x * 0.01, this.y * 0.01) * 2 - 1;
      float noiseY = noise(this.y * 0.01, this.x * 0.01) * 2 - 1;

      x += noiseX * this.speed;
      y += noiseY * this.speed;

      x = (x + width) % width;
      y = (y + height) % height;
    }

    void display() {
      float r = random(200, 255);
      float g = random(100, 200);
      float b = random(150, 255);

      stroke(r, g, b, 50); // Slightly transparent
      ellipse(x, y, size, size);
    }
  }
}
