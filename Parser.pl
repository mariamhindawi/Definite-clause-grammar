% sentence structures
s(s(A,B),Y,Z) :- noun_phrase(A,Y,Q), verb_phrases(B,Q,Z).
s(s(A,B,C,D),Y,Z) :- noun_phrase(A,Y,Q), verb_phrases(B,Q,W), conjunction(C,W,E),s(D,E,Z).
s(s(A,B,C,D),Y,Z) :- interrogative_pronoun(A,Y,Q), infinitive_verb(B,Q,W), noun_phrase(C,W,E),infinitive_verb(D,E,Z).
s(s(A,B),Y,Z) :- interrogative_pronoun(A,Y,Q), verb_phrases(B,Q,Z).
s(s(A,B,C,D,E),Y,Z) :- noun_phrase(A,Y,Q), verb_phrases(B,Q,W), object_pronoun(C,W,R), singular_pronoun(D,R,T),verb(E,T,Z).
s(s(A,B,C,D,E),Y,Z) :- noun_phrase(A,Y,Q), verb_phrases(B,Q,W), object_pronoun(C,W,R), noun_phrase(D,R,T),verb(E,T,Z).

% noun phrase structures

% Noun phrases can consist of a noun only eg. box or eg. the box
noun_phrase(noun_phrase(A),Y,Z) :-   noun(A,Y,Z).
noun_phrase(noun_phrase(A,B),Y,Z) :- determiner(A,Y,Q), noun(B,Q,Z).

% Noun phrase can consist of an adjective followed by a noun eg. old box or eg. the old box
noun_phrase(noun_phrase(A,B),Y,Z) :-  adjective_noun_phrase(A,B,Y,Z).
noun_phrase(noun_phrase(A,B,C),Y,Z) :- determiner(A,Y,Q), adjective_noun_phrase(B,C,Q,Z).

% Noun phrase can be followed by a preposition eg. box in  or eg. the box in 
noun_phrase(noun_phrase(A,B,C),Y,Z) :-  noun(A,Y,Q), preposition_noun_phrase(B,C,Q,Z).
noun_phrase(noun_phrase(A,B,C,D),Y,Z) :- determiner(A,Y,Q), noun(B,Q,W), preposition_noun_phrase(C,D,W,Z).

% Noun phrase with adjectives can be followed by a preposition eg. box in or eg. the box in
noun_phrase(noun_phrase(A,B,C,D),Y,Z) :-  adjective_noun_phrase(A,B,Y,Q), preposition_noun_phrase(C,D,Q,Z). 
noun_phrase(noun_phrase(A,B,C,D,E),Y,Z) :- determiner(A,Y,Q), adjective_noun_phrase(B,C,Q,W), preposition_noun_phrase(D,E,W,Z).

% Noun phrase can be separated by a conjunction eg. man and woman or eg. the man and the woman
noun_phrase(noun_phrase(A,B,C),Y,Z) :-  noun(A,Y,Q), conjunction_noun_phrase(B,C,Q,Z).
noun_phrase(noun_phrase(A,B,C,D),Y,Z) :- determiner(A,Y,Q), noun(B,Q,W), conjunction_noun_phrase(C,D,W,Z).

% Noun phrase with adjectives can be separated by a conjunction eg. old man and old woman or eg. the old man and the woman
noun_phrase(noun_phrase(A,B,C,D),Y,Z) :-  adjective_noun_phrase(A,B,Y,Q), conjunction_noun_phrase(C,D,Q,Z).  
noun_phrase(noun_phrase(A,B,C,D,E),Y,Z) :- determiner(A,Y,Q), adjective_noun_phrase(B,C,Q,W), conjunction_noun_phrase(D,E,W,Z).  


% Adjectives structures

adjectives(A,B,C):-adjective(A,B,C).
adjectives(adjectives(A,B),Y,Z):-adjective(A,Y,Q), adjectives(B,Q,Z).

adjective_noun_phrase(A,B,C,D) :- adjectives(A,C,Q), noun(B,Q,D).


% Prepositions structures

