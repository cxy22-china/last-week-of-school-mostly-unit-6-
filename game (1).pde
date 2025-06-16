void clickgame(){
  mode=1;
}

void game(){
  speed+=0.001;
  background(back);
  strokeWeight(3);
  stroke(p3);

  fill(p2);
  circle(playerx, playery, playerd);
  int i=0;
  while (i<n){
    if (alive[i]==true){
      managebricks(i);
    }
    i++;
  }
  //KEY CODE
  if (leftKey && playerx>=0) playerx -= 5;
  if (rightKey && playerx<=600) playerx += 5;
  if (upKey && playery>=650) playery -= 5;
  if (downKey && playery<=1000) playery += 5;

  if (playery<750){
    stroke((750-playery)/100*255);
    line(0,599,600,599);
  }
  
  strokeWeight(5);
  stroke(0);
  fill(255);
  circle(ballx, bally, balld);



  ////velocity + acceleration = gravity
  //vx += ax;
  //vy += ay;


  //movement
  ballx += vx*(1+speed);
  bally += vy*(1+speed);


  //if (ballx <= balld/2 || ballx >= width - balld/2) vx = -vx;
  //if (bally <= balld/2 || bally >= height - balld/2) vx = -vx;
 
  //bouncing off the walls
  if (bally <= balld/2) { // top
    vy = vy * -1; //positive * negative = negative
   bally = balld/2; // when the ball is outside the walls this ensures bally is set back to within the walls,
   
   // if bally was <= to balld/2 wouldn't the computer bounce the ball as soon as it is equal to?
   // unless the number when bally touches the wall isn't an int and has to go to the nearest int for it to perform a task cuz int can't = float
  }
 
  if (bally >= height - balld/2){ //bottom
    vy = vy * -1; //reverse the vy. Negative * negative = positive
   bally = height - balld/2 ;
   
  }
  if (ballx <= balld/2){// right
    vx = vx * -1;
   ballx = balld/2;
  }
 
  if (ballx >= width - balld/2 ){ //left
    vx = vx * -1; //reverse the vx
   ballx = width - balld/2;
  }
  
  
  if (dist(playerx,playery,ballx,bally)<=playerd/2+balld/2){
    vx=(ballx-playerx)/8;
    vy=(bally-playery)/8;
  }

  if ( height<=bally+balld/2){
    lives--;
    speed=0;
    ballx=width/2;
    bally=height/2+200;
    fail.play();
  }
  
  
  textSize(30);
  textAlign(CENTER,0);
  fill(255);
  textFont(IF);
  text("score "+score,80,970);
  text("lives "+lives,520,970);
  
}

void managebricks(int i){
  fill(c[i/6]);
  stroke(255);
  circle(x[i],y[i],brickd);
  star(x[i],y[i],c[i/6]);
  if (dist(ballx,bally,x[i],y[i])<balld/2+brickd/2){
    vx=(ballx-x[i])/8;
    vy=(bally-y[i])/8;
    alive[i]=false;
    success.play();
    score++;
  }
}

void star(float x,float y,color fill){
  pushMatrix();
  translate(x,y);
  stroke(255);
  scale(0.2);
  fill(fill);
  circle(0,0,200);
  circle(0,0,170);
  circle(0,0,140);
  circle(0,0,110);
  int t=0;
  fill(255);
  while (t<8){
    fill(255);
    triangle(-10,0,10,0,0,-100);
    rotate(PI/4);
    t++;
  }
  popMatrix();
}
