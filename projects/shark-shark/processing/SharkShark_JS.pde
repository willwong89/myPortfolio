String path = "processing/";

//import processing.opengl.PGraphicsOpenGL;


//This variable will determine how many EnemyFish is created
//Level determines how many EnemyFish will be on the screen,
//turn level to 0 in order to control the number of fish directly
int howMany = 10;




//PFont variable
PFont font;
PImage bg0, bg2;

//These Arrays will store the Fish
ArrayList fish = new ArrayList();//EnemyFish
//EnemyFish[] fish = new EnemyFish[howMany];//EnemyFish
PlayerFish player;//PlayerFish
Shark shark;//Shark



boolean resetGame = false;

int gameState, gameScore, finalScore, highestScore, sharksKilled, fishKilled ;

int level = 1;

float playerSize = 0;


color bgColor = color(30, 130, 255, 150);
class EnemyFish extends GeneralFish {

  //fields
  float wave, waveSpeed, amp;
  int traceTimer = 100;
  int enemyBound = 200;
  float tailOffSet = -99;

  //constructor
  EnemyFish(){
    super();
    
    if (random(0, 2) > 1) {
      x = -enemyBound;
      velX = random(2, 4);
      if(level == 99) velX = random(20, 15);
    }
    else {
      x = width+enemyBound;
      velX = random(-4, -2);
      if(level == 99) velX = random(-20, -15);
    }
    velY = 0;
    fishColor = color( random(80, 128), random(80, 128), random(80, 128) );
    
    if(level > 7 && level < 99){
    w = random(playerSize-10, playerSize+50);
    h = w/2;  
    }
    if(level == 99){
    w = 60;
    h = w/2;
    }
    
    
    wave = random(TWO_PI);
    waveSpeed = random(0.1, 0.3);
    amp = random(1, 2);
  }

void drawFish(){
  
  if(level==99)  shark.drawFish(); 
  else super.drawFish();
 
}


  //methods
  void update() {
    wave += waveSpeed;
    y += sin(wave)*amp;
    super.update();
  }

  void dead() {
    y -= 5;
    if (traceTimer > 0) traceTimer--;				
    else respawnEnemy();//respawm
  }

  void respawnEnemy() {
    fish.remove(this);//remove this EnemyFish
    fish.add( new EnemyFish() );
    if(level == 99) {
      player.score+=5;
    }

    
  }

  boolean detectOffScreen() {
    if (x < -enemyBound || x > width+enemyBound) return true;
    else if (y < -enemyBound || y > height+enemyBound) return true;
   return false;
  }
  
}//class

class GeneralFish {
  //field
  float x, y, velX, velY, w, h;
  color fishColor, finAndTailColor;
  boolean alive;

  //constructor
  GeneralFish() {
    x = random(width);
    y = random(30, height-30);

    w = random(20, 100);
    h = w/2;  

    velX = random(-2, 2);
    velY = random(-2, 2);

    fishColor = color(255);
    finAndTailColor = color(random(50, 255), 0, 0 );
    
    alive = true;
  }


  //method
  void drawMe() {
    pushMatrix();
    translate(x, y);
    if (velX < 0) { //if the fish is going left
      scale(-1, 1); //face left
    }
    drawFish();
    popMatrix();
  }//end drawMe


