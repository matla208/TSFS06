% TASKS
clear all
close all
clc
run('labskel')
% excercise 6
Nh = null(H.').';

R = Nh*L

%% excercise 7
syms y1 y2 y3 u

%rr1 = 0.71*p*y1-0.71;
%rr2 = -0.0074*y1 +(-0.039 + 0.049*p+0.49*p^2)*y2 + 0.0074*y3 + (0.054-0.054p)*u

%% excercise 8-9
Hf = [H F(:,1)];
Nhf = null(Hf.').';
Nhf*L

% f1 kopplad till y1 och y1 nollad 

%%evaluate at zero
% atleast one element zero when s zero possible strong detectable
%% excercise 11
Nhf*F(:,1)
Hf2 = [H F(:,2)];
Nhf2 = null(Hf2.').';
Nhf2*F
Nh*F
% Vilket betyder att alla faults är strongly detectable 
%% excercise 12
%def iso om Rank H F1 F2 > Rank H F1  osv
% alla är isolerbara

% all residuals may give alarm excercise 14

%% excercise 13
% 0 1 0 0 1
% 0 0 1 0 1
% 0 0 0 1 1
% cant isolate multiple faults but can determine them
% 0 0 1 1 1
% 0 1 0 1 1
% 0 1 1 0 1
% 0 1 1 1 0
%% excercise 14
Hf1 = [H F(:,2) F(:,3)];
Nhf1 = null(Hf1.').';
Rr1 = Nhf1*L;
Hf2 = [H F(:,1) F(:,3)];
Nhf2 = null(Hf2.').';
Rr2 = Nhf2*L;
Hf3 = [H F(:,1) F(:,2)];
Nhf3 = null(Hf3.').';
Rr3 = Nhf3*L;


Rnew = [Rr1;Rr2;Rr3;Rr4];
%% excercise 15
% f1 and f3 is not strongly detectable
% 4 
%% excercise 16

gamma1 = [0 1]; %scalar ty 2 decouplings
d1 = p^2+1; % lika stor som polynomet i r
gamma2 = [1 0]; %scalar ty 2 decouplings
d2 = p^2+1; % lika stor som polynomet i r
gamma3 = [1 1]; %scalar ty 2 decouplings
d3 = p^3+1; % lika stor som polynomet i r
gamma4 = [0 1]; %scalar ty 2 decouplings
d4 = p^3+1; % lika stor som polynomet i r

R11 = ss(gamma1*Rr1, d1);
R12 = ss(gamma2*Rr2, d2);
R13 = ss(gamma3*Rr3, d3);
R14 = ss(gamma4*Rr4, d4);
Rnew1 = [R11;R12;R13;R14];
bode(R16)

%% excercise 17 
%yes kolla på B med 4 värden per svar

%% 18
Rr1n = Rr1/0.045;
Rr2n = Rr2/0.045;
Rr3n = Rr3/0.024;
% Put your code here, name the residual generators R1, R2, etc.
% Hf1 = [H F(:,2) F(:,3)];
% Nhf1 = null(Hf1.').';
% Rr1 = Nhf1*L;
% Hf2 = [H F(:,1) F(:,3)];
% Nhf2 = null(Hf2.').';
% Rr2 = Nhf2*L;
% Hf3 = [H F(:,1) F(:,2)];
% Nhf3 = null(Hf3.').';
% Rr3 = Nhf3*L;
% J = [2.6702  ;  1.9580 ;   3.1076]*1e12 % titta max av abs
%  Rr1n = Rr1/J(1);
%  Rr2n = Rr2/J(2);
%  Rr3n = Rr3/J(3);

% Hf1 = [H F(:,1)];
% Nhf1 = null(Hf1.').';
% Rr1 = Nhf1*L;
% Hf2 = [H F(:,2)];
% Nhf2 = null(Hf2.').';
% Rr2 = Nhf2*L;
% Hf3 = [H F(:,3)];
% Nhf3 = null(Hf3.').';
% Rr3 = Nhf3*L;
% Hf4 = [H F(:,4)];
% Nhf4 = null(Hf4.').';
% Rr4 = Nhf4*L;
% %J = [2.6702  ;  1.9580 ;   3.1076]*1e12 % titta max av abs
% %  Rr1n = Rr1/J(1);
% %  Rr2n = Rr2/J(2);
% %  Rr3n = Rr3/J(3);
% %  Rr4n =Rr4/J(4);
% 
% gamma1 = [0 1]; %scalar ty 2 decouplings
% d1 = (p+1)^2; % lika stor som polynomet i r
% gamma2 = [1 0]; %scalar ty 2 decouplings
% d2 = (p+1)^2; % lika stor som polynomet i r
% gamma3 = [1 1]; %scalar ty 2 decouplings
% d3 = (p+1)^3; % lika stor som polynomet i r
% gamma4 = [1 1]; %scalar ty 2 decouplings
% d4 = (p+1)^2; % lika stor som polynomet i r
% 
% R1 = ss(gamma1*Rr1, d1);
% R2 = ss(gamma2*Rr2, d2);
% R3 = ss(gamma3*Rr3, d3);
% R4 = ss(gamma4*Rr4, d4);