String path = "processing/";
String gameState;

PImage menuImg, instructionImg;
PImage powerupPanelBG;
PImage coinImage, forceantlionImage, heartImage, speedImage, starImage;//25x25
PImage toolIcon1, toolIcon2, toolIcon3, toolIcon4;//50x50

int level, highestScore;
int currentSecond;

Ant ant;
Antlion antlion;
ArrayList<Obstacle> rocks;
ArrayList<PowerUp> powerUps;
ArrayList<Coin> coins;

int howManyObstacle, howManyPowerUps, howManyCoins;
void setup(){
  size(300,600);
    gameState = "gameMenu";
  resetGame();
  highestScore = 0;
//  currentSecond = second();
//  ant = new Ant();//ant
//  antlion = new Antlion(); //antlion
//  antlion.moveTimer = second();
//  rocks = new ArrayList();
//  powerUps = new ArrayList();
//  coins = new ArrayList();
//  howManyObstacle = 10;
//  howManyPowerUps = 1;
//  level = 1;
//  gameState = "playing";
  
   menuImg = loadImage(path+"bg/cover.png");
   instructionImg = loadImage(path+"bg/instruction.png"); 
   powerupPanelBG = loadImage(path+"powerupPanel.png");
   
   coinImage = loadImage(path+"powerups/25/coin.png");
   speedImage = loadImage(path+"powerups/25/speed.png");
   starImage = loadImage(path+"powerups/25/star.png");
   heartImage = loadImage(path+"powerups/25/heart.png");
   forceantlionImage = loadImage(path+"powerups/25/forceantlion.png");
   
   toolIcon1 = loadImage(path+"powerups/40/speed.png");
   toolIcon2 = loadImage(path+"powerups/40/forceantlion.png");
   toolIcon3 = loadImage(path+"powerups/40/star.png");
   toolIcon4 = loadImage(path+"powerups/40/heart.png");
  
  

   
//   playButton = new Button(width/2-50,height/2-25,100,50);
//    playButton = new Button(100,150,100,50);
}
//Button playButton;
void resetGame(){
  currentSecond = second();
  ant = new Ant();//ant
  antlion = new Antlion(); //antlion
  antlion.moveTimer = second();
  rocks = new ArrayList();
  powerUps = new ArrayList();
  coins = new ArrayList();
  howManyObstacle = 10;//10
  howManyPowerUps = 1;
  level = 1;

}
void draw(){
  
  if(gameState.equals("gameMenu")){
    image(menuImg, 0, 0);
    //start button
//    playButton.run();
  }//end if(gameState.equals("gameMenu")){
    
  else if (gameState.equals("instruction")){
    image(instructionImg, 0, 0);
  }
  else if (gameState.equals("playing")){
    drawBG();
    runGame();
    if(!ant.dead){ drawPowerUpPanel(); }
  }  // end if (gameMenu.equals("playing")){
  
  
  
    
  //KEY PRESSED HANDLER
  if(keyPressed){
      if(keySpace == true){ keySpace = false; ant.coin++; ant.highSpeed = !ant.highSpeed;}
      if(key1 == true){ 
        key1 = false; 
        if(ant.coin>=10){
          ant.coin-=10; 
          ant.collidePowerUp("speed");//speedBooster
        }
      }
      if(key2 == true){ 
        key2 = false; 
        if(ant.coin>=20){
          ant.coin-=20; 
          antlion.backToPos();//forces antlion to go back           
        }
      }
      if(key3 == true){ 
        key3 = false; 
        if(ant.coin>=30){
          ant.coin-=30;
          ant.collidePowerUp("star");//invisible         
        }
      }
      if(key4 == true){ 
        key4 = false; 
        if(ant.coin>=40){
          ant.coin-=40; 
          ant.collidePowerUp("heart");//increase the ant's life by 1
        }
      }
  }
  
  
  
  
}//end method draw






color bgColor = color(193, 154, 107);
void drawBG(){
  noStroke();
  fill(bgColor);
  rect(0,0,width,height);  
}//end method drawBG





 

class Ant extends Object{
  
