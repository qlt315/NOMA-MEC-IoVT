function z = sparse( i, j, x, m, n )

%   Disciplined convex/geometric programming information for SPARSE:
%       For a CVX variable X, SPARSE(X) just returns X. In the three-
%       and five-argument versions SPARSE(I,J,V,M,N), the index
%       arguments I and J and size arguments M and N must be constant.
%       If any of the index pairs (I(k),J(k)) are repeated, then the
%       corresponding elements V(k) will be added together. Therefore,
%       those elements must be compatible with addition; i.e., they
%       must have the same curvature.

switch nargin,
	case 1,
		z = i;
		return
	case {2,4}
		cvx_throw( 'Not enough arguments.' );
end

%
% Check sizes and indices
%

if ( ~isnumeric( i ) && ~ischar( i ) ) || ( ~isnumeric( j ) && ~ischar( j ) ),
    cvx_throw( 'The first two arguments must be numeric.' );
end
nn = [ numel( i ), numel( j ), prod( x.size_ ) ];
nz = max( nn );
if any( nn(nn~=nz) ~= 1 ),
    cvx_throw( 'Vectors must be the same lengths.' );
end
i = i( : ); j = j( : );
if nargin == 3,
    m = max( i );
    n = max( j );
elseif ( ~isnumeric( m ) && ~ischar( m ) ) || ( ~isnumeric( n ) && ~ischar( n ) ) || n < 0 || m < 0 || n ~= floor( n ) || m ~= floor( m ),
    cvx_throw( 'Sparse matrix sizes must be positive integers.' );
elseif any( i > m ) || any( j > n ),
    cvx_throw( 'Index exceeds matrix dimensions.' );
end

%
% Reconstruct basis matrices and indices
%

[ ix, jx, vx ] = find( x.basis_ );
ij = i + m * ( j - 1 );
if length(ij) > 1,
    ij = ij(jx);
end
xb = sparse( ix, ij, vx, max(ix), m * n );
z = cvx( [ m, n ], xb );

%
% Verify vexity is preserved
%

if ~cvx_isvalid(z),
    cvx_throw( 'Disciplined convex programming error:\n    Sparse matrix construction produced invalid sums of convex and concave terms.' );
end

% Copyright 2005-2014 CVX Research, Inc.
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
