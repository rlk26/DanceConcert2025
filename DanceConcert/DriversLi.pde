class DriversLi extends Scene{
  ArrayList<Star> stars;
  ArrayList<StopSign> stopSigns;
  ArrayList<RedLight> redLights;
  boolean showRedLights = false;
  DriversLi (){
    smooth();
  

    stars = new ArrayList<Star>();
    for (int i = 0; i < 300; i++) {
      stars.add(new Star());
    }
  

    stopSigns = new ArrayList<StopSign>();
    for (int i = 0; i < 5; i++) {
      stopSigns.add(new StopSign());
    }
  
    // Smaller, more artistic red lights
    redLights = new ArrayList<RedLight>();
    for (int i = 0; i < 10; i++) {
      redLights.add(new RedLight());
    }
    }
  void run(){
    for (int i = 0; i < height; i++) {
      float inter = map(i, 0, height, 0, 1);
      color c = lerpColor(color(5, 5, 30), color(0, 0, 10), inter);
      stroke(c);
      line(0, i, width, i);
    }
  
  
    for (Star s : stars) {
      s.update();
      s.display();
    }
    if(showRedLights == true) { 
      for (RedLight light : redLights) {
      light.update();
      light.display();
     }
    }
  }
  void keyPressed(){
    if (key == 'r' || key == 'R') {
    println("R WAS PRESSED");
    showRedLights = !showRedLights;
   
  }
    
  else if (key == 's' || key == 'S') {
    println("S WAS PRESSED");
     for (StopSign sign : stopSigns) {
     sign.update();
     sign.display();
  }
      
   }
  }
}
