// Warehouse Manager project

// Import G4P controls
import g4p_controls.*;

// Number of objects
int  numTrucks = 5;  //the number of shipping trucks
int  numWorkers = 10;  //the number of employees
int numHouses = 6;
int  numShelves = 6;  //the number of shelves in the warehouse
int numStreets = 9;

// Truck variables
int  truckMaxLoad = 100;  //maximum carrying capacity of the truck
float truckSpeed = 0.1;

// Worker variables
float workerSpeed = 0.09;

// House variables
int houseDistance = 12;
int houseSize = 10;

// Package variables
float minPackageWeight = 5;
float maxPackageWeight = 20;
float minPackageCost = 10;
float maxPackageCost = 100;

// Shelf variables
int  shelfCapacity = 5;  //the number of packages a shelf can store

// Order and delivery variables
int framesBetweenOrders = 30 * 60 * 5;
int framesSinceOrder = framesBetweenOrders; // Make a package order at the very start
int deliveryFrames = 270;
int  packageOutRate = 10;  //the number of randomly generated packages requested from the warehouse per framesSinceOrder

// Rating variables
int numRatings = 0;
float averageRating = 0;

// Income and expense variables
float  wage = 20;  //employee wage
float  gasPrice = 1.3;  //price of gas
float  totalWageExpense = 0;
float  totalGasExpense = 0;
float totalExpenses;
float grossProfit = 0;
float netProfit = 0;

//User Interface variables
float  uiX = 200;  //the x coordinate of the right side/end of the UI

// Graphic simulation variables
float  spacer = 10;  //spacer for drawing
float  sW = 70;  //shelf width
float  sH = 10;  //shelf height
int truckHeight = 10;
int truckWidth = 20;
int roadWidth = 20;
int laneWidth = roadWidth / 2;
int laneMarkingWidth = 4;

// Simulation settings (pause, show, etc.)
boolean  isPaused = false;  //if the simulation is paused or not
boolean showTrucks = true;
boolean showEmployees = true;
String detail = "High";
float  curTime = 0;  //the current time value
float  simSpeed = 5;  // delta time

int[] intChanges = {numTrucks, numWorkers, numHouses, numShelves, packageOutRate, truckMaxLoad};
float[] floatChanges = {wage, gasPrice};

// Object variables
Warehouse Warehouse;
ArrayList<Shelf> Shelves = new ArrayList<Shelf>();
ArrayList<Worker>  Workers = new ArrayList<Worker>();
ArrayList<Road> streets = new ArrayList<Road>();
ArrayList<House> allHouses = new ArrayList<House>();
ArrayList<Package> allPackages = new ArrayList<Package>();
ArrayList<Package> allOrdered = new ArrayList<Package>();
ArrayList<Truck> trucks = new ArrayList<Truck>();
ArrayList<Truck> queue = new ArrayList<Truck>();
Truck incomingTruck;
Road warehouseIn, warehouseOut;
Road mergeRoad;

// Start the simulation
void  setup()  {
  size(700, 500);
  createGUI();
  reset();
}

void  draw()  {
  background(0);
  
  //draw everything
  drawUI();
  drawSim();

  //update everything
  updatePackages();
  updateTrucks();
  updateWorkers();
  createOrders();
}
