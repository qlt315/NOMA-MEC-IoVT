function cvx_clear

% CVX_CLEAR   Clears all active CVX data.
%    CVX_CLEAR clears the current CVX model in progress. This is useful if, for
%    example, you have made an error typing in your model and wish to start 
%    over. Typing this before entering another CVX_BEGIN again avoids the 
%    warning message that occurs if CVX_BEGIN detects a model in progress.

evalin( 'caller', 'cvx_cleanup( false )' );

% Copyright 2005-2014 CVX Research, Inc.
% See the file LICENSE.txt for full copyright information.
% The command 'cvx_where' will show where this file is located.
