function imgName=loadFigure(randcomb,trial,img,mode)

idx=1;

switch randcomb(1+idx,trial) % laterality 
    case -1
        if randcomb(2+idx,trial)==0 % orientation
            if randcomb(3+idx,trial)==-1 % side
                if strcmp(mode,'visual')
                    imgName=img.s01;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s02;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        elseif randcomb(2+idx,trial)==90
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s03;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s04;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        elseif randcomb(2+idx,trial)==180
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s05;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s06;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        else
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s07;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s08;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        end
    case 1
        if randcomb(2+idx,trial)==0
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s09;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s10;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        elseif randcomb(2+idx,trial)==90
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s11;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s12;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        elseif randcomb(2+idx,trial)==180
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s13;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s14;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        else
            if randcomb(3+idx,trial)==-1
                if strcmp(mode,'visual')
                    imgName=img.s15;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            else
                if strcmp(mode,'visual')
                    imgName=img.s16;
                elseif strcmp(mode,'tactile')
                    imgName=img.ctrl;
                end
            end
        end
end