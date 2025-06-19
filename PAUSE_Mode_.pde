void pauseGame() {
  fill(midwhite);
  textAlign(CENTER);
  textSize(32);
  text("Paused. Click to resume.", width / 2, height / 2);
}
void keyPressed() {
  if (mode == GAME) {
    if (key == 'a' || key == 'A') leftPressed = true;
    if (key == 'd' || key == 'D') rightPressed = true;
  }
  if (key == 'p' || key == 'P') mode = PAUSE;
}

void keyReleased() {
  if (key == 'a' || key == 'A') leftPressed = false;
  if (key == 'd' || key == 'D') rightPressed = false;
}
