class node0 {
  float output;
  float bias;
  float p1yc;
  float p2yc;
  float ballxc;
  float ballyc;
  float ballSpeedXc;
  float ballSpeedYc;
  node0 (float a, float b, float c, float d, float e, float f, float g, float h) {
    output = a;
    bias = b;
    p1yc = c;
    p2yc = d;
    ballxc = e;
    ballyc = f;
    ballSpeedXc = g;
    ballSpeedYc = h;
  }
  void reinit() {
    output = 0;
    bias = random(0,1);
    p1yc = random(0,1);
    p2yc = random(0,1);
    ballxc = random(0,1);
    ballyc = random(0,1);
    ballSpeedXc = random(0,1);
    ballSpeedYc = random(0,1);
  }
  void update() {
    output = 0;
    output = output + (bias * (p1y * p1yc) + (p2y * p2yc) + (ballx * ballxc) + (bally * ballyc) + (ballSpeedX * ballSpeedXc) + (ballSpeedY * ballSpeedY));
  }
}
