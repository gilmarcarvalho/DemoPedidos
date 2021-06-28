unit ufEditCustomer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   Data.DB,   Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
   cxTextEdit, cxCurrencyEdit, cxDBEdit, IBX.IBCustomDataSet,
  ibx.ibquery,  dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxMaskEdit, uCustomerRules, cxDropDownEdit, cxCalc,
  cxLabel, cxDBLabel;

type
  TfEditCustomer = class(TForm)
    Panel1: TPanel;
    btnFecha: TButton;
    btnCancela: TButton;
    btnConfirma: TButton;
    dsMaster: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    dstMaster: TIBDataSet;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    DBComboBox1: TDBComboBox;
    Label8: TLabel;
    Label9: TLabel;
    dstMasterID: TLargeintField;
    dstMasterFANTASY_NAME: TIBStringField;
    dstMasterSOCIAL_NAME: TIBStringField;
    dstMasterADDRESS: TIBStringField;
    dstMasterNEIGHBORHOOD: TIBStringField;
    dstMasterCITY: TIBStringField;
    dstMasterSTATE: TIBStringField;
    cxDBMaskEdit1: TcxDBMaskEdit;
    dstMasterCNPJ: TIBStringField;
    dstMasterTELEPHONE: TIBStringField;
    cxDBMaskEdit2: TcxDBMaskEdit;
    cxDBLabel1: TcxDBLabel;
    procedure btnFechaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dsMasterStateChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dstMasterBeforePost(DataSet: TDataSet);
  private
    Rules:tcustomerRules;
    procedure setbuttons;

  public
    SenderForm:TForm;
    procedure Open(ID:int64);
    procedure New;
  end;

var
  fEditCustomer: TfEditCustomer;

implementation

{$R *.dfm}

uses  uDM1;

procedure TfEditCustomer.Open(ID: int64);
begin
  dstMaster.Params[0].Value:=ID;
  dstMaster.Open();
  setbuttons;
end;

procedure TfEditCustomer.New;
begin
  dstMaster.Params[0].Value:=0;
  dstMaster.Open();
  dstMaster.Append;
end;
procedure TfEditCustomer.setbuttons;
begin
  btnConfirma.Enabled:=dstMaster.State in [dsInsert,dsEdit];
  btnCancela.Enabled:=dstMaster.State in [dsInsert,dsEdit];
end;
procedure TfEditCustomer.dsMasterStateChange(Sender: TObject);
begin
  setbuttons;
end;

procedure TfEditCustomer.btnCancelaClick(Sender: TObject);
begin
  if dstMaster.State=dsinsert then close;
  dstMaster.CancelUpdates;
end;

procedure TfEditCustomer.btnConfirmaClick(Sender: TObject);
begin
  dstMaster.Post;
  dstMaster.ApplyUpdates;
  dstMaster.Params[0].Value:=dstMasterID.Value;
  if assigned(SenderForm) then SenderForm.Hint:='changed';
end;

procedure TfEditCustomer.btnFechaClick(Sender: TObject);
begin
  close;
end;

procedure TfEditCustomer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  rules.Free;
  action:=cafree;
  fEditCustomer:=nil;
end;

procedure TfEditCustomer.FormShow(Sender: TObject);
begin
  dstMaster.Open;
  Rules:=tCustomerRules.Create(dstMaster);
end;


procedure TfEditCustomer.dstMasterBeforePost(DataSet: TDataSet);
begin
  //verif Business rules for post
  if not Rules.ValidPost then begin
    application.MessageBox(pchar(rules.msg),'Erro ao salvar',mb_iconerror);
    abort;
  end;
  
end;




end.
