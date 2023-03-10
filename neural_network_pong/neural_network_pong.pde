//////
//
//
//////
nnBrain n0_0 = new nnBrain(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
nnBrain n0_1 = new nnBrain(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
nnBrain n0_2 = new nnBrain(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
nnBrain n0_3 = new nnBrain(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
nnBrain n0_4 = new nnBrain(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

void setup() {
  size(600, 600);
  setBallAngle();
  reinitBrain(0);
  reinitBrain(1);
  reinitBrain(2);
  reinitBrain(3);
  reinitBrain(4);
}

void draw() {
  background(0);
  drawGame();
  updateBallAngle();
  updateBrains(currentPerm);
  moveBall();
  if (realPlayer == false) moveBasicAI();
  resolveNodes();
}

void setBallAngle() {
  ballAngle = random(0.25, 0.90);
}

void updateBallAngle() {
  if (ballDirX == true) ballSpeedX = ballSpeed * ballAngle;
  else ballSpeedX = -1*((ballSpeed) * ballAngle);
  if (ballDirY == true) ballSpeedY = ballSpeed * (1 - ballAngle);
  else ballSpeedY = -1 * ((ballSpeed * (1 - ballAngle)));
}

void drawGame() {
  //draw left paddle
  rect(20, p1y, 10, 100);
  //draw right paddle
  rect(570, p2y, 10, 100);
  //draw ball
  ellipse(ballx, bally, 20, 20);
  
  //draw text
  text("nn score: " + p1score, 250, 20);
  text("nn highscore: " + p1highscore, 250, 40);
  text("total permutations: " + permutation, 250, 60);
  text("current permutation: " + currentPerm, 250,80);
  text("generation: " + generation, 250, 100);
  text("nn hits: " + hits, 250, 120);
  if (currentPerm == 0) {
    text("up: " + n0_0.outputU, 250, 140);
    text("down: " + n0_0.outputD, 250, 160);
  } else if (currentPerm == 1) {
    text("up: " + n0_1.outputU, 250, 140);
    text("down: " + n0_1.outputD, 250, 160);
  } else if (currentPerm == 2) {
    text("up: " + n0_2.outputU, 250, 140);
    text("down: " + n0_2.outputD, 250, 160);
  } else if (currentPerm == 3) {
    text("up: " + n0_3.outputU, 250, 140);
    text("down: " + n0_3.outputD, 250, 160);
  } else if (currentPerm == 4) {
    text("up: " + n0_4.outputU, 250, 140);
    text("down: " + n0_4.outputD, 250, 160);
  }
}

void moveBall() {
  ballx = ballx + ballSpeedX;
  bally = bally + ballSpeedY;
  //ballCollision
  if (ballx >= 560 && ballx <= 580 && bally >= p2y && bally <= (p2y + 120)) {
    ballDirX = false;
    //hits++;
  }
  if (ballx >= 20 && ballx <= 40 && bally >= p1y && bally <= (p1y + 120)) { //<>//
    ballDirX = true;
    hits++;
  }
  if (bally >= 590) ballDirY = false;
  if (bally <= 10) ballDirY = true;
  
  //update ball speed based on hits
  ballSpeed = 5 * ((hits / 5)+1);
  
  //ball scoring
  if (ballx <= -10) { //ball hit left side out zone
    scoreArray[scoreArrayIndex] = p1score;
    reinitVars();
    permutation++;
    ballSpeedX = 1;
    ballSpeedY = 1;
    if (hits == 0) { //if nn ai did not hit the ball
      
      reinitBrain(currentPerm); //re-roll current ai and continue
    } else { //if ai hit the ball
      if (currentPerm < 4) currentPerm++; //advance to next permutation
      else reproduceNewGen(); //TODO, NEXT GEN
    }
    hits = 0; //reset hit counter
    p1score = 0;
  } else if (ballx >= 590) { //ball hit right side out zone
    p1score++;
    if (p1score > p1highscore) p1highscore = p1score;
    p1y = 250;
    p2y = 250;
    ballx = 290;
    bally = 290;
    ballSpeedX = 1;
    ballSpeedY = 1;
    ballSpeed = 5;
    ballDirX = true;
    setBallAngle();
    if ((int)random(2) == 1) ballDirY = false;
    else ballDirY = true;
  }
}

void moveBasicAI() {
  float ballControl = (bally - (p2y + 50)); //get difference between paddle and ball
  if (ballControl > 10) ballControl = 20; //limit down speed to 20px/s
  else if (ballControl < -10) ballControl = -20; //limit up speed to 20px/s
  p2y = p2y + ballControl; //add speed to y
  
  /*if (bally > p2y + 50) p2y = p2y + 5;
  else if (bally > p2y + 150) p2y = p2y + 10;
  if (bally < (p2y + 50)) p2y = p2y - 5;
  else if (bally < (p2y + 150)) p2y = p2y - 10;*/
  if (p2y <= 0) p2y = 0; //limit y to play area top
  if (p2y >= 500) p2y = 500; //limit y to play area bottom
}

void resolveNodes() { //this moves the nn paddle up or down
  if (currentPerm == 0) {
    if (n0_0.outputU > n0_0.outputD) p1y = p1y - 10;
    else p1y = p1y + 10;
  } else if (currentPerm == 1) {
    if (n0_1.outputU > n0_1.outputD) p1y = p1y - 10;
    else p1y = p1y + 10;
  } else if (currentPerm == 2) {
    if (n0_2.outputU > n0_2.outputD) p1y = p1y - 10;
    else p1y = p1y + 10;
  } else if (currentPerm == 3) {
    if (n0_3.outputU > n0_3.outputD) p1y = p1y - 10;
    else p1y = p1y + 10;
  } else if (currentPerm == 4) {
    if (n0_4.outputU > n0_4.outputD) p1y = p1y - 10;
    else p1y = p1y + 10;
  }
  
  if (p1y <= 0) p1y = 0;
  if (p1y >= 500) p1y = 500;
}
