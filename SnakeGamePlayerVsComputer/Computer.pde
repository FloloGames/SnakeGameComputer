class Computer extends Snake {
  ArrayList<Node> path;
  boolean showPath = true;
  Computer(int x, int y) {
    super(x, y);
    path = new ArrayList<Node>();
  }
  void findPath(int[][] g) {
    Pathfinding pathfinding = new Pathfinding(pos.x, pos.y, foodPos.x, foodPos.y, g);
    path = pathfinding.searchPath();
    VecInt d = pathfinding.getDir();
    if (d == null) return;
    dir.set(d);
  }
  @Override
    void update() {
    findPath(grid);
    move();
    checkCollision(bodys);
    checkFoodCollision();
    if (!showPath) return;
    strokeWeight(5);
    stroke(255);
    noFill();
    beginShape();
    for (Node n : path) {
      vertex(n.i*cellSize+cellSize/2, n.j*cellSize+cellSize/2);
    }
    endShape();
  }
}
