function [xmass ymass zmass]=mass(cgrx, cgry, zfin, mase)
%calculam centrul de greutate pt fiecare sectiune transversala

%initializam cordonatele centrelor de masa
xmass = 0;
ymass = 0;
zmass = 0;

%se elimina prima componenta care corespunde primei suprafete(care e de fapt 1 punct)
cgrx = cgrx(2 : length(cgrx));
cgry = cgry(2 : length(cgry));

%se face o medie ponderata a centrlor de greutate ale sectiunilor
%cu ponderile masele volumelor cuprinse intre 2 sectiuni consecutive
for i = 1 : length(cgrx)
	xmass = xmass + mase(i) * cgrx(i);
	ymass = ymass + mase(i) * cgry(i);
	%pentru z se vor considera valorile pentru fiecare sectiune
	zmass = zmass + mase(i) * zfin(i + 1);
endfor
endfunction
