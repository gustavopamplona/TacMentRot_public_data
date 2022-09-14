function pahandle=playSound(pahandle,filename)

% AssertOpenGL;

wavfilename = ['C:\Gustavo\Dropbox\Postdoc\Project1 - Mental rotation\Codes\github\Sounds' filesep filename '.wav'];

[y, ~] = psychwavread(wavfilename);
wavedata = y';
% nrchannels = size(wavedata,1); % Number of rows == number of channels.
% nrchannels = 2;

% if nrchannels < 2
%     wavedata = [wavedata ; wavedata];
%     nrchannels = 2;
% end

% InitializePsychSound;

% pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);

PsychPortAudio('FillBuffer', pahandle, wavedata);

t1 = PsychPortAudio('Start', pahandle, 1, 0, 1);

% WaitSecs(3);
% PsychPortAudio('Stop', pahandle);
% 
% PsychPortAudio('Close', pahandle);