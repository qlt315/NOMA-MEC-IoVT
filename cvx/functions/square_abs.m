function y = square_abs( x )

%SQUARE_ABS   Square of absolute value.
%   For real X, SQUARE_ABS(X) produces the same result as SQUARE(X); that
%   is, it squares the elements of X. For complex X, SQUARE_ABS(X) returns
%   a real array whose elements are the squares of the magnitudes of the
%   elements of X; that is, SQUARE_ABS(X) = CONJ(X).*X.
%
%   Disciplined convex programming information:
%       SQUARE_ABS(X) is convex and nonmonotonic in X. Thus when used in 
%       CVX expressions, X must be affine.

y = square( cvx_linearize( x, 'cabs' ) );

% Copyright 2005-2014 CVX Research, Inc. 
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
