abstract class Scene {
  boolean use3D = false; 
  PGraphics pg;

  Scene() {
  }

  void init() {
    if (use3D) {
      pg = createGraphics(width, height, P3D);
    } else {
      pg = null;
    }
  }

  void run() {
    if (use3D && pg != null) {
      pg.beginDraw();
      draw3D(pg);
      pg.endDraw();
      image(pg, 0, 0);
    } else {
      draw2D();
    }
  }
  void draw2D() {}
  void draw3D(PGraphics pg) {}
  
  void reset() {}
  void keyPressed() {}
  void keyReleased() {}
  void mouseClicked() {}
}
