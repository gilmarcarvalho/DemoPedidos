unit uGlobalFuncs;

interface

uses
Windows, Forms,Dialogs, Messages, SysUtils, Classes, Controls, StdCtrls, Mask,
Variants,Graphics,Jpeg,strutils,DB, DBClient,DateUtils,Inifiles,Buttons,Math,
ComObj, vcl.dbgrids, FireDAC.Comp.Client,FireDAC.stan.option,IBX.IBquery;


Function ToInteger(Expr:Variant):integer; //Converte em número inteiro
Function ToFloat(Expr:Variant):Double; //Converte em número Double precision
Function IsDate(Expr: Variant):Boolean; //Verifica se é data
Function IsTime(Expr: Variant):Boolean; //Verifica se é hora
Function IsNumber(Expr: Variant):Boolean; //Verifica se é numero
Function IsFloat(Expr: string):Boolean; //Verifica se é numero fracionario
Function IsInteger(Expr: string):Boolean; //Verifica se é numero
Function PictureSize(PicFile: String):integer;
function BuscaTroca(Text,Busca,Troca : string) : string;
Function DecimalToHoras(numDecimal:variant):String;  //converte número em horas
Function ExtraiNumAno(Numero:String):integer;
function ContaDiasUteis(dtinicial, dtfinal:Tdate):Integer;
Function NumberOrNull(Numero:Variant):String;
function DiasNoMes(Ayear, AMonth: Integer): Integer;
function AnoBiSexto(Ayear: Integer): Boolean;
Function DifHora(hrInicial:TTime;HrFinal:TTime):String;
Function NumToMes(nMes:byte):String;
Function Crypt(Action, Src: String): String;

implementation

uses udm1;

// Verifica se o ano é Bi-Sexto
function AnoBiSexto(Ayear: Integer): Boolean;
begin
 Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or
 (AYear mod 400 = 0));
end;
//Quantos dias tem o mes
function DiasNoMes(Ayear, AMonth: Integer): Integer;
 const DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
 begin
 Result := DaysInMonth[AMonth];
 if (AMonth = 2) and AnoBiSexto(AYear) then
 Inc(Result);
end;
Function NumberOrNull(Numero:Variant):String;
begin
 //USADO PARA FORMAR SQL'S//
 if (vartype(Numero)=varEmpty)or(vartype(Numero)=varNull) then begin
  result:='NULL';
  end else begin
  result:=quotedstr(vartostr(Numero));
 end;
end;

function ContaDiasUteis(dtinicial,dtfinal:TDate):Integer;
  var
    contador : Integer;
    data : TDate;
  begin
    contador := 0 ;
    data:= dtinicial;
    while data <= dtfinal do   begin
      if not (Dayoftheweek(data) in [6..7]) then
       inc (contador);
       data :=data+1;
    end;
    result:=contador;
end;

Function DecimalToHoras(numDecimal:variant):String;
 var
 Hrs, Min: word;
 secs: longint;
 begin
 secs:= numdecimal *3600;
 Hrs := Secs div 3600;
 Secs := Secs mod 3600;
 Min := Secs div 60;
 Secs := Secs mod 60;
 result:=formatfloat('00',hrs)+':'+ formatfloat('00',min);
end;


Function ToInteger(Expr: Variant):Integer;
var r:integer;
begin
 expr:=vartostr(expr);
 if tryStrtoint(Expr,r) then
  result:=r
  else
  result:=0;
end;

Function ToFloat(Expr: Variant):Double;
var r:double;
begin
 expr:=vartostr(expr);
 if tryStrtofloat(Expr,r) then
  result:=r
  else
  result:=0;
end;

function BuscaTroca(Text,Busca,Troca : string) : string;
{ Substitui um caractere dentro da string}
var n : integer;
begin
for n := 1 to length(Text) do
  begin
  if Copy(Text,n,1) = Busca then
  begin
  Delete(Text,n,1);
  Insert(Troca,Text,n);
  end;
  end;
Result := Text;
end;



Function IsDate(Expr: Variant):Boolean;
begin
  result:=true;
  try
    expr:=strtodate(vartostr(Expr));
    except
    result:=false;
  end;
end;

