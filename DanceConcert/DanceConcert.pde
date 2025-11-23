ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen();
  scenes.add(new Blank());
  scenes.add(new Footprint());
  scenes.add(new Spiders());
  scenes.add(new DriversLi());
  scenes.add(new AppleTree());
  scenes.add(new Control(this));
  scenes.add(new Skyline());
  scenes.add(new Pulses());
}

void draw() {
  scenes.get(current).run();
}

void keyPressed() {
  if (key == '0') {
    current = 0;
    reset();
  } else if (key == '1') {
    current = 1;
    reset();
  } else if (key == '2') {
    current = 2;
    reset();
  } else if (key == '3') {
    current = 3;
    reset();
  } else if (key == '4') {
    current = 4;
    reset();
  } else if (key == '5') {
    current = 5;
    reset();
  } else if (key == '6') {
    current = 6;
    reset();
  } else if (key == '7') {
    current = 7;
    reset();
  } else if (key == '8') {
    current = 8;
    reset();
  } else if (key == '9') {
    current = 9;
    reset();
  } else {
    scenes.get(current).keyPressed();
  }
}

void keyReleased() {
  scenes.get(current).keyReleased();
}
void mouseClicked() {
  scenes.get(current).mouseClicked();
}

void reset() {
  scenes.get(current).reset();
  frameRate(60);
  background(0);
  colorMode(RGB);
  stroke(0);
  fill(255);
  strokeWeight(1);
  noTint();
  ellipseMode(CENTER);
  rectMode(CORNER);
  imageMode(CORNER);
  strokeCap(ROUND);
  textMode(MODEL);
}
