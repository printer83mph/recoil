ArrayList<Enemy> enemies = new ArrayList<Enemy>();

class Enemy extends Player {
  
  boolean loadingIn = true;
  int startFrame;
  
  public Enemy(float x, float y) {
    super(round(x),round(y));
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    size = 20;
    startFrame = frameCount;
  }
  
  void run() {
    if(loadingIn) {
      loadIn();
    } else {
      position.add(velocity);
      velocity.mult(0.99);
      checkEdgeCollide();
      if(shootDelay == 0) {
        if(dist(ply.position.x, ply.position.y, position.x, position.y) < 100) {
          shoot(new PVector(ply.position.x-position.x, ply.position.y-position.y));
        } else {shoot(new PVector(ply.position.x-position.x, ply.position.y-position.y).mult(-1));}
        shootDelay = 60;
      } else {
        shootDelay--;
      }
      draw();
    }
  }
  
  void draw() {
    fill(255,0,0);
    ellipse(position.x, position.y, size, size);
  }
  
  void shoot(PVector aim) {
    velocity.add(aim.normalize().mult(-1));
    bullets.add(new EnemyBullet(position.x,position.y,aim.mult(-3).add(velocity)));
  }
  
  void loadIn() {
    fill(255,0,0);
    float curSize = 20-10/(frameCount-startFrame+1);
    ellipse(position.x, position.y, curSize, curSize);
    if(curSize > size-1) {loadingIn = false;}
  }
  
}

void runEnemies() {
  if(frameCount % 600 == 0) {
    PVector enemyPos = PVector.random2D().mult(random(arenaSize/2-10));
    enemies.add(new Enemy(enemyPos.x,enemyPos.y));
  }
  int i = enemies.size();
  while(i > 0) {
    Enemy enemy = enemies.get(i-1);
    enemy.run();
    i--;
  }
}