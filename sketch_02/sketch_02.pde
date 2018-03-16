import codeanticode.syphon.*; // import the library
SyphonServer server; // create a syphon server object

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

float x = 1;
float targetx = 60;
float adjust = 1;
float midiValue = 0;
float cc[] = new float[256]; // Add this to modifires and see the midi number

void settings() {
  size(1280,720, P3D); // set the size and the renderer
  PJOGL.profile=1;
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
}


// the setup runs once
void setup() {
  // Create syhpon server to send frames out to other client(s)
  server = new SyphonServer(this, "Processing Syphon");
  smooth();
  // Add delov this
  
}


// the draw runs all the time
void draw() {
  background(0);
  x = (1-adjust) * x + (adjust) * cc[14];
  ellipse(width/2, height/2, map(x, 48, 72, 2, 400), map(x, 48, 72, 2, 400));
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
