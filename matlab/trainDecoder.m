function decodingStruct = trainDecoder(eventMatrix, positionVec)

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
% positionVec : binned positional information. Range is from 1 to
%   maximum bin number.
%       - Vector containing binned position information for the same
%       time period as eventMatrix. Size is [nFrames 1] or [1 nFrames].

%%% OUTPUTS
% decodingStruct : structure containing all parts of the constructed
%     Bayesian decoder as described in Ziv et. al., Nature Neuroscience 2013.
%     This is input into testDecoder for testing.



numTrainPoints = size(eventMatrix, 1);  %nFrames
numFeatures = size(eventMatrix, 2); %nCells

% addition terms inside each probability calculation are for laplacian
% smoothing: takes care of occasional lack of examples of combinations
%the 3 lines below are for establishing the intial values of probs then
%we update then, these are basically matrices telling you the probability
%for each position and each cell 
%lick

%logProb1givenPos=-100*ones(max(positionVec), numFeatures);
%logProb0givenPos=-100*ones(max(positionVec), numFeatures);
%logProbPos=-100*ones(max(positionVec),1);

positions=unique(positionVec);
for pos=positions
   theseExamples=eventMatrix(positionVec==pos,:);
   %essentially the probability that we get events in postion i i.e. the
   %sum of all events in position i divided by the size of position i - 
   %so the number of position is/ in english: sum of events in position i
   %divided by the size of position i or the number of rows corresponsn
   %problem with this sum(theseExamples) will always be equal to
   %size(theseExamples,1) or will always be one
   %logProb1givenPos will always be the same if we use the max as the event
   logProb1givenPos(pos, :)=log(sum(theseExamples,1)+1)-log(size(theseExamples,1)+2);
   logProb0givenPos(pos, :)=log(sum(1-theseExamples,1)+1)-log(size(theseExamples,1)+2);
   %below is the probability of position of being in positions i 
   logProbPos(pos)=log(size(theseExamples,1)+1)-log(numTrainPoints+max(positionVec)-min(positionVec)); 
end

%overall probability of getting an event or non event per cell 
logProbX1=log(sum(eventMatrix, 1)+1)-log(numTrainPoints);       % 1 x numfeatures
logProbX0=log(sum(1-eventMatrix, 1)+1)-log(numTrainPoints);

decodingStruct.logProb1givenPos=logProb1givenPos;
decodingStruct.logProb0givenPos=logProb0givenPos;
decodingStruct.logProbPos=logProbPos;
decodingStruct.logProbX1=logProbX1;
decodingStruct.logProbX0=logProbX0;