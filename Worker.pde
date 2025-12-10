class  Worker  {
  //fields
  PVector  pos;  //position of the worker
  PVector  vel;  //velocity of the worker
  PVector  target;  //where the worker is going
  String  state;  //what they are currently doing (Unloading, Loading, Storring, Retrieving, Waiting, )
  Package  holding;  //the package the worker is moving
  Package  targPack;  //the package the worker is SEARCHING FOR when retrieving
  int  targShelf;  //the index of the shelf we are targeting when unloading etc.
  Truck  targTruck;
  
  //constructor
  Worker(PVector p)  {
    this.pos = p.copy();
    this.vel = new PVector(0,0);
    this.target = p.copy();
    this.state = "Waiting";
    this.holding = null;
    this.targPack = null;
    this.targShelf = 0;
    this.targTruck = null;
    
  }
  
  
  //methods
  void  drawMe()  {
    
    noStroke();
    
    if  (  this.state.equals("Waiting")  )  {
      fill(255,0,0);
    }
    else  {
      fill(0,255,0);
    }
    circle(this.pos.x, this.pos.y, 8);
    
    if  (this.holding != null)  {
      fill(holding.colour);
      square(this.pos.x, this.pos.y + 6, 6);
    }
    
  }
  
  //void  update()  {
    
  //  totalWageExpense += simSpeed * wage / 20000;
    
  //  //general algo idea
  //  //if we are Waiting
  //    //check if the incoming truck needs to be unloaded and its num cur workers is low
  //      //if it needs workers work on it and set its target as such
  //      //else it doesnt need workers
  //        //check if the outgoing trucks need workers
  //          //if they do, they find the packages need and begin loading, or wait if there are none
  //          //if they dont, just wait
  //  //else
  //    //continue doing whatever you were doing (move)
    
  //  if  (this.state.equals("Waiting"))  {
      
      
      
  //    //Work on outgoing
  //    //else  {
  //    for  (Truck t: trucks)  {  //Loop through trucks
  //      if  (  t.state.equals("Stationary")  &&  t.numCurWorkers < 2)  {
  //        for  (Shelf s: Shelves)  {  //Loop through shelves
  //          for  (  int i = 0 ; i < s.stored.size() ; i++  )  {  //Loop through packages
              
  //            if  (  t.canFit(  s.stored.get(i)  )  &&  !s.claimed.get(i)  )  {  //Valid package, weight & not claimed
  //              this.targPack = s.stored.get(i);
                
  //              this.targetShelf(s, i);
  //              this.setVelTarget();
  //              this.state = "Retrieving";  //set state
                
  //              this.targTruck = t;
  //              //targTruck.loadPackage(this.targPack);

  //              //println(s.claimed.get(i));
                
  //              t.numCurWorkers += 1;  //update how many workers are working on the trucks
                
  //              break;  //Stop searching
  //            }
              
  //            // The truck will leave if it cannot hold any more packages
  //            else if (!t.canFit(s.stored.get(i)) && !t.state.equals("Waiting To Leave") && !queue.contains(t)) {
  //             queue.add(t);
  //             t.state = "Waiting to Leave";
  //             // this.targInd = 0;
  //             this.targTruck = null;
  //             //break;
  //            }
         
              
  //          }
            
  //          if  (  this.state.equals("Retrieving")  )  {
  //            break;  //Stop searching
  //          }
            
  //        }
  //      }
        
  //      if  (  this.state.equals("Retrieving")  )  {
  //            break;  //Stop searching
  //          }
        
  //    }
      
  //    //println(this.state);
      
  //    //if  (this.targTruck != null)  {
  //    if  (  this.state.equals("Waiting")  )  {
  //      //Work on incoming
  //      if  (  incomingTruck.state.equals("Unloading")  &&  incomingTruck.numCurWorkers < 5  &&  incomingTruck.numCurWorkers < incomingTruck.packages.get(0).size()  )  {
  //        this.targetIncoming();
  //        this.setVelTarget();
  //        this.state = "Unloading";  //set state
  //        incomingTruck.numCurWorkers += 1;  //update how many workers are working on the trucks
          
  //        this.targTruck = null;
          
  //      }
  //    }
      

  //  }  //end of waiting
    
  //  else  {//is working
      
  //    //red circle target TESTER
  //    //if  (this.pos.x != this.target.x)  {
  //    //  fill(255,0,0);
  //    //  circle(this.target.x, this.target.y, 4);
  //    //}
      
      
      
  //    //move closer to target if if the next frame we dont reach it
  //    if  (dist(this.pos.x, this.pos.y, this.target.x, this.target.y) > this.vel.copy().mult(simSpeed).mag())  {
  //      this.pos.add(this.vel.copy().mult(simSpeed));
  //    }
      
  //    else  {  //if we are close enough to target set our position to it
  //      this.pos = this.target.copy();
        
  //      //Unloading
  //      if  (  this.state.equals("Unloading")  )  {
  //        this.holding = incomingTruck.packages.get(0).get(0);
  //        incomingTruck.packages.get(0).remove(0);
  //        incomingTruck.numCurWorkers -= 1;
  //        this.state = "Storring";
          
  //        this.targetShelf();
  //        this.setVelTarget();
          
  //      }
        
  //      //Store in shelf
  //      else  if  (  this.state.equals("Storring")  )  {
  //        if  (  Shelves.get(targInd).stored.size()  <  5  )  {
  //          Shelves.get(targInd).stored.add(this.holding);
  //          Shelves.get(targInd).claimed.add(false);
  //          this.holding = null;
  //          this.state = "Waiting";
            
  //          //println(Shelves.get(targInd).stored.size());
  //        }
  //        else  {
  //          this.targetShelf();
  //          this.setVelTarget();
  //          //this.state = "Unloading";
  //        }
  //      }
        
  //      //Loading
  //      else  if  (  this.state.equals("Loading")  )  {
  //        targTruck.loadPackage(this.holding);
  //        this.holding = null;
  //        targTruck.numCurWorkers -= 1;
  //        this.state = "Waiting";
          
  //        //targTruck.leaveWarehouse();
          
  //      }
        
  //      //Retrieving
  //      else  if  (  this.state.equals("Retrieving")  )  {
  //        this.holding = this.targPack;
  //        Shelves.get(targInd).claimed.remove(  Shelves.get(targInd).stored.indexOf(this.holding)  );
  //        Shelves.get(targInd).stored.remove(  this.holding  );
          
  //        this.state = "Loading";
          
  //        //was in loading
  //        targetOutgoing(targTruck);
  //        this.setVelTarget();
          
  //      }
        
  //    }
      
      
      
  //  }
  //}
  
  //look if an outgoing truck can hold a package on the incoming truck           check
  //look if an outgoing truck can hold a package that is on the shelves          check
  //
  //look if the shelves can hold if there is a package from the incoming truck
  
  void  update()  {  //General update function
    
    totalWageExpense += simSpeed * wage / 20000;
    
    //do not combine the below into one if statement, this.searchOutgoing can alter this.state
    if  (  this.state.equals("Waiting")  )  {  //Look for an outgoing truck to load
      this.searchOutgoing();
    }
    if  (  this.state.equals("Waiting")  )  {  //We couldn't find any outgoing trucks to load
      //println("searching incoming", frameCount);
      this.searchIncoming();
      //println(  this.state.equals("Waiting")  );
    }
    
    
    
    else  {  //Worker is doing some job, not waiting
    
      //move closer to target if if the next frame we dont reach it
      if  (dist(this.pos.x, this.pos.y, this.target.x, this.target.y) > this.vel.copy().mult(simSpeed).mag())  {
        this.pos.add(this.vel.copy().mult(simSpeed));
      }
      
      else  {  //We have reached our target
        this.pos = this.target.copy();
        
        if  (  this.state.equals("Unloading")  )  {
          //This line is stupidly long but I need it this way to set holding to a COPY of targPack, NOT a reference
          this.holding = incomingTruck.packages.get(0).get(  incomingTruck.packages.get(0).indexOf(  this.targPack  )  );
          incomingTruck.packages.get(0).remove(  incomingTruck.packages.get(0).indexOf(  this.holding  )  );
          incomingTruck.numCurWorkers -= 1;
          
          //distinction
          if  (  this.targTruck != null)  {  //IMMEDIATELY LOADING FROM INCOMING TO OUTGOING  
            this.state = "Loading";
            this.targetOutgoing(this.targTruck);
            this.setVelTarget();
          }
          else  {  //STORRING PACKAGES IN SHELVES FROM INCOMING
            this.state = "Storring";
            this.targetShelf(this.targShelf);
            this.setVelTarget();
          }
          
        }  //end of unloading
        
        //Store in shelf
        else  if  (  this.state.equals("Storring")  )  {
          //println(  Shelves.get(targShelf).capacity  );
          this.holding.claimed = false;
          Shelves.get(targShelf).stored.add(  this.holding  );
          //Shelves.get(targShelf).capacity -= 1;
          this.holding = null;
          this.state = "Waiting";
        }  //end of storring
        
        //Loading
        else  if  (  this.state.equals("Loading")  )  {
          this.targTruck.loadPackage(  this.holding  );
          this.holding = null;
          this.targTruck.numCurWorkers -= 1;
          this.state = "Waiting"; 
        }  //end of loading
        
        //Retrieving
        else  if  (  this.state.equals("Retrieving")  )  {
          this.holding = Shelves.get(targShelf).stored.get(  Shelves.get(targShelf).stored.indexOf(targPack)  );
          Shelves.get(targShelf).stored.remove(  this.holding  );
          this.holding.claimed = true; //false? i dont think it matters
          
          //Shelves.get(targInd).claimed.remove(  Shelves.get(targInd).stored.indexOf(this.holding)  );
          //Shelves.get(targInd).stored.remove(  this.holding  );
          
          this.state = "Loading";
          
          this.targetOutgoing(this.targTruck);
          this.setVelTarget();
        }  //end of Retrieving
      
      
      }  //End
    
    }
    
  }
  
  
  
  //Looking for work on an outgoing Truck
  void  searchOutgoing()  {
    
    for  (Truck t: trucks)  {
      if  (  t.state.equals("Stationary")  )  {
        
        //check incoming                                                           //careful ||||||
        if  (  incomingTruck.state.equals("Unloading")  &&  incomingTruck.numCurWorkers < 5  )  {//&&  incomingTruck.numCurWorkers < incomingTruck.packages.get(0).size())  {
          //loop through packages on the incoming
          for  (int i = 0; i < incomingTruck.packages.get(0).size(); i++)  {
            Package p = incomingTruck.packages.get(0).get(i);  //setting
            if  (  !p.claimed  &&  t.canFit(p)  &&  t.state.equals("Stationary")  )  {  //found an unclaimed AND valid package for truck t from INCOMING
              this.targetIncoming();
              this.setVelTarget();
              this.state = "Unloading";  //set state
              this.targPack = p;
              incomingTruck.numCurWorkers += 1;
              this.targTruck = t;
              t.load += p.weight;  //**********************************************
              t.numCurWorkers += 1;
              p.claimed = true;
              println(  trucks.indexOf(t), t.state  ,  frameCount);
              break;
            }
            else  if  (  !t.canFit(p)  &&  !t.state.equals("Waiting To Leave")  &&  !queue.contains(t)  &&  t.numCurWorkers == 0)  {
              queue.add(t);
              t.state = "Waiting to Leave";
              break;
            }
          }

        }
        
        if  (this.state.equals("Unloading"))  {
          break;
        }
        //println("code was run", frameCount);
        //else?
        //CAN'T directly unload incoming onto outgoing
        
        else  if  (  t.state.equals("Stationary")  )  {
          //Loop shelves
          for  (Shelf s: Shelves)  {
            for  (int i = 0; i < s.stored.size(); i++)  {
              Package p = s.stored.get(i);
              if  (  !p.claimed  &&  t.canFit(p)  )  {  //found an unclaimed AND valid package for truck t from SHELF S
                this.targetShelf(s);
                this.setVelTarget();
                this.state = "Retrieving";
                this.targPack = p;
                this.targShelf = Shelves.indexOf(s);
                this.targTruck = t;
                t.load += p.weight;  //**********************************************
                t.numCurWorkers += 1;
                p.claimed = true;  //The package is now CLAIMED
                break;
              }
              ////test
              //else  if  (  !t.canFit(p)  &&  !t.state.equals("Waiting To Leave")  &&  !queue.contains(t)  &&  t.numCurWorkers == 0)  {
              //  queue.add(t);
              //  t.state = "Waiting to Leave";
              //}
              ////test
              
              if  (  this.state.equals("Retrieving")  )  {  //Leave if we found a valid package
                break;
              }
              
            }
          }
        }
        
      }
      
    }
    
  }
  
  //Looking to unload the incoming truck
  void  searchIncoming()  {
    if  (  incomingTruck.state.equals("Unloading")  &&  incomingTruck.numCurWorkers < 4  &&  incomingTruck.numCurWorkers < incomingTruck.packages.get(0).size())  {

      for  (int i = 0; i < incomingTruck.packages.get(0).size(); i++)  {
        Package p = incomingTruck.packages.get(0).get(i);  //setting
        
        if  (  !p.claimed  )  {  //Unclaimed package on incoming
          for  (Shelf s: Shelves)  {
            //println();
            //println(Shelves.indexOf(s));
            //println(s.capacity);
            if  (  s.capacity > 0  )  {  //The shelf can store an additional package
              s.capacity -= 1;  //immediately decrease so no other workers try to use it
              this.targetIncoming();
              this.setVelTarget();
              this.state = "Unloading";
              this.targPack = p;
              this.targShelf = Shelves.indexOf(s);
              this.targTruck = null;
              p.claimed = true;
              break;
            }
          }
        }
        
        if  (  this.state.equals("Unloading")  )  {  //Leave if we found a valid package
          break;
        }
        
      }
      
    }
  }
  
  //Sets target to closest outgoing Truck  (still needs work)
  void  targetOutgoing(Truck  t)  {
    this.target = t.restPosition.copy();
    this.target.y += 5;
    this.target.x -= 5;
  }
  
  //Sets target to incoming truck
  void  targetIncoming()  {
    this.target = incomingTruck.position.copy();
    this.target.y += 15;
    this.target.x += 10;
  }
  
  //Sets target to closest availible shelf, set targInd
  //void  targetShelf()  {
  //  for  (Shelf s: Shelves)  {
  //    //Has room for package
  //    if  (s.stored.size() < 5)  {
  //      this.target = s.pos.copy();
  //      this.target.y -= sH;
  //      this.target.x += random(-sW/2, sW/2);
  //      this.targInd = Shelves.indexOf(s);
        
  //      break;
  //    }
  //  }
  //}
  
  void  targetShelf(int  i)  {
    this.target = Shelves.get(i).pos.copy();
    this.target.y -= sH;
    this.target.x += random(-sW/2, sW/2);
  }
  
  void  targetShelf(Shelf s)  {  //idk if this works
    this.target = s.pos.copy();
    this.target.y -= sH;
    this.target.x += random(-sW/2, sW/2);
    this.targShelf = Shelves.indexOf(s);
    
    //Shelves.get( Shelves.indexOf(s) ).claimed.set(index, true);
    
    //println("\t", s.claimed);
    
  }
  
  //Calculates the velocity that the worker should be moving to reach its destination
  void  setVelTarget()  {
    this.vel = PVector.sub(this.target, this.pos);
    this.vel.normalize();
    this.vel.mult(workerSpeed);
  }
  
}
