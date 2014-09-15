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

%% usage: ssp = frjoin(ssp1,ssp2,k1,k2)
%%
%% Une dos respuestas en magnitud sobre el semiespectro, mezcl�ndolas en un intervalo de
%% �ndices dado.
%%
%% ssp	= vector columna con la magnitud de la mezcla.
%% ssp1	= vector columna con la respuesta a mezclar por la izquierda.
%% ssp2	= vector columna con la respuesta a mezclar por la derecha.
%% k1	= primer �ndice del intervalo.
%% k2	= segundo �ndice del intervalo.

function ssp = frjoin(ssp1,ssp2,k1,k2)

	if ! iscolumn(ssp1)
		error ("ssp1 must be a column vector")
	end

	if ! iscolumn(ssp2)
		error ("ssp2 must be a column vector")
	end

	if (length (ssp1) != length (ssp2))
		error ("frjoin: Spectrum lengths must be equal");
	end
    [trw1, trw2] = trwcos(k1,k2);
    m=length(ssp1);
    ssp1=[ssp1(1:k1-1);ssp1(k1:k2).*trw1;zeros(m-k2,1)];
    ssp2=[zeros(k1-1,1);ssp2(k1:k2).*trw2;ssp2(k2+1:m)];
    ssp=ssp1+ssp2;
    
endfunction