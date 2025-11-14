ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen(P3D);
  scenes.add(new Blank());
  scenes.add(new Skyline());
}

void draw() {
  scenes.get(current).run();
}

void keyPressed(){
  if (key == '0') {
    current = 0;
  } else if (key == '1'){
    current = 1;
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
}
