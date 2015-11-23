load('wordsNum.mat');
load('EachLineTF.mat');
load('classification.mat');
word_false =zeros(10,299); %记录每个word在类别为true下出现的次数 
word_true = zeros(10,299); %记录每个word在类别为false下出现的次数
for fNum = 1:10
    count = size(wordsNum(fNum).word);
    rowNum = size(classification(fNum).arrayClassLabel,1);
    for j = 1:rowNum
        if classification(fNum).arrayClassLabel(j) == 1
            for i = 1:count
                 word_true(fNum,i) = word_true(fNum,i)+EachLineTF(fNum).TF(j,i);
            end
        else
            for i = 1:count
                 word_false(fNum,i) = word_false(fNum,i)+EachLineTF(fNum).TF(j,i);
            end
        end
    end
end

%用来保存正在分类文件中的单词在其他文档中出现中的次数
words_TFInother_false= zeros(10,299); %word在false类别下出现的次数
words_TFInother_true= zeros(10,299);  %word在true类别下出现的次数
TP = zeros(10,1);
FN = zeros(10,1);
FP = zeros(10,1);
TN = zeros(10,1);
accuracy = zeros(10,1);
recall = zeros(10,1);
precision = zeros(10,1);
F_measure= zeros(10,1);
%%
%对acq.train用5路交叉验证
word_true_1 = zeros(5,299);
word_false_1 = zeros(5,299);
 count = size(wordsNum(1).word);
 rowNum = size(classification(1).arrayClassLabel,1);
 
 for m = 1:5
    for j = floor((m-1)*rowNum/5)+1:floor(m*rowNum/5)
        if classification(1).arrayClassLabel(j) == 1
            for i = 1:count
                 word_true_1(m,i) = word_true_1(m,i)+EachLineTF(1).TF(j,i);
            end
        else
            for i = 1:count
                 word_false_1(m,i) = word_false_1(m,i)+EachLineTF(1).TF(j,i);
            end
        end
    end
 end
word_true(1,:) =  word_true_1(2,:)+word_true_1(3,:)+word_true_1(4,:)+word_true_1(5,:);
word_true(2,:) =  word_true_1(1,:)+word_true_1(3,:)+word_true_1(4,:)+word_true_1(5,:);
word_true(3,:) =  word_true_1(1,:)+word_true_1(2,:)+word_true_1(4,:)+word_true_1(5,:);
word_true(4,:) =  word_true_1(1,:)+word_true_1(3,:)+word_true_1(2,:)+word_true_1(5,:);
word_true(5,:) =  word_true_1(1,:)+word_true_1(3,:)+word_true_1(4,:)+word_true_1(2,:);
word_false(1,:) = word_false_1(2,:)+word_false_1(3,:)+word_false_1(4,:)+word_false_1(5,:);
word_false(2,:) = word_false_1(1,:)+word_false_1(3,:)+word_false_1(4,:)+word_false_1(5,:);
word_false(3,:) = word_false_1(2,:)+word_false_1(1,:)+word_false_1(4,:)+word_false_1(5,:);
word_false(4,:) = word_false_1(2,:)+word_false_1(3,:)+word_false_1(1,:)+word_false_1(5,:);
word_false(5,:) = word_false_1(2,:)+word_false_1(3,:)+word_false_1(4,:)+word_false_1(1,:);

wordList = wordsNum(1).word.keys();
k = 1;
while(wordList.hasNext())
%for k = 1:297 
    word = wordList.nextElement;
   % disp(word);
    for j = 2:10
       % disp('========================================================');
       % disp((wordsNum(j).word.containsKey(char(word))));
       % disp(j);
        %sprintf('word = %s   j = %d',(wordsNum(j).word.containsKey(char(word))),j);
        if wordsNum(j).word.containsKey(char(word))
            pos = 1;
            while(wordsNum(j).word.keys().hasNext())
               tem = wordsNum(j).word.keys().nextElement;
               %disp(word);
               %disp(tem);
               % disp(strcmp(tem,word));
               if (strcmp(tem,word))
                  
                    words_TFInother_true(1,k) = words_TFInother_true(1,k)+word_true(j,pos);
                    words_TFInother_false(1,k) = words_TFInother_false(1,k)+word_false(j,pos);
                    break;
                  
               else
                   if pos >=297
                       break;
                   end
                   pos = pos +1;
                   %disp(pos);
               end
            end
        end
    end
    k = k+1;   
