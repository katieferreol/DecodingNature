class Eagle extends Animal {
  float angle = 0;
  int length = 40;
  int foodDistance = 10000;
  float angleOfPrey = 0;
  float secondsToDie = survivalSeconds;
  int foodCount = 0;
  int foodNeed = 5;
  PImage eagle = loadImage("eagle.png");


  void update() {
    secondsToDie -= 1.0/rate;
    
    //when eagle eats fox, it regenerates timer
    if (foodCount >= foodNeed) {
      foodCount = 0;
      eagle1.add(new Eagle(x+random(-150, 150), y+random(-400, 400)));
    }
    
    //seconds the eagle has to eat a fox before it dies
    if (eagle1.size() > 0) {
      survivalSeconds = 60/eagle1.size();
    } else {
      survivalSeconds = 60;
    }

    //prevents the eagle population from dying to ensure looping during showcase
    if (eagle1.size() < 1) {
      eagle1.add(new Eagle(x+random(-150, 150), y+random(-400, 400)));
    }
  }

  void followFox() {
    if (x+length >= width || y+length >= height || x-length <= 0 || y-length <= 0) {
      angle += 180;
    }
    translate(x, y);
    if (fox1.size() > 0) {
      Fox pred1 = fox1.get(0);
      angleOfPrey = solveAngle((pred1.x-x) / dist(0, 0, x-pred1.x, y-pred1.y), (y-pred1.y) / dist(0, 0, x-pred1.x, y-pred1.y));
      angle = angleOfPrey;
    }
    x += cos(radians(angle))/1.5;
    y -= sin(radians(angle))/1.5;
    image(eagle, 0, 0, 160, 130);
  }
 
 void eagleTimer() {
    translate(-x, -y);
    fill(0);
    textAlign(CENTER);
    textSize(20);
    text(secondsToDie, x, y);
  }
  
  void addEagle() {
    if (keyPressed) {
      if (key == 'e' || key == 'E') {
        eagle1.add(new Eagle(random(width), random(height)));
      }
    }
  }

  Eagle(float x, float y) {
    super(x, y);
    angle = random(0, 360);
  }

  float solveAngle(float cos, float sin) {
    if (sin > 0) {
      return degrees(acos(cos));
    } else {
      return 360-degrees(acos(cos));
    }
  }
}
