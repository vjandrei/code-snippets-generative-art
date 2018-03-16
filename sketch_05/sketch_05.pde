import codeanticode.syphon.*; // import the library
SyphonServer server; // create a syphon server object

import themidibus.*; //Import the library
MidiBus myBus; // The MidiBus

float midiValue = 0;
float cc[] = new float[256]; // Add this to modifires and see the midi number


ArrayList<Dot> poop = new ArrayList();
int minR=100, maxR=160, N=12 ;

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
  for (int n=0; n<N; n++) { 
    float R = map(n, 0, N, minR, maxR);
    poop.add(new Dot(R, n));
  }
}


// the draw runs all the time
void draw() {
  noFill();// no fill
  background(25);// black bg
  translate(width>>1, height>>1);  
  for (int i=0; i<poop.size (); i++) {
    Dot D = poop.get(i);
    D.show();
    D.R+=0.05f;
    if (D.R >maxR) {
      D.R =minR;
    }
  }
  server.sendScreen(); // now send all that to client(s)
}

class Dot {
  float R ;
  int N;
  Dot(float R, int N) { 
    this.R = R;
    this.N = N;
  }
  void show() { 
    noStroke();
    fill(255);
    for (int i=0; i<360; i+=10) {
      float x = R*sin(radians(i+N*5));
      float y = R*cos(radians(i+N*5));
      float t = map(R, minR, maxR, -1, 180);
      float r = 4*sin(radians(t));
      ellipse(x, y, 2*r, 2*r);
    }
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
