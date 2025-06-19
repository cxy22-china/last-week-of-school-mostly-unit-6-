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

int numOfFrames = 7; 
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
