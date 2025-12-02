// timing stuff
float glowIntensity = 0;
float domeProgress = 0;
int startTime = 0;
boolean performanceStarted = false;
boolean shatterTriggered = false;
ArrayList<Spark> sparks;
ArrayList<Shard> shards;

int TOTAL_TIME = 90000; // make it 30 sec for testing
int SHATTER_TIME = 27000; // shatter at 27 sec (3 sec before end)

void setup() 
{
  fullScreen();
  colorMode(RGB, 255);
  
  performanceStarted = true;
  startTime = millis();
  
  // make some sparks
  sparks = new ArrayList<Spark>();
  for (int i = 0; i < 80; i++) {
    sparks.add(new Spark());
  }
  
  // make shards for later
  shards = new ArrayList();
}

void draw() 
{
  background(0);
  
  // figure out how far along we are
  if (performanceStarted) {
    int elapsed = millis() - startTime;
    float progress = (float)elapsed / TOTAL_TIME;
    progress = constrain(progress, 0, 1);
    
    glowIntensity = progress * 100;
    
    // dome appears early but gradient fills it slowly
    if (progress < 0.15) 
    {
      domeProgress = 0;
    } 
    else 
    {
      float domeStartProgress = (progress - 0.15) / 0.85;
      domeProgress = domeStartProgress * 100;
    }
    
    // trigger shatter near the end
    if (elapsed >= SHATTER_TIME && !shatterTriggered) 
    {
      triggerShatter();
    }
  }
  
  // draw sparks first so they're behind everything
  for (Spark s : sparks) 
  {
    s.update();
    s.display();
  }
  
  // red glow coming up from bottom - contained in dome
  noStroke();
  float glowHeight = height * (glowIntensity / 100);
  float maxRadius = min(width, height) * 0.8;
  float currentRadius = maxRadius * (domeProgress / 100);
  
  pushMatrix();
  translate(width / 2, height);
  
  // always draw dome outline first if it exists
  if (domeProgress > 5) 
  {
    noFill();
    for (int i = 0; i < 25; i++) 
    {
      float outlineAlpha = map(i, 0, 25, 120, 0) * (domeProgress / 100);
      stroke(220, 20, 40, outlineAlpha);
      strokeWeight(1 + i * 0.3);
      arc(0, 0, currentRadius * 2 + i * 5, currentRadius * 2 + i * 5, PI, TWO_PI);
    }
  }
  
  // gradient fills inside dome shape
  if (domeProgress > 5) 
  {
    for (float y = 0; y > -glowHeight; y -= 2) 
    {
      float distFromBottom = abs(y);
      float fadeAmount = distFromBottom / glowHeight;
      
      // crimson color - more burgundy
      float redValue = 180 + (75 * (1 - fadeAmount * 0.5));
      float greenValue = 0;
      float blueValue = 30 * (1 - fadeAmount * 0.8);
      float alpha = 255 * (1 - fadeAmount);
      
      fill(redValue, greenValue, blueValue, alpha);
      
      // calculate width at this height using circle formula
      float radiusAtHeight = sqrt(currentRadius * currentRadius - y * y);
      if (!Float.isNaN(radiusAtHeight)) 
      {
        rect(-radiusAtHeight, y, radiusAtHeight * 2, 2);
      }
    }
  }
  
  popMatrix();
  
  // draw shards if shattered
  if (shatterTriggered) {
    for (int i = shards.size() - 1; i >= 0; i--) 
    {
      Shard s = shards.get(i);
      s.update();
      s.display();
      if (s.isDead()) 
      {
        shards.remove(i);
      }
    }
  }
  
  // check progress
  fill(255);
  textSize(16);
  text("Progress: " + int(glowIntensity) + "%", 20, 30);
}

// sparks that fall slowly
class Spark 
{
  float x, y;
  float size;
  float speed;
  float alpha;
  float brightness;
  
  Spark() 
  {
    x = random(width);
    y = random(-height, 0);
    size = random(2, 6);
    speed = random(0.3, 1.2);
    alpha = random(150, 255);
    brightness = random(180, 255);
  }
  
  void update() 
  {
    y += speed;
    if (y > height) 
    {
      y = random(-50, 0);
      x = random(width);
    }
  }
  
  void display() 
  {
    // glow effect
    noStroke();
    for (int i = 0; i < 3; i++) 
    {
      float glowAlpha = alpha * (glowIntensity / 100) / (i + 1);
      fill(brightness, 20, 40, glowAlpha);
      ellipse(x, y, size + i * 4, size + i * 4);
    }
    
    // center bright spot
    fill(brightness, 50, 60, alpha * (glowIntensity / 100));
    ellipse(x, y, size, size);
  }
}

void keyPressed() 
{
  if (key == 'r' || key == 'R') 
  {
    // start over
    performanceStarted = true;
    startTime = millis();
    glowIntensity = 0;
    domeProgress = 0;
    shatterTriggered = false;
    shards.clear();
  }
}

void triggerShatter() 
{
  shatterTriggered = true;
  
  // create shards from the dome
  float maxRadius = min(width, height) * 0.8;
  float currentRadius = maxRadius * (domeProgress / 100);
  
  // make lots of shards
  for (int i = 0; i < 60; i++) 
  {
    float angle = random(PI, TWO_PI);
    float r = random(currentRadius * 0.7, currentRadius);
    float x = width/2 + cos(angle) * r;
    float y = height + sin(angle) * r;
    
    shards.add(new Shard(x, y));
  }
}

// shards that explode outward
class Shard 
{
  float x, y;
  float vx, vy;
  float rotation;
  float rotSpeed;
  float alpha;
  float size;
  int numPoints;
  float[] pointsX;
  float[] pointsY;
  
  Shard(float startX, float startY) 
  {
    x = startX;
    y = startY;
    
    // velocity away from center
    float angle = atan2(y - height, x - width/2);
    float speed = random(3, 10);
    vx = cos(angle) * speed;
    vy = sin(angle) * speed - 3;
    
    rotation = random(TWO_PI);
    rotSpeed = random(-0.15, 0.15);
    alpha = 255;
    size = random(15, 35);
    
    // make irregular shard shape
    numPoints = int(random(3, 6));
    pointsX = new float[numPoints];
    pointsY = new float[numPoints];
    
    for (int i = 0; i < numPoints; i++) 
    {
      float a = (float)i / numPoints * TWO_PI + random(-0.4, 0.4);
      float r = size * random(0.5, 1);
      pointsX[i] = cos(a) * r;
      pointsY[i] = sin(a) * r;
    }
  }
  
  void update() 
  {
    x += vx;
    y += vy;
    vy += 0.3; // gravity
    rotation += rotSpeed;
    alpha -= 2.5;
  }
  
  void display() 
  {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    
    // draw shard with glow
    for (int i = 0; i < 2; i++) 
    {
      float glowAlpha = alpha / (i + 1) * 0.5;
      fill(220, 20, 40, glowAlpha);
      noStroke();
      
      beginShape();
      for (int j = 0; j < numPoints; j++) 
      {
        vertex(pointsX[j] + i * 2, pointsY[j] + i * 2);
      }
      endShape(CLOSE);
    }
    
    // main shard
    fill(180, 0, 30, alpha);
    beginShape();
    for (int i = 0; i < numPoints; i++) 
    {
      vertex(pointsX[i], pointsY[i]);
    }
    endShape(CLOSE);
    
    popMatrix();
  }
  
  boolean isDead() 
  {
    return alpha <= 0;
  }
}
