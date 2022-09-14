function TactileHandsRotation

% Code to run tactile/visual hands mental rotation experiments in fMRI
% Gustavo Pamplona, July 2019

% check the total time and decide how many runs/repetitions will be made

% pilot for experimenter training
% pilot for power analysis (3 subjects)

% participant's data
prompt = {'Name of the participant:','Run:'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'participant','1'};
subjData = inputdlg(prompt,dlgtitle,dims,definput);

Screen('Preference', 'SkipSyncTests', 2);

folder = 'C:\Gustavo\Dropbox\Postdoc\Project1 - Mental rotation\Codes\github\Figures';

% experiment parameters
n_trials=2;

screenNumber=max(Screen('Screens'));
%     window=Screen('OpenWindow', screenNumber);
%     window=Screen('OpenWindow', 2);
window = Screen('OpenWindow', screenNumber, [], []);
DrawFormattedText(window,...
    'MENTAL ROTATION OF HANDS \n\n\n\n Please look attentively at the screen. \n\n Lower your right hand as soon as you see a down arrow and \n\n only raise your hand when you see an up arrow. Respond \n\n with left or right with the left hand. \n\n Please start with the right hand raised. \n\n Good luck! :)',...
    'center','center');
Screen('Flip',window);

% defining screen parameters
white=WhiteIndex(window);
Screen(window, 'FillRect',white); % paints entire window of gray
Screen('TextSize',window, 50);

fixloc=[folder '\fixation.jpg'];
fix = imread(fixloc);
ctrlloc=[folder '\woodenBall.jpg'];
img.ctrl = imread(ctrlloc);
uploc=[folder '\up.jpg'];
img.up = imread(uploc);
downloc=[folder '\down.jpg'];
img.down = imread(downloc);
loc01 = [folder '\palm_pos000_L.png']; %L0P
img.s01  = imread(loc01);
loc02 = [folder '\dors_pos000_L.png']; %L0D
img.s02  = imread(loc02);
loc03 = [folder '\palm_pos090_L.png']; %L1P
img.s03  = imread(loc03);
loc04 = [folder '\dors_pos090_L.png']; %L1D
img.s04  = imread(loc04);
loc05 = [folder '\palm_pos180_L.png']; %L2P
img.s05  = imread(loc05);
loc06 = [folder '\dors_pos180_L.png']; %L2D
img.s06  = imread(loc06);
loc07 = [folder '\palm_pos270_L.png']; %L3P
img.s07  = imread(loc07);
loc08 = [folder '\dors_pos270_L.png']; %L3D
img.s08  = imread(loc08);
loc09 = [folder '\palm_pos000_R.png']; %R0P
img.s09  = imread(loc09);
loc10 = [folder '\dors_pos000_R.png']; %R0D
img.s10  = imread(loc10);
loc11 = [folder '\palm_pos090_R.png']; %R1P
img.s11  = imread(loc11);
loc12 = [folder '\dors_pos090_R.png']; %R1D
img.s12  = imread(loc12);
loc13 = [folder '\palm_pos180_R.png']; %R2P
img.s13  = imread(loc13);
loc14 = [folder '\dors_pos180_R.png']; %R2D
img.s14  = imread(loc14);
loc15 = [folder '\palm_pos270_R.png']; %R3P
img.s15  = imread(loc15);
loc16 = [folder '\dors_pos270_R.png']; %R3D
img.s16  = imread(loc16);

% setting initial parameters
starttic=0;
trial=1;
KbName('UnifyKeyNames');
stopkey=KbName('ESCAPE');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
triggerKey = KbName('s');
respMat =(nan(10,n_trials));

% create matrix of stimuli and answers
description(1,:)={'mode'};
description(2,:)={'laterality'};
description(3,:)={'orientation'};
description(4,:)={'side'};
description(5,:)={'response'};
description(6,:)={'correct?'};
description(7,:)={'RT'};
description(8,:)={'onset'};
description(9,:)={'trial'};
description(10,:)={'too slow'};

randcomb=quasirandom;

respMat(1:4,:) = randcomb(:,1:n_trials); % 9 14 ctrl

