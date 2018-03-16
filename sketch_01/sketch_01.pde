
import codeanticode.syphon.*; // import the library
SyphonServer server; // create a syphon server object

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

float detail = 20;
float maxSize = 400;
float f = 0;
float x = 60;
float midiValue = 0;
float adjust = 0.1;
float cc[] = new float[256];

void settings() {
  size(1280,720, P3D); // set the size and the renderer
  PJOGL.profile=1;
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
}


void setup(){
  strokeWeight(4);
  noFill();
  server = new SyphonServer(this, "Processing Syphon");
}

void draw(){
  background(0);
  stroke(255);
  
  int channel = 0;
  int pitch = 64;
  int velocity = 127;
  
  translate(width/2, height/2);
  println(f);
  rotateX(cc[18]);
  rotateY(cc[19]);
  
  for (float i = f; i < TWO_PI+f; i+= TWO_PI / detail) {
    pushMatrix();
    translate(0, 0, cos(i) * cc[17]);
    stroke(max(20 + cos(i) * 150,0));
    //ellipse(0, 0, cc[14] * 1000, cc[15] * 1000);
    ellipse(0, 0, cc[14] * 1000 + sin(i) * maxSize, cc[15] * 1000 + sin(i) * maxSize);
    popMatrix();
  }
  f+= 0.01f;
  server.sendScreen(); // now send all that to client(s)
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  cc[number] = map(value, 0, 127, 0, 1); 
  midiValue = value;
}
