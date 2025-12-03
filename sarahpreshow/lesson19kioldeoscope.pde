
int n = 6;
float angle;
float x, vx;
float y, vy;
int c1;
int c2;
int c3;


void setup()
{
  fullScreen();
  angle = 0;
  x = 0;
  vx = 1;
  y = 0;
  vy = 2;
  
  c1 = color(random(255),random(255),random(255));
  c2 = color(random(255),random(255),random(255));
  c3 = color(random(255),random(255),random(255));
  

}

void init(){
  
  c1 = color(random(255),random(255),random(255));
  c2 = color(random(255),random(255),random(255));
  c3 = color(random(255),random(255),random(255));
  
}


void draw()
{
  translate(mouseX, mouseY);
  background(0);
  rotate(angle);

  

  
  for(int i = 0; i < n; i++)
  {
    rotate(TWO_PI/n);
    stroke(255);
    strokeWeight(4);
    fill(c1);
    rect(x,y,100,20);
    fill(c2);
    ellipse(X+100, y+50, 50, 50);
    fill(c3);
    triangle(x, y, x+100, y+100, x-50, y+100);
    fill(c2);
    rect(x,y,20,100);
     fill(c1);
    ellipse(X+400, y+20, 50, 50);
     fill(c2);
    triangle(x-200, y+200, x+200, y+10, x-40, y+100);
     
    pushMatrix();
    strokeWeight(7);
    line(x,y,x+70,y+70);
    popMatrix();
  }
  
  x = x+vx;
  if(x>=width)
  {
    x = 0;
  }
  if(y>height/2 || y < 0)
  {
    vy*=0.1;
  }
  angle+=0.01;

   n+=0.01;
}

void keyPressed()
{
  init();
}
