/*class GlueSong extends Scene {
  PVector camPos, camCenter;
  ArrayList<Tree> trees;

  PImage treeTex;
  PImage[] speeches;
  int totalSpeeches = 16;

  float bubbleAlpha = 0;
  int bubbleIndex = -1;
  boolean fadingIn = false;
  boolean fadingOut = false;

  GlueSong() {
    //use3D = true;

    camPos = new PVector(0, 0, 600);
    camCenter = new PVector(0, 0, 0);

    treeTex = loadImage("DandeSeed.png");

    speeches = new PImage[totalSpeeches];
    for (int i = 0; i < totalSpeeches; i++) {
      String filename = "Speech" + nf(i+1, 2) + ".png";
      speeches[i] = loadImage(filename);
    }

    trees = new ArrayList<Tree>();
    for (int i = 0; i < 25; i++) spawnTree();
  }

  void draw3D(PGraphics pg) {
    pg.beginDraw();
    pg.background(0);
    pg.camera(camPos.x, camPos.y, camPos.z,
              camCenter.x, camCenter.y, camCenter.z,
              0, 1, 0);

    pg.lights();

    // trees
    for (int i = trees.size() - 1; i >= 0; i--) {
      Tree t = trees.get(i);
      t.update();
      t.display(pg);
      if (t.done()) {
        trees.remove(i);
        spawnTree();
      }
    }

    pg.endDraw();
    image(pg, 0, 0);

    updateBubble();
    displayBubble();
  }

  void spawnTree() {
    float x = random(-width/2, width/2);
    float y = random(-height/2, height/2);
    float z = random(-200, 300);
    trees.add(new Tree(new PVector(x, y, z), treeTex));
  }

  class Tree {
    PVector pos;
    float baseSize, size, maxSize, growth;
    float alpha = 0;
    PImage tex;
    float swayAngle = random(TWO_PI);
    float swaySpeed = random(0.005, 0.02);
    float life = 0;
    float fadeSpeed = 0.5;

    Tree(PVector p, PImage tex) {
      this.pos = p.copy();
      this.tex = tex;
      this.baseSize = random(30, 50);
      this.size = baseSize;
      this.maxSize = baseSize + random(30, 60);
      this.growth = random(0.3, 0.6);
    }

    void update() {
      if (size < maxSize) size += growth;
      else life += 1;

      if (life > 200) alpha -= fadeSpeed;
      else if (alpha < 255) alpha += 5;

      swayAngle += swaySpeed;
    }

    void display(PGraphics pg) {
      pg.pushMatrix();
      pg.translate(pos.x + sin(swayAngle) * 10,
                   pos.y + cos(swayAngle * 0.5) * 10,
                   pos.z);

      pg.tint(255, constrain(alpha, 0, 255));
      pg.noStroke();

      float w = size;
      float h = size * 1.5;

      pg.beginShape();
      pg.textureMode(NORMAL);
      pg.texture(tex);
      pg.vertex(-w/2, -h/2, 0, 0, 0);
      pg.vertex( w/2, -h/2, 0, 1, 0);
      pg.vertex( w/2,  h/2, 0, 1, 1);
      pg.vertex(-w/2,  h/2, 0, 0, 1);
      pg.endShape(CLOSE);

      pg.popMatrix();
    }

    boolean done() {
      return alpha <= 0;
    }
  }

  // 🔹 input
  void mouseClicked() {
    if (!fadingIn && !fadingOut) {
      if (bubbleIndex == -1) {
        bubbleIndex = 0;
        fadingIn = true;
      } else if (bubbleAlpha == 255) {
        fadingOut = true;
      }
    }
  }

  void updateBubble() {
    if (fadingIn) {
      bubbleAlpha += 5;
      if (bubbleAlpha >= 255) {
        bubbleAlpha = 255;
        fadingIn = false;
      }
    } else if (fadingOut) {
      bubbleAlpha -= 5;
      if (bubbleAlpha <= 0) {
        bubbleAlpha = 0;
        fadingOut = false;

        bubbleIndex++;
        if (bubbleIndex >= totalSpeeches) {
          bubbleIndex = -1;
        } else {
          fadingIn = true;
        }
      }
    }
  }

  void displayBubble() {
    if (bubbleIndex < 0 || bubbleIndex >= totalSpeeches) return;

    hint(DISABLE_DEPTH_TEST);
    pushMatrix();
    camera();
    ortho();
    imageMode(CENTER);
    tint(255, bubbleAlpha);

    PImage current = speeches[bubbleIndex];
    image(current, width/1.75, height/2.3,
          current.width * 1.4, current.height * 1.4);

    popMatrix();
    hint(ENABLE_DEPTH_TEST);
  }
}*/
