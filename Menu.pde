class Menu {

  private PImage menuImage;
  private PFont font;

  public Menu() {
    this.menuImage = loadImage("start.png");
    font = createFont("PressStart2P-Regular.ttf", 12);
    textFont(font);
  }

  void draw() {
    image(menuImage, 0, 0, width, height);
    fill(255,255,255);
    textSize(25);
    text("SPACE",45,50);
    text("BLASTER",75,70);
    textSize(12);
    text("Press [c] to instert coin",width/2,height/2);
    
  }
}