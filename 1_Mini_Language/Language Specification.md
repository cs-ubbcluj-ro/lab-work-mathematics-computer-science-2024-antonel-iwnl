
1. Language definition
	1. Alphabet:
			a. Lower (a-z) case letter of the English alphabet and only Romanian Upper case letters (Ă, Â, Î, Ț, Ș)
			b. At the rate symbol '@' and underline '_'
			c. Decimal digits (0-9)
		Lexic:
			a. Special symbols, representing:
				- operators + - * / := < <= = >= >
				- separators [ ] { } : ; space
				- reserved words: int char const iftry elsetry then do while for program re wr bundle
			b. Identifiers:
				- an 'at the rate' symbol ( @ ) followed by a sequence of letters and digits, such that the first character is always an 'at the rate' symbol. The rule is:
					identifier := @letter | @letter{letter}{digit}{underscore}{letter}
					letter := "a" | "b" | ... | "z" | "Ă" | "Â" | "Î" | "Ț" | "Ș" 
					digit := "0" | "1" | ... | "9"
			c. constants
	2. integer - rule:
			noconst := +no | -no | no
			no := digit{no}
	3. character:
			character := letter | digit
	4. string:
			const char := "string"
			string := char{string}
			char := letter | digit
2. Syntax:
	<program> ::= "antonelgram" identifier ";" declist "Lights out" stmtlist "Checkered flag"
	<declist> ::= declaration | declaration ";" declist
	<type> ::= "int" | "char" | "string" | "bundle" | "bool"
	<bundle> ::= "bundle" "["number of elements"]" "of" type identifier
	<declaration> ::= type identifier | bundle
	<stmtlist> ::= stmt | stmt ";" stmtlist
	<stmt> ::= simplstmt | structstmt
	<simplstmt> ::= assignstmt | iostmt
	<assignstmt> ::= identifier "=" expression
	<iostmt> ::= re "(" identifier ")" | wr "(" expression ")"
	<structstmt> ::= ifstmt | whilestmt | forstmt | cmpdstmt
	<cmpdstmt> ::= "begin" stmtlist "end"
	<ifstmt> ::= "iftry" condition "then" stmt ["elsetry" stmt]
	<whilestmt> ::= "while" condition "do" stmt
	<forstmt> ::= "for" identifier ":=" expression "to" expression "do" stmt
	<condition> ::= expression relation expression
	<relation> ::= "<" | "<=" | "=" | "<>" | ">=" | ">"
	<expression> ::= term {("+" | "-") term}
	<term> ::= factor {("*" | "/") factor}
	<factor> ::= "(" expression ")" | identifier | constant
	<constant> ::= integer | character | string
	<integer> ::= noconst


