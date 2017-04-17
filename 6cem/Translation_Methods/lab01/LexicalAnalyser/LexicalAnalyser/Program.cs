using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace LexicalAnalyser
{
    class Illegal
    {
        public string illegal_string { get; set; }
        public int illegal_line { get; set; }
        public int row { get; set; }
    }

    class Expressions
    {
        public string regex { get; set; }
        public string description { get; set; }
        public int linenum { get; set; }
    }

    
    class Program
    {

        static string reserved = "RESERVED";
        static string integer = "TYPE_INTEGER";
        static string real = "TYPE_REAL";
        static string stri = "TYPE_STRING";
        static string variable_name = "VARIABLE_NAME";
        static string math_operation = "MATH_OPERATION";
        static string reserved_program_char = "RESERVED_PROGRAM_CHAR";
        static string illegal_name = "ILLEGAL_NAME";
        public static List<Expressions> found_lexem = new List<Expressions>();

        private static List<Expressions> _expr = new List<Expressions>()
        {
                new Expressions() { regex = @"\bprogram\s.*",description = @reserved},
                new Expressions(){regex = @"{$APPTYPE CONSOLE}", description = reserved},
                new Expressions(){regex = "var", description = reserved},
                new Expressions(){regex = @"program\s\d+;", description = reserved},
                new Expressions(){regex = @"uses", description = reserved},
                new Expressions(){regex = @"const", description = reserved},
                new Expressions(){regex = @"integer", description = reserved},
                new Expressions(){regex = @"word", description = reserved},
                new Expressions(){regex = @"string", description = reserved},
                new Expressions(){regex = @"real", description = reserved},
                new Expressions(){regex = @"begin", description = reserved},
                new Expressions(){regex = @"end", description = reserved},
                new Expressions(){regex = @"while", description = reserved},
                new Expressions(){regex = @"do", description = reserved},
                new Expressions(){regex = @"if", description = reserved},
                new Expressions(){regex = @"then", description = reserved},
                new Expressions(){regex = @"else", description = reserved},
                new Expressions(){regex = @"writeln", description = reserved},
                new Expressions(){regex = @"readln", description = reserved},
                new Expressions(){regex = @"dec", description = reserved},
                new Expressions(){regex = @"inc", description = reserved},
                new Expressions(){regex = @":=", description = reserved},
                new Expressions(){regex = @"\+", description = math_operation},
                new Expressions(){regex = @"\-", description = math_operation},
                new Expressions(){regex = @"\*", description = math_operation},
                new Expressions(){regex = @"\/", description = math_operation},
                new Expressions(){regex = @"<=", description = math_operation},
                new Expressions(){regex = @">=", description = math_operation},
                new Expressions(){regex = @"<", description = math_operation},
                new Expressions(){regex = @">", description = math_operation},
                new Expressions(){regex = @"=", description = math_operation},
                new Expressions(){regex = @"\(", description = reserved_program_char},
                new Expressions(){regex = @"\)", description = reserved_program_char},
                new Expressions(){regex = @":", description = reserved_program_char},
                new Expressions(){regex = @";", description = reserved_program_char},
                new Expressions(){regex = @"\[", description = reserved_program_char},
                new Expressions(){regex = @"\]", description = reserved_program_char},
                new Expressions(){regex = @",", description = reserved_program_char},
                new Expressions(){regex = @"\.", description = reserved_program_char},
                new Expressions(){regex = "\\'.+\\'", description = stri},
                new Expressions(){regex = "\\'.+\\'", description = stri},
                new Expressions(){regex = @"\b[A-Za-z_]\w*", description = variable_name},
                new Expressions(){regex = @"\b[-+]?\d+\.\d+", description = real},
                new Expressions(){regex = @"\b[-+]?\d+", description = integer},
                new Expressions(){regex = @"\[", description = stri},
                new Expressions(){regex = @"\]", description = stri}
        };


        private static void Main(string[] args)
        {
            
            var sr = new StreamReader("Project2.dpr");
            var code = sr.ReadToEnd().Split('\n');
            var line_number = 0;
            var errors = new List<Illegal>();
            foreach (var line in code)
            {
                var current_line = line;
                var _line = line.Trim();
                if (current_line=="") continue;
                line_number += 1;
                foreach (var token in _expr)
                {
                    _line = _line.Trim();
                    var pattern = new Regex(token.regex, RegexOptions.IgnoreCase);
                    var tokens = pattern.Matches(_line);
                    _line = getLexem(_line, tokens, token.description, line_number);
                    if (_line == "")
                        break;
                }
                _line = _line.Trim();
                if (_line != "")
                {
                    var err = 0;
                    try
                    {
                        err = current_line.IndexOf(_line)-1;
                    }
                    catch (Exception)
                    {
                        err = 11;
                        throw;
                    }
                    errors.Add(new Illegal() {illegal_line = line_number, illegal_string = line, row = err });
                }
            }
            if (errors.Count == 0)
            {
                foreach (var lexem in found_lexem)
                {
                   
                    Console.WriteLine(lexem.regex + " :\t\t " + lexem.description + " : on line " + lexem.linenum );
                }
            }
            else
            {
                Console.WriteLine("There are some errors");
                foreach (var line in errors)
                    Console.WriteLine(line.illegal_line + " :   " + line.illegal_string+ " ---- symbol #"+line.row);
            }


        }

        public static string getLexem(string line, ICollection tokens, string description, int lineNumber)
        {
            if (tokens.Count != 0)
            {
                line = tokens.Cast<object>().Aggregate(line, (current, token) => current.Replace(token.ToString(), ""));
                foreach (var token in tokens)
                    found_lexem.Add(new Expressions()
                    {
                        description = description,
                        regex = token.ToString(),
                        linenum = lineNumber
                    });
            }
            else
                return line;
            return line;
        }
    }
}
