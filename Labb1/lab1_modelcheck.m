function r=lab1_modelcheck(H,L,F)
% LAB1_MODELCHECK  Verify that the model equations are correct
%
%   Syntax: r = lab1_modelcheck(H,L,F)
%
%   In:      H, L, F are the polynomial matrices in the model equations
%            H(s)x + L(s)z + F(s)f=0
%         
%            The argument for F is not required, i.e., if only matrices
%            H and L are used, only the fault-free model is tested.
%
%            Important note: FFor this command to work, the z and f vectors
%            must be ordered as in the lab text.
%
%            z = (y1, y2, y3, u) where y1=motor angle, y2,
%            motor angular velocity, y3=angle at wheel, u
%            torque fot the DC servo.
%
%            f = (f1,f2,f3,f4), where f1-f3 are sensor faults for sensors 
%            y1 to y3 and f4 is a fault in the actuator.
%
%   Out:     r is 1 if the model is OK and 0 if it is not.
%
