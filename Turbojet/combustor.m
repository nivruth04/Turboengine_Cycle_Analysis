function [m_f, f] = combustor(T03, T04, Qr, cp_a, cp_h, m_inf)

f = (cp_h .* T04 - cp_a .* T03) ./ (Qr - cp_h .* T04);
m_f = f .* m_inf;

end