int gameStartFrame;
int difficulty = 0;
int score = 0;
int multiplier = 0;
int comboDelay = 0;
int scoreSize = 100;
int comboSize = 100;

int game() {
  runBullets();
  ply.run();
  runEnemies();
  drawScore();
  drawMult();
  runNumDisplay();
  if(comboDelay == 0 && multiplier != 0) {multiplier = floor(multiplier/2);comboDelay = 300;comboSize += 20;}
  else comboDelay--;
  if((frameCount-gameStartFrame) % 60 == 0) {score += multiplier; scoreSize += min(multiplier*10,30);}
  return 0;
}

void killEnemies(float x, float y, float size, boolean chargeKill) {
  int i = enemies.size();
  while(i > 0) {
    Enemy enemy = enemies.get(i-1);
    if(dist(enemy.position.x, enemy.position.y, x, y) < enemy.size/2 + size/2) {
      enemy.kill();
    }
    i--;
  }
}

void drawScore() {
  fill(bg);
  int digLen = String.valueOf(score).length();
  textSize(scoreSize/digLen);
  text(score,-200,-200);
  if(scoreSize > 100) scoreSize --;
}

void drawMult() {
  fill(bg);
  int digLen = String.valueOf(multiplier).length()+1;
  textSize(comboSize/digLen);
  text("x" + multiplier,200,-200);
  if(comboSize > 100) comboSize --;
}