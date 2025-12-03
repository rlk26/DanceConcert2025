//declare a mover object
Mover mover;
Fluid fluid;
PVector gravity;
PVector wind;
ArrayList<Mover>movers;

void setup(){ 
  fullScreen();
  background(0,0,0);
  colorMode(HSB, 360, 100, 100); 

  //initialize mover object with constructor 
  mover = new Mover(); 
  mover.c = color(random(360), 80, 90); 

  fluid = new Fluid(0,height/2+100,width,height,0.2);
  movers = new ArrayList<Mover>();


  for (int i = 0; i < 40; i++)
  { 
    Mover m = new Mover(); 
    
    
    m.c = color(i * 36, 90, 90); 

    movers.add(m);
  } 

  
  gravity = new PVector(0.0,0.06); 
  wind = new PVector(0,0);
}

void draw(){ 
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
  if(mover.isInFluid(fluid)) { 
    println("ITS IN FLUID !"); 
  } else { 
    // println("itsz not"); // Commented out to prevent console spam
  } 
  fluid.display1(); //call our function

  for(Mover m: movers)
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
  if(keyCode == LEFT); 
  { 
    wind = new PVector(-0.1,0.0); 
  } 
  if(keyCode == RIGHT); 
  { 
    wind = new PVector(0.1,0.0); 
  }
}
