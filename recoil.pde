void setup() {
  size(500,500);
  noStroke();
}

final color fg = color(40, 90, 150);
final color bg = color(240, 240, 240);
final color enemyCol = color(150, 90, 40);
final int arenaSize = 400;

Player ply;

PVector camPos = new PVector(250, 250);

int gameState = 0;

void draw() {
  pushMatrix();
  translate(camPos.x, camPos.y);
  
  background(fg);
  fill(bg);
  ellipse(0, 0, arenaSize, arenaSize);
  if(gameState == 0) if(drawMenu()) gameState = -1;
  if(gameState == -1) {ply = new Player(0,0); gameState = 1;};
  if(gameState == 1) {
    int score = game();
    if(score != 0) {
      
    }
  }
  
  popMatrix();
}