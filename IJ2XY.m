function [x,y] = IJ2XY(i,j,struct)

x = struct.xllcorner + (j-1).*struct.dx;
y = struct.yllcorner + (i-1).*struct.dy;


