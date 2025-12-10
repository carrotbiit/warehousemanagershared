class Truck {
  // Fields
  ArrayList<ArrayList<Package>> packages; // Packages are grouped by streets
  Road roadOn;
  PVector position, velocity;
  PVector restPosition;
  // Incoming trucks --> "Shipping to Warehouse", "Unloading, "Done Unloading" 
  // Other trucks --> "Stationary", "Waiting to Leave", "Leaving Warehouse", "Going to Street", "At Street", "Delivering", "Leaving Street", "Returning from Street", "Returning from Intersection"
  String state; 
  float load;
  float maxCapacity;
  int streetIdx; // Current street of the struck
  int  numCurWorkers;  //the number of workers working on a truck
  int framesSinceDelivery;

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
    for (int idx = 0; idx < streetCount; idx++) {
      packages.add(new ArrayList<Package>());
    }
    streetIdx = -1;
    numCurWorkers = 0;
  }
  
  // Method to check if another package can fit
  boolean canFit(Package item) {
    return this.load + item.weight <= this.maxCapacity;
  }

  // Method to leave the warehouse
  void leaveWarehouse() {
    this.roadOn = warehouseOut;
    this.state = "Leaving Warehouse";
    this.position = new PVector(this.roadOn.center.x - this.roadOn.radiusWidth, this.roadOn.center.y);
    this.velocity = new PVector(truckSpeed, 0);
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
      this.position = new PVector(this.roadOn.center.x, this.roadOn.center.y + this.roadOn.radiusHeight - truckWidth);
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
    totalGasExpense += this.velocity.mag() * simSpeed * gasPrice / 200;
   
    // Incoming truck has reached the warehouse
    if (this.state.equals("Shipping to Warehouse") && isNear(this.position.y, this.roadOn.center.y + this.roadOn.radiusHeight - 10)) {
      this.state = "Unloading";
      this.velocity = new PVector(0, 0);
    }
    
    // Incoming truck is done shipping
    else if (this.state.equals("Done Unloading") && this.position.y <= -truckWidth) {
      this.state = "Stationary";
      this.velocity = new PVector(0, 0);
    }
    
    // Truck has left the warehouse
    else if (this.state.equals("Leaving Warehouse") && isNear(this.position.x, this.roadOn.center.x + this.roadOn.radiusWidth)) {
      this.state = "Going to Street";
      this.streetIdx = locateNextStreet();
      this.roadOn = streets.get(streetIdx);
      if (this.position.y < this.roadOn.center.y) {
        this.position = new PVector(mergeRoad.center.x - mergeRoad.radiusWidth, mergeRoad.center.y - warehouseOut.radiusHeight);
        this.velocity = new PVector(0, truckSpeed);
      } else {
        this.velocity = new PVector(0, -truckSpeed);
        this.position = new PVector(mergeRoad.center.x, mergeRoad.center.y + warehouseOut.radiusHeight);
      }
    }
    
    // Truck is atits designated street
    else if (this.state.equals("Going to Street") && isNear(this.position.y, this.roadOn.center.y)) {
      this.state = "At Street";
      this.velocity = new PVector(truckSpeed, 0);
    } 
    // Truck finished delivering packages at its street
    else if (this.state.equals("At Street") && this.packages.get(this.streetIdx).isEmpty()) {
      this.state = "Leaving Street";
      this.position = new PVector(this.position.x, this.roadOn.center.y - this.roadOn.radiusHeight);
      this.velocity = new PVector(-truckSpeed, 0);
    } 
    
    // Truck has left its street
    else if (this.state.equals("Leaving Street") && isNear(this.position.x, mergeRoad.center.x)) {
      this.streetIdx = locateNextStreet();
      if (this.streetIdx == -1) {
        this.state = "Returning from Street";
        this.roadOn = warehouseOut;
        if (this.position.y < this.roadOn.center.y) {
          this.position = new PVector(mergeRoad.center.x - mergeRoad.radiusWidth, this.position.y);
          this.velocity = new PVector(0, truckSpeed);
        } else {
          this.position = new PVector(mergeRoad.center.x, this.position.y);
          this.velocity = new PVector(0, -truckSpeed);
        }
      }
      else {
        this.state = "Going to Street";
        this.roadOn = streets.get(streetIdx);
        this.position = new PVector(mergeRoad.center.x - mergeRoad.radiusWidth, this.position.y);
        this.velocity = new PVector(0, truckSpeed);
      }
    }
    
    // Truck has returned to the warehouse street
    else if (this.state.equals("Returning from Street") && isNear(this.position.y, this.roadOn.center.y)) {
      this.state = "Returning from Intersection";
      this.position = new PVector(this.position.x, this.roadOn.center.y - this.roadOn.radiusHeight);
      this.velocity = new PVector(-truckSpeed, 0);
    }
    
    // Truck has returned to warehouse
    else if (this.state.equals("Returning from Intersection") && isNear(this.position.x, this.roadOn.center.x - this.roadOn.radiusWidth)) {
      this.state = "Stationary";
      this.roadOn = null;
      this.position = restPosition.copy();
    }
   }
   
  // Method to find if the truck is near an x or y position
  boolean isNear(float truck, float road) {
    return truck - truckSpeed * simSpeed < road && road < truck + truckSpeed * simSpeed;
  }
  
  // Method to find the next closest street
  int locateNextStreet() {
    for (int idx = 0; idx < streetCount; idx++) {
      if (!this.packages.get(idx).isEmpty()) {
        return idx;
      }
    }
    return -1;
  }
  
  // Deliver package method
  void deliverPackage() {
    if (this.streetIdx == -1) {
      return;
    }
    Package item;
    ArrayList<Package> streetPackages = this.packages.get(streetIdx);
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
        break;
      }
    }
  }
  
  // Check if truck would collide
  boolean willCollide() {
    for (Truck truck : trucks) {
      if (truck == this || truck.state.equals("Stationary")) {
        continue;
      }
      else if (isNear(this.position.x, truck.position.x + truck.velocity.x) && this.position.y == truck.position.y) {
        return true;
      }
      else if (this.position.x == truck.position.x && isNear(this.position.y, truck.position.y + truck.velocity.y)) {
        return true;
      }
    }
    return false;
  }
  
  // Draw method
  void drawMe() {
    rectMode(CORNER);
    if (this.state.equals("Delivering") || this.state.equals("Unloading")) {
      fill(0, 0, 200);   
    } else {
      fill(0, 200, 0);
    }
    if (abs(this.velocity.x) >= abs(this.velocity.y)) {
      rect(this.position.x, this.position.y, truckWidth, truckHeight);
    } else {
      rect(this.position.x, this.position.y, truckHeight, truckWidth);
    }
    
    if  (this.state.equals("Stationary") && !detail.equals("low"))  {
      drawPackageCount();
    }
  }
  
  // Draw the number of packages in the truck
  void drawPackageCount() {
    fill(255);
    textAlign(CENTER);
    textSize(20);
    int count = 0;
    for  (  int i = 0; i < this.packages.size(); i++  )  {
      count += this.packages.get(i).size();
    }
    text(count , this.position.x + 10, this.position.y);
  }
  
  // Ship to warehouse
  void shipToWarehouse() {
    this.state = "Shipping to Warehouse";
    this.position = new PVector(this.roadOn.center.x - this.roadOn.radiusWidth, this.roadOn.center.y - this.roadOn.radiusHeight);
    this.velocity = new PVector(0, truckSpeed);
  }

   // Load package method
   void loadPackage(Package item) {
     Road street = item.destination.street;
     int idx = streets.indexOf(street);
     this.packages.get(idx).add(item);
     this.load += item.weight;
   }
}
