class Enemy {

  private PImage enemy1;
  private PImage enemy2;
  private PImage enemy3;
  private int x;
  private int y;
  private int enemyWidth;
  private int enemyHeight;
  private int speed;
  private int hp;

  public Enemy(int x, int y, int speed, int hp) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.hp = hp;
    this.enemy1 = loadImage("enemy_1.png");
    this.enemy2 = loadImage("enemy_2.png");
    this.enemy3 = loadImage("enemy_3.png");
    enemyWidth =  enemy1.width;
    enemyHeight = enemy1.height;
  }

  void draw() {
    move();
    pushMatrix();
    translate(x, y);
    switch(hp) {
    case 1:
      image(enemy1, -enemyWidth/2, -enemyHeight/2, enemyWidth, enemyHeight);
      break;
    case 2:
      image(enemy2, -enemyWidth/2, -enemyHeight/2, enemyWidth, enemyHeight);
      break;
    case 3:
      image(enemy3, -enemyWidth/2, -enemyHeight/2, enemyWidth, enemyHeight);
      break;
    }
    popMatrix();
  }

  void move() {
    x -= speed;
    //Enemys respawnen random
    if (x <= -enemyWidth/2) {
      x = width + enemyWidth/2;
      y = (int)random(height);
    }
  }

  //getteR methoden für Werteübergabe an Kollisionsabfrage
  public int getX() {
    return x -enemyWidth/2;
  }

  public int getY() {
    return y -enemyHeight/2;
  }

  public int getX2() {
    return enemyWidth;
  } 

  public int getY2() {
    return enemyHeight;
  }

  public void setHp(int hp) {
    this.hp = hp;
  }

  public int getHp() {
    return hp;
  }
}