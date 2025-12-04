class Extra extends Scene {
  float flashAlpha = 0;
  float flashDecay = 8;
  boolean bigDrop = false;
  float shakeIntensity = 0;
  float burstRadius = 0;
  float burstGrowth = 0;
  color flashColor;
  ArrayList<Integer>colors;

  Extra() {
    noStroke();
    flashColor = color(255);
    colors = new ArrayList<Integer>();
    colors.add(color(215, 185, 255));
    colors.add(color(255, 214, 246));
    colors.add(color(193, 250, 182));
    colors.add(color(182, 223, 250));
  }
  void run () {
    if (shakeIntensity > 0) {
      translate(random(-shakeIntensity, shakeIntensity), random(-shakeIntensity, shakeIntensity));
    }

    background(0);

    if (random(1) < 0.015 && !bigDrop) {
      flashAlpha = random(50, 100);
      int newColor = (int) random(4);
      flashColor = colors.get(newColor);
    }

    if (bigDrop) {
      flashAlpha = 255;
      //bright yellow
      //blue
      //gree;
      int newColor = (int) random(4);
      flashColor = colors.get(newColor);
      burstRadius = 0;
      burstGrowth = random(30, 60);
      shakeIntensity = random(8, 20);
      bigDrop = false;
    }

    if (burstRadius < width * 1.2) {
      fill(flashColor, map(burstRadius, 0, width, 255, 0));
      ellipse(width/2, height/2, burstRadius, burstRadius);
      burstRadius += burstGrowth;
    }

    fill(flashColor, flashAlpha);
    rect(0, 0, width, height);

    flashAlpha = max(0, flashAlpha - flashDecay);

    shakeIntensity = max(0, shakeIntensity - 0.5);

    resetMatrix();
  }

  void reset() {
  }

  void keyPressed() {
    bigDrop = true;
  }
}
