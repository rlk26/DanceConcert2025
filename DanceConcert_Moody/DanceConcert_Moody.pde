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
  int r = (int)random(0, 14);
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
 

  