  void drawFish() {
    
    fill(fishColor);
    stroke(0);
    
    
    
    //(-x3, -y1) (-x2, -y1) (-x1, -y1)  (0,-y1)  (x1,-y1) (x2,-y1) (x3,-y1)
    //(-x3,   0) (-x2,   0) (-x1,   0)  (0,  0)  (x1,  0) (x2,  0) (x3,  0)
    //(-x3,  y1) (-x2,  y1) (-x1,  y1)  (0, y1)  (x1, y1) (x2, y1) (x3, y1)
    float x1 = w/6;
    float x2 = w/3;
    float x3 = w/2;
    float y1 = h/2;
    color bodyColor = fishColor;
    color traceColor = bodyColor;
    strokeWeight(1);
    if (!alive) strokeWeight(3);
    if (!alive) stroke(bodyColor);
    //head
    fill(bodyColor);
    if (!alive) noFill();
    arc(x1-1, +1, w*2/3, h, -PI/2, 0);
    arc(x1-1, -1, w*2/3, h, 0, PI/2);
    //body
//    noStroke();
    stroke(bodyColor);
    rect(0, -y1, w/6, h);
    rect(-x2, -y1/2, x2, y1);
    stroke(0, 0, 0);
    if (!alive) stroke(traceColor);
    line(0, -y1, x1, -y1);
    line(0, y1, x1, y1);
    arc(1, -y1/2+1, w*2/3+1, y1+2, PI, PI*3/2);
    arc(1, y1/2-1, w*2/3+1, y1+2, PI/2, PI);
    curve(x2, -y1*2, x1, -y1, x1, y1, x2, y1*2);//gill
    //eye and mouth
    fill(255, 255, 255);
    ellipse(x2, -y1/2, w/12, w/12);//eye
    fill(0, 0, 0);
    ellipse(x2, -y1/2, w/20, w/20);//pupil
    fill(200, 0, 0);
    ellipse(w*5/12, h/5, w/30, h/30);//mouth
    //fins
    fill(finAndTailColor);
    if (!alive) noFill();
    noStroke();
    triangle(x1, -y1, -(abs(-x1-x2)/2), -y1*1.5, -x1, -y1*0.9);
    triangle(x1, y1, -(abs(-x1-x2)/2), y1*1.5, -x1, y1*0.9);
    stroke(0, 0, 0);
    if (!alive) stroke(traceColor);
    line(-(abs(-x1-x2)/2), -y1*1.5, -x1, -y1*0.9);
    line(-(abs(-x1-x2)/2), y1*1.5, -x1, y1*0.9);
    curve(x1, 0, x1, -y1+1, -(abs(-x1-x2)/2), -y1*1.5+1, -x2, -y1/2);
    curve(x1, 0, x1, y1-1, -(abs(-x1-x2)/2), y1*1.5-1, -x2, y1/2);
    //tail
    noStroke();
    triangle(-x2, 1, -x2, -y1/2, -x3, -y1);
    triangle(-x2, -1, -x2, y1/2, -x3, y1);
    stroke(0, 0, 0);
    if (!alive) stroke(traceColor);
    curve(-x2, 0, -x2, -y1/2+1, -x3, -y1+1, -x3, 0);
    curve(-x2, 0, -x2, y1/2-1, -x3, y1-1, -x3, 0);
    curve(-x2, -y1/2, -x2, -1, -x3, -y1-1, -x3, -y1*2);
    curve(-x2, y1/2, -x2, 0, -x3, y1+1, -x3, y1*2+1);
  
  }//end drawFish




    boolean collision(GeneralFish other) { 
    if (abs(x-other.x)<=w/2+other.w/2 && abs(y-other.y)<=h/2+other.h/2) {
      return true;
    }
    return false;
  }//end colliosn

  void bounce(GeneralFish other) {
    float angle = atan2(y - other.y, x - other.x);
    if (abs(velX) < 0.1 ) velX = 2; 
    if (abs(velY) < 0.1 ) velY = 2; 
    if (abs(other.velX) < 0.1 ) other.velX = 2; 
    if (abs(other.velY) < 0.1 ) other.velY = 2; 
    velX = abs(velX) * cos(angle);
    velY = abs(velY) * sin(angle);
    other.velX = abs(other.velX) * cos(angle - PI);
    other.velY = abs(other.velY) * sin(angle - PI);
  }


  void update() {
    x += velX;
    y += velY;
  }//end update
}//end class

class PlayerFish extends GeneralFish {

  //fields
  int traceTimer, respawnTimer;

  int score, lives;

  color playerColor = color(255, 150, 150);
  //constructor
  PlayerFish() {
    super();  
    x = width/2;
    y = height/2;
    w = 50;
    h = w/2;

    fishColor = playerColor;

    traceTimer = 50;
    respawnTimer = -1;
    score = 0;
    lives = 5;
  }

