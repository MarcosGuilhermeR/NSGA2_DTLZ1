function [F, varargout] = dtlz1 (x, varargin)

x = x(:);

n = length(x); %n = nvar, x é um individuo
k = 5;

m = n - k + 1;  %nro de objetivos

s = 0;
for i = m:n
    s = s + (x(i)-0.5)^2 - cos(20*pi*(x(i)-0.5));
end
g = 100*(k+s);

f(1) = 0.5 * prod(x(1:m-1)) * (1+g);
for i = 2:m-1
    f(i) = 0.5 * prod(x(1:m-i)) * (1-x(m-i+1)) * (1+g);
end
f(m) = 0.5 * (1-x(1)) * (1+g);

F = f(:)';

varargout(1) = {F};
varargout(2) = {0};