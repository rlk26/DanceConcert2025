import java.util.ArrayList;

ArrayList<Shape> shapes;
float spawnInterval = 500;
float lastSpawnTime = 0;
int lifespan = 2050;
String visualScreen = "uno";


void setup() {
  fullScreen();
  shapes = new ArrayList<Shape>();
  background(0);
}

void draw() {
  background(0);
  if (millis() - lastSpawnTime > spawnInterval) {
    for (int i = 0; i < int(random(4, 7)); i++) {
      int choice = int(random(4));
      Shape s = new SquareObj();
      if (choice == 0) {
        s = new EllipseObj();
      } else if (choice == 1) {
        s = new TriangleObj();
      } else if (choice == 2) {
        s = new SquareObj();
      } else if (choice == 3) {
        s = new StarObj();
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

void keyPressed() {
   }
   
abstract class Shape {
  float x, y;
  float size;
  float vx, vy;
  color c;
  float birthTime;
  float rotation;
  float rotationSpeed;

  Shape() {
    x = random(width);
    y = random(height);
    size = random(70, 100);
    vx = random(-2, 2);
    vy = random(-2, 2);
    color fluorescentGreen = color(50, 255, 50);
    color fluorescentPink = color(255, 50, 200);

    if (int(random(2)) == 0) {
      c = fluorescentGreen;
    } else {
      c = fluorescentPink;
    }

    birthTime = millis();
    rotation = random(TWO_PI);
    rotationSpeed = random(0.01, 0.015);
  }

  void update() {
    x += vx;
    y += vy;
    rotation += rotationSpeed;
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

//at the beginning make the screen all black and then have a keypressed function to start visual one
//key 1 = black key 2 = visual green and pink key 3 = fireworks
