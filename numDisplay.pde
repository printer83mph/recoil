float numProgress = 60;
int curNum;
String curString;

void drawNum(int num) {
  curNum = num;
  numProgress = 0;
  curString = "";
  for(int i = 0; i < curNum; i++) {
    curString += "♥";
  }
}

void runNumDisplay() {
  if(numProgress < 60) {
    textSize(arenaSize/3+numProgress);
    fill(fg,(60-numProgress)/60*255);
    text(curString,0,-20);
    float camShake = (60-numProgress)/12;
    camPos.set(random(500-camShake,500+camShake),random(500-camShake,500+camShake));
    numProgress++;
  }
}