  color c;
  boolean highSpeed, resprawning, dead;
  int resprawnCounter, highSpeedCounter;
  int score, life, coin;
  PImage antImage, antImage2;
  Ant(){
    super();
    w = 20;
    h = 50;  
    x = width/2;
    y = height/2;
    vx = 0;
    vy = +0.1;
    c = color(0,255,0);
    resprawning = highSpeed = false;
    resprawnCounter = highSpeedCounter = 200;
    life = 5;
    coin = 0;
    antImage = loadImage(path+"ant.png");
    antImage2 = loadImage(path+"ant2.png");
//    lifeDisplay = loadImage("life.png");
  }
  
  void run(){
    if(!dead){
    drawMe();
    update();
    if(resprawning){
        resprawnCounter--;
        if(resprawnCounter == 0){
          resprawning = false;
          resprawnCounter = 200;
        }
    }//end if resprawning
    
    if(highSpeed){
        highSpeedCounter--;
        if(highSpeedCounter == 0){
          highSpeed = false;
          highSpeedCounter = 200;
        }
    }//end if highSpeed
    
    if(y>height){ decreaseLife();}
    
    }//end if !dead
    
    
    printText();
  }//end method run
  
   void drawMe(){
    if(!resprawning){ c = color(0,255,0); }
    else{ c = color(random(0,255),random(0,255),random(0,255)); }

    pushMatrix();
    translate(x,y);

    noStroke();
    if(resprawning){
    fill(c);
//        ellipse(0,0,w,h);
//    ellipse(0,-h/3,w,h/3);
//    ellipse(0,h/3,w,h/1.1);
      if((millis())%2 == 0){
        image(antImage,-w/2-10, -h/2-5);
      }
      else{
        image(antImage2,-w/2-10, -h/2-5);
      }
    }//end if resprawning
    else{
      image(antImage,-w/2-10, -h/2-5);
    }

//    stroke(40);
//    strokeWeight(2);
//    
//    line(5,-h/3, 20, -h/3-10);
//    line(-5,-h/3, -20, -h/3-10);
//    ellipse(0,0,w,h);
//    ellipse(0,h/3,w,h);
    
    popMatrix();
  }
  
  
   void update(){
     y+=vy; 
//     println("highSpeed: "+highSpeed);
     if(keyUp){ 
       if(highSpeed){ vy=-0.6;  }
       else         { vy=-0.3;  }
     }
     else{ vy=1.1; }//0.1
     
     if(keyLeft){ 
       if(highSpeed){ x-=2.8; }
       else         { x-=1.0; }
       vy=0.5;
     }
     if(keyRight){ 
       if(highSpeed){ x+=2.8; }
       else         { x+=1.0; }
       vy=0.5;
     }
  }//end method update
  
  void collideRock(float rockX, float rockY, float rockW, float rockH){
  if(!resprawning){
      if(Math.abs(rockX - x) < (w+rockW)/2 && Math.abs(rockY-y) < (h+rockH)/2){
         y +=rockW*1.5;
         resprawning = true;
         decreaseLife();
      }//end if
    }//end !resprawning
  }//end method collideRock
  
  
  void collideAntlion(){
    if(!resprawning){
      y -= 35*1.5;
      resprawning = true;
      decreaseLife();
    }//end if !resprawning
  }//end method collideAntlion
  
  void collideObstacle(){
    if(!resprawning){
      y += 4*1.5;
      resprawning = true;
      decreaseLife();
    }//end if !resprawning
  }//end method collidObstacle
  
  void collidePowerUp(String powerUpType){
    
    if(powerUpType.equals("speed")){ highSpeed = true; }
    if(powerUpType.equals("star")){ resprawning = true; }
    if(powerUpType.equals("forceantlion")){antlion.backToPos(); }//forces antlion to go back
    if(powerUpType.equals("heart")){ life++ ; }
  }//end method collidePowerUp
  
  void collideCoin(){
    coin++;
  }//end method collideCoin
  
