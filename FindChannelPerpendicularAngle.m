function [ang chandist] = FindChannelPerpendicularAngle(X,Y,Xo,Yo,chandist)

%X and Y is the channel point where data is to be extracted. Xo and Yo
%are the original channel points (all pixels in channel).

%convert to column vector if necessary
if size(Xo,2) > 1
    Xo = Xo';
    Yo = Yo';
end

ind = ismember([Xo Yo],[X Y],'rows');
ind2 = find(ind == 1);

while ind2+chandist > length(Xo) || ind2-chandist < 1
    chandist = chandist - 1;
end

A = [X Y];
B = [Xo(ind2+chandist) Yo(ind2+chandist)];
C = [Xo(ind2-chandist) Yo(ind2-chandist)];

AB = B - A;
AC = C - A;

%vector lengths:
LAB = norm(AB);
LAC = norm(AC);

%unit vectors
ABu = AB./LAB;
ACu = AC./LAC;

bisVec = ((ABu + ACu)./2) + A;

%condition where bisecting point is identical to current channel point
if sum(bisVec - A) == 0
    bisVec = [-ABu(2) ABu(1)] + A;
end

ang = atan((bisVec(2)-Y)/(bisVec(1)-X));

