class Snake {
  ArrayList<VecInt> bodys;//body positions
  VecInt pos;
  VecInt dir;//direction

  Snake(int x, int y) {
    pos = new VecInt(x, y);
    dir = new VecInt(0, -1);
    bodys = new ArrayList<VecInt>();
  }
  void setDirection(VecInt v) {
    //if v is = to up and dir is = to down
    //than we cant go up
    if (dir.x*-1 == v.x || dir.y*-1 == v.y) return;
    dir.set(v);
  }
  void checkCollision(ArrayList<VecInt> walls) {
    for (VecInt v : walls) {
      if (pos.x == v.x && pos.y == v.y) {
        restart();
      }
    }
  }
  void checkFoodCollision() {
    if (foodPos.x == pos.x && foodPos.y == pos.y) {
      addBody();
      setFood();
    }
    for (int i = 0; i < bodys.size(); i++) {
      VecInt v = bodys.get(i);
      if (foodPos.x == v.x && foodPos.y == v.y) {
        addBody();
        setFood();
      }
    }
  }
  void addBody() {
    bodys.add(new VecInt(pos));
  }
  void update() {
    move();
  }
  void move() {
    if (pos.x + dir.x >= gridSize || pos.x + dir.x < 0 || pos.y + dir.y >= gridSize || pos.y + dir.y < 0) {
      restart();
      return;
    }
    VecInt lastPos = pos.copy();
    pos.add(dir);
    for (int i = 0; i < bodys.size(); i++) {
      VecInt curr = bodys.get(i).copy();
      bodys.get(i).set(lastPos);
      lastPos.set(curr);
    }
  }
  void show(int body, int head, int[][] g) {
    for (int i = 0; i < bodys.size(); i++) {
      VecInt v = bodys.get(i);
      g[v.x][v.y] = body;
    }
    g[pos.x][pos.y] = head;
  }
}
