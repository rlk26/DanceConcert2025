class PinkWaves extends Scene {

  float t = 0;  // time variable

  PinkWaves() {
    noStroke();
  }

  void run() {
    background(0, 0, 0);
    noStroke();
    //frameRate(2);

    int numWaves = 5;
    float baseHue = random(330, 350); // pink hue range

    for (int i = 0; i < numWaves; i++) {
      float yOff = map(i, 0, numWaves, height * 0.3, height * 0.9);
      float waveAmp = 30 + i * 8;
      float waveSpeed = 0.0002 + i * 0.000008;
      float opacity = map(i, 0, numWaves, 60, 150);
      fill(255, 200 - i * 10, 220 - i * 15, opacity);

      beginShape();
      for (float x = 0; x <= width; x += 10) {
        float y = yOff + sin(x * 0.015 + t * (2 + i * 0.4)) * waveAmp;
        vertex(x, y-200);
      }
      vertex(width, height);
      vertex(0, height);
      endShape(CLOSE);
    }

    t += 0.001;
  }
}
