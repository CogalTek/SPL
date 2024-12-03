% --- Génération des paires possibles ---
pair(X, Y, X, Y1) :- cell(X, Y, _), cell(X, Y1, _), Y1 = Y + 1. % Horizontal
pair(X, Y, X1, Y) :- cell(X, Y, _), cell(X1, Y, _), X1 = X + 1. % Vertical
pair(X2, Y2, X1, Y1) :- pair(X1, Y1, X2, Y2). % Symétrie

% --- Sélection d'une paire par cellule ---
1 { used_pair(X1, Y1, X2, Y2) : pair(X1, Y1, X2, Y2) } 1 :- cell(X1, Y1, _).

% --- Définir les valeurs de dominos ---
domino_values(X1, Y1, X2, Y2, V1, V2) :-
    used_pair(X1, Y1, X2, Y2),
    cell(X1, Y1, VA),
    cell(X2, Y2, VB),
    V1 = VA,
    V2 = VB.

% Assurez-vous que V1 <= V2
domino(V1, V2) :-
    domino_values(_, _, _, _, V1, V2),
    V1 <= V2.

% --- Comptage des occurrences des dominos ---
count(V1, V2, Count) :-
    domino(V1, V2),
    #count{X1, Y1, X2, Y2 : domino_values(X1, Y1, X2, Y2, V1, V2)} = Count.

:- domino(V1, V2),
   #count{X1, Y1, X2, Y2 : domino_values(X1, Y1, X2, Y2, V1, V2)} != 1.

% --- Empêcher les chevauchements ---
:- used_pair(X1, Y1, X2, Y2), 
   used_pair(X1, Y1, X3, Y3), 
   (X2, Y2) != (X3, Y3).

% --- Formater la sortie pour afficher pair/4 ---
pair(R1, C1, R2, C2) :-
    used_pair(R1, C1, R2, C2),
    R1 < R2.

pair(R1, C1, R2, C2) :-
    used_pair(R1, C1, R2, C2),
    R1 == R2,
    C1 <= C2.

% --- Débogage ---
debug_pair(X1, Y1, X2, Y2) :- pair(X1, Y1, X2, Y2).
debug_used_pair(X1, Y1, X2, Y2) :- used_pair(X1, Y1, X2, Y2).
debug_domino(V1, V2) :- domino(V1, V2).
debug_count(V1, V2, Count) :- count(V1, V2, Count).

% --- Afficher pour le débogage ---
% #show debug_pair/4.
% #show debug_used_pair/4.
% #show debug_domino/2.
% #show debug_count/3.
#show pair/4.
