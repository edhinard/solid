// Which one would you like to see?
part = "pentagon"; // [pentagon:5,hexagon:6,both:5-6]

// diameter of the circumscribed sphere in mm
diameter = 220; // [40:400]
R = diameter/2;

// "flat" faces or "projected" on the sphere
variant="flat";// ["flat","projected"]

// in mm
thickness = 5; // [5:20]

reverse="no"; // [yes,no]


a = R / (sqrt((29 + 9*sqrt(5)) /2));

echo(part,R,variant,thickness,reverse);
print_part();

module print_part() {
  if (part == "pentagon") {
    pentagon();
  } else if (part == "hexagon") {
    hexagon();
  } else if (part == "both") {
    both();
  } else {
    both();
  }
}

module pentagon() {
  if(variant=="flat")
    flatface(R,a,5,thickness,upward=reverse=="yes"?true:false);
  else
    sphericalface(R,a,5,thickness,upward=reverse=="yes"?false:true);
}
module hexagon() {
  if(variant=="flat")
    flatface(R,a,6,thickness,upward=reverse=="yes"?true:false);
  else
    sphericalface(R,a,6,thickness,upward=reverse=="yes"?false:true);
}
module both() {
  translate([-a,0,0]) pentagon();
  translate([a,0,0]) hexagon();
}

module sphericalface(R,a,n,thickness,upward=true) {
  r = a / (2*sin(180/n));
  H = sqrt(R*R - r*r);

  translate([0,0,upward?0:R-H+thickness]) mirror([0,0,upward?0:1])
    difference() {
      translate([0,0,-H+thickness]) {
        intersection() {
          sphere(r=R);
          cylinder(2*H,r1=0,r2=2*r,$fn=n);
        }
      }
      translate([0,0,-R])
        cube(2*R, center=true);
    }
}

module flatface(R,a,n,thickness,upward=false) {
  r = a / (2*sin(180/n));
  H = sqrt(R*R - r*r);

  translate([0,0,upward?0:thickness]) mirror([0,0,upward?0:1])
    difference() {
      translate([0,0,-H+thickness]) 
        cylinder(H,r1=0,r2=r,$fn=n);
      translate([0,0,-R])
        cube(2*R, center=true);
    }      
}
