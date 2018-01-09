class Laser {

  private int hp;
  private int x;
  private int y;
  private int speed;
  private final int WIDTH = 7;
  private final int HEIGHT= 3;

  public Laser(int x, int y, int speed) {
    hp = 1;
    this.x = x; 
    this.y = y; 
    this.speed = speed;
  }

  void draw() {
    move();
    rect(x, y, WIDTH, HEIGHT);
  }

  void move() {
    x += speed; 
    if( x > width || x < -WIDTH){
      hp = 0;
    }
  }

  boolean collide(int enemyX, int enemyY, int enemyWidth, int enemyHeight) {
    if (enemyX <= x + WIDTH && enemyX + enemyWidth >= x && enemyY <= y + HEIGHT && enemyY + enemyHeight >= y) {
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
}