float numProgress = 60;
int curNum;
String curString;

void drawNum(int num) {
  curNum = num;
  curString = "x" + num;
  numProgress = 0;
}

void runNumDisplay() {
  if(numProgress < 60) {
    textSize(arenaSize/3+numProgress);
    fill(fg,(60-numProgress)/60*255);
    text(curString,0,-arenaSize/20);
    float camShake = (60-numProgress)/(arenaSize/30);
    camPos.set(random(defaultCamPos.x-camShake,defaultCamPos.x+camShake),random(defaultCamPos.y-camShake,defaultCamPos.y+camShake));
    numProgress++;
  }
}