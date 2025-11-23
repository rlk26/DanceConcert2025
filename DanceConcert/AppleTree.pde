class AppleTree extends Scene {
  PImage tree;
  PImage petal;
  ArrayList<Petal> petals;
  int numPetals = 80;

  AppleTree (){
    
    tree = loadImage("apple_tree3.png"); 
    petal = loadImage("petal.png");
    petal.resize(30, 30);   
  
    tree.resize(width, (height/3)*2);

    petals = new ArrayList<Petal>();
    for (int i = 0; i < numPetals; i++) {
      petals.add(new Petal(random(width), random(-height, 0)));
    }
  }
  
  
  void run (){
    
    background(0);
    //background(198, 217, 255);
  
    imageMode(CORNER);
    //tint(165, 13, 13);
    //tint(250, 110, 110);
    tint(250, 50, 50, 250);
    image(tree, 0, 0);


    for (Petal p : petals) {
      p.update();
      p.display();
    }
  }
  
  class Petal {
  float x, y;
  float baseX;
  float speedY;
  float swayAngle;
  float swayAmplitude;
  float rotation;
  float rotationSpeed;
  float size;

  Petal(float x, float y) {
    this.x = x;
    this.baseX = x;
    this.y = y;
    this.speedY = random(0.05, 0.15);
    this.swayAngle = random(TWO_PI);
    this.swayAmplitude = random(5, 15);
    this.rotation = random(TWO_PI);
    this.rotationSpeed = random(-0.005, 0.005);
    this.size = random(0.5, 1.0);
  }

  void update() {
    y += speedY;
    x = baseX + sin(swayAngle) * swayAmplitude;
    swayAngle += 0.01;
    rotation += rotationSpeed;

    if (y > height) {
      y = random(-150, -10);
      baseX = random(width);
      x = baseX;
      speedY = random(0.05, 0.15);
      swayAngle = random(TWO_PI);
      swayAmplitude = random(5, 15);
      rotationSpeed = random(-0.005, 0.005);
      size = random(0.5, 1.0);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    imageMode(CENTER);
    scale(size);
    image(petal, 0, 0);
    popMatrix();
  }
}
  
}
