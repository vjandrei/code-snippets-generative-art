/**
 * part of the example files of the generativedesign library.
 *
 * shows how to use the mesh class, if you want to define your own forms.
 */


// imports
import themidibus.*; //Import the library
import generativedesign.*;
import processing.opengl.*;

// mesh
MyOwnMesh myMesh;

float midiValue = 0;
float adjust = 0.1;
float cc[] = new float[256];
MidiBus myBus; // The MidiBus

void setup() {
  size(1000,1000,OPENGL);

  // setup drawing style 
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();

  // initialize mesh. class MyOwnMesh is defined below
  myMesh = new MyOwnMesh(this);
  myMesh.setUCount(100);
  myMesh.setVCount(100);
  myMesh.setColorRange(193, 193, 30, 30, 85, 85, 100);
  myMesh.update();
   MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
}


void draw() {
  background(255);

  // setup lights
  colorMode(RGB, 255, 255, 255, 100);
  lightSpecular(255, 255, 255); 
  directionalLight(255, 255, 255, 1, 1, -1); 
  shininess(5.0); 

  // setup view
  translate(width*0.5, height*0.5);
  scale(cc[14]);
  rotateX(radians(10)); 
  rotateY(radians(-10)); 

  // recalculate points and draw mesh
  myMesh.draw();
}



// define your own class that extends the Mesh class 
class MyOwnMesh extends Mesh {
  
  MyOwnMesh(PApplet theParent) {
    super(theParent);
  }

  // just override this function and put your own formulas inside
  PVector calculatePoints(float u, float v) {
    float A = 2/2.0;
    float B = sqrt(2);

    float x = A * (cos(u) * cos(2*v) + B * sin(u) * cos(v)) * cos(u) / (B - sin(2*u) * sin(3*v));
    float y = A * (cos(u) * sin(2*v) - B * sin(u) * sin(v)) * cos(u) / (B - sin(2*u) * sin(3*v));
    float z = B * cos(u) * cos(u) / (B - sin(2*u) * sin(3*v)); 

    return new PVector(x, y, z);
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