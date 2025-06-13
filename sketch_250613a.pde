color black = #001219;
color DB = #005f73;
color ldb = #0a9396;
color lb = #94d2bd;
color midwhite = #e9d8a6;
color yellow = #ee9b00;
color orange = #ca6702;
color or = #bb3e03;
color red = #ae2012;
color dr = #9b2226;
color white = #FFFFFF;
color B = #000000;
color grey = #7C7B7A;

// Mode constants
int INTRO = 0;
int GAME = 1;
int PAUSE = 2;
int GAMEOVER = 3;

int mode = INTRO;

PImage[] gifFrames;
int gifIndex = 0;
int frameTotal = 10; // Replace with your actual number of GIF frames

int score = 0;
int lives = 3;

float ballX, ballY, ballVX, ballVY;
float ballR = 20;

float paddleX, paddleY;
float paddleW = 100;
float paddleH = 15;

boolean[][] bricks;
int rows = 5;
int cols = 8;
int brickD = 40;
color[] rowColors;

void setup() {
  size(1000, 800);

  gifFrames = new PImage[frameTotal];
  for (int i = 0; i < frameTotal; i++) {
    gifFrames[i] = loadImage("frame" + i + ".png");
  }

  rowColors = new color[] { red, or, orange, yellow, lb };

  resetGame();
}

void draw() {
  background(B);
  if (mode == INTRO) showIntro();
  else if (mode == GAME) playGame();
  else if (mode == PAUSE) pauseGame();
  else if (mode == GAMEOVER) showGameOver();
}

void showIntro() {
  image(gifFrames[gifIndex], 0, 0, width, height);
  gifIndex = frameCount % frameTotal;

  fill(white);
  textAlign(CENTER);
  textSize(40);
  text("Breakout (Click to Play)", width/2, height/2);
}

void playGame() {
  moveBall();
  drawPaddle();
  drawBall();
  drawBricks();
  drawStats();
}

void pauseGame() {
  fill(midwhite);
  textAlign(CENTER);
  textSize(32);
  text("Paused. Click to resume.", width/2, height/2);
}

void showGameOver() {
  fill(white);
  textAlign(CENTER);
  textSize(40);
  text(score >= rows * cols ? "YOU WIN!" : "GAME OVER!", width/2, height/2);
  textSize(20);
  text("Click to restart.", width/2, height/2 + 40);
}

void moveBall() {
  ballX += ballVX;
  ballY += ballVY;

  if (ballX < 0 || ballX > width) ballVX *= -1;
  if (ballY < 0) ballVY *= -1;

  if (ballY + ballR/2 >= paddleY && ballY <= paddleY + paddleH && ballX >= paddleX && ballX <= paddleX + paddleW) {
    ballVY *= -1;
  }

  for (int r = 0; r < rows; r++) {
     for (int c = 0; c < cols; c++) {
      if (bricks[r][c]) {
        float brickX = c * (brickD + 10) + 50;
           float brickY = r * (brickD + 10) + 50;
                    if (dist(ballX, ballY, brickX, brickY) < (brickD/2 + ballR/2)) {
          bricks[r][c] = false;
          ballVY *= -1;
          score++;
        }
      }
    }
  }

  if (ballY > height) {
    lives--;
    if (lives <= 0) mode = GAMEOVER;
    else resetBall();
  }
}

void drawPaddle() {
  paddleX = constrain(mouseX - paddleW/2, 0, width - paddleW);
  paddleY = height - 60;
  fill(DB);
  rect(paddleX, paddleY, paddleW, paddleH);
}

void drawBall() {
  fill(white);
  ellipse(ballX, ballY, ballR, ballR);
}

void drawBricks() {
         for (int r = 0; r < rows; r++) {
         for (int c = 0; c < cols; c++) {
        if (bricks[r][c]) {
        float x = c * (brickD + 10) + 50;
        float y = r * (brickD + 10) + 50;
        fill(rowColors[r % rowColors.length]);
        ellipse(x, y, brickD, brickD);
      }
    }
  }
}

void drawStats() {
  fill(white);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Lives: " + lives, 20, 60);
}

void resetGame() {
  score = 0;
  lives = 3;
  paddleX = width/2 - paddleW/2;
  paddleY = height - 60;
  resetBall();

  bricks = new boolean[rows][cols];
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      bricks[r][c] = true;
    }
  }
}

void resetBall() {
  ballX = width/2;
  ballY = height/2;
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
  if (mode == GAME) mode = PAUSE;
}