  void decreaseLife(){
    life--;
    //remove Ant if it's dead
    if(ant.life < 0){
      ant.dead = true;
      ant.x = ant.y = -300;
    }
  }//end method decreaseLife
  
  
  void printText(){
    printScore();
    printCoinCollected();
    if(!dead){ printLife(); }
    if(dead){ printGameOver(); }
    //Distance Travelled
    //Time duration
    //Coin collection
  }
  void printLife(){
    noStroke();
    fill(0);
    textSize(12);
    for(int i=0; i<life ; i++){ image(heartImage, width-25 - i*25, 5); }
  }
  void printScore(){
    noStroke();
    fill(0);
    textSize(12);
    text("HIGHEST: "+highestScore, 10, 20);  
    text("SCORE  : "+score, 10, 40);  
  }
  void printCoinCollected(){
    noStroke();
    fill(0);
    textSize(12);
    text("COIN: "+coin, 10, 60);  
  }
  void printGameOver(){
    noStroke();
    fill(0);
    textSize(50);
    text("GAME OVER ", 5, height/2);  
    textSize(12);
    text("Click to restart game. ", 100, height/2+25); 
  }
  
  
  
}//class Ant
class Antlion extends Object{
  float dx, dy;
  int moveTimer;
  String lastMove;
  PImage antlionImage;
  Antlion(){
    super();
    w = 120;
    h = 240;
    x = width/2;
    y = height-50;
    dx = x;//destinationX
    dy = y;//destinationY
    vx = 2;
    vy = 2;
    moveTimer = 0;
    lastMove = "";
    
    antlionImage = loadImage(path+"antlion.png");
  }
  
  void drawMe(){
    pushMatrix();
    translate(x,y);
    fill(255,0,0);
//    ellipse(0,0,w,h);
    image(antlionImage, -1*w/2, -1*h/2);
    popMatrix();
  }
  
  void move(String m){
    lastMove = m;
    if(m.equals("left")){ dx = w/2; }
    if(m.equals("center")){ dx = width/2; }
    if(m.equals("right")){ dx = width-w/2;  }
    if(m.equals("attack")){ attack(); }
  }
  
  void attack(){
    dy = height/2;
  }
  void backToPos(){
    lastMove = "backToPos";
    dy = height;
  }
  void update(){
    if(Math.abs(dx - x) > 5) {  
      if(dx>x){ vx = Math.abs(vx); }
      else{ vx = Math.abs(vx)*-1;}
      x+=vx;  
    }
    if(Math.abs(dy - y) > 5) {  
      if(dy>y){ vy = Math.abs(vy); }
      else{ vy = Math.abs(vy)*-1; }
      y+=vy;  
    }

  }
  
}
//class Button{
//  //fields
//  int x,y,w,h;
//  color btnColor;
//  //constructor
//  Button(int x_, int y_, int w_, int h_){
//    x = x_;
//    y = y_;
//    w = w_;
//    h = h_;
//    btnColor = color(20,20,20);
//  }//constructor 
//  
//  //methods
//  void run(){
//    drawButton();
//  }//end method run
//  
//  void drawButton(){
//    fill(btnColor);
//    noStroke();
//    rect(x,y,w,h);
//    fill(200,0,0);
//    textSize(32);
//    text("PLAY", x+10, y+30);
//  }//end method drawButton
//  
//  boolean mouseOn(){
//    if(mouseX>x && mouseY<x+w && mouseY>y&&mouseY<y+h){
//      btnColor = color(140,140,140);
//      return true;
//    }
//    else{
//      btnColor = color(20,20,20);
//    }
//    return false;
//  }//end method mouseOn
//  
//}//Button class
class Coin extends Object{
 
  //fields

  //constructor
  Coin(){
    super();
  }
  Coin(float x_, float y_, float vy_){
    super();
    x = x_;
    y += y_;
    vy = vy_;
  }
 
 //methods
 void drawMe(){
    
    image(coinImage, x-12,y-12);
//    fill(200,200,0);
//    ellipse(x,y,w,h);
//    fill(0);
//    textSize(18);
//    text("$", x-5, y+5);
  } 
}
class Object{
  //fields
  float x, y, vx, vy, w, h;
  
  //constructor
  Object(){
    w = h = 25;
    x = random(0,width);
    y = random(-50,-250);
    vx = 0;
    vy = random(1, level*2);
  }
  
  //method
  void run(){
    drawMe();
    update();  
  }
  
  void drawMe(){
//    pushMatrix();
//    translate(x,y);
    fill(0,0,255);
    ellipse(0,0,w,h);  
    ellipse(x,y,w,h);  
//    popMatrix();
  }
  
  void update(){
    x += vx;
    y += vy;
  }
}
class Obstacle extends Object{
  color obstacleColor;

  Obstacle(){
    super();
    w = h = random(10,40);
    obstacleColor = color(random(20,150));
  }
  
