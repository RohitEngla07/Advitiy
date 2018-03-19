%% This is the input file for the PRATHAM ADCS simulations.
% run this file before running the SIMULINK model.

% NEEDS THE FOLLOWING FILES:
    % euler_to_rotmatrix.m
    % rotmatrix_to_quaternion.m
    % rotate_x.m
    % rotate_y.m
    % rotate_z.m
    % sh2010.mat
    % light_calc.m
    % sun_calc.m
    % euler2qBI.m

% THE FOLLOWING MAT FILES NEED TO BE SAVED BEFORE SIMULATING:
    % Bi_120k.mat
    % Bi8_est_120k.mat
    % SGP_120k.mat
    % SGP_est_120k.mat     %%% run precalc.m to calculate upto here
    % light_120k.mat       %%% run light_calc.m to generate this file
    % Si_120k.mat          %%% run sun_calc.m to generate this file
    

%% CHECK THESE ALWAYS
% Date and time
% 00erance values
% Initial angular rates and euler angles
% Moment of inertia
% v_COM_to_COP_b 
% Rest all values are pretty much constant

clear;
clc;
close all;
%% SUN SENSORS
% Solar panel positions
v_S1  = [1 0 0];    %Lead
v_S2  = [-1 0 0];   %Lag
v_S3  = [0 1 0];    %antisun
v_S4  = [0 -1 0];   %sun
v_S5  = [0 0 1];    %nadir
v_S6  = [0 0 -1];   %zenith

efficiany_solar_cell = 0.27;
Solar_Constant = 1362;

Area_SP_S1 = 0.0144;%4*11*0.02025*0.04025; % Areas on side S1, in m^2 %leading
Area_SP_S2 = 0.0144;%4*11*0.02025*0.04025; % Areas on side S2, in m^2 %lagging
Area_SP_S3 = 0.0144; % Areas on side S3, in m^2 %antisunside
Area_SP_S4 = 0.0144;%4*11*0.02025*0.04025; % Areas on side S4, in m^2 %sunside
Area_SP_S5 = 0.0; % Areas on side S5, in m^2 %nadir
Area_SP_S6 = 0.0064;%3*11*0.02025*0.04025; % Areas on side S6, in m^2 %zenith

% efficiany_solar_cell = 0.27; % percentage
% eclipse_time = T_ORBIT*0.4;  % approximated value, we don't need correct one.
fprintf('Constants done \n')
%% END OF FILE %% 
