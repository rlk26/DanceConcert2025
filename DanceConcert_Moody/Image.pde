//class for images
//display images and clear rectangle that increases in opacity and becomes black
class Image
{

  int z = 255;
  int vz = -5;
  int xSize;
  int ySize;
  int xPos;
  int yPos;
  PImage image;
  String name;
  int bounceCount = 0;
  
  

//initialize function(reset bouncecount back to zero) --> call initialize from constructor


  Image(String imageName)
  {
   println(width, height);
    name = imageName;
   
    image = loadImage(name);
    initialize();
        
  }

  
  void display()
  {

    image(image, xPos, yPos);

    fill(0, 0, 0, z);
    rect(xPos, yPos, xSize, ySize);
    //if(frameCount%9 == 0)
    if(frameCount%5 == 0)
    {
     z+=vz;
    }
    if(z < 0)
    {
       z = 0;
       vz *= -1;
       bounceCount += 1;
    }
    
     if(z > 255)
    {
      z = 255;
      vz *= -1;
      bounceCount += 1;
    }

  }
  

 void initialize()
  {
    bounceCount = 0;
    
    xSize = (int)random(200, width); 
    ySize = (int)random(200, height); 
    xPos = (int)random(0, width - xSize); 
    yPos = (int)random(0, height - ySize);
    
    image.resize(xSize, ySize);
    
    z = 255;
    vz = -5;
  }
  
  boolean isDead()
  {
   return bounceCount >= 2; 
  }
    
}

//void Setup()
//{
  
  //image1 = loadImage("horse.png");
  //image1.resize(xSize, ySize);
  //image2 = loadImage("branch.png");
  //image2.resize(xSize, ySize);
//image3 = loadImage("groupOfHorses.png");
  //image3.resize(xSize, ySize);
  //image4 = loadImage("HorseCloseUp");
  //image4.resize(xSize, ySize);
  //image5 = loadImage("fullHorse");
  //image5.resize(xSize, ySize);
  //image6 = loadImage("boat");
  //image6.resize(xSize, ySize);
  
//}

//void Display()
//{
  //image(image1, xPos, yPos);
  //image(image2, xPos, yPos); 
  //image(image3, xPos, yPos);
  //image(image4, xPos, yPos);
  //image(image5, xPos, yPos);
  //image(image6, xPos, yPos);
//}
