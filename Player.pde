class Player {
  
  PVector position;
  PVector velocity;
  float size;
  float shakeSpeed;
  int hp;
  int invulDelay;
  
  int shootDelay;
  
  public Player(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    size = 20;
    shakeSpeed = 4;
    hp = 3;
  }
  
  void run() {
    position.add(velocity);
    velocity.mult(0.99);
    checkEdgeCollide();
    if(invulDelay > 0) {
      invulDelay--;
    }
    if(shootDelay == 0) {
      if(mousePressed) {
        shoot(new PVector(mouseX-camPos.x-position.x, mouseY-camPos.y-position.y));
        shootDelay = 10;
      }
    } else {
      shootDelay--;
    }
    if(velocity.mag() > shakeSpeed) {
      fill(0);
      float camShake = velocity.mag() - shakeSpeed + 1;
      ellipse(position.x, position.y, size + camShake, size + camShake);
      killEnemies(position.x,position.y,size + camShake,true);
      if(frameCount % 2 == 0) {
        camPos.x = random(250-camShake,250+camShake);
        camPos.y = random(250-camShake,250+camShake);
      }
    } else {camPos.set(250,250);}
    draw();
  }
  
  void checkEdgeCollide() {
    if(dist(position.x, position.y, 0, 0) > arenaSize/2-size/2) {
      position.normalize().mult(arenaSize/2-size/2);
      velocity.set(0,0);
    }
  }
  
  void draw() {
    fill(fg);
    ellipse(position.x, position.y, size, size);
  }
  
  void shoot(PVector aim) {
    velocity.add(aim.normalize().mult(-1));
    bullets.add(new Bullet(position.x,position.y,aim.mult(-3).add(velocity)));
  }
  
  void damage() {
    if(invulDelay == 0 && !(velocity.mag()>shakeSpeed)) {
      hp--;
      drawNum(hp);
      invulDelay = 60;
    }
  }
  
}