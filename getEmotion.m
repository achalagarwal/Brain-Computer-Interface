function [ emotion ] = getEmotion( state )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

v = state(1,1);
a = state(1,2);
%excited-1, nervous-2, depressed-3, serene-4
if v>5
    if a>5
        emotion = 1;
    else if a<=5
            emotion = 4;
        end
    end
else if v<=5
        if a>5
            emotion = 2;
        else if a<=5
                emotion = 3;
            end
        end
    end
end
        


