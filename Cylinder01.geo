n1=60;
n2=90;

// Initial Points
Point(1) = {0, 0, 0, 0};
Point(2) = {10, 0, 0, 0};
Point(3) = {-10, 0, 0, 0};
Point(4) = {0, 10, 0, 0};
Point(5) = {0, -10, 0, 0};
Point(6) = {0.5, 0, 0, 0};
Point(7) = {-0.5, 0, 0, 0};
Point(8) = {0, 0.5, 0, 0};
Point(9) = {0, -0.5, 0, 0};

// Exterior Circle
Circle(1) = {2, 1, 4};
Circle(2) = {3, 1, 4};
Circle(3) = {2, 1, 5};
Circle(4) = {3, 1, 5};

// Interior Circle
Circle(5) = {6, 1, 8};
Circle(6) = {7, 1, 8};
Circle(7) = {6, 1, 9};
Circle(8) = {7, 1, 9};
Line(9) = {6, 2};
Line(10) = {8, 4};
Line(11) = {7, 3};
Line(12) = {9, 5};

// Create surfaces
Line Loop(13) = {10, -1, -9, 5};
Plane Surface(14) = {13};
Line Loop(15) = {10, -2, -11, 6};
Plane Surface(16) = {15};
Line Loop(17) = {9, 3, -12, -7};
Plane Surface(18) = {17};
Line Loop(19) = {11, 4, -12, -8};
Plane Surface(20) = {19};

// Making Mesh
Transfinite Line {11,10,2,12,4}=n1 Using Progression 1.035;
Transfinite Line {6,2,8,4}=n2 Using Progression 1.0;
Transfinite Line {9,10,1,12,3}=n1 Using Progression 1.035;
Transfinite Line {5,1,7,3}=n2 Using Progression 1.0;
Transfinite Surface "*";
Recombine Surface "*";

// Ruller to measure y+ for the given Reynolds number

//Point(10) = {0, 0.55, 0, 1.0};

Extrude {0, 0, 1} {
  Surface{14, 16, 18, 20};
Layers{1};
Recombine;
}

Physical Surface("inlet") = {55, 99};
Physical Surface("back") = {108, 86, 64, 42};
Physical Surface("front") = {16, 14, 18, 20};
Physical Surface("exit") = {33, 77};
Physical Surface("cylinder") = {63, 41, 85, 107};
Physical Volume("internal") = {1, 2, 3, 4};

// Apply an elliptic smoother to the grid
Mesh.Smoothing = 30;
