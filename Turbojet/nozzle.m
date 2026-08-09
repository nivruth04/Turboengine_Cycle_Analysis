function [T06, P06, V_e] = nozzle(gamma_h, T05, P05, R, P_inf, cp_h)

cr_p_r = ((gamma_h + 1) / 2)^(gamma_h / (gamma_h - 1));
T06 = zeros(size(P05));
P06 = zeros(size(P05));
V_e = zeros(size(P05));
for i = 1:length(P05)
    P_c_i = P05(i) / cr_p_r;
    if P05(i) >= cr_p_r * P_inf * 1.05  % choked with 5% margin
        P06(i) = P_c_i;
        T06(i) = T05(i) / ((gamma_h + 1) / 2);
        V_e(i) = sqrt(1000 * gamma_h * R * T06(i));
    else  % unchoked
        P06(i) = P_inf;
        T06(i) = T05(i) * (P06(i) / P05(i))^((gamma_h-1)/gamma_h);
        V_e(i) = sqrt(2000 * cp_h * (T05(i) - T06(i)));
    end
end
end