function params = setParameters(Phi)

allVerboseMode = 1;

% dictionary parameters
dictionarySize = 600;
dictionaryMethod = 'gradient';
dictionaryKappa = 6;
dictionaryLambda = 0.15;
dictionaryBlockRatio = 0;
dictionaryNoiseSTD = 0.05;
dictionarySensMethod = 'orig';
dictionaryClearing = 1;
dictionaryNumIters2 = 10;

% other dictionary
if (strcmp(dictionaryMethod, 'coupledmemory') || strcmp(dictionaryMethod, 'coupledgradient')),
	dictionaryNumIters = 50;
	dictionaryAlpha = 1 / 33;
else
	dictionaryNumIters = 50;
	dictionaryAlpha = 1 / 32;
end;

% Gaussian, exponential, and kernel
dictionaryNoiseModel = 0;
expFamily = 'P';
kernelType = 'G';	
kernelParam1 = 1;
kernelParam2 = 1;

% coding parameters
codingMethod = 'lasso';
codingKappa = 6;
codingLambda = 0.15;
codingEpsilon = 0.0001;
codingMode = 1;

% support-vector machine parameters
svmUseBias = 1;
% svmLambda = 0.1;
svmLambda = [.0000001 .000001 .00001, .0001, .001, .01, .1, 1, 10, 100, 1000];
% svmLambda = [.0001, .001, .01, .1, 1, 10, 100, 1000 10000 100000 1000000];
% svmLambda = [.001, .01, .1, 1, 10];
svmCramerSingerApprox = 1;
svmNuclearApprox = 0.01;
svmNumIters = 300;
svmLossFunction = 'huber';
svmPreprocessMode = 1;
svmProbabilityEstimates = 0;
svmRegularization = 'frobenius';

% projections
compressNumSamples = 512;

% text datasets
textDataSet = 'tng';
textVocabulary = 'tng';
textSelectionMethod = 'counts';
textNumWords = 100;

params = sparseClassificationParams(...
	'allVerboseMode', allVerboseMode,...
	'dictionaryMethod', dictionaryMethod,...
	'dictionaryKappa', dictionaryKappa,...
	'dictionaryLambda', dictionaryLambda,...
	'dictionarySize', dictionarySize,...
	'dictionaryBlockRatio', dictionaryBlockRatio,...
	'dictionaryNumIters', dictionaryNumIters,...
	'dictionaryNumIters2', dictionaryNumIters2,...
	'dictionarySensMethod', dictionarySensMethod,...
	'dictionaryAlpha', dictionaryAlpha,...
	'dictionaryNoiseSTD', dictionaryNoiseSTD,...
	'dictionaryClearing', dictionaryClearing,...
	'dictionaryNoiseModel', dictionaryNoiseModel,...
	'expFamily', expFamily,...
	'kernelType', kernelType,...
	'kernelParam1', kernelParam1,...
	'kernelParam2', kernelParam2,...
	'codingMethod', codingMethod,...
	'codingMode', codingMode,...
	'codingKappa', codingKappa,...
	'codingLambda', codingLambda,...
	'codingEpsilon', codingEpsilon,...
	'compressNumSamples', compressNumSamples,...
	'svmPreprocessMode', svmPreprocessMode,...
	'svmLossFunction', svmLossFunction,...
	'svmUseBias', svmUseBias,...
	'svmProbabilityEstimates', svmProbabilityEstimates,...
	'svmLambda', svmLambda,...
	'svmCramerSingerApprox', svmCramerSingerApprox,...
	'svmNuclearApprox', svmNuclearApprox,...
	'svmNumIters',  svmNumIters,...
	'textDataSet', textDataSet,...
	'textVocabulary', textVocabulary,...
	'textSelectionMethod', textSelectionMethod,...
	'textNumWords', textNumWords);
