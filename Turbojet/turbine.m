function [T05, P05, W_T] = turbine(T02, T03, T04, cp_a, cp_h, f, m_inf, P03, gamma_h,pe_t,me)
P04 = P03;
eta_t = 0.9;
T05_ideal = T04 - (cp_a .* (T03 - T02)) ./ ((1 + f) .* cp_h.*me); 
T05 = T04 - (T04 - T05_ideal) .* eta_t;
P05 = P04 .* (T05 ./ T04).^(gamma_h / (gamma_h - 1).*pe_t);

W_T = m_inf .* (1 + f) .* cp_h .* (T04 - T05);

end