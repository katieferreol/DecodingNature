class Eagle extends Animal {
  float angle = 0;
  int length = 40;
  int foodDistance = 10000;
  float angleOfPrey = 0;
  float secondsToDie = survivalSeconds;
  int foodCount = 0;
  int foodNeed = 5;
  PImage eagle = loadImage("eagle.png");

  color eaglecolor = color(191,146,68);
  float eaglethreshold = 20;
  boolean newEagle = false;

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

  void colorEagle() {
    eaglethreshold = 20;

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
        float r2 = red(eaglecolor);
        float g2 = green(eaglecolor);
        float b2 = blue(eaglecolor);

        float d = distSq(r1, g1, b1, r2, g2, b2);

        if (d < eaglethreshold*eaglethreshold) {
          avgX += x;
          avgY += y;
          count++;
        }
      }
    }

    if (count > 0) {
      avgX = avgX / count;
      avgY = avgY / count;
      newEagle = true;
      count = 0;
    } else {
    }
  }

  float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
    float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
    return d;
  }

  void addnewEagle() {
    //println(newEagle);
    if (newEagle == true && frameCount % 100 == 0) {
      eagle1.add(new Eagle(random(width), random(height)));
      println("New eagle added");
    }
    newEagle = false;
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
