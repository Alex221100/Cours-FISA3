%{
#define MAX 30
int T[MAX] ; // on dÃ©clare un tableau de MAX
%}
%%
[a-zA-Z]+ T[yyleng]++ ; //yyleng : longueur du mot courant
. |
\n ;
%%
yywrap()
{ int i ;
 printf("longueur des mots\n") ;
 for(i=0 ;i<MAX ;i++) if(T[i]>0) printf("%d mots de longueur %d\n",T[i],i) ;
 exit(0) ;
}
