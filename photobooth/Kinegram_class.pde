class Kinegram {
  int imageWidth, imageHeight, slitWidth;
  PImage[] frames;
  PImage kinegramImage, maskImage;
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
      this.kinegramImage.pixels[i] = this.frames[((i % this.kinegramImage.width) / this.slitWidth) % this.frames.length].pixels[i / (this.kinegramImage.width / this.imageWidth)];
    }
    this.kinegramImage.updatePixels();
    println(this.frames.length);
    return this.kinegramImage;
  }

  PImage generateMask() {
    this.maskImage = createImage(imageWidth, imageHeight, ARGB);
    this.maskImage.loadPixels();
    for (int i = 0; i < (this.maskImage.pixels.length); i++) {
      if (((i % this.kinegramImage.width) / this.slitWidth) % this.frames.length != 0) {
        this.maskImage.pixels[i] = color(0, 0, 0);
      }
    }
    this.maskImage.updatePixels();
    return this.maskImage;
  }
}
