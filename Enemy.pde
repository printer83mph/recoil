int difDelay;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();

class Enemy extends Player {
  
  float fear;
  boolean loadingOut;
  boolean loadingIn;
  boolean dead;
  int startFrame;
  
  public Enemy(float x, float y) {
    super(round(x),round(y));
    position = new PVector(x,y);
    velocity = new PVector(0,0);
    fear = random(arenaSize/3);
    size = arenaSize/20;
    loadingOut = false;
    loadingIn = true;
    dead = false;
    startFrame = frameCount;
  }
  
  void run() {
    if(loadingIn) {
      loadIn();
    } else if(loadingOut) {
      loadOut();
    } else {
      position.add(velocity);
      velocity.mult(0.99);
      checkEdgeCollide();
      if(shootDelay == 0) {
        if(dist(ply.position.x, ply.position.y, position.x, position.y) < fear) {
          shoot(new PVector(ply.position.x-position.x, ply.position.y-position.y));
        } else {shoot(new PVector(ply.position.x-position.x, ply.position.y-position.y).mult(-1));}
        shootDelay = 60-difficulty;
      } else {
        shootDelay--;
      }
      if(touchingPlayer()) {
        ply.damage();
      }
      draw();
    }
  }
  
  void draw() {
    fill(255,0,0);
    ellipse(position.x, position.y, size, size);
  }
  
  void shoot(PVector aim) {
    velocity.add(aim.normalize().mult(-arenaSize/600));
    bullets.add(new EnemyBullet(position.x,position.y,aim.mult(-3).add(velocity)));
  }
  
  void loadIn() {
    fill(255,0,0);
    float curSize = (frameCount-startFrame)*arenaSize/500;
    ellipse(position.x, position.y, curSize, curSize);
    if(curSize > size-1) {loadingIn = false;}
  }
  
  void kill() {
    if(!loadingOut) {
      loadingOut = true;
      loadingIn = false;
      startFrame = frameCount;
      comboDelay = 300;
      comboSize += arenaSize/20;
      multiplier++;
    }
  }
  
  void loadOut() {
    fill(255,0,0);
    float curSize = size-(frameCount-startFrame)*arenaSize/500;
    ellipse(position.x, position.y, curSize, curSize);
    if(curSize < 1) {dead = true;}
  }
  
  boolean touchingPlayer() {
    return dist(ply.position.x, ply.position.y, position.x, position.y) < size/2 + ply.size/2;
  }
  
}

void runEnemies() {
  if(difDelay == 0) {
    difficulty ++;
    difDelay = round(600+difficulty*60);
  } else {
    difDelay--;
  }
  if(enemies.size() == 0) {
    for(int i = 0; i < difficulty; i++) {
      PVector enemyPos = PVector.random2D().mult(random(arenaSize/2-10));
      while(dist(enemyPos.x,enemyPos.y,ply.position.x,ply.position.y) < arenaSize/4) {
        enemyPos = PVector.random2D().mult(random(arenaSize/2-10));
      }
      enemies.add(new Enemy(enemyPos.x,enemyPos.y));
    }
  }
  int i = enemies.size();
  while(i > 0) {
    Enemy enemy = enemies.get(i-1);
    enemy.run();
    if(enemy.dead) enemies.remove(enemy);
    i--;
  }
}