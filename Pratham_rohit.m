%To simulate energy generated in ideal attitude for some orbits
%RUN contants v15 pow and Si_120k,light_120k,SGP_120k before running this
%code
%for conviniece area and normal vectors are redefined
v_S=[v_S1',v_S2',v_S3',v_S4',v_S5',v_S6'];
Area=[Area_SP_S1,Area_SP_S2,Area_SP_S3,Area_SP_S4,Area_SP_S5,Area_SP_S6];
cosangle=[0,0,0,0,0,0]; %vector to store dot product between normal to solar vector
interval=0.1; %time in seconds
Energy=0.00; %variable to store Energy
%P=zeros(1,size(SGP_120k,2));
%totalpower=zeros(6,54000);
totalpower=zeros(1, 54000);
Energyplot=zeros(1,54000);
%for i=1:size(SGP_120k,2)
for i=1:54000
    r=SGP_120k(2:4,i);
    v=SGP_120k(5:7,i);
    normr=r/norm(r);
    normv=v/norm(v);
    z=-normr;
    y=cross(normv,normr);
    y=y/norm(y);
    x=cross(y,z);
    DCM_IO=[x,y,z]'; %Rotation matrix to convert inertial frame vector to orbit frame vector
    sunvector_I=Si_120k(2:4,i);
    sunvector_O=DCM_IO*sunvector_I;
    for side=1:6
        cosangle(side)=dot(sunvector_O,v_S(:,side));
        if (cosangle(side)<0)
            cosangle(side)=0;
        end
        P=efficiany_solar_cell*Solar_Constant*cosangle(side)*Area(side)*light_120k(2,i);
        Energy=Energy+(P*interval);
        Energyplot(i)=Energy;
        totalpower(i)=totalpower(i)+P;
    end 
    
end
Energy