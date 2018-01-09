class HeroShip {
  private PImage hero; 
  private int moveSpeed;
  //koordinate an denen das PImage geladen wird
  private int x;
  private int y;
  private int heroWidth;
  private int heroHeight;
  private int hp;
  private int score;
  
  public HeroShip(int x, int y, int speed, PImage hero) {
    this.hero = hero;
    this.moveSpeed = speed;
    this.x = x;
    this.y = y;
    this.score = 0;
    //Skalierung des Bilds auf 1/8 der Originalgröße
    heroWidth = hero.width;
    heroHeight = hero.height;
    hp = 5;
  }

  void draw() {
    if ( x < 100) {
      x+=moveSpeed; 
    }
    pushMatrix();
    translate (x, y);
    //punkt an dem er anfängt zu zeichnen von oben links nach mittelpunkt vom bild verschoben
    image(hero, -heroWidth/2, -heroHeight/2, heroWidth, heroHeight);
    noFill();
    stroke(255, 0, 0);
    popMatrix();
  }

  void up() {
    y -= moveSpeed;
    if ( y < 0 + heroHeight/2 ) {
      y = 0 + heroHeight/2;
    }
  }

  void down() {
    y +=moveSpeed;
    if (y > height - heroHeight/2) {
      y = height - heroHeight/2;
    }
  }

  public int getX() {
    return x -heroWidth/2;
  }

  public int getY() {
    return y -heroHeight/2;
  }

  public int getCenterX() {
    return x;
  }

  public int getCenterY() {
    return y;
  }
  
  public int getWidth(){
    return heroWidth;
  }
  
  public int getHeight(){
    return heroHeight;
  }

  boolean collide(int enemyX, int enemyY, int enemyWidth, int enemyHeight) {
    //hitbox rechteck
    //rect(getX(), getY(), heroWidth, heroHeight);
    //rect(enemyX, enemyY, enemyWidth, enemyHeight);
    if (enemyX <= getX() + heroWidth && enemyX + enemyWidth >= getX() && enemyY <= getY() + heroHeight && enemyY + enemyHeight >= getY()) {
      return true;
    } else {
      return false;
    }
  }
  
   public void reduceHp() {
    hp--;
  }

  public int getHp() {
    return hp;
  }
  
  public int getScore(){
    return score;
  }
  
  public void setScore(int score){
    this.score = score;
  }
}