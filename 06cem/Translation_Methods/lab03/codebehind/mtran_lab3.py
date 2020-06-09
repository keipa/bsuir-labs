import ply.lex as lex
import re
import ply.yacc as yacc
from token_rules import tokens
import token_rules
from operator import add, sub, mul, div, eq, ne, le, ge, gt, lt
from config import *


identifiers = dict()


def p_program(p):
    """
        program : var begin
    """
    p[0] = p[1]


def p_var(p):
    """
        var : VAR declare
    """
    p[0] = p[2]


def p_begin(p):
    """
        begin : BEGIN body END POINT
    """
    p[0] = p[2]


def p_declare(p):
    """
        declare : declaration declare
                 | empty
    """
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = p[2]


def p_block(p):
    """
        block : BEGIN body END SEMICOLON
    """
    p[0] = p[2]


def p_body(p):
    """
        body : expression
    """
    p[0] = p[1]


def p_expression(p):
    """
    expression : assignment body
                | if body
                | function body
                | empty
                | while body
    """
    if p[1]:
        p[0] = p[1]


def p_declaration(p):
    """
        declaration : IDENTIFIER COLON type SEMICOLON
    """
    identifiers[p[1]] = (None, p[3])
    p[0] = p[3]


def p_type(p):
    """
        type : TYPE_STRING
             | TYPE_INTEGER
             | TYPE_REAL
    """
    p[0] =  p[1]


def p_empty(p):
    """
        empty :
    """
    pass


def p_assignment(p):
    """
        assignment : IDENTIFIER ASSIGNMENT arithmetic_expression
                    | IDENTIFIER ASSIGNMENT arithmetic_expression SEMICOLON
    """
    if identifiers.get(p[1], None):
        if type(p[3]) not in (int, float) and '"' not in p[3]:
            p[0] = identifiers[p[3]][0]
            identifiers[p[1]] = (identifiers[p[3]][0], identifiers[p[1]][1])
        else:
            p[0] = p[3]
            identifiers[p[1]] = (p[3], identifiers[p[1]][1])
        p[0] = p[1]
    else:
        raise Exception('Identifier undeclared ' + p[1])


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
                     | FLOAT_NUMBER
                     | NUMBER
                     | IDENTIFIER
                     | STRING
    """

    if len(p) == 2:
        p[0] = p[1]
    else:
        operatons_associator = {'+': add,
                                '-': sub,
                                '*': mul,
                                '/': div}
        v1, v2 = p[1], p[3]
        if type(p[1]) not in (float, int):
            v1 = identifiers[p[1]][0]
        if type(p[3]) not in (float, int):
            v2 = identifiers[p[3]][0]
        p[0] = perform_operation(operatons_associator[p[2]], v1, v2)


def perform_operation(operation, v1, v2):
    return operation(v1, v2)


def p_function(p):
    """
        function : WRITELN OPEN_BRACKET arithmetic_expression CLOSE_BRACKET SEMICOLON
                    | READLN OPEN_BRACKET IDENTIFIER CLOSE_BRACKET SEMICOLON
                    | INC OPEN_BRACKET IDENTIFIER CLOSE_BRACKET SEMICOLON
    """

    if type(p[3]) not in (int, float, str):
        if identifiers.get(p[3], None):
            pass
        else:
            raise Exception('Undeclared Identifier!')
        #if identifiers.get(p[3], None):
        #    print identifiers[p[3]][0]
        #else:
        #    raise Exception('Undeclared Identifier!')
    else:
        pass
        #print p[3]
    p[0] = p[3]


def invert_operation(operation):
    invertor = {'>': '<', '<': '>', '<=': '>=',
                '>=': '<=', '=': '<>', '<>': '='}
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
        p[0] = p[1]
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
                operation = operations_associator[invert_operation(p[2])]
                p[1], p[3] = p[3],p[1]
            else:
                p[0] = perform_operation(operation,p[1], p[3])

        elif type(p[3]) in (int, float) and (type(p[1]) not in (int, float)):
            p[0] = perform_operation(operation, identifiers[p[1]][0], p[3])
        p[0] = p[1]


def p_while(p):
    """
        while : WHILE predicate DO block
    """
    if p[2]:
        p[0] = p[4]


def p_if(p):
    """
        if : IF predicate THEN block
            | IF predicate THEN expression
    """
    if p[2]:
        p[0] = p[4]


def p_error(p):
    print 'Unexpected token {0}'.format(p)






if __name__ == '__main__':
    lexer = lex.lex(reflags=re.UNICODE | re.DOTALL, module=token_rules)
    parser = yacc.yacc(method='LALR')
    code = data
    result = parser.parse(code, lexer=lexer, debug=False, tracking=True)

    from prettytable import PrettyTable
    x = PrettyTable()
    x.field_names = ["identifier", "type"]
    for k, v in zip(identifiers.keys(), identifiers.values()):
        # print k + "\t"+v[1]
        x.add_row([k,v[1]])
    print x
    print "===========OK==========="
    # print identifiers.keys()