I2 = 3.5; % Tal 2009 6s (but we think we can do in 3 s)
I2add = [.5 1 1.5 2];
I2addVec=repmat(I2add,1,8); % 8 * 4 = 32 trials
I2addRand=I2addVec(:,randperm(size(I2addVec,2)));

D2 = 6; % Saito 2003

% config sound
AssertOpenGL;
InitializePsychSound;
pahandle = PsychPortAudio('Open', [], [], 0, 44100, 2);

while 1
    [~,~,keyCode] = KbCheck;
    if keyCode(triggerKey)
        tic
        Screen('Flip',window);
        DrawFormattedText(window,'Experiment starting...','center','center');
        Screen('Flip',window);
        pahandle=playSound(pahandle,'start');
        WaitSecs(3);
        break
    end
end

while trial<=n_trials
    
    % initial parameters
    changeToFix=0;
    t1=0;
    choice=0;
%     audioPlayed=0;
    
    if randcomb(1,trial)==1
        modestr='visual';
    else
        modestr='tactile';
    end
    
    imgName=loadFigure(randcomb,trial,img,modestr);
    
    for cond=1:2
        
        if cond==1
            buffer=Screen('MakeTexture', window, fix);
            Screen('DrawTexture', window, buffer);
            Screen('Flip',window,[]);
            
            if trial==1
                nextTrialIdx=nextTrial(randcomb,0);
                if nnz(num2str(nextTrialIdx))==1
                    pahandle=playSound(pahandle,['0' num2str(nextTrialIdx)]);
                else
                    pahandle=playSound(pahandle,num2str(nextTrialIdx));
                end
                WaitSecs(6+I2addRand(trial));
            elseif nnz(trial==[n_trials/4 2*n_trials/4 3*n_trials/4]+1) % in trials 9, 17, and 25, there's a longer waiting time to wait for scanner trigger
%             elseif trial==2 % in trials 9, 17, and 25, there's a longer waiting time to wait for scanner trigger
                Screen('Flip',window);
                buffer=Screen('MakeTexture', window, fix);
                Screen('DrawTexture', window, buffer);
%                 DrawFormattedText(window,'waiting time','center',90);
%                 Screen('Flip',window);
%                 WaitSecs(4);
% plan the trigger to be sent ~4 s after this line
                while 1
                    [~,~,keyCode] = KbCheck;
                    buffer=Screen('MakeTexture', window, fix);
                    Screen('DrawTexture', window, buffer);
%                     DrawFormattedText(window,'waiting for trigger','center',90);
                    Screen('Flip',window);
                    if keyCode(triggerKey)
                        buffer=Screen('MakeTexture', window, fix);
                        Screen('DrawTexture', window, buffer);
%                         DrawFormattedText(window,'trigger received','center',90);
                        Screen('Flip',window);
                        WaitSecs(I2addRand(trial));
                        break
                    end
                end
            else
                WaitSecs(I2+I2addRand(trial)); % minus 1 because it has to count the "withdraw" sound time too
            end
        else
            
            % down arrow
            buffer_temp=Screen('MakeTexture', window, img.down);
            Screen('DrawTexture', window, buffer_temp);
            Screen('Flip',window,[],1);
            pahandle=playSound(pahandle,'put');
            WaitSecs(1);
            
            % hand or control image
            buffer=Screen('MakeTexture', window, imgName);
            Screen('DrawTexture', window, buffer);
            Screen('Flip',window,[]);
            
            t0=toc;
            respMat(8,trial)=t0; % onset
            respMat(9,trial)=trial; % trial
            while t1<D2 % loop till error or space bar or responses are pressed
                
                [~,~,keyCode] = KbCheck; % check for keyboard press
                
                
                if keyCode(stopkey) % if spacebar was pressed stop display
                    break;
                end
                t1=toc-t0;
                if choice==0
                    if keyCode(leftKey) % if spacebar was pressed stop display
                        respMat(5,trial)=-1; % left
                        t2=toc-t0;
                        choice=1;
                    end
                    if keyCode(rightKey) % if spacebar was pressed stop display
                        respMat(5,trial)=1; % right
                        t2=toc-t0;
                        choice=1;
                    end
                end
                
                if choice == 1 && changeToFix==0
                    
                    % up arrow
                    buffer_temp=Screen('MakeTexture', window, img.up);
                    Screen('DrawTexture', window, buffer_temp);
                    Screen('Flip',window,[],1);
                    if trial<n_trials
                        nextTrialIdx=nextTrial(randcomb,trial);
                        if nnz(num2str(nextTrialIdx))==1
                            pahandle=playSound(pahandle,['0' num2str(nextTrialIdx)]);
                        else
                            pahandle=playSound(pahandle,num2str(nextTrialIdx));
                        end
                    end
                    WaitSecs(1);
                    
                    % fixation
                    buffer=Screen('MakeTexture', window, fix);
                    Screen('DrawTexture', window, buffer);
