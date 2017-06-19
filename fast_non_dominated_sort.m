function [pop, F] = fast_non_dominated_sort(pop)
    nPop = numel(pop);
    
    %inicializate var
    for i=1:nPop
        pop(i).dominationSet=[];
        pop(i).dominatedCount=0;
    end
    
    %Inicializate cell array
    F{1}=[];
    
    %NSGA Parte 1
    for i=1: nPop
       for j=i+1: nPop 
           p = pop(i);
           q = pop(j);
           
           if dominates(p, q)
               p.dominationSet = [p.dominationSet j];
               q.dominatedCount = q.dominatedCount + 1;
           elseif dominates(q, p)
               q.dominationSet = [q.dominationSet i];
               p.dominatedCount = p.dominatedCount + 1;
           end
           
           pop(i) = p;
           pop(j) = q;
       end
       
       if pop(i).dominatedCount == 0
           F{1} = [F{1} i]; %adiciona o índice daquele indivíduo na fronteira um
           pop(i).rank=1;
       end
    end
    
    %NSGA Parte 2
    k=1;
    
    while true
        
        Q=[];
        
        for i=F{k}
            p=pop(i);
            
            for j=p.dominationSet
                q=pop(j);
                
                q.dominatedCount=q.dominatedCount-1;
                
                if q.dominatedCount==0
                    Q=[Q j];
                    q.rank=k+1;
                end
                
                pop(j)=q;
            end
        end
        
        if isempty(Q)
            break;
        end
        
        k=k+1;
        F{k}=Q;

    end
    
end