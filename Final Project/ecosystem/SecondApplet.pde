//Class to access a second camera
public class SecondApplet extends PApplet {

  public void settings() {
    size(640, 360);
    video.start();
  }

  public void draw() {
    video.loadPixels();
    image(video, 0, 0);
  }
}
