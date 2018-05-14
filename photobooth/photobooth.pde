// illusions explained from this link:
//http://www.slate.com/blogs/bad_astronomy/2013/12/15/optical_illusion_motion_using_vertical_slits.html

import processing.video.*;

Capture cam;

PImage frames[] = new PImage[4];
PImage mixedImage, gif;
boolean VIEWMODE = true;

Kinegram k, photoGif;

int eachSlitWidthInPixels = 1;

int currFrame = 0;

void setup() {
  size(800, 800);
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[3]);
    cam.start();
  }      
  for (int i = 0; i < frames.length; i++) {
    frames[i] = loadImage("data/Ball bounce" + i + ".png");
  }

  k = new Kinegram(frames[0].width, frames[0].height, eachSlitWidthInPixels, frames);
  mixedImage = k.generateImage();
}

void draw() {
  background(255);
  image(mixedImage, 0, 0);

  if (!VIEWMODE)
    photoGif.drawSlits(mouseX, mouseY);
}


void mouseClicked() {
  VIEWMODE = !VIEWMODE;
}

void keyReleased() {
  println(key);
  switch(key) {
  case ' ':
    photoGif = new Kinegram(cam.width, cam.height, eachSlitWidthInPixels, takePictures(4, 1000));
    mixedImage = photoGif.generateImage();
    break;
  }
}
