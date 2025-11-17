import processing.sound.*;

//This sketch will demo how to use the SOUND LIBRARY
//LIBRARIES are sets of code that can add EXTRA FUNCTIONALITY 
//For example, the SOUND Library has classe and functions for manipulating sound

//To get a LIBRARY in Processing, you first DOWNLOAD it... 
//Using the CONTRIBUTION MANAGER in the "Sketch" menu-->Import Library-->Manage Libraries

//Once you download a LIBRARY, you still need to IMPORT it to your sketch...
//IMPORT using "Sketch menu"-->Import Library
   
//If you go to FILE-->EXAMPLES-->LIBRARIES

//DECLARE a SOUNDFILE object to store a sound file
SoundFile sound;
SoundFile otherSound;

//Declare Waveform object
Waveform waveform;

// Define how many samples of the Waveform you want to be able to read at once
int samples = 100;


void setup(){
  size(400,400);
  //Load the soundfile
  sound = new SoundFile(this, "song.mp3");
  //otherSound = new SoundFile(this, "Explosion37.wav");

  //create the Waveform object with CONSTRUCTOR
  waveform = new Waveform(this, samples);
  waveform.input(sound);
}

void draw(){
   // Set background color, noFill and stroke style
  background(255);
  stroke(0);
  strokeWeight(2);
  /*
  //SoundFile also has functions to manipulate sound
  //we can adjust the VOLUME by adjusting AMPLITUDE
  //map the amplitude to mouse Y position
  float amp = map(mouseY, 0, height, 1, 0);
  //set the amplitude of the soundfile using the amp function
  sound.amp(amp);
  
  //we can adjust speed/frequency/PITCH of the soundfile with the 'rate' function
  //map the rate to the mouse X position (1 is normal speed, >1 is higher pitch, < 1 is lower pitch)
  float rate = map(mouseX, 0, width, 0, 5);
  //use the rate function to alter the playback speed
  sound.rate(rate);
  */
  
  float position = map(sound.position(), 0, sound.duration(), 0, width);
  line(position, 0, position, height);
  fill(0);
  rect(0,0,position,20);

  noFill();
  // Perform the analysis
  waveform.analyze();
   translate(width/2, height/2);
   
  beginShape();
  for(int i = 0; i < samples; i++){
    // Draw current data of the waveform
    // Each sample in the data array is between -1 and +1 
    rotate(PI/3.0);
    vertex(
      //x coordinate of the vertex
      0,
  
      //map(i, 0, samples, 0, width),
      //y coordinate of the vertex (amplitude of the sound)
      map(waveform.data[i], -1, 1, height/2, -height/2 )
    );
  }
  endShape();

}

void keyPressed(){
  //if space is pressed
  if(key == ' '){
    //if the sound is playing
    if(sound.isPlaying()){
      //pause the sound
      sound.pause();
    }else{
      sound.play();
    }
  }
  
  if(keyCode == RIGHT){
    sound.jump(sound.position() + 0.5);
  }else if(keyCode == LEFT){
    sound.jump(sound.position() - 0.5);
  }
}

void mouseClicked(){
  //ADD ANOTHER SOUNDFILE AND MAKE IT PLAY ON A MOUSE CLICK
  //otherSound.play();
}
