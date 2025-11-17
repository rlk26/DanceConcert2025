ArrayList<Shape> shapes;
float spawnInterval = 500;
float lastSpawnTime = 0;
int lifespan = 2000; 

void setup() {
  fullScreen();
  shapes = new ArrayList<Shape>();
  background(0);
}

void draw() {
  background(0);


  if (millis() - lastSpawnTime > spawnInterval) {
    for (int i = 0; i < int(random(3, 8)); i++) { 
      int choice = int(random(3)); 
      Shape s = new SquareObj();
      if (choice == 0) {
        s = new EllipseObj();
      }
      else if (choice == 1) {
        s = new TriangleObj();
      }
      else if (choice == 2) {
        s = new SquareObj();
      }
      shapes.add(s);
    }
    lastSpawnTime = millis();
    
  }

  for (int i = shapes.size() - 1; i >= 0; i--) {
    Shape s = shapes.get(i);
    s.update();
    s.display();
    if (s.isDead()) {
      shapes.remove(i);
    }
  }
}

abstract class Shape {
  float x, y;
  float size;
  float vx, vy;
  color c;
  float birthTime;

  Shape() {
    x = random(width);
    y = random(height);
    size = random(30, 100);
    vx = random(-2, 2);
    vy = random(-2, 2);
    c = color(random(255), random(255), random(255));
    birthTime = millis();
  }

  void update() {
    x += vx;
    y += vy;

    if (x < 0 || x > width) {
      vx *= -1;
    }
    if (y < 0 || y > height) {
      vy *= -1;
    }
  }

  boolean isDead() {
    return millis() - birthTime > lifespan;
  }

  abstract void display();
}
