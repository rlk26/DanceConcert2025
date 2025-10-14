//notes for mia:
/*
falling flowers can wait until she starts dancing to actually go
  i changed this so that it starts when you press q but feel free to change it to whatever
flowers more hot pink
ms rothschild is thinking that the bursts of petals can go when the fans open (either with key press or sound recognition)
color of fans more like (232, 52, 151)

*/

import processing.sound.*;

PImage corner1;
PImage corner2;

boolean falling;

ArrayList<Particle> particles;
ArrayList<ParticleSystem> systems;
PVector gravity;
PVector wind;
ParticleSystem ps;
AudioIn in;
BeatDetector beatDetector;
SoundFile song;

void setup() {
  fullScreen();
  corner1 = loadImage("corner1.png");
  corner1.resize(int(width/2.5), (int(height/3)));
  corner2 = loadImage("corner2.png");
  corner2.resize(int(width/2.5), (int(height/3)));



  song = new SoundFile(this, "song.mp3");
  song.play();

  gravity = new PVector(0, 0.02);
  wind = new PVector(0, 0);

  systems = new ArrayList<ParticleSystem>();
  particles = new ArrayList<Particle>();

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

  /*if (beatDetector.isBeat()) {
    ParticleSystem newSystem = new ParticleSystem(int(random(width)), int(random(height)));
    systems.add(newSystem);
  }*/

  //fluid.display();
  //solid.display();

  imageMode(CORNER);
  //tint(255,255);
  tint(247, 155, 187, 255);
  image(corner1, 0, 0);
  image(corner2, width-corner2.width, 0);
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
