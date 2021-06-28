unit ufEditCartao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons;

type
  TfEditProduct = class(TForm)
    Panel1: TPanel;
    btnFecha: TButton;
    btnCancela: TButton;
    btnConfirma: TButton;
    qryMaster: TFDQuery;
    dsMaster: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    qryMasterCodigo: TWideStringField;
    qryMasterDescricao: TWideStringField;
    qryMasterAtivo: TWideStringField;
    procedure btnFechaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dsMasterStateChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure qryMasterNewRecord(DataSet: TDataSet);
    procedure qryMasterBeforePost(DataSet: TDataSet);
    procedure qryMasterBeforeEdit(DataSet: TDataSet);
  private
    procedure setbuttons;
    function Duplicated:boolean;
  public
    SenderForm:TForm;
    procedure Open(vCodigo:String);
    procedure New;
  end;

var
  fEditProduct: TfEditProduct;

implementation

{$R *.dfm}

uses ufDefaultSearch, uDM1, ufEditPessoa;

procedure TfEditProduct.Open(vCodigo: String);
begin
  qrymaster.Params[0].Value:=vCodigo;
  qrymaster.Open();
  setbuttons;
end;

procedure TfEditProduct.New;
begin
  qrymaster.Params[0].Value:=0;
  qrymaster.Open();
  qrymaster.Append;
end;
procedure TfEditProduct.setbuttons;
begin
  btnConfirma.Enabled:=qryMaster.State in [dsInsert,dsEdit];
  btnCancela.Enabled:=qrymaster.State in [dsInsert,dsEdit];
  dbedit1.ReadOnly:=(qrymaster.State <> dsInsert);
  if dbedit1.ReadOnly=true then
    dbedit1.Color:=clBtnFace
    else
    dbedit1.Color:=clWindow;
end;
procedure TfEditProduct.dsMasterStateChange(Sender: TObject);
begin
  setbuttons;
end;

procedure TfEditProduct.btnCancelaClick(Sender: TObject);
begin
  if qrymaster.State=dsinsert then close;
  qrymaster.CancelUpdates;
end;

procedure TfEditProduct.btnConfirmaClick(Sender: TObject);
begin
  qrymaster.Post;
  qrymaster.ApplyUpdates(0);
  qrymaster.Params[0].Value:=qrymasterCodigo.Value;
  if assigned(SenderForm) then SenderForm.Hint:='changed';

end;

procedure TfEditProduct.btnFechaClick(Sender: TObject);
begin
  close;
end;

procedure TfEditProduct.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  fEditPessoa:=nil;
end;

procedure TfEditProduct.FormShow(Sender: TObject);
begin
  qrymaster.Open();
end;


procedure TfEditProduct.qryMasterBeforeEdit(DataSet: TDataSet);
begin
  if not dm1.GetAccess(4) then begin
      application.MessageBox('Acesso não permitido.','Negado',mb_iconerror);
      DataSet.Cancel;
      abort;
  end;
end;

procedure TfEditProduct.qryMasterBeforePost(DataSet: TDataSet);
begin
  if Trim(qrymasterCodigo.Value)='' then begin
    application.MessageBox('Preencha o código do cartão.','Código em branco',mb_iconerror);
    abort;
  end;

  if qrymaster.State=dsinsert then begin
    if Duplicated then begin
      application.MessageBox('Já existe um cartão com este código. Verifique e tente um outro código.','Código já existe',mb_iconerror);
      abort;
      end;
  end;
end;

procedure TfEditProduct.qryMasterNewRecord(DataSet: TDataSet);
begin
  qrymasterAtivo.Value:='S';
end;

function TfEditProduct.Duplicated:boolean;
var q:tfdquery;
begin
  q := tfdquery.Create(nil);
  q.Connection := dm1.db1;
  q.SQL.Add('select count(*) from cartoes where cartoes.Codigo='+quotedstr(qrymasterCodigo.value));
  q.Open;
  result:=q.Fields[0].Value >0;
  q.Free;
end;


end.