end 
for n =1:5
%使用多项式模型来计算类条件概率
X_C_true = (word_true(n,:)+words_TFInother_true(1,:)+1)/(sum(word_true(n,:))+size(wordsNum(1).word));
X_C_false = (word_false(n,:)+words_TFInother_false(1,:)+1)/(sum(word_false(n,:))+size(wordsNum(1).word));

a=[];
for i = floor((n-1)*rowNum/5)+1:floor(n*rowNum/5)
    f = 1;
    t = 1;
    for j = 1:size(wordsNum(1).word)
        t = t * power(X_C_true(j),EachLineTF(1).TF(i,j));
        f = f * power(X_C_false(j),EachLineTF(1).TF(i,j));
    end
    if f > t
        a = [a;0];
    else 
        a = [a;1];   
    end
end

for i = floor((n-1)*rowNum/5)+1:floor(n*rowNum/5)
    if classification(1).arrayClassLabel(i) == 1
        if a(i-floor((n-1)*rowNum/5)) == 1
            TP(n) = TP(n) +1;
        else
            FN(n) = FN(n) + 1;
        end
    else
        if a(i-floor((n-1)*rowNum/5)) == 1
            FP(n) = FP(n) +1;
        else
            TN(n) = TN(n) + 1;
        end 
    end
end
accuracy(n) = (TP(n)+TN(n))/size(a,1);
recall(n) = TP(n)/(TP(n)+FN(n));
precision(n) = TP(n)/(TP(n)+FP(n));
F_measure(n) = (2*precision(n)*recall(n))/(precision(n)+recall(n));
end
%%
%下面对10类文件进行分类
%{
for n = 1:10
wordList = wordsNum(n).word.keys();
k = 1;

while(wordList.hasNext())
%for k = 1:297 
    word = wordList.nextElement;
   % disp(word);
    for j = 1:10
       % disp('========================================================');
       % disp((wordsNum(j).word.containsKey(char(word))));
       % disp(j);
        %sprintf('word = %s   j = %d',(wordsNum(j).word.containsKey(char(word))),j);
        if wordsNum(j).word.containsKey(char(word)) && j ~= n
            pos = 1;
            while(wordsNum(j).word.keys().hasNext())
               tem = wordsNum(j).word.keys().nextElement;
               %disp(word);
               %disp(tem);
               % disp(strcmp(tem,word));
               if (strcmp(tem,word))
                   if j ~= n
                    words_TFInother_true(n,k) = words_TFInother_true(n,k)+word_true(j,pos);
                    words_TFInother_false(n,k) = words_TFInother_false(n,k)+word_false(j,pos);
                    break;
                   end
               else
                   if pos >=299
                       break;
                   end
                   pos = pos +1;
                   %disp(pos);
               end
            end
        end
    end
    k = k+1;   
end

%使用多项式模型来计算类条件概率
X_C_true = (word_true(n,:)+words_TFInother_true(n,:)+1)/(sum(word_true(n,:))+size(wordsNum(n).word));
X_C_false = (word_false(n,:)+words_TFInother_false(n,:)+1)/(sum(word_false(n,:))+size(wordsNum(n).word));

a=[];
for i = 1:size(classification(n).arrayClassLabel,1)
    f = 1;
    t = 1;
    for j = 1:size(wordsNum(n).word)
        t = t * power(X_C_true(j),EachLineTF(n).TF(i,j));
        f = f * power(X_C_false(j),EachLineTF(n).TF(i,j));
    end
    if f > t
        a = [a;0];
    else 
        a = [a;1];   
    end
end

for i = 1:size(classification(n).arrayClassLabel,1)
    if classification(n).arrayClassLabel(i) == 1
        if a(i) == 1
            TP(n) = TP(n) +1;
        else
            FN(n) = FN(n) + 1;
        end
    else
        if a(i) == 1
            FP(n) = FP(n) +1;
        else
            TN(n) = TN(n) + 1;
        end 
    end
end


accuracy(n) = (TP(n)+TN(n))/size(a,1);
recall(n) = TP(n)/(TP(n)+FN(n));
precision(n) = TP(n)/(TP(n)+FP(n));
F_measure(n) = (2*precision(n)*recall(n))/(precision(n)+recall(n));

end
%}