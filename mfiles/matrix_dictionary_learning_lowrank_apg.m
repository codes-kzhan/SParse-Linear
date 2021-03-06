function [B iter] = matrix_dictionary_learning_lowrank_apg(B, XAt, AAt,...
								numRows, numSamples, mu, kappa, tolerance,...
								delta, numIters, eta)

if ((nargin < 7) || isempty(kappa)),
	kappa = 0;
end;

if ((nargin < 8) || isempty(tolerance)),
	tolerance = 10 ^ - 6;
end;

if ((nargin < 9) || isempty(delta)),
	delta = 10 ^ - 5;
end;

if ((nargin < 10) || isempty(numIters)),
	numIters = 50000;
end;

if ((nargin < 11) || isempty(eta)),
	eta = 0.9;
end;

[MN K] = size(XAt);
N = MN / numRows;
M = numRows;

if (isempty(B)),
	B = zeros(MN, K);
end;
Bkm1 = zeros(MN, K);
YB = zeros(MN, K);
DA = zeros(MN, K);
S = zeros(MN, K);
Lf = diag(AAt) / numSamples + kappa;
Lf = Lf';

tk = 1;
tkm1 = 1;
muk = mu / delta;
iter = 0;

while (1),
	YB = (tk + tkm1 - 1) / tk * B - (tkm1 - 1) / tk * Bkm1;
	DA = 1 / numSamples * (YB * AAt - XAt);

	Bkm1 = B;
	B = repmat((1.0 - 0.5 * kappa ./ Lf), [MN 1]) .* YB...
		- 0.5 * repmat(1.0 ./ Lf, [MN, 1]) .* DA;
	S = 2.0 * repmat(Lf, [MN, 1]) .* B;
	for iterK = 1:K,
		B(:, iterK) = vec(nuclear_proximal(reshape(B(:, iterK), [M N]), 0.5 * muk / Lf(iterK)));
	end;
	S = S - 2.0 * repmat(Lf, [MN, 1]) .* B;
	normsum = sqrt(sum(S(:) .^ 2));
	
	tkm1 = tk;
	tk = (1.0 + sqrt(4.0 * tkm1 ^ 2 + 1)) / 2.0;
	muk = max(eta * muk, mu);
	
	if (normsum / K < tolerance),
		break;
	end;

	iter = iter + 1;
% 	if (mod(iter, 1000) == 0),
		disp(iter);
% 	end;
	if (iter == numIters),
		break;
	end;
end;
