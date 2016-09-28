function eventTimes = convertEventMatToCell(eventMat, nTrials)

%%% Written by Lacey Kitch in 2012-2014
%% so is the number of trials equal to the number of cells?
nCells=size(eventMat,1);
eventTimes=cell(nTrials,1);
for cInd=1:nCells
    
    eventTimes{cInd}=find(eventMat(cInd,:));
    
end