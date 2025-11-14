class Line{
    float angle;
    PVector l;
    
    Line(){
      angle = random(0,2*PI);
      l = PVector.random2D();
    }
    
    void display(){
      line(0,0,l.x,l.y);
    }
    
    void adjust(){
      
    }
}
