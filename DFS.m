function [runtime] = DFS(P) % iterative, the lack of FIFO queue makes recursive difficult
tic
runtime = 0; % good reference point for if finished yet
Puzzle = [1 2 3 4 5 6 7 8 9];
if (isSolvable(Puzzle) == 0)
    disp('INVALID PUZZLE');
    return
end


% the issue here being that if it's recursive, I need a FIFO queue
% if it's iterative, I need a LIFO queue
% neither exist in MATLAB

% using http://en.wikipedia.org/wiki/Depth-first_search psuedocode as reference




function [queue] = enqueue(queue, value) 
queue(end+1, :) = value;

function [value queue] = dequeue(queue)
value = queue(1,:);
queue(1, :) = [];

function [isSolvable] = isSolvable(state)
isSolvable = 0;
state(state==9)=0;
for i = 1:9
    for j = 1:9
        if (j > i)
            if (state(i) > state(j))
                isSolvable = isSolvable + 1;
            end
        end
    end
end
disp(isSolvable);
    if (mod(isSolvable,2) == 0)
        isSolvable = 1;
        return
    end
    isSolvable = 0;


function [isGoalState] = checkState(state)
isGoalState = 1;
for i = 1:8
   if ((state(i+1) - state(i)) ~= 1)
       isGoalState = 0;
       return
   end
    
end

function [index] = findBlank(state)

for i = 1:9
   if (state(i) == 9)
       index = i;
       return
   end
    
end

function [validMoves] = findValidMoves(index)
%Is up a valid move?
validMoves = [1 1 1 1];
if (index <= 3 )
   validMoves(1) = 0;
end
%Is down a valid move?
if (index >= 7 )
   validMoves(2) = 0;
end
%Is left a valid move?
if (mod((index-1),3) == 0)
   validMoves(3) = 0;
end
%Is right a valid move?
if (mod((index),3) == 0)
   validMoves(4) = 0;
end
