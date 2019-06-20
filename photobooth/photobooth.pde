// illusions explained from this link:
//http://www.slate.com/blogs/bad_astronomy/2013/12/15/optical_illusion_motion_using_vertical_slits.html

import processing.video.*;
import processing.sound.*;
import controlP5.*;

ControlP5 cp5;

Capture cam;

PImage currentKinegram, currentMask, liveImage;
PImage frames[];
int currentFrame = 0;
int lastMillis = 0;
boolean SHOWMASK = false;

Kinegram photoGif;

final int eachSlitWidthInPixels = 1; // keeping this constant because usually the masks are pre-printed. This can be changed if you're not printing physical images
final int numOfFrames = 4; 
final int delayAmount = 1000; // time between frames

PFont pfont;

SoundFile shutter;

void setup() {
  size(displayWidth, displayHeight);

  // camera
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, 960, 720, cameras[0]);
    cam.start();
  }

  // kinegrams
  currentKinegram = null; // TODO remove this
  frames = new PImage[numOfFrames];

  //sound file
  shutter = new SoundFile(this, "shutterSound.aiff");

  // controlp5 
  cp5 = new ControlP5(this);
  pfont = createFont("HelveticaNeue-48.vlw", 48, true);
  ControlFont font = new ControlFont(pfont, 241);
  cp5.addButton("takePicture")
    .setPosition((width-cam.width)/2, cam.height+(height-cam.height)/8)
    .setSize(cam.width, cam.height/4)
    .setLabel("Create!")
    .setColorBackground(color(20, 33, 61))
    .setColorForeground(color(252, 163, 17))
    .getCaptionLabel()
    .setFont(font)
    .setSize(48)
    ;

  cp5.addButton("printPhoto")
    .setPosition((width-cam.width)/2, cam.height+(height-cam.height)/8 + cam.height/4)
    .setSize(cam.width/2, cam.height/12)
    .setLabel("Print!")
    .hide()
    .setColorBackground(color(20, 33, 61))
    .setColorForeground(color(252, 163, 17))    
    .getCaptionLabel()
    .setFont(font)
    .setSize(12)
    ;
  cp5.addButton("restart")
    .setPosition(width/2, cam.height+(height-cam.height)/8 + cam.height/4)
    .setSize(cam.width/2, cam.height/12)
    .setLabel("Reset")
    .hide()
    .setColorBackground(color(20, 33, 61))
    .setColorForeground(color(252, 163, 17))
    .getCaptionLabel()
    .setFont(font)
    .setSize(12)
    ;
  println("Ready!");
}

void draw() {
  background(220);
  if (cam.available()) { 
    cam.read();
  } 
  pushMatrix();
  translate( (width-cam.width)/2, (height-cam.height)/8);
  image(cam, 0, 0);
  for (int i = 0; i < frames.length; i++) {
    if (frames[i] != null) {
      image(frames[i], i * cam.width/4, cam.height, cam.width/4, cam.height/4);
    }
  }
  if (currentKinegram != null) {
    image(currentKinegram, 0, 0);
  }
  if (SHOWMASK) {
    image(photoGif.maskImage, mouseX-photoGif.maskImage.width, 0);
  }
  popMatrix();

  if (currentFrame >= numOfFrames) {
    createKinegram();
    currentFrame = 0;
    cp5.getController("printPhoto").show();
    cp5.getController("restart").show();
  }

  if (currentFrame > 0 && abs(millis() - lastMillis) > delayAmount) {
    addFrame(cam.get());
  }
  if (!cp5.getController("printPhoto").getLabel().equals("Print!") && millis() - lastMillis > 15000) {
    cp5.getController("printPhoto").setLabel("Print!");
  }
}

void createKinegram() {
  println("Generating kinegram");
  photoGif = new Kinegram(cam.width, cam.height, eachSlitWidthInPixels, frames);
  currentKinegram = photoGif.generateImage();
  currentMask = photoGif.generateMask();
  println("kinegram ready");
  SHOWMASK = true;
}

void keyReleased() {
  println("Clicked " + key);
  switch(key) {
  case ' ':
    addFrame(cam.get());
    break;
  case 's':
    currentKinegram.save("lastImage.png");
    currentMask.save("lastMask.png");
    break;
  case 'p':
    printImage("/Users/mithruvigneshwara/Desktop/residentsshow/photobooth/lastImage.png");
    break;
  case 'P':
    printImage("/Users/mithruvigneshwara/Desktop/residentsshow/photobooth/lastMask.png");
    break;
  case 'm':
    SHOWMASK = !SHOWMASK;
    break;
  case 'x':
    SHOWMASK = false;
    currentKinegram = null;
    break;
  }
}
