from mylexer import data, lexer
from token_rules import tokens
import ply.yacc as yacc
from operator import add, sub, mul, truediv, eq, ne, le, ge, gt, lt
from ply.yacc import YaccSymbol
from checker import check


consts = dict()
identifiers = dict()
semantic_errors = []

def saveToFile(path, string):
    with open(path, "a") as file:
        file.writelines(string)

path = "D:\\LABS\\BSUIR_labs\\6cem\\Translation_Methods\\lab02\\output.txt"

def tree_print(l, i):
    for item in l:
        if type(item) is list:
            tree_print(item, i)
        else:
            i += 1
            if item:
                saveToFile(path, "\t" * i + str(item)+"\n")


interpret_index = 0


def interpret_tree(l, i):
    row = []
    for item in l:
        if type(item) is list:
            new = interpret_tree(item, i)
            if interpret_index == 0:
                row.append([])
                row[-1] += new
        else:
            i += 1
            if item:
                row.append(item)
    return row


class Node:
    def parts_str(self):
        st = []
        for part in self.parts:
            st.append(part.__str__())
        return "\n".join(st)

    def __str__(self):
        return self.type + ":\n\t" + self.parts_str().replace("\n", "\n\t")

    def add_child(self, parts):
        if isinstance(parts, Node):
            if parts.parts:
                self.parts.extend(parts.parts)
        return self

    def __init__(self, type, parts):
        self.type = type
        self.parts = parts


def p_consts(p):
    '''
        consts : CONST IDENTIFIER EQUALITY NUMBER SEMICOLON begin_program
                | CONST IDENTIFIER EQUALITY STRING SEMICOLON begin_program
                | CONST IDENTIFIER EQUALITY matrix SEMICOLON begin_program
                | begin_program
    '''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = [['const', p[2], p[4]], p[6]]


def p_matrix(p):
    '''
        matrix : OPEN_SQUARE_BRACKET identifiers CLOSE_SQUARE_BRACKET
    '''
    p[0] = [p[1] + p[3], p[2]]


def p_identifiers(p):
    '''
        identifiers : IDENTIFIER ZAPYATAYA identifiers
                    | NUMBER ZAPYATAYA identifiers
                    | STRING ZAPYATAYA identifiers
                    | IDENTIFIER
                    | NUMBER
                    | STRING
    '''
    if len(p) == 2:
        p[0] = p[1]
    else:
        p[0] = [[p[1]], p[3]]


def p_begin_program(p):
    '''
        begin_program : VAR declarations BEGIN body END POINT
    '''
    p[0] = [p[2], ['begin program', p[4]]]


def p_block(p):
    '''
        block : BEGIN body END SEMICOLON
    '''
    p[0] = [p[2]]


def p_body(p):
    '''
        body : expression
    '''
    p[0] = [p[1]]


def p_identifier(p):
    '''
        identifier : IDENTIFIER
    '''
    if list(identifiers.keys()).count(p[1]) == 0:
        semantic_errors.append('{0}) There is no {1} variable!'.format(p.lexer.lineno, p[1]))
    p[0] = p[1]


def p_expression(p):
    '''
    expression : assignment expression
                | if expression
                | function expression
                | empty
                | while expression
                | for expression
                | break
    '''
    # empty
    if len(p) == 2:
        p[0] = [p[1]]
    else:
        p[0] = [p[1], p[2]]


def p_break(p):
    '''
        break : BREAK SEMICOLON
    '''
    p[0] = [p[1]]


def p_declarations(p):
    '''
        declarations : declaration declarations
                    | empty
    '''
    if len(p) == 2:
        p[0] = p[0]
    else:
        p[0] = [p[1], p[2]]


def p_declaration(p):
    '''
        declaration : IDENTIFIER another_identifiers COLON type SEMICOLON
    '''
    if type(p[2]) is list:
        p[0] = [['declare', p[1], p[4]]] + [['declare', item, p[4]] for item in p[2]]
    elif p[2] is None:
        p[0] = ['declare', p[1], p[4]]
    else:
        p[0] = [['declare', p[1], p[4]], ['declare', p[2], p[4]]]


def p_another_identifiers(p):
    '''
        another_identifiers : ZAPYATAYA IDENTIFIER another_identifiers
                            | empty
    '''
    if len(p) == 2:
        p[0] = p[0]
    else:
        if p[3] is None:
            p[0] = p[2]
        else:
            p[0] = [p[2], p[3]]


def p_type(p):
    '''
        type : TYPE_STRING
             | TYPE_INTEGER
             | TYPE_REAL
    '''
    p[0] = [p[1]]


def p_empty(p):
    '''
        empty :
    '''
    p[0] = p[0]


def p_assignment(p):
    '''
        assignment : identifier ASSIGNMENT arithmetic_expression SEMICOLON
                   | identifier ASSIGNMENT function SEMICOLON
                   | identifier ASSIGNMENT function
                   | identifier ASSIGNMENT arithmetic_expression
    '''
    p[0] = ['assign ' + p[1], p[2], p[3]]


