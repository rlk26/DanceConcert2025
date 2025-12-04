

//declare the class
  //add variable for position, width, its thickness(Drag) and height
  
  class Fluid{
    
  float x,y,w,h,c;
  
  //define constructor function w paramters position and size
  Fluid(float xIn, float yIn, float wIn, float hIn, float cIn)
  {
    x = xIn;
    y = yIn;
    w = wIn;
    h = hIn;
    c = cIn;
    
    //In paramter passing in the class constructor, placeholder varriable
  }
  
  //display
  
  void display1()
  {
    fill(0,0,0,100);
    rect(x,y,w,h);
  }
  
  }
