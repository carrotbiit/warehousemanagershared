// Draw the side panel UI
void drawUI() {
  noStroke();

  // UI rectangle
  fill(200);
  rectMode(CORNER);
  rect(0, 0, uiX, height);

  // Warehouse Manager title
  fill(0);
  textSize(30);
  textAlign(CENTER);
  text("Warehouse\nManager", uiX/2, 50);

  // Number of trucks and employees
  textSize(20);
  textAlign(LEFT);
  text("# of Trucks:  " + numTrucks, 10, 120);
  text("# of Employees:  " + numWorkers, 10, 140);

  // Expenses
  text("Total Gas Expenses", 10, 180);
  text("Total Labour Expenses", 10, 230);
  text("Total Expenses", 10, 260);
  textAlign(RIGHT);
  text(dollarFormat(totalGasExpense), uiX - 10, 180);
  text(dollarFormat(totalWageExpense), uiX - 10, 230);
  totalExpenses = totalGasExpense + totalWageExpense;
  text(dollarFormat(totalExpenses), uiX - 10, 280);
  
  // Profit
  textAlign(LEFT);
  text("Gross Profit", 10, 330);
  text("Net Profit", 10, 380);
  textAlign(RIGHT);
  text(dollarFormat(grossProfit), uiX - 10, 330);
  netProfit = grossProfit - totalExpenses;
  text(dollarFormat(netProfit), uiX - 10, 380);
  
  // Warehouse rating
  textAlign(CENTER);
  text("Rating: " + nf(roundAny(averageRating, 2), 0, 2) + "/5", uiX / 2, 450);
}


// Draw all of the objects
void  drawSim() {
  noStroke();

  //draw the roads
  for (Road road : streets) {
    road.drawMe();
  }
  warehouseIn.drawMe();
  warehouseOut.drawMe();
  mergeRoad.drawMe();

  //draw the warehouse
  Warehouse.drawMe();

  noStroke();
  
  //draw the workers
  if  (showEmployees)  {
    for  (Worker worker : Workers) {
      worker.drawMe();
    }
  }
  
  noStroke();
  
  //draw the houses
  for (House house : allHouses) {
    house.drawMe();
  }
  
  //draw the trucks
  if  (showTrucks)  {
    for (Truck truck : trucks) {
      truck.drawMe();
      //text(truck.numCurWorkers, truck.position.x - 10, truck.position.y);
    }
    
    incomingTruck.drawMe();
  }

  //draw the shelves
  for (Shelf shelf : Shelves) {
    shelf.drawMe();
  }
  
  tally();
}
