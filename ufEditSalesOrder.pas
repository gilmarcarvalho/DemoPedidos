unit ufEditSalesOrder;

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
  dxSkinXmas2008Blue, cxMaskEdit, cxDropDownEdit, cxCalc,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, cxCalendar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,uSalesOrderRules, cxLabel,
  cxDBLabel, frxClass, frxDBSet;

type
  TfEditSalesOrder = class(TForm)
    Panel1: TPanel;
    btnClose: TButton;
    btnCancel: TButton;
    btnConfirm: TButton;
    dsMaster: TDataSource;
    Label2: TLabel;
    Label1: TLabel;
    dstMaster: TIBDataSet;
    cxDBLookupComboBox1: TcxDBLookupComboBox;
    qryCustomers: TIBQuery;
    qryCustomersID: TLargeintField;
    qryCustomersFANTASY_NAME: TIBStringField;
    dsCustomers: TDataSource;
    cxDBDateEdit1: TcxDBDateEdit;
    Label3: TLabel;
    dstMasterNUMBER: TLargeintField;
    dstMasterEMISSIONDATE: TDateField;
    dstMasterCUSTOMERID: TLargeintField;
    dstMasterDISCOUNT: TIBBCDField;
    Label5: TLabel;
    cxDBCurrencyEdit1: TcxDBCurrencyEdit;
    Label4: TLabel;
    Label6: TLabel;
    lbTotalItens: TcxLabel;
    lbTotalOrder: TcxLabel;
    cxDBLabel1: TcxDBLabel;
    dstItens: TIBDataSet;
    dstItensID: TLargeintField;
    dstItensSALESORDERNUMBER: TLargeintField;
    dstItensPRODUCTID: TLargeintField;
    dstItensQUANTITY: TIBBCDField;
    dstItensUNITPRICE: TIBBCDField;
    dstItensTotalPrice: TBCDField;
    qryProducts: TIBQuery;
    qryProductsID: TLargeintField;
    qryProductsDESCRIPTION: TIBStringField;
    qryProductsPRICE: TIBBCDField;
    dsItens: TDataSource;
    dsProducts: TDataSource;
    Panel2: TPanel;
    btnNewItem: TButton;
    btnDeleteItem: TButton;
    cxGrid1: TcxGrid;
    tvItens: TcxGridDBTableView;
    tvItensID: TcxGridDBColumn;
    tvItensSALESORDERNUMBER: TcxGridDBColumn;
    tvItensPRODUCTID: TcxGridDBColumn;
    tvItensQUANTITY: TcxGridDBColumn;
    tvItensUNITPRICE: TcxGridDBColumn;
    tvItensTotalPrice: TcxGridDBColumn;
    cxGrid1Level1: TcxGridLevel;
    btnPrint: TButton;
    frxReport1: TfrxReport;
    frxDBMaster: TfrxDBDataset;
    frxDBItens: TfrxDBDataset;
    dstMasterCustomerName: TStringField;
    dstItensProductDescription: TStringField;
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dsMasterStateChange(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure dstMasterBeforePost(DataSet: TDataSet);
    procedure dstItensCalcFields(DataSet: TDataSet);
    procedure btnNewItemClick(Sender: TObject);
    procedure btnDeleteItemClick(Sender: TObject);
    procedure dstItensBeforePost(DataSet: TDataSet);
    procedure dsItensStateChange(Sender: TObject);
    procedure dstItensAfterDelete(DataSet: TDataSet);
    procedure dstMasterDISCOUNTChange(Sender: TField);
    procedure dstItensPRODUCTIDChange(Sender: TField);
    procedure btnPrintClick(Sender: TObject);
  private
    Rules:tSalesOrderRules;
    procedure setbuttons;
    procedure CalcTotals;
  public
    SenderForm:TForm;
    procedure Open(ID:int64);
    procedure New;
  end;

var
  fEditSalesOrder: TfEditSalesOrder;

implementation

{$R *.dfm}

uses  uDM1, uGlobalFuncs;

procedure TfEditSalesOrder.Open(ID: int64);
begin
  dstMaster.Params[0].Value:=ID;
  dstMaster.Open();
  setbuttons;
end;

procedure TfEditSalesOrder.New;
begin
  dstMaster.Params[0].Value:=0;
  dstMaster.Open();
  dstMaster.Append;
end;
procedure TfEditSalesOrder.setbuttons;
var changed:boolean;
begin
  changed:= (dstMaster.State in [dsInsert,dsEdit])or
            (dstitens.UpdatesPending)or
            (dstitens.State in [dsinsert,dsedit]) ;

  btnDeleteItem.Enabled:=dstItens.RecordCount>0;
  btnConfirm.Enabled:=changed;
  btnCancel.Enabled:=changed;
  btnPrint.Enabled:=not Changed;
  CalcTotals;
end;
procedure TfEditSalesOrder.dsItensStateChange(Sender: TObject);
begin
  setbuttons;
end;

procedure TfEditSalesOrder.dsMasterStateChange(Sender: TObject);
begin
  setbuttons;
end;

procedure TfEditSalesOrder.btnCancelClick(Sender: TObject);
begin
  if dstMaster.State=dsinsert then close;
  dstMaster.CancelUpdates;
  dstItens.CancelUpdates;
  setbuttons;
end;

procedure TfEditSalesOrder.btnConfirmClick(Sender: TObject);
begin
  if dstitens.State in [dsinsert,dsedit] then
    dstitens.Post;
  if dstitens.State =dsBrowse then begin
    if dstmaster.State in [dsinsert,dsedit] then begin
      dstMaster.Post;
      dstMaster.ApplyUpdates;
    end;
    dstitens.ApplyUpdates;
  end;
  dstMaster.Params[0].Value:=dstMasterNumber.Value;
  dstItens.Params[0].Value:=dstMasterNumber.Value;
 if assigned(SenderForm) then SenderForm.Hint:='changed';
 setbuttons;
end;

procedure TfEditSalesOrder.btnPrintClick(Sender: TObject);
begin
  frxreport1.ShowReport();
end;

procedure TfEditSalesOrder.btnCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfEditSalesOrder.btnNewItemClick(Sender: TObject);
begin
  dstItens.Append;
end;

procedure TfEditSalesOrder.btnDeleteItemClick(Sender: TObject);
begin
  dstitens.Delete;

end;

procedure TfEditSalesOrder.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  rules.Free;
  action:=cafree;
  fEditSalesOrder:=nil;
end;

procedure TfEditSalesOrder.FormShow(Sender: TObject);
begin
  qryCustomers.open;
  qryProducts.Open;
  dstMaster.Open;
  dstitens.ParamByName('number').Value:=dstmasterNumber.Value;
  dstItens.Open;
  Rules:=tSalesOrderRules.Create(dstMaster,dstitens);
end;


procedure TfEditSalesOrder.dstItensAfterDelete(DataSet: TDataSet);
begin
  setbuttons;
end;

procedure TfEditSalesOrder.dstItensBeforePost(DataSet: TDataSet);
begin
  //verif Business rules for post
  if not Rules.ValidPostItem then begin
    application.MessageBox(pchar(rules.msg),'Erro ao salvar ítem',mb_iconerror);
    abort;
  end;

end;

procedure TfEditSalesOrder.dstItensCalcFields(DataSet: TDataSet);
begin
  dstItensTotalPrice.Value:=dstItensQuantity.Value*dstItensUnitPrice.Value;
end;

procedure TfEditSalesOrder.dstItensPRODUCTIDChange(Sender: TField);
begin
  rules.OnChangeProductID;
end;

procedure TfEditSalesOrder.dstMasterBeforePost(DataSet: TDataSet);
begin
  //verif Business rules for post
  if not Rules.ValidPost then begin
    application.MessageBox(pchar(rules.msg),'Erro ao salvar',mb_iconerror);
    abort;
  end;

end;
procedure TfEditSalesOrder.dstMasterDISCOUNTChange(Sender: TField);
begin
  CalcTotals;
end;

procedure TfEditSalesOrder.CalcTotals;
var vlItens,vlOrder: double;
begin
  VlItens:=toFloat(tvitens.DataController.Summary.FooterSummaryValues[0]);
  vlOrder:=vlItens-dstMasterDiscount.Value;
  lbtotalitens.Caption:=floattostrf(vlItens,ffcurrency,18,2);
  lbTotalOrder.Caption:=floattostrf(vlOrder,ffcurrency,18,2);
end;




end.
