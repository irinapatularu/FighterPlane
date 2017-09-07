function I = Simpson(x, y)
I = 0;
n = length(x);
%se vor lua cate 3 puncte pentru a aplica Simpson
for i = 1 : 2 : n - 2
	h = (x(i) - x(i + 2)) / 2;
	I = I + (y(i) + 4 * y(i + 1) + y(i + 2)) * (h / 3);
endfor

%daca avem un numar par de puncte, mar ramane o regiune necalculata
if mod(n,2) == 0
	%se actualizeaza h la fiecare pas
	h = x(i) - x(i + 1);
	I = I + (y(i) + y(i + 1)) * (h / 2);
endif
endfunction
