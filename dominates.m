function r = dominates( x, y )
    
    x=x.cost;
    y=y.cost;
    
    r = all(x<=y) && any(x<y);

end