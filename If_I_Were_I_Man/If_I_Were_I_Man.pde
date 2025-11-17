PImage bridgerton;
ArrayList<Petal> petals; 

void setup() {
  fullScreen();
  bridgerton = loadImage("bridgertonn_2.jpeg"); 
  bridgerton.resize(width, height);
  
  petals = new ArrayList<Petal>();
  
  for (int i = 0; i < 40; i++) {
    petals.add(new Petal());
  }
}

void draw() {
  image(bridgerton, 0, -150);
  
  for (Petal p : petals) {
    p.update();
    p.display();
  }
}

//background fade in 
