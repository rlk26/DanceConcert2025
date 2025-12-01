PImage bridgerton;
ArrayList<Petal> petals;
boolean showImage = false;
float transparency = 0;

void setup() {
  fullScreen();
  bridgerton = loadImage("bridgertonn_2.jpeg"); 
  bridgerton.resize(width, height);
  
  petals = new ArrayList<Petal>();
  
}

void draw() {
  if (showImage) {
    background(0);
    tint(255, transparency);
    image(bridgerton, 0, -275);
    tint(255, 255);
    if (transparency < 255) {
      transparency += .5;
    }
  } else {
    background(0); 
  }
  
  for (Petal p : petals) {
    p.update();
    p.display();
  }
}

void mousePressed() {
  showImage = true;
  for (int i = 0; i < 30; i++) {
    petals.add(new Petal());
  }
}
