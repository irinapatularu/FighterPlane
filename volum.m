function [vfinal volume]=volum(trap,zfin)
%luam ariile sectiunilor, 2 cate 2, le facem media si le inmultim cu distanta pe z

%initializam volumul final si vectorul de volume(pentru fiecare sectiune)
vfinal = 0;
volume = zeros(0);

%luam pe rand cate 2 sectiuni transversale consecutive
for i = 1 : length(trap) - 1
	%calculam aria medie a celor 2 sectiuni
	A = (trap(i) + trap(i + 1))/2;

	%calculam distanta intre cele 2 sectiuni
	dz = zfin(i + 1) - zfin(i);

	%se adauga la volumul total volumul aproximativ cuprins intre aceste sectiuni
	vfinal = vfinal + A * dz;

	%se retine volumul in vectorul corespunzator
	volume = [volume A * dz];
endfor
endfunction
