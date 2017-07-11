function [i,j] = BresenhamLine(DEMsize,io,jo,i1,j1)
%This function uses Bresenham's line algorithm to return the i,j
%subscript values of a line through a matrix given input subscripts of the
%endpoints. 

% Written by Gus Seixas 2016.

if i1 <= 0
    i1 = 1;
end
if j1 <= 0
    j1 = 1;
end

if i1 > DEMsize(1)
    i1 = DEMsize(1);
end

if j1 > DEMsize(2)
    j1 = DEMsize(2);
end


slope = ((i1 - io) / (j1 - jo));

if abs(slope) < 1
    
    if j1 > jo
        
        j = jo:j1;
                
        c = 1;
        while j(c) <= j1
            
            
            i(c) = round(slope * (j(c) - jo) + io); %rounding ensures i index gets assigned to nearest integer
                                    
            c = c + 1;
            if c > length(j)
                break
            end
            
        end
        
    else
        j = abs(-(j1:jo));
        
        slope = ((i1 - io) / (jo - j1));

        c = 1;
        while j(c) <= jo
            
            i(c) = round(slope * (j(c) - j1) + io); %rounding ensures i index gets assigned to nearest integer         
            
            c = c + 1;
            if c > length(j)
                break
            end
            
        end

        j = fliplr(j);
    end
    
else
    
    if io < i1
        
        slope = ((j1 - jo) / (i1 - io));
            
        i = io:i1;
        
        c = 1;
        while i(c) <= i1

            j(c) = round(slope * (i(c) - io) + jo); %rounding ensures i index gets assigned to nearest integer
           
            c = c + 1;
            if c > length(i)
                break
            end
            
        end
    
    else
        i = abs(-(i1:io));
        
        slope = ((j1 - jo) / (io - i1));

        c = 1;
        while i(c) <= io
                        
            j(c) = round(slope * (i(c) - i1) + jo); %rounding ensures i index gets assigned to nearest integer
      
            c = c + 1;
            if c > length(i)
                break
            end
            
        end

        i = fliplr(i);
    end
end
