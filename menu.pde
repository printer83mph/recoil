int menuStage = 0;
float menuSpeed = 0;
float menuProgress = 0;

boolean drawMenu() {
  fill(fg);
  if(menuStage == 1 || menuStage == 0) {
    textSize(20);
    textAlign(CENTER, CENTER);
    text("recoil", 0, menuProgress - 10);
    textSize(10);
    text("click to start", 0, menuProgress + 10);
  }
  if(mousePressed && menuStage == 0) menuStage = 1;
  if(menuStage == 1 || menuStage == 2) {menuSpeed ++;menuProgress += menuSpeed;}
  if(menuProgress > 300) {menuStage = 2;menuProgress = 0;menuSpeed = 0;}
  if(menuStage == 2) {ellipse(0,0,20-10/menuSpeed,20-10/menuSpeed);}
  return menuStage == 2 && menuProgress > 19;
}