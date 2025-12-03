
//int y = height/2;


int z = 255;
int vz = -5;
boolean overlap = true;
boolean allBlack = false;
ArrayList<Image> images= new ArrayList<Image>();
//Image current;
ArrayList<Image> currentImage = new ArrayList<Image>();





void setup()
{
   //size(500, 500);
   fullScreen();
   
Image image1 = new Image("horse.png");
//Image image2 = new Image("branch.png");
//Image image3 = new Image("herd.png");
//Image image4 = new Image("whiteHorse.png");
Image image5 = new Image("fullHorse.png");
//Image image6 = new Image("boat.png");
Image image7 = new Image("moon.png");
Image image8 = new Image("woods.png");
Image image9 = new Image("MoodyForest.png");
Image image10 = new Image("house.png");
Image image11 = new Image("horseWalking.png");
Image image12 = new Image("hand.png");
Image image13 = new Image("flower.png");
Image image14 = new Image("aloneBranch.png");
Image image15 = new Image("bird.png");
Image image16 = new Image("clouds.png");
Image image17 = new Image("lighthouse.png");
Image image18 = new Image("pebbles.png");
  
  images.add(image1);
  //images.add(image2);
  //images.add(image3);
  //images.add(image4);
  images.add(image5);
  //images.add(image6);
  images.add(image7);
  images.add(image8);
  images.add(image9);
  images.add(image10);
  images.add(image11);
  images.add(image12);
  images.add(image13);
  images.add(image14);
  images.add(image15);
  images.add(image16);
  images.add(image17);
  images.add(image18);
  
 chooseNew();
 
 
 
}




 void chooseNew()
{
 
    int r = (int)random(0,13);
    Image temp = images.get(r);
    temp.initialize();
    currentImage.add(temp);
    
    /* for(int n = 0; n <=currentImage.size(); n++)
   {
     if((n + 1).initialize() == n.initialize())
     {
       (n+1).initialize()
     }
   } */
   
}
  


void drawEverything()
{
  background(0);
  
   //chooseNew();
    
    for(Image image: currentImage)
    {
      image.display();
    }
    
    if(frameCount%500 == 0)
    {
      chooseNew();
    }
    
    for(int i = currentImage.size()-1; i>=0; i--)
    {
      if(currentImage.get(i).isDead())
      {
        currentImage.remove(i);
      }
    }
    
  
    
 }
 
 void draw()
 {
   if(allBlack)
   {
     background(0);
   }
   else
   {
     drawEverything();
   }
 }
 
 void keyPressed()
 {
   if(key == 'b')
   {
     allBlack = true;
   }
   if(key == 'v')
   {
     allBlack = false;
   }
   if(key = 'g')
   {
     background(0);
    images.get(image7);
   }
   
 }
 
 
 
/* void keyPressed()
 {
   if(keyCode = 'b')
   {
   //=make all images black
   }
   
   if(keyCode = 'g')
   {
     image7.display();
   }
 } */
 

  
 /*void keyPressed()
 {
    if(keyCode == 'B')
    {
      chooseNew();
    }
 } */
  
    
  
  //image
  //fill(255, 0, 0, z);
  //rect(0, 0, width, height);

  //if(frameCount%1 == 0)
  //{
    //z += vz;
   
 // }
  
  //if(z < 0 || z > 255)
  //{
    //vz *= -1;
  //}
  
  
//}
 

  
