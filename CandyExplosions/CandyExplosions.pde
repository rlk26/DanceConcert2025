

import processing.sound.*;


boolean falling;

ArrayList<Particle> particles;
ArrayList<ParticleSystem> systems;
PVector gravity;
PVector wind;
ParticleSystem ps;
AudioIn in;
BeatDetector beatDetector;
SoundFile song;
Pic iceCream;

void setup() {
  fullScreen();


  song = new SoundFile(this, "song.mp3");
  song.play();

  gravity = new PVector(0, 0.02);
  wind = new PVector(0, 0);

  systems = new ArrayList<ParticleSystem>();
  particles = new ArrayList<Particle>();
  
  iceCream = new Pic("icecream", 100, 100);

  for (int i = 0; i < 15; i++) {
    Particle p = new Particle();
    particles.add(p);
  }
  ps = new ParticleSystem(width/2, height/2);
  systems.add(ps);


  beatDetector = new BeatDetector(this);
  in = new AudioIn(this);
  beatDetector.input(song);
  //beatDetector.input(in);
  beatDetector.sensitivity(250);

  falling = false;
}

void draw() {
  background(0);


  for (ParticleSystem system : systems) {
    system.run();
  }

  for (Particle p : particles) {
    if (falling == true) {
      p.applyGravity(gravity);
      p.fall();
      p.display();
    }
  }

  if (beatDetector.isBeat()) {
    ParticleSystem newSystem = new ParticleSystem(int(random(width)), int(random(height)));
    systems.add(newSystem);
  }



  imageMode(CORNER);
  //tint(255,255);
  //tint(247, 155, 187, 255);
}

void mouseClicked() {
  ParticleSystem newSystem = new ParticleSystem(mouseX, mouseY);
  systems.add(newSystem);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    wind = new PVector(0.05, 0);
  } else if (keyCode == LEFT) {
    wind = new PVector(-0.05, 0);
  } else if (key == 'q') {
    falling = true;
  } else if (key == ' '){
    ParticleSystem newSystem = new ParticleSystem(int(random(width)), int(random(height)));
  systems.add(newSystem);
  }
    
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    wind = new PVector(0, 0);
  }
}