%                     DrawFormattedText(window,'2','center',90);
                    Screen('Flip',window);
                    changeToFix=1;
                    t1=toc-t0;
                    WaitSecs(D2-t1);
                end
            end
            
            if choice == 0
                % up arrow
                buffer_temp=Screen('MakeTexture', window, img.up);
                Screen('DrawTexture', window, buffer_temp);
                Screen('Flip',window,[],1);
                if trial<n_trials
                    nextTrialIdx=nextTrial(randcomb,trial);
                    if nnz(num2str(nextTrialIdx))==1
                        pahandle=playSound(pahandle,['0' num2str(nextTrialIdx)]);
                    else
                        pahandle=playSound(pahandle,num2str(nextTrialIdx));
                    end
                end
                WaitSecs(1);
            end
            
            if choice == 1 % && responded == 0
                if respMat(2,trial)==1 && respMat(5,trial)==1  % write whether correct or not
                    respMat(6,trial)=1;
                elseif respMat(2,trial)==-1 && respMat(5,trial)==-1
                    respMat(6,trial)=1;
                elseif respMat(2,trial)==1 && respMat(5,trial)==-1
                    respMat(6,trial)=0;
                elseif respMat(2,trial)==-1 && respMat(5,trial)==1
                    respMat(6,trial)=0;
                end
                respMat(7,trial)=t2; % RT
                respMat(10,trial)=0; % not too slow
            else
                respMat(5,trial)=NaN;
                respMat(6,trial)=NaN;
                respMat(7 ,trial)=NaN;
                respMat(10,trial)=1; % too slow
            end
            
            trial=trial+1;
        end
        
        if keyCode(stopkey) % if spacebar was pressed stop display
            break;
        end
        
        Screen('Close');
    end
    
    if keyCode(stopkey) % if spacebar was pressed stop display
        break;
    end
end

buffer=Screen('MakeTexture', window, fix);
Screen('DrawTexture', window, buffer);
% DrawFormattedText(window,'final interval','center',90);
pahandle=playSound(pahandle,'finish');
Screen('Flip',window);
WaitSecs(15);
DrawFormattedText(window,'Experiment finished.','center','center');
Screen('Flip',window,[]);
WaitSecs(3);
PsychPortAudio('Stop', pahandle);
PsychPortAudio('Close', pahandle);

% respMat
table=num2cell(respMat);

% Converting table to cell
for i=1:size(table,2)
    if cell2mat(table(1,i))==1
        table{1,i}='visual';
    else
        table{1,i}='tactile';
    end
    
    if cell2mat(table(2,i))==1
        table{2,i}='right';
    else
        table{2,i}='left';
    end
    
    if cell2mat(table(4,i))==1
        table{4,i}='back';
    else
        table{4,i}='palm';
    end
    
    if cell2mat(table(5,i))==1
        table{5,i}='right';
    elseif cell2mat(table(5,i))==-1
        table{5,i}='left';
    end
    
    if cell2mat(table(6,i))==1
        table{6,i}='yes';
    elseif cell2mat(table(6,i))==0
        table{6,i}='no';
    end
    
    if cell2mat(table(10,i))==1
        table{10,i}='yes';
    else
        table{10,i}='no';
    end
end
T = cell2table(table','VariableNames',{'Mode' 'Laterality' 'Orientation' 'Side' 'Response' 'Correct' 'RT' 'Onset' 'Trial' 'Too_slow'})

save(['resultsTable_' char(subjData(1,1)) '_run' char(subjData(2,1))],'T')

% Close window:
sca;