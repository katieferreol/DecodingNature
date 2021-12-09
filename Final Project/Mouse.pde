class Mouse extends Animal {
  int diameter = 6;
  PImage mouse = loadImage("mouse.png");
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

    //reproduction
    if (mouse1.size() < 20) {
      offspring += 0.01;
      if (offspring > 6) {
        offspring = 0;
        mouse1.add(new Mouse(random(100, width), random(100, height)));
      }
    }
    
    //prevents the mouse population from dying to ensure looping during showcase
    if (mouse1.size() < 1) {
      mouse1.add(new Mouse(random(100, width), random(100, height)));
    }
  }

  void display() {
    fill(170);
    image(mouse, x, y, 70, 50);
  }

  Mouse(float x, float y) {
    super(x, y);
    numberofPreys1++;
  }
}
