//This code relies on BOSL (Belfry Open SCAD Library). 
//Found at: https://github.com/revarbat/BOSL
//BOSL makes fancier objects easier to code in OpenSCAD.

include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

slotType = "PART"; // FULL, PART, NONE

caseWidthX = 36.25;
caseDepthY = 35.25;
caseHeightZ = 2.50;

mountWidthX=27.20;
mountDepthY=2.50; //1.25; -- 1.25 is original measured tab thickness. doubled up for additional strength
mountHeightZ=4.45;
mountOffset=29.25; //28.00; -- 28.00 is original distance, based on 1.25 thick -- doubling 1.25 means this goes up 1.25

mountCurveOffset=12.00;

mountPinWidthX=2.70;
mountPinDepthY=0.50;
mountPinHeightZ=0.80;
mountPinOffset=24.50;

slotWidthX = 3.00;
slotDepthY=24.00;
slotOffset=25.00;

tabWidthX=1.46;
tabDepthY=10.00;
tabOffset=6.00;

$fn=120; //circle smoothness
overlap = 1.00; // overlap ensures that subtractions go beyond the edges


//MAIN *******************************************
difference() {
  union() { core(); mounts(); }
    forward(1) slots();
    flextab();
}


module core() {
  color("cadetblue") {
    difference() {
      cuboid([caseWidthX, caseDepthY, caseHeightZ], align=V_UP, fillet=2, edges=EDGES_Z_ALL);
      //flex point
     up(caseHeightZ/2) back((caseDepthY/2)-((tabDepthY+2)/2)) cuboid([tabOffset+tabWidthX, tabDepthY+2, caseHeightZ], align=V_UP);
    }
  }
  
}

module mounts() {
   forward((mountOffset/2)+1.5) mountA();
   back((mountOffset/2)-0.0) mountB();
}


module mountA() { 
    difference() {
      union() {
        color("violet") cuboid([mountWidthX, mountDepthY, mountHeightZ+caseHeightZ], fillet=0.5, edges=EDGES_Y_ALL, align=V_UP);
        back(mountPinDepthY/2) up(caseHeightZ+3) color("orange") cuboid([mountPinWidthX, mountPinDepthY+mountDepthY, mountPinHeightZ], align=V_UP);
        left(mountPinOffset/2) back(mountPinDepthY/2) up(caseHeightZ+3) color("orange") cuboid([mountPinWidthX, mountPinDepthY+mountDepthY, mountPinHeightZ], align=V_UP);
        right(mountPinOffset/2) back(mountPinDepthY/2) up(caseHeightZ+3) color("orange") cuboid([mountPinWidthX, mountPinDepthY+mountDepthY, mountPinHeightZ], align=V_UP);
        //additional printing support
        back(mountPinDepthY/2) up(caseHeightZ+3-mountPinHeightZ) color("crimson") prismoid(size1=[mountPinWidthX, 0], size2=[mountPinWidthX, mountPinDepthY+mountDepthY], h=mountPinHeightZ, align=V_UP); 
        left(mountPinOffset/2) back(mountPinDepthY/2) up(caseHeightZ+3-mountPinHeightZ) color("crimson") prismoid(size1=[mountPinWidthX, 0], size2=[mountPinWidthX, mountPinDepthY+mountDepthY], h=mountPinHeightZ, align=V_UP); 
        right(mountPinOffset/2) back(mountPinDepthY/2) up(caseHeightZ+3-mountPinHeightZ) color("crimson") prismoid(size1=[mountPinWidthX, 0], size2=[mountPinWidthX, mountPinDepthY+mountDepthY], h=mountPinHeightZ, align=V_UP); 

      }
       up(caseHeightZ+2.20) left(mountCurveOffset/2) ycyl(d=8, h=mountDepthY, align=V_UP);
       up(caseHeightZ+2.20) right(mountCurveOffset/2) ycyl(d=8, h=mountDepthY, align=V_UP);
    }
}

module mountB() {
    difference() {
      union() {
        color("salmon") cuboid([mountWidthX, mountDepthY, mountHeightZ+caseHeightZ], fillet=0.5, edges=EDGES_Y_ALL, align=V_UP);
        color("orange") forward(mountPinDepthY/2) up(caseHeightZ+3) cuboid([mountPinWidthX, mountPinDepthY+mountDepthY, mountPinHeightZ], align=V_UP);
        //additional printing support
        forward(mountPinDepthY/2) up(caseHeightZ+3-mountPinHeightZ) color("plum") prismoid(size1=[mountPinWidthX, 0], size2=[mountPinWidthX, mountPinDepthY+mountDepthY], h=mountPinHeightZ, align=V_UP); 
      }
       up(caseHeightZ+2.20) left(mountCurveOffset/2) ycyl(d=8, h=mountDepthY, align=V_UP);
       up(caseHeightZ+2.20) right(mountCurveOffset/2) ycyl(d=8, h=mountDepthY, align=V_UP);
    }
}


module slots() {
  if (slotType=="FULL") {
    left(slotOffset/2) cuboid([slotWidthX, slotDepthY, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    right(slotOffset/2) cuboid([slotWidthX, slotDepthY, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
  }
  if (slotType=="PART") {
    shrink=4;
    back(slotDepthY/shrink) left(slotOffset/2) cuboid([slotWidthX, slotDepthY/shrink, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    forward(slotDepthY/shrink) left(slotOffset/2) cuboid([slotWidthX, slotDepthY/shrink, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    back(slotDepthY/shrink) right(slotOffset/2) cuboid([slotWidthX, slotDepthY/shrink, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    forward(slotDepthY/shrink) right(slotOffset/2) cuboid([slotWidthX, slotDepthY/shrink, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    //zip tie clearance
    up(caseHeightZ-1) left(slotOffset/2) cuboid([slotWidthX, slotDepthY/(shrink/2), caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    up(caseHeightZ-1) right(slotOffset/2) cuboid([slotWidthX, slotDepthY/(shrink/2), caseHeightZ], align=V_UP, fillet=1, edges=EDGES_Z_ALL);
    
    //eyeglass arm
    //down(caseHeightZ/1.5) cuboid([caseWidthX+1, 4, caseHeightZ], align=V_UP, fillet=1, edges=EDGES_TOP);
  }
}

module flextab() {
  
  left(tabOffset/2) back((caseDepthY/2)-(tabDepthY/2)) cuboid([tabWidthX, tabDepthY, caseHeightZ+mountHeightZ], align=V_UP);
  right(tabOffset/2) back((caseDepthY/2)-(tabDepthY/2)) cuboid([tabWidthX, tabDepthY, caseHeightZ+mountHeightZ], align=V_UP);
  
}
