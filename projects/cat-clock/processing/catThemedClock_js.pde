/* @pjs font=CurlzMT.ttf; */

/*  This Cat-themed Clock project is done for 
 *  IAT 355 Introduction to Visual Analysis
 *  by William Wong (301155106).
 *  
 *  Time taken: 2 Days
 *  Last modified: 16-Jan-2013 01:45
 *
 *  23-Apr-2013 Made some minor changes so that it runs in javascript mode
 */
 
boolean jsMode = true;
boolean explicitMode;
float hourR, minuteR, secondR;
PFont font;

Cat cat;
int catWidth, catHeight;
color catBodyColor;
color catEyeColor;
color catNoseColor;
color catEarColor;






class Cat{
  //field
  int catW, catH; //the cat's width and height
  float catX, catY; //the cat's position  
  
  color bodyColor; //the cat's body color
  color eyeColor; //the cat's eye color
  color noseColor; //the cat's nose color  
  color earColor; //the cat's ear color  
  float noseW, noseH; //the cat's nose size
  boolean mouseOnNose = false;
  
  //The cat is drawn based on a 8 x 6 grid, and
  //columnW and rowH represent the width and height of each column and row in the grid layout.
  //The purpose of this appoarch is to maintain the cat's scale.
  float columnW, rowH, halfColumnW, halfRowH;
  float x0, x1, x2, x3;
  float y0, y1, y2, y3;

  //constructor
   Cat(){
    catW = 800;
    catH = 600;
    bodyColor = color( 20, 20, 20); //black
    eyeColor  = color(120, 255, 0); //green
    noseColor = color(200,   0, 0);//red
    initCatFields();
  }
  
  Cat(int w, int h, color bc, color ec, color nc, color earc){
    //overidding the default field values
    catW = w;
    catH = h;
    bodyColor = bc;
    eyeColor = ec;
    noseColor = nc;
    earColor = earc;
    initCatFields();
    
  }

  //method
  void initCatFields(){
    catX = width/2;//width/2;
    catY = height/2;
    x0 = 0;
    x1 = (catW/8);
    x2 = (catW*2/8);
    x3 = (catW*3/8);
    
    y0 = 0;
    y1 = (catH/6);
    y2 = (catH*2/6);
    y3 = (catH*3/6);
    
    columnW = catW/8;
    rowH = catH/6;
    halfColumnW = catW/8/2;
    halfRowH = catH/6/2;

    noseW = 30;
    noseH = 20;

    
  }//initCatFields
  
  void drawCat(){
    pushMatrix();
    translate(catX, catY);//width/2, height/2
      /* //cat locator
      fill(255,0,0, 20);
      rect(-catW/2, -catH/2, catW, catH);
      */  
      drawHead();
      drawNose();  
      drawEyes();
      drawWhiskers();  
      drawBody();
      drawTail();
      if(explicitMode){ drawWhiskerScale(); } 
      popMatrix();
  }

  void drawHead(){
    scale(-1, 1);
    drawHalfHead();
    scale(-1, 1);
    drawHalfHead();
  }//drawHead
  
  void drawHalfHead(){    
    beginShape();
    fill(bodyColor);
    noStroke();  
    curveVertex(x0+halfColumnW, -y3+halfRowH/2);
    curveVertex(x0, -y3+rowH*0.2);
    curveVertex(x0-halfColumnW, -y3+halfRowH/2);
      //ear
      curveVertex(-x1-halfColumnW, -y3+halfRowH);    curveVertex(-x1-halfColumnW, -y3+halfRowH);
      curveVertex(-x3, -y3+2);
      curveVertex(-x2, -y2);              curveVertex(-x2, -y2);    
    curveVertex(-x2-halfColumnW, -y1);  
    curveVertex(x0, y0);
    curveVertex(x2+halfColumnW, -y1);
    endShape();  
  }//drawHalfHead
  
