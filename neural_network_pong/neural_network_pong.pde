//////
//
//
//////
node0 n0_0 = new node0(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
node0 n0_1 = new node0(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
//node0 n0_2 = new node0(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
//node0 n0_3 = new node0(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
//node0 n0_4 = new node0(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
//node0 n0_5 = new node0(0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

void setup() {
  size(600, 600);
  setBallAngle();
  reinitNodes();
}

void draw() {
  background(0);
  drawGame();
  updateBallAngle();
  updateNodes();
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
  text("permutation: " + permutation, 250, 60);
  text("generation: " + generation, 250, 80);
  text("up: " + n0_0.outputU, 250, 100);
  text("down: " + n0_1.outputD, 250, 120);
}

void moveBall() {
  ballx = ballx + ballSpeedX;
  bally = bally + ballSpeedY;
  //ballCollision
  if (ballx >= 560 && ballx <= 580 && bally >= p2y && bally <= (p2y + 120)) {
    ballDirX = false;
    hits++;
  }
  if (ballx >= 20 && ballx <= 40 && bally >= p1y && bally <= (p1y + 120)) { //<>//
    ballDirX = true;
    hits++;
  }
  if (bally >= 590) ballDirY = false;
  if (bally <= 10) ballDirY = true;
  
  //update ball speed based on hits
  ballSpeed = 5 * ((hits / 2)+1);
  
  //ball scoring
  if (ballx <= -10) { //ball hit left side out zone
    scoreArray[scoreArrayIndex] = p1score;
    scoreArrayIndex++;
    p1score = 0;
    reinitNodes();
    reinitVars();
    permutation++;
    ballSpeedX = 1;
    ballSpeedY = 1;
    hits = 0;
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
  float ballControl = (bally - (p2y + 50));
  if (ballControl > 10) ballControl = 20;
  else if (ballControl < -10) ballControl = -20;
  p2y = p2y + ballControl;
  
  /*if (bally > p2y + 50) p2y = p2y + 5;
  else if (bally > p2y + 150) p2y = p2y + 10;
  if (bally < (p2y + 50)) p2y = p2y - 5;
  else if (bally < (p2y + 150)) p2y = p2y - 10;*/
  if (p2y <= 0) p2y = 0;
  if (p2y >= 500) p2y = 500;
}

void resolveNodes() { //this moves the nn paddle up or down
  if (n0_0.outputU > n0_0.outputD) p1y = p1y - 10;
  else p1y = p1y + 10;
  
  if (p1y <= 0) p1y = 0;
  if (p1y >= 500) p1y = 500;
}
