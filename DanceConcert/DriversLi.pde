class DriversLi extends Scene {
  ArrayList<Star> stars;
  ArrayList<StopSign> stopSigns;
  ArrayList<RedLight> redLights;
  boolean showRedLights = false;
  DriversLi () {
    smooth();


    stars = new ArrayList<Star>();
    for (int i = 0; i < 300; i++) {
      stars.add(new Star());
    }


    stopSigns = new ArrayList<StopSign>();
    for (int i = 0; i < 5; i++) {
      stopSigns.add(new StopSign());
    }

    // Smaller, more artistic red lights
    redLights = new ArrayList<RedLight>();
    for (int i = 0; i < 10; i++) {
      redLights.add(new RedLight());
    }
  }
  void run() {
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      color c = lerpColor(color(5, 5, 30), color(0, 0, 10), inter);
      stroke(c);
      line(0, i, width, i);
    }


    for (Star s : stars) {
      s.update();
      s.display();
    }
    if (showRedLights == true) {
      for (RedLight light : redLights) {
        light.update();
        light.display();
      }
    }
  }
  void keyPressed() {
    if (key == 'r' || key == 'R') {
      println("R WAS PRESSED");
      showRedLights = !showRedLights;
    } else if (key == 's' || key == 'S') {
      println("S WAS PRESSED");
      for (StopSign sign : stopSigns) {
        sign.update();
        sign.display();
      }
    }
  }

  class Star {
    float x, y, z;
    float size;
    float twinkle;
    float twinkleSpeed;

    Star() {
      x = random(width);
      y = random(height);
      z = random(width);
      size = random(1, 3);
      twinkle = random(TWO_PI);
      twinkleSpeed = random(0.02, 0.08);
    }

    void update() {
      twinkle += twinkleSpeed;
      x += sin(frameCount * 0.001 + z * 0.01) * 0.5;
      y += cos(frameCount * 0.001 + z * 0.01) * 0.5;
      if (x < 0) x = width;
      if (x > width) x = 0;
      if (y < 0) y = height;
      if (y > height) y = 0;
    }

    void display() {
      float brightness = map(sin(twinkle), -1, 1, 100, 255);
      noStroke();
      fill(255, 255, 200, brightness);
      ellipse(x, y, size, size);
      fill(255, 255, 200, brightness * 0.3);
      ellipse(x, y, size * 3, size * 3);
    }
  }

  class StopSign {
    float x, y;
    float size;
    float rotation;
    float rotSpeed;
    float driftAngle;
    float driftSpeed;

    StopSign() {
      x = random(width);
      y = random(height);
      size = random(25, 50);
      rotation = random(TWO_PI);
      rotSpeed = random(-0.01, 0.01);
      driftAngle = random(TWO_PI);
      driftSpeed = random(0.2, 0.6);
    }

    void update() {
      rotation += rotSpeed;
      driftAngle += 0.01;
      x += cos(driftAngle) * driftSpeed;
      y += sin(driftAngle) * driftSpeed;
      if (x < -size) x = width + size;
      if (x > width + size) x = -size;
      if (y < -size) y = height + size;
      if (y > height + size) y = -size;
    }

    void display() {
      pushMatrix();
      translate(x, y);
      rotate(rotation);

      for (int i = 4; i > 0; i--) {
        float alpha = 25 * i;
        float blur = i * 2;
        fill(200, 0, 0, alpha);
        stroke(255);
        strokeWeight(2);
        drawOctagon(0, 0, size + blur);
      }


      stroke(255, 180);
      strokeWeight(1);
      line(-size * 0.3, -size * 0.3, size * 0.3, size * 0.3);
      line(size * 0.3, -size * 0.3, -size * 0.3, size * 0.3);

      popMatrix();
    }

    void drawOctagon(float x, float y, float r) {
      beginShape();
      for (int i = 0; i < 8; i++) {
        float angle = TWO_PI / 8 * i;
        float vx = x + cos(angle) * r;
        float vy = y + sin(angle) * r;
        vertex(vx, vy);
      }
      endShape(CLOSE);
    }
  }

  class RedLight {
    float x, y;
    float size;
    float glow;
    float glowSpeed;
    float vx, vy;

    RedLight() {
      x = random(width);
      y = random(height);
      size = random(8, 20);
      glow = random(255);
      glowSpeed = random(2, 4);
      vx = random(-0.3, 0.3);
      vy = random(-0.3, 0.3);
    }


    void update() {
      glow += glowSpeed;
      x += vx + sin(frameCount * 0.015) * 0.2;
      y += vy + cos(frameCount * 0.015) * 0.2;
      if (x < -size) x = width + size;
      if (x > width + size) x = -size;
      if (y < -size) y = height + size;
      if (y > height + size) y = -size;
    }
    void display() {
      float brightness = map(sin(glow * 0.05), -1, 1, 80, 220);
      noStroke();


      for (int i = 6; i > 0; i--) {
        float alpha = brightness * 0.07 * i;
        fill(255, 60, 60, alpha);
        ellipse(x, y, size * i * 0.5, size * i * 0.5);
      }

      // Core light with soft shimmer
      fill(255, 100, 100, brightness);
      ellipse(x, y, size * 0.5, size * 0.5);
    }
  }
}
