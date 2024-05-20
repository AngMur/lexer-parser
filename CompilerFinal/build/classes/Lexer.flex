import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]
ComentarioTradicional = "/*" [^*] ~"*/" | "/*" "*"+ "/"
FinDeLineaComentario = "//" {EntradaDeCaracter}* {TerminadorDeLinea}?
ContenidoComentario = ( [^*] | \*+ [^/*] )*
ComentarioDeDocumentacion = "/**" {ContenidoComentario} "*"+ "/"

/* Comentario */
Comentario = {ComentarioTradicional} | {FinDeLineaComentario} | {ComentarioDeDocumentacion}

/* Identificador */
Letra = [A-Za-zÑñ_ÁÉÍÓÚáéíóúÜü]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/*Simbolos del lenguaje*/

">" { return token(yytext(), "MOVER_DERECHA", yyline, yycolumn); }
"<" { return token(yytext(), "MOVER_IZQUIERDA", yyline, yycolumn); }
"+" { return token(yytext(), "SUMAR_1", yyline, yycolumn); }
"-" { return token(yytext(), "RESTAR_1", yyline, yycolumn); }
"." { return token(yytext(), "MOSTRAR_ASCII", yyline, yycolumn); }
"," { return token(yytext(), "PEDIR_ASCII", yyline, yycolumn); }
"[" { return token(yytext(), "INICIO_BUCLE", yyline, yycolumn); }
"]" { return token(yytext(), "FIN_BUCLE", yyline, yycolumn); }

/**/
{TerminadorDeLinea} {/*Ignorar*/}
. { /*Ignorar*/ }

