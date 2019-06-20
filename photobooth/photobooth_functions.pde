void addFrame(PImage img) {
  background(255);
  shutter.play();
  println("taking pic " + currentFrame);
  lastMillis = millis();
  frames[currentFrame] = img;
  currentFrame++;
}

// buttons
public void takePicture() {
  println("takePicture button clicked");
  addFrame(cam.get());
  cp5.getController("takePicture").hide();
}
public void printPhoto() {
  println("printPhoto button clicked");
  currentKinegram.save("lastImage.png");
  cp5.getController("printPhoto").setLabel("Printing... please wait until done");
  printImage("/Users/mithruvigneshwara/Desktop/residentsshow/photobooth/lastImage.png");
  lastMillis = millis();
  currentMask.save("lastMask.png");
}
public void restart() {
  println("restart button clicked");
  cp5.getController("printPhoto").hide();
  cp5.getController("restart").hide();
  cp5.getController("takePicture").show();
  cp5.getController("printPhoto").setLabel("Print!");
  SHOWMASK = false;
  currentKinegram = null;
}
