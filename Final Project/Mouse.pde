class Mouse extends Animal {
  int diameter = 6;
  PImage mouse = loadImage("mouse.png");
  PImage mouseworried = loadImage("mouseworried.png");
  PImage mousewarning = loadImage("mousewarning.png");
  float speedX = 1;
  float speedY = 2;
  int movementCountdown = 0;

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

  Mouse(float x, float y) {
    super(x, y);
    numberofPreys1++;
  }
}
