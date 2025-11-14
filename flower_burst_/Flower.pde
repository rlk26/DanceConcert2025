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
