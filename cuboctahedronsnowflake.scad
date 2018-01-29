// +===========================================================================+
// |                                                                           |
// |  Cuboctahedron Snowflake                                                  |
// |                                                                           |
// |    Edges of a cuboctahedron projected on a sphere                         |
// |    and replaced by Koch curves on the same sphere                         |
// |                                                                           |
// | See https://en.wikipedia.org/wiki/Cuboctahedron and                       |
// | https://www.mathcurve.com/fractals/koch/koch.shtml                        |
// |  _edh_ @ ThingIVerse - 2018                                               |
// +===========================================================================+

// Radius of the sphere on which to draw the snowflake (in mm)
r=40;

// Recursion level of Koch curves. (n<=0 to see original points)
n=3;

// Options:
//  - only superior half of snowflake
//  - add a sphere to support the snowflake
//  - add a square on each squared face and a triangle on each triangle face
//    of the cuboctahedron 
half=true;
sphere=true;
trim=true;


thickness=.5;

//
// Processing options 'sphere' and 'half'
//
difference() {
 union() {
  cuboctahedronsnowflake();
  if(sphere)
   color("LightBlue",0.9) sphere(r);
 }
 if(half)
  translate([0,0,-2*r]) cube(4*r, center=true);
}


// The three points ABC are the vertices of an equilateral triangle on the
// sphere of radius r. Duplicating this triangle by the 3 planar symmetries
// yoz, xoz and xoy result in a cuboctahedron
A=sp([1,0,1]);
B=sp([0,1,1]);
C=sp([1,1,0]);

module cuboctahedronsnowflake() {
// copymirror([0,0,1])
 copymirror([0,1,0])
 copymirror([1,0,0])
 {
  // the initial Koch snowflake = 3 Koch curves
  path3d(koch(A,B,n),thickness);
  path3d(koch(B,C,n),thickness);
  path3d(koch(C,A,n),thickness);

  if(trim) {
   // a 1/3 smaller triangle in triangle faces
   ta=sp(3*B+3*C+A);
   tb=sp(3*C+3*A+B);
   tc=sp(3*A+3*B+C);
   path3d(koch(ta,tb,n-1),thickness);
   path3d(koch(tb,tc,n-1),thickness);
   path3d(koch(tc,ta,n-1),thickness);
  }

  if(trim) {
   // a 1/3 smaller square in square faces
   sqa1=sp(5*B-3*A+3*C);
   sqa2=sp(5*C-3*A+3*B);
   sqb1=sp(5*C-3*B+3*A);
   sqb2=sp(5*A-3*B+3*C);
   sqc2=sp(5*B-3*C+3*A);
   sqc1=sp(5*A-3*C+3*B);
   path3d(koch(sqa1,sqa2,n-1),thickness);
   path3d(koch(sqb1,sqb2,n-1),thickness);
   path3d(koch(sqc1,sqc2,n-1),thickness);
  }
 }
}


// 
// Projection on a sphere
//  input: point A
//  output: projection of A on the sphere centered on origin of given radius
//
function sp(A, radius=r) =
 A/norm(A)*radius;


//
// Mirrors the child element while keeping the original
//
module copymirror(vec) {
 children();
 mirror(vec) children(); 
}


//
// Draw a 3d path
//
module path3d(segments, width=2) {
  for(i=[0:len(segments)-1])
    hull() {
      translate(segments[i][0]) sphere(width/2);
      translate(segments[i][1]) sphere(width/2);      
    }
}


