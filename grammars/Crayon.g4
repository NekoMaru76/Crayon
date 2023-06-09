grammar Crayon;

NUMBER: ([0-9]+ '.' [0-9]+) | ('.' [0-9]+) | ([0-9]+ ('.'?));
MAIN: M A I N;
FRAME: F R A M E;
LOOP: L O O P;
STRING: '"' (ESC | ~["\\])* '"';
NONE: '#' N O N E;
INFINITY: '#' I N F I N I T Y;
YES: '#' Y E S;
NO: '#' N O;
PI: '#' P I;
END: '~';

WS: [ \t\r\n]+ -> skip;

fragment IDENTIFIER_START: ([A-Z] | [a-z] | '_');

IDENTIFIER: IDENTIFIER_START (IDENTIFIER_START | [0-9])*;
fragment ESC: '\\' ['"\\];

fragment A : [aA]; // match either an 'a' or 'A'
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];

variable: '$' IDENTIFIER;
numberLiteral: NUMBER;
pair: IDENTIFIER '=' value;
stringLiteral: STRING;
none: NONE;
bool: YES | NO;
pI: PI;
infinity: INFINITY;
object: '#{' (pair (',' pair?)*)? '}';
array: '#[' (value (',' value?)*)? ']';
commandValue: '@(' command ')';
value: pI | bool | valueTag | commandValue | variable | none | infinity | stringLiteral | numberLiteral | object | array | '(' value ')';
end: END value?;
keywordPath: IDENTIFIER;
valueTag: '@' IDENTIFIER;
valuePath: value | scope;
path: keywordPath | valuePath;
command: path+;
scope: '{' (exp | end)* '}';
exp: scope | ((command | end) ';'+)+;
tag: '[' (mainTag | frameTag | loopTag | customTag) ']' exp;
mainTag: MAIN;
frameTag: FRAME NUMBER;
loopTag: LOOP;
customTag: '@' IDENTIFIER;
script: tag+ EOF;