import processing.video.*;
Capture video;

ArrayList<Eagle> eagle1 = new ArrayList<Eagle>();
ArrayList<Fox> fox1 = new ArrayList<Fox>();
ArrayList<Mouse> mouse1 = new ArrayList<Mouse>();
PImage bg;
PImage mousebutton;
PImage foxbutton;
PImage eaglebutton;

int survivalSeconds = 60;
int numberofPreys1 = 0;
int rate = 60;

int miceEaten = 0;
int foxesEaten = 0;
int eaglesDied = 0;

void setup() {
  size(1200, 700);

  bg = loadImage("bg.jpg");
  mousebutton = loadImage("mousebutton.png");
  foxbutton = loadImage("foxbutton.png");
  eaglebutton = loadImage("eaglebutton.png");

  mouse1.add(new Mouse(width/4, height/4));
  mouse1.add(new Mouse(3*width/4, height/4));
  mouse1.add(new Mouse(3*width/4, 3*height/4));
  mouse1.add(new Mouse(width/4, 3*height/4));

  fox1.add(new Fox(random(width), random(height)));
  fox1.add(new Fox(random(width), random(height)));
  fox1.add(new Fox(random(width), random(height)));

  eagle1.add(new Eagle(random(width), random(height)));

  //accessing the camera
  String[] cameras = Capture.list();
  printArray(cameras);
  video = new Capture(this, cameras[0]);

  //accessing the second window
  String[] args = {"TwoFrameTest"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
}

public void captureEvent(Capture video) {
  video.read();
}

void draw() {
  frameRate(rate);
  background(bg);
  textSize(30);

  //instructions showing what keys to press
  image(mousebutton, 50, 60, 200, 45);
  image(foxbutton, 265, 60, 180, 45);
  image(eaglebutton, 470, 60, 200, 45);
  text("Mice Eaten: " + miceEaten + "      " + "Foxes Eaten: " + foxesEaten + "      " + "Eagles Died: " + eaglesDied, 350, 40);

  //Mouse initialization
  for (int i = 0; i < mouse1.size(); i++) {
    Mouse p = mouse1.get(i);
    p.update();
    p.display();

    for (int j = 0; j < fox1.size(); j++) {
      Fox pred = fox1.get(j);

      if (dist(p.x, p.y, pred.x, pred.y) < 50) {
        mouse1.remove(i);
        p.newMouse();
        miceEaten++;
        pred.foodCount++;
        break;
      }
    }
  }

  // Fox initialization
  for (int i = 0; i < fox1.size(); i++) {
    Fox pred = fox1.get(i);
    pred.update();
    pred.display();
  }

  // Eagle initialization
  for (int i = 0; i < eagle1.size(); i++) {
    Eagle pred2 = eagle1.get(i);
    if (pred2.secondsToDie < 0) {
      eagle1.remove(i);
      eaglesDied++;
      for (int count = 0; count < 3; count++) {
        mouse1.add(new Mouse(pred2.x + random(-2, 2), pred2.y + random(-2, 2)));
      }
    }

    pred2.update();
    pred2.followFox();
    pred2.eagleTimer();

    for (int j = 0; j < fox1.size(); j++) {
      Fox pred1 = fox1.get(j);

      if (dist(pred1.x, pred1.y, pred2.x, pred2.y) < 50) {
        fox1.remove(j);
        foxesEaten++;
        pred1.newFox();
        pred2.foodCount++;
        pred2.secondsToDie = survivalSeconds;
      }
    }
  }

  //accessing color tracker and add a new animal
  for (int i = 0; i < 1; i++) {
    Mouse m = mouse1.get(i);
    ///m.addMouse();
    m.colorMouse();
    m.addnewMouse();
    Fox f = fox1.get(i);
    //f.addFox();
    f.colorFox();
    f.addnewFox();
    Eagle e = eagle1.get(i);
    //e.addEagle();
    e.colorEagle();
    e.addnewEagle();
  }
}
