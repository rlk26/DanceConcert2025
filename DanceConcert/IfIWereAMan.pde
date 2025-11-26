class IfIWereAMan extends Scene {
  PImage bridgerton;
  ArrayList<Petal> petals;
  IfIWereAMan() {
    bridgerton = loadImage("bridgertonn_2.jpeg");
    bridgerton.resize(width, height);

    petals = new ArrayList<Petal>();

    for (int i = 0; i < 40; i++) {
      petals.add(new Petal());
    }
  }
  void run() {
    image(bridgerton, 0, -275);

    for (Petal p : petals) {
      p.update();
      p.display();
    }
  }

  class Petal {
    float x;
    float y;
    PImage petal;
    float speed;
    float rotation;

    Petal() {
      petal = loadImage("whitepetal.png");
      petal.resize(petal.width/16, petal.height/16);

      //random position across screen
      x = random(width);
      y = random(-height, 0);
      speed = random(3/4, 1);
      rotation = random(TWO_PI);
    }

    void update() {
      y += speed;
      if (y > height) {
        y = random(-300, -100); // Reset above the screen
        x = random(width); // New random x position
      }
    }

    // petal display
    void display() {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      imageMode(CENTER);
      image(petal, 0, 0);
      imageMode(CORNER);
      popMatrix();
    }
  }
}
