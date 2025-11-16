class Flame {
  PVector pos;
  ArrayList<FlameParticle> particles;
  int maxParticles = 70;
  
  Flame(float x, float y) {
    pos = new PVector(x, y);
    particles = new ArrayList<FlameParticle>();
  }
  
  void update() {
    if (particles.size() < maxParticles && frameCount % 10 == 0) {
      particles.add(new FlameParticle(pos.x, pos.y));
    }
    
    for (FlameParticle fp : particles) {
      fp.update();
      
      if (fp.done()) {
        fp.reset(pos.x, pos.y);
      }
    }
  }
  
  void display() {
    for (FlameParticle fp : particles) {
      fp.display();
    }
  }
}
