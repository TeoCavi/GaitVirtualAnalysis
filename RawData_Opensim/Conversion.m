fid = fopen('man_EMG\manok.txt', 'r');
nlines = 11111111; %to chenage before execute
nofframe = 111111;  %to chenage before execute

%removal of frame header row (starting with TIME and Number)
%(considering this row the execution of textscan() will be stopped at the first frame)
fileID = fopen('man_EMG\manraw.txt','w');
for i=1:nlines
    str = fgetl(fid); %read the lines one by one, removing \n
    pat1 = "TIME";
    pat2 = "Number";
    if contains(str,pat1) == 0 && contains(str,pat2) == 0
        fprintf(fileID, str);
        fprintf(fileID,'\r\n');
    end
end
fclose(fileID);

%opening the formatted file slicing the different columns
fileid = fopen('man_EMG\manraw.txt');
P = textscan(fileid,'%d %s %f %f %f');

%create a new .trc file following the formatting rules
fileIDtrc = fopen('man_EMG\man.trc','w');
fprintf(fileIDtrc,'PathFileType\t4\t(X/Y/Z)\tman.trc\t\n');
fprintf(fileIDtrc,'DataRate\tCameraRate\tNumFrames\tNumMarkers\tUnits\tOrigDataRate\tOrigDataStartFrame\tOrigNumFrames\t\n');
fprintf(fileIDtrc,'50\t50\t85\t15\tm\t50\t1\t4\t\n'); %check if needed
fprintf(fileIDtrc,'#Frame\tTime\t');
for i=1:15
    fprintf(fileIDtrc,'%s\t',P{1,2}{i,1});
end
fprintf(fileIDtrc,'\n\t\t');
for i=1:15
    fprintf(fileIDtrc,'X%d\tY%d\tZ%d\t', i,i,i);
end
fprintf(fileIDtrc,'\n\n');
tm = 0;
of = 0;
for j = 1:nofframe
    fprintf(fileIDtrc,'%d\t%f\t', j,tm);
    tm = tm + 0.02;
    for i = 1+of:15+of
        fprintf(fileIDtrc,'%.6f\t%.6f\t%.6f\t',P{1,3}(i),P{1,4}(i),P{1,5}(i));
    end
    of = of + 15;
    fprintf(fileIDtrc,'\n');
end
fclose(fileIDtrc);
    
    











