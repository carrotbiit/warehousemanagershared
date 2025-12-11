class  Warehouse  {
  //fields
  PVector pos;  //position, centre
  float w, h;  //width and height of the warehouse
  
  //constructor
  Warehouse(PVector p, float wi, float he)  {
    this.pos = p.copy();
    this.w = wi;
    this.h = he;
    
  }
  
  //methods
  void  drawMe()  {
    fill(170);
    rectMode(CENTER);
    rect(pos.x, pos.y, w, h);
    
  }
  
  
  
}