  //methods
  void eat(EnemyFish other) {
    if ( other instanceof Shark && respawnTimer ==-1) {//if that fish is a shark
      this.alive=false;
    }
    else if (alive==true && w > other.w) {//if PlayerFish is bigger than EnemyFish

      other.alive = false;//kill the other fish
      fishKilled ++;
      
      if (w <= 300) {//limit the maxium size of PlayeFish
           velX *= 0.1;
           velY *= 0.1;
           
        //if the EnemyFish is over 95% of the PlayerFish
        if (w*0.95 <= other.w) {
          score += 40;
          w *= 1.1;
          h *= 1.1;
        }
        //else if the EnemyFish is over 50% but less than 95% of the PlayerFish
        else if (w*0.5 <= other.w){
          score +=20;
          w *= 1.03;
          h *= 1.03;
        }
        //else if the EnemyFish is lss than 50%
        else {
          score +=10;
          w *= 1.01;
          h *= 1.01;
        }
      }
    }
    else if (respawnTimer == -1) {
      this.alive = false;
    }
  }



  void drawMe() {
    if (alive) super.drawMe(); 
    else drawPlayerTrace();
  }
  void drawFish() {

    if(key2) playerColor = color(random(255), random(255), random(255));
    
    if (respawnTimer != -1) {
      respawnTimer--;
      fishColor = color(random(255), random(255), random(255));
      finAndTailColor = color(random(255), random(255), random(255));
      
    }//end if respawnTimer != -1
    else {
      fishColor = playerColor;
      finAndTailColor= color(random(50, 255), 0, 0 );
    }
    super.drawFish();
  }
  void drawPlayerTrace() {
    noFill();
    ellipse(x, y, h, h);
    ellipse(x, y, h*1.5, h*1.5);
    ellipse(x, y, h*2, h*2);
  }
  //this method is to kill and respawn PlayerFish
  void dead() {
    //while alive == false
    if (traceTimer > 0) {
      traceTimer--;
      w*=1.01;
      h*=1.01;
    }
    else {
      lives --;
      respawnPlayer();
      if (lives < 0) gameState = 2;
    }
  }

  void respawnPlayer() {
    if (lives >= 0) {
      x = random(width);
      y = random(height);

      w = 50;
      h = 50/2;
      traceTimer = 50;
      respawnTimer = 200;
      alive = true;
    }
    //player = new PlayerFish();
  }

  //to slow down the velocity
  void update() {
    //velX *= 0.96;
    //velY *= 0.96;
    if(key3) {
      w *= 0.9;
      h = w/2;
    }
    float speed = 0.9;
    if (w > 100) speed = 0.8;
    if (w > 200) speed = 0.7;
    if (w > 300) speed = 0.6;
    velX *= speed;
    velY *= speed;
    super.update();
  }

  void update ( float xDir, float yDir) {
    velX += xDir;
    velY += yDir;
  }

  void walls() {
    if (x + w/2 >= width) {
      x = width - w/2;
      velX *= -1;
    }//right
    if (x - w/2 <= 0) {
      x = 0 + w/2;
      velX *= -1;
    }//left
    if (y - h/2 <= 0) {
      y =  h/2;
      velY *= -1;
    }//top
    if (y + h/2 >= height) {
      y = height - h/2;
      velY *= -1;
    }//bottom
  }

  boolean headOn(EnemyFish other) {
    //if headOn
    if (velX>0 && other.velX<0 || velX<0 && other.velX>0) {
      return true;
    }
    return false;
  }
}

class Shark extends EnemyFish {

  //fields
  float tailOffSet, tailW, tailH, tailX;
  int traceTimer, flipTimer, sharkLives, dir;

  //constructor
  Shark() {
    super();
    w = 250;
    if (level == 99) w=60;
    h = w/2;
    velX *= 1.2;//the shark swims 1.2 times faster than regular EnemyFish
    if (level == 99) velX *= 3;
    fishColor = color(200, 200, 200);

    tailW = w/4;
    tailH = h;

    tailOffSet = w*3/8;
    flipTimer = -1;
    traceTimer = 100;
    sharkLives = 4;
  }



  //methods
  void update() {
    if (flipTimer > 0) {
      flipTimer--;
      //ellipse(40, 40, flipTimer, flipTimer);//flipTimer tracer
    }
    else if (flipTimer==0) {
      velX*=-1;
      flipTimer--;
    }
    super.update();
  }

