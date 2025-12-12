class Truck {
  // Fields
  ArrayList<ArrayList<Package>> packages; // Packages are grouped by streets
  Road roadOn; // The road that the truck is on/heading towards
  PVector position, velocity;
  PVector restPosition; // Resting position at the warehouse
  // Incoming trucks --> "Shipping to Warehouse", "Unloading, "Done Unloading" 
  // Other trucks --> "Stationary", "Waiting to Leave", "Leaving Warehouse", "Going to Street", "At Street", "Delivering", "Leaving Street", "Returning from Street", "Returning from Intersection"
  String state; 
  float load;
  float maxCapacity;
  int streetIdx; // Current street of the struck
  int  numCurWorkers;  //the number of workers working on a truck
  int framesSinceDelivery; // The number of frames elapsed since the last delivery
  int totalPackageCount; // Avoids recalculating total packages in the packages ArrayList
  int nextStreetIdx;  // Prevent duplicate calculation by pre-calculating the next street to deliver to

  // Constructor method
  Truck(Road roadOn, float x, float y) {
    this.packages = new ArrayList<ArrayList<Package>>();
    this.roadOn = roadOn;
    this.position = new PVector(x, y);
    this.velocity = new PVector(0, 0);
    this.restPosition = this.position.copy();
    this.state = "Stationary";
    this.load = 0;
    this.maxCapacity = truckMaxLoad;
    this.framesSinceDelivery = 0;
    for (int idx = 0; idx < numStreets; idx++) {
      packages.add(new ArrayList<Package>());
    }
    this.streetIdx = -1;
    this.numCurWorkers = 0;
    this.framesSinceDelivery = 0;
    this.totalPackageCount = 0;
    this.nextStreetIdx = -1;
  }

  // Draw method
  void drawMe() {
    rectMode(CORNER);
    // Blue for delivering trucks and green for moving trucks
    if (this.state.equals("Delivering") || this.state.equals("Unloading")) {
      fill(0, 0, 200);   
    } else {
      fill(0, 200, 0);
    }
    // Orient the trucks upwards or horizontally based on velocity
    if (abs(this.velocity.x) >= abs(this.velocity.y)) {
      rect(this.position.x, this.position.y, truckWidth, truckHeight);
    } else {
      rect(this.position.x, this.position.y, truckHeight, truckWidth);
    }
    // Draw the number of packages
    if  (this.state.equals("Stationary") && !detail.equals("Low"))  {
      drawPackageCount();
    }
  }

  // Draw the number of packages in the truck
  void drawPackageCount() {
    
    float  colourVal = lerp(255,0,  this.totalPackageCount/(this.maxCapacity/(minPackageWeight + (maxPackageWeight-minPackageWeight)/2))  );
    fill(colourVal, colourVal, 255);
    textAlign(CENTER);
    textSize(20);
    text(this.totalPackageCount , this.position.x + 10, this.position.y);
  }
 
  // Method to move to the next houses
  void move() {
    // Truck is not supposed to move
    if (this.state.equals("Stationary") || this.state.equals("Waiting to Leave")) { //|| this.willCollide()) {
      return;
    }
    
    // Incoming truck has finished unloading its items
    else if (this.state.equals("Unloading") && this.packages.get(0).isEmpty()) {
      this.state = "Done Unloading";
      this.position = new PVector(this.roadOn.center.x, this.roadOn.bottomY - truckWidth);
      this.velocity = new PVector(0, -truckSpeed);
      return;
    }
    
    // Truck is delivering package to house
    else if (this.state.equals("Delivering")) {
      this.framesSinceDelivery += simSpeed;
      if (this.framesSinceDelivery >= deliveryFrames) {
        this.state = "At Street";
      }
      return;
    }
    
    // Process movement and gas expense
    this.position.add(PVector.mult(this.velocity, simSpeed));
    totalGasExpense += simSpeed * gasPriceDT;
   
    // Incoming truck has reached the warehouse
    if (this.state.equals("Shipping to Warehouse") && isNear(this.position.y, warehouseIn.bottomY - truckWidth)) {
      this.state = "Unloading";
      this.position = new PVector(warehouseIn.leftX, warehouseIn.bottomY - truckHeight);
      this.velocity = new PVector(0, 0);
    }
    
    // Incoming truck is done shipping
    else if (this.state.equals("Done Unloading") && this.position.y <= -truckWidth) {
      this.state = "Stationary";
      this.velocity = new PVector(0, 0);
    }
    
    // Truck has left the warehouse
    else if (this.state.equals("Leaving Warehouse")) {
      // Move down
      if (isNear(this.position.x + truckWidth, mergeRoad.center.x) && this.position.y < streets.get(this.nextStreetIdx).center.y) {
        this.state = "Going to Street";
        this.streetIdx = this.nextStreetIdx;
        this.roadOn = streets.get(streetIdx);
        this.position = new PVector(mergeRoad.leftX, mergeRoad.center.y);
        this.velocity = new PVector(0, truckSpeed);
      } 
      // Move up
      else if (isNear(this.position.x + truckWidth, mergeRoad.rightX) && this.position.y > streets.get(this.nextStreetIdx).center.y) {
        this.state = "Going to Street";
        this.streetIdx = this.nextStreetIdx;
        this.roadOn = streets.get(streetIdx);
        this.position = new PVector(mergeRoad.center.x, warehouseOut.bottomY - truckWidth);
        this.velocity = new PVector(0, -truckSpeed);
      }
      // Move forwards
      else if (this.position.y == streets.get(this.nextStreetIdx).center.y) {
        this.streetIdx = this.nextStreetIdx;
        this.state = "At Street";
      }
    }
    
    // Truck is at the designated street
    else if (this.state.equals("Going to Street") && ((this.velocity.y < 0 && isNear(this.position.y, this.roadOn.center.y)) || (this.velocity.y > 0 && isNear(this.position.y + truckWidth, this.roadOn.bottomY)))) {
      this.state = "At Street";
      this.position = new PVector(this.position.x, this.roadOn.center.y);
      this.velocity = new PVector(truckSpeed, 0);
    } 
    // Truck finished delivering packages at its street
    else if (this.state.equals("At Street") && this.packages.get(this.streetIdx).isEmpty()) {
      this.state = "Leaving Street";
      this.nextStreetIdx = locateNextStreet();
      this.position = new PVector(this.position.x, this.roadOn.topY);
      this.velocity = new PVector(-truckSpeed, 0);
    } 
    
    // Truck has left its street
    else if (this.state.equals("Leaving Street")) {
      // Move down to warehouse (no more packages to deliver)
      if (nextStreetIdx == -1 && this.position.y < warehouseOut.center.y && isNear(this.position.x, mergeRoad.leftX)) {
        this.state = "Returning from Street";
        this.streetIdx = -1;
        this.roadOn = warehouseOut;
        this.position = new PVector(mergeRoad.leftX, this.position.y);
        this.velocity = new PVector(0, truckSpeed);
      } 
      // Move up to warehouse (no more packages to deliver)
      else if (this.nextStreetIdx == -1 && this.position.y > warehouseOut.center.y && isNear(this.position.x, mergeRoad.center.x)) {
        this.state = "Returning from Street";
        this.streetIdx = -1;
        this.roadOn = warehouseOut;
        this.position = new PVector(mergeRoad.center.x, this.position.y - truckWidth + truckHeight);
        this.velocity = new PVector(0, -truckSpeed);
      }
      else if (isNear(this.position.x, mergeRoad.leftX)) {
        this.state = "Going to Street";
        this.streetIdx = this.nextStreetIdx;
        this.roadOn = streets.get(streetIdx);
        this.position = new PVector(mergeRoad.leftX, this.position.y);
        this.velocity = new PVector(0, truckSpeed);
      }
    }
    
    // Truck has returned to the warehouse street
    else if (this.state.equals("Returning from Street")) {
      // Came from bottom
      if (this.velocity.y < 0 && isNear(this.position.y, warehouseOut.topY)) {
        this.state = "Returning from Intersection";
        this.position = new PVector(mergeRoad.rightX - truckWidth, warehouseOut.topY);
        this.velocity = new PVector(-truckSpeed, 0);
      }
      // Came from top
      else if (this.velocity.y > 0 && isNear(this.position.y, warehouseOut.center.y - truckWidth)) {
        this.state = "Returning from Intersection";
        this.position = new PVector(mergeRoad.center.x - truckWidth, warehouseOut.topY);
        this.velocity = new PVector(-truckSpeed, 0);
      }
    }
    
    // Truck has returned to warehouse
    else if (this.state.equals("Returning from Intersection") && isNear(this.position.x, warehouseOut.leftX)) {
      this.state = "Stationary";
      this.roadOn = null;
      this.position = restPosition.copy();
      this.load = 0;
      this.numCurWorkers = 0;
    }
  }
   
  // Method to find if the truck is near an x or y position
  boolean isNear(float truck, float road) {
    return truck - truckSpeed * simSpeed < road && road < truck + truckSpeed * simSpeed;
  }
  
  // Method to find the next closest street
  int locateNextStreet() {
    // Find the first street with packages
    for (int idx = 0; idx < numStreets; idx++) {
      if (!this.packages.get(idx).isEmpty()) {
        return idx;
      }
    }
    return -1;
  }

  // Method to check if another package can fit
  boolean canFit(Package item) {
    return this.load + item.weight <= this.maxCapacity;
  }

  // Ship to warehouse
  void shipToWarehouse() {
    this.state = "Shipping to Warehouse";
    this.position = new PVector(this.roadOn.center.x - this.roadOn.radiusWidth, this.roadOn.center.y - this.roadOn.radiusHeight);
    this.velocity = new PVector(0, truckSpeed);
  }

  // Method to leave the warehouse
  void leaveWarehouse() {
    this.roadOn = warehouseOut;
    this.state = "Leaving Warehouse";
    this.nextStreetIdx = locateNextStreet();
    this.position = new PVector(this.roadOn.center.x - this.roadOn.radiusWidth, this.roadOn.center.y);
    this.velocity = new PVector(truckSpeed, 0);
  }
  
   // Load package method
  void loadPackage(Package item) {
     Road street = item.destination.street;
     int idx = streets.indexOf(street);
     this.packages.get(idx).add(item);
     this.totalPackageCount++;
     //this.load += item.weight;
   }
   
  // Deliver package method
  void deliverPackage() {
    if (this.streetIdx == -1) {
      return;
    }
    Package item;
    ArrayList<Package> streetPackages = this.packages.get(streetIdx);
    // Check if the packages on the street are near the truck
    for (int idx = 0; idx < streetPackages.size(); idx++) {
      item = streetPackages.get(idx);
      if (isNear(this.position.x + truckWidth / 2, item.destination.position.x + houseSize / 2)) {
        this.state = "Delivering";
        this.framesSinceDelivery = 0;
        streetPackages.remove(idx);
        allPackages.remove(item);
        averageRating = getNewAverage(item.getSatisfaction());
        grossProfit += item.profit;
        this.load -= item.weight;
        this.totalPackageCount--; //test
        break;
      }
    }
  }
}
