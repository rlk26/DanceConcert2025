class SuperMover extends Scene {
  //declare a mover object
  Mover mover;
  Fluid fluid;
  PVector gravity;
  PVector wind;
  ArrayList<Mover>movers;

  SuperMover() {
    fullScreen();
    background(0, 0, 0);
    colorMode(HSB, 360, 100, 100);

    //initialize mover object with constructor
    mover = new Mover();
    mover.c = color(random(360), 80, 90);

    fluid = new Fluid(0, height/2+100, width, height, 0.2);
    movers = new ArrayList<Mover>();


    for (int i = 0; i < 40; i++)
    {
      Mover m = new Mover();


      m.c = color(i * 36, 90, 90);

      movers.add(m);
    }


    gravity = new PVector(0.0, 0.06);
    wind = new PVector(0, 0);
  }

  void run() {
    // Add a semi-transparent background to create a subtle "trail" effect
    // Fill with white and a low alpha value (e.g., 20)
    fill(0, 0, 0, 20);
    rect(0, 0, width, height);

    //call mover functions
    //mover.accelerate Towards Mouse();
    // mover.accelerate Randomly();
    mover.applyForce(gravity);
    mover.applyForce(wind);
    mover.update();
    mover.checkEdgesBounce();
    mover.display();
    if (mover.isInFluid(fluid)) {
      println("ITS IN FLUID !");
    } else {
      // println("itsz not"); // Commented out to prevent console spam
    }
    fluid.display1(); //call our function

    for (Mover m : movers)
    {
      m.applyForce(gravity);
      m.applyForce(wind);
      m.update();
      m.checkEdgesBounce();
      m.display();
    }
  }

  void keyPressed()
  {
    if (keyCode == LEFT);
    {
      wind = new PVector(-0.1, 0.0);
    }
    if (keyCode == RIGHT);
    {
      wind = new PVector(0.1, 0.0);
    }
  }


  //declare the class
  //add variable for position, width, its thickness(Drag) and height

  class Fluid {

    float x, y, w, h, c;

    //define constructor function w paramters position and size
    Fluid(float xIn, float yIn, float wIn, float hIn, float cIn)
    {
      x = xIn;
      y = yIn;
      w = wIn;
      h = hIn;
      c = cIn;

      //In paramter passing in the class constructor, placeholder varriable
    }

    //display

    void display1()
    {
      fill(0, 0, 0, 100);
      rect(x, y, w, h);
    }
  }
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
      if (position.x > f.x && position.x < f.x+f.w && position.y > f.y && position.y < f.y+f.h)
      {
        return true;
      } else
      {
        return false;
      }
    }



    //this function will create an acceleration towards the mouse
    void accelerateTowardsMouse() {
      //create a vector for mouse location
      PVector mouse = new PVector(mouseX, mouseY);
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
    void accelerateRandomly() {
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

      if (position.y + radius > height*0.65) {
        velocity.y *= -1;
        position.y = height*0.65 - radius;
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
}
