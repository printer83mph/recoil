void setup() {
  fullScreen();
  noStroke();
  defaultCamPos = new PVector(width/2,height/2);
  camPos = new PVector(width/2,height/2);
}

int deathAnimProg;

final color fg = color(40, 90, 150);
final color bg = color(240, 240, 240);
final color enemyCol = color(150, 90, 40);
final int arenaSize = 400;

Player ply;

PVector defaultCamPos;
PVector camPos;

int gameState = 0;

void draw() {
  pushMatrix();
  translate(camPos.x, camPos.y);
  
  background(fg);
  fill(bg);
  ellipse(0, 0, arenaSize, arenaSize);
  if(gameState == 0) if(drawMenu()) gameState = -1;
  if(gameState == -1) {ply = new Player(0,0); gameState = 1;gameStartFrame = frameCount-1;drawNum(3);}
  if(gameState == 1) {
    game();
  }
  if(gameState == 2) {
    killPlayer();
    drawScore();
  }
  
  popMatrix();
}