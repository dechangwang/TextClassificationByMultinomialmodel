%Ԥ�������� ��ȡ�����ĵ��еĺ��еĵ��ʼ���������

[map1,words]=SegmentAll('acq.train');
wordsNum.word = map1;
wordsNum.wordNum = words;
[map1,words]=SegmentAll('corn.train');
wordsNum(2).word = map1;
wordsNum(2).wordNum = words;
[map1,words]=SegmentAll('crude.train');
wordsNum(3).word = map1;
wordsNum(3).wordNum = words;
[map1,words]=SegmentAll('earn.train');
wordsNum(4).word = map1;
wordsNum(4).wordNum = words;
[map1,words]=SegmentAll('grain.train');
wordsNum(5).word = map1;
wordsNum(5).wordNum = words;
[map1,words]=SegmentAll('interest.train');
wordsNum(6).word = map1;
wordsNum(6).wordNum = words;
[map1,words]=SegmentAll('money-fx.train');
wordsNum(7).word = map1;
wordsNum(7).wordNum = words;
[map1,words]=SegmentAll('ship.train');
wordsNum(8).word = map1;
wordsNum(8).wordNum = words;
[map1,words]=SegmentAll('trade.train');
wordsNum(9).word = map1;
wordsNum(9).wordNum = words;
[map1,words]=SegmentAll('wheat.train');
wordsNum(10).word = map1;
wordsNum(10).wordNum = words;
save wordsNum;  %�����еĽ��������wordsNum.mat ��
%wordsNum ���汣������Ϊ{t1,t2,...tn} tk Ϊĳһ���ĵ��а����ĵ��ʣ�ȥ�����ظ����͸õ��ʵ�TF

%%

%��ȡ�����ĵ��е�false �� true ��ÿ���ĵ��еĽ��������һ��������
%false �������м�Ϊ0 true ��Ϊ1
arrayClassLabel = getClassLabel('acq.train');
classification.arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('corn.train');
classification(2).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('crude.train');
classification(3).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('earn.train');
classification(4).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('grain.train');
classification(5).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('interest.train');
classification(6).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('money-fx.train');
classification(7).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('ship.train');
classification(8).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('trade.train');
classification(9).arrayClassLabel = arrayClassLabel;
arrayClassLabel = getClassLabel('wheat.train');
classification(10).arrayClassLabel = arrayClassLabel;
save classification; %�����н��������classification.mat��

%%
%����ÿ���ļ���ÿ�е��ʵ�TF
%getTFOfEachLine ���صĲ���tf��һ��n*297������
%����ÿ����297�����ݶ�Ӧ�Ÿ��еĵ��ʵ�TF��˳����wordsNum�е��ʳ��ֵ�˳��һ��
%wordsNum��line33����˵��

TF = getTFOfEachLine('acq.train',wordsNum(1).word);
EachLineTF(1).TF= TF;
TF = getTFOfEachLine('corn.train',wordsNum(2).word);
EachLineTF(2).TF= TF;
TF = getTFOfEachLine('crude.train',wordsNum(3).word);
EachLineTF(3).TF= TF;
TF = getTFOfEachLine('earn.train',wordsNum(4).word);
EachLineTF(4).TF= TF;
TF = getTFOfEachLine('grain.train',wordsNum(5).word);
EachLineTF(5).TF= TF;
TF = getTFOfEachLine('interest.train',wordsNum(6).word);
EachLineTF(6).TF= TF;
TF = getTFOfEachLine('money-fx.train',wordsNum(7).word);
EachLineTF(7).TF= TF;
TF = getTFOfEachLine('ship.train',wordsNum(8).word);
EachLineTF(8).TF= TF;
TF = getTFOfEachLine('trade.train',wordsNum(9).word);
EachLineTF(9).TF= TF;
TF = getTFOfEachLine('wheat.train',wordsNum(10).word);
EachLineTF(10).TF= TF;
save EachLineTF;

