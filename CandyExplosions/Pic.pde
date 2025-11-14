PImage icecream;

class  Pic {
  float x;
  float y=0;
  PVector position, velocity, acceleration;
  //declare top speed and display size
  float angle, angleVel, angleAcc;
  int lifeSpan;
  PImage candy;
  int r;
  float rotate;
  String name;
  float xIn, yIn;
  
  Pic(String candyIn,float xIn,float yIn) {
    initialize();
    name = candyIn;
    if (name== "icecream") {
      candy= icecream;
    }
    
    if (candy == null) {
      println("Error: image is null!");
    }

    //assign initial values based on parameters passed into constructor
    position = new PVector(xIn, yIn);
    velocity = new PVector(random(3), random(8));
    acceleration = new PVector(0, 0);
    candy.resize(100, 100);
    lifeSpan = 1000;
    rotate = 10;
  }
  
  void initialize() {
    if (icecream==null) {
      icecream= loadImage("icecream.png");
    }
  
  }
  
  void display(){
    push();
    translate(position.x,position.y);
    rotate(rotate);
    imageMode(CENTER);
    image(candy, 0, 0);
    pop();
  }
  
}
