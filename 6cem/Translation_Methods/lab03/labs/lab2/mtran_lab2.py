import re
import ply.lex as lex
import ply.yacc as yacc
from token_rules import tokens
import token_rules
from operator import add, sub, mul, div, eq, ne, le, ge, gt, lt

data = '''
var EUR: integer;
    USD: integer;
    GBP: integer;
    i: integer;
    rub_value: real;
    currency_value: real;
    type_currency: string;
begin
    EUR := 24850;
    USD := 22000;
    GBP := 31900;

    writeln("Input amount in rubles:");
    readln(rub_value);

    writeln("Input type currency:");
    readln(type_currency);

    if type_currency = "EUR" then currency_value := rub_value / EUR;
    if type_currency = "USD" then currency_value := rub_value / USD;
    if type_currency = "GBP" then currency_value := rub_value / GBP;

    i := 0;
    while i <= 3 do begin
        writeln(currency_value);
        inc(i);
    end;
end.
'''


class TreeBuilder:
    def __init__(self, type, parts):
        self.type = type
        self.parts = parts

    def __str__(self):
        if len(self.parts) != 0:
            return self.type + ":\n\t" + self.parts_str().replace("\n", "\n\t")
        else:
            return self.type + self.parts_str().replace("\n", "\n\t")

    def parts_str(self):
        st = []
        for part in self.parts:
            st.append(part.__str__())
        return "\n".join(st)

    def add_leaf(self, parts):
        if isinstance(parts, TreeBuilder):
            if parts.parts:
                self.parts.extend(parts.parts)
        return self


identifiers = dict()


def p_program(p):
    """
        program : var begin
    """
    p[0] = TreeBuilder('program', [p[1], p[2]])


def p_var(p):
    """
        var : VAR declare
    """
    p[0] = TreeBuilder('var block', [p[2]])


def p_begin(p):
    """
        begin : BEGIN body END POINT
    """
    p[0] = TreeBuilder('code block', [p[2]])


def p_declare(p):
    """
        declare : declaration declare
                 | empty
    """
    if len(p) == 2:
        p[0] = TreeBuilder('declarations', [p[1]])
    else:
        p[0] = TreeBuilder('declarations', [p[1]]).add_leaf(p[2])


def p_block(p):
    """
        block : BEGIN body END SEMICOLON
    """
    p[0] = TreeBuilder('block', [p[2]])


def p_body(p):
    """
        body : expression
    """
    p[0] = TreeBuilder('body', [p[1]])


def p_expression(p):
    """
    expression : assignment expression
                | if expression
                | function expression
                | empty
                | while expression

    """
    if len(p) == 2:
        p[0] = TreeBuilder('expression', [p[1]])
    else:
        p[0] = TreeBuilder('expression', [p[1]]).add_leaf(p[2])


def p_declaration(p):
    """
        declaration : IDENTIFIER COLON type SEMICOLON
    """
    p[0] = TreeBuilder('declare', [p[1]]).add_leaf(p[3])


def p_type(p):
    """
        type : TYPE_STRING
             | TYPE_INTEGER
             | TYPE_REAL
    """
    p[0] = TreeBuilder('type', [p[1]])


def p_empty(p):
    """
        empty :
    """
    p[0] = TreeBuilder('', [])


def p_assignment(p):
    """
        assignment : IDENTIFIER ASSIGNMENT arithmetic_expression SEMICOLON
    """
    p[0] = TreeBuilder('assignment', [p[1], p[2]]).add_leaf(p[3])


def p_arithmetic_expression(p):
    """
    arithmetic_expression : IDENTIFIER PLUS arithmetic_expression
                     | IDENTIFIER MINUS arithmetic_expression
                     | IDENTIFIER MUL arithmetic_expression
                     | IDENTIFIER DIV arithmetic_expression

                     | NUMBER PLUS arithmetic_expression
                     | NUMBER MINUS arithmetic_expression
                     | NUMBER MUL arithmetic_expression
                     | NUMBER DIV arithmetic_expression
                     | NUMBER
                     | IDENTIFIER
                     | STRING
    """

    if len(p) == 2:
        p[0] = TreeBuilder('expression', [p[1]])
    else:

        if p[2] == '/' and 0 in p[3].parts:
            raise ArithmeticError('Division by zero!')
        p[0] = TreeBuilder('expression', [p[1], p[2], p[3]])


def perform_operation(operation, v1, v2):
    return operation(v1, v2)


def p_function(p):
    """
        function : WRITELN OPEN_BRACKET arithmetic_expression CLOSE_BRACKET SEMICOLON
                    | READLN OPEN_BRACKET IDENTIFIER CLOSE_BRACKET SEMICOLON
                    | INC OPEN_BRACKET IDENTIFIER CLOSE_BRACKET SEMICOLON
    """
    if p[1] == 'inc':
        p[0] = TreeBuilder('inc', [p[3]])
    elif p[1] == 'writeln':
        p[0] = TreeBuilder('output', [p[3]])
    elif p[1] == 'readln':
        p[0] = TreeBuilder('input', [p[3]])


def invert_operation(operation):
    invertor = {'>': '<', '<': '>', '<=': '>=', '>=': '<=', '=': '<>', '<>': '='}
    return invertor[operation]


def p_predicate(p):
    """
    predicate :    IDENTIFIER EQUALITY arithmetic_expression
                  | NUMBER  EQUALITY arithmetic_expression
                  | IDENTIFIER  NON_EQUALITY arithmetic_expression
                  | NUMBER  NON_STRICT_COMPARISON arithmetic_expression
                  | IDENTIFIER  NON_STRICT_COMPARISON arithmetic_expression
                  | NUMBER  NON_EQUALITY arithmetic_expression
                  | NUMBER COMPARISON arithmetic_expression
                  | NUMBER
                  | IDENTIFIER
    """

    if len(p) == 2:
        if type(p[1]) not in (int, float):
            p[0] = identifiers[p[1]][0]
        else:
            p[0] = p[1]
        p[0] = TreeBuilder('expr', [p[1]])
    else:
        operations_associator = {
            '<>': ne,
            '=': eq,
            '>': gt,
            '<': lt,
            '>=': ge,
            '<=': le
        }
        operation = operations_associator[p[2]]
        if type(p[1]) in (int, float):
            if not(type(p[3]) in (int, float)):
                p[2] = invert_operation(p[2])
                operation = operations_associator[p[2]]
                p[1], p[3] = p[3], p[1]
            else:
                p[0] = TreeBuilder('operation', [p[1], p[2]]).add_leaf(p[3])
        elif type(p[3]) in (int, float) and (type(p[1]) not in (int, float)):
            p[0] = TreeBuilder('operation', [p[1], p[2]]).add_leaf(p[3])

        p[0] = TreeBuilder('operation', [p[1], p[2], p[3]])


def p_while(p):
    """
        while : WHILE predicate DO block
    """
    p[0] = TreeBuilder('while', [p[2]]).add_leaf(p[4])


def p_if(p):
    """
        if : IF predicate THEN block
            | IF predicate THEN expression
    """
    p[0] = TreeBuilder('if', [p[2]]).add_leaf(p[4])


def p_error(p):
    print 'Unexpected token {0}'.format(p)


if __name__ == '__main__':
    lexer = lex.lex(reflags=re.UNICODE | re.DOTALL, module=token_rules)
    parser = yacc.yacc(method='LALR')
    code = data
    result = parser.parse(code, lexer=lexer, debug=False, tracking=True)
    if result:
        print result
