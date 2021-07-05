class Pathfinding {
  ArrayList<Node> path;
  ArrayList<Node> openList;
  ArrayList<Node> closedList;
  Node[][] myGrid;
  Node start, end;

  Pathfinding(int x1, int y1, int x2, int y2, int[][] g) {
    myGrid = new Node[gridSize][gridSize];

    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        myGrid[i][j] = new Node(i, j, EMPTY);
        myGrid[i][j].type = g[i][j];
      }
    }
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        myGrid[i][j].addNeighbors(myGrid);
      }
    }

    start = myGrid[x1][y1];
    end = myGrid[x2][y2];



    path = new ArrayList<Node>();
    openList = new ArrayList<Node>();
    closedList = new ArrayList<Node>();
  }
  VecInt getDir() {
    //searchPath();
    if (path.size() > 1) {
      int vx = path.get(path.size()-2).i - start.i;
      int vy = path.get(path.size()-2).j - start.j;
      vx = constrain(vx, -1, 1);
      vy = constrain(vy, -1, 1);
      return new VecInt(vx, vy);
    } 
    return null;
  }
  ArrayList<Node> searchPath() {
    openList.clear();
    closedList.clear();

    openList.add(start);

    Node current;

    int maxRounds = 99999;
    int rounds = 0;
    while (openList.size() > 0) {
      rounds++;
      if (rounds > maxRounds) return path;
      int winner = 0;
      for (int i = 0; i < openList.size(); i++) {
        if (openList.get(i).f < openList.get(winner).f) {
          winner = i;
        }
      }
      current = openList.get(winner);

      if (current == end) {
        path.clear();
        Node temp = current;
        path.add(temp);
        while (temp.previous != null) {
          rounds++;
          if (rounds > maxRounds) return path;
          path.add(temp.previous);
          temp = temp.previous;
        }
        return path;
      }

      openList.remove(current);
      closedList.add(current);

      ArrayList<Node> neighbors = current.neighbors;
      for (Node neighbor : neighbors) {
        if (closedList.contains(neighbor) == false &&
          neighbor.type != PLAYER_BODY &&
          neighbor.type != PLAYER_HEAD &&
          neighbor.type != COMPUTER_BODY &&
          neighbor.type != COMPUTER_HEAD) {
          float tempG = current.g + heuristic(neighbor, current);
          boolean newPath = false;

          if (openList.contains(neighbor)) {
            if (tempG < neighbor.g) {
              neighbor.g = tempG;
              newPath = true;
            }
          } else {
            neighbor.g = tempG;
            newPath = true;
            openList.add(neighbor);
          }

          // Yes, it's a better path
          if (newPath) {
            path.clear();
            neighbor.heuristic = heuristic(neighbor, end);
            neighbor.f = neighbor.g + neighbor.heuristic;
            neighbor.previous = current;
          }
        }
      }
      path.clear();
      Node temp = current;
      path.add(temp);
      while (temp.previous != null) {
        rounds++;
        if (rounds > maxRounds) return path;
        path.add(temp.previous);
        temp = temp.previous;
      }
    }
    return path;
  }
}
float heuristic(Node a, Node b) {
  return dist(a.i, a.j, b.i, b.j);
}
