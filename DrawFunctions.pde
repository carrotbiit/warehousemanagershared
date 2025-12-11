// Draw the side panel UI
void drawUI() {
  noStroke();

  // UI rectangle
  rectMode(CORNER);
  fill(170);
  rect(0, 0, uiX, height);
  fill(200);
  rect(3, 3, uiX-6, height-6);
  
  // Textboxes
  fill(220);
  rectMode(CENTER);
  rect(uiX/2,  55, 165, 83, 10);

  // Warehouse Manager title
  fill(45);
  textSize(30);
  textAlign(CENTER);
  text("Warehouse", uiX/2, 50);
  text("Manager", uiX/2 - 16, 80);
  fill(45);
  textSize(10);
  textAlign(CENTER);
  text("v 6.7", uiX/2 + 60, 80);

  // Number of trucks and employees
  textSize(18);
  textAlign(LEFT);
  text("# of Trucks:  " + numTrucks, 10, 130);
  text("# of Employees:  " + numWorkers, 10, 150);

  // Expenses
  text("Total Gas Expenses:", 10, 190);
  text("Total Labour Expenses:", 10, 240);
  text("Total Expenses:", 10, 290);
  textAlign(RIGHT);
  text(dollarFormat(totalGasExpense), uiX - 10, 190);
  text(dollarFormat(totalWageExpense), uiX - 10, 240);
  totalExpenses = totalGasExpense + totalWageExpense;
  text(dollarFormat(totalExpenses), uiX - 10, 290);
  
  // Profit
  textAlign(LEFT);
  text("Gross Profit", 10, 340);
  text("Net Profit", 10, 390);
  textAlign(RIGHT);
  text(dollarFormat(grossProfit), uiX - 10, 340);
  netProfit = grossProfit - totalExpenses;
  text(dollarFormat(netProfit), uiX - 10, 390);
  
  // Warehouse rating
  textAlign(CENTER);
  //text("\u2B50",uiX/2,height/2);
  text("Rating: " + nf(roundAny(averageRating, 2), 0, 2) + "/5", uiX / 2, 480);
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
  ruler();
}

//draw star
void  drawStar()  {
  
}
