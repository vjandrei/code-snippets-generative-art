import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import themidibus.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sketch_01 extends PApplet {

 //Import the library

MidiBus myBus; // The MidiBus

float detail = 20;
float maxSize = 400;
float f = 0;
float x = 60;
float midiValue = 0;
float adjust = 0.1f;
float cc[] = new float[256];


public void setup(){
  
  //background(000);
  noFill();
  strokeWeight(4);
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
}

public void draw(){
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
}

public void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
  cc[number] = map(value, 0, 127, 0, 1); 
  midiValue = value;
}
  public void settings() {  size(1280,720, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_01" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
