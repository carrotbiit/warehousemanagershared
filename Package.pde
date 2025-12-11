// Class to represent packages that get shipped
class  Package  {
  // Fields
  House destination;
  color colour;
  float weight;
  float profit; 
  float urgency; // How urgently the customer requires the package
  float framesWaited;
  boolean  claimed; // Whether or not a worker is already headed to the package
  
  // Constructor method
  Package() {
    this.destination = allHouses.get(int(random(allHouses.size())));
    this.colour = color(random(255), random(255), random(255));;
    this.weight = random(maxPackageWeight - minPackageWeight) + minPackageWeight;
    this.profit = roundAny(random(maxPackageCost - minPackageCost) + minPackageCost, 2);
    this.urgency = random(2);
    this.framesWaited = 0;
    this.claimed = false;
    this.destination.ordered.add(this);
  }
  
  // Satisfaction rating between 1 and 5
  float getSatisfaction() {
    return max(5 - this.framesWaited * this.urgency / 50000, 1);
  }
}
