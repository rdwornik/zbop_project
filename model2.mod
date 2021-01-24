set I;
set W;
set T;
set E;
set J;
set S{I}, within I;
set P{I}, within I;
set Ik{W}, within I;
set T0;
param h{i in I};
param s{i in I};
param f{i in I};
param b{i in I};
param l{i in I};
param a{i in I, j in I};
param o{i in I};
param c{k in W, t in T};
param d{i in I, t in T};
param M;
param IT0{i in I};

var X{i in I, t in T}, >= 0;
var Z{i in I, t in T}, binary;
var IT{i in I, t in T0};
var ITplus{i in I, t in T0}, >=0;
var ITminus{i in I, t in T0}, >= 0;
var PSI{i in I}, >= 0;

minimize canvas_number: sum{t in T}(sum{i in I}(h[i]*ITplus[i,t]+s[i]*ITminus[i,t]+f[i]*Z[i,t]));
subject to
one{i in I}: 
	IT[i,0] = IT0[i];
oneb{i in I}:
	ITplus[i,0] = IT0[i];
onec{i in I}:
	ITminus[i,0] = 0;
two{i in I, t in T}: 
	IT[i,t-1]+X[i,t]-IT[i,t]-sum{j in S[i]}(a[i,j]*X[j,t]) = d[i,t];
four{i in I, t in T}: 
	X[i,t] <= PSI[i]-IT[i,t-1];
five{k in W,t in T, i in Ik[k]}:
	X[i,t] <= (c[k,t]-sum{alpha in (Ik[k] diff {i})}(b[alpha]*X[alpha,t]+o[alpha]*Z[alpha,t])-o[i]*Z[i,t])/b[i];
ten{k in W, t in T, i in Ik[k]}:
	X[i,t] <= (c[k,t]-o[i])*Z[i,t]/b[i];
eleven{i in I, t in T}:
	IT[i,t] = ITplus[i,t]-ITminus[i,t];