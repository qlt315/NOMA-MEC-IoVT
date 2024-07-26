function z = mpower( x, y )

%   Disciplined convex/geometric programming information for MPOWER (^):
%      The CVX version of the matrix power function Z=X.^Y supports only
%      the case where X and Y are scalars. In such instances, the rules
%      are identical to those outlined in the help for CVX/POWER.

if length( x ) > 1 && length( y ) > 1,
    cvx_throw( 'Disciplined convex programming error:\n    Matrix powers not permitted.' );
end
z = power( x, y, '^' );

% Copyright 2005-2014 CVX Research, Inc.
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
