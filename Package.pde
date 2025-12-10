// Class to represent packages that get shipped
class  Package  {
  // Fields
  House destination;
  color colour;
  String status; // "To warehouse", "In warehouse", "On road", "Shipped"
  float weight;
  float profit; 
  float urgency; // number of frames until house's satisfaction reduces by 0.1
  float framesWaited;
  
  // Constructor method
  Package(House destination, color colour, float weight, float profit) {
    this.destination = destination;
    this.colour = colour;
    this.status = "to warehouse";
    this.weight = weight;
    this.profit = profit;
    this.urgency = 1;
    this.framesWaited = 0;
  }
  
  // Satisfaction rating between 1 and 5
  float getSatisfaction() {
    return max(5 - this.framesWaited * this.urgency / 50000, 1);
  }
}
