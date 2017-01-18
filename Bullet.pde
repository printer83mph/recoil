import java.util.Iterator;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

Iterator<Bullet> bullitr = bullets.iterator();

class Bullet {
  
  final static float lifeSpan = 15;
  
  PVector position;
  PVector direction;
  float size;
  float curSize;
  int lifeStart;
  
  public Bullet(float x, float y, PVector ang) {
    position = new PVector(x, y);
    direction = ang;
    size = 20;
    lifeStart = frameCount;
  }
  
  void run() {
    position.add(direction);
    draw();
  }
  
  void draw() {
    fill(0);
    curSize = exp(-pow((1-(lifeSpan-(frameCount-lifeStart))/lifeSpan),2))*size;
    ellipse(position.x,position.y,curSize,curSize);
  }
  
}

void runBullets() {
  int i = bullets.size();
  while(i > 0) {
    Bullet bullet = bullets.get(i-1);
    bullet.run();
    if(frameCount - bullet.lifeStart > Bullet.lifeSpan) {
      bullets.remove(bullet);
    }
    i--;
  }
}