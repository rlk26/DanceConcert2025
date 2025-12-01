import java.util.ArrayList;

// more directions for all of this are line by line
// To adjust brightness for stars use map() lines in Star.display()
// for brightness, change map() in RedLight.display().
// To change glow color/vibrancy change the fill() lines within RedLight.display()
// To change object count, see the 'for' loops for stars and redLights in setup() and just change whatever i< X, change x for ex

ArrayList<Star> stars;
ArrayList<RedLight> redLights;
boolean showRedLights = false;

void setup() {
  fullScreen();
  smooth();

  stars = new ArrayList<Star>();
  for (int i = 0; i < 300; i++) {
    stars.add(new Star());
  }

  redLights = new ArrayList<RedLight>();
  for (int i = 0; i < 50; i++) {
    redLights.add(new RedLight());
  }
}

void draw() {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(5, 5, 30), color(0, 0, 10), inter);
    //lerpcolor finds the middl ebetween like two colors yay
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

class Star {
  float x, y, z;
  float size;
  float twinkle;
  float twinkleSpeed;

  Star() {
    x = random(width);
    y = random(height);
    z = random(width);
    size = random(1, 5);
    twinkle = random(TWO_PI);
    twinkleSpeed = random(0.06, 0.1);
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
    //where the 100 is is what changes the brightness
    noStroke();
    fill(255, 255, 220, brightness);
    ellipse(x, y, size, size);
    fill(255, 255, 220, brightness * 0.3);
    ellipse(x, y, size * 3, size * 3);
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
    glow = random(200, 255);
    glowSpeed = random(4, 6);
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
    
    float brightness = map(sin(glow * 0.05), -1, 1, 100, 255);
    noStroke();

    for (int i = 6; i > 0; i--) {
      
      float br = brightness * 0.06 * i;
      fill(255, 40, 40, br);
      // the two 40s change the vibrancy, for more vibrant lower, to make softer increase them # color throey
      ellipse(x, y, size * i * 0.5, size * i * 0.5);
    }

    fill(255, 80, 80, brightness);
    //these two 80s, same principle as above w color
    ellipse(x, y, size * 0.5, size * 0.5);
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    showRedLights = !showRedLights;
  }
}
