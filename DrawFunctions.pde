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
  text("Warehouse\nManager", uiX/2, 30);

  // Number of trucks and employees
  textSize(20);
  textAlign(LEFT);
  text("# of Trucks:  " + numTrucks, 10, 100);
  text("# of Employees:  " + numWorkers, 10, 120);

  // Expenses
  text("Total Gas Expenses", 10, 160);
  text("Total Labour Expenses", 10, 210);
  text("Total Expenses", 10, 260);
  textAlign(RIGHT);
  text("\n$ " + nfc(roundAny( totalGasExpense, 2), 2), uiX - 10, 160);
  text("\n$ " + nfc(roundAny( totalWageExpense, 2), 2), uiX - 10, 210);
  text("\n$ " + nfc(roundAny( totalGasExpense + totalWageExpense, 2), 2), uiX - 10, 260);
  
  // Profit
  textAlign(LEFT);
  text("Gross Profit", 10, 310);
  text("Net Profit", 10, 360);
  textAlign(RIGHT);
  text("\n$ " + nfc(roundAny( grossProfit, 2), 2), uiX - 10, 310);
  text("\n$ " + nfc(roundAny( grossProfit - totalGasExpense - totalWageExpense, 2), 2), uiX - 10, 360);
  
  // Warehouse rating
  textAlign(CENTER);
  text("Rating: " + nf(roundAny(averageRating, 2), 0, 2) + "/5", uiX / 2, 410);


  //println(curTime);
}



void  drawSim() {
  println();
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

  //draw the houses
  for (House house : allHouses) {
    house.drawMe();
  }
  
  //println();
  //draw the trucks
  if  (showTrucks)  {
    for (Truck truck : trucks) {
      truck.drawMe();
      println(truck.state, truck.numCurWorkers);
    }
    
    incomingTruck.drawMe();
  }

  //draw the shelves
  for (Shelf shelf : Shelves) {
    shelf.drawMe();
  }

  //draw the workers
  if  (showEmployees)  {
    for  (Worker worker : Workers) {
      worker.drawMe();
      //println(worker.state);
      //println("\t");
      //print(  incomingTruck.packages.get(0).indexOf(worker.targPack)  );
    }
  }

  //draw the packages
  
  // draw the delivery text
  println( "num workers " , incomingTruck.numCurWorkers  );
  println( "num packages " , incomingTruck.packages.get(0).size());
  println( "incoming state ", incomingTruck.state);
}
