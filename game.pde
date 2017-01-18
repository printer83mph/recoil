int game() {
  runBullets();
  ply.run();
  runEnemies();
  return 0;
}

void killEnemies(float x, float y, float size) {
  int i = enemies.size();
  while(i > 0) {
    Enemy enemy = enemies.get(i-1);
    if(dist(enemy.position.x, enemy.position.y, x, y) < enemy.size/2 + size/2) {
      enemy.kill();
    }
    i--;
  }
}