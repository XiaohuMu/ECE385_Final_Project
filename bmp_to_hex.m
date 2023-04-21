b=imread("C:\Users\muxia\Desktop\1920px-Godhome_Arena_Mantis_Lords_Sisters_of_Battle_copy.png"); % 24-bit BMP image RGB888 

k=1;
for i=240:-1:1 % image is written from the last row to the first row
for j=1:320
a(k)=b(i,j,1);
a(k+1)=b(i,j,2);
a(k+2)=b(i,j,3);
k=k+3;
end
end
fid = fopen('background.hex', 'wt');
fprintf(fid, '%x\n', a);
disp('Text file write done');disp(' ');
fclose(fid);
% fpga4student.com FPGA projects, Verilog projects, VHDL projects