// Class to represent roads and streets
class Road {
  // Fields
  ArrayList<House> houses; // Houses that are located on the street
  PVector center;
  String orientation; // "Vertical" or "Horizontal"
  float radiusWidth, radiusHeight;
  boolean isEnd; // End of the road --> draws a circular arc at the end
  // Road ending fields to avoid duplicate calculations
  float leftX;
  float rightX;
  float topY;
  float bottomY;
  // Road lane fields to avoid duplicate calculations
  float laneStart;
  int numLanes;
  // Location of the next house to avoid duplicate calculations
  float houseLocation; 
  
  // Constructor method
  Road(float centerX, float centerY, String orientation, float radiusWidth, float radiusHeight, boolean isEnd) {
    this.houses = new ArrayList<House>();
    this.center = new PVector(centerX, centerY);
    this.orientation = orientation;
    this.radiusWidth = radiusWidth;
    this.radiusHeight = radiusHeight;
    this.isEnd = isEnd;
    // Road ending fields
    this.leftX = this.center.x - this.radiusWidth;
    this.rightX = this.center.x + this.radiusWidth;
    this.topY = this.center.y - this.radiusHeight;
    this.bottomY = this.center.y + this.radiusHeight;
    // Road lane fields
    if (this.orientation.equals("Horizontal")) {
      this.laneStart = this.center.x - this.radiusWidth + 3 * laneMarkingWidth;
      this.numLanes = int(this.radiusWidth / (2 * laneMarkingWidth));
    } else {
      this.laneStart = this.center.y - this.radiusHeight + 3 * laneMarkingWidth;
      this.numLanes = int(this.radiusHeight / (2 * laneMarkingWidth));
    }
    // House variables
    this.houseLocation = this.leftX;
  }
  
  // Add house method
  void addHouse() {    
    // Add the next houses
    this.houseLocation += houseDistance + houseSize;
    House houseAbove = new House(this, houseLocation, this.center.y - houseDistance);
    House houseBelow = new House(this, houseLocation, this.center.y + this.radiusHeight);
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
    if (detail.equals("High")) {
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
    
    // Draw the road lane markings if the road is horizontal
    if (orientation.equals("Horizontal")) {
      x = this.laneStart;
      y = this.center.y;
      for (int count = 0; count < numLanes; count++) {
        rect(x, y, laneMarkingWidth, 1);
        x += laneSpaceInterval;
      }
    } else { // Draw the road lane markings if the road is vertical
      x = this.center.x;
      y = this.laneStart;
      for (int count = 0; count < numLanes; count++) {
        rect(x, y, 1, laneMarkingWidth);
        y += laneSpaceInterval;
      }
    }
  }
}
