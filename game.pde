int gameStartFrame;
int difficulty = 0;
int score = 0;
int multiplier = 0;
int comboDelay = 0;
float scoreSize;
float comboSize;
float hpSize;
float scorePos;
int extraLifeGoal = 15;

void game() {
  runBullets();
  ply.run();
  runEnemies();
  drawScore();
  drawMult();
  runNumDisplay();
  drawHp();
  if(comboDelay == 0 && multiplier != 0) {multiplier = floor(multiplier/2);comboDelay = 300;comboSize += arenaSize/20;doExtraLife();}
  else comboDelay--;
  if((frameCount-gameStartFrame) % 60 == 0) {
    score += multiplier;
    scoreSize += min(multiplier*arenaSize/40,arenaSize/15);
  }
}

void doExtraLife() {
  if(multiplier >= extraLifeGoal) {
    ply.hp ++;
    drawNum(ply.hp);
    extraLifeGoal+= 15;
  }
  if(multiplier < extraLifeGoal - 15) {
    extraLifeGoal -= 15;
  }
}

void killEnemies(float x, float y, float size) {
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
  text(score,-scorePos,-scorePos);
  if(scoreSize > arenaSize/5) scoreSize -= arenaSize/600;
}

void drawMult() {
  fill(bg);
  int digLen = String.valueOf(multiplier).length()+1;
  textSize(comboSize/digLen);
  text("+" + multiplier,scorePos,-scorePos);
  if(comboSize > arenaSize/5) comboSize -= arenaSize/600;
}

void drawHp() {
  fill(bg);
  int digLen = String.valueOf(curString).length()+1;
  textSize(hpSize/digLen);
  text(curString,-scorePos,scorePos);
  if(hpSize > arenaSize/4) hpSize -=arenaSize/600;
}

void resetGame() {
  enemies.clear();
  bullets.clear();
  gameState = -1;
  menuStage = 0;
  menuSpeed = 0;
  menuProgress = 0;
  difficulty = 1;
  score = 0;
  multiplier = 0;
  numProgress = 60;
  restarting = false;
  restartTimer = 0;
  scoreSize += arenaSize/20;
  comboSize += arenaSize/20;
  hpSize += arenaSize/20;
  extraLifeGoal = 15;
}