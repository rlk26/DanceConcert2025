ArrayList<Scene> scenes = new ArrayList<Scene>();
int current = 0;
import processing.sound.*;

void setup() {
  fullScreen(P3D);
  scenes.add(new Blank()); //0
  scenes.add(new Footprint()); //1
  scenes.add(new Spiders());//2
  scenes.add(new DriversLi());//3
  scenes.add(new AppleTree());//4
  scenes.add(new Control(this));//5
  scenes.add(new PinkWaves());//6
  scenes.add(new IfIWereAMan());//7
  scenes.add(new Moody());//8
  scenes.add(new FeelingGood());//9
  scenes.add(new Pulses());//10
  scenes.add(new Birds());//11
  scenes.add(new CandyExplosions(this));//12
  scenes.add(new Whiplash(this));//13
  scenes.add(new Skyline());//14
  scenes.add(new FlowerBurst()); //15
  scenes.add(new GlueSong()); //16
  scenes.add(new OneMoreTime()); //17
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
  } else if (key == 'z' || key == 'Z') {
    current = 10;
    reset();
  } else if (key == 'x' || key == 'X') {
    current = 11;
    reset();
  } else if (key == 'c' || key == 'C') {
    current = 12;
    reset();
  } else if (key == 'v' || key == 'V') {
    current = 13;
    reset();
  } else if (key == 'b' || key == 'B') {
    current = 14;
    reset();
  } else if (key == 'n' || key == 'N') {
    current = 15;
    reset();
  } else if (key == 'm' || key == 'M') {
    current = 16;
    reset();
  } else if (key == ',' || key == '<') {
    current = 17;
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
  noCursor();
}