  void drawMe(){
    fill(obstacleColor);
    ellipse(x,y,w,h);

  }
}//class Obstacle
class PowerUp extends Object{
  
  String type;
  PowerUp(){
    super();
     w = h = 20;
    int which = (int)random(0,30);
    if(which<10){ type = "none"; }
    else if(which<20){ type = "forceantlion"; }
    else if(which<27){ type = "speed"; }
    else if(which<29){ type = "star"; }
    else if(which<30){ type = "heart";}
//    else{type ="none"; }
  }
  
  void drawMe(){
    if(type.equals("star")){ drawStar(); }
    if(type.equals("heart")){ drawHeart(); }
    if(type.equals("speed")){ drawSpeed(); }
    if(type.equals("forceantlion")){ drawForceantlion(); }
    if(type.equals("none")){ drawEmptyTool(); }
  }
  
  void drawStar(){
//    fill(200,200,0);
//    ellipse(x,y,w,h);  
    pushMatrix();
    translate(x,y);
    image(starImage, 0-w/2, 0-h/2);
    popMatrix();
  }
  
  void drawHeart(){
//    fill(255,0,0);
//    ellipse(x,y,w,h);
    pushMatrix();  
    translate(x,y);
    image(heartImage, 0-w/2, 0-h/2);
    popMatrix();
  }
  
  void drawSpeed(){
//    fill(255,0,0);
//    ellipse(x,y,w,h);
    pushMatrix();  
    translate(x,y);
    image(speedImage, 0-w/2, 0-h/2);
    popMatrix();
  }
  
  void drawForceantlion(){
//    fill(255,0,0);
//    ellipse(x,y,w,h);
    pushMatrix();  
    translate(x,y);
    image(forceantlionImage, 0-w/2, 0-h/2);
    popMatrix();
  }
  
  void drawEmptyTool(){
//    fill(0,0,255);
//    ellipse(x,y,w,h);  
  }
  
}//class PowerUp

void drawPowerUpPanel(){
  noStroke();
  //IMPORT PANEL BG
  image(powerupPanelBG, 0,540);
  fill(255);
  textSize(25);
  if(ant.coin>40){
    //PRINT ALL ICONS
    image(toolIcon1, 20, 550);
    image(toolIcon2, 90, 550);
    image(toolIcon3, 165, 550);
    image(toolIcon4, 240, 550);
  }
  else if(ant.coin>30){
    //PRINT I, I, I 4
    image(toolIcon1, 20, 550);
    image(toolIcon2, 90, 550);
    image(toolIcon3, 165, 550);
    text("4", 250, 580); 
  }
  else if(ant.coin>20){
    //PRINT I, I, 3, 4
    image(toolIcon1, 20, 550);
    image(toolIcon2, 90, 550);
    text("3", 175, 580); 
    text("4", 250, 580); 
  }
  else if(ant.coin>10){
    //PRINT I, 2, 3, 4
    image(toolIcon1, 20, 550);
    text("2", 100, 580); 
    text("3", 175, 580); 
    text("4", 250, 580); 
  }
  else{
    //PRINT 1,2,3,4 
    text("1", 30, 580); 
    text("2", 100, 580); 
    text("3", 175, 580); 
    text("4", 250, 580); 
  }
}//end method drawPowerupPanel
//Key Mapping for Multi-Input using I/O method
boolean keyUp, keyDown, keyLeft, keyRight;
boolean keyP, keyQ, keyR;
boolean key0, key1, key2, key3, key4;
boolean keySpace;



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
  if (key == '4') key4 = true;
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
  if (key == '4') key4 = false;
}

