ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen(P3D);
  scenes.add(new Blank());
}

void draw() {
  scenes.get(current).run();
}

void keyPressed(){
  scenes.get(current).keyPressed();
}

void keyReleased() {
  scenes.get(current).keyReleased();
}
void mouseClicked() {
  scenes.get(current).mouseClicked();
}

void reset() {
}
