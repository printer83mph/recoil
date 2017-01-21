float numProgress = 60;
int curNum;

void drawNum(int num) {
  curNum = num;
  numProgress = 0;
}

void runNumDisplay() {
  if(numProgress < 60) {
    textSize(arenaSize/2+numProgress);
    fill(fg,(60-numProgress)/60*255);
    text(curNum,0,-20);
    float camShake = (60-numProgress)/12;
    camPos.set(random(500-camShake,500+camShake),random(500-camShake,500+camShake));
    numProgress++;
  }
}