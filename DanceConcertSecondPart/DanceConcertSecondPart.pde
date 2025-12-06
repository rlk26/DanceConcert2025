ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen(P3D);
  scenes.add(new Blank()); //0
  scenes.add(new GlueSong()); //1
  scenes.add(new GlueSong2());//2
  
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
  scenes.get(current).init();
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
  noCursor();
}
