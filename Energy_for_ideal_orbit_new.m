%This code calculates solar flux and power on each face assuming perfect
%control

load('SGP_120k');
load('Si_120k');
load('light_120k');
N = size(SGP_120k,2);
%for conviniece area and normal vectors are redefined
v_S = [v_S1',v_S2',v_S3',v_S4',v_S5',v_S6'];
Area = [Area_SP_S1,Area_SP_S2,Area_SP_S3,Area_SP_S4,Area_SP_S5,Area_SP_S6];
cosine = [0,0,0,0,0,0]; %vector to store dot product between normal and solar vector
interval = 0.1; %time in seconds
Energy = 0.00; %variable to store Energy
Energyplot = zeros(N,1);  %Energy generated on each side
Power_side = zeros(N,6);  %Power generated on each side
Intensity = zeros(N,6);
sunvector_O = zeros(4,N);
for i=1:N
    r = SGP_120k(2:4,i);    %position in ECI
    v = SGP_120k(5:7,i);    %velocity in ECI
    unit_r = r/norm(r);
    unit_v = v/norm(v);
    z = -unit_r;
    y = cross(unit_v,unit_r);
    y = y/norm(y);
    x = cross(y,z);
    DCM_IO = [x,y,z]'; %Rotation matrix to convert inertial frame vector to orbit frame vector
    sunvector_I=Si_120k(2:4,i);
    sunvector_O(2:4) = DCM_IO*sunvector_I;
    sunvector_O(1,i) = Si_120k(1,i);
    
    for side=1:6
        cosine(side) = dot(sunvector_O(2:4),v_S(:,side));
        if (cosine(side)<0)
            cosine(side)=0;
        else
        end
        Power_side(i,side)= efficiany_solar_cell*Area(side)*Solar_Constant*cosine(side)*light_120k(2,i);
        Intensity(i,side) = Solar_Constant*cosine(side)*light_120k(2,i);
        Energy = Energy+(Power_side(i,side)*interval);
        Energyplot(i)= Energy;
    end 
    
end
plot(Intensity) ;
legend('leading', 'lagging', 'antisun', 'sunside', 'nadir', 'zenith');
Energy;
fprintf('Energy_for_ideal_orbit done \n')