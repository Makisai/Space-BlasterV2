class Boss {

  private PImage boss;
  private int x;
  private int y;
  private float bossWidth;
  private float bossHeight;
  private int hp;
  private final int MOVE_SPEED = 2;
  private boolean moveDown;
  private Level level;


  public Boss(int x, int y, int hp, Level level) {
    this.x = x;
    this.y = y;
    this.hp = hp;
    this.level = level;
    this.boss = loadImage("boss.png");
    this.bossWidth = boss.width/1.3;
    this.bossHeight = boss.height/1.3;
    this.moveDown = true;
  }

  void draw() {
    if (getHp() > 0) {
      move();
      pushMatrix();
      translate(x, y);
      image(boss, 0, 0, bossWidth, bossHeight);
      noFill();
      stroke(255, 0, 0);
      //rect(0, 0, bossWidth, bossHeight);
      popMatrix();
    }
  }

  void move() {
    if (moveDown) {
      y+= MOVE_SPEED;
      if (y >= height - bossHeight) {
        moveDown = false;
        level.addBossLaser((int)x, (int)(y + random(bossHeight)) );
      }
    } else {
      y-= MOVE_SPEED;
      if (y <= 0) {
        moveDown = true;
      }
    }
    if (x > width - bossWidth) {
      x-= MOVE_SPEED;
    }
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y ;
  }

  public int getX2() {
    return (int)bossWidth;
  }

  public int getY2() {
    return (int)bossHeight;
  }

  public void setHp(int hp) {
    this.hp = hp;
  }

  public int getHp() {
    return hp;
  }
}