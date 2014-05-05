function [  ] = eq_createcoefffile(coeffStruct, StructName, filename)
    

    % Input arg: filename
    % coefficient vector
    % (Formatting)
    
       
    
    %%Command status
    %%error checking for fileopening
    
    if (isstruct(coeffStruct))
        createArray = 0;
    elseif (iscell(coeffStruct))
        createArray = 1;
        arraysize = length(coeffStruct);
    end
    
    
    filepath = 'Dat096/';
    Cfilestring = sprintf('%s%s.c',filepath,filename);
    Hfilestring = sprintf('%s%s.h',filepath,filename);
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   C file
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fCfile = fopen(Cfilestring,'wt');
    
    fprintf(fCfile,'/* %s.c */\n',filename);
    fprintf(fCfile,'/* Initialization of coefficients for 3-band equalizer	*/\n');
    fprintf(fCfile,'/* For use with HandyEQ project MPEES-1 DAT096 Group6	*/\n');
    fprintf(fCfile,'/* Preben Thorod @ HandyEQ                              */\n');
    fprintf(fCfile,'/* Generated: ');
    fprintf(fCfile,datestr(now,'dd mmmm yyyy HH:MM:SS */\n'));
    
    fprintf(fCfile,'\n');
    fprintf(fCfile,'#include <string.h>\n');
    fprintf(fCfile,'#include "biquad.h"\n');
    fprintf(fCfile,'#include "%s.h"\n',filename); 
    fprintf(fCfile,'\n');
    
    fprintf(fCfile,'BiquadCoeff %s',StructName);
        if createArray, fprintf(fCfile,'[%i]',arraysize) ,end 
        fprintf(fCfile,';\n');
    fprintf(fCfile,'\n');

    fprintf(fCfile,'void initEqCoeff() {\n');
    
   % Coefficients:
    if createArray == 0
        fprintf(fCfile,'	strcpy(%s.filtertype, "%s");\n',StructName,coeffStruct.type);
        fprintf(fCfile,'	strcpy(%s.fc, "%dHz");\n',StructName,coeffStruct.fc);
        fprintf(fCfile,'	strcpy(%s.gain, "%ddB");\n',StructName,coeffStruct.gain);    
        fprintf(fCfile,'	strcpy(%s.q, "%s");\n',StructName,num2str(coeffStruct.q));
        fprintf(fCfile,'	strcpy(%s.dataformat, "%s");\n',StructName,coeffStruct.dataformat);
        fprintf(fCfile,'	%s.scalefactor =  %i;\n',StructName,coeffStruct.scalefactor);

        fprintf(fCfile,'	%s.a0 = %d;\n',StructName,coeffStruct.a(1));
        fprintf(fCfile,'	%s.a1 = %d;\n',StructName,coeffStruct.a(2));
        fprintf(fCfile,'	%s.a2 = %d;\n',StructName,coeffStruct.a(3));
        fprintf(fCfile,'	%s.b0 = %d;\n',StructName,coeffStruct.b(1));
        fprintf(fCfile,'	%s.b1 = %d;\n',StructName,coeffStruct.b(2));
        fprintf(fCfile,'	%s.b2 = %d;\n',StructName,coeffStruct.b(3));
    
    elseif createArray == 1
        for i = 1:arraysize
            fprintf(fCfile,'	strcpy(%s[%i].filtertype, "%s");\n',StructName,i-1,coeffStruct{i}.type);            
            fprintf(fCfile,'	strcpy(%s[%i].fc, "%dHz");\n',StructName,i-1,coeffStruct{i}.fc);
            fprintf(fCfile,'	strcpy(%s[%i].gain, "%ddB");\n',StructName,i-1,coeffStruct{i}.gain);    
            fprintf(fCfile,'	strcpy(%s[%i].q, "%s");\n',StructName,i-1,num2str(coeffStruct{i}.q));
            fprintf(fCfile,'	strcpy(%s[%i].dataformat, "%s");\n',StructName,i-1,coeffStruct{i}.dataformat);
            fprintf(fCfile,'	%s[%i].scalefactor =  %i;\n',StructName,i-1,coeffStruct{i}.scalefactor);
            
            fprintf(fCfile,'	%s[%i].a0 = %d;\n',StructName,i-1,coeffStruct{i}.a(1));
            fprintf(fCfile,'	%s[%i].a1 = %d;\n',StructName,i-1,coeffStruct{i}.a(2));
            fprintf(fCfile,'	%s[%i].a2 = %d;\n',StructName,i-1,coeffStruct{i}.a(3));
            fprintf(fCfile,'	%s[%i].b0 = %d;\n',StructName,i-1,coeffStruct{i}.b(1));
            fprintf(fCfile,'	%s[%i].b1 = %d;\n',StructName,i-1,coeffStruct{i}.b(2));
            fprintf(fCfile,'	%s[%i].b2 = %d;\n',StructName,i-1,coeffStruct{i}.b(3));
            
            fprintf(fCfile,'\n');
        end
    end
    
    fprintf(fCfile,'};\n');    
    fprintf(fCfile,'\n');
    fprintf(fCfile,'\n');
    fprintf(fCfile,'\n');
    fprintf(fCfile,'\n');
    fprintf(fCfile,'\n');
    fprintf(fCfile,'\n');
    
    fclose(fCfile);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %   header file
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fHfile = fopen(Hfilestring,'wt');
    
    fprintf(fHfile,'/* %s.h */\n',filename);
    fprintf(fHfile,'/* Fixed point coefficients for use with 3band equalizer*/\n');
    fprintf(fHfile,'/* For use with HandyEQ project MPEES-1 DAT096 Group6	*/\n');
    fprintf(fHfile,'/* Preben Thorod @ HandyEQ                              */\n');
    fprintf(fHfile,'/* Generated: ');
    fprintf(fHfile,datestr(now,'dd mmmm yyyy HH:MM:SS */\n'));
    fprintf(fHfile,'\n');
    fprintf(fHfile,'\n');  
    
    fprintf(fHfile,'#ifndef %s_H\n',upper(filename));
    fprintf(fHfile,'#define %s_H\n',upper(filename));
    fprintf(fHfile,'\n');
    
    fprintf(fHfile,'#include "biquad.h"\n');    
    fprintf(fHfile,'\n');
    
    fprintf(fHfile,'/* Global coefficient structs: */\n');
    
    fprintf(fCfile,'extern BiquadCoeff %s',StructName);
        if createArray, fprintf(fCfile,'[%i]',arraysize) ,end 
        fprintf(fCfile,';\n');
    
    
    fprintf(fHfile,'\n');
    fprintf(fHfile,'/* Function prototypes */\n');
    fprintf(fHfile,'void initEqCoeff();\n');
    fprintf(fHfile,'\n');   
    fprintf(fHfile,'#endif\n');
    fprintf(fHfile,'\n');
    fprintf(fHfile,'\n');   
    
    
    fprintf(fHfile,'\n');
    
    fclose(fHfile);
 


end

