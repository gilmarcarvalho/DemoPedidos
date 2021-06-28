unit ufConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxDropDownEdit, cxTimeEdit, cxCheckBox, cxLabel,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Vcl.ExtCtrls;

type
  TfConfig = class(TForm)
    btnCancelar: TButton;
    btnFechar: TButton;
    btnSalvar: TButton;
    qryMaster: TFDQuery;
    dsMaster: TDataSource;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBCheckBox1: TDBCheckBox;
    dsHorarios: TDataSource;
    qryHorarios: TFDQuery;
    qryHorariosID: TLargeintField;
    qryHorariosDia: TWideStringField;
    qryHorariosHrSaida: TTimeField;
    qryHorariosHrEntrada: TTimeField;
    qryHorariosHrIntervInicio: TTimeField;
    qryHorariosHrIntervTermino: TTimeField;
    qryHorariosCargaHoraria: TBCDField;
    qryHorariosIntervalo: TWideStringField;
    qryHorariosIDConfiguracao: TLargeintField;
    qryMasterID: TLargeintField;
    qryMasterTempo_registro_duplicado: TIntegerField;
    qryMasterRegistra_registro_duplicado: TWideStringField;
    qryMasterConsidera_dia_anterior: TWideStringField;
    qryMasterNome_Empresa: TWideStringField;
    DBCheckBox2: TDBCheckBox;
    procedure btnFecharClick(Sender: TObject);
    procedure dsMasterStateChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure qryHorariosBeforeEdit(DataSet: TDataSet);
    procedure qryHorariosNewRecord(DataSet: TDataSet);
    procedure qryHorariosIntervaloChange(Sender: TField);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure dsHorariosStateChange(Sender: TObject);
    procedure qryHorariosAfterScroll(DataSet: TDataSet);
    procedure qryMasterAfterOpen(DataSet: TDataSet);
    procedure qryMasterBeforePost(DataSet: TDataSet);
    procedure qryHorariosReconcileError(DataSet: TFDDataSet; E: EFDException;
      UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction);

  private
    Automatic:boolean;
    procedure setbuttons;
     procedure SetHorarioIDConfiguracao;
  public
    { Public declarations }
  end;

var
  fConfig: TfConfig;

implementation

{$R *.dfm}

uses uGlobalFuncs, uDM1;

procedure TfConfig.dsHorariosStateChange(Sender: TObject);
begin
  setbuttons;
end;

procedure TfConfig.dsMasterStateChange(Sender: TObject);
begin
  setbuttons;
end;

procedure TfConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  fConfig:=nil;
end;

procedure TfConfig.FormShow(Sender: TObject);
begin
  qrymaster.Open();
  qryHorarios.Open();
end;

procedure TfConfig.qryHorariosAfterScroll(DataSet: TDataSet);
begin
  setbuttons;
end;

procedure TfConfig.qryHorariosBeforeEdit(DataSet: TDataSet);
begin
  if Automatic then exit;
  qrymaster.Edit;
  if not(qrymaster.State in [dsinsert,dsedit]) then
    abort;

end;

procedure TfConfig.qryHorariosIntervaloChange(Sender: TField);
begin
  if qryHorarios.State in [dsInsert,dsedit] then begin
    if sender.Value='N' then begin
      qryHorariosHrIntervInicio.Clear;
      qryHorariosHrIntervTermino.Clear;
    end;
  end;

end;

procedure TfConfig.qryHorariosNewRecord(DataSet: TDataSet);
begin
  qryHorariosIntervalo.Value:='N';
end;


procedure TfConfig.qryHorariosReconcileError(DataSet: TFDDataSet;
  E: EFDException; UpdateKind: TFDDatSRowState;
  var Action: TFDDAptReconcileAction);
begin
  showmessage(e.Message);
end;

procedure TfConfig.qryMasterAfterOpen(DataSet: TDataSet);
begin
  qryHorarios.Params[0].Value:=qrymasterID.Value;
end;

procedure TfConfig.qryMasterBeforePost(DataSet: TDataSet);
begin
  SetHorarioIDConfiguracao;
end;



procedure TfConfig.setbuttons;
begin
  btnCancelar.Enabled:=qrymaster.State in [dsinsert,dsedit];
  btnSalvar.Enabled:=qrymaster.State in  [dsinsert,dsedit];
end;

procedure TfConfig.SetHorarioIDConfiguracao;
begin
  Automatic:=true;
  qryHorarios.First;
  qryHorarios.DisableControls;
  while not qryHorarios.Eof do begin
    if qryHorariosIDconfiguracao.IsNull then begin
      qryHorarios.Edit;
      qryHorariosIDconfiguracao.Value:=qryMasterID.Value;
      qryHorarios.Post;
    end;
    qryHorarios.Next;
  end;
  qryHorarios.EnableControls;
  qryHorarios.Params[0].Value:=qryMasterID.Value;
  Automatic:=false;
end;

procedure TfConfig.btnCancelarClick(Sender: TObject);
begin
  qrymaster.CancelUpdates;
  qryHorarios.CancelUpdates;
end;

procedure TfConfig.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfConfig.btnSalvarClick(Sender: TObject);
begin
  if qryHorarios.State in [dsinsert,dsedit] then qryhorarios.Post;
  qrymaster.Post;
  qrymaster.ApplyUpdates(0);
  qryHorarios.ApplyUpdates(0);
  application.MessageBox(pchar('Configurações salvas.'+chr(10)+
        'As configurações serão aplicadas na próxima inicialização do sistema.'),'Aviso',mb_ok);
end;

procedure TfConfig.Button1Click(Sender: TObject);
begin
  if qryHorarios.RecordCount >= 7 then begin
   application.MessageBox(pchar('Você já inseriu 7 dias no horário.'+chr(10)+
     ' Não é permitido inserir mais do que 7 dias, que correspondem à uma semana completa.'),
     'Impossível inserir',mb_iconerror);
   abort;
  end;
  qrymaster.Edit;
  if qrymaster.State in [dsInsert,dsEdit] then
    qryHorarios.Append;

end;

procedure TfConfig.Button2Click(Sender: TObject);
begin
 qrymaster.Edit;
  if qrymaster.State in [dsInsert,dsEdit] then
    qryHorarios.Delete;
end;

end.
