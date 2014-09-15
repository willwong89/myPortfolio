/*  This TimeSeries project is done for 
 *  IAT 355 Introduction to Visual Analysis
 *  by William Wong (301155106).
 *  
 *  Time taken: 3 Days
 *  Last modified: 8-Feb-2013 03:22
 */
 
 
 //global var
String data[] ;
ArrayList <Date> dateValues;
ArrayList <TimeSeries> ts;// au, uk, ca, nk, fr, de, jp, ch
PFont font;
Graph graph;
int graphW, graphH, graphX, graphY;

//UI var
Date startDate = new Date(1983, 06, 01);//1983, 01, 01
Date endDate = new Date(1985, 06, 30);//1985, 06, 30
boolean[] showCountry = {true, true, true, true, true, true, true, true};
boolean unifiedYScale = false ;
float globalMinCurrency, globalMaxCurrency;
boolean connectPlottedPoints = true;

String[] flagButtonIconPath = {"data/icon/flag/au.png", "data/icon/flag/uk.png", "data/icon/flag/ca.png", "data/icon/flag/nk.png",
                             "data/icon/flag/fr.png", "data/icon/flag/de.png", "data/icon/flag/jp.png", "data/icon/flag/ch.png"}; 
String[] connectedIconPath = {"data/icon/connected.png", "data/icon/notConnected.png"};
String[] arrowIconPath = {"data/icon/plus.png" , "data/icon/plusHover.png",
                                 "data/icon/minus.png", "data/icon/minusHover.png"}; 
String randomizePlotColorButtonIconPath = "data/icon/randomizePlotColorIcon.png";
//Button and ButtonPanel
ButtonPanel fbp; //Flag Button Panel
Button uysb; //unifiedYScaleButton
Button connectPlottedPointsButton;//connectPlottedPointsButton
Button randomizePlotColorButton;
ArrayList<ButtonPanel> dibp = new ArrayList();









//methods
int getSI(){
  int si = 0;
  for(int i=0 ; i<dateValues.size(); i++){
    if(firstDateEarlier(dateValues.get(i),startDate)){ si = i; }
  }
  return si;
}//end getSI


int getEI(){
  int ei = 0;
  for(int i=0 ; i<dateValues.size(); i++){
    if(firstDateEarlier(dateValues.get(i),endDate)){ ei = i; }
  }
  return ei;
}//end getEI


boolean firstDateEarlier(Date one, Date two){
 
 //compare year
 if(one.getYear() < two.getYear()){
   return true;
 }
 else if(one.getYear() > two.getYear()){
   return false;
 }
 else{ // year == year
   //compare month
   if(one.getMonth() < two.getMonth()){
     return true;
   }
   else if(one.getMonth() > two.getMonth()){
     return false;
   }
   else{ //month == month
     //compare day
     if(one.getDay() <= two.getDay()){
       return true;
     }
     else{
       return false;
     }//end day check
   }//end month check   
 }// end year check
 
}//end firstDateEarlier


void initGlobalMaxMin(){
  globalMinCurrency = 0;
  globalMaxCurrency = 0; 

  for(int i=0 ; i<ts.size() ; i++){
    if(showCountry[i]){
      TimeSeries temp = ts.get(i);
      if(globalMinCurrency == 0){globalMinCurrency = ts.get(i).getMinCurrency(); }
      if(globalMinCurrency > ts.get(i).getMinCurrency()) { globalMinCurrency = ts.get(i).getMinCurrency(); }
      if(globalMaxCurrency < ts.get(i).getMaxCurrency()) { globalMaxCurrency = ts.get(i).getMaxCurrency(); }
    }
  }
  
}//end initGlobalMaxMin()

void randomizeTSColor(){
  for(int i=0 ; i<ts.size() ; i++){
    ts.get(i).setPlotColor(color(random(255), random(255), random(255)));

  }
  if(fbp != null){
  for(int i=0 ; i<fbp.getSize() ; i++){
      fbp.setButtonColor(i, ts.get(i).getPlotColor()) ;
  }
  }
}
class Button{
  
  //fields
  int x, y, w, h;
  PImage icon, hoverIcon;
  String iconPath = "";
  String hoverIconPath = "";
  color c, hc;

