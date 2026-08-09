function [T03,P03] = compressor(T02,P02,pi_c,gamma,pe_c)
P03 = pi_c.*P02;
eta_c = (pi_c.^((gamma-1)/gamma) - 1) ./ (pi_c.^((gamma-1)/(gamma*pe_c)) - 1);
T03_ideal = T02*(pi_c).^((gamma-1)/gamma);
T03 = T02 + (T03_ideal - T02) ./ eta_c;
