unit ufCustomers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.ExtCtrls, 
  System.Dateutils, cxClasses, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
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
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxBar, IBX.IBCustomDataSet,
  IBX.IBQuery, cxLabel,cxGridExportLink, uCustomerRules;

type
  TfCustomers = class(TForm)
    ActionList1: TActionList;
    actClose: TAction;
    actNew: TAction;
    actOpen: TAction;
    actDelete: TAction;
    actPrint: TAction;
    actExport: TAction;
    dsMaster: TDataSource;
    lbRecordCount: TLabel;
    actRefresh: TAction;
    tvMaster: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarLargeButton1: TdxBarLargeButton;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    dxBarLargeButton4: TdxBarLargeButton;
    dxBarLargeButton5: TdxBarLargeButton;
    dxBarLargeButton6: TdxBarLargeButton;
    qryMaster: TIBQuery;
    dxBarLargeButton7: TdxBarLargeButton;
    FileSaveDialog1: TFileSaveDialog;
    qryMasterID: TLargeintField;
    qryMasterFANTASY_NAME: TIBStringField;
    qryMasterSOCIAL_NAME: TIBStringField;
    qryMasterADDRESS: TIBStringField;
    qryMasterNEIGHBORHOOD: TIBStringField;
    qryMasterCITY: TIBStringField;
    qryMasterSTATE: TIBStringField;
    tvMasterID: TcxGridDBColumn;
    tvMasterFANTASY_NAME: TcxGridDBColumn;
    tvMasterSOCIAL_NAME: TcxGridDBColumn;
    tvMasterCNPJ: TcxGridDBColumn;
    tvMasterADDRESS: TcxGridDBColumn;
    tvMasterNEIGHBORHOOD: TcxGridDBColumn;
    tvMasterCITY: TcxGridDBColumn;
    tvMasterSTATE: TcxGridDBColumn;
    tvMasterTELEPHONE: TcxGridDBColumn;
    qryMasterCNPJ: TIBStringField;
    qryMasterTELEPHONE: TIBStringField;
    procedure actCloseExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMasterAfterScroll(DataSet: TDataSet);
    procedure actRefreshExecute(Sender: TObject);
  private
    { Private declarations }
    Procedure SetButtons;
  public

  end;

var
  fCustomers: TfCustomers;

implementation

{$R *.dfm}

uses uTDI,ufMain,uDM1,ufEditCustomer, uGlobalFuncs;

procedure tfCustomers.SetButtons;
begin
  actOpen.Enabled:=qryMaster.RecordCount>0;
  actDelete.Enabled:=qryMaster.RecordCount>0;
  actPrint.Enabled:=qryMaster.RecordCount>0;
  lbRecordCount.Caption:='  '+formatfloat('#,##0',tvmaster.DataController.RowCount )+' registros';
end;
procedure TfCustomers.actCloseExecute(Sender: TObject);
begin
  CloseTabForm(fMain.PageControl1.ActivePage,fMain.PageControl1);
end;

procedure TfCustomers.actDeleteExecute(Sender: TObject);
var vmsg1,vmsg2:string;  rule:tcustomerRules;
begin
  vMsg1:= qrymasterID.AsString+' - '+qrymasterFantasy_name.AsString;
  vMsg2:='Confirma exclusão do cliente '+chr(34)+ vMsg1+chr(34)+' ?';
  if application.MessageBox(pchar(vMsg2),'Excluir',mb_iconquestion+mb_Yesno)=mrYes then begin
    Rule:=tcustomerRules.Create(qryMaster);
    if rule.Delete then begin
      application.MessageBox('Cliente excluído com sucesso.','Exclusão',mb_ok);
      actRefresh.execute;
    end
    else
    begin
      application.MessageBox(pchar(rule.msg),'Erro ao excluir',mb_iconerror);
    end;
    rule.Free;
  end;

end;

procedure TfCustomers.actExportExecute(Sender: TObject);
begin
  if Filesavedialog1.Execute then
    ExportGridToXLSX(Filesavedialog1.FileName, cxGrid1, true, True, True);
end;

procedure TfCustomers.actNewExecute(Sender: TObject);
begin
 fEditCustomer:=tfEditCustomer.Create(self);
 fEditCustomer.New;
 fEditCustomer.SenderForm:= self;
 fEditCustomer.ShowModal;
 if Self.Hint='changed' then actRefresh.Execute;
 self.Hint:='';

end;

procedure TfCustomers.actOpenExecute(Sender: TObject);
begin
 fEditCustomer:=tfEditCustomer.Create(self);
 fEditCustomer.Open(qrymasterID.Value);
 fEditCustomer.SenderForm:= self;
 fEditCustomer.ShowModal;
 if Self.Hint='changed' then actRefresh.Execute;
 self.Hint:='';

end;

procedure TfCustomers.actPrintExecute(Sender: TObject);
begin
//
end;

procedure TfCustomers.actRefreshExecute(Sender: TObject);
begin
  qryMaster.Active:=false;
  qryMaster.Active:=true;
  setbuttons;
end;

procedure TfCustomers.FormShow(Sender: TObject);
begin
  qrymaster.Open;
  setbuttons;
end;

procedure TfCustomers.qryMasterAfterScroll(DataSet: TDataSet);
begin
    setbuttons;
end;

end.
