// Class to represent roads and streets
class Road {
  // Fields
  ArrayList<House> houses;
  PVector center;
  String orientation; // "Vertical" or "Horizontal"
  float radiusWidth, radiusHeight;
  boolean isEnd; // End of the road
  
  
  // Constructor method
  Road(float centerX, float centerY, String orientation, float radiusWidth, float radiusHeight, boolean isEnd) {
    this.houses = new ArrayList<House>();
    this.center = new PVector(centerX, centerY);
    this.orientation = orientation;
    this.radiusWidth = radiusWidth;
    this.radiusHeight = radiusHeight;
    this.isEnd = isEnd;
  }
  
  // Add house method
  void addHouse() {
    // Process location of the next house
    int houseCount = this.houses.size();
    int level = houseCount / 2;
    float distance = this.center.x - this.radiusWidth + (level + 1) * (houseDistance + houseSize);
    
    // Add the next houses
    House houseAbove = new House(this, distance, this.center.y - houseDistance);
    House houseBelow = new House(this, distance, this.center.y + this.radiusHeight);
    this.houses.add(houseAbove);
    this.houses.add(houseBelow);
    allHouses.add(houseAbove);
    allHouses.add(houseBelow);
  }
  
  // Draw method
  void drawMe() {
    // Draw the main road segment
    fill(80);
    rectMode(RADIUS);
    rect(this.center.x, this.center.y, this.radiusWidth, this.radiusHeight); 
    
    // Draw lanes and road endings
    if (detail.equals("high")) {
      if (this.isEnd) {
        arc(this.center.x + this.radiusWidth, this.center.y, roadWidth, roadWidth, -HALF_PI, HALF_PI);
      }   
      drawLanes();
    }
  }
  
  // Draw lanes
  void drawLanes() {
    float x, y;
    fill(255);
    rectMode(RADIUS);
    if (orientation.equals("Horizontal")) {
      x = this.center.x - this.radiusWidth;
      y = this.center.y;
      for (int count = 0; count < this.radiusWidth / (2 * laneMarkingWidth); count++) {
        rect(x, y, laneMarkingWidth, 1);
        x += 4 * laneMarkingWidth;
      }
    } else {
      x = this.center.x;
      y = this.center.y - this.radiusHeight;
      for (int count = 0; count < this.radiusHeight / (2 * laneMarkingWidth); count++) {
        rect(x, y, 1, laneMarkingWidth);
        y += 4 * laneMarkingWidth;
      }
    }
  }
}
