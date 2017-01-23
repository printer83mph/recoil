int menuStage = 0;
float menuSpeed = 0;
float menuProgress = 0;
float restartTimer = 0;
boolean restarting = false;

boolean drawMenu() {
  fill(fg);
  if(menuStage == 1 || menuStage == 0) {
    textSize(arenaSize/10);
    textAlign(CENTER, CENTER);
    text("recoil", 0, menuProgress - arenaSize/30);
    textSize(arenaSize/20);
    text("click to start/shoot", 0, menuProgress + arenaSize/30);
  }
  if(mousePressed && menuStage == 0) menuStage = 1;
  if(menuStage == 1 || menuStage == 2) {menuSpeed += arenaSize/500;menuProgress += menuSpeed;}
  if(menuProgress > arenaSize) {menuStage = 2;menuProgress = 0;menuSpeed = 0;}
  if(menuStage == 2) {ellipse(0,0,arenaSize/20-10/menuSpeed,arenaSize/20-10/menuSpeed);}
  return menuStage == 2 && menuProgress > arenaSize/20;
}

void killPlayer() {
  fill(fg);
  ellipse(ply.position.x,ply.position.y,pow(deathAnimProg,2) + 20,pow(deathAnimProg,2) + 20);
  if(pow(deathAnimProg,2) < arenaSize*3) {
    deathAnimProg ++;
    fill(bg);
    textSize(arenaSize/4);
    text("GAME\nOVER",0,0);
  } else {
    fill(bg);
    textSize(arenaSize/4);
    text("GAME\nOVER",0,pow(restartTimer,2));
    if(mousePressed) {restarting = true;}
    if(restarting) {restartTimer++;}
    if(pow(restartTimer,2) > arenaSize*1.5) {resetGame();}
  }
}