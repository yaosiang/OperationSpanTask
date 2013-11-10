function stimulusList = genStimulusList(expInfo)

operationList = genOperationList(expInfo.letterLength, expInfo.trialsPerLength);
letterList = genLetterList(expInfo.alphabetic, expInfo.letterLength, expInfo.trialsPerLength);

stimulusList = cell(expInfo.nTrials, 3);

count = 1;
for i = 1:length(letterList)
  letter = cellstr(letterList{i}')';
  operation = cell(1, length(letterList{i}));
  operationAnswer = cell(1, length(letterList{i}));
  for j = 1:length(letterList{i})
    operation{1, j} = operationList{count};
    if eval(operationList{count}(1:end-2)) == eval(operationList{count}(end))
      operationAnswer{1, j} = expInfo.yesKey;
    else
      operationAnswer{1, j} = expInfo.noKey;
    end
    count = count + 1;
  end
  stimulusList{i, 1} = letter;
  stimulusList{i, 2} = operation;
  stimulusList{i, 3} = operationAnswer;
end