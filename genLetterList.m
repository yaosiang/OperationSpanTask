function randLetterList = genLetterList(alphabetic, lengthList, trialsPerLength)

letterLengthList = repmat(lengthList, 1, trialsPerLength);
letterLengthList = sortrows(letterLengthList')';

randSequence = randperm(length(letterLengthList));

randLetterLengthList = zeros(1, length(letterLengthList));
for i = 1:length(randSequence)
  randLetterLengthList(i) = letterLengthList(randSequence(i));
end

randLetterList = cell(1, length(randLetterLengthList));
for i = 1:length(randLetterList)
  randLetterList{i} = randsample(alphabetic, randLetterLengthList(i));
end