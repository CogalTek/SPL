% --- Domain definition ---

% Define valid pairs between adjacent cells (horizontal and vertical)
pair(X,Y,X,Y1) :- cell(X,Y,_), cell(X,Y1,_), Y1 = Y + 1.
pair(X,Y,X1,Y) :- cell(X,Y,_), cell(X1,Y,_), X1 = X + 1.

% Make pairs symmetric
pair(X2,Y2,X1,Y1) :- pair(X1,Y1,X2,Y2).

% Each cell must belong to exactly one pair
1 { used_pair(X1,Y1,X2,Y2) : pair(X1,Y1,X2,Y2) } 1 :- cell(X1,Y1,_).

% Create dominos from paired cells (ensure values are ordered for uniqueness)
domino(V1,V2) :- 
    used_pair(X1,Y1,X2,Y2),
    cell(X1,Y1,V1),
    cell(X2,Y2,V2),
    V1 <= V2.

% Each domino value combination should appear exactly once
:- domino(V1,V2), #count{ X1,Y1,X2,Y2 : 
    used_pair(X1,Y1,X2,Y2),
    cell(X1,Y1,VA),
    cell(X2,Y2,VB),
    V1 = min(VA,VB),
    V2 = max(VA,VB)
} != 1.

% Prevent overlapping pairs
:- used_pair(X1,Y1,X2,Y2), 
   used_pair(X1,Y1,X3,Y3), 
   (X2,Y2) != (X3,Y3).

% Output
#show used_pair/4.