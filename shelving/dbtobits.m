function [ bits ] = dbtobits( db )
    ampfactor = 10^(db/20);  %amplification factor
    bits = log2(ampfactor);    

end

