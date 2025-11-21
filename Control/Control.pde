import processing.sound.*;

SoundFile player;
PImage room;
ArrayList<Raindrop> raindrops;
Lightning lightning;
Flame[] flames;

int fadeDuration = 5000;
boolean playMusic = false;

static int WIDTH, HEIGHT, X, Y;

void setup() {
  fullScreen();
  
  X = width / 6;
  Y = 0;
  WIDTH = width / 3 * 2;
  HEIGHT = height / 4 * 3;
  
  if (playMusic) {
    player = new SoundFile(this, "Control.mp3");
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

void draw() {
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
