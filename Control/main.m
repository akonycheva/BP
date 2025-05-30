m0 = 2; m1 = 0.5; L = 0.5; g = 9.81; r = 0.1;
Kt = 1; Ke = 0.2; R = 0.5; Lm = 0.2; B = 0.1;


Aa = [0 1 0 0 0;
     0 -B/(m0*r^2) g*m1/m0 0 Kt/(m0*r);
     0 0 0 1 0;
     0 B/(m0*L*r^2) -g*(m0+m1)/(m0*L) 0 -Kt/(m0*L*r);
     0 -Ke/(r*Lm) 0 0 -R/Lm];

Bb = [0; 0; 0; 0; 1/Lm];
Cc = [1 0 0 0 0];
Dd = 0;

Aa = [0 1 0 0 0;
      0 -5 2.4525 0 5;
      0 0 0 1 0;
      0 10 -24.525 0 -10;
      0 -10 0 0 -2.5];
Bb = [0; 0; 0; 0; 5];

a = 2.5 / 3;
Kp_theta = -(a^3 + 61.3125) / 50;
Kd_theta = -(3*a^2 + 24.525) / 50;

K_theta = [0 0 Kp_theta Kd_theta 0];
A_closed_theta = Aa - Bb * K_theta;
poles_theta = eig(A_closed_theta);

Q = diag([0.000008, 20, 1, 20, 5]);
R = 2;
Q1 = diag([200000, 500000, 1, 80000, 1]);
R1 = 1;

K = lqr(Aa, Bb, Q, R);
K1 = lqr(Aa, Bb, Q1, R1);
A_closed = Aa - Bb * K;
inv_A_closed = inv(A_closed);
C_times_invA_times_B = Cc * inv_A_closed * Bb;
N = -1 / C_times_invA_times_B;
disp(['N = ', num2str(N)]);

K = place(Aa, Bb, poles_theta);
kin = -1 / (Cc * inv(Aa - Bb * K) * Bb);

