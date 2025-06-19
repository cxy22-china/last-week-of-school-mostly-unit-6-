void showGameOver() {
  fill(white);
  textAlign(CENTER);
  textSize(40);
 if(score >= rows * cols){
    text("You win", width/2, height/2);
}
else{
    text("GAME OVER!", width / 2, height / 2);
}
  textSize(20);
  text("Click to restart.", width / 2, height / 2 + 40);
}
