unit ufSalesOrders;

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
  IBX.IBQuery, cxLabel,cxGridExportLink, uSalesOrderRules, frxClass, frxDBSet;

type
  TfSalesOrders = class(TForm)
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
    qryMasterNUMBER: TLargeintField;
    qryMasterEMISSIONDATE: TDateField;
    qryMasterCUSTOMERID: TLargeintField;
    qryMasterSALESORDERTOTAL: TFMTBCDField;
    qryMasterFANTASY_NAME: TIBStringField;
    tvMasterNUMBER: TcxGridDBColumn;
    tvMasterEMISSIONDATE: TcxGridDBColumn;
    tvMasterSALESORDERTOTAL: TcxGridDBColumn;
    tvMasterFANTASY_NAME: TcxGridDBColumn;
    frxReport1: TfrxReport;
    frxDBMaster: TfrxDBDataset;
    procedure actCloseExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actOpenExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure qryMasterAfterScroll(DataSet: TDataSet);
    procedure actRefreshExecute(Sender: TObject);
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
    Procedure SetButtons;
  public

  end;

var
  fSalesOrders: TfSalesOrders;

implementation

{$R *.dfm}

uses uTDI,ufMain,uDM1,ufEditSalesOrder, uGlobalFuncs;

procedure tfSalesOrders.SetButtons;
begin
  actOpen.Enabled:=qryMaster.RecordCount>0;
  actDelete.Enabled:=qryMaster.RecordCount>0;
  actPrint.Enabled:=qryMaster.RecordCount>0;
  lbRecordCount.Caption:='  '+formatfloat('#,##0',tvmaster.DataController.RowCount )+' registros';
end;
procedure TfSalesOrders.actCloseExecute(Sender: TObject);
begin
  CloseTabForm(fMain.PageControl1.ActivePage,fMain.PageControl1);
end;

procedure TfSalesOrders.actDeleteExecute(Sender: TObject);
var vmsg1,vmsg2:string;  rule:tSalesOrderRules;
begin
  vMsg1:= qrymasterNumber.AsString;
  vMsg2:='Confirma exclusão do pedido de venda nº '+chr(34)+ vMsg1+chr(34)+' ?';
  if application.MessageBox(pchar(vMsg2),'Excluir',mb_iconquestion+mb_Yesno)=mrYes then begin
    Rule:=tSalesOrderRules.Create(qryMaster);
    if rule.Delete then begin
      application.MessageBox('Pedido de venda excluído com sucesso.','Exclusão',mb_ok);
      actRefresh.execute;
    end
    else
    begin
      application.MessageBox(pchar(rule.msg),'Erro ao excluir',mb_iconerror);
    end;
    rule.Free;
  end;

end;

procedure TfSalesOrders.actExportExecute(Sender: TObject);
begin
  if Filesavedialog1.Execute then
    ExportGridToXLSX(Filesavedialog1.FileName, cxGrid1, true, True, True);
end;

procedure TfSalesOrders.actNewExecute(Sender: TObject);
begin
 fEditSalesOrder:=tfEditSalesOrder.Create(self);
 fEditSalesOrder.New;
 fEditSalesOrder.SenderForm:= self;
 fEditSalesOrder.ShowModal;
 if Self.Hint='changed' then actRefresh.Execute;
 self.Hint:='';

end;

procedure TfSalesOrders.actOpenExecute(Sender: TObject);
begin
 fEditSalesOrder:=tfEditSalesOrder.Create(self);
 fEditSalesOrder.Open(qrymasterNumber.Value);
 fEditSalesOrder.SenderForm:= self;
 fEditSalesOrder.ShowModal;
 if Self.Hint='changed' then actRefresh.Execute;
 self.Hint:='';

end;

procedure TfSalesOrders.actPrintExecute(Sender: TObject);
begin
  frxreport1.ShowReport();
end;

procedure TfSalesOrders.actRefreshExecute(Sender: TObject);
begin
  qryMaster.Active:=false;
  qryMaster.Active:=true;
  setbuttons;
end;

procedure TfSalesOrders.FormShow(Sender: TObject);
begin
  qrymaster.Open;
  setbuttons;
end;

procedure TfSalesOrders.frxReport1GetValue(const VarName: string;
  var Value: Variant);
begin
  if varname='filter' then
    if tvmaster.DataController.Filter.Active then
      value:='Filtro: '+tvmaster.DataController.Filter.FilterCaption
      else
      value:='';
end;

procedure TfSalesOrders.qryMasterAfterScroll(DataSet: TDataSet);
begin
    setbuttons;
end;

end.
