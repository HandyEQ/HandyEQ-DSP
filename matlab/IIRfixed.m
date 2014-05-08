%% Design a Lowpass Chebyshev Type I Filter
f = fdesign.lowpass('Fp,Fst,Ap,Ast',0.4,0.45,0.5,80);
Hdf1sos = design(f, 'cheby1', 'FilterStructure', 'df1sos');
%% Step 1: Select a Second-Order Structure
[b,a]=tf(Hdf1sos);
Hdf1 = dfilt.df1(b,a);
Hdf1.Arithmetic = 'fixed';
hfvt = fvtool(Hdf1,'legend','on');
legend(hfvt,'Direct-Form I')

%%  quantize the second-order sections 
Hdf1sos.Arithmetic = 'fixed';
setfilter(hfvt,Hdf1sos);
axis([0 1 -120 5])
legend(hfvt,'Direct-Form I SOS', 'Location','NorthEast')

%%
rng(5,'twister');
q = quantizer([10,9], 'RoundMode','round');
xq = randquant(q,1000,1);
x= fi(xq,true,10,9);

Hdf1sos.AccumWordLength = Hdf1sos.ProductWordLength; % No guard bits in hardware

%% Overflow stats:
fipref('LoggingMode', 'on', 'DataTypeOverride', 'ScaledDoubles');
y = filter(Hdf1sos,x);
fipref('LoggingMode', 'off', 'DataTypeOverride', 'ForceOff');
R = qreport(Hdf1sos)