import ddf.minim.*;

public static final int STATE_MENU = 0;
public static final int STATE_GAME = 1;
public static final int STATE_HIGHSCORE = 2;
public static final int STATE_LOADING = 3;

private int state;
private PImage heroImage;
private HeroShip heroShip;
private Level l1;
private HUD hud;
private Menu menu;
private Highscore score;
private int laserTimer;
private Minim minim;
private AudioPlayer laser;

void setup() {
  size(860, 240);
  laserTimer = 0;
  state = STATE_MENU;
  minim = new Minim (this);
  laser = minim.loadFile ("laser.mp3");


  heroImage = loadImage("shippybig.png");

  menu = new Menu();

  frameRate( 50 );
  smooth();
}

void draw() {
  background(0);
  switch (state) {
  case STATE_MENU:
    menu.draw();
    break;
  case STATE_GAME:
    l1.draw();
    hud.draw();
    break;
  case STATE_LOADING:
    //übergeben vom hier erzeughten Hero Ship an die Level Klasse und die SpaceGame klasse selbst für die Musik
    heroShip = new HeroShip (-100, height/2, 5, heroImage);
    score = new Highscore(heroShip);
    hud = new HUD(heroShip);
    l1 = new Level(heroShip, this);
    setState(STATE_GAME);
    break;
  case STATE_HIGHSCORE:
    score.draw();
    break;
  }
}

//Listener - wird aufgerufen, wenn Taste gedrückt wird
void keyTyped() {
  switch (state) {
  case STATE_MENU:
    if (key == 'c') {
      setState(STATE_LOADING);
    }
    break;
  case STATE_GAME:
    //feuert wenn gedrückte Taste der angegebene Character ist// kann erst wieder geschossen werden, die millisekunen wo das letzte mal geschossen wurde plus 400 überschritten ist
    if (key == ' ' && laserTimer+400 < millis()) {
      l1.addLaser();
      //methode millis gibt millisekunden zurück seit dem das programm gestartet wurde
      laserTimer = millis();
      laser.rewind();
      laser.play();
    }
    break;
  case STATE_HIGHSCORE:
    if (key == 'n') {
      setState(STATE_MENU);
    }
  }
}

//Listener
void keyPressed() {
  if (keyCode == UP) {
    heroShip.up();
  } else if (keyCode == DOWN) {
    heroShip.down();
  }
}


public void setState(int currentState) {
  state = currentState;
}