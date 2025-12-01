class Moody extends Scene {

  //b//int x = width/2;
  //int y = height/2;


  int z = 255;
  int vz = -5;
  ArrayList<Image> images= new ArrayList<Image>();
  Image current;





  Moody()
  {
    //size(500, 500);

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



  void run()
  {
    background(0);

    current.display();

    //if(frameCount%1000 == 0)
    if (current.isDead() == true)
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
      if (frameCount%5 == 0)
      {
        z+=vz;
      }
      if (z < 0)
      {
        z = 0;
        vz *= -1;
        bounceCount += 1;
      }

      if (z > 255)
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
      ySize = (int)random(200, height/2);
      xPos = (int)random(0, width - xSize);
      yPos = (int)random(0, height/2);

      image.resize(xSize, ySize);

      z = 255;
      vz = -5;
    }

    boolean isDead()
    {
      return bounceCount >= 2;
    }
  }
}
