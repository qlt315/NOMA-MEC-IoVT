function y = pow_abs( x, p )

%POW_POS   Power of absolute value.
%   POW_POS(X,P) = ABS(X).^P. 
%   P must be real and greater than or equal to one.
%
%   Disciplined convex programming information:
%       POW_ABS(X,P) is convex and nonmonotonic, so X must be affine.
%       P must be constant, and its elements must be greater than or
%       equal to one. X may be complex.

y = power( abs( x ), p );

% Copyright 2005-2014 CVX Research, Inc. 
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
