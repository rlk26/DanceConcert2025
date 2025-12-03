//This tab will define our 'mover' class...a reusable, modifiable mover object
//Declare Class!
class Mover {
  //Declare PVectors for position, velocity, acceleration
  PVector position, velocity, acceleration;

  //Declare floats for size, topspeed?
  float radius, topSpeed;
  float mass;
  color c;

  //Declare a constructor function with parameters for position and velocity
  Mover(PVector posIn, PVector velIn) {
    //assign values to variables
    position = posIn;
    velocity = velIn;
    //give acceleration an initial value
    acceleration = new PVector(0.0, 0.0);
    radius = 40;
    topSpeed = 40;
    mass = 1;
  }

  //constructor if you want random values
  Mover() {
    //assign values to variables
    position = new PVector(random(0, width), random(0, height));
    velocity = PVector.random2D();
    //give acceleration an initial value
    acceleration = PVector.random2D();
    radius = random(10, 20);
    topSpeed = 10;
        mass = 1;
  }

  //update function
  void update() {
    //give the mover a new random acceleration
    //acceleration = PVector.random2D();
    //increment velocity by acceleration
    velocity.add(acceleration);
    //limit the velocity by topSpeed
    velocity.limit(topSpeed);
    println(velocity.mag());
    //increment position by velocity
    position.add(velocity);
    acceleration.mult(0);
  }


boolean isInFluid(Fluid f)
{
  if(position.x > f.x && position.x < f.x+f.w && position.y > f.y && position.y < f.y+f.h)
  {
    return true;
  }
  else 
  {
    return false;
  }
}



  //this function will create an acceleration towards the mouse
  void accelerateTowardsMouse() {
    //create a vector for mouse location
    PVector mouse = new PVector(mouseX,mouseY);
    //subtract position from mouse location and assign to new ‘direction’ vector (use static func.)
    PVector direction = PVector.sub(mouse, position);
    //normalize direction vector to make its magnitude 1
    direction.normalize();
    //scale direction by multiplying by desired acceleration value
    direction.mult(0.5);
    //set acceleration equal to direction vector
    acceleration = direction;
  }
  
  //this function will generate a random acceleration
  void accelerateRandomly(){
    //use the STATIC function that belongs to the PVector class 
    acceleration = PVector.random2D();
  }


  //checkEdges function (wrap version instead of bounce)
  void checkEdgesWrap() {
    //if x position reaches right side of screen...
    if (position.x-radius > width) {
      //reset x position to left side of screen
      position.x = 0-radius;
    } else if (position.x+radius < 0) {
      //if x position reaches left side of screen....
      position.x = width+radius;
    }

    if (position.y - radius > height) {
      position.y = 0-radius;
    } else if (position.y + radius < 0) {
      position.y = height+radius;
    }
  }

  //add a function to bounce the mover off the edges
  void checkEdgesBounce() {
    //check right edge of the mover with right edge of the screen
    if (position.x + radius > width) {
      //reverse the x velocity
      velocity.x *= -1;
      //snap the mover back to the right edge of the screen
      position.x = width-radius;
    } else if (position.x - radius < 0) {
      velocity.x *= -1;
      position.x = 0 + radius;
    }

    if (position.y + radius > height) {
      velocity.y *= -1;
      position.y = height - radius;
    } else if (position.y - radius < 0) {
      velocity.y *= -1;
      position.y = 0 + radius;
    }
  }

  //display function 
  void display() {
    //draw an ellipse at mover's position
    fill(c);
    noStroke();
    ellipse(position.x, position.y, radius*2, radius*2);
  }
  
  //function to add force to our mover
  //decalre it w paramater for force being applied uwu
  
  void applyForce(PVector force)
  {
    //uwu make a copy of the vector so we can be manipulative to it mwahaha
    PVector f = new PVector(force.x, force.y);
    //divide the force by the mass to get acceleration as a = f/m
    f.div( mass);
    //add the new vector to the acceleration vector uwuw
    acceleration.add(f);
  }
}