  void drawEyes(){
      pushMatrix();
        translate(-x1,-y2+halfRowH);
        rotate(hourR);//Rotate according to the current hour
        drawEye('h');//passing 'h' so that the method can determine what data to output
      popMatrix();    
      pushMatrix();
        translate(x1,-y2+halfRowH);
        rotate(minuteR);//Rotate according to the current hour
        drawEye('m');//passing 'm' so that the method can determine what data to output
      popMatrix();
  }//drawEyes
  
  void drawEye(char t){
    float eyeWidth  = columnW*2;
    float eyeHeight = rowH;  
    fill(eyeColor);
    strokeWeight(2);
    if(!jsMode){
    beginShape();  
      vertex(eyeWidth/-2, 0);
      quadraticVertex(0, -eyeHeight, eyeWidth/2, 0);
      vertex(eyeWidth/2, 0);
      quadraticVertex(0, eyeHeight, eyeWidth/-2, 0);
    endShape();    
    }
    //alternative eyes for js
    beginShape();
      curveVertex(eyeWidth/2, 0);
      curveVertex(eyeWidth/2, 0);
      curveVertex(0, eyeHeight/1.8);
      curveVertex(eyeWidth/-2, 0);
      curveVertex(eyeWidth/-2, 0);
    endShape();
    beginShape();
      curveVertex(eyeWidth/-2, 1);
      curveVertex(eyeWidth/-2, 1);
      curveVertex(0, -eyeHeight/1.8);
      curveVertex(eyeWidth/2, 1);
      curveVertex(eyeWidth/2, 1);
    endShape();
    noStroke();
    drawPupil(t);//drawPupil
  }//drawEye
  
  void drawPupil(char time){
    fill(0);
    if(!explicitMode){
      ellipse(0,0,columnW*0.2,rowH*0.8);
    }
    else{     
      ellipse(columnW*0.6,0,columnW*0.5,rowH*0.5);   
      int t = 99;      
      fill(230);        
      if (time == 'h'){
        t = hour();
        if(t > 12) { t -= 12; }   
        if(jsMode){ textFont(createFont("Curlz MT",columnW/2)); }    
        if(!jsMode){  textFont(font, columnW/2); }
        if(t/10 > 0) { text(t, columnW*0.43, rowH*0.15);} //positing the text according to the digit of time
        else { text(t, columnW*0.5, rowH*0.15); }
      }
      else if (time == 'm' || time == 's'){
        if(time == 'm') { t = minute(); }
        if(time == 's') { t = second(); }
        if(jsMode){ textFont(createFont("Curlz MT",columnW/4)); }    
        if(!jsMode){  textFont(font, columnW/4); }
        text(t, columnW*0.5, rowH*0.1);        
      }
    }
  }//drawPupil
  
  void drawWhiskers(){
    scale(-1, 1);
    drawWhisker();
    scale(-1, 1);
    drawWhisker();
  }//drawWhiskers
  
  void drawWhisker(){
    float gridWidth = columnW;
    float gridHeight = rowH;
    float x, y, whiskerWidth, whiskerHeight;
    
    x = gridWidth/2;
    y = -gridHeight/2;    
    whiskerWidth = map(second(), 0, 60, 0, gridWidth*3);
    whiskerHeight = map(second(), 0, 60, 0.1, 0.5);
    
    stroke(60);
    strokeWeight(2);
    line(x, y-gridHeight*0.1, x+whiskerWidth,y-gridHeight*whiskerHeight);// /
    line(x, y, x+whiskerWidth,y);// -
    line(x, y+gridHeight*0.1, x+whiskerWidth,y+gridHeight*whiskerHeight);// \
  }//drawWhiskers
  
  void drawWhiskerScale(){
    float scaleBarWidth, scaleBarHeight, x, y;
    int counter = 0;
    
    scaleBarWidth = 5;
    scaleBarHeight = 20;
    x = columnW/2;
    y = 0;
    
    while(counter <= 60){      
//      strokeWeight(2);
//      stroke(50);
      fill(20);
      rect(x, y, scaleBarWidth, scaleBarHeight);      
      float fontSize = columnW/2.5;
//      textFont(font, fontSize);
      if(jsMode){ textFont(createFont("Curlz MT",fontSize)); }    
      if(!jsMode){  textFont(font, fontSize); }
      text(counter, x-scaleBarWidth/2, y+scaleBarHeight+fontSize);
      x+= columnW/2; 
      counter+=10;
      strokeWeight(0);
    }
    
  }//drawWhiskerScale
  
