r=40;

// --------------------------------------|--------------------------------------
// ----------------------------------- POLY ------------------------------------
poly_vertices = [
  [+1,+1,+1],
  
] * r / sqrt(3);
poly_faces = [
  [0,1,2],
  
];
poly = [poly_vertices, poly_faces];

phi=(sqrt(5)+1)/2;
iph=(sqrt(5)-1)/2;


// -------------------------------- TETRAHEDRON --------------------------------
tetrahedron_vertices = [
  [+1,+1,-1],
  [+1,-1,+1],
  [-1,+1,+1],
  [-1,-1,-1]
] * r / sqrt(3);
tetrahedron_faces = [
  [0,1,2],
  [0,2,3],
  [0,3,1],
  [1,3,2]
];
tetrahedron = [tetrahedron_vertices, tetrahedron_faces];

// ----------------------------------- CUBE ------------------------------------
cube_vertices = [
  [+1,+1,+1],
  [+1,-1,+1],
  [-1,-1,+1],
  [-1,+1,+1],
  [+1,+1,-1],
  [+1,-1,-1],
  [-1,-1,-1],
  [-1,+1,-1],
] * r / sqrt(3);
cube_faces = [
  [0,1,2,3],
  [0,4,5,1],
  [0,3,7,4],
  [1,5,6,2],
  [2,6,7,3],
  [4,7,6,5]
];
cube = [cube_vertices, cube_faces];

// -------------------------------- OCTAHEDRON ---------------------------------
octahedron_vertices = [
  [+1, 0, 0],
  [-1, 0, 0],
  [ 0,+1, 0],
  [ 0,-1, 0],
  [ 0, 0,+1],
  [ 0, 0,-1]
] * r;
octahedron_faces = [
  [0,3,4],
  [0,4,2],
  [0,2,5],
  [0,5,3],
  [1,2,4],
  [1,4,3],
  [1,3,5],
  [1,5,2]
];
octahedron = [octahedron_vertices, octahedron_faces];

phi=(sqrt(5)+1)/2;
iph=(sqrt(5)-1)/2;
phi2=phi*phi;
// ------------------------------- DODECAHEDRON --------------------------------
dodecahedron_vertices = [
  [+1  ,+1  ,+1  ],
  [+1  ,-1  ,+1  ],
  [-1  ,-1  ,+1  ],
  [-1  ,+1  ,+1  ],
  [+1  ,+1  ,-1  ],
  [+1  ,-1  ,-1  ],
  [-1  ,-1  ,-1  ],
  [-1  ,+1  ,-1  ],
  [ 0  ,+phi,+iph],
  [ 0  ,+phi,-iph],
  [ 0  ,-phi,+iph],
  [ 0  ,-phi,-iph],
  [+iph, 0  ,+phi],
  [-iph, 0  ,+phi],
  [+iph, 0  ,-phi],
  [-iph, 0  ,-phi],
  [+phi,+iph, 0  ],
  [+phi,-iph, 0  ],
  [-phi,+iph, 0  ],
  [-phi,-iph, 0  ]
] * r / sqrt(3);
dodecahedron_faces = [
  [ 0,16,17, 1,12],
  [ 0,12,13, 3, 8],
  [ 1,10, 2,13,12],
  [ 2,19,18, 3,13],
  [ 1,17, 5,11,10],
  [ 6,19, 2,10,11],
  [ 5,14,15, 6,11],
  [ 4,14, 5,17,16],
  [ 6,15, 7,18,19],
  [ 3,18, 7, 9, 8],
  [ 0, 8, 9, 4,16],
  [ 4, 9, 7,15,14]
];
dodecahedron = [dodecahedron_vertices, dodecahedron_faces];

// -------------------------------- ICOSAHEDRON --------------------------------
icosahedron_vertices = [
  [+phi,+1  , 0  ],
  [+phi,-1  , 0  ],
  [-phi,+1  , 0  ],
  [-phi,-1  , 0  ],
  [+1  , 0  ,+phi],
  [-1  , 0  ,+phi],
  [+1  , 0  ,-phi],
  [-1  , 0  ,-phi],
  [ 0  ,+phi,+1  ],
  [ 0  ,+phi,-1  ],
  [ 0  ,-phi,+1  ],
  [ 0  ,-phi,-1  ]
] * r / sqrt(phi*phi+1);
icosahedron_faces = [
  [ 0, 1, 4],
  [ 0, 4, 8],
  [ 4, 5, 8],
  [ 5, 4,10],
  [ 1,10, 4],
  [ 3, 5,10],
  [ 2, 5, 3],
  [ 2, 8, 5],
  [ 0, 8, 9],
  [ 2, 9, 8],
  [ 2, 3, 7],
  [ 3,10,11],
  [ 1,11,10],
  [ 1, 6,11],
  [ 0, 6, 1],
  [ 0, 9, 6],
  [ 2, 7, 9],
  [ 6, 9, 7],
  [ 3,11, 7],
  [ 6, 7,11]
];
icosahedron = [icosahedron_vertices, icosahedron_faces];

// --------------------------------------|--------------------------------------
// ----------------------------- ICOSIDODECAHEDRON -----------------------------
icosidodecahedron_vertices = [
  [ 0     , 0     ,+phi   ],
  [ 0     , 0     ,-phi   ],
  [ 0     ,+phi   , 0     ],
  [ 0     ,-phi   , 0     ],
  [+phi   , 0     , 0     ],
  [-phi   , 0     , 0     ],
  [+1/2   ,+phi/2 ,+phi2/2],
  [+1/2   ,+phi/2 ,-phi2/2],
  [+1/2   ,-phi/2 ,+phi2/2],
  [+1/2   ,-phi/2 ,-phi2/2],
  [-1/2   ,+phi/2 ,+phi2/2],
  [-1/2   ,+phi/2 ,-phi2/2],
  [-1/2   ,-phi/2 ,+phi2/2],
  [-1/2   ,-phi/2 ,-phi2/2],
  [+phi2/2,+1/2   ,+phi/2 ],
  [+phi2/2,+1/2   ,-phi/2 ],
  [+phi2/2,-1/2   ,+phi/2 ],
  [+phi2/2,-1/2   ,-phi/2 ],
  [-phi2/2,+1/2   ,+phi/2 ],
  [-phi2/2,+1/2   ,-phi/2 ],
  [-phi2/2,-1/2   ,+phi/2 ],
  [-phi2/2,-1/2   ,-phi/2 ],
  [+phi/2 ,+phi2/2,+1/2   ],
  [+phi/2 ,+phi2/2,-1/2   ],
  [+phi/2 ,-phi2/2,+1/2   ],
  [+phi/2 ,-phi2/2,-1/2   ],
  [-phi/2 ,+phi2/2,+1/2   ],
  [-phi/2 ,+phi2/2,-1/2   ],
  [-phi/2 ,-phi2/2,+1/2   ],
  [-phi/2 ,-phi2/2,-1/2   ],
] * r / phi;
icosidodecahedron_faces = [
  [ 1,13, 9],
  [ 1, 7,11],
  [ 9,25,17],
];
icosidodecahedron = [icosidodecahedron_vertices, icosidodecahedron_faces];

phi=(sqrt(5)+1)/2;
iph=(sqrt(5)-1)/2;


module poly(poly) {
  for(i=[0:len(poly[0])-1]) {
    vert=poly[0][i];
    translate(vert) text(str(i));
    }

  polyhedron(poly[0],poly[1]);
  //%sphere(r);
}

poly(icosidodecahedron);