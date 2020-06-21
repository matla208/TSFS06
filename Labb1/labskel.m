%% Lab skeleton for lab 1 in TSFS06: Linear residual generation

%% short description of the simulation model
% Variables saved in the workspace after simulation:
% t   time vector
% ref reference signal to the controller (not used here)
% y   measurement signals
% f   fault signals
% res residuals
% T   Thresholded residuals (with threshold 1)
%
% Variables from the workspace that is used in the simulation model:
% Fc     State-space model of the controller, computed in controllerdesign.m 
% Model parameters J1, J2, k, alpha1, alpha2, alpha3, alpha4
% Tfault Time of failure injection. Default: 25
% NP     Defines noise power. Default value: NP=0.00005
% R      State-space model for the residual generator.
%        Code for this is done by student in this file.
% Rseed  Random seed for noise generation

clear
%addpath /courses/TSFS06/polynomial/ % Linux

pinit

% Set the random seed
Rseed = floor(sum(100*clock));

% Define model constants. Make sure these are not overwritten in the code
% below. These values are used in the simulation model.
J1     = 1;
J2     = 0.5;
k      = 99/90;
alpha1 = 1;
alpha3 = 0.1;
alpha2 = 0.05;
alpha4 = 0.1;

% Define model matrices H, L, and F.
H = [J1*p^2 + alpha1*p 0 1; -alpha2-alpha3*p alpha2+alpha3*p 1;0 alpha4*p+J2*p^2 -1;-1 0 0;-p 0 0;0 -1 0];
L = [0 0 0 -k;0 0 0 0; 0 0 0 0;1 0 0 0;0 1 0 0;0 0 1 0];
F = [0 0 0 -k;0 0 0 0;0 0 0 0;-1 0 0 0;0 -1 0 0;0 0 -1 0];


%% Verify that the model is correctly formulated
% For this to work, make sure that the order of the signals in the z and f 
% vectors is correct.2
% z = (y1, y2, y3, u ) where y1, y2, and y3 are the sensors measuring
% theta1, theta1', and theta2
% f = (f1,f2,f3,f4)

lab1_modelcheck(H,L) % Verify that the nominal model is correct
lab1_modelcheck(H,L,F) % Verify that the model with faults is correct

%% Controller design
controllerdesign;

%% Noise power for simulating measurement noise
NP = 0.00005; % Set to 0 to simulate without noise
Tfault = 25;

%% Residual generator design
% Put your code here, name the residual generators R1, R2, etc.

% Put your code here, name the residual generators R1, R2, etc.

Hf1 = [H F(:,1)];
Nhf1 = null(Hf1.').';
Rr1 = Nhf1*L;
Hf2 = [H F(:,2)];
Nhf2 = null(Hf2.').';
Rr2 = Nhf2*L;
Hf3 = [H F(:,3)];
Nhf3 = null(Hf3.').';
Rr3 = Nhf3*L;
Hf4 = [H F(:,4)];
Nhf4 = null(Hf4.').';
Rr4 = Nhf4*L;
% normalize% Jn = [0.0311; 0.0331; 0.0156];% from dry run
% J2n = [0.0276; 0.0308 ;0.0166]+0.1;
% Rr1n = Rr1/J2n(1);
% Rr2n = Rr2/J2n(2);
% Rr3n = Rr3/J2n(3);
% Rr3n = Rr3/J2n(3);

%R1 = ss([0 0 0 0]); % Dummy residual generator
%R2 = ss([0 0 0 0]); % Dummy residual generator

% Collect all residual generators into one single state-space object.
% The object must be called R for the simulation model to work.
gamma1 = [0 1]; %scalar ty 2 decouplings
d1 = (0.001*p+1)^2; % lika stor som polynomet i r
gamma2 = [1 0]; %scalar ty 2 decouplings
d2 = (2.5*p+1)^2; % lika stor som polynomet i r
gamma3 = [1 1]; %scalar ty 2 decouplings
d3 = (100*p+1)^3; % lika stor som polynomet i r
gamma4 = [0 1]; %scalar ty 2 decouplings
d4 = (2*p+1)^2; % lika stor som polynomet i r
R1 = ss(gamma1*Rr1, d1);
R2 = ss(gamma2*Rr2, d2);
R3 = ss(gamma3*Rr3, d3);
R4 = ss(gamma4*Rr4, d4);
R = [R1;R2;R3;R4];
% rör ej
f1=0;
f2=0;
f3=0;
f4=0;
sim('TSFS06lab1');
Jn = max(abs(res))+0.01;% from dry run
%J2n = [0.0276; 0.0308 ;0.0166]+0.1;
Rr1n = Rr1/Jn(1);
Rr2n = Rr2/Jn(2);
Rr3n = Rr3/Jn(3);
Rr4n = Rr4/Jn(4);
R1 = ss(gamma1*Rr1n, d1);
R2 = ss(gamma2*Rr2n, d2);
R3 = ss(gamma3*Rr3n, d3);
R4 = ss(gamma4*Rr4n, d4);
R = [R1;R2;R3;R4];
%% Simulate
% Set fi=0 i=1,..,4 for the fault free case. Set auitable values for
% when faults are simulated.
f1=0;
f2=0;
f3=0;
f4=0;

% Simulation is started either by choosing the menu
% Simulation->Start in the Simulink window of by executing the code below
sim('TSFS06lab1');

%% Calculate the single fault diagnoses
% Define decision matrices for when residuals are over and under the
% thresholds respectively.
s0 = ones(4,5); % dummy exempel
s1 = [0 0 1 1 1;0 1 0 1 1;0 1 1 0 1;0 1 1 1 0]; % dummy exempel
%s1 = [1 0 1 1 0;1 1 0 1 0;1 1 1 0 0];
% Calculate the diagoses
[S,alarm] = decisioncalc(T,s0,s1);

%% Plota and evaluate
figure(100)
plot( t, y ) % Plot
ylabel('utsignaler')
xlabel('t')
legend('y_1','y_2','y_3','Location','SE')

figure(101)
subplot(211)
plot( t, res(:,1))
ylabel('residual 1')
xlabel('t')

subplot(212)
plot( t, res(:,2))
ylabel('residual 2')
xlabel('t')

figure(104)
subplot(211)
plot( t, res(:,3))
ylabel('residual 3')
xlabel('t')
subplot(212)
plot( t, res(:,4))
ylabel('residual 4')
xlabel('t')

figure(102)
plot( t, alarm)
title('alarm')
xlabel('t')

figure(103)
subplot(231)
plot(t,S(:,1));
ylabel('NF indicator');
xlabel('t')
axis([min(t) max(t) -0.3 1.3]);

subplot(232)
plot(t,S(:,2));
ylabel('F_1 indicator');
xlabel('t')
axis([min(t) max(t) -0.3 1.3]);

subplot(233)
plot(t,S(:,3));
ylabel('F_2 indicator');
xlabel('t')
axis([min(t) max(t) -0.3 1.3]);

subplot(234)
plot(t,S(:,4));
ylabel('F_3 indicator');
xlabel('t')
axis([min(t) max(t) -0.3 1.3]);

subplot(235)
plot(t,S(:,5));
ylabel('F_4 indicator');
xlabel('t')
axis([min(t) max(t) -0.3 1.3]);
