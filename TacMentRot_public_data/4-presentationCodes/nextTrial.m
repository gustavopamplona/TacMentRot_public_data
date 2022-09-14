function nextTrialIdx=nextTrial(randcomb,trial)

trial=trial+1;
if randcomb(1,trial)==1
    mode='visual';
else
    mode='tactile';
end

switch randcomb(2,trial) % laterality
    case -1
        if randcomb(3,trial)==0 % orientation
            if randcomb(4,trial)==-1 % side
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=1;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=2;
                end
            end
        elseif randcomb(3,trial)==90
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=3;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=4;
                end
            end
        elseif randcomb(3,trial)==180
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=5;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=6;
                end
            end
        else
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=7;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=8;
                end
            end
        end
    case 1
        if randcomb(3,trial)==0
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=9;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=10;
                end
            end
        elseif randcomb(3,trial)==90
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=11;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=12;
                end
            end
        elseif randcomb(3,trial)==180
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=13;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=14;
                end
            end
        else
            if randcomb(4,trial)==-1
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=15;
                end
            else
                if strcmp(mode,'visual')
                    nextTrialIdx=17;
                elseif strcmp(mode,'tactile')
                    nextTrialIdx=16;
                end
            end
        end
end