domains
    s = string
    int = integer
predicates
 nondeterm man (s)
 nondeterm woman (s)
 nondeterm parent (s, s)
 %nondeterm  cousin (s, s)
 nondeterm  grandson(s,s)
 nondeterm  grandrgandson(s,s)
 nondeterm  aunt(s,s)
 nondeterm married (s, s)
 nondeterm mother_in_law(s,s)
 nondeterm second_coustin_aunt (s,s)
 nondeterm sister (s, s)
 nondeterm   brother (s, s)
 nondeterm   niece (s, s)
 nondeterm cousina(s, s)
 nondeterm uncle(s, s)
 nondeterm secondcousina(s, s)
 nondeterm daughter (s,s)
 nondeterm kid (s,s)
 %nondeterm granddaughter (s,s)
% nondeterm husbands_father (s,s)
 
 
 
 
 
clauses
    man ("mohamed").
    man ("Mahmud").
    man ("Omar").
    man ("Ahmed").
    man ("Mostafa").
    man ("MohamedOmar").
    man ("basem").
    man ("hazem").
    man ("Abdo").
    man ("Kadafe").
    man ("Adel").
        
    woman ("Ayman").
    woman ("Fayza").
    woman ("Warda").
    woman ("Aya").
    woman ("Doha").
    woman ("Asma").
    woman ("Aml").
    woman ("Amira").
    
    parent ("Kadafe", "Mohamed").
    parent ("Kadafe", "Ayman").
    
    parent ("Ayman", "Basem").
    
    
    parent ("Basem", "Hazem").
    %parent ("Basem", "Omar").
    
    parent ("Hazem", "Asma").
    
    parent ("Mohamed", "Omar").
    
    parent ("Omar", "MohamedOmar").
    parent ("Omar", "Mostafa").
    parent ("Omar", "Aya").
    parent ("Fayza", "MohamedOmar").
    parent ("Fayza", "Mostafa").
    parent ("Fayza", "Aya").
    
    parent ("Abdo", "Fayza").
    parent ("Abdo", "WardaW").
    
    parent ("MohamedOmar", "Ahmed").
    parent ("MohamedOmar", "Doha").
    
    parent ("Amyra", "Ahmed").
    parent ("Amyra", "Doha").
    
    
    
    
    married ("Omar", "Fayza").
    married ("MohamedOmar", "Amyra").
   


    sister (S,X):-parent(P,S), parent(P,X), S<>X, woman(S).
    brother (B,X):-parent(P,B), parent(P,X), B<>X, man(B).
    niece (N,X):-parent(P,N), sister(P,X), woman(N).
    niece (N,X):-parent(P,N), brother(P,X), woman(N).
    aunt (A,X):-niece(X,A), woman(A).
    
    kid(X,Y):-parent(Y,X).
    grandson(X,Y):- parent(Y,Z),parent(Z,X),man(X).
    
    grandrgandson(X,Y):-parent(Y,Z),parent(Z,L),parent(L,X),man(X).
    daughter(Z,X):-parent(X,Z),woman(Z).
    second_coustin_aunt(V,Z):-parent(X,L),parent(X,K),parent(L,N),parent(K,M),parent(N,Q)
    ,parent(M,Z),parent(Q,V),parent(Z,C),man(Q),man(C),woman(Z),woman(V),not (V=Z).  
    uncle(X,Z):-parent(V,Z),brother(X,V).
   cousina(T,Z):-uncle(X,Z),daughter(T,X).
   secondcousina(Y,C):-cousina(Z,X),daughter(Y,Z),kid(C,X).
    
    mother_in_law(X,Y):- married(Z,X),parent(Y,Z),man(Z),woman(Y).
    
    
    
    goal
     %t_uncle(X,Y).
     %d_uncle("Bulat",Z).
     %uncle_m("Ilnur",Y).
     %second_cousin_uncle(X,Y),nl.
     %n_uncle(3,"Jozefina",Y).
     secondcousina(X,Y).
    