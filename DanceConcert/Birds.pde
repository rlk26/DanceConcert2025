class Birds extends Scene {
  final int NUM_BIRDS = 10;
  Bird[] birds;
  PImage birdImg;

  void setup() {
    fullScreen();
    background(0);
    imageMode(CENTER);

    birdImg = loadImage("bird4.png");
    birdImg = makeLavender(birdImg);

    birdImg.resize(100, 100);

    birds = new Bird[NUM_BIRDS];
    for (int i = 0; i < NUM_BIRDS; i++) {
      birds[i] = new Bird();
    }
  }

  void draw() {
    background(0);
    for (Bird b : birds) {
      b.update();
      b.display();
    }
  }

  PImage makeLavender(PImage img) {
    PImage out = createImage(img.width, img.height, ARGB);
    img.loadPixels();
    out.loadPixels();
    color lavender = color(229, 225, 237);

    for (int i = 0; i < img.pixels.length; i++) {
      color c = img.pixels[i];
      float b = brightness(c);
      if (b < 10) {
        out.pixels[i] = lavender;
      } else {
        out.pixels[i] = color(0, 0, 0, 0);
      }
    }

    out.updatePixels();
    return out;
  }

  class Bird {
    float x, y;
    float speed;
    float amplitude;
    float frequency;
    float phase;
    float scale;
    boolean goingRight;

    Bird() {
      reset();
    }

    void reset() {
      x = random(width);
      y = random(height * 0.2, height * 0.8);
      speed = random(1.2, 3.2);
      amplitude = random(5, 20);
      frequency = random(0.01, 0.03);
      phase = random(TWO_PI);
      scale = random(0.4, 1.1);
      goingRight = random(1) > 0.5;
    }

    void update() {
      x += (goingRight ? speed : -speed);
      y += sin(frameCount * frequency + phase) * 0.4;

      if (goingRight && x > width + 100) {
        x = -100;
        y = random(height * 0.2, height * 0.8);
      }
      if (!goingRight && x < -100) {
        x = width + 100;
        y = random(height * 0.2, height * 0.8);
      }
    }

    void display() {
      pushMatrix();
      translate(x, y);
      float tilt = sin(frameCount * frequency + phase) * radians(8);
      if (!goingRight) tilt *= -1;
      rotate(tilt);
      scale(goingRight ? scale : -scale, scale);
      image(birdImg, 0, 0);
      popMatrix();
    }
  }
}
