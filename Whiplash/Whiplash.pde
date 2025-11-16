import processing.sound.*;

SoundFile player;
AudioIn mic;

Amplitude analyzer;
FFT fft;

boolean useMic = false;

float[] smoothedBands;

ArrayList<Particle> particles;
int numParticles;

ArrayList<Polygon> polygons;
int maxPolygons = 4;

void setup() {
  fullScreen();
  
  mic = new AudioIn(this, 0);
  player = new SoundFile(this, "Whiplash.mp3");
  
  fft = new FFT(this, 1024);
  analyzer = new Amplitude(this);
  
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

void draw() {
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
  strokeWeight(width * 0.00208);
  
  int nBands = fft.spectrum.length / 5;
  float bandWidth = (float) width / nBands;
  
  for (int i = 0; i <= nBands / 2; i++) {
    float amp = fft.spectrum[i];
    smoothedBands[i] = lerp(smoothedBands[i], amp, 0.5);
    
    float x = i * bandWidth;
    float bandHeight = smoothedBands[i] * width * 0.521;

    line(x, height/2 - bandHeight, x, height/2 + bandHeight);
    line(width - x, height/2 - bandHeight, width - x, height/2 + bandHeight);
  }
}

void drawCircle(float amp) {
  fill(0, 80);
  stroke(255);
  strokeWeight(width * 0.00208);
  float diameter = map(amp, 0, 0.3, width * 0.104, width * 0.167);
  
  ellipse(width/2, height/2, diameter, diameter);
}

boolean detectBeat(float threshold, float amp) {
  return amp > threshold;
}
