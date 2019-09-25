final int BRANCH_DEPTH = 6;
final float LENGTH_MIN = 400;
final float LENGTH_MAX = 500;
final float LENGTH_DAMP_FACTOR = 0.7;
final float STROKE_WEIGHT_INIT_VALUE = 48;
final float STROKE_WEIGHT_DAMP_FACTOR = 0.9;
final int BRANCH_MIN_NUM = 9;
final int BRANCH_MAX_NUM = 11;

void setup() {
  size(1000, 1000);
  stroke(0);
  strokeCap(SQUARE);
}

float len_exp_factor = 0.7;

boolean re = true;

void draw() {
  if (re) {
    re = false;
    background(#C6FDFF);
    tree(new PVector(width/2, height-50), new PVector(0, -1));
    println("done!");
  }
}

void tree(PVector pos, PVector dir) {
  branch(0, pos, dir);
}

void branch(int rd, PVector pos, PVector dir) {
  if (rd >= BRANCH_DEPTH) return;
  
  if (dir.y > 0) dir.y = -dir.y;

  float len = random(LENGTH_MIN, LENGTH_MAX) *exp(-LENGTH_DAMP_FACTOR*rd);

  strokeWeight(STROKE_WEIGHT_INIT_VALUE*exp(-STROKE_WEIGHT_DAMP_FACTOR*rd));
  stroke(64, rd*20, 0);
  line(pos.x, pos.y, pos.x+len*dir.x, pos.y+len*dir.y);

  for (int i = 0; i < int(random(BRANCH_MIN_NUM, BRANCH_MAX_NUM)); i++) {
    PVector branch_pos = PVector.add(pos, PVector.mult(dir, random(len/3, len)));
    PVector branch_dir = PVector.fromAngle(dir.heading()+random(-TWO_PI/8, TWO_PI/8));
    branch(rd+1, branch_pos, branch_dir);
  }
}

void keyPressed() {
  if (key == ' ') re = true;
}

void mouseClicked() {
  if (mouseButton == LEFT) re = true;
  else if (mouseButton == RIGHT) println(len_exp_factor);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  len_exp_factor += 0.01*e;
  re = true;
}
