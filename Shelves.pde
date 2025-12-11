class  Shelf  {
  //fields
  PVector  pos;  //position of the shelves, the centre of the drawn rectangle
  ArrayList<Package>  stored;  //list of stored package objects, String is a place holder
  int  capacity;  //How many additional packages we can store (for worker claiming)
  
  //constructor
  Shelf(PVector p)  {
    this.pos = p.copy();
    this.stored = new ArrayList();
    this.capacity = shelfCapacity;
  }
  
  //methods
  void  drawMe()  {
    rectMode(CENTER);
    fill(0,0);
    stroke(0,0,200);
    rect(pos.x, pos.y, sW, sH);
    
    fill(255);
    textAlign(CENTER);
    textSize(20);
    
    if (!detail.equals("Low")) {
      if  (detail.equals("High"))  {
        text(this.stored.size() , this.pos.x + 50, this.pos.y + (sH/2));
      }

      //drawing packages on the shelf
      noStroke();
      for  (int i = 0; i < this.stored.size(); i++)  {
        
        color  col = this.stored.get(i).colour;
        
        fill(col);
        
        if (detail.equals("High")) {
          strokeWeight(2);
          stroke(  red(col)*0.5, green(col)*0.5, blue(col)*0.5  );
        }
        
        square(this.pos.x - ((-i+int(shelfCapacity/2)) * sH), this.pos.y, sH);
      }
    }
    
  }
  
}
