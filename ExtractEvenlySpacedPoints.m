function ind = ExtractEvenlySpacedPoints(Xo,Yo,dist)
%Pulls out points in Euclidean space that are spaced by a specified
%distance. The indices are returned of the first point to exceed the input
%distance.

% Copyright Gustav Seixas 2016

i = 1;
c = 1;
cumuL = 0;

while i < length(Xo)
    
    dx = Xo(i+1) - Xo(i);
    dy = Yo(i+1) - Yo(i);
    L = sqrt(dx^2 + dy^2);
    
    cumuL = cumuL + L;
    
    if cumuL >= dist
        ind(c) = i;
        c = c + 1;
        cumuL = 0;
    end
    
    i = i + 1;
    
end

if exist('ind','var') == 0
    ind = 0;
end