  //constructor
  Button(int x_, int y_){
    x = x_;
    y = y_;
    w = 50;
    h = 50;  
    initColor();
  }
  Button(int x_, int y_, int w_, int h_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    initColor();
  }  
  Button(int x_, int y_, int w_, int h_, color c_, color hc_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
    hc = hc_;
  }  
  Button(int x_, int y_, int w_, int h_, String iconPath_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    iconPath = iconPath_;
    initColor();
    initIcon();
  }
    Button(int x_, int y_, int w_, int h_, color c_, color hc_, String iconPath_){
    x = x_;
    y = y_;
    w = w_;
    h = h_;   
    c = c_;
    hc = hc_;
    iconPath = iconPath_;
    initIcon();
  }
  
  //methods
  void initColor(){
    c = color(random(0,255), random(0,255), random(0,255) );
    hc = color(random(0,255), random(0,255), random(0,255) ); 
  }
  void initIcon(){
    if(iconPath != ""){
      icon = loadImage(iconPath);
    }
  }
  void initHoverIcon(){
    if(hoverIconPath != ""){
      hoverIcon = loadImage(hoverIconPath);
    }
  }
  void drawButton(){
    
    //draw the button
    fill(c);
    rect(x, y, w, h);
    
    //draw the icon
    if(icon != null){
//      icon = loadImage(iconPath);
      image(icon, 
            x + (w-icon.width)  /2, 
            y + (h-icon.height) /2);
    }
    
    if(mouseX>= x && mouseX<=x+w && mouseY>= y && mouseY<=y+h){
      //if mouse on a button
      fill(hc);
      rect(x-1, y-1, w+2, h+2);
      
      //draw the icon
      if(hoverIcon != null){
//      icon = loadImage(iconPath);
      image(hoverIcon, 
            x + (w-hoverIcon.width)  /2, 
            y + (h-hoverIcon.height) /2);
      }
    }
    
    
  }//draw()
  
  //getter
  boolean getMouseOnBoolean(){
    if(mouseX>= x && mouseX<=x+w && mouseY>= y && mouseY<=y+h){ return true; }
    return false;
  }
  
  //setter
  void setX(int x_) { x = x_; }
  void setY(int y_) { y = y_; }
  void setWidth(int w_) { w = w_; }
  void setHeight(int h_) { h = h_; }
  void setColor(color c_) { c = c_; }
  void setHoverColor(color hc_) { hc = hc_; }
  void setIconPath(String iconPath_) { iconPath = iconPath_; initIcon(); }  
  void setHoverIconPath(String hoverIconPath_) { hoverIconPath = hoverIconPath_; initHoverIcon(); }  
  
}//Button


class ButtonPanel{
  
  //panel fields
  Button[] btns;  
  int x, y, w, h;
  int col; //column
  color c; //panel color
  
    //btn fields
    int bw, bh, howManyBtns;
    
    
  //constructor
  ButtonPanel(int x_, int y_, int w_, int h_, int bw_, int bh_, int howManyBtns_, int col_){ 
    x = x_;
    y = y_;
    w = w_;
    h = h_;    
    howManyBtns = howManyBtns_;
    col = col_;
    bw = bw_;
    bh = bh_;    
    c = color(255);
    initButton();
  }//ButtonPanel
  
  

  //methods
  void initButton(){
    
    btns = new Button[howManyBtns];
    float row = (howManyBtns/col) -1;
    float bx = x;
    float bxi;
    if(col != 1){
      bxi = (w/(col-1)) - bw/(col-1);
    }
    else bxi = w;
    float by = y;       
    float byi = (h)/row - bh/row;//bh; 
    
    for(int i=0 ; i<btns.length ; i++){       
      if( i!= 0 && i % col == 0) { 
        by += byi;
        bx = x;
      }//if    
      btns[i] = new Button((int)bx, (int)by, (int)bw, (int)bh, color(20), color(255,0,0,50));
      bx += bxi;
    }//for
  }//initButton()
  
  void drawPanel(){

    fill(c);
    noStroke();
    rect(x,y,w,h);
    
    for(int i=0 ; i<btns.length; i++){
      Button b = btns[i];
      b.drawButton();
//      boolean bOn = b.mouseOn();
    }

  }//draw()
  
  //setter
  void setButtonX(int i , int x_) { if( i < btns.length ){ btns[i].setX(x_);  }}
  void setButtonY(int i , int y_) { if( i < btns.length ){ btns[i].setY(y_);  }}
  void setButtonWidth(int i , int w_) { if( i < btns.length ){ btns[i].setWidth(w_); initButton();}}  
  void setButtonHeight(int i , int h_) { if( i < btns.length ){ btns[i].setHeight(h_); }}
  void setButtonSize(int i, int s) { if( i < btns.length ){ btns[i].setWidth(s); btns[i].setHeight(s); }}
  
