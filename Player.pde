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
    size = arenaSize/20;
    shakeSpeed = arenaSize/150;
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
      float camShake = (velocity.mag() - shakeSpeed)*(arenaSize/500);
      ellipse(position.x, position.y, size + camShake, size + camShake);
      killEnemies(position.x,position.y,size + camShake);
      if(frameCount % 2 == 0) {
        camPos.x = random(defaultCamPos.x-camShake,defaultCamPos.x+camShake);
        camPos.y = random(defaultCamPos.y-camShake,defaultCamPos.y+camShake);
      }
    } else {camPos.set(defaultCamPos);}
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
    velocity.add(aim.normalize().mult(-arenaSize/600));
    bullets.add(new Bullet(position.x,position.y,aim.mult(-arenaSize/200).add(velocity)));
  }
  
  void damage() {
    if(invulDelay == 0 && !(velocity.mag()>shakeSpeed)) {
      hp--;
      if(hp == 0) {
        gameState = 2;
        deathAnimProg = 0;
      } else {
        drawNum(hp);
        hpSize += 20;
        invulDelay = 60;
      }
    }
  }
  
}