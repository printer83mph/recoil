class Player {
  
  PVector position;
  PVector velocity;
  float size;
  
  int shootDelay;
  
  public Player(int x, int y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    size = 20;
  }
  
  void run() {
    position.add(velocity);
    velocity.mult(0.99);
    checkEdgeCollide();
    if(shootDelay == 0) {
      camPos.set(250,250);
      if(mousePressed) {
        shoot(new PVector(mouseX-camPos.x-position.x, mouseY-camPos.y-position.y));
        shootDelay = 10;
      }
    } else {
      shootDelay--;
      if(shootDelay % 2 == 0) {
        float camShake = shootDelay/3;
        camPos.x = random(250-camShake,250+camShake);
        camPos.y = random(250-camShake,250+camShake);
      }
    }
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
  
}