  void setButtonColor(int i, color c) { if( i < btns.length ){ btns[i].setColor(c); } }
  void setButtonHoverColor(int i, color hc) { if( i < btns.length ){ btns[i].setHoverColor(hc); } }
  void setButtonIconPath(int i, String path){ if( i < btns.length ){ btns[i].setIconPath(path); } }
  void setButtonHoverIconPath(int i, String path){ if( i < btns.length ){ btns[i].setHoverIconPath(path); } }
  
  //getter
  int getSize(){ return btns.length; }    
  boolean[] getButtonMouseOn(){    
    boolean[] b = new boolean[btns.length];
    for(int i=0 ; i<btns.length ; i++){    b[i] = btns[i].getMouseOnBoolean();    }
    return b;
  }

}
class Date{
 int year;
 int month;
 int day;
 
 Date(String s){
   year = int(s.substring(0,4));
   month = int(s.substring(5,7));
   day = int(s.substring(8,10));
 } 
 Date(int y, int m, int d){
   year = y;
   month = m;
   day = d;
 } 
 
 int getYear(){return year;}
 int getMonth(){return month;}
 int getDay(){return day;}
 
 void setYear(int y){ year = y; }
 void setMonth(int m){ month = m; }
 void setDay(int d){ day = d; }
 
 void increaseYear(){ year++; }
 void decreaseYear(){ year--; }
 void increaseMonth(){ month++; if(month>12){ month = 1; }}
 void decreaseMonth(){ month--; if(month<1){ month = 12; }}
 void increaseDay(){ day++; if(day>31){ day = 1; }}
 void decreaseDay(){ day--; if(day<1){ day = 31; }}
 
 String getMonthString(){
   if(month == 1){ return "Jan"; }
   else if(month == 2){ return "Feb"; }
   else if(month == 3){ return "Mar"; }
   else if(month == 4){ return "Apr"; }
   else if(month == 5){ return "May"; }
   else if(month == 6){ return "Jun"; }
   else if(month == 7){ return "Jul"; }
   else if(month == 8){ return "Aug"; }
   else if(month == 9){ return "Sep"; }
   else if(month == 10){ return "Oct"; }
   else if(month == 11){ return "Nov"; }
   else if(month == 12){ return "Dec"; }
   else  return "Error";
 }
}
class Graph {

  //fields
  ArrayList<Date> date;
  color graphBGColor = color(235);  
  int pixelW = 600/30;//  graphW/howManyPixelsIWant 
  int pixelH = 50;


  //constructor
  Graph(ArrayList<Date> d) {    
    date = d;
  }//Graph()


  //methods
  void drawGraph() {
    pushMatrix();
    translate(graphX, graphY);

    fill(graphBGColor);
    stroke(0);
    rect(0, 0, graphW, graphH);

    strokeWeight(3);
    line(0, graphH, graphW, graphH);
    line(0, 0, 0, graphH);
    strokeWeight(0);

    popMatrix();
  }//drawGraph

  void drawGridMarking(int si, int ei) {

    pushMatrix();
    translate(graphX, graphY);  

    
    Date sd = date.get(si);
    Date ed = date.get(ei);
    int py = 0;
    int pm = 0;
    int pd = 0;
    int yearDifference = ed.getYear() - sd.getYear();
    int monthDifference = (yearDifference*12) + ed.getMonth() - sd.getMonth();
  


    //print every month
    for (int i=si ; i<=ei ; i++) {
      int y = date.get(i).getYear();
      if(py != y){
        //print year
        stroke(255, 0, 0);
        float plotX = map(i, si, ei, 0, graphW);
        Date d = date.get(i);
        //draw grid marking
        strokeWeight(2);
        stroke(color(255, 0, 0, 50));
        strokeWeight(1);
        //print line
        line(plotX, 0, plotX, graphH);
        //print X axis text
        fill(0);
        textFont(font, 15);
        text(date.get(i).getYear(), plotX-10, graphH+35);    
        py = y;
      }
      
      if (monthDifference < 20) {//if the range is within 15 months
        int m = date.get(i).getMonth();
        if (pm != m) {
          //print month
          stroke(255, 0, 0);
          float plotX = map(i, si, ei, 0, graphW);
          Date d = date.get(i);
          //draw grid marking
          strokeWeight(1);
          stroke(color(255, 0, 0, 50));
          //print line
          line(plotX, 0, plotX, graphH);
          //print X axis text
          fill(50);
          textFont(font, 10);
          text(date.get(i).getMonthString(), plotX-10, graphH+15);    
          pm = m;

        }//end if pm !=m
      }//end if the range is within 15 months
    }//end for


    if(unifiedYScale){
      fill(0);
      textFont(font, 10);
      text(globalMaxCurrency, -45, 0); 
      text((globalMaxCurrency+globalMinCurrency)/4, -45, graphH/4);   
      text((globalMaxCurrency+globalMinCurrency)/2, -45, graphH/2);  
      text((globalMaxCurrency+globalMinCurrency)*3/4, -45, graphH*3/4);   
      text(globalMinCurrency, -45, graphH);  
    }
    popMatrix();
  }//drawGridMarking
}

