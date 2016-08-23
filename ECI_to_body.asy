import three; 
import solids;
settings.outformat="pdf";
currentprojection=orthographic(5,4,2);

size(20cm);





real h_sat = 0.1;
real r_earth = 0.4;

triple n1_tip = (1,0,0);
triple n2_tip = (0,1,0);
triple n3_tip = (0,0,1);
triple target = (1,3,1.5);
target = r_earth * target/sqrt(target.x^2+target.y^2+target.z^2);

transform3 sat_scale = scale3(h_sat);
triple[] sat_corners;
triple[] solar_array_1;
triple[] solar_array_2;



sat_corners[0] = sat_scale*(0,0,0);
sat_corners[1] = sat_scale*(1,0,0);
sat_corners[2] = sat_scale*(1,1,0);
sat_corners[3] = sat_scale*(0,1,0);
sat_corners[4] = sat_scale*(0,0,1);
sat_corners[5] = sat_scale*(1,0,1);
sat_corners[6] = sat_scale*(1,1,1);
sat_corners[7] = sat_scale*(0,1,1);

solar_array_1[0] = sat_corners[7]/2;
solar_array_1[1] = solar_array_1[0] ;
solar_array_1[2] = solar_array_1[1] - (0.1,0.1,0);
solar_array_1[3] = solar_array_1[2] - (0.4,0,0);
solar_array_1[4] = solar_array_1[3] - (0,-0.2,0);
solar_array_1[5] = solar_array_1[4] - (-0.4,0,0);
solar_array_1[6] = solar_array_1[1];
solar_array_1[7] = solar_array_1[0];



triple sat_barycenter;

for(int i=0; i<sat_corners.length; ++i) {
    sat_barycenter += sat_corners[i];
}
sat_barycenter = sat_barycenter/sat_corners.length;

for(int i=0; i<sat_corners.length; ++i) {
    sat_corners[i] = sat_corners[i] - sat_barycenter;
    solar_array_1[i] = solar_array_1[i] - sat_barycenter;
    solar_array_2[i] = - solar_array_1[i];

}

triple b1_tip = -0.6*n2_tip;
triple b2_tip = 0.6*n1_tip;
triple b3_tip = 0.6*n3_tip;




triple n1_tip_arc = 0.8*n1_tip;
triple n2_tip_arc = 0.8*n2_tip;
triple n3_tip_arc = 0.8*n3_tip;

path3 n1 = (O--n1_tip);
path3 n2 = (O--n2_tip);
path3 n3 = (O--n3_tip);

// Orbit orientation
real Omega = 30;
real i = 30 ;
real omega = 25;
real nu = 30;
real R = 2 ;


// Satellite orientation
real yaw = 170;
real pitch = 20;
real roll = 0;

// Earth orientation
real gamma = 30;

transform3 rot_Omega = rotate(Omega,O,n3_tip);
transform3 rot_i = rotate(i,O,rot_Omega*n1_tip);
transform3 rot_omega = rotate(omega,O,rot_i*n3_tip);
transform3 rot_nu = rotate(nu,O,rot_i*n3_tip);

transform3 rot_yaw = rotate(yaw,O,b3_tip);
transform3 rot_pitch = rotate(pitch,O,rot_yaw * b2_tip);
transform3 rot_roll = rotate(roll,O,rot_pitch * rot_yaw * b1_tip);

transform3 rot_gamma = rotate(gamma,n3_tip);

triple x_omega_tip = rot_omega*rot_i*rot_Omega*n1_tip;
triple y_omega_tip = rot_omega*rot_i*rot_Omega*n2_tip;
triple z_omega_tip = rot_omega*rot_i*rot_Omega*n3_tip;

triple x_tip = rot_nu*rot_omega*rot_i*rot_Omega*n1_tip;
triple y_tip = rot_nu*rot_omega*rot_i*rot_Omega*n2_tip;
triple z_tip = rot_nu*rot_omega*rot_i*rot_Omega*n3_tip;

triple e1_tip = rot_gamma * n1_tip;
triple e2_tip = rot_gamma * n2_tip;


b1_tip = rot_roll * rot_pitch * rot_yaw * b1_tip;
b2_tip = rot_roll * rot_pitch * rot_yaw * b2_tip;
b3_tip = rot_roll * rot_pitch * rot_yaw * b3_tip;

transform3 orbit = shift(rot_nu*rot_omega*rot_i*rot_Omega*(R*n1_tip));

path3 x_omega = (O--x_omega_tip);
path3 y_omega = (O--y_omega_tip);
path3 z_omega = (O--z_omega_tip);

