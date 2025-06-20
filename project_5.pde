import processing.sound.*;

SoundFile fail;
SoundFile success;
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

int mode = 0; // 0 = INTRO, 1 = GAME, 2 = PAUSE, 3 = GAMEOVER
boolean ai = false;

float leftY, rightY;
boolean wPressed = false, sPressed = false;
boolean upPressed = false, downPressed = false;
float paddleSpeed = 5;
float paddleRadius = 40;

float ballX, ballY, ballSpeedX, ballSpeedY;
float ballRadius = 25;
int delayCounter = 0;

int leftScore = 0;
int rightScore = 0;

// GIF variables
PImage[] gifFrames;
int gifIndex = 0;
int totalFrames = 7; 

void setup() {
  size(800, 600);

  int numOfFrames = 10; 
  gifFrames = new PImage[numOfFrames];
  int i = 0;
  while (i < numOfFrames) {
    gifFrames[i] = loadImage("frame_" + i + "_delay-0.1s.gif");
    i++;
  }

  fail = new SoundFile(this, "FAILURE.wav");
  success = new SoundFile(this, "SUCCESS.wav");
  music = new SoundFile(this, "MUSIC.mp3");

  if (music != null) music.loop();

  resetGame();
}


void draw() {
  background(green);

  if (mode == 0) intro();
  else if (mode == 1) game();
  else if (mode == 2) pause();
  else if (mode == 3) gameover();
}

void intro() {
  if (gifFrames != null && gifFrames[gifIndex] != null) {
    image(gifFrames[gifIndex], 0, 0, width, height);
    gifIndex = (gifIndex + 1) % totalFrames;
  }

  fill(lightyellow);
  textAlign(CENTER);
  textSize(25);
  text("Welcome to Pong!", width / 2, height / 4);
  text("left click if you have no friends     right click if you have friends", width / 2, height / 2);
}

void pause() {
  fill(lightyellow);
  textAlign(CENTER);
  textSize(32);
  text("Paused - Click to Resume", width / 2, height / 2);
}

void gameover() {
  fill(midwhite); 
  textAlign(CENTER);
  textSize(20);
  if (leftScore > rightScore) {
    text("Left Player Wins!", width / 2, height / 2);
  } else {
    text("Right Player Wins!", width / 2, height / 2);
  }
  text("Click to restart", width / 2, height / 2 + 40);

  if (fail != null && !fail.isPlaying()) {
    fail.play();
  }
  if (music != null && music.isPlaying()) {
    music.stop();
  }
}

void game() {
  fill(orange);
  ellipse(ballX, ballY, 35, 35);

  fill(ldb);
  ellipse(50, leftY, 75, 75);
  fill(red);
  ellipse(width - 50, rightY, 75, 75);

  textSize(32);
  fill(midwhite); 
  text(leftScore, 275, 50);
  text(rightScore, 525, 50);

  if (delayCounter == 0) {
    ballX += ballSpeedX;
    ballY += ballSpeedY;
  } else {
    delayCounter--;
  }

  if (wPressed) leftY -= paddleSpeed;
  if (sPressed) leftY += paddleSpeed;

  if (!ai) {
    if (upPressed) rightY -= paddleSpeed;
    if (downPressed) rightY += paddleSpeed;
  } else {
    if (ballX > width / 2) {
      if (ballY < rightY) rightY -= paddleSpeed;
      else if (ballY > rightY) rightY += paddleSpeed;
    }
  }

if (leftY < paddleRadius) {
  leftY = paddleRadius;
} else if (leftY > height - paddleRadius) {
  leftY = height - paddleRadius;
}

if (rightY < paddleRadius) {
  rightY = paddleRadius;
} else if (rightY > height - paddleRadius) {
  rightY = height - paddleRadius;
}

  if (ballY < ballRadius || ballY > height - ballRadius) {
    ballSpeedY *= -1;
  }

  if (dist(ballX, ballY, 50, leftY) < (paddleRadius + ballRadius / 2)) {
    float dx = ballX - 50;
    float dy = ballY - leftY;
    ballSpeedX = dx / 10;
    ballSpeedY = dy / 10;
    if (success != null) success.play();
  }

  if (dist(ballX, ballY, width - 50, rightY) < (paddleRadius + ballRadius / 2)) {
    float dx = ballX - (width - 50);
    float dy = ballY - rightY;
    ballSpeedX = dx / 10;
    ballSpeedY = dy / 10;
    if (success != null) success.play();
  }

  if (ballX < 0) {
    rightScore++;
    resetBall();
    if (success != null) success.play();
  } else if (ballX > width) {
    leftScore++;
    resetBall();
    if (success != null) success.play();
  }

  if (leftScore == 3 || rightScore == 3) {
    mode = 3;
  }
}

void resetBall() {
  ballX = width / 2;
  ballY = height / 2;
  ballSpeedX = random(1, 7);
  ballSpeedY = random(1, 7);
  delayCounter = 87;
}

void resetGame() {
  leftY = height / 2;
  rightY = height / 2;
  leftScore = 0;
  rightScore = 0;
  paddleSpeed = random(2, 8);  
  resetBall();
}

void mousePressed() {
  if (mode == 0) {
    ai = (mouseX < width / 2);
    resetGame();
    mode = 1;
  } else if (mode == 2) {
    mode = 1;
  } else if (mode == 3) {
    if (music != null) music.loop();
    mode = 0;
  }
}

void keyPressed() {
  if (key == 'w') wPressed = true;
  if (key == 's') sPressed = true;
  if (keyCode == UP) upPressed = true;
  if (keyCode == DOWN) downPressed = true;
  if (key == 'p') mode = 2;
}

void keyReleased() {
  if (key == 'w') wPressed = false;
  if (key == 's') sPressed = false;
  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
}
