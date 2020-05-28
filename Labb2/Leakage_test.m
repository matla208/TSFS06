function res=Leakage_test( data, biasIdx, diagIdx, pfa)
% Leakage_test - Detect leakages in purge system
%
% Inputs: 
%   1) data     (Measured data)
%   2) biasIdx  (Samples [start end] for bias estimation)
%   3) diagIdx  (Samples [start end] for diagnosis sequence)
%   4) pfa,     (Probability of false alarm)
%
% Outputs:
%   res is a struct variable which includes:
%   1) T, (The test quantity)
%   2) J, (The threshold value)
%   3) R, (The residual vector)

  % Compute test quantity, threshold, and residual.
  % Write, and use, the three functions 
  % 1. EstimateBias()
  % 2. EstimateVariance()
  % 3. TQCalc()
   y = data.y;
   Ts = data.Ts;
   k1 = data.k1;
   
  bhat = EstimateBias(y,biasIdx);
  y_b = data.y(diagIdx(1):diagIdx(2)) - bhat;
 
  [theta1,s2] = EstimateVariance(y_b);
  k2 = Estimatek2(y_b,Ts);
  [theta T R J] = TQCalc(y_b,s2,pfa,k1,Ts);
%   T = 0;
%   J = 0;
%   R = 0;
  
  % Return results
  res.T = T;
  res.J = J;
  res.R = R;
  res.k2 = k2;
  res.theta = theta/Ts;
end


function bhat = EstimateBias(y,index)
  % Estimate bias
  bhat = mean(y(index(1):index(2)));
end

function [theta_est2,s2] = EstimateVariance(y)
  % Estimate variance
  Y2    = y(2:end);
  phi2  = [y(1:(end-1)) sqrt(-y(1:(end-1))) ones(length(y)-1,1)];
  theta_est2 = inv(phi2'*phi2)*phi2'*Y2;
  
  rt    = Y2 - phi2 * theta_est2 ;
  
  s2    = cov(rt);
  
end

function k2 = Estimatek2(y,Ts)
  % Estimate variance
  Y2    = y(2:end);
  phi2  = [y(1:(end-1)) sqrt(-y(1:(end-1))) ones(length(y)-1,1)];
  theta_est2 = inv(phi2'*phi2)*phi2'*Y2;
  k2 = theta_est2(2)/Ts;
  
end

function [theta_est,T, R, J] = TQCalc(y,s2,pfa,k1,Ts)
  % Compute test quantity, residual, and threshold
  phi = ones(length(y)-1,1);
  alpha = 1-Ts*k1;
  Y1    = y(2:end) - alpha*y(1:end-1);
  theta_est = phi\Y1;
%   theta_est = inv(phi'*phi)*phi'*Y1;
  
  R = Y1 - phi * theta_est;
  T = 1/s2*R'*R;
  J = chi2inv(1-pfa,length(y)-1);
end
