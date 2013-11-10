function randOperationList = genOperationList(lengthList, trialsPerLength)

operationPool = genOperationPool;
randOperationPool = cell(1, length(operationPool));
randSequence = randperm(length(operationPool));
for i = 1:length(randSequence)
  randOperationPool{i} = operationPool(randSequence(i), :);
end

trueOperationList = cell(1, ((sum(lengthList) * trialsPerLength) / 2));
falseOperationList = cell(1, ((sum(lengthList) * trialsPerLength) / 2));

for i = 1:length(trueOperationList)
  trueOperationList{i} = randOperationPool{i};
end

for i = 1:length(trueOperationList)
  trueOperationList{i} = strcat(trueOperationList{i}, '=', num2str((eval(trueOperationList{i}))));
end

for i = 1:length(falseOperationList)
  falseOperationList{i} = randOperationPool{length(trueOperationList) + i};
end

for i = 1:length(falseOperationList)
  if mod(i, 2) == 0
    falseOperationList{i} = strcat(falseOperationList{i}, '=', num2str((eval(falseOperationList{i}) + 1)));
  else
    falseOperationList{i} = strcat(falseOperationList{i}, '=', num2str((eval(falseOperationList{i}) - 1)));
  end
end

operationList = horzcat(trueOperationList, falseOperationList);
randOperationList = cell(1, length(operationList));
randSequence = randperm(length(operationList));
for i = 1:length(randSequence)
  randOperationList{i} = operationList{randSequence(i)};
end