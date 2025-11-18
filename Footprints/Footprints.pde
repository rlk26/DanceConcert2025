ArrayList<Footstep> steps;
PImage foot;

float stepInterval = 80; 
float xPos = -200;   
float speed = 3;         
boolean leftFoot = true;

void setup() {
  fullScreen();
  steps = new ArrayList<Footstep>();

  foot = loadImage("footprint.png");
  foot.resize(90, 0); 
}

void draw() {
  background(0);

  xPos += speed;

  if (steps.isEmpty() || xPos - steps.get(steps.size()-1).x > stepInterval) {

    float y = height/2 + (leftFoot ? -40 : 40);
    float ang = 0;

    steps.add(new Footstep(xPos, y, ang));
    leftFoot = !leftFoot;
  }

  for (int i = steps.size() - 1; i >= 0; i--) {
    Footstep f = steps.get(i);
    f.update();
    f.display();

    if (f.alpha <= 0 || f.x > width + 200) {
      steps.remove(i);
    }
  }
}

class Footstep {
  float x, y, angle;
  float alpha = 255;

  Footstep(float x, float y, float angle) {
    this.x = x;
    this.y = y;
    this.angle = angle;
  }

  void update() {
    alpha -= 1.3;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(radians(45));

    blendMode(SCREEN);
    tint(255, alpha);
    imageMode(CENTER);
    image(foot, 0, 0);
    blendMode(BLEND);

    popMatrix();
  }
}
