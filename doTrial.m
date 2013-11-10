function [itemLength, operationAnswer, operationResponse, operationAccuracy, letterAnswer, letterResponse, letterAccuracy] = ...
  doTrial(windowPtr, expInfo, letterStimulus, operationStimulus, answerStimulus, foreColor, backColor)

bKey = KbName('b'); cKey = KbName('c'); dKey = KbName('d');
fKey = KbName('f'); gKey = KbName('g'); hKey = KbName('h');
jKey = KbName('j'); kKey = KbName('k'); lKey = KbName('l');
mKey = KbName('m'); nKey = KbName('n'); pKey = KbName('p');
rKey = KbName('r'); sKey = KbName('s'); tKey = KbName('t');
vKey = KbName('v'); wKey = KbName('w'); xKey = KbName('x');
zKey = KbName('z'); returnKey = KbName('Return');
operationResponseKeySet = [expInfo.yesKey, expInfo.noKey];
responseKeySet = [bKey, cKey, dKey, fKey, gKey, hKey, jKey, kKey, lKey, mKey, ...
                  nKey, pKey, rKey, sKey, tKey, vKey, wKey, xKey, zKey, returnKey];

itemLength = length(letterStimulus);

operationAnswer = '';
operationResponse = '';
operationAccuracy = 0;
letterAnswer = '';
letterResponse = '';
letterAccuracy = 0;

correctNo = 0;
wrongNo = 0;

for j = 1:length(letterStimulus)

  % Show operation:
  DrawFormattedText(windowPtr, operationStimulus{j}, 'center', 'center', foreColor);
  Screen('Flip', windowPtr, 0);

  % Get response with time out
  response = getTimeoutResponseRT(operationResponseKeySet, expInfo.operationDuration);
  if isempty(response); response = '_'; end

  if response ~= '_'
    operationResponse = [operationResponse upper(KbName(response))];
  else
    operationResponse = [operationResponse '_'];
  end

  if response ~= '_'
    if response == answerStimulus{j}
      correctNo = correctNo + 1;
    else
      wrongNo = wrongNo + 1;
    end
  else
    wrongNo = wrongNo + 1;
  end

  operationAnswer = [operationAnswer upper(KbName(answerStimulus{j}))];

  % Show letter:
  DrawFormattedText(windowPtr, letterStimulus{j}, 'center', 'center', foreColor);
  Screen('Flip', windowPtr, 0);
  WaitSecs(expInfo.letterDuration);
end

operationAccuracy = correctNo / (correctNo + wrongNo);

% Wait for response:
response = getEchoStringRT(windowPtr, responseKeySet, foreColor, backColor, max(expInfo.letterLength));
if isempty(response); response = '_'; end

if response ~= '_'
  letterResponse = response;
else
  letterResponse = '_';
end

if strcmp(char(letterStimulus)', letterResponse)
  letterAccuracy = 1;
else
  letterAccuracy = 0;
end

letterAnswer = char(letterStimulus)';

WaitSecs(expInfo.interTrialInterval);