class TimeSeries{
  
  //fields
  ArrayList <Date> date = new ArrayList();
  ArrayList <Float> currency = new ArrayList();
  
  float maxCurrency;
  float minCurrency;
  
  color plotColor = color(255,0,0);
  
  //constructor
  TimeSeries(ArrayList<Date> d, ArrayList <Float> c){
    date = d;
    currency = c;
    
    initCurrencyRange();
  }
  
  //methods
  void initCurrencyRange(){
    float max, min;
    max = min = currency.get(0);
    for(int i=1 ; i<currency.size() ; i++){
      if(currency.get(i)>max) { max = currency.get(i); }
      if(currency.get(i)<min) { min = currency.get(i); }
    }
    maxCurrency = max;
    minCurrency = min;
  }
  
  void plotter(int si, int ei){
    if(unifiedYScale){//global var
      maxCurrency = globalMaxCurrency;
      minCurrency = globalMinCurrency;
    }
    else{ initCurrencyRange(); }
    pushMatrix();
    translate(graphX, graphY);

    noStroke();
 
    for(int i=si ; i< ei; i++){
        float plotX = 0; //map time to window x , using i
        float plotY = 0; //map currency data to windoy y
        plotX = map(i, si, ei, 0, graphW);
        plotY = map(currency.get(i), minCurrency, maxCurrency, graphH, 0);
        fill(plotColor);
        ellipse(plotX, plotY, 2, 2);
        if(connectPlottedPoints){
          if(i!=si){
            float pPlotX = map(i-1, si, ei, 0, graphW);
            float pPlotY = map(currency.get(i-1), minCurrency, maxCurrency, graphH, 0);
            strokeWeight(1);
            stroke(plotColor);
            line(pPlotX, pPlotY, plotX, plotY);
          }
        }
    }
 
    popMatrix();
    
    initCurrencyRange();
  }
  
  //setter
  void setPlotColor(color c){ plotColor = c; }
  
  //getter
  ArrayList<Date> getDate(){  return date;  }
  Date getDate(int i){  return date.get(i);  }
  ArrayList<Float> getCurrency(){  return currency;  }
  float getCurrency(int i){  return currency.get(i);  }
  float getMaxCurrency(){ return maxCurrency;  }
  float getMinCurrency(){ return minCurrency; }
  color getPlotColor(){ return plotColor; }
}
void draw(){
  smooth();
  int si = getSI();
  int ei = getEI();

  //bg
  drawBG();  
  
 
  //graph
  graph.drawGraph();
  graph.drawGridMarking(si, ei);

  //timeSeries
  for(int i=0 ; i<ts.size() ; i++){
    TimeSeries t = ts.get(i);
    if(showCountry[i]){
      t.plotter(si, ei);
    }
  }//end for
    
  //flag button panel
  fbp.drawPanel();
  
  //unifiedYScaleButtib
  uysb.drawButton(); //x=20, y=265, w=120, h=20
  color uysbTextColor = color(255);
  String uysbText;
  if(unifiedYScale){ uysbText = "real scale ON" ;}
  else{ uysbText = "real scale OFF" ;}
  fill(uysbTextColor);
  textFont(font, 15);
  text(uysbText, 35, 280);     
 
  //connectPlottedPointsButton
  //connectPlottedPointsButton.setIconPath(connectedIconPath[int(connectPlottedPoints)]);
  connectPlottedPointsButton.drawButton();
  	
  	
  //randomizePlotColorButton
  randomizePlotColorButton.drawButton();
  
  //timeIntervalPanel
  color timeIntervalTextColor = color(50);
  fill(color(0));
  text("Start Date", 20, 395);    
  text("End Date", 20, 475);   
  
  for(int i=0 ; i<dibp.size() ; i++){
    ButtonPanel tsdbp = dibp.get(i);
    tsdbp.drawPanel();
  }

  fill(timeIntervalTextColor);
  textFont(font, 12); 
    text(startDate.getYear(), 35, 425);   
    text(startDate.getMonth(), 75, 425);   
    text(startDate.getDay(), 100, 425);       
    text(endDate.getYear(), 35, 505);   
    text(endDate.getMonth(), 75, 505);   
    text(endDate.getDay(), 100, 505);     
  
  
  

}//draw
color bgColor = color(255);

