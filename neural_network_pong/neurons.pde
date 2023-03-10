//c reference to bias level, D refers to down, U to up
class nnBrain {
  float outputU;
  float biasU;
  float p1ycU;
  float p2ycU;
  float ballxcU;
  float ballycU;
  float ballSpeedXcU;
  float ballSpeedYcU;
  float ballSpeedcU;
  float hitscU;
  float outputD;
  float biasD;
  float p1ycD;
  float p2ycD;
  float ballxcD;
  float ballycD;
  float ballSpeedXcD;
  float ballSpeedYcD;
  float ballSpeedcD;
  float hitscD;
  int score;
  nnBrain (float a, float b, float c, float d, float e, float f, float g, float h, float i, float j, float k, float l, float m, float n, float o, float p, float q, float r, float s, float t) {
    outputU = a;
    biasU = b;
    p1ycU = c;
    p2ycU = d;
    ballxcU = e;
    ballycU = f;
    ballSpeedXcU = g;
    ballSpeedYcU = h;
    ballSpeedcU = i;
    hitscU = j;
    outputD = k;
    biasD = l;
    p1ycD = m;
    p2ycD = n;
    ballxcD = o;
    ballycD = p;
    ballSpeedXcD = q;
    ballSpeedYcD = r;
    ballSpeedcD = s;
    hitscD = t;
  }
  void reinit() {
    outputU = 0;
    biasU = random(0,1);
    p1ycU = random(0,1);
    p2ycU = random(0,1);
    ballxcU = random(0,1);
    ballycU = random(0,1);
    ballSpeedXcU = random(0,1);
    ballSpeedYcU = random(0,1);
    ballSpeedcU = random(0,1);
    hitscU = random(0,1);
    outputD = 0;
    biasD = random(0,1);
    p1ycD = random(0,1);
    p2ycD = random(0,1);
    ballxcD = random(0,1);
    ballycD = random(0,1);
    ballSpeedXcD = random(0,1);
    ballSpeedYcD = random(0,1);
    ballSpeedcD = random(0,1);
    hitscD = random(0,1);
  }
  void update() {
    score = hits;
    outputU = 0;
    outputD = 0;
    outputU = outputU + (1 * (p1y * p1ycU) + (p2y * p2ycU) + (ballx * ballxcU) + (bally * ballycU) + (ballSpeedX * ballSpeedXcU) + (ballSpeedY * ballSpeedYcU));
    outputD = outputD + (1 * (p1y * p1ycD) + (p2y * p2ycD) + (ballx * ballxcD) + (bally * ballycD) + (ballSpeedX * ballSpeedXcD) + (ballSpeedY * ballSpeedYcD));
  }
}
