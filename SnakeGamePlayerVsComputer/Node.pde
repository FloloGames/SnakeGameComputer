class Node {
  int i;
  int j;
  // f, g, and h values for A*
  float f = 0;
  float g = 0;
  float heuristic = 0;

  ArrayList<Node> neighbors = new ArrayList<Node>();

  Node previous = null;

  int type = EMPTY;

  Node(int i_, int j_, int t) {
    i = i_;
    j = j_;
    type = t;
  }
  void addNeighbors(Node[][] g) {
    if (i < gridSize - 1) {
      neighbors.add(g[i + 1][j]);
    }
    if (i > 0) {
      neighbors.add(g[i - 1][j]);
    }
    if (j < gridSize - 1) {
      neighbors.add(g[i][j + 1]);
    }
    if (j > 0) {
      neighbors.add(g[i][j - 1]);
    }
  }
};
