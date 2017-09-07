function I = Trapez(x, y)
n = length(x);
I = 0;
%se iau cate 2 puncte consecutive si se aplica formula
for i = 1 : n - 1
	% h  se actualizeaza la fiecare pas
	h = x(i) - x(i + 1);
	%se verifica daca avem 2 abscise consecutive egale
	if h != 0
		I = I + (y(i) + y(i + 1)) * (h / 2);
	endif
endfor
endfunction

