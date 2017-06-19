function [y] = cost_funcion (x)


CostFunction=@(x) parabolas(x);      % Cost Function

y = CostFunction (x);

end