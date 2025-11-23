ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen();
  scenes.add(new Blank());
  scenes.add(new Spiders());
  scenes.add(new DriversLi());
  scenes.add(new Skyline());
  scenes.add(new Pulses());
  scenes.add(new Footprint());
}

void draw() {
  scenes.get(current).run();
}

void keyPressed(){
  if (key == '0') {
    current = 0;
    reset();
  } else if (key == '1'){
    current = 1;
    reset();
  } else if (key == '2'){
    current = 2;
    reset();
  } else if (key == '3'){
    current = 3;
    reset();
  } else if (key == '4'){
    current = 4;
    reset();
  } else if (key == '5'){
    current = 5;
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
