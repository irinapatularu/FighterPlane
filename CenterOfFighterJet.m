function CenterOfFighterJet(cale)

%se stabileste daca este data bine calea
if cale(length(cale)) != '/'
	cale = strcat(cale, '/');
endif

%coordonatele centroidului:
%se deschide fisierul
fisier = strcat(cale, "contur.in");
fid = fopen(fisier, "r");
%se initializeaza vectorii ce retin coordonatele
x = zeros(0);
y = zeros(0);
%citim pana la sfarsitul fisierului
while !feof(fid)
	%citim abscisa si o stocam in vectorul x
	a = fscanf(fid, "%f", 1);
	x = [x a];
	%citim ordonata si o stocam in vectorul y
	b = fscanf(fid, "%f", 1);
	y = [y b];
endwhile
%calculam coordonatele centrului de greutate
[x0, y0] = CentroidOfSurface(x, y);
printf("%.3f %.3f\n", x0, y0);
fclose(fid);

%ariile sectiunilor transversale
%initializare vectori ce retin ariile sectiunilor pentru ambele metode
trap = zeros(0);
simp = zeros(0);

%initializare vector in care se retine coordonata z pentru fiecare sectiune
zfin = zeros(0);

%initlializare vectori ce retin centrele de greutate ale sectiunilor
cgrx = zeros(0);
cgry = zeros(0);

%se iau pe rand fisierele pentru sectiuni
for i = '0' : '6'
	fisier = strcat(cale, "date", i, ".in");
	fid = fopen(fisier, "r");
	%se initlializeaza vectorii ce retin coordonatele
	x = zeros(0);
	y = zeros(0);
	z = zeros(0);
	%citim pana la sfarsitul fiecarui fisier
	while !feof(fid)
		%citim fiecare coordonata si o stocam in vectorul sau
		a = fscanf(fid, "%f", 1);
		b = fscanf(fid, "%f", 1);
		c = fscanf(fid, "%f", 1);
		x = [x a];
		y = [y b];
		z = [z c];
	endwhile
	%calculam aria sectiunii cu metoda trapezelor
	I1 = Trapez(x, y);

	%calculam aria sectiunii cu metoda Simpson
	I2 = Simpson(x, y);

	%calculam centrul de greutate al sectiunii
	[x0, y0] = CentroidOfSurface(x, y);

	%stocam datele in vectorii corespunzatori
	cgrx = [cgrx x0];
	cgry = [cgry y0];
	trap = [trap I1];
	simp = [simp I2];
	fclose(fid);
	
	%stocam si coordonata z, specifica acestei sectiuni
	zfin = [zfin z(1)];
endfor

%afisam ariile sectiunilor calculate cu metoda trapezelor
for i = 1 : length(trap)
	printf("%.3f ", trap(i));
endfor
printf("\n");

%afisam ariile sectiunilor calculate cu metoda Simpson
for i = 1 : length(simp)
	printf("%.3f ", simp(i));
endfor
printf("\n");

%volumul avionului
[vfinal volume] = volum(trap, zfin);

%masa avion
%se initializeaza masa finala si vectorul de mase
mase = zeros(0);
mfinal = 0;
fis = strcat(cale, "densitati.in");
fid = fopen(fis, "r");
%se citesc densitatile medii
for i = 1 : length(volume)
	d = fscanf(fid, "%f", 1);
	%se calculeaza masa volumului dintre 2 sectiuni consecutive
	m = d * volume(i);
	mase = [mase m];
	%se adauga la masa finala
	mfinal += m;
endfor
fclose(fid);
printf("%.3f %.3f\n", mfinal,vfinal);

%centrul de masa
[xmass ymass zmass]=mass(cgrx, cgry, zfin, mase);
%se imparte la masa finala
xmass = xmass / mfinal;
ymass = ymass / mfinal;
zmass = zmass / mfinal;
printf("%.3f %.3f %.3f\n", xmass, ymass, zmass);

endfunction
