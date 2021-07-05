public class Player extends Snake {
  Player(int x, int y) {
    super(x, y);

    registerMethod("keyEvent", this);
  }
  @Override 
    void update() {
    move();
    checkCollision(bodys);
    checkCollision(computer.bodys);
    checkFoodCollision();
    show(PLAYER_BODY, PLAYER_HEAD, grid);
  }
  void keyPressed() {
    if (keyCode == UP || key == 'w' || key == 'W') {
      setDirection(new VecInt(0, -1));
    } else if (keyCode == DOWN || key == 's' || key == 'S') {
      setDirection(new VecInt(0, 1));
    }
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      setDirection(new VecInt(-1, 0));
    } else if (keyCode == RIGHT || key == 'd' || key == 'D') {
      setDirection(new VecInt(1, 0));
    }
    if (key == ' ') {
      addBody();
    }
  }
  void keyReleased() {
  }
  void keyTyped() {
  }
  public void keyEvent(KeyEvent evt) {
    switch(evt.getAction()) {
    case KeyEvent.PRESS:
      keyPressed();
      break;
    case KeyEvent.RELEASE:
      keyReleased();
      break;
    case KeyEvent.TYPE:
      keyTyped();
      break;
    }
  }
}
