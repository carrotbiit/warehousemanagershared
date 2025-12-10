// Class to represent homes
class  House  {
  // Fields
  ArrayList<Package> ordered;
  Road street;
  PVector position;
  
  // Constructor method
  House(Road street, float x, float y) {
    this.ordered = new ArrayList<Package>();
    this.street = street;
    this.position = new PVector(x, y);    
  }
  
  // Draw method
  void drawMe() {
    fill(200, 0, 0);
    square(this.position.x, this.position.y, houseSize);
  }
}
