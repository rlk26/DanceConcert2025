// Variables for wave and sparkle effect
int cols, rows;
float scl = 20; // Scale for the grid of vertices
float w, h;
float[][] terrain;
float flying = 0;

// Variables for color gradient
color oceanTop, oceanDeep;
float gradientStep;

// Variables for sparkle effect
Particle[] particles;
int numParticles = 100;

void setup() {
  size(800, 600, P3D);
  w = width * 1.5;
  h = height * 2;
  cols = floor(w / scl);
  rows = floor(h / scl);
  terrain = new float[cols][rows];

  // Define ocean colors for the gradient
  oceanTop = color(95, 158, 160); // A teal/light blue
  oceanDeep = color(0, 0, 102);  // A deep navy blue
  gradientStep = 1.0 / rows;

  // Initialize the particle system for sparkles
  particles = new Particle[numParticles];
  for (int i = 0; i < numParticles; i++) {
    particles[i] = new Particle();
  }
}

void draw() {
  background(10, 20, 40); // Dark background for contrast

  // Animate the wave surface using perlin noise
  flying -= 0.05;
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  // Adjust camera and lighting
  camera(mouseX, mouseY, 400 + mouseX, width/2.0, height/2.0, 0, 0, 1, 0);
  lights();

  // Draw the ocean waves
  pushMatrix();
  translate(width / 2.0, height / 2.0 + 50);
  rotateX(PI / 3);
  translate(-w / 2, -h / 2);

  for (int y = 0; y < rows - 1; y++) {
    // Interpolate the color for the current row
    float lerpAmount = gradientStep * y;
    color c = lerpColor(oceanTop, oceanDeep, lerpAmount);

    // Set the material for the waves with the gradient color
    fill(c);
    noStroke();
    
    // Draw each quad strip to form the waves
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      vertex(x * scl, y * scl, terrain[x][y]);
      vertex(x * scl, (y + 1) * scl, terrain[x][y + 1]);
    }
    endShape();
  }
  popMatrix();

  // Update and display sparkles
  for (int i = 0; i < numParticles; i++) {
    particles[i].update();
    particles[i].display();
  }
}

// Sparkle particle class
class Particle {
  PVector position;
  PVector velocity;
  float lifespan;
  float size;
  color sparkleColor;

  Particle() {
    // Start sparkles near the wave crests
    position = new PVector(random(width), random(height / 2, height));
    velocity = new PVector(random(-1, 1), random(-2, -0.5));
    lifespan = random(50, 150);
    size = random(1, 3);
    sparkleColor = color(255, 255, 200, 150); // Off-white/yellowish for sparkle
  }

  void update() {
    position.add(velocity);
    lifespan -= 1.0;
    
    // Reset the particle if it dies
    if (lifespan < 0) {
      position = new PVector(random(width), random(height / 2, height));
      velocity = new PVector(random(-1, 1), random(-2, -0.5));
      lifespan = random(50, 150);
    }
  }

  void display() {
    float alpha = map(lifespan, 0, 150, 0, 255);
    stroke(sparkleColor, alpha);
    strokeWeight(size);
    point(position.x, position.y);
  }
}
