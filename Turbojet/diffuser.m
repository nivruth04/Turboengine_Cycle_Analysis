function [T02,P02] = diffuser(T_inf,P_inf,gamma,Ma_inf)
P02 = P_inf*( 1 + 0.5*(Ma_inf.^2)*(gamma-1)).^(gamma/(gamma-1));
T02 = T_inf*(1 + 0.5*(Ma_inf.^2)*(gamma-1));