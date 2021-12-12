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

  Fox(float x, float y) {
    super(x, y);
  }

  Fox() {
    super(random(5, height), random(5, height));
  }
}
