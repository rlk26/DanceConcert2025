class OneMoreTime extends Scene {


  ArrayList<Shape> shapes;
  float spawnInterval = 500;
  float lastSpawnTime = 0;
  int lifespan = 2050;
  boolean showImage = false;
  boolean showFireworks = false;

  OneMoreTime() {
    shapes = new ArrayList<Shape>();
    background(0);
  }

  void run() {
    if (showImage) {
      mainVisual();
    } else if (showFireworks) {
      background(0);
      for (int i = shapes.size() - 1; i >= 0; i--) {
        Shape s = shapes.get(i);
        s.update();
        s.display();
        if (s.isDead()) {
          //shapes.remove(i);
        }
      }
    } else {
      background(0);
    }
  }

  void mainVisual() {
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

  abstract class Shape {
    float x, y;
    float size;
    float vx, vy;
    color c;
    float birthTime;
    float rotation;
    float rotationSpeed;
    float sizeSpeed;

    Shape() {
      x = random(width);
      y = random(height);
      size = random(50, 80);
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
      sizeSpeed = random(0.1, 0.5);
    }

    void update() {
      if (showFireworks) {
        x += vx;
        y += vy;
        rotation += rotationSpeed;
        size += sizeSpeed;
      } else {
        x += vx;
        y += vy;
        rotation += rotationSpeed;
        size += sizeSpeed;
        if (x < 0 || x > width) {
          vx *= -1;
        }
        if (y < 0 || y > height) {
          vy *= -1;
        }
      }
    }

    boolean isDead() {
      return millis() - birthTime > lifespan;
    }

    abstract void display();
  }

  void mouseClicked() {
    showImage = true;
  }

  void keyPressed() {
    if (keyCode == ' ') {
      fireWorks();
    }
  }

  void fireWorks() {
    showImage = false;
    showFireworks = true;
    for (Shape s : shapes) {
      s.size = 50;
      s.x = width/2;
      s.y = height/2;
      s.vx = random(-5, 5);
      s.vy = random(-5, 5);
      s.birthTime = 16000;
    }
  }

  //at the beginning make the screen all black and then have a keypressed function to start visual one
  //key 1 = black key 2 = visual green and pink key 3 = fireworks
  class EllipseObj extends Shape {
    void display() {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      fill(c);
      noStroke();
      ellipse(0, 0, size, size);
      popMatrix();
    }
  }
  class SquareObj extends Shape {
    void display() {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      fill(c);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, size, size);
      popMatrix();
    }
  }
  class StarObj extends Shape {
    void display() {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      fill(c);
      noStroke();
      beginShape();
      for (int i = 0; i < 10; i++) {
        float angle = i * PI / 5;
        float radius = (i % 2 == 0) ? size / 2 : size / 4;
        float px = cos(angle) * radius;
        float py = sin(angle) * radius;
        vertex(px, py);
      }
      endShape(CLOSE);
      popMatrix();
    }
  }
  class TriangleObj extends Shape {
    void display() {
      pushMatrix();
      translate(x, y);
      rotate(rotation);
      fill(c);
      noStroke();
      triangle(0, -size/2, -size/2, size/2, size/2, size/2);
      popMatrix();
    }
  }
}