path3 x = (O--x_tip);
path3 y = (O--y_tip);
path3 z = (O--z_tip);

path3 b1 = orbit*(O -- b1_tip);
path3 b2 = orbit*(O -- b2_tip);
path3 b3 = orbit*(O -- b3_tip);

for(int i=0; i<sat_corners.length; ++i) {
    sat_corners[i] = rot_roll * rot_pitch * rot_yaw * sat_corners[i];
    sat_corners[i] = orbit * sat_corners[i];
    solar_array_1[i] = rot_roll * rot_pitch * rot_yaw * solar_array_1[i];
    solar_array_1[i] = orbit * solar_array_1[i];
    solar_array_2[i] = rot_roll * rot_pitch * rot_yaw * solar_array_2[i];
    solar_array_2[i] = orbit * solar_array_2[i];

}
triple u_TS_vec = orbit*O - target;
real length_u_TS = sqrt( u_TS_vec.x^2 + u_TS_vec.y^2 + u_TS_vec.z^2);
triple u_TS_dir = u_TS_vec/length_u_TS;

path3 u_TS = target -- (target + 0.4*u_TS_dir );

path3 face1 = sat_corners[0] -- sat_corners[1]
 -- sat_corners[2] -- sat_corners[3] -- cycle;

path3 face2 = sat_corners[4] -- sat_corners[5] -- sat_corners[6] 
-- sat_corners[7] -- cycle;

path3 face3 = sat_corners[0] -- sat_corners[1]
 -- sat_corners[5] -- sat_corners[4] -- cycle;

path3 face4 = sat_corners[3] -- sat_corners[2] -- sat_corners[6] 
-- sat_corners[7] -- cycle;


path3 face5 = sat_corners[0] -- sat_corners[3]
 -- sat_corners[7] -- sat_corners[4] -- cycle;

path3 face6 = sat_corners[1] -- sat_corners[2] -- sat_corners[6] 
-- sat_corners[5] -- cycle;

path3 solar_array_1_surf = solar_array_1[1]
 -- solar_array_1[2] -- solar_array_1[3] -- solar_array_1[4] -- solar_array_1[5] -- cycle;


path3 solar_array_2_surf = solar_array_2[1]
 -- solar_array_2[2] -- solar_array_2[3] -- solar_array_2[4] -- solar_array_2[5] -- cycle;

path3 gamma_arc = arc(O, 0.8*n1_tip, 0.8*e1_tip);

revolution earth = sphere(r_earth);
real opacity_sat = 1;


draw(surface(earth),lightblue);

draw(n1,Arrow3(DefaultHead3));
draw(n2,Arrow3(DefaultHead3));
draw(n3,Arrow3(DefaultHead3));

draw(O--e1_tip,lightblue,Arrow3(DefaultHead3));
draw(O--e2_tip,lightblue,Arrow3(DefaultHead3));
draw(O--n3_tip,lightblue,Arrow3(DefaultHead3));


draw(b1,grey,Arrow3(DefaultHead3));
draw(b2,grey,Arrow3(DefaultHead3));
draw(b3,grey,Arrow3(DefaultHead3));

draw(u_TS, deepgreen, Arrow3(DefaultHead3));
draw(target -- orbit * O, dashed + deepgreen);
draw(gamma_arc,lightblue,Arrow3(DefaultHead3));


draw(surface(face1),grey + opacity(opacity_sat));
draw(surface(face2),grey + opacity(opacity_sat));
draw(surface(face3),grey + opacity(opacity_sat));
draw(surface(face4),grey + opacity(opacity_sat));
draw(surface(face5),grey + opacity(opacity_sat));
draw(surface(face6),grey + opacity(opacity_sat));

draw(surface(solar_array_1_surf),grey );
draw(surface(solar_array_2_surf),grey);


label("$\hat{u}_{TH}$", target + 0.4*u_TS_dir , N,deepgreen);
label("$\gamma t$", gamma_arc, N,lightblue);


label("$\hat{\imath}_x$", n1_tip, NW);
label("$\hat{\imath}_y$", n2_tip, SE);
label("$\hat{\imath}_z$", n3_tip, E);

label("$\hat{e}_1$", e1_tip, E,lightblue);
label("$\hat{e}_2$", e2_tip, SE,lightblue);
label("$\hat{e}_3$", n3_tip, W,lightblue);


label("$\hat{b}_1$", orbit*(b1_tip), W, grey);
label("$\hat{b}_2$", orbit*(b2_tip), N, grey);
label("$\hat{b}_3$", orbit*(b3_tip), W, grey);




dot("N",O,2S);
dot("H",orbit*O,5SE);
dot("T",target,2SE);


