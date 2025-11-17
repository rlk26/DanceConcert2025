import processing.sound.*;

SoundFile player;
PImage room;
ArrayList<Raindrop> raindrops;
Lightning lightning;
Flame[] flames;

void setup() {
  fullScreen();
  player = new SoundFile(this, "Control.mp3");
  player.play();
  
  room = loadImage("room.png");
  room.resize(width, height);
  
  lightning = new Lightning();
  
  raindrops = new ArrayList<Raindrop>();
  for (int i = 0; i < 600; i++) {
    raindrops.add(new Raindrop());
  }
  
  flames = new Flame[] {
    new Flame(width * 0.03, height * 0.83),
    new Flame(width * 0.34, height * 0.83),
    new Flame(width * 0.64, height * 0.83),
    new Flame(width * 0.94, height * 0.83)
  };
}

void draw() {
  background(0);
  
  int levels = int(height * 0.0556);
  color startCol = color(10, 45, 90);
  color endCol = color(0);
  float step = height / float(levels);
  
  for (int i = 0; i < levels; i++) {
    color curCol = lerpColor(startCol, endCol, i / float(levels));
    noStroke();
    fill(curCol);
    
    rect(0, i * step, width, step);
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
  
  image(room, 0, 0);
  
  for (Flame f : flames) {
    f.display();
    f.update();
  }
}
