function arrayClassLabel = getClassLabel(fileName)
fid = fopen(['reuters/train/',fileName])
arrayClassLabel = [];
tline = fgetl(fid);
while ischar(tline)
    tline = deblank(tline);
    if(strcmp(char(tline),'false')==1)
        arrayClassLabel = [arrayClassLabel;0];
    else
        arrayClassLabel = [arrayClassLabel;1];
    end
    tline = fgetl(fid);
    tline = fgetl(fid);
end
fclose(fid);
end

