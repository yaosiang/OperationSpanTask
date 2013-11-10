function main(subjectId)

% Get experimental parameters:
expInfo = getExpInfo;

% Check for OpenGL compatibility, abort otherwise:
AssertOpenGL;

% Reseed the random-number generator for each experiment:
rand('twister', sum(100 * clock));

% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows, and GNU/Linux:
KbName('UnifyKeyNames');

% Hide the mouse cursor:
HideCursor;

% Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
% they are loaded and ready when we need them - without delays
% in the wrong moment:
KbCheck;
WaitSecs(0.1);
GetSecs;

% Open a double buffered fullscreen window on the stimulation screen
% 'screenNumber' and 'windowPtr' is the handle used to direct all 
% drawing commands to that window - the "Name" of the window:
screenNumber = 0;
windowPtr = Screen('OpenWindow', screenNumber);

% Define black and white color:
blackColor = BlackIndex(windowPtr);
whiteColor = WhiteIndex(windowPtr);

Screen('FillRect', windowPtr, blackColor);

% Set text size and font:
Screen('TextSize', windowPtr, expInfo.textSize);
Screen('TextFont', windowPtr, expInfo.textFont);

% Show welcome message:
DrawFormattedText(windowPtr, expInfo.welcomeMsg, 'center', 'center', whiteColor);
Screen('Flip', windowPtr, 0);
KbWait();

% Disable inputs from MATLAB:
ListenChar(2);
  
pracPhase = cell(1, expInfo.nPracTrials);
pracTrials = zeros(1, expInfo.nPracTrials);
pracLetterLength = zeros(1, expInfo.nPracTrials);
pracOperationAnswer = cell(1, expInfo.nPracTrials);
pracOperationResponse = cell(1, expInfo.nPracTrials);
pracOperationAccuracy = zeros(1, expInfo.nPracTrials);
pracLetterAnswer = cell(1, expInfo.nPracTrials);
pracLetterResponse = cell(1, expInfo.nPracTrials);
pracLetterAccuracy = zeros(1, expInfo.nPracTrials);


% Generate stimulus list for practice:
pracStimulusList = genStimulusList(expInfo);

% Show practice message:
DrawFormattedText(windowPtr, expInfo.pracMsg, 'center', 'center', whiteColor);
Screen('Flip', windowPtr);
KbWait();

% Do practice:
for i = 1:expInfo.nPracTrials

  pracPhase{i} = 'Prac';
  pracTrials(i) = i;
  
  % Do trial:
  [pracLetterLength(i), ...
   pracOperationAnswer{i}, pracOperationResponse{i}, pracOperationAccuracy(i), ...
   pracLetterAnswer{i}, pracLetterResponse{i}, pracLetterAccuracy(i)] = ...
   doTrial(windowPtr, expInfo, ...
           pracStimulusList{i, 1}, ...
           pracStimulusList{i, 2}, ...
           pracStimulusList{i, 3}, ...
           whiteColor, blackColor);
end



expPhase = cell(1, expInfo.nTrials);
expTrials = zeros(1, expInfo.nTrials);
expLetterLength = zeros(1, expInfo.nTrials);
expOperationAnswer = cell(1, expInfo.nTrials);
expOperationResponse = cell(1, expInfo.nTrials);
expOperationAccuracy = zeros(1, expInfo.nTrials);
expLetterAnswer = cell(1, expInfo.nTrials);
expLetterResponse = cell(1, expInfo.nTrials);
expLetterAccuracy = zeros(1, expInfo.nTrials);

% Generate stimulus list for experiment:
stimulusList = genStimulusList(expInfo);

% Show experiment message:
DrawFormattedText(windowPtr, expInfo.expMsg, 'center', 'center', whiteColor);
Screen('Flip', windowPtr, 0);
KbWait();

% Do experiment:
for i = 1:expInfo.nTrials

  expPhase{i} = 'Exp';
  expTrials(i) = i;

  % Do trial:
  [expLetterLength(i), ...
   expOperationAnswer{i}, expOperationResponse{i}, expOperationAccuracy(i), ...
   expLetterAnswer{i}, expLetterResponse{i}, expLetterAccuracy(i)] = ...
   doTrial(windowPtr, expInfo, ...
           stimulusList{i, 1}, ...
           stimulusList{i, 2}, ...
           stimulusList{i, 3}, ...
           whiteColor, blackColor);
end

% Open data file:
fid = fopen(strcat('data', filesep, num2str(subjectId), '.txt'), 'wt');
fprintf(fid, 'Subject ID: %d\n', subjectId);

% Out header to data file:
fprintf(fid, 'Phase\tTrial\tLength\tOperAns\tOperResp\tOperAcc\tLettAns\tLettResp\tLettAcc\n');

% Output practice data:
for i = 1:length(pracPhase)
  fprintf(fid, '%s\t%d\t%d\t%s\t%s\t%f\t%s\t%s\t%f\n', ...
    pracPhase{i}, ...
    pracTrials(i), ...
    pracLetterLength(i), ...
    pracOperationAnswer{i}, ...
    pracOperationResponse{i}, ...
    pracOperationAccuracy(i), ...
    pracLetterAnswer{i}, ...
    pracLetterResponse{i}, ...
    pracLetterAccuracy(i));
end

% Output experiment data:
for i = 1:length(expPhase)
  fprintf(fid, '%s\t%d\t%d\t%s\t%s\t%f\t%s\t%s\t%f\n', ...
    expPhase{i}, ...
    expTrials(i), ...
    expLetterLength(i), ...
    expOperationAnswer{i}, ...
    expOperationResponse{i}, ...
    expOperationAccuracy(i), ...
    expLetterAnswer{i}, ...
    expLetterResponse{i}, ...
    expLetterAccuracy(i));
end
% Close data file:
fclose(fid);

% Show thank you message:
DrawFormattedText(windowPtr, expInfo.thankYouMsg, 'center', 'center', whiteColor);
Screen('Flip', windowPtr, 0);
KbWait([], 2);

% Enable inputs from MATLAB:
ListenChar(0);

% Cleanup at end of experiment - Close window, show mouse cursor:
Screen('CloseAll');
ShowCursor;