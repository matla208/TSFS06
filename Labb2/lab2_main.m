%% *** TSFS06 Laboration 2 Skeleton main file: Diagnosis of Purge System ***
clc
clear
close all

%% *** Data Loading ***
load diagnosisFile.mat

%% *** Plot data ***
d = diagnosisSequences.F00;

figure(1);
plot( d.time, d.y);

figure(2);
plot( d.time, d.D);
hold on;
plot( d.time, d.P,'r');
legend('Diagnosis valve position','Purge valve position');
%%finding index script

%% *** Set index intervals for all datasets
f00d =diagseqidx(diagnosisSequences.F00)
diagnosisSequences.F00.biasIdx  = [952 1011]; %(Samples [start end] for bias estimation) % D open P closed
diagnosisSequences.F00.diagIdx  = [239 904]; %(Samples [start end] for diagnosis sequence 1)
diagnosisSequences.F00.diagIdx2 = [1331 2014]; %(Samples [start end] for diagnosis sequence 2)

% f10d =diagseqidx(diagnosisSequences.F10)
diagnosisSequences.F10.biasIdx  = [1 76];
diagnosisSequences.F10.diagIdx  = [476 1021];
diagnosisSequences.F10.diagIdx2 = [1583 2193];

% f35d =diagseqidx(diagnosisSequences.F35)
diagnosisSequences.F35.biasIdx  = [1 206];
diagnosisSequences.F35.diagIdx  = [891 999];
diagnosisSequences.F35.diagIdx2 = [1737 1830];

diagnosisSequences.F50.biasIdx  = [955 1500];
diagnosisSequences.F50.diagIdx  = [782 820];
diagnosisSequences.F50.diagIdx2 = [1938 1975];

f05d =diagseqidx(diagnosisSequences.F05)
diagnosisSequences.F05.biasIdx  = [9132 10000];
diagnosisSequences.F05.diagIdx  = [1680 8654];

fxxd =diagseqidx(diagnosisSequences.Fxx)
diagnosisSequences.Fxx.biasIdx  = [1 993];
diagnosisSequences.Fxx.diagIdx  = [1733 8688];

%% *** Detection results ***
pfa  = 0.01; % Probability of false alarm

d = diagnosisSequences.F00;
res00a  = Leakage_test( d, d.biasIdx, d.diagIdx, pfa)  ;
res00b  = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa) ;

d = diagnosisSequences.F05;
res05  = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;

d = diagnosisSequences.F10;
res10a = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;
res10b = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa);

d = diagnosisSequences.F35;
res35a = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;
res35b = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa);

d = diagnosisSequences.F50;
res50a = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;
res50b = Leakage_test( d, d.biasIdx, d.diagIdx2, pfa);

d = diagnosisSequences.Fxx;
resxx  = Leakage_test( d, d.biasIdx, d.diagIdx, pfa) ;

%% *** Assumptions validation
clf;

figure(3)
sgtitle('F00')
subplot(2,2,1);
normplot(res00a.R)
title('Normal Probability Plot of case A')
subplot(2,2,2);
normplot(res00b.R)
title('Normal Probability Plot of case B')
subplot(2,2,3);
plot(xcorr(res00a.R))
title('Normalized covariance function of case A')
subplot(2,2,4);
plot(xcorr(res00b.R))
title('Normalized covariance function of case B')


figure(4)
sgtitle('F10')
subplot(2,2,1);
normplot(res10a.R)
title('Normal Probability Plot of case A')
subplot(2,2,2);
normplot(res10b.R)
title('Normal Probability Plot of case B')
subplot(2,2,3);
plot(xcorr(res10a.R))
title('Normalized covariance function of case A')
subplot(2,2,4);
plot(xcorr(res10b.R))
title('Normalized covariance function of case B')

figure(5)
sgtitle('F35')
subplot(2,2,1);
normplot(res35a.R)
title('Normal Probability Plot of case A')
subplot(2,2,2);
normplot(res35b.R)
title('Normal Probability Plot of case B')
subplot(2,2,3);
plot(xcorr(res35a.R))
title('Normalized covariance function of case A')
subplot(2,2,4);
plot(xcorr(res35b.R))
title('Normalized covariance function of case B')

figure(6)
subplot(2,2,1);
sgtitle('F50')
normplot(res50a.R)
title('Normal Probability Plot of case A')
subplot(2,2,2);
normplot(res50b.R)
title('Normal Probability Plot of case B')
subplot(2,2,3);
plot(xcorr(res50a.R))
title('Normalized covariance function of case A')
subplot(2,2,4);
plot(xcorr(res50b.R))
title('Normalized covariance function of case B')

figure(7)
sgtitle('F05')
subplot(2,1,1);
normplot(res05.R)
title('Normal Probability Plot of case A')
subplot(2,1,2);
plot(xcorr(res05.R))
title('Normalized covariance function of case A')

figure(8)
sgtitle('Fxx')
subplot(2,1,1);
normplot(resxx.R)
title('Normal Probability Plot of case A')
subplot(2,1,2);
plot(xcorr(resxx.R))
title('Normalized covariance function of case A')
%% test alarms 
alarm00 = [res00a.T/res00a.J res00b.T/res00b.J] 
alarm10 = [res10a.T/res10a.J res10b.T/res10b.J]
alarm35 = [res35a.T/res35a.J res35b.T/res35b.J]
alarm50 = [res50a.T/res50a.J res50b.T/res50b.J]
alarm05 = [res05.T]/res05.J ] 
alarmxx = [resxx.T/resxx.J ]

format longg
T = [res00a.T res00b.T res10a.T res10b.T res35a.T res35b.T res50a.T...
    res50b.T res05.T resxx.T]'
    
J = [res00a.J res00b.J res10a.J res10b.J res35a.J res35b.J res50a.J...
    res50b.J res05.J resxx.J]'


alarm = [alarm00 alarm10 alarm35 alarm50 alarm05 ]
FT = [ 0 0 10 10 35 35 50 50 5 ]*10^-4;
plot(FT,alarm,'r*')
yline(1)
%% excercise 2 
K2 = [ res05.k2 res10a.k2 res10b.k2 res35a.k2 res35b.k2 res50a.k2 res50b.k2]

FL = [ 5 10 10 35 35 50 50 ]*10^-4;
FD = FL.^2*pi/4

C = Fd.\K2


