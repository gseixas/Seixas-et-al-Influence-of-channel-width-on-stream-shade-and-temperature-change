function [X,Y] = SearchDownFlowDirection(fd,xo,yo)
%This function searches down the flow direction grid starting from a 
%specified channel head using the D8 method. function uses ArcInfo flow 
%routing convention (base 2 starting at East
%and proceeding clockwise).

%Copyright Gustav Seixas 2014.


%Find subscripts for initial position
[i,j] = XY2IJ(xo,yo,fd);

inew = i;
jnew = j;

forever = 1;
while forever == 1
    
    [x,y] = IJ2XY(inew,jnew,fd);
    
    if inew == 0 || jnew == 0 || y > max(fd.y) || x > max(fd.x)
        i = i(1:end-1); %condition to exclude last point (zero/max)
        j = j(1:end-1);
        break
    end
    

    if fd.grid(inew,jnew) == 1
       jnew = jnew + 1;
    
    elseif fd.grid(inew,jnew) == 2
        jnew = jnew + 1;
        inew = inew - 1;
    
    elseif fd.grid(inew,jnew) == 4
        inew = inew - 1;       
    
    elseif fd.grid(inew,jnew) == 8
        inew = inew - 1;
        jnew = jnew - 1;
    
    elseif fd.grid(inew,jnew) == 16
        jnew = jnew - 1;
    
    elseif fd.grid(inew,jnew) == 32
        jnew = jnew - 1;
        inew = inew + 1;
    
    elseif fd.grid(inew,jnew) == 64
        inew = inew + 1;
    
    elseif fd.grid(inew,jnew) == 128
        inew = inew + 1;
        jnew = jnew + 1;
    
    else
        break %this condition should trigger when the edge of the grid has been reached
        
    end
    
    i = [i,inew];
    j = [j,jnew];
    

end


%convert back to x,y
[X,Y] = IJ2XY(i,j,fd);

