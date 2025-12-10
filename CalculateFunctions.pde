float  roundAny(float  num, int n)  { //decimal rounding function
  int p = int(  pow(10, n)  );
  return  float(round(num * p))/p;
}

// Computes midpoint between two values 
// Used for road initialization
float midpoint(float point1, float point2) {
  return (point1 + point2) / 2;
}

// Compute the new average given the current average, number of ratings, and new rating
float getNewAverage(float rating) {
  float newAverage = (averageRating  * numRatings + rating) / (numRatings + 1);
  numRatings++;
  return newAverage;
}

// Update the packages for their rating system
void updatePackages() {
  for (Package item : allPackages) {
    item.framesWaited += simSpeed;
  }
}

//  Process movement and delivery for each truck
void updateTrucks() {
  boolean canLeave = true;

  for (Truck truck : trucks) {
    if (truck.state.equals("Leaving Warehouse") && truck.position.x <= Warehouse.pos.x + Warehouse.w / 2 + 30) {
      canLeave = false;
    }
    truck.move();
    truck.deliverPackage();
  }
  if (canLeave && !queue.isEmpty()) {
    queue.get(0).leaveWarehouse();
    queue.remove(0);
  }
  incomingTruck.move();
}

void  updateWorkers()  {
  for (Worker w : Workers) {
    w.update();
  }
}
