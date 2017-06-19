function x=mutate(x)


n = size(x,2);

%i = unifrnd(0,n, 1);
i = randi(n);

r = 0.05*randn();

x(i) = x(i) + r;

if x(i) < 0
    x(i) = 0;
    %x(i) = unifrnd(0,1,1);
elseif x(i) > 1
    x(i) = 1;
    %x(i) = unifrnd(0,1,1);
end

%x = x + r;

end