use <3dvector.scad>;


function sp(A, radius=r) =
 A/norm(A)*radius;

r=40;

cuboctahedron_vertices = [
  sp([+1, 0,+1]),
  sp([ 0,+1,+1]),
  sp([-1, 0,+1]),
  sp([ 0,-1,+1]),

  sp([+1,+1, 0]),
  sp([-1,+1, 0]),
  sp([-1,-1, 0]),
  sp([+1,-1, 0]),

  sp([+1, 0,-1]),
  sp([ 0,+1,-1]),
  sp([-1, 0,-1]),
  sp([ 0,-1,-1]),
];

cuboctahedron_triangle_faces = [
  [0,1,4],
  [1,2,5],
  [2,3,6],
  [3,0,7],

  [4,9,8],
  [5,10,9],
  [6,11,10],
  [7,8,11]
];
cuboctahedron_square_faces = [
[0,3,2,1],
[0,4,8,7],
[1,5,9,4],
[2,6,10,5],
[3,7,11,6],
[8,9,10,11]
];
cuboctahedron_faces = concat(cuboctahedron_triangle_faces,cuboctahedron_square_faces);
cuboctahedron = [cuboctahedron_vertices, cuboctahedron_faces];

function edges(poly) =
 let(
  vertices=poly[0],
  faces=poly[1]
 )
 [for(face=faces) let(vert=concat(face, [face[0]])) for(j=[0:len(vert)-2])
    let(v1=vert[j], v2=vert[j+1])
      if(v1<v2)
        [v1,v2,edgetransform(vertices[v1],vertices[v2])]
 ];

function joins(poly) =
 let(
  vertices=poly[0],
  faces=poly[1],
  edges=[for(face=faces) let(vert=concat(face, [face[0]])) for(j=[0:len(vert)-2]) let(v1=vert[j], v2=vert[j+1]) [v1,v2]]
 )
 [for(i=[0:len(vertices)-1])
   [for(edge=edges) if(edge[0]==i) edge[1]]
 ];


function edgetransform(A,B) =
 let(
  uo=[0,0,1],
  vo=[0,-1,0],
  up=normalize(B-A),
  vp=-normalize(A),
  rot1=make_rotation(uo,up),
  vi=rotate_vector(vo, rot1),
  wi=vi-(vi*up)*up,
  wp=vp-(vp*up)*up,
  rot2=make_rotation(wi,wp)
 )
 [A,rot1,rot2];

function make_rotation(vec1,vec2) =
 let(
  cr=cross(vec1,vec2),
  axe=normalize(cr),
  c=(vec1*vec2),
  s=norm(cr)
 )
 M = [[axe[0]*axe[0]*(1-c) + c,      axe[0]*axe[1]*(1-c) - axe[2]*s, axe[0]*axe[2]*(1-c) + axe[1]*s],
      [axe[0]*axe[1]*(1-c) + axe[2]*s, axe[1]*axe[1]*(1-c) + c,      axe[1]*axe[2]*(1-c) - axe[0]*s],
      [axe[0]*axe[2]*(1-c) - axe[1]*s, axe[1]*axe[2]*(1-c) + axe[0]*s, axe[2]*axe[2]*(1-c) + c]];



echo(edges(cuboctahedron));
echo(joins(cuboctahedron));

