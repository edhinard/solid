// Which one would you like to see?
part = "pentagon"; // [pentagon:5,hexagon:6]
n = part=="pentagon"?5:6;

// diameter of the circumscribed sphere in mm
diameter = 220; // [40:400]
R = diameter/2;

// "flat" faces or "projected" on the sphere
variant="projected";// ["flat","projected"]

// in mm
thickness = 15; // [5:20]

reverse="no"; // [yes,no]

$fn=100;
a = 2*R / (sqrt((29 + 9*sqrt(5)) /2));

echo(R,a,n,variant,thickness,reverse);
//if(variant=="flat")
//  flatface(upward=reverse=="yes"?true:false);
//else
//  sphericalface(upward=reverse=="yes"?false:true);


  r = a / (2*sin(180/n));
  H = sqrt(R*R - r*r);
under = 15;
above = 20;

  r1 = r * (H-under) / H;
  r2 = r * (H+above) / H;
  h = under + above;

function cylinder_vertex(h,r1,r2,ni=0) =
 let(
  n=ni<=0?$fn:ni,
  alpha = 360 / n
 )
 concat(
    [for(i=[0:n]) [r1*cos(i*alpha),r1*sin(i*alpha),0]],
    [for(i=[0:n]) [r2*cos(i*alpha),r2*sin(i*alpha),h]]
  );

function cylinder_faces(ni=0) =
 let(
  n=ni<=0?$fn:ni
 )
 concat(
  [for(i=[0:n-1]) [i,i+1,i+n+2,i+n+1]],
  [[for(i=[0:n-1]) i]],
  [[for(i=[0:n-1]) n+1+i]]
  );

module movetoface(face) {

}
vertex = cylinder_vertex(h,r1,r2,6);
faces = cylinder_faces(6);

echo(vertex);
echo(faces);
polyhedron(vertex, faces);









module sphericalface(upward=true) {
  r = a / (2*sin(180/n));
  H = sqrt(R*R - r*r);

  r2 = r * (R+2) / H;
  r1 = r * (H-thickness) / H;
  h = thickness + (R-H+2);
  
  translate([0,0,upward?0:h-2]) mirror([0,0,upward?0:1])
   intersection() {
    translate([0,0,-H+thickness])
     sphere(r=R);
    cylinder(h,r1=r1,r2=r2,$fn=n);
   }

  cylinder(h=30,r=5);
}

module sphericalfacesav(upward=true) {
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
