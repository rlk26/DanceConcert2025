//b//int x = width/2;
//int y = height/2;


int z = 255;
int vz = -5;
ArrayList<Image> images= new ArrayList<Image>();
Image current;





void setup()
{
   //size(500, 500);
   fullScreen();
   
Image image1 = new Image("horse.png");
Image image2 = new Image("branch.png");
Image image3 = new Image("herd.png");
Image image4 = new Image("whiteHorse.png");
Image image5 = new Image("fullHorse.png");
Image image6 = new Image("boat.png");
Image image7 = new Image("moon.png");
Image image8 = new Image("woods.png");
Image image9 = new Image("MoodyForest.png");
Image image10 = new Image("house.png");
Image image11 = new Image("horseWalking.png");
 
  
  images.add(image1);
  images.add(image2);
  images.add(image3);
  images.add(image4);
  images.add(image5);
  images.add(image6);
  images.add(image7);
  images.add(image8);
  images.add(image9);
  images.add(image10);
  images.add(image11);
  
 chooseNew();
  
}


 void chooseNew()
{
  int r = (int)random(0, 11);
  current = images.get(r);
  current.initialize();
  
}
  


void draw()
{
  background(0);

    current.display();
    
    //if(frameCount%1000 == 0)
    if(current.isDead() == true)
    {
      chooseNew();
    }
    
 }
 

  
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
 

  
