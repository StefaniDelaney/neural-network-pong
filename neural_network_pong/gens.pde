void reinitBrain(int index) {
  if (index == 0) n0_0.reinit();
  else if (index == 1) n0_1.reinit();
  else if (index == 2) n0_2.reinit();
  else if (index == 3) n0_3.reinit();
  else if (index == 4) n0_4.reinit();
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

void updateBrains(int index) {
  if (index == 0) n0_0.update();
  else if (index == 1) n0_1.update();
  else if (index == 2) n0_2.update();
  else if (index == 3) n0_3.update();
  else if (index == 4) n0_4.update();
}

void reproduceNewGen() { //check which one has highest score
  int nnHighscore = 0;
  int index = 0;
  if (n0_0.score > nnHighscore) {
    nnHighscore = n0_0.score;
    index = 0;
  } else if (n0_1.score > nnHighscore) {
    nnHighscore = n0_1.score;
    index = 1;
  } else if (n0_2.score > nnHighscore) {
    nnHighscore = n0_2.score;
    index = 2;
  } else if (n0_3.score > nnHighscore) {
    nnHighscore = n0_3.score;
    index = 3;
  } else if (n0_4.score > nnHighscore) {
    nnHighscore = n0_4.score;
    index = 4;
  }
  println("winner: " + index);
  println("score: " + nnHighscore);
}