  void respawnShark() {
    shark = new Shark();
  }

  void dead() {
    y += 5;
    if (traceTimer > 0) traceTimer--;				
    else respawnShark();//respawm
  }

  void tailBite(PlayerFish other) {
    if (velX>0) dir = -1;
    else dir = 1;

    //    //this ellipse is to indicate where exactly the tail is
    //    ellipse(dir*tailOffSet + x, y, tailW, tailH); 

    //if PlayerFish and Shark are both facing the same direction
    if ( (velX>0 && other.velX>0) || (velX<0 && other.velX<0) ) {
      //if PlayerFish collide with the Shark's tail
      if ( abs(dir*tailOffSet+x - other.x) < tailW/2 + other.w/2 &&
        abs(y - other.y) < h/2 + other.h/2  
        && flipTimer < 0) {
        //shark gets bite
        sharkLives --;
        flipTimer = 50;
      }//end if PlayerFish collide with the Shark's tail
    }//end if PlayerFish and Shark are both facing the same direction


    if (sharkLives ==0) {
      this.alive = false;
      other.score += 400;
      other.lives += 1;
      sharksKilled ++;
    }
  }
  boolean detectOffScreen() {
    //top wall
    if (y - h/2 <= 0) {
      y =  h/2;
      velY *= -1;
    }//top
    if (y + h/2 >= height) {
      y = height - h/2;
      velY *= -1;
    }//bottom

    return super.detectOffScreen();
  }

  void drawmMe() {
    drawFish();
  }  

  void drawFish() {
    scale(-1, 1);
    if (flipTimer != -1) {
      if (flipTimer%2 == 0) fishColor = color(255, 0, 0); 
      else fishColor = color(200, 200, 200);
    }
    else fishColor = color(200, 200, 200);
    //(-x3, -y1) (-x2, -y1) (-x1, -y1)  (0,-y1)  (x1,-y1) (x2,-y1) (x3,-y1)
    //(-x3,   0) (-x2,   0) (-x1,   0)  (0,  0)  (x1,  0) (x2,  0) (x3,  0)
    //(-x3,  y1) (-x2,  y1) (-x1,  y1)  (0, y1)  (x1, y1) (x2, y1) (x3, y1)
    float x1 = (w)/6;
    float x2 = (w)/3;
    float x3 = (w)/2;
    float y1 = (h)/2;
    if (alive == false) {
      x1 = w/2;
      x2 = w/6;
      x3 = w/3;
    }
    strokeWeight(2);
    stroke(0);
    fill(fishColor);

    //tail
    beginShape();
    curveVertex(x1, 0);
    curveVertex(x1, 0);
    curveVertex(x3, y1);
    curveVertex((x2+x3)/2, 0);
    curveVertex(x3, -y1);
    curveVertex(x1, 0);
    curveVertex(x1, 0);
    endShape();

    //fin
    beginShape();
    curveVertex(x2/1.8, 0);//middle right
    curveVertex(x2/1.8, 0);//middle right
    curveVertex(x2/1.1, y1/0.8);//bottom right
    curveVertex(-x1, 0);//middle left
    curveVertex(x2/1.1, -y1/0.8);//top right
    curveVertex(x2/1.8, 0);//middle right
    curveVertex(x2/1.8, 0);//middle right
    endShape();

    //body
    //noStroke();  
    strokeWeight(1);
    stroke(fishColor);
    triangle(-x3, -y1/1.3, x2/1.3, -y1/4, x2/1.3, y1/3);

    stroke(0);
    strokeWeight(2);
    beginShape();
    curveVertex(-x3, -y1/1.3);
    curveVertex(-x3, -y1/1.3);
    curveVertex(0, -y1/1.5);
    curveVertex(x2/1.3, -y1/4);
    curveVertex(x2/1.3, -y1/4);
    endShape();
    
    beginShape();
    curveVertex(x2/1.2, y1/4);
    curveVertex(x2/1.2, y1/4);
    curveVertex(x1/2, y1);
    curveVertex(-x2, y1/4);
    curveVertex(-x3, -y1/1.3);
    curveVertex(-x3, -y1/1.3);
    endShape();

    //eye 
    fill(255, 0, 0);
    beginShape();
    curveVertex(-x1/0.7, -y1/5);
    curveVertex(-x1/0.7, -y1/5);
    curveVertex(-x1/1.2, -y1/12);
    curveVertex(-x1/2.2, -y1/2.5);
    curveVertex(-x1/2.2, -y1/2.5);
    endShape();
    fill(255);
    ellipse(-x1, -y1/5, 5, 5);
    line(-x1/0.7, -y1/5, -x1/2.2, -y1/2.5);    

    //mouth
    fill(255, 0, 0);
    beginShape();
    curveVertex(-x1/0.8, y1/2);
    curveVertex(-x1/0.8, y1/2);
    curveVertex(-x1/1.8, y1/2.7);
    curveVertex(-x1/2, y1/2.5);
    curveVertex(-x1/2, y1/2.5);
    endShape();

    //nose
    fill(230);
    beginShape();
    curveVertex(-x2/0.8, -y1/3.5);
    curveVertex(-x2/0.8, -y1/3.5);
    curveVertex(-x2/0.82, -y1/4);
    curveVertex(-x2/0.8, -y1/4.5);
    curveVertex(-x2/0.8, -y1/4.5);
    endShape();

    //scale
    stroke(255);
    fill(0);
    beginShape();
    curveVertex(3, 0);
    curveVertex(3, 0);
    curveVertex(5, y1/10);
    curveVertex(0, y1/5);
    curveVertex(0, y1/5);
    endShape();
    beginShape();
    curveVertex(13, 0);
    curveVertex(13, 0);
    curveVertex(15, y1/10);
    curveVertex(10, y1/5);
    curveVertex(10, y1/5);
    endShape();
    beginShape();
    curveVertex(23, 0);
    curveVertex(23, 0);
    curveVertex(25, y1/10);
    curveVertex(20, y1/5);
    curveVertex(20, y1/5);
    endShape();

    if (alive == false) {
      fill(0, 0, 150);
      strokeWeight(0);
    }
  }
}

