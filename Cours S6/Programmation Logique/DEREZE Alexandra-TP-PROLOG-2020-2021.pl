# Structures

professeur(nom, prenom, discipline, identifiant)
eleve(nom, prenom, niveau, identifiant)
salle(nom, capacite, type, identifiant)
matiere(nom, discipline, type, niveau, identifiant)
groupe(nom, niveau, liste-eleves, identifiant)
seance(matiere, prof, groupe, salle, creneau, identifiant)

:-dynamic professeur/4.
:-dynamic eleve/4.
:-dynamic salle/4.
:-dynamic matiere/5.
:-dynamic groupe/4.
:-dynamic seance/6.


#Question 1

ajouter_professeur(Nom, Prenom, Discipline, Id):- not(professeur(Nom, Prenom, Discipline, _)),
						  not(professeur(_, _, _, Id)), 
						  assert(professeur(Nom, Prenom, Discipline, Id))

supprimer_professeur(Nom, Prenom, Discipline, Id):- professeur(Nom, Prenom, Discipline, Id),retract(professeur(Nom, Prenom, Discipline, Id))

ajouter_eleve(Nom, Prenom, Niveau, Id):- not(eleve(Nom, Prenom, Niveau, _)), not(eleve(_, _, _, Id)), assert(eleve(Nom, Prenom, Niveau, Id))

supprimer_eleve(Nom, Prenom, Niveau, Id):- eleve(Nom, Prenom, Niveau, Id), retract(eleve(Nom, Prenom, Niveau, Id))

ajouter_salle(Nom, Capacite, Type, Id):- not(salle(Nom, Capacite, Type,_)),not(salle(_, _, _, Id)), assert(salle(Nom, Capacite, Type, Id))

supprimer_salle(Nom, Capacite, Type, Id):- salle(Nom, Capacite, Type, Id), retract(salle(Nom, Capacite, Type, Id))

ajouter_matiere(Nom, Discipline, Type, Niveau, Id):- not(matiere(Nom, Discipline, Type, Niveau, _)),not(matiere(_, _, _, _, Id)), assert(matiere(Nom, Discipline, Type, Niveau, Id))

supprimer_matiere(Nom, Discipline, Type, Niveau, Id):- matiere(Nom, Discipline, Type, Niveau, Id), retract(matiere(Nom, Discipline, Type, Niveau, Id))

ajouter_groupe(Nom, Niveau, ListeEleve, Id):- not(groupe(Nom, Niveau, ListeEleve, _)),not(groupe(_, _, _, Id)), assert(groupe(Nom, Niveau, ListeEleve, Id))

supprimer_groupe(Nom, Niveau, ListeEleve, Id):- groupe(Nom, Niveau, ListeEleve, Id), retract(groupe(Nom, Niveau, ListeEleve, Id))

ajouter_seance(Matiere, Prof, Groupe, Salle, Creneau, Id):- not(seance(Matiere, Prof, Groupe, Salle, Creneau, _)),not(seance(_, _, _, _, _, Id)), assert(seance(Matiere, Prof, Groupe, Salle, Creneau, Id))

supprimer_seance(Matiere, Prof, Groupe, Salle, Creneau, Id):- seance(Matiere, Prof, Groupe, Salle, Creneau, Id), retract(seance(Matiere, Prof, Groupe, Salle, Creneau, Id))"

#Question 2

ajouter_eleve_groupe(eleve(NomEleve, PrenomEleve, NiveauEleve, IdEleve), groupe(NomGroupe, NiveauGroupe, ListeEleve, IdGroupe)):- eleve(_, _, _, IdEleve), groupe(_, _, _, IdGroupe), supprimer_groupe(NomGroupe, NiveauGroupe, ListeEleveGroupe, IdGroupe),  ajouter_groupe(NomGroupe, NiveauGroupe, [eleve(_, _, _, IdEleve)|ListeEleveGroupe], IdGroupe)

#Question 3

tailleListe([], 0 )
tailleListe([_|B], Taille) :- tailleListe(B, N) , Taille is N+1

problemeCapaciteSalle(seance(_, _, groupe(_, _, ListeEleves, _), salle(_, Capacite, _, _), _, _)) :- tailleListe(ListeEleves, TailleGroupe), TailleGroupe > Capacite

#Question 4

afficher_seance_professeur(Professeur):- seance(_, Professeur, _, _, _, IdSeance)
afficher_seance_eleve(Eleve) :- seance(_, _, groupe(_, _, ListeEleves, _), _, _, IdSeance), appartient(Eleve, ListeEleves)
afficher_seance_salle(Salle) :- seance(_, _, _, Salle, _, IdSeance)
afficher_seance_groupe(Groupe) :- seance(_, _, Groupe, _, _, IdSeance)

appartient(X, [X|_])
appartient(X,[_|L]) :- appartient(X, L)

#Question 5

jour(Creneau) :- sub_atom(Creneau, 1, 1, 1, 1), writeln("Lundi")
jour(Creneau) :- sub_atom(Creneau, 1, 1, 1, 2), writeln("Mardi")
jour(Creneau) :- sub_atom(Creneau, 1, 1, 1, 3), writeln("Mercredi")
jour(Creneau) :- sub_atom(Creneau, 1, 1, 1, 4), writeln("Jeudi")
jour(Creneau) :- sub_atom(Creneau, 1, 1, 1, 5), writeln("Vendredi")
jour(Creneau) :- sub_atom(Creneau, 1, 1, 1, 6), writeln("Samedi")

#Question 6

