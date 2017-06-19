function igd = calculate_IGD (z, a)
    
    soma = 0;
    
    b = a;
    
    [n, ~] = size(z);
    
    for i=1: n
        menor = inf;
        pos = -1;
        
        
        [n2, ~] = size(b);
        for j=1: n2
            d = euclidean_distance(z(i,:), b(j,:));
            
            if d < menor
                menor = d;
                pos = j;
            end
        end
        
        b(pos,:) = [];
        soma = soma + menor;
    end
    igd = soma/n;
end


function dist = euclidean_distance(p1, p2)

    dist = sqrt(sum((p1 - p2).^ 2));
end