//void draw() {
//  fill(255,255,255);
//  rect(0,0,width, height);
//  shark.x = width/2;
//  shark.y = height/2;
//  shark.update();
//  shark.drawMe(); //overridden update method, draw both EnemyFish no matter what
////  if(shark == null)
//   
//   
//}

void draw(){
  //level setUp
  if (level != 0) howMany = level*2;
  if (level > 10 ) howMany = 20;
  for (int i=fish.size() ; i<howMany ; i++) {
    fish.add( new EnemyFish() );
    EnemyFish fishi = (EnemyFish) fish.get(i);
    //fishi.fishColor = color(255, 0, 0);
  }  
  //levelUp 
  if (finalScore>=400 && level<2) level = 2;
  if (finalScore>=800 && level<3) level = 3;
  if (finalScore>=1200 && level<4) level = 4;
  if (finalScore>=1600 && level<5) level = 5;
  if (finalScore>=2000 && level<6) level = 6;    
  if (finalScore>=2400 && level<7) level = 7;
  if (finalScore>=2800 && level<8) level = 8;
  if (finalScore>=3200 && level<9) level = 9;
  if (finalScore>=3600 && level<10) level = 10;
  if (finalScore>=5000 && level<11) level = 11;





  ///////////////////////////////////////////////////
  //                    State 0                    //
  ///////////////////////////////////////////////////
  if (gameState == 0) {
    //background(255, 0, 0);
    noStroke();
    fill(255);
    rect(0,0,width,height);
    if (keyP) {
      gameState = 1;
      resetGame = true;
    }
    image( bg0, 0, 0 );
  }//End if gameState == 0



    ///////////////////////////////////////////////////
  //                    State 1                    //
  ///////////////////////////////////////////////////
  else if (gameState == 1) {
    if (keyR) {
      gameState = 1;
      resetGame = true;
    }
    else if (keyQ) gameState = 2;
    //background(bgColor);
    fill(bgColor);
    rect(0,0,width,height);
    if (resetGame) {
      //;

      resetGame = false;
      player = new PlayerFish();     
      shark = new Shark();
      //remove EnemyFish
      fish.clear();
      //add EnemyFish
      for (int i=0 ; i<howMany ; i++) {
        fish.add( new EnemyFish() );
      }

      level = 1;
      sharksKilled = 0;
      fishKilled = 0;
    }//end if resetGame




    //end levelSetUp

    /////////////////////////////
    //       PlayerFish        //
    /////////////////////////////  
    if (key1) player.respawnTimer = 500;
    if (player.alive) {
      //move PlayerFish based on keypressed
      if (keyUp) player.update( 0, -1); // Right Key to move PlayerFish up
      if (keyDown) player.update( 0, 1); // Right Key to move PlayerFish down
      if (keyLeft) player.update( -1, 0); // Right Key to move PlayerFish left
      if (keyRight) player.update( 1, 0); // Right Key to move PlayerFish right
      if (keySpace) player.fishColor = color(random(255), random(255), random(255) );
      player.update(); //update the player position using the GeneralFish update method that was inherited

      player.walls(); //PlayerFish walls method

      player.drawMe(); //Overridden drawMe method
    }

    else {
      player.dead();

      player.drawMe();
    }


    /////////////////////////////
    //          SHARK          //
    /////////////////////////////
    if (shark.alive) {

      if ( player.collision( shark )) {

        shark.tailBite(player);
        if (shark.flipTimer < 20 ) player.eat(shark);
      }

      shark.update(); //overridden update method with wave added

      if ( shark.detectOffScreen() ) {
        shark.respawnShark();
      } //EnemyFish walls method
    }//end if alive 
    else {//else if NOT alive
      shark.dead(); //call the dead method of a dead fish (alive is false)
    }//end else

    shark.drawMe(); //overridden update method, draw both EnemyFish no matter what
    //draw traces if alive is false

      /////////////////////////////
    //        EnemyFish        //
    /////////////////////////////
    for (int i = 0; i < fish.size(); i++) {

      EnemyFish fishi = (EnemyFish) fish.get(i); //This is fishi, don't forget to cast here!!!


      if (fishi.alive) {

        if ( shark.collision( fishi ) ) { //GeneralFish collision method
          shark.bounce( fishi ); //bounce the fish
        }//if

        //GeneralFish collision method + PlayerFish headOn method
        if ( player.collision( fishi ) && player.headOn( fishi ) ) { 
          player.eat( fishi ); //PlayerFish eat method
        }

        for (int j = i + 1; j < fish.size(); j++) {

          EnemyFish fishj = (EnemyFish)fish.get(j); //This is fishj, don't forget to cast here!!!

          if ( fishi.collision( fishj ) ) { //GeneralFish collision method
            fishi.bounce( fishj ); //bounce the fish
          }//if
        } //for j

          fishi.update(); //overridden update method with wave added

        if ( fishi.detectOffScreen() ) {
          fishi.respawnEnemy();
        }//EnemyFish walls method
      }//end if alive 
      else {//else if NOT alive
        fishi.dead(); //call the dead method of a dead fish (alive is false)
      }//end else

      fishi.drawMe(); //overridden update method, draw both EnemyFish no matter what
      //draw traces if alive is false

        playerSize = player.w;
      //println("fish.size" + fish.size());
      //println("level" + level);

      /*
      ////////////////////////////////////////////////////////////////////////////////////
      ////              This method is to kill Fishes by clicking                       //
      ////////////////////////////////////////////////////////////////////////////////////
      //kill EnemyFish by clicking
      if (mouseX>=fishi.x-fishi.w/2 && mouseX<=fishi.x+fishi.w/2 &&
        mouseY>=fishi.y-fishi.h/2 && mouseY<=fishi.y+fishi.h/2) {
        //mouse over
        if (mousePressed) {//clicked
          fishi.alive = false;
        }//end if mouseClicked
      }//end if mouseOn
      //kill PlayerFish by clicking
      if (mouseX>=player.x-player.w/2 && mouseX<=player.x+player.w/2 &&
        mouseY>=player.y-player.h/2 && mouseY<=player.y+player.h/2) {
        //mouse over
        if (mousePressed) {//clicked
          player.alive = false;
        }//end if mouseClicked
      }//end if mouseOn
      //kill Shark by clicking
      if (mouseX>=shark.x-shark.w/2 && mouseX<=shark.x+shark.w/2 &&
        mouseY>=shark.y-shark.h/2 && mouseY<=shark.y+shark.h/2) {
        //mouse over
        if (mousePressed) {//clicked
          shark.alive = false;
        }//end if mouseClicked
      }//end if mouseOn
      ////////////////////////////////////////////////////////////////////////////////////
      */
    } //for i


    ///////////////////////////////////////////////////
    //                 Display Data                  //
    ///////////////////////////////////////////////////
    
    fill(255);

    //for JS
    text("Lives: "+player.lives,675,50);//+Integer.toString(player.lives), 700, 50);
    text("Level: "+level,675,25);//+Integer.toString(level), 700, 25);
    text(""+highestScore,0,25);//+Integer.toString(highestScore), 0, 25);//Highest Score
    text(""+finalScore,0,50);//+Integer.toString(finalScore), 0, 50);//Score
    
    
    /*
    text("Lives: "+Integer.toString(player.lives), 700, 50);
    text("Level: "+Integer.toString(level), 700, 25);
    text(""+Integer.toString(highestScore), 0, 25);//Highest Score
    text(""+Integer.toString(finalScore), 0, 50);//Score
    */

    //store player.score into finalScore
    finalScore = player.score;
    //update highestScore
    if (finalScore > highestScore) highestScore = finalScore;
    //update playerSize

  }//End if gameState == 1






  ///////////////////////////////////////////////////
  //                    State 2                    //
  ///////////////////////////////////////////////////
  else if (gameState == 2) {
    noStroke();
    fill(255);
    rect(0,0,width,height);
    if (keyR) {
      gameState = 1;
      resetGame = true;
    }
    image( bg2, 0, 0 );
    fill(0);
    text("Highest Score: "+Integer.toString(highestScore), 0, 25);//Highest Score
    text("Score: "+Integer.toString(finalScore), 0, 50);//Score
    text("Fish Killed: "+Integer.toString(fishKilled), 0, 75);
    text("Sharks Killed: "+Integer.toString(sharksKilled), 0, 100);
   

    
    
  }//End if gameState == 2


}//End draw

