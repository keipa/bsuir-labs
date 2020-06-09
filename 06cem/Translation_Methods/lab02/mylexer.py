import ply.lex as lex
import re
import token_rules


with open('input.txt', 'r') as fin:
    data = ''.join(fin.readlines())

lexer = lex.lex(reflags=re.UNICODE | re.DOTALL, module=token_rules)

if __name__ == '__main__':
    lexer.input(data)
    while True:
        tok = lexer.token()
        if not tok:
            break
        print(tok)