Function IsTime(Expr: Variant):Boolean;
begin
  result:=true;
  try
    expr:=strtotime(vartostr(Expr));
    except
    result:=false;
  end;
end;

Function PictureSize(PicFile: String):integer;
 var F: file of byte;
 begin
  try
   assignfile(F,picfile);
   reset(F);
   result:=filesize(F);
   closefile(F);
  except
   closefile(f);
   result:=0;
  end;
end;


Function ExtraiNumAno(Numero:String):integer;
var Ano:string;
begin
 Ano:=AnsiRightStr(numero ,2);
 try
  result:=strtoint(ano);
  except
  result:=0;
 end;
end;

Function DifHora(hrInicial:TTime;HrFinal:TTime):String;
//Retorna a diferença entre duas horas}
begin
 If (HrInicial > HrFinal) then
  begin
   Result := TimeToStr((StrTotime('23:59:59')+ StrToTime('00:00:01')-HrInicial)+HrFinal)
  end
 else
  begin
   Result := TimeToStr(HrFinal-HrInicial);
  end;
end;

Function ValidDouble(Valor: Variant):Double;
begin
if valor=null then begin
 Result:=0;
 end else begin
  try
   Result:=strtofloat(vartostr(valor));
  except
  result:=0;
 end
end;
end;

Function NumToMes(nMes:byte):String;
//retorna o mes por extenso
begin
 case nMes of
  1: result:='Janeiro';
  2: result:='Feveiro';
  3: result:='Março';
  4: result:='Abril';
  5: result:='Maio';
  6: result:='Junho';
  7: result:='Julho';
  8: result:='Agosto';
  9: result:='Setembro';
  10: result:='Outubro';
  11: result:='Novembro';
  12: result:='Dezembro';
 end;
end;

Function IsNumber(Expr: Variant):Boolean; //Verifica se é numero
var n:double;
begin
  result:=true;
  try
    n:=strtofloat(vartostr(expr));
    except
    result:=false;
  end;
end;

Function IsFloat(Expr: String):Boolean; //Verifica se é numero float
var iValue:double; iCode:integer;
begin
  Expr:=stringreplace(Expr,',','.',[rfReplaceAll, rfIgnoreCase]); //coverte virgula em ponto
  val(Expr,iValue,iCode);
  if iCode=0 then
    result:=true
    else
    result:=false;
end;

Function IsInteger(Expr: String):Boolean; //Verifica se é numero inteiro
var iValue,iCode:integer;
begin
  val(Expr,iValue,iCode);
  if iCode=0 then
    result:=true
    else
    result:=false;
end;



Function FloatToMoeda(FloatValue:Double):Currency;
var r:Currency;
begin
  try
  r:=floattocurr(Floatvalue);
  except
  r:=0;
  end;
  Result:=r;
end;

Function Crypt(Action, Src: String): String;
Label Fim;
var KeyLen : Integer;
  KeyPos : Integer;
  OffSet : Integer;
  Dest, Key : String;
  SrcPos : Integer;
  SrcAsc : Integer;
  TmpSrcAsc : Integer;
  Range : Integer;
begin
  if (Src = '') Then
  begin
    Result:= '';
    Goto Fim;
  end;
  Key :='YUQL23KL23DF90WI5E1JAS467NMCXXL6JAOAUWWMCL0AOMM4A4VZYW9KHJUI2347EJHJKDF3424SKL';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 256;
  if (Action = UpperCase('C')) then
  begin
    Randomize;
    OffSet := Random(Range);
    Dest := Format('%1.2x',[OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then KeyPos := KeyPos + 1 else KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x',[SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$'+ copy(Src,1,2));
    SrcPos := 3;
  repeat
    SrcAsc := StrToInt('$'+ copy(Src,SrcPos,2));
    if (KeyPos < KeyLen) Then KeyPos := KeyPos + 1 else KeyPos := 1;
    TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
    if TmpSrcAsc <= OffSet then TmpSrcAsc := 255 + TmpSrcAsc - OffSet
    else TmpSrcAsc := TmpSrcAsc - OffSet;
    Dest := Dest + Chr(TmpSrcAsc);
    OffSet := SrcAsc;
    SrcPos := SrcPos + 2;
  until (SrcPos >= Length(Src));
  end;
  Result:= Dest;
  Fim:
end;








end.
