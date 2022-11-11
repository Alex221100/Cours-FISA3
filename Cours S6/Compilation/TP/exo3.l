%{ 
    #include <stdio.h>
    #include <string.h>
    typedef struct liste{ char mot[20] ; int categorie; struct liste* suivant ;} listech ;
    // déclaration du variable liste chainée
    listech *L1 = NULL ; // début  de la liste 
    int command_caller = 0;
%}

%s creer
%%

sujet {
    command_caller = 1;
    BEGIN(creer);
}

verbe {
    command_caller = 2;
    BEGIN(creer);
}

complement {
    command_caller = 3;
    BEGIN(creer);
}

<creer>[a-zA-Z]+ {
    printf("%s est ajoute a la base. \n", yytext);
    inserer(yytext, command_caller);
}
<creer>\n {BEGIN(INITIAL);}

[a-zA-Z]+ {
    char *categorie;
    switch (rechercher(yytext)) {
            case 1: 
                categorie = "sujet";
                break;

            case 2: 
                categorie = "verbe";
                break;

            case 3: 
                categorie = "complement";
                break;

            default: 
                categorie = "inconnu";
                break;
        }
    printf("%s est un %s \n", yytext, categorie);
}

%%

void inserer (char mot1[20], int categorie1)
{
    //d'abord créer un maillon ou un bloc
    listech *maillon = (listech *)malloc(sizeof(listech));

    //copier le mot1 en paramètre vers le champ mot du maillon
    strcpy(maillon->mot, mot1);
    maillon->categorie = categorie1;

    // chainer le maillon à la liste chainée (en début)
    maillon->suivant = L1;

    // faire que le maillon inséré soit le nouveau début de la liste
    L1 = maillon;
}

int rechercher (char mot2[20]) 
{
    // on parcourt la liste et on compare.... Si on trouve le mot alors on retourne sa catégorie.
    listech *m=L1;
    while((m!=NULL) && (strcmp(m->mot, mot2)!=0)){
        
        m=m->suivant;
    }

    //les deux mots sont égaux
    if ((m!=NULL) && strcmp(m->mot, mot2) == 0) {
        return m->categorie;
    }
    else {
        return 0;
    }
}

yywrap() {
    exit(0);
}

int main() {
    yylex();

    return 0;
}