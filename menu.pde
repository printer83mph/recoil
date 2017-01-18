boolean drawMenu() {
  fill(fg);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("recoil", 0, -10);
  textSize(10);
  text("click to start", 0, 10);
  return mousePressed;
}