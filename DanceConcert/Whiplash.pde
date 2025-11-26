import processing.sound.*;

class Whiplash extends Scene {
  SoundFile player;
  AudioIn mic;
  Amplitude analyzer;
  FFT fft;

  float[] smoothedBands;

  ArrayList<Particle> particles;
  int numParticles;
  ArrayList<Polygon> polygons;
  int maxPolygons = 4;

  boolean useMic = false;
  int WIDTH, HEIGHT, X, Y;

  Whiplash(PApplet pap) {

    X = width / 6;
    Y = 0;
    WIDTH = width / 3 * 2;
    HEIGHT = height / 4 * 3;

    mic = new AudioIn(pap, 0);
    player = new SoundFile(pap, "Whiplash.mp3");

    fft = new FFT(pap, 1024);
    analyzer = new Amplitude(pap);

    smoothedBands = new float[fft.spectrum.length];

    particles = new ArrayList<Particle>();
    numParticles = 400;
    for (int i = 0; i < numParticles; i++) {
      particles.add(new Particle());
    }

    polygons = new ArrayList<Polygon>();

    if (useMic) {
      mic.start();
      fft.input(mic);
      analyzer.input(mic);
    } else {
      player.play();
      fft.input(player);
      analyzer.input(player);
    }
  }

  void run() {
    fill(0, 50);
    noStroke();
    rect(0, 0, width, height);

    float amp = analyzer.analyze();
    fft.analyze();

    for (Particle p : particles) {
      p.update(detectBeat(0.16, amp), amp);
      p.display();

      if (!p.onScreen()) {
        p.reset();
      }
    }

    drawAudioWave(fft);

    if (detectBeat(0.5, amp) && polygons.size() < maxPolygons) {
      polygons.add(new Polygon(amp));
    }

    for (int i = polygons.size() - 1; i >= 0; i--) {
      Polygon p = polygons.get(i);
      p.update();
      p.display();

      if (p.shouldRemove()) {
        polygons.remove(i);
      }
    }

    drawCircle(amp);
  }

  void drawAudioWave(FFT fft) {
    stroke(255);
    strokeWeight(WIDTH * 0.00208);

    int nBands = fft.spectrum.length / 5;
    float bandWidth = (float) WIDTH / nBands;

    for (int i = 0; i <= nBands / 2; i++) {
      float amp = fft.spectrum[i];
      smoothedBands[i] = lerp(smoothedBands[i], amp, 0.5);

      float x = i * bandWidth;
      float bandHeight = smoothedBands[i] * WIDTH * 0.521;

      line(X + x, Y + HEIGHT/2 - bandHeight, X + x, Y + HEIGHT/2 + bandHeight);
      line(X + WIDTH - x, Y + HEIGHT/2 - bandHeight, X + WIDTH - x, Y + HEIGHT/2 + bandHeight);
    }
  }

  void drawCircle(float amp) {
    fill(0, 80);
    stroke(255);
    strokeWeight(WIDTH * 0.00208);
    float diameter = map(amp, 0, 0.3, WIDTH * 0.104, WIDTH * 0.167);

    ellipse(X + WIDTH/2, Y + HEIGHT/2, diameter, diameter);
  }

  boolean detectBeat(float threshold, float amp) {
    return amp > threshold;
  }
  class Particle {
    float x, y, z;
    float displayX, displayY;
    float curSpeed;
    float baseSpeed;
    float radius;
    float alpha;
    color c;

    Particle() {
      reset();
    }

    void reset() {
      x = random(-WIDTH, WIDTH);
      y = random(-HEIGHT, HEIGHT);
      z = random(WIDTH * 0.104, WIDTH * 1.04);

      baseSpeed = WIDTH * 0.000781;
      curSpeed = baseSpeed;

      radius = random(WIDTH * 0.0026, WIDTH * 0.00521);
      alpha = random(20, 100);
      c = color(255);
    }

    void update(boolean beat, float amp) {
      if (beat) {
        curSpeed = lerp(curSpeed, baseSpeed * map(amp, 0, 0.5, WIDTH * 0.000521, WIDTH * 0.00573), 0.5);
      } else {
        curSpeed = lerp(curSpeed, baseSpeed, 0.5);
      }

      z -= curSpeed;
    }

    void display() {
      float scale = WIDTH * 0.26 / z;
      displayX = X + x * scale + WIDTH / 2;
      displayY = Y + y * scale + HEIGHT / 2;

      float alpha = map(z, WIDTH * 1.04, 0, 0, 150);
      fill(c, alpha);

      ellipse(displayX, displayY, radius, radius);
    }

    boolean onScreen() {
      return displayX >= 0 && displayX <= width && displayY >= 0 && displayY <= height;
    }
  }
  class Polygon {
    float x, y, z;
    float displayX, displayY;
    float angle;
    float speed;
    float radius;
    float alpha;
    int sides;
    color c;

    Polygon(float amp) {
      x = random(1) < 0.5 ? random(-WIDTH * 0.6, -WIDTH * 0.3) : random(WIDTH * 0.3, WIDTH * 0.6);
      y = random(1) < 0.5 ? random(-HEIGHT * 0.6, -HEIGHT * 0.3) : random(HEIGHT * 0.3, HEIGHT * 0.6);
      z = random(WIDTH * 0.208, WIDTH * 0.781);

      angle = random(TWO_PI);
      speed = random(WIDTH * 0.0026, WIDTH * 0.00781);

      radius = map(amp, 0, 0.3, WIDTH * 0.00521, WIDTH * 0.026);
      alpha = random(150, 255);
      sides = int(random(3, 7));
      c = color(255);
    }

    void update() {
      z -= speed;
      alpha -= 7;
      radius += WIDTH * 0.00156;
    }

    void display() {
      float scale = WIDTH * 0.208 / z;
      displayX = X + x * scale + WIDTH / 2;
      displayY = Y + y * scale + HEIGHT / 2;

      fill(0, 80);
      stroke(c, alpha);
      strokeWeight(WIDTH * 0.00208);

      polygon(displayX, displayY, radius, sides);
    }

    void polygon(float x, float y, float radius, int npoints) {
      float angle = TWO_PI / npoints;
      beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = x + cos(a) * radius;
        float sy = y + sin(a) * radius;
        vertex(sx, sy);
      }
      endShape(CLOSE);
    }

    boolean onScreen() {
      return displayX >= 0 && displayX <= width && displayY >= 0 && displayY <= height;
    }

    boolean shouldRemove() {
      return alpha <= 0;
    }
  }
}
