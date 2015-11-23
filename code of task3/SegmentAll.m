function [result,wordsNum] =SegmentAll(fileName)
fid = fopen(['reuters/train/',fileName]);
s1 = java.util.Hashtable;
wordsNum =0;
%arraybool = [];
  tline = fgetl(fid);
  tline = fgetl(fid);
while ischar(tline)
   tline = deblank(tline);
   tline = regexp(tline, '\s+', 'split');
   num = size(tline,2);
   
for i =1:num   
    wordsNum = wordsNum+1;
  if(~s1.containsKey(char(tline(1,i))))
       s1.put(char(tline(1,i)),1);
  else
        value1 = 1.0+s1.get(char(tline(1,i)));
        s1.put(char(tline(1,i)),value1);
   end     
end    
     tline = fgetl(fid);
     tline = fgetl(fid);
end
result = s1;
fclose(fid);
end
