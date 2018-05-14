
PImage[] takePictures(int numberOfPics, int delayBetweenPics) {
  int currMillis = millis();
  //int currFrame = 0;
  PImage f[] = new PImage[numberOfPics];

  for (int currFrame = 0; currFrame < numberOfPics; currFrame++ ) {
    if (cam.available() == true) {
      println("taking picture " + currFrame);
      cam.read();
      f[currFrame] = cam.get();
      delay(delayBetweenPics);
    }
  }
  return f;
}