void drawBG(){
  noStroke();
  fill(bgColor);
  rect(0,0,width,height);
  
}
void mouseClicked(){

  //Flag Buttons
  boolean[] mouseOnFlag = fbp.getButtonMouseOn();
  int countryIndex = -1;
  for(int i=0 ; i<mouseOnFlag.length ; i++){
      if(mouseOnFlag[i]){ countryIndex = i; }
  }
  if(countryIndex != -1){
    showCountry[countryIndex] = !showCountry[countryIndex];  
     initGlobalMaxMin();
    if(showCountry[countryIndex]){  fbp.setButtonColor(countryIndex, ts.get(countryIndex).getPlotColor()) ;}//color(0,150,0)  ); } 
    else {             fbp.setButtonColor(countryIndex, color(255,255,255,0)); }
  }
  countryIndex = -1;
  
  boolean mouseOnUnifiedScale = uysb.getMouseOnBoolean();
  if(mouseOnUnifiedScale){  unifiedYScale =! unifiedYScale; }

  boolean mouseOnConnectPlottedPoints = connectPlottedPointsButton.getMouseOnBoolean();
  if(mouseOnConnectPlottedPoints){  
  	connectPlottedPoints =! connectPlottedPoints ; 
  	if(connectPlottedPoints)
		connectPlottedPointsButton.setIconPath(connectedIconPath[1]);
  	else
  		connectPlottedPointsButton.setIconPath(connectedIconPath[0]);
  }
  
  
  boolean mouseOnRandomizePlotColorButton = randomizePlotColorButton.getMouseOnBoolean();
  if(mouseOnRandomizePlotColorButton){ randomizeTSColor();  }
  
  
  for(int i=0 ; i<dibp.size() ; i++){
    ButtonPanel bp = dibp.get(i); //6 in total
    boolean[] mouseOnArrow = bp.getButtonMouseOn();//0 = up, 1 = down
    
    //start year
    if( i == 0 ){
      if(mouseOnArrow[0]){ if(startDate.getYear() != endDate.getYear()) { startDate.increaseYear(); }}//+
      if(mouseOnArrow[1]){  startDate.decreaseYear(); } //- 
    }
    if( i == 1 ){
      if(mouseOnArrow[0]){ startDate.increaseMonth(); }//+
      if(mouseOnArrow[1]){ startDate.decreaseMonth(); } //- 
    }
    if( i == 2 ){
      if(mouseOnArrow[0]){ startDate.increaseDay(); }//+
      if(mouseOnArrow[1]){ startDate.decreaseDay(); } //- 
    }
    //end year
    if( i == 3 ){
      if(mouseOnArrow[0]){  endDate.increaseYear(); }//+
      if(mouseOnArrow[1]){ if(startDate.getYear() != endDate.getYear()) { endDate.decreaseYear(); }} //- 
    }
    if( i == 4 ){
      if(mouseOnArrow[0]){ endDate.increaseMonth(); }//+
      if(mouseOnArrow[1]){ endDate.decreaseMonth(); } //- 
    }
    if( i == 5 ){
      if(mouseOnArrow[0]){ endDate.increaseDay(); }//+
      if(mouseOnArrow[1]){ endDate.decreaseDay(); } //- 
    }
  }


}

