import geometry;
import markers;
//import three;
size(15cm);

pair jupiter=(0,0);
pair P=(1,0);
real delta=4.75587;
real w = atan(-10.9537/-7.11344);
real f = atan(6.6941/56.6419) + pi/2;
real ex=1.09261;
real a=-10.7985;
real r(real theta) {return a*(1-ex^2)/(1+ex*cos((theta)*pi/180-f));}

transform rotp=rotate(f*180/pi,jupiter);
transform rota1=rotate(10,jupiter);
transform rota2=rotate(-5,jupiter);
transform rota3=rotate(-20,jupiter);
transform rota4=rotate(-50,jupiter);
point P0=rotp*(r(f*180/pi)*P);
point P1=rota1*(r(10)*P);
point P2=rota2*(r(-5)*P);
point P3=rota3*(r(-20)*P);
point P4=rota4*(r(-50)*P);
point arrival=(-6.09008/11.9985,10.338/11.9985);
conic orbith= conic(P0,P1,P2,P3,P4);

path ihat=(0,-4)--(2,-4);
path jhat=(0,-4)--(0,-2);

transform r7=rotate(147-180,(0,-4));
transform r8=rotate(147,(0,-4));
path tosun=r7*((0,-4)--(1,-4));
path vp=rotp*((1,0)--(1,3.5));
path orbit= circle(jupiter,1);
path Jplanet=circle(jupiter,0.877);
path vj=jupiter--(2.5*-7.11344/13.0608,2.5*-10.9537/13.0608);
line linearrival=line(jupiter,arrival);
line linep=line(rotp*(1,0),rotp*(1,3.5));
transform trans=shift(-10*arrival.x,-10*arrival.y);
transform aim=shift(delta*10.338/11.9985,delta*6.09008/11.9985);
path v=jupiter--arrival;
path vinfi=aim*(trans*v);
line linevinfi=line(aim*(trans*jupiter),aim*(trans*arrival));

draw(Jplanet,orange);
fill(Jplanet,orange);
draw(vinfi,Arrow);
draw(orbit);
draw(vj,Arrow);
draw(linearrival,dashed);
draw(linevinfi,dashed);
draw(vp,Arrow);
draw(orbith,red);
draw(ihat,Arrow);
draw(jhat,Arrow);
draw(tosun,Arrow);
draw((0,-4)--r8*(1,-4),dashed);
draw(linep,dashed);
pair M=(aim*jupiter);
pair ext=extension(rotp*(1,0),rotp*(1,3.5),M,aim*(trans*jupiter));

distance("$\Delta$",(trans*jupiter),aim*((trans*jupiter)),rotated=false,4mm);
label("$\overrightarrow{V}_{\infty\slash J,I}$",vinfi);
label("$\overrightarrow{V}_p$",vp);
label("$\overrightarrow{V}_{J\slash\odot}$",vj);
label("$\hat{i}$",ihat,2NE);
label("$\hat{j}$",jhat,2W);
label("To the sun",tosun);
markangle("$\theta$",5mm,(1,-4),(0,-4),r8*(1,-4));
markangle("$\frac{\delta '}{2}$",M,ext,rotp*(1,0));


dot(jupiter);
dot(aim*(trans*jupiter));
dot(rotp*P);

