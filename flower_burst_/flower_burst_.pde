ArrayList<Flower> flowers;
color colorRandom;
PImage f1, f2, f3;

void setup() {
  fullScreen();
  
  f1 = loadImage("flower1.png");
  f2 = loadImage("flower2.png");
  f3 = loadImage("flower3.png");
  
  flowers = new ArrayList<Flower>();

  int cols = 10; // number of flowers horizontally
  int rows = 6;  // number of flowers vertically

  float spacingX = width / (cols + 1);
  float spacingY = height / (rows + 1);

  // place flowers in a grid
  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      float x = spacingX * (i + 1);
      float y = spacingY * (j + 1);
      flowers.add(new Flower(x, y, f1, f2, f3));
    }
  }

  imageMode(CENTER); // center images for easier grid placement
}

void draw() {
  // random background color
//  int randColor = int(random(3));
//  if (randColor == 0) colorRandom = ##050505;
//  else if (randColor == 1) colorRandom = #FFB4EF;
//  else colorRandom = #A4D7FA;
  
  background(0);
  frameRate(0.5);

  // global phase for synchronized breathing (2-second cycle)
  float cycleDuration = 2000.0; // 2 seconds
  float globalPhase = (millis() % cycleDuration) / cycleDuration * TWO_PI;

  for (Flower f : flowers) {
    f.display(globalPhase);
  }
}
