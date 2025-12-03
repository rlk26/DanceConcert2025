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

int flashDuration = 0;
final int MAX_FLASH_DURATION = 5;

void setup() {
  fullScreen();

  song = new SoundFile(this, "song.mp3");
  song.play();
  gravity = new PVector(0, 0.02);
  wind = new PVector(0, 0);
  systems = new ArrayList<ParticleSystem>();
  particles = new ArrayList<Particle>();
  
  ps = new ParticleSystem(width/2, height/2);
  systems.add(ps);
  beatDetector = new BeatDetector(this);
  beatDetector.input(song);
  beatDetector.sensitivity(250);
  falling = false;
}

void draw() {
  background(0);

 
  if (flashDuration > 0) {
    fill(255); 
    noStroke();
    for(int i =0; i<300; i++)
    {
       rect(random(width), random(height), 20, 20);
    }
    flashDuration--; 
  }

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
}

void mouseClicked() {
  ParticleSystem newSystem = new ParticleSystem(mouseX, mouseY);
  systems.add(newSystem);
}


void flashLight() {
  flashDuration = MAX_FLASH_DURATION;
  //ParticleSystem newSystem = new ParticleSystem(width/2, height/2);
  //systems.add(newSystem);
}

void keyPressed() {
  if (keyCode == RIGHT) {
    wind = new PVector(0.05, 0);
  } else if (keyCode == LEFT) {
    wind = new PVector(-0.05, 0);
  } else if (key == 'q') {
    falling = true;
  } else if (key == ' ') {
    
    flashLight();
  }
  
}

void keyReleased() {
  if (keyCode == RIGHT || keyCode == LEFT) {
    wind = new PVector(0, 0);
  }
}
