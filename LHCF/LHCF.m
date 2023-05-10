function Aff = LHCF(X, opts)
% A matlab implementation for robust subspace clustering by LHCF
% If you use this code, please cite it:
% @ARTICLE{10113174,
%   author={Cao, Lei and Shi, Long and Wang, Jun and Yang, Zhendong and Chen, Badong},
%   journal={IEEE Signal Processing Letters}, 
%   title={Robust Subspace Clustering by Logarithmic Hyperbolic Cosine Function}, 
%   year={2023},
%   volume={30},
%   number={},
%   pages={508-512},
%   doi={10.1109/LSP.2023.3271828}}
%
% Input:
%       X: data matrix, size=d*n;
%       opts: option value
%           opts.num_iter: default number of iterations;
%           opts.err_thr: error threshold at convergence;
%           opts.lambda: balanced parameter;
%           opts.alpha: scaling factor;
%
% Output:
%       Aff: affinity matrix, size=n*n;

%% Initialization
if ~isfield(opts, 'num_iter')
    opts.num_iter = 200;
end
if ~isfield(opts, 'err_thr')
    opts.err_thr = 10.^-5;
end
if ~isfield(opts,'lambda')
    opts.lambda = 20;  % default
end
if ~isfield(opts,'alpha')
    opts.alpha = 1;  % default
end

n = size(X, 2); % number of samples
Z = zeros(n, n);
%% Start iterating
iter = 0;
converged = false;
while iter < opts.num_iter && ~converged
    iter = iter + 1;
    Z_prev = Z;
    Z = update_para(X, Z, opts.lambda, opts.alpha);
    % Checking convergence
    converged = true;
    err = max(max(abs(Z_prev - Z)));
    if err > opts.err_thr
        converged = false;
    end
end
%% Obtaining the affinity matrix
Aff = (abs(Z) + abs(Z')) / 2;

end