void mousePressed(){
//  if(playButton.mouseOn()){
//    gameState = "playing";
//  }

  if(gameState.equals("playing")){ resetGame();  }
  if(gameState.equals("instruction")){ gameState = "playing";  }
  if(gameState.equals("gameMenu")){ gameState = "instruction";  }


//  println("PRESSED"+gameState);
}//end method mousePressed
void runGame(){
    //Coins
  for(int i=0 ; i<coins.size() ; i++){
    Coin c = coins.get(i);
    c.run();
    //IF COIN COLLIDES WITH THE ANT
    if(Math.abs(c.x - ant.x) < (ant.w+c.w)/2 && Math.abs(c.y-ant.y) < (ant.h+c.h)/2){
      ant.collideCoin();
      coins.remove(i);
    }//END IF COIN COLLIDES WITH THE ANT
    //Remove Coins that are out of the screen
    if(c.y-c.h>height){
      coins.remove(i);
    }
  }//for Coin i  
  
  
  //Obstacles
  for(int i=0 ; i<rocks.size() ; i++){
    Obstacle r = rocks.get(i);
    r.run();
    //IF OBSTACLE COLLIDES WITH THE ANT
    if(Math.abs(r.x - ant.x) < (ant.w+r.w)/2 && Math.abs(r.y-ant.y) < (ant.h+r.h)/2){
      ant.collideObstacle();
    }//END IF OBSTACLE COLLIDES WITH THE ANT
    
    //Remove Obstacles that are out of the screen
    if(r.y-r.h>height){
      rocks.remove(i);
    }
  }//for Obstacle i
  
  
  
  //PowerUps
  for(int i=0 ; i<powerUps.size() ; i++){
    PowerUp pu = powerUps.get(i);
    pu.run();
    //IF POWER UP(i) COLLIDES WITH THE ANT
    if(Math.abs(pu.x - ant.x) < (ant.w+pu.w)/2 && Math.abs(pu.y-ant.y) < (pu.h+ant.h)/2){
         ant.collidePowerUp(pu.type);
         powerUps.remove(i);
    }//END IF POWER UP(i) COLLIDES WITH THE ANT
    
    //Remove PowerUps that are out of the screen
    if(pu.y-pu.h>height){
      powerUps.remove(i);
    }
  }//for PowerUp i
  
  

  //Antlion
  antlion.run();
  if(Math.abs(second() - antlion.moveTimer) > 3 ){
    antlion.moveTimer = second();
    
    if(antlion.lastMove.equals("attack") ){ antlion.backToPos(); }//println("backToPos");}
    else{
    int which = (int)random(0,5);
   
    if(which < 1){ antlion.move("left"); }//println("left"); }
    else if(which < 2){ antlion.move("center");}// println("center");}
    else if(which < 3){ antlion.move("right"); }//println("right");}
    else{ antlion.move("attack"); antlion.vy*=-1; }//println("attack");}
    }
  }
  //IF ANTLION COLLIDES WITH THE ANT
    if(Math.abs(antlion.x - ant.x) < (ant.w+antlion.w)/2 && Math.abs(antlion.y-ant.y) < (antlion.h+ant.h)/2){
         ant.collideAntlion();
    }//END IF ANTLION COLLIDES WITH THE ANT
  //Ant
  ant.run();
    
    
    

  //Resprawn objects
  //Obstacle
  while(howManyObstacle > rocks.size()){
    rocks.add(new Obstacle());
  }//end howManyObstacle > rocks.size()
  
  //PowerUps
  if(powerUps.size() == 0){
    howManyPowerUps = (int)random(0,5);//0,2
    for(int i=0 ; i<howManyPowerUps ; i++){
      powerUps.add(new PowerUp());
    }//for PowerUp i
  }//end if powerUps.size() == 0
  
  //Coins
  if(coins.size() == 0){
    howManyCoins = 10;
    for(int i=0 ; i<howManyCoins ; i++){
      if(i==0){ coins.add(new Coin()); }
      else { coins.add(new Coin(coins.get(0).x, i*-25, coins.get(0).vy) );}
    }//for Coin i
  }//end if coins.size() == 0
  
  

  int scoreIncrement = 1;
  if(dist(antlion.x, antlion.y, ant.x, ant.y) < 160){
    fill(200,0,0);
    textSize(32);
    text("VERY DANGEROUS", 10, height/2);
    scoreIncrement = 10;
  }
  else if(dist(antlion.x, antlion.y, ant.x, ant.y) < 180){
    fill(200,0,0);
    textSize(45);
    text("DANGEROUS", 10, height/2);
    scoreIncrement = 2;
  }
  else{scoreIncrement = 1;}
       //update Score by 1 every second
  if(currentSecond != second() ){
    if(!ant.dead){
    ant.score += scoreIncrement;
    currentSecond = second();
    }
  } 
  
  if(ant.score > highestScore){ highestScore = ant.score;}
  
  

}

