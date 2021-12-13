class Fox extends Animal {
  int diameter = 10;
  float speedX = 1;
  float speedY = 2;
  int movementCountdown = 0;
  int foodCount = 0;
  int foodNeed = 5;
  PImage fox = loadImage("fox.png");
  PImage foxworried = loadImage("foxworried.png");
  PImage foxwarning = loadImage("foxwarning.png");

  color foxcolor = color(184,75,113);
  float foxthreshold = 20;
  boolean newFox = false;

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

    if (foodCount >= foodNeed) {
      fox1.add(new Fox(x+random(-2, 2), y+random(-2, 2)));
      foodCount = 0;
    }
  }

  void display() {
    image(fox, x, y, 110, 90);
    if ((foxesEaten > 10) && (eaglesDied < foxesEaten/5)) {
      image(foxworried, x, y, 110, 90);
      image(foxwarning, 970, 20, 180, 180);
    }
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text(foodCount, x-5, y-5);
  }

  //prevents the fox population from dying to ensure looping during showcase
  void newFox() {
    if (fox1.size() < 1) {
      fox1.add(new Fox(random(width), random(height)));
    }
  }

  void addFox() {
    if (keyPressed) {
      if (key == 'f' || key == 'F') {
        fox1.add(new Fox(random(width), random(height)));
      }
    }
  }

  void colorFox() {
    foxthreshold = 20;

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
        float r2 = red(foxcolor);
        float g2 = green(foxcolor);
        float b2 = blue(foxcolor);

        float d = distSq(r1, g1, b1, r2, g2, b2);

        if (d < foxthreshold*foxthreshold) {
          avgX += x;
          avgY += y;
          count++;
        }
      }
    }

    if (count > 0) {
      avgX = avgX / count;
      avgY = avgY / count;
      newFox = true;
      count = 0;
    } else {
    }
  }

  float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
    float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
    return d;
  }

  void addnewFox() {
    //println(newFox);
    if (newFox == true && frameCount % 100 == 0) {
      fox1.add(new Fox(random(width), random(height)));
      println("New fox added");
    }
    newFox = false;
  }

  Fox(float x, float y) {
    super(x, y);
  }

  Fox() {
    super(random(5, height), random(5, height));
  }
}
