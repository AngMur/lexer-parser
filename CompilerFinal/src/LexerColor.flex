import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int) start, size, color);
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

/* Comentarios o espacios en blanco */
{Comentario} { return textColor(yychar, yylength(), new Color(146, 146, 146)); }
{EspacioEnBlanco} {/*IGNORAR*/}

/*Simbolos del lenguaje*/

">" { return textColor(yychar, yylength(), new Color(255, 0, 0)); }    // Rojo
"<" { return textColor(yychar, yylength(), new Color(0, 255, 0)); }    // Verde
"+" { return textColor(yychar, yylength(), new Color(0, 0, 255)); }    // Azul
"-" { return textColor(yychar, yylength(), new Color(255, 165, 0)); }  // Naranja
"." { return textColor(yychar, yylength(), new Color(255, 255, 0)); }  // Amarillo
"," { return textColor(yychar, yylength(), new Color(128, 0, 128)); }  // Púrpura
"[" { return textColor(yychar, yylength(), new Color(0, 255, 255)); }  // Cian
"]" { return textColor(yychar, yylength(), new Color(255, 192, 203)); }// Rosa


{TerminadorDeLinea} {/*Ignorar*/}
. { /* Ignorar */ }