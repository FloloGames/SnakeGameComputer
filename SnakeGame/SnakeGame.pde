final int gridSize = 20;//20*20
final int EMPTY = 0;
final int PLAYER_BODY = 1;
final int PLAYER_HEAD = 2;
final int COMPUTER_BODY = 3;
final int COMPUTER_HEAD = 4;
final int FOOD = 5;

final color PLAYER_BODY_COLOR = color(151, 84, 114);
final color PLAYER_HEAD_COLOR = color(231, 164, 189);
final color COMPUTER_BODY_COLOR = color(33, 26, 105);
final color COMPUTER_HEAD_COLOR = color(100, 119, 175);
final color FOOD_COLOR = color(174, 191, 171);

boolean showGrid = false;

float tickTime = 0.15;//move Speed default: 0.15
float time = 0;

float cellSize;
int[][] grid;

Player player;

VecInt foodPos;

void setup() {
  rectMode(CENTER);
  size(700, 700);
  //fullScreen();
  player = new Player(4, 10);
  foodPos = new VecInt(0, 0);
  for (int i = 0; i < 2; i++) {
    player.addBody();
  }
  grid = new int[gridSize][gridSize];

  cellSize = float(min(width, height)) / gridSize;
  clearGrid();
  setFood();
}
void keyPressed() {
  if (key == 'g' || key == 'G') {
    showGrid = !showGrid;
  }
  //if (keyCode == UP) {
  //  tickTime += 0.01;
  //} 
  //if (keyCode == DOWN) {
  //  tickTime -= 0.01;
  //}
}
void draw() {
  println("draw", frameRate);
  time += 1 / frameRate;
  if (time < tickTime) return;
  time = 0;

  background(0);  
  clearGrid();

  drawFood();
  player.update();

  drawGrid();//must be called at last
}
void exit() {
  super.exit();
}
void drawFood() {
  grid[foodPos.x][foodPos.y] = FOOD;
}
void restart() {
  println("RESTART");
  setup();
}
void setFood() {
  foodPos.set(floor(random(gridSize)), floor(random(gridSize)));
}
void clearGrid() {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      grid[i][j] = EMPTY;
    }
  }
}
void drawGrid() {
  if (showGrid) {
    strokeWeight(0.5);
    stroke(255, 100);
  } else {
    noStroke();
  }
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      int cellType = grid[i][j];
      if (cellType == EMPTY) {
        noFill();
        rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
      } else if (cellType == PLAYER_BODY) {
        fill(PLAYER_BODY_COLOR);
        rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
      } else if (cellType == PLAYER_HEAD) {
        fill(PLAYER_HEAD_COLOR);
        rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize, 10, 10, 10, 10);
      } else if (cellType == COMPUTER_BODY) {
        fill(COMPUTER_BODY_COLOR);
        rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
      } else if (cellType == COMPUTER_HEAD) {
        fill(COMPUTER_HEAD_COLOR);
        rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize, 10, 10, 10, 10);
      } else if (cellType == FOOD) {
        fill(FOOD_COLOR);
        rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize, 10, 10, 10, 10);
      }
    }
  }
}
//You could also do it like that:
//switch(cellType) {
//case EMPTY://empty
//  noFill();
//  rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
//  break;
//case PLAYER_BODY://body
//  fill(#C720D3);
//  rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
//  break;
//case PLAYER_HEAD://head
//  fill(#9D20D3);
//  ellipse(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
//  break;
//case COMPUTER_BODY:
//  fill(120);
//  rect(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
//  break;
//case COMPUTER_HEAD:
//  fill(120);
//  ellipse(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
//  break;
//case FOOD:
//  fill(0, 0, 255);
//  ellipse(i*cellSize+cellSize/2, j*cellSize+cellSize/2, cellSize, cellSize);
//}
