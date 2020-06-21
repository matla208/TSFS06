% Controller design: lead-lag design
wcdes = 2;
phasem = 40;

% Define system matrices A, B, C, D and create a
% state-space object
Aservo = [0 1 0 0; ...
  -alpha2/J1 -(alpha1+alpha3)/J1 alpha2/J1 alpha3/J1; ...
  0 0 0 1; ...
  alpha2/J2 alpha3/J2 -alpha2/J2 -(alpha3+alpha4)/J2];
Bservo = [0; k/J1; 0; 0];
Cservo = [eye(3) zeros(3, 1)];
Dservo = zeros(3, 1);
Gservo = ss(Aservo, Bservo, Cservo, Dservo);
Gdes = Gservo(1, :);

% phaseadv = max(0,phasem-180-phase(evalfr(Gdes,i*wcdes))*180/pi);
phaseadv = max(0, phasem - 180 - ...
                  unwrap(angle(evalfr(Gdes, 1i*wcdes)))*180/pi);

if phaseadv > 0
    N = 1;
    while (atan(0.5*(sqrt(N) - 1/sqrt(N)))*180/pi < phaseadv)
        N = N + 0.05;
    end
    Fc = tf(N*[1 wcdes/sqrt(N)], [1 wcdes*sqrt(N)]);
else
    Fc = 1;
end

Fc = ss(1/abs(evalfr(Fc*Gdes, 1i*wcdes))*Fc);