void setup(){
  
  size(800,600);
  
  //graphX, graphY, graphW, graphH are used by Graph() and TimeSeries()
  graphW = 600;
  graphH = 500;
  graphX =  width  - graphW - 10;
  graphY = (height - graphH)/2;
  

  
  // read excel file and put into data 
  data = loadStrings( "data/daily-foreign-exchange-1983-1985.csv" );


  //temp arratList
  dateValues = new ArrayList();
  ArrayList <Float> auCurrency = new ArrayList();
  ArrayList <Float> caCurrency = new ArrayList();
  ArrayList <Float> chCurrency = new ArrayList();
  ArrayList <Float> deCurrency = new ArrayList();
  ArrayList <Float> frCurrency = new ArrayList();
  ArrayList <Float> jpCurrency = new ArrayList();
  ArrayList <Float> nkCurrency = new ArrayList();
  ArrayList <Float> ukCurrency = new ArrayList();
  
  //the first line and the last 2 lines are not data
  for (int i=1 ; i< data.length-2 ; i++){ 
    String[] line;//date, au, uk, ca, nk, fr, de, jp, ch
    line = split(data[i], ',');
    
    dateValues.add(new Date(line[0]));    
    auCurrency.add(float(line[1]));
    ukCurrency.add(float(line[2]));
    caCurrency.add(float(line[3]));    
    nkCurrency.add(float(line[4]));
    frCurrency.add(float(line[5]));
    deCurrency.add(float(line[6]));
    jpCurrency.add(float(line[7]));
    chCurrency.add(float(line[8]));
  }//for
  
  //init TimeSeries  ts
  ts = new ArrayList();
  ts.add(new TimeSeries(dateValues, auCurrency));
  ts.add(new TimeSeries(dateValues, ukCurrency));
  ts.add(new TimeSeries(dateValues, caCurrency));
  ts.add(new TimeSeries(dateValues, nkCurrency));
  ts.add(new TimeSeries(dateValues, frCurrency));
  ts.add(new TimeSeries(dateValues, deCurrency));
  ts.add(new TimeSeries(dateValues, jpCurrency));
  ts.add(new TimeSeries(dateValues, chCurrency));
  
  //assign a unique color for each time series
//  randomizeTSColor();
  for(int i=0 ; i<ts.size() ; i++){
    ts.get(i).setPlotColor(color(0,150,0));
  }
  
  
  
  //init Graph graph
  graph = new Graph(dateValues);
  

  initGlobalMaxMin();
  
  //init PFont font
  font = loadFont("Helvetica-Light-48.vlw");
  
  
  //ButtonPanel
  //flagButton                           
  fbp = new ButtonPanel(20 , 50, 120, 200, //panel x, y, w, h
                        55 , 45,           //btn w, h
                        8  ,  2);          //howManyButton and row
  //customize each button's attribute
  for(int i=0 ; i<fbp.getSize() ; i++){
//    fbp.setButtonColor(i, color(0,150,0));
    fbp.setButtonColor(i, ts.get(i).getPlotColor());
    fbp.setButtonIconPath(i, flagButtonIconPath[i]);
  }
  
  //unifiedYScaleButton
  uysb = new Button(20, 265, 120, 20, color(20), color(50));
  
  //connectPlottedPointsButton
  connectPlottedPointsButton = new Button(20, 290, 120, 40, color(0), color(50, 70));
  connectPlottedPointsButton.setIconPath(connectedIconPath[int(connectPlottedPoints) ]);
  
  //randomize plotColor button
  randomizePlotColorButton = new Button(20, 335, 120, 20, color(10), color(50,70));
  randomizePlotColorButton.setIconPath(randomizePlotColorButtonIconPath);
  
  //date interval ButtonPanel
  //start date
  dibp.add( new ButtonPanel( 40, 400, 20, 45, 15, 15, 2, 1) );
  dibp.add( new ButtonPanel( 70, 400, 20, 45, 15, 15, 2, 1) );
  dibp.add( new ButtonPanel( 95, 400, 20, 45, 15, 15, 2, 1) );
  //end date
  dibp.add( new ButtonPanel( 40, 480, 20, 45, 15, 15, 2, 1) );
  dibp.add( new ButtonPanel( 70, 480, 20, 45, 15, 15, 2, 1) );
  dibp.add( new ButtonPanel( 95, 480, 20, 45, 15, 15, 2, 1) );

  for(int i=0 ; i<dibp.size() ; i++){
    ButtonPanel temp = dibp.get(i);

        temp.setButtonHoverColor(0, color(255,0,0,0));
        temp.setButtonHoverColor(1, color(255,0,0,0));
        temp.setButtonIconPath(0, arrowIconPath[0]);
        temp.setButtonHoverIconPath(0, arrowIconPath[1]);
        temp.setButtonIconPath(1, arrowIconPath[2]);
        temp.setButtonHoverIconPath(1, arrowIconPath[3]);

  }
  //   println(firstDateEarlier(new Date(1990,11,27), new Date(1990, 12,27)  ));
}//setup()

