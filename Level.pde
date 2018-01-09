import java.util.Iterator;
import ddf.minim.*;
class Level {

  private Starfield theField;
  private FrontStarfield secondField;

  private SpaceGame game;

  private Minim minim;
  private AudioPlayer music;

  private ArrayList<Enemy> baddies;
  private HeroShip hero;
  private ArrayList<Laser> eduard;
  private ArrayList<Laser> bossLaser;

  private Boss boss;

  public Level(HeroShip hero, SpaceGame game) {
    theField = new Starfield( 100, 2 );
    secondField = new FrontStarfield( 30, 5 );

    this.game = game; 

    //Hintergrundmusik
    minim = new Minim (game);
    music = minim.loadFile ("science_blaster.mp3");
    music.play();

    this.hero = hero;
    eduard = new ArrayList<Laser>();
    bossLaser = new ArrayList<Laser>();

    //Enemy(int x, int y, int speed, int hp) 
    baddies = new ArrayList<Enemy>();
    baddies.add(new Enemy(width + 100, 25, 3, 1));
    baddies.add(new Enemy(width + 200, 50, 3, 1));
    baddies.add(new Enemy(width + 300, 75, 3, 1));
    baddies.add(new Enemy(width + 400, 150, 3, 1));
    baddies.add(new Enemy(width + 500, 125, 3, 3));
    baddies.add(new Enemy(width + 700, 100, 3, 1));
    baddies.add(new Enemy(width + 900, 50, 3, 2));
    baddies.add(new Enemy(width + 900, 100, 3, 2));
    baddies.add(new Enemy(width + 1300, 175, 3, 1));
    baddies.add(new Enemy(width + 1500, 20, 3, 2));
    baddies.add(new Enemy(width + 1550, 80, 3, 3));
    baddies.add(new Enemy(width + 1550, 140, 3, 1));
    baddies.add(new Enemy(width + 1600, 20, 3, 1));
    baddies.add(new Enemy(width + 1700, 70, 3, 1));
    baddies.add(new Enemy(width + 1800, 120, 3, 1));
    baddies.add(new Enemy(width + 1700, 80, 3, 1));
    baddies.add(new Enemy(width + 1600, 100, 3, 1));
    baddies.add(new Enemy(width + 2000, 150, 3, 1));
    baddies.add(new Enemy(width + 2000, 50, 3, 1));
    baddies.add(new Enemy(width + 2000, 200, 3, 1));
    baddies.add(new Enemy(width + 2100, 75, 3, 1));
    baddies.add(new Enemy(width + 2200, 175, 3, 1));
    baddies.add(new Enemy(width + 2300, 225, 3, 1));
    baddies.add(new Enemy(width + 2400, 275, 3, 1));
  }

  void draw() {
    theField.draw();
    hero.draw();
    for (Laser l : eduard) {
      stroke(228, 0, 88);
      fill(228, 0, 88);
      l.draw();
    }
    for (Laser bl : bossLaser) {
      stroke(0, 75, 200);
      fill(0, 75, 200);
      bl.draw();
    }
    //schleife läuft solange noch elemente e(neue temporäre variable -- wie i in normaler for schleife) vom typ Enemy in der liste baddies sind
    for (Enemy e : baddies) {
      //Draw aus der enemyklasse wird aufgerufen
      e.draw();
    }
    if (boss != null) {
      boss.draw();
    }
    secondField.draw();
    collisions();
    // cleanup methode, die alle sachen mit null leben löscht
    cleanUp();
  }

  void collisions() {
    //Kollison Shippy-laser mit boss
    for (Laser l : eduard) {
      if (boss != null && l.collide(boss.getX(), boss.getY(), boss.getX2(), boss.getY2())) {
        //wenn der "aktulle" laser mit dem "aktuellen" gegner kollidiert reduziere die HP um 1
        boss.setHp(boss.getHp() - 1);
        System.out.println(l.getHp());
        l.reduceHp();
        hero.setScore(hero.getScore() + 5);
      }
    }
    //Kollision BossLaser mit Shippy
    checkBossLaserCollide();
    //schleife läuft solange noch elemente e(neue temporäre variable -- wie i in normaler for schleife) vom typ Enemy in der liste baddies sind
    for (Enemy e : baddies) {
      //Kollision Shippy mit Gegner
      //Draw aus der enemyklasse wird aufgerufen
      if (hero.collide(e.getX(), e.getY(), e.getX2(), e.getY2())) {
        e.setHp(0);
        hero.reduceHp();
        hero.setScore(hero.getScore() -5);
      }
      //Kollision Shippy Laser mit Gegner
      checkLaserCollide(e);
    }
  }

  void checkBossLaserCollide() {
    for (Laser bl : bossLaser) {
      if (bl.collide(hero.getX(), hero.getY(), hero.getWidth(), hero.getHeight())) {
        //wenn der "aktulle" boss laser mit shippy kollidiert reduziere shippy HP um 1
        hero.reduceHp();
        bl.reduceHp();
        hero.setScore(hero.getScore() -5);
      }
    }
  }
  void checkLaserCollide(Enemy e) {
    for (Laser l : eduard) {
      if (l.collide(e.getX(), e.getY(), e.getX2(), e.getY2())) {
        //wenn der "aktulle" laser mit dem "aktuellen" gegner kollidiert reduziere die HP um 1
        e.setHp(e.getHp() - 1);
        l.reduceHp();
        hero.setScore(hero.getScore() +5);
      }
    }
  }

  void addLaser() {
    eduard.add(new Laser(hero.getCenterX()+ hero.getWidth()/2, hero.getCenterY()- 1, 4));
  }

  public void addBossLaser(int x, int y) {
    bossLaser.add(new Laser(x, y, -5));
  }

  void cleanUp() {
    Iterator<Enemy> i1 = baddies.iterator();
    while (i1.hasNext()) {
      //gibt enemy an der stelle i zurück
      Enemy e = i1.next();
      if (e.getHp() <= 0) {
        i1.remove();
        if (baddies.size() == 0) {
          boss = new Boss(width, 0, 15, this);
        }
      }
    }
    Iterator<Laser> i2 = eduard.iterator();
    while (i2.hasNext()) {
      //gibt laser an der stelle i zurück
      Laser l = i2.next();
      if (l.getHp() <= 0) {
        i2.remove();
      }
    }
    Iterator<Laser> i3 = bossLaser.iterator();
    while (i3.hasNext()) {
      //gibt laser an der stelle i zurück
      Laser l = i3.next();
      if (l.getHp() <= 0) {
        i3.remove();
      }
    }
    //GAME OVER
    if (boss != null && boss.getHp() <= 0) {
      music.pause();
      game.setState(SpaceGame.STATE_HIGHSCORE);
    }

    if (hero.getHp() <= 0) {
      music.pause();
      game.setState(SpaceGame.STATE_HIGHSCORE);
    }
  }
}