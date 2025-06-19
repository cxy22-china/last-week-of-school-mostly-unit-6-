

void draw() {
  background(B);
  if (mode == INTRO) showIntro();
  else if (mode == GAME) playGame();
  else if (mode == PAUSE) pauseGame();
  else if (mode == GAMEOVER) showGameOver();
}

void showIntro() {
  image(gifFrames[gifIndex], 0, 0, width, height);
  gifIndex = (gifIndex + 1) % numOfFrames;
  fill(white);
  textAlign(CENTER);
  textSize(40);
  text("Breakout (Click to Play)", width / 2, height / 2);
}

void playGame() {
  if (leftPressed) paddleX -= 6;
  if (rightPressed) paddleX += 6;
  if (paddleX < 0) paddleX = 0;
  if (paddleX > width - paddleW) paddleX = width - paddleW;

  moveBall();
  drawPaddle();
  drawBall();
  drawBricks();
  drawStats();
}
