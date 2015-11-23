M = dlmread('iris.txt', ',');
X = M(:,3:4);
y =[];
for i = 1:150
    if i<=50
    y = [y;'setosa    '];
    elseif i<=100
        y = [y;'versicolor'];
    else
        y = [y;'virginica '];
    end;        
end
%{
for i = 51:100
    y = [y;'Iris-versicolor'];
end
for i = 101:150
    y = [y;'Iris-virginica'];
end
%}
tabulate(y);
NBModel = fitNaiveBayes(X,y);
figure
gscatter(X(:,1),X(:,2),y);
xylim = cell2mat(get(gca,{'Xlim','YLim'})); % Gets current axis limits
hold on
Params = cell2mat(NBModel.Params);
Mu = Params(2*(1:3)-1,1:2); % Extracts the means
Sigma = zeros(2,2,3);
for j = 1:3
    Sigma(:,:,j) = diag(Params(2*j,:)); % Extracts the standard deviations
    ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),...
        xylim+0.5*[-1,1,-1,1]) ...
        % Draws contours for the multivariate normal distributions
end
title('Naive Bayes Classifier -- Fisher''s Iris Data')
xlabel('Petal Length (cm)')
ylabel('Petal Width (cm)')
hold off