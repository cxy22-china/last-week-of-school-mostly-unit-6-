// Breakout Game Main Project

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
int frameTotal = 50;

int score = 0;
int lives = 3;

float ballX, ballY, ballVX, ballVY;
float ballR = 20;

float paddleX, paddleY;
float paddleW = 100;
float paddleH = 15;

boolean leftPressed = false;
boolean rightPressed = false;

boolean[][] bricks;
int rows = 5;
int cols = 8;
int brickD = 40;
color[] rowColors;

int numOfFrames = 7; // assumed default for demo purposes
PFont font;

void setup() {
  size(475, 500);
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

//void pauseGame() {
//  fill(midwhite);
//  textAlign(CENTER);
//  textSize(32);
//  text("Paused. Click to resume.", width / 2, height / 2);
//}

//void showGameOver() {
//  fill(white);
//  textAlign(CENTER);
//  textSize(40);
// if(score >= rows * cols){
//    text("You win", width/2, height/2);
//}
//else{
//    text("GAME OVER!", width / 2, height / 2);
//}
//  textSize(20);
//  text("Click to restart.", width / 2, height / 2 + 40);
//}

//void moveBall() {
//  ballX += ballVX;
//  ballY += ballVY;

//  if (ballX < 0 || ballX > width) ballVX *= -1;
//  if (ballY < 0) ballVY *= -1;

//  if (ballY + ballR / 2 >= paddleY && ballY <= paddleY + paddleH && ballX >= paddleX && ballX <= paddleX + paddleW) {
//    ballVY *= -1;
//  }

//  int r = 0;
//while (r < rows) {
//  int c = 0;
//  while (c < cols) {
//    if (bricks[r][c]) {
//      float brickX = c * (brickD + 10) + 50;
//      float brickY = r * (brickD + 10) + 50;
//      if (dist(ballX, ballY, brickX, brickY) < (brickD / 2 + ballR / 2)) {
//        bricks[r][c] = false;
//        ballVY *= -1;
//        score++;
//      }
//    }
//    c++;
//  }
//  r++;
//}

//  if (ballY > height) {
//    lives--;
//    if (lives <= 0) mode = GAMEOVER;
//    else resetBall();
//  }
//}

//void drawPaddle() {
//  paddleY = height - 60;
//  fill(DB);
//  rect(paddleX, paddleY, paddleW, paddleH);
//}

//void drawBall() {
//  fill(white);
//  ellipse(ballX, ballY, ballR, ballR);
//}

//void drawBricks() {
//  int r = 0;
//  while (r < rows) {
//    int c = 0;
//    while (c < cols) {
//      if (bricks[r][c]) {
//        float x = c * (brickD + 10) + 50;
//        float y = r * (brickD + 10) + 50;
//        fill(rowColors[r % rowColors.length]);
//        ellipse(x, y, brickD, brickD);
//      }
//      c++;
//    }
//    r++;
//  }
//}


//void drawStats() {
//  fill(white);
//  textSize(20);
//  text("Score: " + score, 70, 30);
//  text("Lives: " + lives, 70, 60);
//}

//void resetGame() {
//  score = 0;
//  lives = 3;
//  paddleX = width / 2 - paddleW / 2;
//  paddleY = height - 60;
//  resetBall();

//  bricks = new boolean[rows][cols];
//  int r = 0;
//while (r < rows) {
//  int c = 0;
//  while (c < cols) {
//    bricks[r][c] = true;
//    c++;
//  }
//  r++;
//}
//}

//void resetBall() {
//  ballX = width / 2;
//  ballY = height / 2;
//  ballVX = random(-4, 4);
//  ballVY = 5;
//}

//void mousePressed() {
//  if (mode == INTRO) mode = GAME;
//  else if (mode == PAUSE) mode = GAME;
//  else if (mode == GAMEOVER) {
//    resetGame();
//    mode = INTRO;
//  }
//}

//void keyPressed() {
//  if (mode == GAME) {
//    if (key == 'a' || key == 'A') leftPressed = true;
//    if (key == 'd' || key == 'D') rightPressed = true;
//  }
//  if (key == 'p' || key == 'P') mode = PAUSE;
//}

//void keyReleased() {
//  if (key == 'a' || key == 'A') leftPressed = false;
//  if (key == 'd' || key == 'D') rightPressed = false;
//}