  void drawNose(){
    float x, y;
    x =  x0;
    y = -y1;
    
    /* //nose locator
    ellipse(x, y, noseW, noseH);
    */
    fill(noseColor);    
    if(mouseX >  catX-noseW/2 && mouseX < catX+noseW/2 &&
       mouseY > catY-noseH/2 - rowH && mouseY < catY+noseH/2 - rowH){ 
         mouseOnNose = true;
         fill(255,150,150); 
    }
    else { mouseOnNose = false; fill(noseColor); }// }
    if(!jsMode){
      beginShape();
        vertex         (x +   noseW/3, y - noseH/2);
        quadraticVertex(x + 2*noseW/3, y              , x         , y+noseH/2);
        quadraticVertex(x - 2*noseW/3, y              , x- noseW/3, y-noseH/2);
        vertex         (x -   noseW/3, y - noseH/2);
        quadraticVertex(x            , y - 15*noseH/20, x+noseW/3 , y-noseH/2);
      endShape();  
    }
    else{
    //alternative heart-shape nose for JS version
      beginShape();
        curveVertex(x, y+noseH/2);//Bottom
        curveVertex(x, y+noseH/2);//Bottom
        curveVertex (x + 2*noseW/3, y );//Right Control Point
        curveVertex(x+noseW/3,  y - noseH/2); //Top Right
        curveVertex(x,  y - noseH/2.8);//Top Middle
        curveVertex(x,  y - noseH/2.8);//Top Middle
        curveVertex(x-noseW/3, y-noseH/2);// Top Left
        curveVertex (x - 2*noseW/3, y );//Left Control Point
        curveVertex(x, y+noseH/2);//Bottom
        curveVertex(x, y+noseH/2);//Bottom
      endShape();
    }
  }//drawNose
  
//  void drawEars(){
//    scale(-1, 1);
//    drawEar();
//    scale(-1, 1);
//    drawEar();
//  }//drawEars
  
  void drawBody(){
    scale(-1, 1);
    drawHalfBody();
    scale(-1, 1);
    drawHalfBody();
  }//drawBody
  
  void drawHalfBody(){   
    beginShape();
      fill(bodyColor);
      noStroke(); 
      curveVertex(-columnW*0.0,  rowH*0.0);curveVertex(-columnW*0.0,  rowH*0.0);
      curveVertex(-columnW*0.1,  rowH*0.0);
      curveVertex(-columnW*0.2,  rowH*1.0);
      curveVertex(-columnW*0.3,  rowH*1.3);
      curveVertex(-columnW*0.4,  rowH*1.5);
      curveVertex(-columnW*0.5,  rowH*2.0);
      curveVertex(-columnW*0.3,  rowH*2.5);
      curveVertex(-columnW*0.8,  rowH*2.7);
      curveVertex(-columnW*1.0,  rowH*2.9);
      curveVertex(-columnW*0.9,  rowH*3.0);
      curveVertex(-columnW*0.2,  rowH*3.0);
      curveVertex(-columnW*0.0,  rowH*2.8); curveVertex(-columnW*0.0,  rowH*2.8);    
    endShape();  
  }//drawHalfBody
  
