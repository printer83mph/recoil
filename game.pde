int game() {
  runBullets();
  ply.run();
  runEnemies();
  return 0;
}