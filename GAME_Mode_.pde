
void moveBall() {
  ballX += ballVX;
  ballY += ballVY;

  if (ballX < 0 || ballX > width) ballVX *= -1;
  if (ballY < 0) ballVY *= -1;

  if (ballY + ballR / 2 >= paddleY && ballY <= paddleY + paddleH && ballX >= paddleX && ballX <= paddleX + paddleW) {
    ballVY *= -1;
  }

  int r = 0;
while (r < rows) {
  int c = 0;
  while (c < cols) {
    if (bricks[r][c]) {
      float brickX = c * (brickD + 10) + 50;
      float brickY = r * (brickD + 10) + 50;
      if (dist(ballX, ballY, brickX, brickY) < (brickD / 2 + ballR / 2)) {
        bricks[r][c] = false;
        ballVY *= -1;
        score++;
      }
    }
    c++;
  }
  r++;
}

  if (ballY > height) {
    lives--;
    if (lives <= 0) mode = GAMEOVER;
    else resetBall();
  }
}

void drawPaddle() {
  paddleY = height - 60;
  fill(DB);
  rect(paddleX, paddleY, paddleW, paddleH);
}

void drawBall() {
  fill(white);
  ellipse(ballX, ballY, ballR, ballR);
}

void drawBricks() {
  int r = 0;
  while (r < rows) {
    int c = 0;
    while (c < cols) {
      if (bricks[r][c]) {
        float x = c * (brickD + 10) + 50;
        float y = r * (brickD + 10) + 50;
        fill(rowColors[r % rowColors.length]);
        ellipse(x, y, brickD, brickD);
      }
      c++;
    }
    r++;
  }
}


void drawStats() {
  fill(white);
  textSize(20);
  text("Score: " + score, 70, 30);
  text("Lives: " + lives, 70, 60);
}

void resetGame() {
  score = 0;
  lives = 3;
  paddleX = width / 2 - paddleW / 2;
  paddleY = height - 60;
  resetBall();

  bricks = new boolean[rows][cols];
  int r = 0;
while (r < rows) {
  int c = 0;
  while (c < cols) {
    bricks[r][c] = true;
    c++;
  }
  r++;
}
}

void resetBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballVX = random(-4, 4);
  ballVY = 5;
}

void mousePressed() {
  if (mode == INTRO) mode = GAME;
  else if (mode == PAUSE) mode = GAME;
  else if (mode == GAMEOVER) {
    resetGame();
    mode = INTRO;
  }
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
