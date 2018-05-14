class Kinegram {
  int imageWidth, imageHeight, slitWidth;
  PImage[] frames;
  PImage kinegramImage;
  Kinegram(int w, int h, int sW, PImage[] imgArray) {
    this.imageWidth = w;
    this.imageHeight = h;
    this.slitWidth = sW;
    this.frames = imgArray;
    for (int i = 0; i < this.frames.length; i++) {
      this.frames[i].loadPixels();
    }
  }

  PImage generateImage() {
    this.kinegramImage = createImage(imageWidth, imageHeight, ARGB);
    this.kinegramImage.loadPixels();
    for (int i = 0; i < (this.kinegramImage.pixels.length); i++) {
      //println(((i % mixedImage.width) / eachSlitWidthInPixels) % frames.length);
      this.kinegramImage.pixels[i] = this.frames[((i % this.kinegramImage.width) / this.slitWidth) % this.frames.length].pixels[i / (this.kinegramImage.width / this.imageWidth)];
      //mixedImage.pixels[i] = frames[(i%mixedImage.width)%frames.length].pixels[i];
    }
    this.kinegramImage.updatePixels();
    return this.kinegramImage;
  }

  void drawSlits(int x, int y) {
    noStroke();
    pushMatrix();
    translate(x, y);
    fill(0);
    for (int i = -this.kinegramImage.width/2; i < this.kinegramImage.width/2; i += (this.slitWidth * this.frames.length)) {
      rect(i, 0, slitWidth * (this.frames.length - 1), this.kinegramImage.height);
    }
    popMatrix();
  }
}
