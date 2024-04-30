// ButtonMagnetAdapter_Inside_v1C.scad
// Copyright 2022 by Ronald L. Nelson II
// ron.nelson.ii@gmail.com
// sybarite.us

// All measurements are in MM

//The Belfry OpenSCAD Library
//https://github.com/revarbat/BOSL
include <BOSL/constants.scad>
use <BOSL/shapes.scad>
use <BOSL/transforms.scad>

buttonHeight = 2.64;
buttonDiameter = 11.25;
buttonWiggleRoom = 0.30;

magnetDiameter = 6;
magnetHeight = 2;

adapterHeight = (buttonHeight * 1.60);
$fn=120; //default circle smoothness


difference(){

  union(){
  //base object
  color("blue") cylinder(h=adapterHeight, d=buttonDiameter*1.5);
  }

  //subtractions ---------------------------------------

  //subtract out space for button in middle
  color("red") 
   translate([0,0,(adapterHeight/2)-((buttonHeight+buttonWiggleRoom)/2)])
    cylinder(h=(buttonHeight+buttonWiggleRoom), d=(buttonDiameter+buttonWiggleRoom));

  //subtract out slot for button to slide into
  color("pink")
   translate([-((buttonDiameter+buttonWiggleRoom)/2), 0, (adapterHeight/2)-((buttonHeight+buttonWiggleRoom)/2)])
    cube([(buttonDiameter+buttonWiggleRoom), (buttonDiameter*1.5), (buttonHeight+buttonWiggleRoom)]);
  
  //subtract out keyhole slot for button thread attachment
  color("hotpink") cylinder(h=buttonHeight, d=(buttonDiameter+buttonWiggleRoom)*0.40);
  color("hotpink") translate([0,63,0]) rotate([90,0, 0]) teardrop(r=buttonDiameter, h=2, ang=10);
  
  //subtract out magnet mounting
  color("deeppink") translate([0,0,adapterHeight-0.50]) cylinder(h=magnetHeight, d=magnetDiameter);

}//difference