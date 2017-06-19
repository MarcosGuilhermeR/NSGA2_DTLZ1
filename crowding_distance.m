function pop=crowding_distance(pop,F)

    nF=numel(F);
    
    for k=1:nF
        
        Costs=[pop(F{k}).cost];
        
        nObj=size(Costs,1);
        
        n=numel(F{k});
        
        d=zeros(n,nObj);
        
        for j=1:nObj
            
            [cj, so]=sort(Costs(j,:));
            
            d(so(1),j)=inf;
            
            for i=2:n-1
                
                d(so(i),j)=abs(cj(i+1)-cj(i-1))/abs(cj(1)-cj(end));
                
            end
            
            d(so(end),j)=inf;
            
        end
        
        
        for i=1:n
            
            pop(F{k}(i)).crowdingDistance=sum(d(i,:));
            
        end
        
    end


%     nF = numel(F);
%     
%     for k=1: nF
%         costs = [pop(F{k}).cost]';     
%         nobj = size(costs,2);
%         
%         nind = numel(F{k});
%         dist = zeros(nind,1);
%         
%         for j=1: nobj
%            %ordena pela coluna objetivo J
%            [c, pos] = sort(costs(:,j));
%            
%            
%            indMenor = pos(1);
%            dist(indMenor) =  dist(indMenor) + inf;
%            
%            for i=2: nind-1
%                indProximo = pos(i);
%                dist(indProximo) = dist(indProximo) + abs((c(i+1) - c(i-1))/(c(end)-c(1)));
%            end
%            
%            indMaior = pos(end);
%            dist(indMaior) =  dist(indMaior) + inf;
%         end
%         
%         %Atualiza Crowding Distance população
%         for i=1: nind
%            pop(F{k}(i)).crowdingDistance = dist(i);
%         end
%     end
end