// ButtonVelcroAdapter_Outside_v1C.scad
// Copyright 2022 by Ronald L. Nelson II
// ron.nelson.ii@gmail.com
// sybarite.us

// All measurements are in MM

buttonHeight = 2.64;
buttonDiameter = 11.25 * 0.95; // shrink slightly
velcroDiameter = 19;

postDiameter = 5;
adapterHeight = (buttonHeight * 0.50);
adjustHeight = 2.3;

$fn=120; //default circle smoothness


difference() {
  union(){
    //base object
    color("yellow") 
     cylinder(h=adapterHeight, d=velcroDiameter);

    //pseudo threads (through button hole)
    color("gold")
     cylinder(h=buttonHeight*adjustHeight, d=postDiameter);
     
   //pseudo button
   color("snow")
    translate([0,0, (buttonHeight*adjustHeight)-buttonHeight])
    cylinder(h=buttonHeight, d=buttonDiameter);
  }//union
  
  //subtractions --------------------------------------
  
  color("pink")
   translate ([-(buttonDiameter*0.15), -(buttonDiameter*0.15), ((buttonHeight*adjustHeight)-(buttonHeight*0.20))])
    cylinder(h=buttonHeight*0.20, d=2);
  color("pink")
   translate ([-(buttonDiameter*0.15), +(buttonDiameter*0.15), ((buttonHeight*adjustHeight)-(buttonHeight*0.20))])
    cylinder(h=buttonHeight*0.20, d=2);
  color("pink")
   translate ([+(buttonDiameter*0.15), -(buttonDiameter*0.15), ((buttonHeight*adjustHeight)-(buttonHeight*0.20))])
    cylinder(h=buttonHeight*0.20, d=2);
  color("pink")
   translate ([+(buttonDiameter*0.15), +(buttonDiameter*0.15), ((buttonHeight*adjustHeight)-(buttonHeight*0.20))])
    cylinder(h=buttonHeight*0.20, d=2);
  
}//difference  