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
  text("# of Trucks:  " + numTrucks, 10, 127);
  text("# of Employees:  " + numWorkers, 10, 147);

  // Expenses
  text("Total Gas Expenses:", 10, 187);
  text("Total Labour Expenses:", 10, 237);
  text("Total Expenses:", 10, 287);
  textAlign(RIGHT);
  text(dollarFormat(totalGasExpense), uiX - 10, 190);
  text(dollarFormat(totalWageExpense), uiX - 10, 240);
  totalExpenses = totalGasExpense + totalWageExpense;
  text(dollarFormat(totalExpenses), uiX - 10, 290);
  
  // Profit
  textAlign(LEFT);
  text("Gross Profit", 10, 337);
  text("Net Profit", 10, 387);
  textAlign(RIGHT);
  text(dollarFormat(grossProfit), uiX - 10, 340);
  netProfit = grossProfit - totalExpenses;
  text(dollarFormat(netProfit), uiX - 10, 392);
  text(dollarFormat(netProfit), uiX - 10, 392);
  text(dollarFormat(netProfit), uiX - 9, 390);
  text(dollarFormat(netProfit), uiX - 8, 390);
  if  (netProfit > 0)  { //setting fill color for profit, red if negative, green if position, grey if break even
    fill(0,230,0);
  }
  else  if  (netProfit < 0)  {
    fill(230,0,0);
  }
  else  {
    fill(45);
  }
  text(dollarFormat(netProfit), uiX - 10, 390);
  text(dollarFormat(netProfit), uiX - 11, 390);
  
  // Warehouse rating
  fill(45);
  textAlign(CENTER);
  text("Rating: " + nf(roundAny(averageRating, 2), 0, 2) + "/5", uiX / 2, 480);
  for  (int i = 0; i < 5; i++)  {
    drawStar(  new PVector(uiX/2 + ((i-2) * 36),  440),  i, 14);
  }
  
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
void  drawStar(PVector  pos,  float  n,  float multiplier)  {
  
  color  dark = color(230, 180, 0);
  color  light = color(255, 214, 10);
  
  //points for the star
  PVector  p1 = new PVector(0,  -multiplier);
  PVector  p2 = new PVector(0.224398 * multiplier,  0.308858 * -multiplier);
  PVector  p3 = new PVector(0.951057 * multiplier,  0.308858 * -multiplier);
  PVector  p4 = new PVector(0.363084 * multiplier,  0.117973 * multiplier);
  PVector  p5 = new PVector(0.587785 * multiplier,  0.809017 * multiplier);
  PVector  p6 = new PVector(0,  0.381769 * multiplier);
  PVector  p7 = new PVector(0.587785 * -multiplier,  0.809017 * multiplier);
  PVector  p8 = new PVector(0.363084 * -multiplier,  0.117973 * multiplier);
  PVector  p9 = new PVector(0.951057 * -multiplier,  0.308858 * -multiplier);
  PVector  p10 = new PVector(0.224398 * -multiplier,  0.308858 * -multiplier);
  
  //Outline
  stroke(dark);
  strokeWeight(5);
  triangle(p1.x  +  pos.x, p1.y  +  pos.y, p2.x  +  pos.x, p2.y  +  pos.y, p8.x  +  pos.x, p8.y  +  pos.y);
  triangle(p10.x  +  pos.x, p10.y  +  pos.y, p1.x  +  pos.x, p1.y  +  pos.y, p4.x  +  pos.x, p4.y  +  pos.y);
  triangle(p6.x  +  pos.x, p6.y  +  pos.y, p10.x  +  pos.x, p10.y  +  pos.y, p9.x  +  pos.x, p9.y  +  pos.y);
  triangle(p6.x  +  pos.x, p6.y  +  pos.y, p2.x  +  pos.x, p2.y  +  pos.y, p3.x  +  pos.x, p3.y  +  pos.y);
  triangle(p6.x  +  pos.x, p6.y  +  pos.y, p7.x  +  pos.x, p7.y  +  pos.y, p8.x  +  pos.x, p8.y  +  pos.y);
  triangle(p6.x  +  pos.x, p6.y  +  pos.y, p5.x  +  pos.x, p5.y  +  pos.y, p4.x  +  pos.x, p4.y  +  pos.y);
  
  noStroke();
  //Left half
  if  (averageRating >= n + 0.5)  {
    fill(light);
  }
  else  {
    fill(dark);
  }
  triangle(p10.x  +  pos.x, p10.y  +  pos.y, p9.x  +  pos.x, p9.y  +  pos.y, p6.x  +  pos.x, p6.y  +  pos.y);
  triangle(p1.x  +  pos.x, p1.y  +  pos.y, p6.x  +  pos.x, p6.y  +  pos.y, p7.x  +  pos.x, p7.y  +  pos.y);
  
  //Right half
  if  (roundAny(averageRating, 1) >= n + 1)  {
    fill(light);
  }
  else  {
    fill(dark);
  }
  triangle(p2.x  +  pos.x, p2.y  +  pos.y, p3.x  +  pos.x, p3.y  +  pos.y, p6.x  +  pos.x, p6.y  +  pos.y);
  triangle(p1.x  +  pos.x, p1.y  +  pos.y, p5.x  +  pos.x, p5.y  +  pos.y, p6.x  +  pos.x, p6.y  +  pos.y);
  
}
