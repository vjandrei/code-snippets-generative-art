import codeanticode.syphon.*; // import the library
SyphonServer server; // create a syphon server object

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

float midiValue = 0;
float cc[] = new float[256]; // Add this to modifires and see the midi number

Particle[] p = new Particle[800];
int diagonal;

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
  // Add delov this
  for (int i = 0; i<p.length; i++) {
    p[i] = new Particle();
    p[i].o = random(1, random(1, width/p[i].n));
  }
  size(1280, 720);
  diagonal = (int)sqrt(width*width + height * height)/2;
  background(0);
  noStroke();
  fill(255);
  frameRate(30);
}

float rotation = 0;

// the draw runs all the time
void draw() {
  if (!mousePressed)  {
    background(2);
  }
  
  

  translate(width/2, height/2);
  rotation-=0.002;
  rotate(cc[14] * 2);

  for (int i = 0; i<p.length; i++) {
    p[i].draw();
    if (p[i].drawDist()>diagonal) {
      p[i] = new Particle();
    }
  }
  server.sendScreen(); // now send all that to client(s)
}

class Particle {
  float n;
  float r;
  float o;
  int l;
  Particle() {
    l = 1;
    n = random(1, width/2);
    r = random(0, TWO_PI);
    o = random(1, random(1, width/n));
  }

  void draw() {
    l++;
    pushMatrix();
    rotate(r);
    translate(drawDist(), 0);
    fill(255, min(l, 255));
    ellipse(0, 0, width/o/8, width/o/8);
    popMatrix();

    o-=0.07;
  }
  float drawDist() {
    return atan(n/o)*width/HALF_PI;
  }
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