def p_arithmetic_expression(p):
    '''
    arithmetic_expression : NUMBER
                     | identifier
                     | STRING
                     | function
                     | identifier PLUS arithmetic_expression
                     | identifier MINUS arithmetic_expression
                     | identifier MUL arithmetic_expression
                     | identifier DIV arithmetic_expression
                     | NUMBER PLUS arithmetic_expression
                     | NUMBER MINUS arithmetic_expression
                     | NUMBER MUL arithmetic_expression
                     | NUMBER DIV arithmetic_expression
                     | function PLUS arithmetic_expression
                     | function MINUS arithmetic_expression
                     | function MUL arithmetic_expression
                     | function DIV arithmetic_expression
                     | identifier OPEN_SQUARE_BRACKET arithmetic_expression CLOSE_SQUARE_BRACKET
                     | arithmetic_expression PLUS arithmetic_expression
                     | arithmetic_expression MINUS arithmetic_expression
                     | arithmetic_expression MUL arithmetic_expression
                     | arithmetic_expression DIV arithmetic_expression
    '''

    if len(p) == 5:
        p[0] = [p[1], p[2] + p[4], p[3]]
    elif len(p) == 2:
        p[0] = p[1]
    else:
        if p[2] in ("+", "-", "/", "*"):
            if type(p[3]) is list and type(p[1]) is list:
                if list(identifiers.keys()).count(p[1][0]) > 0 and list(identifiers.keys()).count(p[3][0]) > 0:
                    if identifiers[p[3][0]][1] in (list, str) and identifiers[p[1][0]][1] in (list, str) and\
                                    identifiers[p[3][0]][0] != identifiers[p[1][0]][0]:
                        semantic_errors.append("{3}) Operations with different types! {0} {1} {2}"
                                               .format(p[1], p[2], p[3], p.lexer.lineno))
            elif list(identifiers.keys()).count(p[1]) > 0 and list(identifiers.keys()).count(p[3]) > 0:
                if identifiers[p[3]][1] != identifiers[p[1]][1]:
                    semantic_errors.append("{3}) Operations with different types! {0} {1} {2}"
                                           .format(p[1], p[2], p[3], p.lexer.lineno))
            elif list(identifiers.keys()).count(p[1]) > 0:
                if ((type(p[3]) is list and p[3][1] == "[]" and identifiers[p[3][0]][1] != identifiers[p[1]][1]) or\
                        (type(p[3]) is not list and (not (type(p[3]) in (int, float) and identifiers[p[1]][1]
                        in (int, float)) and not (type(p[3]) is str and identifiers[p[1]][1] is str)))) and p[3] != "0":
                    semantic_errors.append("{3}) Operations with different types! {0} {1} {2}"
                                           .format(p[1], p[2], p[3], p.lexer.lineno))
            elif list(identifiers.keys()).count(p[3]) > 0:
                if (type(p[1]) is list and p[1][1] == "[]" and identifiers[p[1][0]][1] != identifiers[p[3]][1]) or \
                        (type(p[1]) is not list and (not (type(p[1]) in (int, float) and identifiers[p[3]][1]
                        in (int, float)) and not (type(p[1]) is str and identifiers[p[3]][1] is str))):
                    semantic_errors.append("{0}) Operations with different types! {1} {2} {3}"
                                           .format(p.lexer.lineno, p[1], p[2], p[3]))
        if p[2] == "/" and ((type(p[3]) in (int, float) and p[3] == 0) or p[3] == "0"):
            semantic_errors.append("{3}) Division by 0 exception. {0} {1} {2}".format(p[1], p[2], p[3], p.lexer.lineno))
        if list(identifiers.keys()).count(p[3]) > 0 and p[2] == "/":
                if identifiers[p[3]][0] == 0:
                    semantic_errors.append(
                        "{3}) Division by 0 exception. {0} {1} {2}".format(p[1], p[2], p[3], p.lexer.lineno))
        p[0] = [p[1], p[2], p[3]]


def perform_operation(operation, v1, v2):
    return operation(v1, v2)


def p_function(p):
    '''
        function : WRITE OPEN_BRACKET arithmetic_expression CLOSE_BRACKET SEMICOLON
                    | WRITELN OPEN_BRACKET arithmetic_expression CLOSE_BRACKET SEMICOLON
                    | READ OPEN_BRACKET identifier CLOSE_BRACKET SEMICOLON
                    | READLN OPEN_BRACKET identifier CLOSE_BRACKET SEMICOLON
                    | LENGTH OPEN_BRACKET identifier CLOSE_BRACKET
                    | INC OPEN_BRACKET identifier CLOSE_BRACKET SEMICOLON
    '''
    p[0] = [p[1], p[3]]


def invert_operation(operation):
    invertor = {'>': '<', '<': '>', '<=': '>=',
                '>=': '<=', '=': '<>', '<>': '=', 'in': 'in'}
    return invertor[operation]


