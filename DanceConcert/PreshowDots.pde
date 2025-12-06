class Dots extends Scene {
  Flower[] flowers = new Flower[2000];
  Dart p;

  Dots() {
    fullScreen();
    noCursor();
    smooth();
    background(0);
    for (int i =0; i<flowers.length; i++) {
      flowers[i]= new Flower();
    }

    p = new Dart();
  }

  void run() {
    fill(0, 40);
    rect(0, 0, width, height);
    p.update();
    for (int i =0; i<flowers.length; i++) {
      flowers[i].update(p);
      flowers[i].display();
    }
  }

  class Flower {
    PVector location;
    PVector speed;
    PVector acceleration;
    float topspeed;
    int colorChange;

    int noiseV;
    int noisev;

    Flower() {
      location = new PVector(random(width), random(height));
      speed = new PVector(0, 0);
      topspeed=8;

      colorChange = 0;

      noiseV = 0;
      noisev = 0;
    }

    void update(Dart p) {
      colorChange += 1;

      acceleration = PVector.sub(p.pos, location);
      fill(255, 255-acceleration.mag() + 120, 255-acceleration.mag() + 40);

      acceleration.normalize();
      acceleration.mult(0.2);
      speed.add(acceleration);
      speed.limit(topspeed);
      location.add(speed);
    }

    void display() {
      noiseV += 0.012;
      noisev += 0.01;

      noStroke();

      //fill(255,255-acceleration.mag()*400,255-acceleration.mag()*400);
      ellipse(location.x, location.y, 4, 4);
    }
  }

  class Dart {
    float size;
    float r, b, g;
    PVector vel;
    PVector acc;
    PVector pos;
    PVector point;
    int turnTimer;
    int turnMode = 1;
    int lifeTime;

    Dart() {
      pos = new PVector(width/2, height/2);
      r = 255;
      b = 74;
      g = 181;
      turnTimer = 0;
      lifeTime = 0;

      vel = new PVector(4, 4);
      acc = new PVector(0, 0);
      PVector temp = new PVector(vel.x, vel.y);
      point = PVector.add(pos, temp.rotate(HALF_PI).mult(8));
    }

    void update() {

      vel.mult(1.02);
      lifeTime += 1;

      vel.add(acc);
      pos.add(vel);

      vel.limit(width/300);


      PVector direction = PVector.sub(point, pos);
      direction.normalize();
      direction.mult(0.4);
      acc = direction;

      if (turnTimer < 30) {
        edgeAvoidance();
      }

      turnTimer -= 1;

      if (turnTimer < 0) {
        turn();
      }



      if (pos.x > width) {
        pos.x = width;
      } else if (pos.x < 0) {
        pos.x = 0;
      } else if (pos.y > height) {
        pos.y = height;
      } else if (pos.y < 0) {
        pos.y = 0;
      }
    }

    void turn() {
      PVector temp = new PVector(vel.x, vel.y);
      if (random(1) < 0.8) {
        if (random(1) < 0.5) {
          if (pos.x < width/2) {
            turn("right");
          } else {
            turn("left");
          }
        } else {
          if (pos.y < height/2) {
            turn("down");
          } else {
            turn("up");
          }
        }
      }
      point = PVector.add(pos, temp.rotate(HALF_PI).mult(turnMode * 2*random(vel.mag()*2/3, vel.mag()*4/3)));
      turnMode*=-1;
      turnTimer = int(random(30, 80));
    }

    void turn(String direction) {
      PVector temp = new PVector(vel.x, vel.y);
      int multiplier = 0;
      if (direction.equals("left")) {
        if (vel.y > 0) {
          multiplier = 1;
        } else {
          multiplier = -1;
        }
      } else if (direction.equals("right")) {
        if (vel.y > 0) {
          multiplier = -1;
        } else {
          multiplier = 1;
        }
      } else if (direction.equals("up")) {
        if (vel.x > 0) {
          multiplier = -1;
        } else {
          multiplier = 1;
        }
      } else if (direction.equals("down")) {
        if (vel.x > 0) {
          multiplier = 1;
        } else {
          multiplier = -1;
        }
      }
      point = PVector.add(pos, temp.rotate(HALF_PI).mult(multiplier * 2*random(vel.mag()*2/3, vel.mag()*4/3)));
      turnTimer = int(random(30, 80));
    }

    void edgeAvoidance() {
      if (vel.x < 0 && pos.x < width/2 && random(0.021) > (-1*vel.x/vel.mag())*(pos.x/width)) {
        turn("right");
      } else if (vel.x > 0 && pos.x > width/2 && random(0.021) > (vel.x/vel.mag())*((width-pos.x)/width)) {
        turn("left");
      } else if (vel.y > 0 && pos.y > height/2 && random(0.021) > (vel.y/vel.mag())*((height -pos.y)/height)) {
        turn("up");
      } else if (vel.y < 0 && pos.y < height/2 && random(0.021) > (-1*vel.y/vel.mag())*(pos.y/height)) {
        turn("down");
      }
    }
  }
}
