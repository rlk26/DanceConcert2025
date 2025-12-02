import processing.sound.*;
class Control extends Scene {
  SoundFile player;
  PImage room;
  ArrayList<Raindrop> raindrops;
  Lightning lightning;
  Flame[] flames;

  int fadeDuration = 5000;
  boolean playMusic = false;

  int WIDTH, HEIGHT, X, Y;


  Control(PApplet pap) {

    X = width / 6;
    Y = 0;
    WIDTH = width / 3 * 2;
    HEIGHT = height / 4 * 3;

    if (playMusic) {
      player = new SoundFile (pap, "Control.mp3");
      player.play();
    }

    room = loadImage("room-3.png");
    room.resize(WIDTH, HEIGHT);

    lightning = new Lightning();

    raindrops = new ArrayList<Raindrop>();
    for (int i = 0; i < 600; i++) {
      raindrops.add(new Raindrop());
    }

    flames = new Flame[] {
      new Flame(X + WIDTH * 0.03, Y + HEIGHT * 0.84),
      new Flame(X + WIDTH * 0.34, Y + HEIGHT * 0.84),
      new Flame(X + WIDTH * 0.64, Y + HEIGHT * 0.84),
      new Flame(X + WIDTH * 0.94, Y + HEIGHT * 0.84)
    };
  }

  void run() {
    background(0);

    int levels = int(HEIGHT * 0.0556);
    color startCol = color(10, 45, 90);
    color endCol = color(0);
    float step = HEIGHT / float(levels);

    for (int i = 0; i < levels; i++) {
      color curCol = lerpColor(startCol, endCol, i / float(levels));
      noStroke();
      fill(curCol);

      rect(X, Y + i * step, WIDTH, step);
    }

    for (Raindrop r : raindrops) {
      r.display();
      r.update();

      if (!r.onScreen()) {
        r.reset();
      }
    }
    lightning.display();
    lightning.update();

    image(room, X, Y);

    for (Flame f : flames) {
      f.display();
      f.update();
    }

    if (millis() < fadeDuration) {
      fill(0, map(millis(), 0, fadeDuration, 255, 0));
      rect(0, 0, width, height);
    }
  }

  class Flame {
    PVector pos;
    ArrayList<FlameParticle> particles;
    int maxParticles = 70;

    Flame(float x, float y) {
      pos = new PVector(x, y);
      particles = new ArrayList<FlameParticle>();
    }

    void update() {
      if (particles.size() < maxParticles && frameCount % 10 == 0) {
        particles.add(new FlameParticle(pos.x, pos.y));
      }

      for (FlameParticle fp : particles) {
        fp.update();

        if (fp.done()) {
          fp.reset(pos.x, pos.y);
        }
      }
    }

    void display() {
      for (FlameParticle fp : particles) {
        fp.display();
      }
    }
  }

  class FlameParticle {
    PVector pos, vel;
    float size, maxSize, sizeInc;
    float alpha, maxAlpha, alphaInc;
    boolean entering;
    color col;

    FlameParticle(float x, float y) {
      reset(x, y);
    }

    void reset(float x, float y) {
      pos = new PVector(x, y);
      vel = new PVector(random(-WIDTH * 0.00104, WIDTH * 0.00104), random(-WIDTH * 0.00313, -WIDTH * 0.000521));

      maxSize = random(WIDTH * 0.0104, WIDTH * 0.0208);
      maxAlpha = 255;

      size = 0;
      alpha = 0;

      sizeInc = maxSize / 15;
      alphaInc = maxAlpha / 15;

      col = color(250, random(50, 230), 10);

      entering = true;
    }

    void update() {
      pos.add(vel);

      if (entering) {
        size += sizeInc;
        alpha += alphaInc;

        if (size >= maxSize) {
          size = maxSize;
          alpha = maxAlpha;
          entering = false;
        }
      } else {
        size *= 0.97;
        alpha *= 0.97;
      }
    }

    void display() {
      fill(col, alpha);
      noStroke();
      rect(pos.x, pos.y, size, size);
    }

    boolean done() {
      return alpha <= 5;
    }
  }

  class Lightning {
    int nextStart, nextEnd;
    boolean active;

    Lightning() {
      nextStart = int(random(2000, 9000));
      nextEnd = nextStart + int(random(500, 1000));
      active = false;
    }

    void update() {
      if (!active && millis() >= nextStart) {
        active = true;
      }

      if (active && millis() >= nextEnd) {
        active = false;
        nextStart = millis() + int(random(2000, 15000));
        nextEnd = nextStart + int(random(300, 1000));
      }
    }

    void display() {
      if (active) {
        noStroke();
        fill(200, 220, 255, random(20, 100));
        rect(X, Y, WIDTH, HEIGHT);

        if (random(1) < 0.5) {
          fill(60, 130, 230, random(40, 100));
          rect(X, Y, WIDTH, HEIGHT);
        }

        if (random(1) < 0.15) {
          fill(30, 90, 170, random(10, 50));
          rect(X, Y, WIDTH, HEIGHT);
        }
      }
    }
  }

  class Raindrop {
    PVector pos, vel, acc;
    float len;
    float wid;
    float wind;

    Raindrop() {
      reset();
    }

    void reset() {
      wind = 1;

      pos = new PVector(random(X, X + WIDTH), random(Y - WIDTH * 0.26, Y - WIDTH * 0.00521));
      vel = new PVector(wind, random(WIDTH * 0.00104, WIDTH * 0.0026));
      acc = new PVector(0, random(WIDTH * 0.000104, WIDTH * 0.00026));

      len = random(WIDTH * 0.00521, WIDTH * 0.026);
      wid = random(WIDTH * 0.00156, WIDTH * 0.0026);
    }

    void update() {
      pos.add(vel);
      vel.add(acc);
    }

    void display() {
      stroke(150, 180, 230, 7 * len);
      strokeWeight(wid);

      line(pos.x, pos.y, pos.x - wind, pos.y - len);
    }

    boolean onScreen() {
      return pos.x >= X && pos.x <= X + WIDTH && pos.y >= Y - WIDTH * 0.26 && pos.y <= Y + HEIGHT;
    }
  }
}
