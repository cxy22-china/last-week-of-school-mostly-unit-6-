import processing.sound.*;

SoundFile bounce;
SoundFile fail;
SoundFile music;

color black = #001219;
color DB = #005f73;
color ldb = #0a9396;
color lb = #94d2bd;
color midwhite = #e9d8a6;
color yellow = #ee9b00;
color orange = #ca6702;
color or = #bb3e03;
color dr = #9b2226;
color white = #FFFFFF;
color B = #000000;
color grey = #7C7B7A;

color blue = #335c67;
color lightyellow = #fff3b0;
color dark = #e09f3e;
color red = #9e2a2b;
color darkred = #540b0e;
color green = #619b8a;

int INTRO = 0;
int GAME = 1;
int PAUSE = 2;
int GAMEOVER = 3;

int mode = INTRO;

PImage[] gifFrames;
int gifIndex = 0;

int score = 0;
int lives = 3;

float ballX, ballY, ballVX, ballVY;
float ballR = 20;
float ballSpeed;

float paddleX, paddleY;
float paddleW = 100;
float paddleH = 15;
float paddleSpeed;

boolean leftPressed = false;
boolean rightPressed = false;

boolean[][] bricks;
int rows = 5;
int cols = 8;
int brickD = 40;
color[] rowColors;

int numOfFrames = 7;
PFont font;

void setup() {
  size(475, 550);
  gifFrames = new PImage[numOfFrames];
  int i = 0;
  while (i < numOfFrames) {
    gifFrames[i] = loadImage("frame_" + i + "_delay-0.1s.gif");
    i++;
  }

  font = createFont("Arial", 32);
  textFont(font);
  rowColors = new color[] { red, or, orange, yellow, lb };
  resetGame();

  bounce = new SoundFile(this, "SUCCESS.wav");
  fail = new SoundFile(this, "FAILURE.wav");
  music = new SoundFile(this, "MUSIC.mp3");
  music.loop();
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
  gifIndex = (gifIndex + 1) % numOfFrames;
  fill(white);
  textAlign(CENTER);
  textSize(40);
  text("Breakout", width / 2, height / 2 - 40);
}

void playGame() {
  if (leftPressed) paddleX -= paddleSpeed;
  if (rightPressed) paddleX += paddleSpeed;
if (paddleX < 0) {
  paddleX = 0;
} else if (paddleX > width - paddleW) {
  paddleX = width - paddleW;
}


  moveBall();
  drawPaddle();
  drawBall();
  drawBricks();
  drawStats();
}

void pauseGame() {
  image(gifFrames[gifIndex], 0, 0, width, height);
  gifIndex = (gifIndex + 1) % numOfFrames;
  fill(midwhite);
  textAlign(CENTER);
  textSize(32);
  text("Paused. Click to resume.", width / 2, height / 2);
}

void showGameOver() {
  image(gifFrames[gifIndex], 0, 0, width, height);
  gifIndex = (gifIndex + 1) % numOfFrames;
  fill(white);
  textAlign(CENTER);
  textSize(40);
  if (score >= rows * cols) {
    text("YOU WIN!", width / 2, height / 2);
  } else {
    text("GAME OVER!", width / 2, height / 2);
  }
  textSize(20);
  text("Click to restart.", width / 2, height / 2 + 40);
}

void moveBall() {
  ballX += ballVX;
  ballY += ballVY;

  if (ballX < 0 || ballX > width) {
    ballVX *= -1;
    bounce.play();
  }
  if (ballY < 0) {
    ballVY *= -1;
    bounce.play();
  }

  checkPaddleCollision();  

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

          // Speed up 
          ballVX *= 1.15;
          ballVY *= 1.15;

          bounce.play();
        }
      }
      c++;
    }
    r++;
  }

  if (score >= rows * cols) {
    if (!bounce.isPlaying()) {
      bounce.play();
      music.stop();
    }
    mode = GAMEOVER;
  }

  if (ballY > height) {
    lives--;
    if (lives <= 0) {
      mode = GAMEOVER;
      if (!fail.isPlaying()) {
        fail.play();
        music.stop();
      }
    } else resetBall();
  }
}


void drawPaddle() {
  paddleY = height - 60;
  fill(DB);
  ellipse(paddleX + paddleW / 2, paddleY + paddleH / 2, paddleW, paddleW);
}

void checkPaddleCollision() {
  float paddleCenterX = paddleX + paddleW / 2;
  float paddleCenterY = paddleY + paddleH / 2;
  if (dist(ballX, ballY, paddleCenterX, paddleCenterY) < (paddleW / 2 + ballR / 2)) {
    float dx = ballX - paddleCenterX;
    float dy = ballY - paddleCenterY;
    ballVX = dx / 10;
    ballVY = dy / 10;
    bounce.play();
  }
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

  ballSpeed = random(3, 6);
  paddleSpeed = random(4, 8);

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
  ballVX = random(-ballSpeed, ballSpeed);
  ballVY = ballSpeed;
}

void mousePressed() {
  if (mode == INTRO) mode = GAME;
  else if (mode == PAUSE) mode = GAME;
  else if (mode == GAMEOVER) {
    resetGame();
    music.loop();
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
