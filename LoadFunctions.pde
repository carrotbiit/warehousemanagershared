void loadRoads() {
  // Variable declarations
  float x;
  float spacing = height / (streetCount + 1);
  float y = spacing;
  
  // Add the auxillary roads
  warehouseIn = new Road(Warehouse.pos.x - Warehouse.w  / 2 + 10, (Warehouse.pos.y - Warehouse.h / 2) / 2, "Vertical", laneWidth, (Warehouse.pos.y - Warehouse.h / 2) / 2, false); // From the top of the screen to the warehouse
  warehouseOut = new Road(Warehouse.pos.x + Warehouse.w / 2 + 25, Warehouse.pos.y, "Horizontal", 25, laneWidth, false); // Extends 50 pixels out from the right of the warehouse
  mergeRoad = new Road(warehouseOut.center.x + warehouseOut.radiusWidth + 10, Warehouse.pos.y, "Vertical", laneWidth, height / 2 - spacing + laneWidth, false); // Meets the warehouseOut and the other streets
  
  // Add streets
  x = midpoint(width, mergeRoad.center.x + mergeRoad.radiusWidth) - roadWidth; // Between the merging road and the right edge of the screen
  for (int count = 0; count < streetCount; count++) {
    streets.add(new Road(x, y, "Horizontal", x - mergeRoad.center.x - mergeRoad.radiusWidth, laneWidth, true));
    y += spacing;
  }
}

// Add houses to each street
void loadHouses() {
  for (Road street : streets) {
    for (int houseCount = 0; houseCount < numHouses; houseCount += 2) {
      street.addHouse();
    }
  }
}

// Add the trucks that leave the warehouse and go to the warehouse
void loadTrucks() {
  float y;
  float x = Warehouse.pos.x + Warehouse.w / 2;
  float spacing = Warehouse.h / (numTrucks + 1);
  for (int count = 0; count < numTrucks; count++) {
    y = Warehouse.pos.y - (Warehouse.h / 2) + spacing * (count + 1);
    trucks.add(new Truck(null, x, y));
  }
  incomingTruck = new Truck(warehouseIn, warehouseIn.center.x - warehouseIn.radiusWidth, warehouseIn.center.y - warehouseIn.radiusHeight - truckHeight);
}

void  loadShelves()  {
  for  (int i = 0; i < numShelves; i++)  {
    float  x  =  Warehouse.pos.x  -  (Warehouse.w/2)  +  spacer  +  (sW/2);
    float  y  =  Warehouse.pos.y  +  (Warehouse.h/2)  -  (spacer *  (numShelves - i))  -  (sH/2)  -  (sH * (numShelves - i - 1));
    Shelves.add(new  Shelf(  new  PVector( x, y)  ));
  }
}

void  loadWorkers()  {
  int  xN, yN;
  //xN = round(numWorkers/2);
  xN = int(sqrt(numWorkers));
  yN = int(numWorkers/xN);
  float x,y;
  
  for  (int i = 0; i < xN; i ++)  {
    for  (int j = 0; (j*xN) + i < numWorkers ; j++)  {
      x = j * 10;
      y = i * 10;
      
      //centering to the warehuse
      x += Warehouse.pos.x - (5 * xN);
      y += Warehouse.pos.y - (2.5 * yN);
      
      //moving them a bit
      y -= (Warehouse.h/3.5);
      
      Workers.add(new  Worker(  new  PVector( x, y )  ));
    }
  }
}