def p_predicate(p):
    '''
    predicate :    arithmetic_expression COMPARISON arithmetic_expression
                  | arithmetic_expression EQUALITY arithmetic_expression
                  | arithmetic_expression NON_EQUALITY arithmetic_expression
                  | arithmetic_expression NON_STRICT_COMPARISON arithmetic_expression
                  | arithmetic_expression IN identifier
                  | arithmetic_expression IN matrix
    '''
    if p[3] in identifiers.keys() and p[2] == "in" and identifiers[p[3]][1] is not list:
        semantic_errors.append("{0}) You can pass operator \"in\" only for matrix.".format(p.lexer.lineno))
    old_len = len(semantic_errors)
    check_comparation(p[1], p[2], p[3], p.lexer.lineno)
    if old_len == len(semantic_errors):
        check_comparation(p[3], p[2], p[1], p.lexer.lineno)
    if type(p[1]) is list and p[1][1] == '[]':
        p[0] = p[1] + [p[2], p[3]]
    else:
        p[0] = [p[1], p[2], p[3]]


def check_comparation(p1, p2, p3, line):
    if type(p1) is list and p2 != "in":
        tp = None
        for _ in p1:
            if list(identifiers.keys()).count(_) > 0:
                tp = identifiers[_][1]
                break
        tp = tp if tp is not None else type(p1[0])
        if type(p3) is not list:
            if (type(p3) is not tp) or (tp is str and type(p3) in (int, float)):
                semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))
            elif list(identifiers.keys()).count(p3) > 0 and identifiers[p3][1] != tp:
                semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))
        else:
            tp1 = None
            for _ in p3:
                if list(identifiers.keys()).count(_) > 0:
                    tp1 = identifiers[_][1]
                    break
            tp1 = tp1 if tp1 is not None else type(p3[0])
            if tp != tp1:
                semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))
    else:
        if list(identifiers.keys()).count(p1) > 0:
            if list(identifiers.keys()).count(p3) > 0:
                if identifiers[p3][1] != identifiers[p1][1]:
                    semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))
            else:
                if identifiers[p1][1] != type(p3):
                    semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))
        else:
            if list(identifiers.keys()).count(p3) > 0:
                if type(p1) != identifiers[p3][1]:
                    semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))
            else:
                if type(p1) != type(p3):
                    semantic_errors.append("{0}) You can't pass different types to {1} operation.".format(line, p2))


def p_some_predicates(p):
    '''
        some_predicates : OPEN_BRACKET predicate CLOSE_BRACKET AND some_predicates
                        | OPEN_BRACKET predicate CLOSE_BRACKET OR some_predicates
                        | OPEN_BRACKET predicate CLOSE_BRACKET
                        | OPEN_BRACKET NOT OPEN_BRACKET predicate CLOSE_BRACKET CLOSE_BRACKET AND some_predicates
                        | OPEN_BRACKET NOT OPEN_BRACKET predicate CLOSE_BRACKET CLOSE_BRACKET OR some_predicates
                        | OPEN_BRACKET NOT OPEN_BRACKET predicate CLOSE_BRACKET CLOSE_BRACKET
    '''
    if len(p) == 9:
        p[0] = [[p[2], p[3], p[4], p[5], p[7]], p[8]]
    elif len(p) == 7:
        p[0] = [p[2], p[4]]
    elif len(p) == 4:
        p[0] = p[2]
    else:
        p[0] = [[p[2], p[4]], p[5]]


def p_while(p):
    '''
        while : WHILE OPEN_BRACKET predicate CLOSE_BRACKET DO block
              | WHILE some_predicates DO block
    '''
    if len(p) == 5:
        p[0] = [['while', p[2]], ['do', p[4]]]
    else:
        p[0] = [['while', p[3]], ['do', p[6]]]


def p_for(p):
    '''
        for : FOR assignment TO arithmetic_expression DO block
              | FOR assignment DOWNTO arithmetic_expression DO block
    '''
    p[0] = [['for', [p[2], [p[3], p[4]]]], p[5], p[6]]


def p_if(p):
    '''
        if : IF OPEN_BRACKET predicate CLOSE_BRACKET THEN block
            | IF OPEN_BRACKET predicate CLOSE_BRACKET THEN block else
    '''
    if len(p) == 8:
        p[0] = [['if', p[3]], ['then', p[6]], ['else', p[7]]]
    else:
        p[0] = [['if', p[3]], ['then', p[6]]]


def p_else(p):
    '''
        else : ELSE block
    '''
    p[0] = p[2]


def p_error(p):
    print('Error syntax {0}'.format(p).replace('LexToken',''))



with open('input.txt', 'r') as fin:
    data = ''.join(fin.readlines())
identifiers = check(data)[0]
parser = yacc.yacc(method='LALR')
result = parser.parse(data, lexer=lexer, debug=False, tracking=True)
if result and len(semantic_errors) == 0:
    tree_print(result, 0)
if len(semantic_errors) > 0:
    for _ in semantic_errors:
        print(_)