//Key Mapping for Multi-Input using I/O method
boolean keyUp, keyDown, keyLeft, keyRight, keySpace;
boolean keyP, keyQ, keyR;
boolean key0, key1, key2, key3;



void keyPressed() {
  if (keyCode == UP) keyUp = true; 
  if (keyCode == DOWN) keyDown = true; 
  if (keyCode == LEFT) keyLeft = true; 
  if (keyCode == RIGHT) keyRight = true;
  if (key == ' ') keySpace = true;
  
  if (key == 'p' || key == 'P') keyP = true;
  if (key == 'q' || key == 'Q') keyQ = true;
  if (key == 'r' || key == 'R') keyR = true;
  
  if (key == '0') key0 = true; 
  if (key == '1') key1 = true; 
  if (key == '2') key2 = true; 
  if (key == '3') key3 = true;
}


void keyReleased() {
  if (keyCode == UP) keyUp = false; 
  if (keyCode == DOWN) keyDown = false; 
  if (keyCode == LEFT) keyLeft = false; 
  if (keyCode == RIGHT) keyRight = false;
  if (key == ' ') keySpace = false;

  if (key == 'p' || key =='P') keyP = false;
  if (key == 'q' || key =='Q') keyQ = false;
  if (key == 'r' || key =='R') keyR = false;
  
  if (key == '0') key0 = false; 
  if (key == '1') key1 = false; 
  if (key == '2') key2 = false; 
  if (key == '3') key3 = false;
}

void setup() {
 shark = new Shark();/////debug
 
 size(900, 650);  
  //size(800, 600, OPENGL);
  smooth();
  gameState = gameScore = finalScore = highestScore = sharksKilled = fishKilled = 0;

  keyUp = keyDown = keyLeft = keyRight = false;
  key0 = key1 = key2 = key3 = false;


  font = loadFont(path+"HelveticaCY-Plain-48.vlw");
  bg0 = loadImage( path+"bg-0.jpg" );
  bg2 = loadImage( path+"bg-2.jpg" );
  textFont(font, 30);
}//setup


