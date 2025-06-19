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
int frameTotal = 6; 

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


