int menuStage = 0;
float menuSpeed = 0;
float menuProgress = 0;
float restartTimer = 0;
boolean restarting = false;

boolean drawMenu() {
  fill(fg);
  if(menuStage == 1 || menuStage == 0) {
    textSize(20);
    textAlign(CENTER, CENTER);
    text("recoil", 0, menuProgress - 10);
    textSize(10);
    text("click to start/shoot", 0, menuProgress + 10);
  }
  if(mousePressed && menuStage == 0) menuStage = 1;
  if(menuStage == 1 || menuStage == 2) {menuSpeed ++;menuProgress += menuSpeed;}
  if(menuProgress > 300) {menuStage = 2;menuProgress = 0;menuSpeed = 0;}
  if(menuStage == 2) {ellipse(0,0,20-10/menuSpeed,20-10/menuSpeed);}
  return menuStage == 2 && menuProgress > 19;
}

void killPlayer() {
  fill(fg);
  ellipse(ply.position.x,ply.position.y,pow(deathAnimProg,2) + 20,pow(deathAnimProg,2) + 20);
  if(pow(deathAnimProg,2) < arenaSize*3) {
    deathAnimProg ++;
    fill(bg);
    textSize(100);
    text("GAME\nOVER",0,0);
  } else {
    fill(bg);
    textSize(100);
    text("GAME\nOVER",0,pow(restartTimer,2));
    if(mousePressed) {restarting = true;}
    if(restarting) {restartTimer++;}
    if(pow(restartTimer,2) > arenaSize*1.5) {resetGame();}
  }
}