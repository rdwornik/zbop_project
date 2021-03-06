set I;
set W;
set T;
set S{I}, within I;
set P{I}, within I;
set Ik{W}, within I;
set T0;
param h{i in I};
param b{i in I};
param a{i in I, j in I};
param c{k in W, t in T};
param d{i in I, t in T};
param M;
param IT0{i in I};
var X{i in I, t in T}, >= 0;
var IT{i in I, t in T0}, >= 0;
var PSI{i in I}, >= 0;

minimize fun:sum{t in T}(sum{i in I}(h[i]*IT[i,t]));
subject to
one{i in I}: 
	IT[i,0] = IT0[i];
two{i in I, t in T}: 
	IT[i,t-1]+X[i,t]-IT[i,t]-sum{j in S[i]}(a[i,j]*X[j,t]) = d[i,t];
three{i in I, t in T}: 
	IT[i,0]-sum{tau in 1..t}(d[i,tau])+sum{tau in 1..t}(X[i,tau])-sum{tau in 1..t}(sum{j in S[i]}(a[i,j]*X[j,tau]))>=0;
four{i in I, t in T}: 
	PSI[i]-IT[i,0]+sum{tau in 1..t-1}(d[i,tau])-sum{tau in 1..t}(X[i,tau])+sum{tau in 1..t-1}(sum{j in S[i]}(a[i,j]*X[j,tau])) >= 0;
five{t in T,k in W}: 
	sum{i in Ik[k]}(b[i]*X[i,t]) <= c[k,t];