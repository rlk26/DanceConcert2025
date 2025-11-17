ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen();
  scenes.add(new Blank());
  scenes.add(new Skyline());
  scenes.add(new DriversLi());
  scenes.add(new Pulses());
}

void draw() {
  scenes.get(current).run();
}

void keyPressed(){
  if (key == '0') {
    reset();
    current = 0;
  } else if (key == '1'){
    reset();
    current = 1;
  } else if (key == '2'){
    reset();
    current = 2;
  } else if (key == '3'){
    reset();
    current = 3;
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
