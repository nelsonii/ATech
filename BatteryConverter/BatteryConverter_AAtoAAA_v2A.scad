include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

//positive terminal minimum 1.0mm (included in height) -- max 5.5mm
//negative terminal minimum diameter 7mm
hAA=50;
dAA=14+0.5;

//positive terminal minimum 0.8mm (included in height) -- max 3.8mm
//negative terminal minimum diamter 3.8mm
hAAA=44.5-0.5;
dAAA=10.5;

//Metal Battery Spring Terminals
//additions are for "wiggle room"
slotWidthX = 9.7 + 0.3;
slotDepthY=9.0 + 0.3;
slotThicknessZ=0.40 + 0.40; // metal tab only -- does not count negative spring or positive bump!
tabWidthX=2.3;
tabDepthY=6.0;
tabOffset=0; // in degrees 

//General variables
$fn=60; //circle smoothness
overlap = 1.00; // overlap ensures that subtractions go beyond the edges

difference() {

  //Overall shape (of a AA battery)
  AA();

  //Subtract out space for the AAA
  up(hAA-hAAA-1) AAA();
  up(hAA-hAAA-1) forward(dAAA/2) AAAopening();

  //Positive pole hole
  up(hAA-1) color("green") cyl(d=6.5, h=1, align=V_UP); // hole at top for battery positive to poke through at

  //spring insert for negative pole of battery
  up(hAA-hAAA-1-slotThicknessZ) zrot(180-tabOffset) slot();
  
  up(hAA-hAAA-3-slotThicknessZ) zrot(tabOffset) xrot(180) slot();  
  up(hAA-hAAA-3-slotThicknessZ) zrot(tabOffset) xrot(180) slotopening();  
  
  //Flatten holder
  back((dAA/2)+0.0) color("gray") cuboid([dAA, 2, hAA], align=V_UP); //flatten back
  forward((dAA/2)+0.25) color("gray") cuboid([dAA, 2, hAA], align=V_UP); //flatten front
}
  
 //preview
 //up(hAA+10)   slot();

module AA() { 
  color("orange") cyl(d=dAA, h=hAA, align=V_UP); 
}

module AAA() { 
  color("gold") cyl(d=dAAA, h=hAAA, align=V_UP); 
}

module AAAopening() { 
  color("khaki") cuboid([dAAA, dAAA , hAAA], align=V_UP); 
}

module slot() { 
  color("magenta") cuboid([slotWidthX, slotDepthY, slotThicknessZ], align=V_UP);
  color("deeppink") cyl(d=6, h=slotThicknessZ+1.6, align=V_UP);
  forward((slotDepthY/2)+(tabDepthY/2)) color("hotpink") cuboid([tabWidthX, tabDepthY, slotThicknessZ], align=V_UP);
  //slotopening();
}

module slotopening() {
  forward(dAA/2) color("pink") cuboid([slotWidthX, dAA, slotThicknessZ], align=V_UP);
  forward(dAA/2) color("lightpink") cuboid([6, dAA, slotThicknessZ+1.6], align=V_UP);
}