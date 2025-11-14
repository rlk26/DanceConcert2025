ArrayList<Line> lines;

void setup() {

  fullScreen();

  lines = new ArrayList<Line>();
}


void draw() {
  background(0);
  frameRate(5);


  for (int u = 0; u < 10; u++) {
    lines.add(new Line(random(width), random(height), random(3, 15), random(50, 300)));
  }
  for (Line l : lines) {
    l.display();
    l.update();
  }
}