preposition_noun_phrase(A,B,C,D):- prepositions(A,C,Q), noun_phrase(B,Q,D).

% Conjunction noun phrases

conjunction_noun_phrase(A,B,C,D):- conjunction(A,C,Q), noun_phrase(B,Q,D). 

% Verb phrases structures

verb_phrases(A,B,C):- verb_phrase(A,B,C).

% Verb phrases can be separated by a conjunction eg. pushed the box and stored the box
verb_phrases(verb_phrases(A,B,C),Y,Z):- verb_phrase(A,Y,Q), conjunction(B,Q,W), verb_phrases(C,W,Z).

% Verb phrase structures

% Verb phrase can consist of one or multiple verbs eg. pushed or eg. pushed and stored and...
verb_phrase(verb_phrase(A),Y,Z) :- verbs(A,Y,Z).

% Verb phrase can consist of verbs followed by a noun phrase eg. stored the box
verb_phrase(verb_phrase(A,B),Y,Z) :- verbs(A,Y,Q), noun_phrase(B,Q,Z).

% Verb phrase consists of a verb followed by multiple noun phrases eg. stored the box in the box
verb_phrase(verb_phrase(A,B,C),Y,Z) :- verbs(A,Y,Q), noun_phrase(B,Q,W), noun_phrase(C,W,Z).

% Verb phrase can consist of adverbs followed by verbs eg. quickly climbed
verb_phrase(verb_phrase(A,B),Y,Z) :- adverbs(A,Y,Q), verbs(B,Q,Z).

% Verb phrase can consist of adverbs followed by verbs then a noun phrase eg. quickly climbed the tree
verb_phrase(verb_phrase(A,B,C),Y,Z) :- adverb_verb_phrase(A,B,Y,Q), noun_phrase(C,Q,Z).

% Verb phrase can consist of verbs followed by adverbs eg. climbed quickly
verb_phrase(verb_phrase(A,B),Y,Z) :- verbs(A,Y,Q), adverbs(B,Q,Z).

% Verb phrase can consist of verbs followed by adverbs then a noun phrase eg. climbed quickly the tree
verb_phrase(verb_phrase(A,B,C),Y,Z) :- verb_adverb_phrase(A,B,Y,Q), noun_phrase(C,Q,Z).

% verbs structure 

% Verbs can consist of one verb or multiple verbs separated by a conjunction eg. pushed and stored
verbs(A,B,C):- verb(A,B,C).
verbs(conjunction_verbs(A,B,C),Y,Z):- verb(A,Y,Q), conjunction(B,Q,W), verbs(C,W,Z). 

%  Adverb structures

adverbs(A,B,C):-adverb(A,B,C).
adverbs(adverbs(A,B),Y,Z):-adverb(A,Y,Q), adverbs(B,Q,Z).
adverbs(adverbs(A,B,C),Y,Z):- adverb(A,Y,Q), conjunction(B,Q,W), adverb(C,W,Z).

adverb_verb_phrase(A,B,C,D) :- adverbs(A,C,Q), verbs(B,Q,D).
verb_adverb_phrase(A,B,C,D) :- verbs(A,C,Q), adverbs(B,Q,D). 


%DICTIONARY

%nouns
noun(noun(boy),[boy|T], T). 
noun(noun(box),[box|T], T). 
noun(noun(room),[room|T], T). 
noun(noun(school),[school|T], T). 
noun(noun(woman),[woman|T], T). 
noun(noun(man),[man|T], T).
noun(noun(envelope),[envelope|T], T).
noun(noun(shed),[shed|T], T). 
noun(noun(building),[building|T], T). 
noun(noun(tree),[tree|T], T). 
noun(noun(girl),[girl|T], T). 
noun(noun(students),[students|T], T).
noun(noun(professors),[professors|T], T). 
noun(noun(lecturers),[lecturers|T], T). 
noun(noun(scientists),[scientists|T], T). 
noun(noun(researchers),[researchers|T], T). 
noun(noun(computer),[computer|T], T). 
noun(noun(chair),[chair|T], T). 
noun(noun(bread),[bread|T], T). 
noun(noun(people),[people|T], T). 
noun(noun(chef),[chef|T], T). 

