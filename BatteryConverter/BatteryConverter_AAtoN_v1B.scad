include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

compressedSpring = 5.5;

//positive terminal minimum 1.0mm (included in height) -- max 5.5mm
//negative terminal minimum diameter 7mm
hAA=50.0-1;
dAA=14.0;

//positive terminal minimum XXXmm (included in height) -- max XX
//negative terminal minimum diamter XXmm
hN=30.2+compressedSpring;
dN=12;

//Metal Battery Spring Terminals
//additions are for "wiggle room"
slotWidthX = 9.7 + 0.3;
slotDepthY=9.0 + 0.3;
slotThicknessZ=0.40*2; // metal tab only -- multiplier gives wiggle room
tabWidthX=2.3;
tabDepthY=6.0;
tabOffset=0; // in degrees 

//Plastic Reed Switch
reedL = 14.5;
reedW = 3.25;
reedH = 3.14;

topThickness = 2;
shiftForward=0;


//General variables
$fn=60; //circle smoothness
overlap = 1.00; // overlap ensures that subtractions go beyond the edges

difference() {

  //Overall shape (of a AA battery)
  AA();

  //Battery Cutout
  forward(shiftForward) up(hAA-hN-topThickness) N();
  forward(shiftForward) up(hAA-hN-topThickness) forward(dN/2) Nopening();

  //Positive Pole (M2.5)
  up(hAA-topThickness) color("green") cyl(d=2.4, h=2.6, align=V_UP); 
  up(hAA-topThickness) color("lime") cyl(d=5.5, h=0.6, align=V_UP, $fn=6);

  //spring insert for negative pole of battery
   up(hAA-hN-topThickness) zrot(180-tabOffset) slot();
  
  //Bottom tab (negative)
  up(2) zrot(tabOffset) xrot(180) slot();  
  up(2) zrot(tabOffset) xrot(180) slotopening(); 
  //clear out fiddly parts
  back(8) color("orange") cyl(d=dN, h=2, align=V_UP); 
  
  //Flatten holder
  back((dAA/2)+0.75) color("gray") cuboid([dAA, 2, hAA], align=V_UP); //flatten back
  //forward((dAA/2)+0.25) color("gray") cuboid([dAA, 2, hAA], align=V_UP); //flatten front
  
  
  //Reed switch
  up(20) back((dAA/2)-(reedH/2)-0)  #reed();
  
}
  
 //preview just the slot
 //up(hAA+10)   slot();


//----------------------------------------------------------------------------------------

module AA() { color("orange") cyl(d=dAA, h=hAA, align=V_UP, $fn=240); }
module N() { color("gold") cyl(d=dN, h=hN, align=V_UP, $fn=20); }
module Nopening() { color("khaki") cuboid([dN, dN , hN], align=V_UP); }

//----------------------------------------------------------------------------------------

module reed() { 
  color("slategray") cuboid([reedW, reedH, reedL], align=V_UP);
  down(3) color("lightgray") cuboid([1.25, reedH, reedL+3+3], align=V_UP);
}

//----------------------------------------------------------------------------------------

module slot() { 
  color("magenta") cuboid([slotWidthX, slotDepthY, slotThicknessZ], align=V_UP);
  color("deeppink") cyl(d=6.5, h=slotThicknessZ+1.6, align=V_UP);
  forward((slotDepthY/2)+(tabDepthY/2)) color("hotpink") cuboid([tabWidthX, tabDepthY, slotThicknessZ], align=V_UP);
  //slotopening();
}

module slotopening() {
  forward(dAA/2) color("pink") cuboid([slotWidthX, dAA, slotThicknessZ], align=V_UP);
  forward(dAA/2) color("lightpink") cuboid([6.5, dAA, slotThicknessZ+1.6], align=V_UP);
}

//----------------------------------------------------------------------------------------
