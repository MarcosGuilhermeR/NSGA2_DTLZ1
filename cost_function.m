function [y] = cost_funcion (x)


CostFunction=@(x) dtlz1(x);      % Cost Function

y = CostFunction (x);
y = y';
end