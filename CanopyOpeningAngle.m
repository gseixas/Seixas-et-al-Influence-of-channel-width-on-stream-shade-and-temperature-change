function [canAng,canAngTarg,canW,LidH,bankHeight] = CanopyOpeningAngle(DEM,diffTrans,x,y,thalX,thalY, ...
    BFW,matureHeightCon,matureHeightDec,shadeThresh)

%Code to extract canopy opening angle, tree height, and canopy opening
%width from a transect perpendicular to the channel.
% x and y are the coordinates of the diffTrans transect. thalX and thalY are
% the coordinates of the current channel thalweg (center of full transect).

% Copyright Gustav Seixas 2016

%get elevation of thalweg
[it,jt] = XY2IJ(thalX,thalY,DEM);
indt = sub2ind(size(DEM.grid),it,jt);
thalZ = DEM.grid(indt);

idx = find(diffTrans >= shadeThresh);

if numel(idx) >= 1 && isnan(all(idx)) == 0
    
    dx = x(idx(1)) - thalX; dy = y(idx(1)) - thalY; %use the first cell that exceeds the threshold for shade.
    firstPeak = sqrt(dx.^2 + dy.^2);
    
    %get elevation at first peak
    [ip,jp] = XY2IJ(x(idx(1)),y(idx(1)),DEM);
    indp = sub2ind(size(DEM.grid),ip,jp);
    zo = DEM.grid(indp);
    
    bankHeight = zo - thalZ; 
    if bankHeight < 0
        bankHeight = 0;
    end
    
    canAng = (pi/2) - abs(atan((diffTrans(idx(1))+bankHeight)/firstPeak));
    
    if BFW <= 20
        canAngTarg = (pi/2) - abs(atan((matureHeightCon+bankHeight)/firstPeak));
    else
        canAngTarg = (pi/2) - abs(atan((matureHeightDec+bankHeight)/firstPeak));
    end
    
    LidH = diffTrans(idx(1));
    canW = firstPeak;
    
    
else
    
    canW = BFW/2;      
    
    %get elevation at bankfull width
    dx = x - thalX; dy = y - thalY;
    Lb = sqrt(dx.^2 + dy.^2);
    idxb = find(Lb >= canW,1);
    xb = x(idxb);
    yb = y(idxb);
    
    [ip,jp] = XY2IJ(xb,yb,DEM);
    indp = sub2ind(size(DEM.grid),ip,jp);
    zo = DEM.grid(indp);
    bankHeight = zo - thalZ;    
    if bankHeight < 0
        bankHeight = 0;
    end    
    
    canAng = (pi/2) - abs(atan(bankHeight/canW)); %canopy angle formed by topography, no veg.
  
    
    if BFW <= 20
        canAngTarg = (pi/2) - abs(atan((matureHeightCon+bankHeight)/(BFW/2))); %mean channel width in Chehalis basin is 30m
    else
        canAngTarg = (pi/2) - abs(atan((matureHeightDec+bankHeight)/(BFW/2))); %mean channel width in Chehalis basin is 30m;
    end
    
    LidH = 0;
end
