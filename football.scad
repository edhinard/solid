use <pins.scad>

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

pinhole="yes"; // [yes,no]

$fn=100;
a = 2*R / (sqrt((29 + 9*sqrt(5)) /2));
r = a / (2*sin(180/n));
H = sqrt(R*R - r*r);

wholeheight = (variant=="projected"?(R-H):0)+thickness;
translate([0,0,reverse=="yes"?wholeheight:0]) mirror([0,0,reverse=="yes"?1:0]) {
 // bottom part
 rb = r * (H-thickness) / H;
 cyl = cylinder_params(thickness,rb,r,n);
 difference() {
  buildcylinder(cyl);
  if(pinhole=="yes")
   for(face=sidefaces(cyl)) {
    movetoface(face)
     mirror([0,0,1]) pinhole(h=10);
   }
 }

 // top part
 if(variant == "projected") {
  h = R-H+1;
  rt = r * (R+1) / H;
  translate([0,0,thickness])
   intersection(){
    translate([0,0,-H])
     sphere(r=R);
    cylinder(h,r,rt,$fn=n);
   }
 }

}

function cylinder_params(h,r1,r2,ni=0) =
 let(
  n=ni<=0?$fn:ni,
  alpha = 360 / n,
  vertices = concat(
   [for(i=[0:n]) [r1*cos(i*alpha),r1*sin(i*alpha),0]],
   [for(i=[0:n]) [r2*cos(i*alpha),r2*sin(i*alpha),h]]
   ),
  faces = concat(
   [for(i=[0:n-1]) [i,i+n+1,i+n+2,i+1]],
   [[for(i=[0:n-1]) i]],
   [[for(i=[n-1:-1:0]) n+1+i]]
  )
 )
 [vertices, faces];

function sidefaces(cyl) =
 [for(i=[0:len(cyl[1])-3]) let(vertices=cyl[0],faces=cyl[1],face=faces[i]) [for(v=face) vertices[v]]];

module buildcylinder(cyl) {
 polyhedron(cyl[0], cyl[1]);
}

module movetoface(face) {
 center = sum(face)/len(face);
 normal = normalize(cross(face[0]-face[1],face[2]-face[1]));

 v1 = [0,0,1];
 v2 = normal;
 cr=cross(v1,v2);
 axe=norm(cr)!=0?normalize(cr):normalize(cross(v1,rands(-1,+1,3)));
 c=(v1*v2);
 s=norm(cr);
 M = [[axe[0]*axe[0]*(1-c) + c,        axe[0]*axe[1]*(1-c) - axe[2]*s, axe[0]*axe[2]*(1-c) + axe[1]*s, center[0]],
      [axe[0]*axe[1]*(1-c) + axe[2]*s, axe[1]*axe[1]*(1-c) + c,        axe[1]*axe[2]*(1-c) - axe[0]*s, center[1]],
      [axe[0]*axe[2]*(1-c) - axe[1]*s, axe[1]*axe[2]*(1-c) + axe[0]*s, axe[2]*axe[2]*(1-c) + c,        center[2]],
      [0,                              0,                              0,                              1]
     ];
 multmatrix(M)
  children();
}

function sum(vec, s=undef) =
 let(
  s=s==undef?[for(i=[0:len(vec[0])-1]) 0]:s
 )
 len(vec)==1?s+vec[0]:sum([for(i=[1:len(vec)-1]) vec[i]], s+vec[0]);

function normalize(vec) =
  vec/norm(vec);
  

