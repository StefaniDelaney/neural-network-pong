void reinitNodes() {
  //l0
  n0_0.reinit();
  n0_1.reinit();
  n0_2.reinit();
  n0_3.reinit();
  n0_4.reinit();
  n0_5.reinit();
}

void reinitVars() {
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
  p1score = 0;
  p2score = 0;
}

void updateNodes() {
  //layer 0
  n0_0.update();
  n0_1.update();
  n0_2.update();
  n0_3.update();
  n0_4.update();
  n0_5.update();
}

void reproduceCheck() {
}
