function [i,j] = XY2IJ(x,y,struct)

dy = y - struct.yllcorner;
dx = x - struct.xllcorner;

i = round(dy ./ struct.dy)+1;
j = round(dx ./ struct.dx)+1;


