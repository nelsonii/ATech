//The Belfry OpenSCAD Library
//https://github.com/revarbat/BOSL
include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

$fn=60;

// Half pint: 2.25"x2.25"x2.75"
// Pint: 2.75"x2.75"x3.75"
// Quarter: 2.75"x2.75"x7.5"
// Half Gallon: 3.75"x3.75"x7.75"
// Gallon: 5.5"x5.5"x7.5".

baseXY = 100;

innerMilk = 60; // added some MM for swelling
milkHeight = 30;

wallThickness = 3;

//MAIN PROGRAM
base();
milkContainer();


module base() {
 
 //circular base
 color ("brown") down(milkHeight/2) cylinder(h=wallThickness, d=baseXY);
  
}

module milkContainer() {
  difference() {
    //make base cube
    color ("blue") cuboid([innerMilk+wallThickness, innerMilk+wallThickness, milkHeight], fillet=2);
    //subtract out inner cube
    color ("orange") up(wallThickness) cuboid([innerMilk, innerMilk, milkHeight]);
  }
}


