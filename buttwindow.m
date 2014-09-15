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

%% usage: x = buttwindow (m,ppo,ppoSm)
%%
%% Genera una ventana est�ndar de promediado de potencia con filtrado butterworth de 6� orden.
%%
%% x = ventana.
%% m = longitud del espectro logar�tmico a promediar.
%% ppo = fracci�n de octava del intervalo de frecuencias. 
%% ppoSm = fracci�n de octava del suavizado.

function x=buttwindow(m,ppo,ppoSm);
    w=logfreq(m,2*pi,ppo);
    [b,a]=butter(6,[0.2/2^(1/ppoSm),0.2]);
    x=abs(freqz(b,a,w)).^2;
    x=x(x>dB2pow(-20)); x=x/sum(x);
end
