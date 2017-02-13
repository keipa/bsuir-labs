program Project2;

{$APPTYPE CONSOLE}



uses
  sysutils,
  Classes;

const
  C_FNAME = 'DataSorted.txt';

var
  num1:integer;
  i,j, min, tmp:integer;
  data1:array[1..5000] of integer;
  f:textfile;
  fOut: TextFile;

type
  SortedArray = array[1..5000] of integer;

function bubSort(data: array of integer): SortedArray;
begin
     for i := 0 to (num1 - 1) do
     begin
          for j := 0 to (num1 - 1 - i) do
          begin
               if data[j + 1] < data[j] then
                  begin
                  data[tmp] := data[j];
                  data[j] := data[j + 1];
                  data[j + 1] := data[tmp];
                  end;
          end;
     end;
     for i := 1 to num1 do
     begin
       writeln(data[i],' ');
     end;
    AssignFile(fOut, C_FNAME);
    Rewrite(fOut);
    CloseFile(fOut);
    AssignFile(fOut, C_FNAME);
    append(fOut);
    for i := 1 to num1 do
     begin
       writeln(fOut, data[i]);
     end;
    CloseFile(fOut);
end;
begin
  assignFile(f, 'Data1.txt');
  writeln('Read Data1.txt');
     reset(f);
     read (f,num1);
     num1 := 0;
     While Not EOF(f) Do
      Begin
      num1 := num1 + 1;
      read(f,data1[num1]);
      End;
     closefile(f);
     writeln(num1);
     for i := 1 to num1 do
     begin
        writeln(data1[i],' ');
     end;
  writeln;
  writeln('Data1.txt successfully read!');
  readln;
  bubSort(data1);
  writeln('Sorted!');
  readln;
end.
