% Converts dB to needed bits
% Preben Thor�d @ 2014
function [ bits ] = dbtobits( db )
    ampfactor = 10^(db/20);  
    bits = log2(ampfactor);   

end

