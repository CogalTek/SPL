% Paires possibles (horizontal et vertical)
pair(X, Y, X, Y1) :- cell(X, Y, _), cell(X, Y1, _), Y1 = Y + 1. % Horizontal
pair(X, Y, X1, Y) :- cell(X, Y, _), cell(X1, Y, _), X1 = X + 1. % Vertical
pair(X2, Y2, X1, Y1) :- pair(X1, Y1, X2, Y2). % Symétrie

% Sélectionner une paire par cellule
1 { used_pair(X1, Y1, X2, Y2) : pair(X1, Y1, X2, Y2) } 1 :- cell(X1, Y1, _).

% Définir les dominos à partir des paires sélectionnées
domino(V1, V2) :-
    used_pair(X1, Y1, X2, Y2),
    cell(X1, Y1, V1),
    cell(X2, Y2, V2),
    V1 <= V2.

% Comptage des occurrences des dominos
count(V1, V2, Count) :-
    domino(V1, V2),
    #count{ X1, Y1, X2, Y2 : 
        used_pair(X1, Y1, X2, Y2), 
        cell(X1, Y1, VA), 
        cell(X2, Y2, VB),
        V1 = min(VA, VB),
        V2 = max(VA, VB)
    } = Count.

% Empêcher les chevauchements
:- used_pair(X1, Y1, X2, Y2), 
   used_pair(X1, Y1, X3, Y3), 
   (X2, Y2) != (X3, Y3).

% Formater la sortie pour afficher pair/4
% pair(R1, C1, R2, C2) :- used_pair(R1, C1, R2, C2), R1 <= R2, (R1 <> R2; C1 <= C2).

% Afficher uniquement les paires au format pair/4
#show pair/4.
