include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

//positive terminal minimum 1.0mm (included in height) -- max 5.5mm
//negative terminal minimum diameter 7mm
hAA=50;
dAA=14+0.5;

compressedSpring = 2.5;
hAAAA=42.5+compressedSpring; 
dAAAA=8.3*1.05; // 105% 

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

topThickness = 0.5;
shiftForward=3;


difference() {

  AA();

  forward(shiftForward) up(hAA-hAAAA-topThickness) #AAAA();
  forward(shiftForward) up(hAA-hAAAA-topThickness) forward(dAAAA/2) AAAAopening();

  //Positive pole hole
  forward(shiftForward) up(hAA-topThickness) color("green") cyl(d=6, h=topThickness*2, align=V_UP); // hole at top for battery positive to poke through at

  //spring insert for negative pole of battery
  forward(shiftForward) up(hAA-hAAAA-0.2-slotThicknessZ) zrot(180-tabOffset) slot();
  
  //up(hAA-hAAAA-3-slotThicknessZ) zrot(tabOffset) xrot(180) slot();  
  //up(hAA-hAAAA-3-slotThicknessZ) zrot(tabOffset) xrot(180) slotopening();  
  
  
  //Flatten holder
  back((dAA/2)-shiftForward+(3/2)) color("gray") cuboid([dAA, 3, hAA], align=V_UP); //flatten back
  //forward((dAA/2)+0.25) color("gray") cuboid([dAA, 2, hAA], align=V_UP); //flatten front
}
  
 //preview
 //up(hAA+10)   slot();

module AA() { 
  color("orange") cyl(d=dAA, h=hAA, align=V_UP); 
}

module AAAA() { 
  color("gold") cyl(d=dAAAA, h=hAAAA, align=V_UP); 
}

module AAAAopening() { 
  color("khaki") cuboid([dAAAA, dAAAA , hAAAA], align=V_UP); 
}


module slot() { 
  color("magenta") cuboid([slotWidthX, slotDepthY, slotThicknessZ], align=V_UP);
  color("deeppink") cyl(d=6, h=slotThicknessZ+1.6, align=V_UP);
  forward((slotDepthY/2)+(tabDepthY/2)) color("hotpink") cuboid([tabWidthX, tabDepthY, slotThicknessZ], align=V_UP);
}

module slotopening() {
  forward(dAA/2) color("pink") cuboid([slotWidthX, dAA, slotThicknessZ], align=V_UP);
  forward(dAA/2) color("lightpink") cuboid([6, dAA, slotThicknessZ+1.6], align=V_UP);
}