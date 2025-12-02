
import java.util.ArrayList;

ArrayList<RoseBurst> bursts = new ArrayList<RoseBurst>();
float globalTime = 0;

void settings() 
{
  fullScreen(P3D);
}

void setup() 
{
  frameRate(60);
  noCursor();
  colorMode(HSB, 360, 100, 100, 100);
}

void draw() 
{
  globalTime += 0.01;

  // claer brightness buildup
  background(0);

  // ---- continouous spawning ----
  if (random(1) < 0.03) 
  {  
    bursts.add(new RoseBurst());
  }

  // draw AND updating blooms
  for (int i = bursts.size()-1; i >= 0; i--) 
  {
    RoseBurst b = bursts.get(i);
    b.draw();
    if (!b.update()) bursts.remove(i);
  }
}

// Optional cue ---> space bar = extra blooms

void keyPressed() 
{
  if (key == ' ') 
  {
    for (int i = 0; i < 3; i++) bursts.add(new RoseBurst());
  }
}

// ------------- BLOOMING ROSE CURVES -------------

class RoseBurst 
{
  float x, y;
  float life;      
  float speed;
  float baseRadius;
  float k;         
  float rotSpeed;
  float hueOffset;
  int   layers;

  int spikes;
  float ringPhaseOffset;

  RoseBurst() 
  {
    x = random(width * 0.1, width * 0.9);
    y = random(height * 0.1, height * 0.9);

    life = 0;
    speed = random(0.004, 0.009);

    float minSide = min(width, height);
    baseRadius = minSide * random(0.10, 0.32);

    k = random(0.7, 2.0);

    rotSpeed = random(-0.6, 0.6);
    hueOffset = random(-10, 25);

    layers = int(random(2, 4));

    spikes = int(random(6, 11));
    ringPhaseOffset = random(TWO_PI);
  }

  boolean update() 
  {
    life += speed;
    return life < 1.0;
  }

  void draw() 
  {
    float p = constrain(life, 0, 1);
    float env = sin(p * PI);
    if (env < 0.001) return;

    pushMatrix();
    translate(x, y);

    // main petals
    for (int l = 0; l < layers; l++) {
      float lt = l / max(1.0, layers - 1.0);

      float rot = (globalTime * 0.4 + p * 2.0) * rotSpeed * (1.0 + lt);
      float rScale = baseRadius * (0.45 + 0.5 * lt);

      float brightness = 60 + 25 * env * (1.0 - lt * 0.2);
      float alpha = 70 * env * (1.0 - lt * 0.25);
      float sat = 70 + 20 * lt;

      strokeWeight(1.8 + (layers - l));
      stroke(200 + hueOffset + lt * 20, sat, brightness, alpha);
      noFill();

      pushMatrix();
      rotate(rot);

      float prevX = 0;
      float prevY = 0;
      boolean first = true;

      for (float a = 0; a < TWO_PI * 5; a += 0.015) 
      {
        float r = rScale * sin(k * a + p * 3.0);
        float px = r * cos(a);
        float py = r * sin(a);
        if (!first) line(prevX, prevY, px, py);
        first = false;
        prevX = px;
        prevY = py;
      }

      popMatrix();
    }

    // rotating halo like spark 
    float ringR = baseRadius * (0.6 + 0.4 * env);
    float ringRot = globalTime * 0.6 * rotSpeed + ringPhaseOffset;

    strokeWeight(1.3);
    stroke(200 + hueOffset, 50, 80, 45 * env);
    noFill();

    pushMatrix();
    rotate(ringRot);
    for (int i = 0; i < spikes; i++) 
    {
      float a = TWO_PI * i / spikes;
      float inner = ringR * 0.55;
      float outer = ringR;
      float x1 = cos(a) * inner;
      float y1 = sin(a) * inner;
      float x2 = cos(a) * outer;
      float y2 = sin(a) * outer;
      line(x1, y1, x2, y2);
    }
    popMatrix();

    // center glow SOFT***
    noStroke();
    fill(210 + hueOffset, 40, 80, 40 * env);
    ellipse(0, 0, baseRadius * 0.6, baseRadius * 0.6);

    popMatrix();
  }
}
