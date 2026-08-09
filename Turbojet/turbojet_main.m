%constants
gamma = 1.4;
gamma_h = 1.33;
cp_a = 1.005;
cp_h = 1.156;
T_inf = 300;
P_inf = 101.325;
Qr = 43150;
R = 0.287;
pe_c = 0.9;
pe_t = 0.87;
me = 0.97;

format short;
%Operating Conditions
Ma_inf = linspace(0.1,1.2);
pi_c = 11;
T04 = 1400;
m_inf = 80;
A9 = 0.214;
%Diffuser/Intake: inf - 02
[T02,P02] = diffuser(T_inf,P_inf,gamma,Ma_inf);

% Compressor: 02 - 03
[T03,P03] = compressor(T02,P02,pi_c,gamma,pe_c);

%Combustion Chamber: 03 - 04
[m_f,f] = combustor(T03,T04,Qr,cp_a,cp_h,m_inf);

%Turbine: 04 - 05
[T05,P05,W_T] = turbine(T02,T03,T04,cp_a,cp_h,f,m_inf,P03,gamma_h,pe_t,me);

%Nozzle: 05 - 06
[T06, P06, V_e] = nozzle(gamma_h, T05, P05, R, P_inf, cp_h);

%Performance Parameters
[T, TSFC, Sp_T, eta_p, eta_th, eta_o] = performance(m_inf, f, V_e, Ma_inf, gamma, R, T_inf, P06, P_inf, A9, Qr);

figure;
subplot(2,3,1); plot(Ma_inf, T, 'r-'); title('Thrust'); xlabel('Ma_{\infty}'); ylabel('N');
subplot(2,3,2); plot(Ma_inf, TSFC.*1000, 'b-'); title('TSFC'); xlabel('Ma_{\infty}'); ylabel('g/N/s');
subplot(2,3,3); plot(Ma_inf, Sp_T, 'g-'); title('Specific Thrust'); xlabel('Ma_{\infty}'); ylabel('N/kg/s');
subplot(2,3,4); plot(Ma_inf, eta_p.*100, 'm-'); title('Propulsive Efficiency'); xlabel('Ma_{\infty}'); ylabel('%');
subplot(2,3,5); plot(Ma_inf, eta_th.*100, 'c-'); title('Thermal Efficiency'); xlabel('Ma_{\infty}'); ylabel('%');
subplot(2,3,6); plot(Ma_inf, eta_o.*100, 'w-'); title('Overall Efficiency'); xlabel('Ma_{\infty}'); ylabel('%');
sgtitle('Turbojet Performance vs. Flight Mach Number (\pi_c = 11, T_{04} = 1400 K)');
