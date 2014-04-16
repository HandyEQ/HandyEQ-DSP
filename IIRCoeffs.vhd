-- IIRCoeffs.vhd
-- VHDL package holding LP IIR filter coefficients
-- Carl-Johan Haell - Chalmers University of Technology

-- Autogenerated file. Generated by "SpectoFixed.m"
-- Generated:                   16 April 2014 15:40:02
-- Filter order (N)             2
-- Sample frequency (fs)        768kHz : 
-- Cutoff frequency (fc)        20kHz : 
-- Fractional binary format:    2.30 
-- Stable (1/0)                 1:

library ieee;
use ieee.std_logic_1164.all; 

package IIR_coeffs is  
constant f5_b0 : std_logic_vector(31 downto 0) := B"00000000001001010000100000000000"; --b0 = 2.260208e-03
constant f5_b1 : std_logic_vector(31 downto 0) := B"00000000010010100001000000000000"; --b1 = 4.520416e-03
constant f5_b2 : std_logic_vector(31 downto 0) := B"00000000001001010000100000000000"; --b2 = 2.260208e-03
constant f5_a1 : std_logic_vector(31 downto 0) := B"10000111101001110000000000000000"; --a1 = -1.880432e+00
constant f5_a2 : std_logic_vector(31 downto 0) := B"00111000111101100000000000000000"; --a2 = 8.900146e-01
constant ScaleValue_f5_0 : std_logic_vector(17 downto 0) := B"011111111111111111"; --ScaleValue_0 = 1
constant ScaleValue_f5_1 : std_logic_vector(17 downto 0) := B"011111111111111111"; --ScaleValue_1 = 9.999999e-01
end IIR_coeffs; 

 
