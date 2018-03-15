// illusions explained from this link:
//http://www.slate.com/blogs/bad_astronomy/2013/12/15/optical_illusion_motion_using_vertical_slits.html

// PLAY = 0;
// EDIT = 1;

PImage frames[] = new PImage[4];
PImage mixedImage;
boolean EDIT = true;

int eachSlitWidthInPixels = 1;

int currFrame = 0;

void setup() {
  size(800, 800);

  for (int i = 0; i < frames.length; i++) {
    //frames[i] = loadImage("data/Ball bounce" + i + ".png");
   // frames[i] = loadImage("data/straightLine" + i + ".png");
    frames[i] = loadImage("data/mith" + i + " copy.jpg");
    frames[i].loadPixels();
  }

  mixedImage = createImage(frames[0].width, frames[0].height, ARGB);

  for (int i = 0; i < (mixedImage.pixels.length); i++) {
    println(((i%mixedImage.width)/eachSlitWidthInPixels)%frames.length);
    mixedImage.pixels[i] = frames[((i%mixedImage.width)/eachSlitWidthInPixels)%frames.length].pixels[i/(mixedImage.width/frames[0].width)];
    //mixedImage.pixels[i] = frames[(i%mixedImage.width)%frames.length].pixels[i];
  }
}

void draw() {
  background(255);
  image(mixedImage, 0, 0);
/*
  stroke(0);
  line(0, 0, width, height);
  line(0, height, width, 0);
  */
  if (!EDIT)
   drawSlits(mouseX, 0, eachSlitWidthInPixels, frames.length);
   //drawSingleSlit(mouseX, 0, eachSlitWidthInPixels, frames.length);
}

void drawSingleSlit(int x, int y, int slitWidth, int numberOfFrames) {
  noStroke();

  fill(255);
  rect(0, 0, x- (slitWidth * (numberOfFrames - 1)), height);
  rect(x, 0, width-x, height);
}

void drawSlits(int x, int y, int slitWidth, int numberOfFrames) {
  noStroke();
  pushMatrix();
  translate(x, y);
  fill(255);
  for (int i = -width; i < width; i += (slitWidth * numberOfFrames)) {
    rect(i, 0, slitWidth * (numberOfFrames - 1), height);
  }
  popMatrix();
}

void mouseClicked() {
  EDIT = !EDIT;
}

void keyReleased() {

  println(key);
  currFrame++;
  currFrame%=frames.length;


  //loadPixels();
  /*
    img.loadPixels();
   for (i = 0; i < pixels.length; i++) {
   img.pixels[i] = pixels[i];
   }
   img.updatePixels();
   */
  println(key);

  /*        switch (key) {
   case 'Q':
   image(img, 0, 0);
   console.log(key);
   break;
   case 'S':
   img.loadPixels();
   for (var i = 0; i < img.width; i++) {
   for (var j = 0; j < img.height; j++) {
   img.set(get(i,j));
   }
   }
   img.updatePixels();
   }
   */
}
