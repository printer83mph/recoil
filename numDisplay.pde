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
    numProgress++;
  }
}