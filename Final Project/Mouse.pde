class Mouse extends Animal {
  int diameter = 6;
  PImage mouse = loadImage("mouse.png");
  PImage mouseworried = loadImage("mouseworried.png");
  PImage mousewarning = loadImage("mousewarning.png");
  float speedX = 1;
  float speedY = 2;
  int movementCountdown = 0;

  color mousecolor = color(85,68,120);
  float mousethreshold = 20;
  boolean newMouse = false;

  void update() {
    //movement
    if (movementCountdown == 60) {
      movementCountdown = 0;
      speedX = constrain(speedX+random(-1, 1), -2, 2);
      speedY = constrain(speedY+random(-1, 1), -2, 2);
    }
    x += speedX;
    y += speedY;
    //deal with borders of canvas
    if (x-diameter/2 < 0 || x+diameter/2 > width) {
      speedX = -speedX;
    }
    if (y-diameter/2 < 0 || y+diameter / 2 > height) {
      speedY = -speedY;
    }
    movementCountdown++;

    //prevents the mouse population from dying to ensure looping during showcase
    if (mouse1.size() < 1) {
      mouse1.add(new Mouse(random(100, width), random(100, height)));
    }
  }

  void newMouse() {
    if (mouse1.size() < 1) {
      mouse1.add(new Mouse(random(100, width), random(100, height)));
    }
  }

  void addMouse() {
    if (keyPressed) {
      if (key == 'm' || key == 'M') {
        mouse1.add(new Mouse(random(100, width), random(100, height)));
      }
    }
  }

  void display() {
    image(mouse, x, y, 70, 50);
    if ((miceEaten > 30) && (foxesEaten < miceEaten/5)) {
      image(mouseworried, x, y, 70, 50);
      image(mousewarning, 780, 20, 180, 180);
    }
  }

  void colorMouse() {
    mousethreshold = 20;

    float avgX = 0;
    float avgY = 0;
    int count = 0;

    for (int x = 0; x < video.width; x++ ) {
      for (int y = 0; y < video.height; y++ ) {
        int loc = x + y * video.width;
        // What is current color
        color currentColor = video.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        float r2 = red(mousecolor);
        float g2 = green(mousecolor);
        float b2 = blue(mousecolor);

        float d = distSq(r1, g1, b1, r2, g2, b2);

        if (d < mousethreshold*mousethreshold) {
          avgX += x;
          avgY += y;
          count++;
        }
      }
    }

    if (count > 0) {
      avgX = avgX / count;
      avgY = avgY / count;
      newMouse = true;
      count = 0;
    } else {
    }
  }

  float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
    float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
    return d;
  }

  void addnewMouse() {
    //println(newFox);
    if (newMouse == true && frameCount % 100 == 0) {
      mouse1.add(new Mouse(random(width), random(height)));
      println("New mouse added");
    }
    newMouse = false;
  }

  Mouse(float x, float y) {
    super(x, y);
    numberofPreys1++;
  }
}
