//////
//
//
//////
node0 n0_0 = new node0(0, 0, 0, 0, 0, 0, 0, 0);
node0 n0_1 = new node0(0, 0, 0, 0, 0, 0, 0, 0);
node0 n0_2 = new node0(0, 0, 0, 0, 0, 0, 0, 0);
node0 n0_3 = new node0(0, 0, 0, 0, 0, 0, 0, 0);
node0 n0_4 = new node0(0, 0, 0, 0, 0, 0, 0, 0);
node0 n0_5 = new node0(0, 0, 0, 0, 0, 0, 0, 0);

void setup() {
  size(600, 600);
  setBallAngle();
}

void draw() {
  background(0);
  drawGame();
  updateBallAngle();
  moveBall();
  if (realPlayer == false) moveBasicAI();
}

void setBallAngle() {
  ballAngle = random(0.25, 0.90);
}

void updateBallAngle() {
  if (ballDirX == true) ballSpeedX = ballSpeed * ballAngle;
  else ballSpeedX = -1*(ballSpeed * ballAngle);
  if (ballDirY == true) ballSpeedY = ballSpeed * (1 - ballAngle);
  else ballSpeedY = -1 * (ballSpeed * (1 - ballAngle));
}

void drawGame() {
  //draw left paddle
  rect(20, p1y, 10, 100);
  //draw right paddle
  rect(570, p2y, 10, 100);
  //draw ball
  ellipse(ballx, bally, 20, 20);
}

void moveBall() {
  ballx = ballx + ballSpeedX;
  bally = bally + ballSpeedY;
  //ballCollision
  if (ballx >= 550 && ballx <= 560 && bally >= p2y && bally <= (p2y + 120)) ballDirX = false;
  if (ballx >= 20 && ballx <= 30 && bally >= p1y && bally <= (p1y + 120)) ballDirX = true; //<>//
  if (bally >= 580) ballDirY = false;
  if (bally <= 20) ballDirY = true;
}

void moveBasicAI() {
  if (bally >= p2y) p2y = p2y + 1;
  if (bally <= (p2y + 100)) p2y = p2y - 1;
}
