function [response, rt] = getTimeoutResponseRT(keySet, timeout, stimulusOnset)

if nargin < 3
  stimulusOnset = -1;
end

if stimulusOnset ~= -1
  startTime = stimulusOnset;
else
  startTime = GetSecs;
end

endTime = startTime + timeout;
responseTime = 0;

while KbCheck; end

while GetSecs < endTime
  [keyIsDown, secs, keyCode] = KbCheck;
  if keyIsDown
    c = find(keyCode);
    if length(c) == 1
      if ismember(c, keySet)
        responseTime = secs;
        break;
      end
    end
    while KbCheck; end
  end
  WaitSecs(0.01);
end

if responseTime ~= 0
  rt = responseTime - startTime;
  response = c;
else
  rt = timeout;
  response = '';
end