%verbs
verb(verb(pushed),[pushed|T], T). 
verb(verb(stored),[stored|T], T). 
verb(verb(gave),[gave|T], T). 
verb(verb(climbed),[climbed|T], T). 
verb(verb(watched),[watched|T], T). 
verb(verb(likes),[likes|T], T). 
verb(verb(admired),[admired|T], T). 
verb(verb(appreciated),[appreciated|T], T). 
verb(verb(killed),[killed|T], T). 
verb(verb(baked),[baked|T], T). 
verb(verb(cooked),[cooked|T], T). 
verb(verb(ran),[ran|T], T). 
verb(verb(walked),[walked|T], T). 
verb(verb(slept),[slept|T], T). 
verb(verb(destroyed),[destroyed|T], T). 
verb(verb(played),[played|T], T). 
verb(verb(viewed),[viewed|T], T). 
verb(verb(typed),[typed|T], T). 
verb(verb(understood),[understood|T], T). 
verb(verb(ate),[ate|T], T). 

%adjectives 
adjective(adjective(young),[young|T], T). 
adjective(adjective(big),[big|T], T). 
adjective(adjective(large),[large|T], T). 
adjective(adjective(empty),[empty|T], T). 
adjective(adjective(old),[old|T], T). 
adjective(adjective(poor),[poor|T], T).
adjective(adjective(white),[white|T], T). 
adjective(adjective(brilliant),[brilliant|T], T). 
adjective(adjective(talented),[talented|T], T). 
adjective(adjective(bright),[bright|T], T). 
adjective(adjective(beautiful),[beautiful|T], T). 
adjective(adjective(pretty),[pretty|T], T). 
adjective(adjective(tasty),[tasty|T], T). 
adjective(adjective(smart),[smart|T], T). 
adjective(adjective(crazy),[crazy|T], T). 
adjective(adjective(tall),[tall|T], T). 
adjective(adjective(short),[short|T], T). 
adjective(adjective(rich),[rich|T], T). 
adjective(adjective(small),[small|T], T). 
adjective(adjective(blue),[blue|T], T). 
adjective(adjective(new),[new|T], T). 

%prepositions
prepositions(prepositions(in),[in|T], T). 
prepositions(prepositions(after),[after|T], T). 
prepositions(prepositions(behind),[behind|T], T). 
prepositions(prepositions(on),[on|T], T). 
prepositions(prepositions(under),[under|T], T). 
prepositions(prepositions(over),[over|T], T). 

%determiners
determiner(determiner(the),[the|T], T).
determiner(determiner(a),[a|T], T). 
determiner(determiner(every),[every|T], T).
determiner(determiner(some),[some|T], T). 
determiner(determiner(many),[many|T], T). 

%conjunctions
conjunction(conjunction(and),[and|T], T). 
conjunction(conjunction(but),[but|T], T). 

%adverbs
adverb(adverb(quickly),[quickly|T], T).
adverb(adverb(slowly),[slowly|T], T).
adverb(adverb(suddenly),[suddenly|T], T).
adverb(adverb(beautifully),[beautifully|T], T).
adverb(adverb(carefully),[carefully|T], T).
adverb(adverb(perfectly),[perfectly|T], T).
adverb(adverb(easily),[easily|T], T).
adverb(adverb(hardly),[hardly|T], T).
adverb(adverb(happily),[happily|T], T).
adverb(adverb(cheerfully),[cheerfully|T], T).

%object_pronouns
object_pronoun(object_pronoun(whom),[whom|T], T).

%singular_pronouns
singular_pronoun(singular_pronoun(she),[she|T], T).

%interrogative_pronouns
interrogative_pronoun(interrogative_pronoun(who),[who|T], T). 
interrogative_pronoun(interrogative_pronoun(what),[what|T], T). 

%infinitive_verbs
infinitive_verb(infinitive_verb(do),[do|T], T).
infinitive_verb(infinitive_verb(did),[did|T], T).