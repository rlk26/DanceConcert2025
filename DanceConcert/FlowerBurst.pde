class FlowerBurst extends Scene {
  ArrayList<Flower> flowers;
  color colorRandom;
  PImage f1, f2, f3;

  FlowerBurst() {
    f1 = loadImage("flower1.png");
    f2 = loadImage("flower2.png");
    f3 = loadImage("flower3.png");

    flowers = new ArrayList<Flower>();

    int cols = 10; // number of flowers horizontally
    int rows = 6;  // number of flowers vertically

    float spacingX = width / (cols + 1);
    float spacingY = height / (rows + 1);

    // place flowers in a grid
    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        float x = spacingX * (i + 1);
        float y = spacingY * (j + 1);
        flowers.add(new Flower(x, y, f1, f2, f3));
      }
    }

    imageMode(CENTER); // center images for easier grid placement
  }

  void run() {
    // random background color
    //  int randColor = int(random(3));
    //  if (randColor == 0) colorRandom = ##050505;
    //  else if (randColor == 1) colorRandom = #FFB4EF;
    //  else colorRandom = #A4D7FA;

    background(0);
    frameRate(0.5);

    // global phase for synchronized breathing (2-second cycle)
    float cycleDuration = 2000.0; // 2 seconds
    float globalPhase = (millis() % cycleDuration) / cycleDuration * TWO_PI;

    for (Flower f : flowers) {
      f.display(globalPhase);
    }
  }

  class Flower {
    float x, y;
    float scale;
    float rotation;       // current rotation angle
    float rotationSpeed;  // how fast each flower spins
    int randomNum;
    PImage flower1, flower2, flower3;

    // scale limits
    float minScale = 0.5;
    float maxScale = 0.9;

    Flower(float xIn, float yIn, PImage f1, PImage f2, PImage f3) {
      x = xIn;
      y = yIn;

      flower1 = f1;
      flower2 = f2;
      flower3 = f3;

      randomNum = int(random(3));

      rotation = random(360);
      rotationSpeed = random(1, 5);  // each flower spins at its own speed
    }

    void display(float globalPhase) {
      // breathing scale synchronized for all flowers
      scale = map(sin(globalPhase), -1, 1, minScale, maxScale);

      // update rotation continuously
      rotation += rotationSpeed;

      PImage img;
      if (randomNum == 0) img = flower1;
      else if (randomNum == 1) img = flower2;
      else img = flower3;

      pushMatrix();
      translate(x, y);
      rotate(rotation);       // rotate for spinning effect
      tint(255, 156);        // semi-transparent
      imageMode(CENTER);
      image(img, 0, 0, img.width * scale, img.height * scale);
      popMatrix();
    }
  }
}
