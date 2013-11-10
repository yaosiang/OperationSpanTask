function expInfo = getExpInfo

% Messages:
expInfo.welcomeMsg = 'Welcome to Operation Span Task\n\nPress Any Key to Continue...';
expInfo.pracMsg = 'Press Any Key to Begin Practice';
expInfo.expMsg = 'Press Any Key to Begin Experiment';
expInfo.thankYouMsg = 'Thank You!\n\nPress Any Key to Escape...';

% Duration (secs):
expInfo.interTrialInterval = 0.5;
expInfo.interItemInterval = 0.1;
expInfo.operationDuration = 3;
expInfo.letterDuration = 1;

% Stimuli:
expInfo.letterLength = 2:6;
expInfo.trialsPerLength = 3;
expInfo.nPracTrials = 1;
expInfo.nTrials = length(expInfo.letterLength) * expInfo.trialsPerLength;
expInfo.alphabetic = ['B', 'C', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'R', 'S', 'T', 'V', 'W', 'X', 'Z'];

% Text size:
expInfo.textSize = 48;
expInfo.textFont = 'Helvetica';

% Predefine key name:
expInfo.yesKey = KbName('c');
expInfo.noKey = KbName('m');