//
// Koch curve
//  recursive construction of a Kock curve on a sphere
//  between two points A and B
//
// Returns a list of segment. if n (the recursion level) is 0 (or negative),
//  the result list contains only the segment [A,B]
//
function koch(A, B, n) =
 // end test of recusrsion, only returns segment [A,B]
 n<=0?[[A,B]]:
 
 let(
  p0=A, p4=B,
  // We are assuming p0 and p4 are on the same sphere.
  // Rotation about u by 3*theta turns p0 in p4
  w=cross(p0,p4),u=w[0],theta=w[1]/3,

  // p1 and p3 split the spherical segment [p0,p4] in 3 equal parts
  p1=rot(p0,u,theta),
  p3=rot(p0,u,2*theta),

  // Compute p2 so that p1-p2-p3 is an equilateral triangle on the sphere:
  //  Rotation about u by theta turns p1 in p3.
  //  Thus u is the axe of the great circle that join p1 and p3 on the sphere,
  //   and theta is the angle of the p1 O p3 arc.
  //  Using the cosine formula we can deduce the angle A of the equilateral
  //  triangle p1-p2-p3 from theta. We just have to rotate the great circle
  //  p1 p3 about axe O-p1 by angle A to find the great circle p1 p2. The axe
  //  of this great circle p1 p 2 is the rotated vector u (called v). p2 is
  //  simply the image of p1 by the rotation about v.
  v=rot(u,p1,sphericalequilateraltriangle(theta)),
  p2=rot(p1,v,theta)
 )

 // The process transforms input segment [p0,p4] in 4 smaller segments [p0,p1],
 // [p1,p2], [p2,p3] and [p3,p4] each of which defines an arc on the sphere that
 // is 3 times smaller than the original one
 //
 //                * p2
 //               / \
 //              /   \
 //             /     \
 // p0         /       \         p4
 // *---------*         *---------*
 //          p1        p3

 concat(
  // koch curve, of level n, connecting p0 to p4 is made of the 4 koch curves
  // of level n-1 connecting p0 to p1, p1 to p2, p2 to p3 and p3 to p4 
  koch(p0,p1,n-1),
  koch(p1,p2,n-1),
  koch(p2,p3,n-1),
  koch(p3,p4,n-1)
 );


//
// Cross product of two vectors OA and OB
//
//  The result is a unit vector OC and an angle theta.
//  Assuming distances OA and OB are equals (A and B on the same O centered
// sphere), then B is the image of A by the rotation about OC with angle theta
//
// ref: https://en.wikipedia.org/wiki/Cross_product
//
function cross(A,B) =
 let(C=[A[1]*B[2] - A[2]*B[1],
        A[2]*B[0] - A[0]*B[2],
        A[0]*B[1] - A[1]*B[0]
       ],
     as=asin(norm(C)/(norm(A)*norm(B))),
     scal=A[0]*B[0]+A[1]*B[1]+A[2]*B[2]
  )
  [C/norm(C),scal>0?as:180-as];


//
// Rotation of point A about vector u with angle theta
//
// ref: https://en.wikipedia.org/wiki/Rotation_matrix
//
function rot(A, u, theta) =
 let(
    c = cos(theta),
    s = sin(theta),
    v=u/norm(u),
    R1 = [v[0]*v[0]*(1-c) + c,      v[0]*v[1]*(1-c) - v[2]*s, v[0]*v[2]*(1-c) + v[1]*s],
    R2 = [v[0]*v[1]*(1-c) + v[2]*s, v[1]*v[1]*(1-c) + c,      v[1]*v[2]*(1-c) - v[0]*s],
    R3 = [v[0]*v[2]*(1-c) - v[1]*s, v[1]*v[2]*(1-c) + v[0]*s, v[2]*v[2]*(1-c) + c]
 )
 [R1*A, R2*A, R3*A];


//
// Angle of a spherical equilateral triangle
//  given the angle that the great circle arcs subtend at the centre.
//
//  Simplification of the cosine formula:
//   cos a = cos b . cos c + sin b . sin c . cos A
//  in
//                  2           2
//   cos theta = cos theta + sin theta . cos A
//
// ref: https://en.wikipedia.org/wiki/Spherical_trigonometry#Cosine_rules
//
function sphericalequilateraltriangle(theta) =
 let(
  c=cos(theta),
  s=sin(theta)
 )
 acos((c-c*c)/(s*s));