  void drawTail(){    
    float tailRotation ;//= 1.9*PI;
    if(second()<=30){ tailRotation = map(second(), 0, 30, 1.9*PI,  2.2*PI) ; }
    else{ tailRotation = map(second(), 31, 60, 2.2*PI,  1.9*PI) ; }

    pushMatrix();    
    translate(x0,y2);
    rotate(tailRotation);//1.9*PI =>  2.2*PI
    
    fill(255,0,0);
    beginShape();
      fill(bodyColor);
      noStroke(); 
      curveVertex(columnW*+0.0,  rowH*-0.2);curveVertex(columnW*+0.0,  rowH*-0.2);
      curveVertex(columnW*-0.7,  rowH* 0.0);
      curveVertex(columnW*-1.3,  rowH*-0.2);
      curveVertex(columnW*-1.5,  rowH*-0.5);
      curveVertex(columnW*-1.0,  rowH*-1.0); 
      curveVertex(columnW*-1.5,  rowH*-1.5);
      curveVertex(columnW*-1.9,  rowH*-1.4);
      curveVertex(columnW*-2.1,  rowH*-1.2);
      curveVertex(columnW*-2.2,  rowH*-1.0);
      curveVertex(columnW*-2.3,  rowH*-0.5);
      curveVertex(columnW*-2.0,  rowH* 0.0);    
      curveVertex(columnW*-1.0,  rowH* 0.4);
      curveVertex(columnW*+0.0,  rowH* 0.0);curveVertex(columnW*+0.0,  rowH*0.0);
    endShape();  
    popMatrix();
  }//drawTail
  
  void switchMode(){
    explicitMode = !explicitMode;
//    if(explicitMode){ println("Explicit Mode");}
//    if(!explicitMode){ println("Implicit Mode");}
//     println("switching mode");
  }//switchMode

}//Cat
void draw(){
  hourR   = map(  hour(), 0, 12, 0,  TWO_PI) - HALF_PI;
  minuteR = map(minute(), 0, 60, 0,  TWO_PI) - HALF_PI;
  secondR = map(second(), 0, 60, 0,  TWO_PI) - HALF_PI;
//  println(hour()+":"+minute()+":"+second());  
  
  if(key1) explicitMode = false;
  if(key2) explicitMode = true;
  
  drawBG();
  

  //  cat = new Cat();
  cat.drawCat();

  if(keyG) { drawGrid(width, height); } //draw grid only if the 'g' key is hold

}

void mouseClicked(){
  if(cat.mouseOnNose){ cat.switchMode(); }
}
void drawBG() {
  fill(10, 186, 181);
  rect(0, 0, width, height);
}

void drawGrid(float w, float h){
  strokeWeight(5);
  stroke(50,50,50,50);
  for(float i=0 ; i<8 ; i++){ line(  (i/8)*w, 0, (i/8)*w, h); }
  for(float i=0 ; i<6 ; i++){ line(0, (i/6)*h, w, (i/6)*h); }
  strokeWeight(0);
}

boolean key1, key2, keyG;

void keyPressed() {
  if (key == 'g' || key == 'G') keyG = true;
  if (key == '1') key1 = true; 
  if (key == '2') key2 = true; 
}

void keyReleased() {
  if (key == '1') key1 = false; 
  if (key == '2') key2 = false; 
  if (key == 'g' || key == 'G') keyG = false; 
}

void setup(){
  size(900, 675);
   if(jsMode){ 
     textFont(createFont("Curlz MT",32));
   }//fontName = "data/CurlzMT.ttf"; }
   if(!jsMode){ String fontName = "CurlzMT-30.vlw";  font = loadFont(fontName); }
   
   
  catWidth  = 700;//600;//700
  catHeight = 550;//450;//550
  catBodyColor = color(25,   25, 25);   //black
  catEyeColor  = color(120, 255,  0);   //green
  catNoseColor = color(200,   0,  0);   //red
  catEarColor  = color(200,   0,  0);   //red
  
    //create a Cat class with a customized cat size and color
  cat = new Cat(catWidth, catHeight, catBodyColor, catEyeColor, catNoseColor, catEarColor); 
  
}

void changeSize(int w, int h, int cw, int ch){
  size(w,h);
  catWidth = cw;
  catHeight = ch;
  cat = new Cat(catWidth, catHeight, catBodyColor, catEyeColor, catNoseColor, catEarColor); 
  
}

