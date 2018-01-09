class Highscore{
  
  private PImage highscoreImage;
  private HeroShip hero;

  public Highscore(HeroShip hero) {
    this.highscoreImage = loadImage("highscore.png");
    this.hero = hero;
  }

  void draw() {
    image(highscoreImage, 0, 0, width, height);
    fill(255,255,255);
    textSize(70);
    text("YOUR SCORE",80,100);
    textSize(50);
    textAlign(CENTER, CENTER);
    text(hero.getScore(),400,200);
    textAlign(LEFT);
    textSize(12);
    text("[n] New Game",10,height - 15);
  }
}