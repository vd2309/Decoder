function [decodedPos, logProbOfPos] = testDecoder(eventMatrix, decodingStruct)

%%% Written by Lacey Kitch in 2012-2014

%%% INPUTS
% eventMatrix : binary neuron event timings.
%       - Binary (logical or single or double) matrix indicating eventTimes.
%       Size is [nFrames nCells], and entry is 1 at one time point for each
%       event, and 0 otherwise.
%       - NOTE: often bayesian decoding with imaging data requires the use
%       of past bursting information as features. In this case
%       (non-instantaneous decoding), one needs to include these features
%       in eventMatrix. Use makeDecodingMatrices function to do this, or use
%       crossValidateDecoder to avoid the hassle of calculating it
%       yourself.
% decodingStruct : output from trainDecoder. Structure containing all parts
%   of the constructed Bayesian decoder as described in 
%   Ziv et. al., Nature Neuroscience 2013. (Lacey Kitch)

%%% OUTPUTS

% decodedPos : decoded binned position. Range is from 1 to
%   maximum bin number, and bins match position input into trainDecoder.
%       - Vector containing binned position information for the same
%       time period as eventMatrix. Size is [nFrames 1] or [1 nFrames].
% lodProbOfPos : log probability of each positional bin at each timepoint.
%   decodedPos is the bin where logProbOfPos is maximal at each timepoint.



numTestPoints=size(eventMatrix,1);
decodedPos=zeros(1,numTestPoints); % 1 by n vector
logProbOfPos=zeros(1,numTestPoints); % 1 by n vector 

%intuitive definitions
%logProb1givenPos  prob of event happening for each cell within position i where i = 1:nrow
%logProb0givenPos  prob of no event happening for each cell within position where i = 1:nrow
%logProbPos prob of being in postion i over all 
%logProbX1 prob of an event happening
%logProbX0 prob of no event happening

%sizes
%logProb1givenPos  [max bin value by numCells]
%logProb0givenPos  [max bin value by numCells]
%logProbPos [max bin value by 1]
%logProbX1 [1 by numCells]
%logProbX0 [1 by numCells]

logProb1givenPos=decodingStruct.logProb1givenPos; 
logProb0givenPos=decodingStruct.logProb0givenPos;
logProbPos=decodingStruct.logProbPos;
logProbX1=decodingStruct.logProbX1;
logProbX0=decodingStruct.logProbX0;

posValues=1:length(logProbPos);
logProb=zeros(numTestPoints, length(logProbPos));
for posInd=posValues
    %prob that youll have an event in pos i + prob no event in pos i + prob
    %of being in position i - prob of having an event + prob no event
    logProb(:,posInd)=eventMatrix*logProb1givenPos(posInd,:)'+...
        (1-eventMatrix)*logProb0givenPos(posInd,:)'+...
        logProbPos(posInd)-(eventMatrix*logProbX1'+(1-eventMatrix)*logProbX0');
    % this whole expression above yields and [nframes by 1] vector
end

for posInd=1:length(decodedPos)
    [maxLogProb,maxInd]=max(logProb(posInd,:));
    % the position is the index
    decodedPos(posInd)=maxInd;
    %the probability is the value
    logProbOfPos(posInd)=maxLogProb;
end