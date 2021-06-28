unit uDM1;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls,
  cxImageList, cxGraphics, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, vcl.dialogs,System.inifiles,vcl.Forms, WinAPI.Windows, system.variants,
  IBX.IBDatabase, IBX.IBCustomDataSet, IBX.IBQuery;

type
  Tdm1 = class(TDataModule)
    cxImageList24: TcxImageList;
    cxImageList32: TcxImageList;
    cxSmallImages16: TcxImageList;
    db1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    Current_Server: string;
    Procedure LoadConfig;
    procedure ExecSQL(SQLText: string);
    function GetID(KeyName:string): int64;
    function DuplicatedName(tableName: string; KeyName: string; KeyValue: Int64; NameField: string;NameValue:string):boolean;

    Function VersaoExe: String;
  end;

var
  dm1: Tdm1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Function Tdm1.VersaoExe: String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: String;
begin
  Arquivo := application.ExeName;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '\', Buffer, Tamanho);
      F := PFFI(Buffer);
      result := Format('%d.%d', [HiWord(F^.dwFileVersionMs),
        LoWord(F^.dwFileVersionMs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;



function Tdm1.GetID(keyName:string): int64;
var
  q: tibquery;
  r: int64;
begin
  q := tibquery.Create(nil);
  q.Database := db1;
  q.SQL.Add('SELECT  Keyvalue FROM   primarykeys');
  q.SQL.Add('where keyname='+quotedstr(keyname));
  q.Open;
  if q.Fields[0].IsNull then
    r := 1
  else
    r := q.Fields[0].Value + 1;
  q.Close;
  q.SQL.Clear;
  q.SQL.Add('UPDATE primarykeys  SET  KeyValue= '+inttostr(r));
  q.SQL.Add('where keyname='+quotedstr(keyname));
  q.ExecSQL;
  q.Free;
  result := r;
end;

procedure tdm1.ExecSQL(SQLText: string);
var q:tibquery;
begin
  q:=tibquery.Create(nil);
  q.database:=db1;
  q.SQL.Text:=sqltext;
  q.ExecSQL;
  q.Free;
end;

function tdm1.DuplicatedName(tableName: string; KeyName: string; KeyValue: Int64; NameField: string;NameValue:string):boolean;
var q:tibquery;
begin
  q := tibquery.Create(nil);
  q.database := db1;
  q.SQL.Add('Select count(*) from '+tablename+' where '+NameField+' =  '+quotedstr(Namevalue));
  q.SQL.Add(' and '+keyName+' <>  '+inttostr(keyValue));
  q.Open;
  result:=q.Fields[0].Value >0;
  q.Free;
end;

procedure Tdm1.DataModuleCreate(Sender: TObject);
begin
  LoadConfig;
end;

Procedure Tdm1.LoadConfig;
var
  ConfINI: TIniFile;
begin
  try
    ConfINI := TIniFile.Create(extractfiledir(application.ExeName) +'\conf.ini');
  except
    application.MessageBox
      ('Não foi possível carregar arquivos de inicialização, favor executar a Configuração de conexão.',
      'Impossível carregar configurações', MB_ICONERROR);
    ConfINI.Free;
    application.Terminate;
  end;

  try
    db1.DatabaseName:= ConfINI.ReadString('DatabaseConnection',  'database', '');
    db1.Params.BeginUpdate;
    db1.Params.Values['user_name'] := ConfINI.ReadString('DatabaseConnection',  'user_name', '');
    db1.Params.Values['password'] := ConfINI.ReadString('DatabaseConnection',  'password', '');
    db1.Params.EndUpdate;
    db1.Connected := true;
    Current_Server := db1.DatabaseName;
  except
    application.MessageBox
      ('Não foi possível realizar conexão com o banco de dados, verifique se as configurações de conexão estão corretas.',
      'Falha de conexão', MB_ICONERROR);
    application.Terminate;
  end;
  ConfINI.Free;
end;


end.
