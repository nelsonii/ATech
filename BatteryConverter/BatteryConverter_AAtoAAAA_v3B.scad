include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>
use <BOSL/masks.scad>

//positive terminal minimum 1.0mm (included in height) -- max 5.5mm
//negative terminal minimum diameter 7mm
hAA=50;
dAA=14+0.5;

compressedSpring = 1.6; // trying a flat/hill tab for now
hAAAA=40.5+compressedSpring; 
dAAAA=8.3; 

//Metal Battery Spring Terminals
//additions are for "wiggle room"
slotWidthX = 9.7 + 0.3;
slotDepthY=9.0 + 0.3;
slotThicknessZ=0.40 + 0.40; // metal tab only -- does not count negative spring or positive bump!
tabWidthX=2.5;
tabDepthY=6.0;
tabOffset=0; // in degrees 

//Plastic Reed Switch
reedL = 14.5;
reedW = 3.25;
reedH = 3.14;

//General variables
$fn=60; //circle smoothness
overlap = 1.00; // overlap ensures that subtractions go beyond the edges

topThickness = 0.5;
shiftForward=0.0;


difference() {

  //Outside dimensions of a AA battery
  AA();
  
  //chamfer top edge
  up(hAA) chamfer_cylinder_mask(r=(dAA/2), chamfer=0.8);

  //Cutout for AAAA battery
  forward(shiftForward) up(hAA-hAAAA-topThickness) AAAA();
  forward(shiftForward) up(hAA-hAAAA-topThickness) forward(dAAAA/2) AAAAopening();

  //Positive pole hole
  forward(shiftForward) up(hAA-topThickness) color("green") cyl(d=6, h=topThickness*2, align=V_UP); // hole at top for battery positive to poke through at

  //spring insert for negative pole of battery
  forward(shiftForward) up(hAA-hAAAA-0.2-slotThicknessZ) zrot(180-tabOffset) slot();
  //Downfacing  
  up(hAA-hAAAA-4-slotThicknessZ) zrot(tabOffset) xrot(180) slot();  
  up(hAA-hAAAA-4-slotThicknessZ) zrot(tabOffset) xrot(180) slotopening();  
  //hole for negative spring from device
  forward(shiftForward) color("green") cyl(d=8, h=1, align=V_UP);

  //Flatten holder
  back((dAA/2)-shiftForward+1) color("rosybrown") cuboid([dAA, 3, hAA], align=V_UP); //flatten back
  //forward((dAA/2)+0.25) color("gray") cuboid([dAA, 2, hAA], align=V_UP); //flatten front

  //Reed switch
  up(hAA-hAAAA+2) back((dAA/2)-(reedH/2))  reed();
  
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

module reed() { 
  color("slategray") cuboid([reedW, reedH, reedL], align=V_UP);
  back(1) down(3) color("lightgray") cuboid([1.25, 2.5, reedL+3+3], align=V_UP);
}