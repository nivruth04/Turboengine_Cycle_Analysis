function [T, TSFC, Sp_T, eta_p, eta_th, eta_o] = performance(m_inf, f, V_e, Ma_inf, gamma, R, T_inf, P06, P_inf, A9, Qr);
% Freestream velocity
V_inf = Ma_inf * sqrt(gamma * 1000 * R * T_inf);

% Thrust
T = m_inf .* ((1 + f) .* V_e - V_inf) + (P06 - P_inf) .* A9;

% TSFC
TSFC = (m_inf .* f) ./ T;

% Specific Thrust
Sp_T = T ./ m_inf;

% Propulsive Efficiency
eta_p = (2 .* V_inf) ./ (V_e + V_inf);

% Thermal Efficiency
eta_th = ((1 + f) .* V_e.^2 - V_inf.^2) ./ (2000 .* f .* Qr);

% Overall Efficiency
eta_o = eta_p .* eta_th;

end