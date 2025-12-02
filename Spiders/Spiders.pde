int numSpiders = 2;
float minSpiderSize, maxSpiderSize;
float legSwingAmount, legLengthRatio;
color backgroundColor, spiderBodyColor, legColor, strokeColor;
Spider[] spiders;

PImage clownImg, skeletonImg, spiderwebImg, img4, img5, img6;
PImage currentImage = null;
PImage scaledImage = null;

boolean flashing = false;
float flashAlpha = 0;
int flashStartTime = 0;
int flashDuration = 400;
int fadeOutDuration = 200;

float safeHeight;

void setup() {
  fullScreen();
  smooth(8);

  safeHeight = height * (2.0/3.0);

  minSpiderSize = width * 0.04;
  maxSpiderSize = width * 0.08;
  legSwingAmount = PI / 25;
  legLengthRatio = 0.9;

  backgroundColor = color(0);
  spiderBodyColor = color(70);
  legColor = color(70);
  strokeColor = color(0);

  spiders = new Spider[numSpiders];
  for (int i = 0; i < numSpiders; i++) 
    spiders[i] = new Spider(random(width), random(safeHeight));

  clownImg = loadImage("clown.png");
  skeletonImg = loadImage("skeleton.png");
  spiderwebImg = loadImage("spiderweb.png");

  img4 = loadImage("img4.png");
  img5 = loadImage("img5.png");
  img6 = loadImage("img6.png");

  imageMode(CENTER);
}

void draw() {
  background(backgroundColor);
  
  for (Spider s : spiders) {
    s.update();
    s.display();
  }

  handleFlash();
}

void keyPressed() {
  if (key == 'q' || key == 'Q') triggerFlash(clownImg);
  if (key == 'w' || key == 'W') triggerFlash(skeletonImg);
  if (key == 'e' || key == 'E') triggerFlash(spiderwebImg);
  if (key == 'r' || key == 'R') triggerFlash(img4);
  if (key == 't' || key == 'T') triggerFlash(img5);
  if (key == 'y' || key == 'Y') triggerFlash(img6);
}

void triggerFlash(PImage img) {
  if (img == null) return;

  currentImage = img;

  float maxH = safeHeight;
  float ratio = maxH / img.height;
  
  float scaledW = img.width * ratio;
  float scaledH = img.height * ratio;

  scaledImage = img.copy();
  scaledImage.resize((int)scaledW, (int)scaledH);

  flashing = true;
  flashAlpha = 255;
  flashStartTime = millis();
}

void handleFlash() {
  if (!flashing || scaledImage == null) return;

  int now = millis();
  float elapsed = now - flashStartTime;

  if (elapsed < flashDuration) {
    flashAlpha = 255;
  } else if (elapsed < flashDuration + fadeOutDuration) {
    flashAlpha = map(elapsed, flashDuration, flashDuration + fadeOutDuration, 255, 0);
  } else {
    flashing = false;
  }

  if (flashAlpha > 0) {
    tint(255, flashAlpha);
    image(scaledImage, width/2, scaledImage.height/2);
    noTint();
  }
}

class Spider {
  PVector pos, vel, acc, target;
  float size;
  float legAngle;
  float rotation;
  float nextTargetTime;
  float restTimer;
  boolean resting;
  float[] legPhase = new float[8];

  Spider(float x, float y) {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    
    target = new PVector(random(width), random(safeHeight));
    size = random(minSpiderSize, maxSpiderSize);

    legAngle = random(TWO_PI);
    rotation = 0;

    for (int i = 0; i < 8; i++) legPhase[i] = random(TWO_PI);

    nextTargetTime = millis() + random(1500, 3500);
    restTimer = millis();
    resting = false;
  }

  void update() {
    float now = millis();

    // Pick new target IN SAFE ZONE ONLY
    if (now > nextTargetTime && !resting) {
      target.set(random(width), random(safeHeight - 20));
      nextTargetTime = now + random(1500, 3500);

      if (random(1) < 0.25) {
        resting = true;
        restTimer = now;
      }
    }

    // Resting behavior
    if (resting) {
      if (now - restTimer > random(800, 1600)) resting = false;
      else vel.mult(0.9);
    } else {
      PVector dir = PVector.sub(target, pos);
      if (dir.mag() > 10) {
        dir.normalize().mult(0.08);
        acc.add(dir);
      }
    }

    vel.add(acc);
    vel.limit(4);
    pos.add(vel);
    acc.mult(0);
    vel.mult(0.96);

    pos.x = constrain(pos.x, size, width - size);
    pos.y = constrain(pos.y, size, safeHeight - size);

    rotation = atan2(vel.y, vel.x) + HALF_PI;
    legAngle += 0.07 + vel.mag() * 0.02;
  }

  void display() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    translate(0, sin(legAngle * 2) * size * 0.03);

    fill(spiderBodyColor);
    stroke(strokeColor);
    strokeWeight(width * 0.001);
    ellipse(0, 0, size * 0.9, size * 0.7);
    ellipse(0, -size * 0.4, size * 0.45, size * 0.35);

    stroke(legColor);
    strokeWeight(width * 0.0018);

    for (int i = 0; i < 4; i++) {
      drawLeg(i, 1);
      drawLeg(i, -1);
    }

    popMatrix();
  }

  void drawLeg(int i, float side) {
    float[] baseAngles = {radians(-50), radians(-20), radians(20), radians(50)};
    float baseAngle = baseAngles[i];

    float swingPhase = legPhase[i];
    float swing = sin(legAngle + swingPhase) * radians(10 + i * 1.5);

    float upperLen = size * 0.55;
    float lowerLen = size * 0.45;

    float jointX = cos(baseAngle + swing) * upperLen * 0.6 * side;
    float jointY = sin(baseAngle + swing) * upperLen * 0.6;

    float endX = jointX + cos(baseAngle + swing + radians(25)) * lowerLen * side;
    float endY = jointY + sin(baseAngle + swing + radians(25)) * lowerLen;

    line(0, 0, jointX, jointY);
    line(jointX, jointY, endX, endY);
  }
}
