public class Player extends Snake {
  ArrayList<VecInt> nextDirs;
  Player(int x, int y) {
    super(x, y);
    nextDirs = new ArrayList<VecInt>();
    registerMethod("keyEvent", this);
  }
  void updateNextDirection() {
    if (!(nextDirs.size() > 0)) return;
    VecInt next = nextDirs.remove(0);
    setDirection(next);
  }
  @Override 
    void update() {
    updateNextDirection();
    move();
    checkCollision(bodys);
    checkCollision(computer.bodys);
    checkFoodCollision();
    show(PLAYER_BODY, PLAYER_HEAD, grid);
  }
  void keyPressed() {
    if (keyCode == UP || key == 'w' || key == 'W') {
      nextDirs.add(new VecInt(0, -1));
    } else if (keyCode == DOWN || key == 's' || key == 'S') {
      nextDirs.add(new VecInt(0, 1));
    }
    if (keyCode == LEFT || key == 'a' || key == 'A') {
      nextDirs.add(new VecInt(-1, 0));
    } else if (keyCode == RIGHT || key == 'd' || key == 'D') {
      nextDirs.add(new VecInt(1, 0));
    }
    //if (key == ' ') {
    //  addBody();
    //}
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
