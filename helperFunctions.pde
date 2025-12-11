// Apply any GUI changes to the current simulation and reset
void applyChanges(){
  numTrucks = intChanges[0];
  numWorkers = intChanges[1];
  numHouses = intChanges[2];
  numShelves = intChanges[3];
  packageOutRate = intChanges[4];
  truckMaxLoad = intChanges[5];
  wage = floatChanges[0];
  gasPrice = floatChanges[1];
  
  reset();
}

// Reset the program
void reset(){
  // Expenses and profit
  totalWageExpense = 0;
  totalGasExpense = 0;
  netProfit = 0;
  grossProfit = 0;
   
  // Ratings
  averageRating = 0;
  numRatings = 0;
  
  // Incoming truck comes immediately at the start
  framesSinceOrder = framesBetweenOrders;
  
  // Reset all objects
  Warehouse = new Warehouse(new PVector(  ((width - uiX) / 4) + uiX,  height/2  ),  180,  260);
  Shelves = new ArrayList<Shelf>();
  Workers = new ArrayList<Worker>();
  streets = new ArrayList<Road>();
  allHouses = new ArrayList<House>();
  allPackages = new ArrayList<Package>();
  allOrdered = new ArrayList<Package>();
  trucks = new ArrayList<Truck>();
  
  // Load all objects
  loadShelves();
  loadWorkers();
  loadRoads();
  loadHouses();
  loadTrucks();
}

// Create orders on a time interval
void createOrders() {
  Package item;
  
  // Add packages to truck
  if (incomingTruck.state.equals("Stationary") && !allOrdered.isEmpty()) {
    incomingTruck.packages.set(0, allOrdered);
    allOrdered = new ArrayList<Package>();
    incomingTruck.shipToWarehouse();
  }
  
  // Increment the number of waited time
  framesSinceOrder += simSpeed;
  if (framesSinceOrder < framesBetweenOrders) {
    return;
  }
  
  // Create new packages
  framesSinceOrder = 0;
  for (int count = 0; count < packageOutRate; count++) {
    item = new Package();
    allPackages.add(item);
    allOrdered.add(item);
  }
}
