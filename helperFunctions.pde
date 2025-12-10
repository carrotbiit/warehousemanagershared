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

void reset(){
  
  totalWageExpense = 0;
  totalGasExpense = 0;
  netProfit = 0;
  grossProfit = 0;
  
  averageRating = 0;
  numRatings = 0;
  
  framesSinceOrder = framesBetweenOrders;
  
  Warehouse = new Warehouse(new PVector(  ((width - uiX) / 4) + uiX,  height/2  ),  180,  260);
  
  Shelves = new ArrayList<Shelf>();
  Workers = new ArrayList<Worker>();
  streets = new ArrayList<Road>();
  allHouses = new ArrayList<House>();
  allPackages = new ArrayList<Package>();
  allOrdered = new ArrayList<Package>();
  trucks = new ArrayList<Truck>();
  
  loadShelves();
  loadWorkers();
  loadRoads();
  loadHouses();
  loadTrucks();
  
  // TESTING
  //Package package1 = new Package(allHouses.get(5), color(0), 1.5, 10);
  //Package package2 = new Package(allHouses.get(9), color(0), 1.5, 20);
  //Package package3 = new Package(allHouses.get(21), color(0), 1.5, 100);
  //allPackages.add(package1);
  //allPackages.add(package2);
  //allPackages.add(package3);
  //trucks.get(3).leaveWarehouse();
  //trucks.get(3).packages.get(1).add(package1);
  //trucks.get(3).packages.get(2).add(package2);
  //trucks.get(3).packages.get(5).add(package3);
}

void createOrders() {
  // Variable declarations
  House house;
  Package item;
  color colour;
  float weight;
  float profit;
  
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
    // Fields for each package
    house = allHouses.get(int(random(allHouses.size())));
    colour = color(random(255), random(255), random(255));
    weight = random(maxPackageWeight - minPackageWeight) + minPackageWeight;
    profit = roundAny(random(maxPackageCost - minPackageCost) + minPackageCost, 2);
    
    // Add the package
    item = new Package(house, colour, weight, profit);
    allPackages.add(item);
    allOrdered.add(item);
    house.ordered.add(item);
  }
}
