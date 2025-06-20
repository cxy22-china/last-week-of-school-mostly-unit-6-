
//void game() {
//fill(orange); 
//  ellipse(ballX, ballY, 35, 35);//game ball
// fill(ldb);
//  ellipse(50, leftY, 75, 75);
//  fill(red);
//  ellipse(width - 50, rightY, 75, 75);
//  textSize(32);
//  fill(midwhite); 
//  text(leftScore, 275, 50);
//  text(rightScore, 525, 50);

//  // Ball 
//  if (delayCounter == 0) {
//    ballX += ballSpeedX;
//    ballY += ballSpeedY;
//  } else {
//    delayCounter--;
//  }

//  //  controls
//  if (wPressed) leftY -= random(3, 6);
//  if (sPressed) leftY += random(3, 6);
//  if (!ai) {
//    if (upPressed) rightY -= paddleSpeed;
//    if (downPressed) rightY += paddleSpeed;
//  } else {
//    if (ballX > width/2) {
//      if (ballY < rightY) rightY -= paddleSpeed;
//      else if (ballY > rightY) rightY += paddleSpeed;
//    }
//  }

//if (leftY < paddleRadius) leftY = paddleRadius;
//if (leftY > height - paddleRadius) leftY = height - paddleRadius;

//if (rightY < paddleRadius) rightY = paddleRadius;
//if (rightY > height - paddleRadius) rightY = height - paddleRadius;


//  // Bounce ball 
//  if (ballY < ballRadius || ballY > height - ballRadius) ballSpeedY *= -1;

//  // Paddle 
//  if (dist(ballX, ballY, 50, leftY) <  paddleRadius) ballSpeedX *= -1;
//  if (dist(ballX, ballY, width- 50, rightY) <  paddleRadius) ballSpeedX *= -1;

//  // Scoring
//  if (ballX < 0) {
//    rightScore++;
//    resetBall();
//  }
//  if (ballX > width) {
//    leftScore++;
//    resetBall();
//  }

//  // Win 
//  if (leftScore == 3 || rightScore == 3) mode = 3;
//}
//void resetBall() {
//  ballX = width/2;
//  ballY = height/2;
//  ballSpeedX = random(2, 5) ;
//  ballSpeedY = random(2, 5);
//  delayCounter = 87;
//}

//void resetGame() {
//  leftY = height/2;
//  rightY = height/2;
//  leftScore = 0;
//  rightScore = 0;
//  resetBall();
//}
