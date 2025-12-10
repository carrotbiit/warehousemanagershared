class  Shelf  {
  //fields
  PVector  pos;  //position of the shelves, the centre of the drawn rectangle
  ArrayList<Package>  stored;  //list of stored package objects, String is a place holder
  ArrayList<Boolean>  claimed;
  
  //constructor
  Shelf(PVector p)  {
    this.pos = p.copy();
    this.stored = new ArrayList();
    this.claimed = new ArrayList();
  }
  
  //methods
  void  drawMe()  {
    
    //strokeWeight(2);
    //stroke(100);
    rectMode(CENTER);
    //fill(130);
    //fill(0,0,255);
    fill(0,0);
    stroke(0,0,200);
    rect(pos.x, pos.y, sW, sH);
    
    fill(255);
    textAlign(CENTER);
    //textSize(14);
    //text(Shelves.indexOf(this) , this.pos.x, this.pos.y + (sH/2));
    textSize(20);
    text(this.stored.size() , this.pos.x + 50, this.pos.y + (sH/2));
    
    noStroke();
    for  (int i = 0; i < this.stored.size(); i++)  {
      fill(this.stored.get(i).colour);
      square(this.pos.x - ((-i+2) * sH), this.pos.y, sH -2);
    
    }
    
    String msg = "";
    for  (int i = 0; i < this.claimed.size(); i++)  {
      msg += this.claimed.get(i) + "\t";
    }
    println(msg);
    //println(this.claimed.size());
    
  }
  
  //void  addPackage()  {
  
  //}
  //void  removePackage()  {
  
  //}
  
}
