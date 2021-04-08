import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class neural_network_pong extends PApplet {

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

public void setup() {
  
  setBallAngle();
  reinitNodes();
}

public void draw() {
  background(0);
  drawGame();
  updateBallAngle();
  updateNodes();
  moveBall();
  if (realPlayer == false) moveBasicAI();
  resolveNodes();
}

public void setBallAngle() {
  ballAngle = random(0.25f, 0.90f);
}

public void updateBallAngle() {
  if (ballDirX == true) ballSpeedX = ballSpeed * ballAngle;
  else ballSpeedX = -1*((ballSpeed) * ballAngle);
  if (ballDirY == true) ballSpeedY = ballSpeed * (1 - ballAngle);
  else ballSpeedY = -1 * ((ballSpeed * (1 - ballAngle)));
}

public void drawGame() {
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
  text("up: " + n0_0.output, 250, 100);
  text("down: " + n0_1.output, 250, 120);
}

public void moveBall() {
  ballx = ballx + ballSpeedX;
  bally = bally + ballSpeedY;
  //ballCollision
  if (ballx >= 560 && ballx <= 580 && bally >= p2y && bally <= (p2y + 120)) ballDirX = false;
  if (ballx >= 20 && ballx <= 40 && bally >= p1y && bally <= (p1y + 120)) ballDirX = true;
  if (bally >= 590) ballDirY = false;
  if (bally <= 10) ballDirY = true;
  
  //ball scoring
  if (ballx <= -10) {
    p1score = 0;
    reinitNodes();
    reinitVars();
    permutation++;
  }
}

public void moveBasicAI() {
  if (bally > p2y + 50) p2y = p2y + 5;
  if (bally < (p2y + 50)) p2y = p2y - 5;
  if (p2y <= 0) p2y = 0;
  if (p2y >= 500) p2y = 500;
}

public void resolveNodes() { //simple ver
  if (n0_0.output > n0_1.output) p1y = p1y - 5;
  else p1y = p1y + 5;
  if (p1y <= 0) p1y = 0;
  if (p1y >= 500) p1y = 500;
}
public void reinitNodes() {
  //l0
  n0_0.reinit();
  n0_1.reinit();
  n0_2.reinit();
  n0_3.reinit();
  n0_4.reinit();
  n0_5.reinit();
}

public void reinitVars() {
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

public void updateNodes() {
  //layer 0
  n0_0.update();
  n0_1.update();
  n0_2.update();
  n0_3.update();
  n0_4.update();
  n0_5.update();
}

public void reproduceCheck() {
}
class node0 {
  float output;
  float bias;
  float p1yc;
  float p2yc;
  float ballxc;
  float ballyc;
  float ballSpeedXc;
  float ballSpeedYc;
  int score = p1score;
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
  public void reinit() {
    output = 0;
    bias = random(0,1);
    p1yc = random(0,1);
    p2yc = random(0,1);
    ballxc = random(0,1);
    ballyc = random(0,1);
    ballSpeedXc = random(0,1);
    ballSpeedYc = random(0,1);
  }
  public void update() {
    output = 0;
    output = output + (bias * (p1y * p1yc) + (p2y * p2yc) + (ballx * ballxc) + (bally * ballyc) + (ballSpeedX * ballSpeedXc) + (ballSpeedY * ballSpeedY));
  }
}
public void keyPressed() {
  if (keyCode == ENTER) {
    reinitNodes();
    reinitVars();
  }
}
float p1y = 250;
float p2y = 250;
float ballx = 290;
float bally = 290;
float ballSpeedX = 1;
float ballSpeedY = 1;
float ballSpeed = 5;
float ballAngle = 0; //used as a percentage of 25-75%
boolean ballDirX = true; //whether the ball is heading left or right
boolean ballDirY = false;

int p1score = 0;
int p2score = 0;
int p1highscore = 0;
int permutation = 0;
int generation = 0;

boolean realPlayer = false; //determines whether the user is playing or a basic ai

  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "neural_network_pong" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