heure(Creneau) :- sub_atom(Creneau, 2, 1, 0, 1), writeln("8h-10h")
heure(Creneau) :- sub_atom(Creneau, 2, 1, 0, 2), writeln("10h-12h")
heure(Creneau) :- sub_atom(Creneau, 2, 1, 0, 3), writeln("14h-16h")
heure(Creneau) :- sub_atom(Creneau, 2, 1, 0, 4), writeln("16h-18h")


#Question 7

conflit(seance(_, Professeur, _, _, Creneau, _), seance(_, Professeur, _, _, Creneau, _)) :- write("Séance en conflit : Les professeurs sont identiques")
conflit(seance(_, _, Groupe, _, Creneau, _), seance(_, _, Groupe, _, Creneau, _)) :- write("Séance en conflit : Les groupes sont identiques")
conflit(seance(_, _, _, Salle, Creneau, _), seance(_, _, _, Salle, Creneau, _)) :- write("Séance en conflit : Les salles sont identiques")

#Question 8

afficherEmploiDuTemps(professeur(NomProfesseur, Prenom, Discipline, Id)) :- seance(Matiere, professeur(NomProfesseur, Prenom, Discipline, Id), groupe(NomGroupe, _, _, _), salle(NomSalle, _, _, _), Creneau, Id), writeln(NomProfesseur), writeln(jour(Creneau)), writeln(heure(Creneau)), writeln(Matiere), writeln(NomSalle), writeln(NomGroupe)') 
afficherEmploiDuTemps(eleve(NomEleve, Prenom, Niveau, Id)) :- seance(Matiere, professeur(NomProfesseur, _, _, _), groupe(_, appartient(eleve(NomEleve, Prenom, Niveau, Id), ListeEleves), _, _), salle(NomSalle, _, _, _), Creneau, Id), writeln(NomEleve), writeln(jour(Creneau)), writeln(heure(Creneau)), writeln(Matiere), writeln(NomSalle), writeln(NomProfesseur)') 
afficherEmploiDuTemps(salle(NomSalle, Capacite, Type, Id)) :- seance(Matiere, professeur(NomProfesseur, _, _, _), groupe(NomGroupe, _, _, _), salle(NomSalle, Capacite, Type, Id), Creneau, Id), writeln(NomSalle), writeln(jour(Creneau)), writeln(heure(Creneau)), writeln(Matiere), writeln(NomGroupe), writeln(NomProfesseur)') 

#Question 9

chargeDeTravail(professeur(Nom, Prenom, Discipline, Id)) :- aggregate_all(count, seance(_, professeur(Nom, Prenom, Discipline, Identifiant), _, _, _, _), TotalSeance),Total is 2*TotalSeance, write("Charge de travail du professeur : "), write(Total)
chargeDeTravail(salle(Nom, Capacite, Type, Id)) :- aggregate_all(count, seance(_, _, _, salle(Nom, Capacite, Type, Id), _, _), TotalSeance), Total is 2*TotalSeance, write("Charge de travail de la salle : "), writeln(Nom), writeln(Total)
chargeDeTravail(eleve(Nom, Prenom, Niveau, Id)) :- aggregate_all(count, seance(_, _, groupe(_, appartient(eleve(Nom, Prenom, Niveau, Id), ListeEleves), _, _), _, _, _), TotalSeance), write("Charge de travail de le l'élève : "), Total is 2*TotalSeance, writeln(Nom), writeln(Total)

#Question 10


ajouter_classe(Nom, Niveau, Groupe, Liste_professeurs, Liste_matieres,Liste_seances, Id) :- not(classe(Nom, Niveau, Groupe, Liste_professeurs, Liste_matieres, Liste_seances, _)),not(classe(_, _, _,_,_,_, Id)), assert(classe(Nom, Niveau, Groupe, Liste_professeurs, Liste_matieres,Liste_seances, Id))

supprimer_classe(Nom, Niveau, Groupe, Liste_professeurs, Liste_matieres,Liste_seances, Id):- classe(Nom, Niveau, Groupe, Liste_professeurs, Liste_matieres,Liste_seances, Id), retract(classe(Nom, Niveau, Groupe, Liste_professeurs, Liste_matieres,Liste_seances, Id))

#Question 11

matiereAppartient(matiere, [seance(matiere, _, _, _, _, _)|_])
matiereAppartient(matiere, [_|L]) :- matiereAppartient(matiere, L)

verificationSeances(classe(_, _, _, _, ListeMatieres, ListeSeances, _)) :- taille(ListeMatieres, TailleListeMatieres), taille(ListeSeances, TailleListeSeances), TailleListeSeances = 2*TailleListeMatieres, verificationSeancesCorrespondantes(ListeSeances, ListeMatieres), 
verificationSeancesCorrespondantes(_, [])
verificationSeancesCorrespondantes(ListeSeances, [Matiere|ListeMatieres]) :-  aggregate_all(count, matiereAppartient(Matiere, ListeSeances), Total), Total = 2, verificationSeancesCorrespondantes(ListeSeances, ListeMatieres)

#Question 12

emploiDuTempsPlanifie(_, [])
emploiDuTempsPlanifie([classe(Nom, Niveau, Groupe, ListeProfesseur, ListeMatieres, ListeSeances, Identifiant)|ListeClasses]) :- classe(Nom, Niveau, Groupe, ListeProfesseur, ListeMatieres, ListeSeances, Identifiant), verificationSeances(classe(Nom, Niveau, Groupe, ListeProfesseur, ListeMatieres, ListeSeances, Identifiant)), write("Classe : "), write(Nom), writeln(" planification ok"), emploiDuTempsPlanifie(ListeClasses)

#Question 13

sauvegarder(Fichier) :- open(Fichier, write, Flux), with_output_to(Flux, listing), close(Flux)
