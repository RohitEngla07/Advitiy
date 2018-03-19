tic
orbInc=  98.1290;   %inclination in degrees
meanMo = 14.62906131;   %revolutions per day
SGPdragp1 = 0.00000061;  % from ---First time derivative of mean motion(rad/min^2)
SGPdragp2 =0;     % Second time derivative of mean motion (rad/min^3
SGP4dragp = 8.8930; %Bstar
n0 = 2*pi*meanMo/1440; % Mean motion (rad/min) 
e0 = 0.0034102; % Eccentricity (0.0<=e0>=1.0)   
M0 = 332.6168*pi/180; % Mean anomaly (rad)    
w0 = 27.6840*pi/180;  % Argument of perigee (rad)  
Ohm0 = 138.8693; %RAAN
revNo = 7846;
i0 = pi*orbInc/180; % Inclination (rad) 
dn0 = 2*2*pi*SGPdragp1/(1440^2); % First time derivative of mean motion(rad/min^2)
ddn0 = 6*2*pi*SGPdragp2/(1440^3); % Second time derivative of mean motion (rad/min^3)
Bstar = SGP4dragp; % SGP4 type drag coefficient
t0 =0;
modTLE = [t0 dn0 ddn0 Bstar i0 Ohm0 e0 w0 M0 n0 revNo];
dT = 0:0.1:12e3; % in seconds 
[X, V] = sgp_new(modTLE, dT/60); 
toc
SGP_120k = [dT/60; X'; V'];
clear X V dT 
save SGP_120k.mat SGP_120k
