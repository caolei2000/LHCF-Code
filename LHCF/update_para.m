function Z = update_para(X, Z, lambda, alpha)
% Update R, Q, Z by eq(8)
% Input£º
%       X: data matrix, size=d*n;
%       Z: representation matrix, size=n*n;
% Output£º
%       Z: representation matrix, size=n*n;

U = X - X * Z;  % update R
V = alpha*tanh(alpha*norm(U,"fro").^2);  % update Q
n = size(X, 2);
i = eye(n);
Z = (V*(X'*X)+lambda*i) \ (V*(X'*X));  % update Z

end

