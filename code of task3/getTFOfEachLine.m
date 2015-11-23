function TF = getTFOfEachLine( fileName,s1)
fid = fopen(['reuters/train/',fileName]);
TF = [];
temp = [];
 tline = fgetl(fid);
 tline = fgetl(fid);
 while ischar(tline)
     tline = deblank(tline);
     tline = regexp(tline, '\s+', 'split');
     numLine = size(tline,2);
     wordList = s1.keys();
     
     while(wordList.hasNext())
        word = wordList.nextElement;
        f = 0;
        for j = 1:numLine
            if(strcmp(char(word),char(tline(1,j))) ==1)
                f = f+1;                
            end
        end
        temp=[temp;f];
     end
     TF=[TF;temp'];
     temp=[];
     tline = fgetl(fid);
     tline = fgetl(fid);
 end
fclose(fid);
end

