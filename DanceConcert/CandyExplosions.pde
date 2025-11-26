class CandyExplosions extends Scene {
  boolean falling;

  ArrayList<Particle> particles;
  ArrayList<ParticleSystem> systems;
  PVector gravity;
  PVector wind;
  ParticleSystem ps;
  AudioIn in;
  BeatDetector beatDetector;
  SoundFile song;
  Pic iceCream;

  PImage candy1;
  PImage candy2;
  PImage candy3;
  PImage candy4;
  PImage candy5;
  PImage icecream;


  CandyExplosions(PApplet pap) {

    song = new SoundFile(pap, "song.mp3");
    song.play();

    gravity = new PVector(0, 0.02);
    wind = new PVector(0, 0);

    systems = new ArrayList<ParticleSystem>();
    particles = new ArrayList<Particle>();

    iceCream = new Pic("icecream", 100, 100);

    for (int i = 0; i < 15; i++) {
      Particle p = new Particle();
      particles.add(p);
    }
    ps = new ParticleSystem(width/2, height/2);
    systems.add(ps);


    beatDetector = new BeatDetector(pap);
    in = new AudioIn(pap);
    beatDetector.input(song);
    //beatDetector.input(in);
    beatDetector.sensitivity(250);

    falling = false;
  }

  void run() {
    background(0);


    for (ParticleSystem system : systems) {
      system.run();
    }

    for (Particle p : particles) {
      if (falling == true) {
        p.applyGravity(gravity);
        p.fall();
        p.display();
      }
    }

    if (beatDetector.isBeat()) {
      ParticleSystem newSystem = new ParticleSystem(int(random(width)), int(random(height)));
      systems.add(newSystem);
    }



    imageMode(CORNER);
    //tint(255,255);
    //tint(247, 155, 187, 255);
  }

  void mouseClicked() {
    ParticleSystem newSystem = new ParticleSystem(mouseX, mouseY);
    systems.add(newSystem);
  }

  void keyPressed() {
    if (keyCode == RIGHT) {
      wind = new PVector(0.05, 0);
    } else if (keyCode == LEFT) {
      wind = new PVector(-0.05, 0);
    } else if (key == 'q') {
      falling = true;
    } else if (key == ' ') {
      ParticleSystem newSystem = new ParticleSystem(int(random(width)), int(random(height)));
      systems.add(newSystem);
    }
  }

  void keyReleased() {
    if (keyCode == RIGHT || keyCode == LEFT) {
      wind = new PVector(0, 0);
    }
  }

  class Particle {
    //declare motion vectors
    float x;
    float y=0;
    PVector position, velocity, acceleration;
    //declare top speed and display size
    float topSpeed, radius, mass;
    float angle, angleVel, angleAcc;
    int lifeSpan;
    PImage candy;
    int r;
    float rotate;



    //Constructor Function
    Particle(PVector pIn, PVector vIn) {
      initialize();
      r = int(random(5));
      if (r==0) {
        candy= candy1;
      } else if (r==1) {
        candy= candy2;
      } else if (r==2) {
        candy= candy3;
      } else if (r==3) {
        candy= candy4;
      } else {
        candy= candy5;
      }

      //assign initial values based on parameters passed into constructor
      position = new PVector(pIn.x, pIn.y);
      velocity = new PVector(vIn.x, vIn.y);
      acceleration = new PVector(0, 0);
      topSpeed = 10;
      radius = 20;
      candy.resize(int(radius*2), int(radius*2));
      mass = 1;
      lifeSpan = 0;
      rotate = random(100);
    }

    Particle() {
      initialize();
      r = int(random(3));
      if (r==0) {
        candy= candy1;
      } else if (r==1) {
        candy= candy2;
      } else if (r==2) {
        candy= candy3;
      } else if (r==3) {
        candy= candy4;
      } else {
        candy= candy5;
      }
      if (candy == null) {
        println("Error: Particle flower image is null!");
      }

      //assign initial values based on parameters passed into constructor
      position = new PVector(random(width), -random(height));
      velocity = new PVector(random(3), random(8));
      acceleration = new PVector(0, 0);
      topSpeed = 15;
      radius = 40;
      candy.resize(int(radius*2), int(radius*2));
      mass = random(3);
      lifeSpan = 1000;
      rotate = random(100);
    }


    void initialize() {
      if (candy1==null) {
        candy1= loadImage("candy1.png");
        candy2= loadImage("candy2.png");
        candy3= loadImage("candy3.png");
        candy4= loadImage("candy4.png");
        candy5= loadImage("candy5.png");
      }
      if (candy1 == null || candy2 == null || candy3 == null) {
        println("Error: One or more candy images are missing!");
      }
    }
    //function to check if particle is dead
    boolean isDead() {
      if (lifeSpan >255) {
        return true;
      } else {
        return false;
      }
    }




    void applyForce(PVector force) {
      //divide force by mover mass
      PVector f = PVector.div(force, mass);
      //add the resulting vector to acceleration
      acceleration.add(f);
    }

    void applyGravity(PVector gravity) {
      //add the gravity vector to acceleration
      acceleration.add(gravity);
    }

    void update() {
      if (frameCount%5==0) {
        lifeSpan+=2;
      }

      angleAcc = acceleration.x/10;
      angleVel += angleAcc;
      angle += angleVel;

      //add acceleration to velocity
      velocity.add(acceleration);
      //limit magnitude of velocity
      velocity.limit(topSpeed);
      //add velocity to position
      position.add(velocity);
      //reset acceleration to zero
      acceleration.mult(0);
    }

    void checkEdgesWrap() {
      if (position.x > width + radius) {
        position.x = 0 - radius;
      } else if (position.x < 0 - radius) {
        position.x = width + radius;
      }

      if (position.y > height + radius) {
        position.y = 0 - radius;
      } else if (position.y < 0 - radius) {
        position.y = height + radius;
      }
    }

    void checkEdgesBounce() {
      if (position.x > width) {
        position.x = width;
        velocity.x*=-1;
      } else if (position.x < 0) {
        position.x = 0;
        velocity.x*=-1;
      }

      if (position.y > height) {
        position.y = height;
        velocity.y*=-1;
      } else if (position.y < 0) {
        position.y = 0;
        velocity.y*=-1;
      }
    }

    void display() {
      noStroke();
      pushMatrix();
      translate(position.x, position.y);
      rotate(rotate);
      rotate(angle);
      imageMode(CENTER);

      // tint(100, 100, 100, lifeSpan);
      image(candy, 0, 0);
      fill(0, 0, 0, lifeSpan);
      rectMode(CENTER);
      rect(0, 0, radius*2, radius*2);

      popMatrix();
    }

    void fall() {
      lifeSpan-=4;
      if (position.y>=height) {
        position.y=-random(height);
        position.x = random(width);
        lifeSpan = 1000;
        println(mass);
        velocity.y = 1.5;
      }

      //add acceleration to velocity
      velocity.add(acceleration);
      //limit magnitude of velocity
      velocity.limit(topSpeed);
      //add velocity to position
      position.add(velocity);
      //reset acceleration to zero
      acceleration.mult(0);
    }
  }

  class ParticleSystem {
    ArrayList<Particle> particles;
    PVector position;

    ParticleSystem(int x, int y) {
      //initialize the particle arrayList
      particles = new ArrayList<Particle>();
      position = new PVector(x, y);
      //populate the arraylist with particles using a for loop
      for (int i = 0; i < 40; i++) {
        PVector p = PVector.random2D();
        p.mult(random(1, 2));
        Particle particle = new Particle(position, p);
        particles.add(particle);
      }
    }

    void run() {
      //Removes dead particles
      for (int i = particles.size()-1; i > -1; i--) {
        Particle p = particles.get(i);
        if (p.isDead()) {
          particles.remove(p);
        }
      }

      //use an enhanced for loop to cycle through each particle in the arrayList
      for (Particle p : particles) {
        p.applyGravity(gravity);
        p.update();
        //p.checkEdgesBounce();
        p.display();
      }
    }

    boolean isDead() {
      //you could base the fireworks life on lifespan or the particles in in it
      if (particles.size() < 1) {
        return true;
      } else {
        return false;
      }
    }
  }

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

    Pic(String candyIn, float xIn, float yIn) {
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

    void display() {
      push();
      translate(position.x, position.y);
      rotate(rotate);
      imageMode(CENTER);
      image(candy, 0, 0);
      pop();
    }
  }
}
