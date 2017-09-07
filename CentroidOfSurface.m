function [x0, y0] = CentroidOfSurface(x, y)
n = length(x);

%calculam aria sectiunii determinata de punctele din x si y
A = Trapez(x, y);
x0 = 0;
y0 = 0;
for i = 1 : n - 1
	x0 = x0 + (x(i) + x(i + 1)) * (x(i) * y(i + 1)-  x(i + 1) * y(i));
	y0 = y0 + (y(i) + y(i + 1)) * (x(i) * y(i + 1) - x(i + 1) * y(i));
endfor

%se verifica daca aria este 0, impartirea nemaiavand sens in acest caz
if A == 0
	x0 = x(1);
	y0 = y(1);
else
	x0 = x0 / (6 * A);
	y0 = y0 / (6 * A);
endif
endfunction
