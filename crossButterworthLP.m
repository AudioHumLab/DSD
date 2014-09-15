%% Copyright (C) 2012 Roberto Ripio
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DSD

%% usage: imp=crossButterworthLP(fs,m,nl,fl,nh,fh)
%%
%% Obtiene el filtro FIR de fase lineal con la magnitud
%% de un filtro butterworth de orden n.
%%
%% imp = Coeficientes del filtro FIR.
%% Fs = Frecuencia de muestreo.
%% m = N�mero de muestras.
%% nl = Orden del filtro pasaaltos.
%% fl = Frecuencia de corte inferior (pasaaltos). 0 para pasabajos.
%% nh = Orden del filtro pasabajos.
%% fh = Frecuencia de corte superior (pasabajos). 0 para pasaaltos.

function imp=crossButterworthLP(fs,m,nl,fl,nh,fh);
    
    wl=fl/(fs/2);
    wh=fh/(fs/2);
	mLow = fs/m;						% low freq, freq jump
	ssK = 0:m/2;						% indexes of non aliased frequency vector
	ssF = mLow*(ssK);					% non aliased frequency vector

	% Lowpass
    if (fl==0) & (fh>0)
        [b,a]=butter(nh,wh);
		mag = abs(freqz(b,a,ssF,fs));
    % Highpass
    elseif (fl>0) & (fh==0)
        [b,a]=butter(nl,wl,'high');
		mag = abs(freqz(b,a,ssF,fs));
	% Bandpass
	elseif (fl>0) & (fh>0)
		[b,a]=butter(nh,wh);
		magh = abs(freqz(b,a,ssF,fs));
		[b,a]=butter(nl,wl,'high');
		magl = abs(freqz(b,a,ssF,fs));
		mag=magh.*magl;
	% Delta
    elseif (fl==0) & (fh==0)
		imp=centerimp(deltacentered(m-1),m);
		return;
	end
	
	% mag = freqz(b,a,ssF,fs);
    imp = circshift(real(ifft(wholesplp(mag'))),m/2);
	imp = blackmanharris (m) .* imp;
end
