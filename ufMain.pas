unit ufMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxRibbonCustomizationForm, dxRibbonSkins, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
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
  dxSkinXmas2008Blue, cxClasses, dxRibbon, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ToolWin, Vcl.ActnCtrls,
  dxBar, Vcl.ComCtrls, Vcl.AppEvnts, Vcl.ExtCtrls, dxBarExtItems, cxContainer,
  cxEdit, cxTextEdit, cxHyperLinkEdit;

type
  TfMain = class(TForm)
    dxRibbon1Tab1: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarLargeButton1: TdxBarLargeButton;
    ActionList1: TActionList;
    actProducts: TAction;
    actCustomers: TAction;
    dxBarLargeButton2: TdxBarLargeButton;
    dxBarLargeButton3: TdxBarLargeButton;
    PageControl1: TPageControl;
    StatusBar1: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    actSalesOrder: TAction;
    dxBarLargeButton4: TdxBarLargeButton;
    procedure actProductsExecute(Sender: TObject);
    procedure actCustomersExecute(Sender: TObject);
    procedure actConfigExecute(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure actSalesOrderExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses uDM1,uTDI,ufProducts, ufCustomers, ufSalesOrders, ufConfig;

procedure TfMain.actProductsExecute(Sender: TObject);
begin
    NewTabForm(tfProducts,Pagecontrol1,Pagecontrol1);
end;

procedure TfMain.actSalesOrderExecute(Sender: TObject);
begin
    NewTabForm(tfSalesOrders,Pagecontrol1,Pagecontrol1);
end;

procedure TfMain.actCustomersExecute(Sender: TObject);
begin
   NewTabForm(tfCustomers,Pagecontrol1,Pagecontrol1);
end;

procedure TfMain.actConfigExecute(Sender: TObject);
begin
  fConfig:=tfconfig.create(self);
  fconfig.showmodal;
end;

procedure TfMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
var Msg: String;
begin
  if Pos('is not a valid integer', e.Message ) > 0 then begin
   msg:='Número inválido.'
  end else
  if Pos('date and time', e.Message ) > 0 then begin
   msg:='Informe uma data e hora válida.'
  end else
  if Pos('is not a valid time', e.Message) > 0 then begin
   msg:='Informe uma hora válida.'
  end else
  if Pos('is not a valid date', e.Message) > 0 then begin
   msg:='Informe uma data válida.'
  end else
  if Pos('is not a valid floating point', e.Message) > 0 then begin
   msg:='Número inválido.'
  end else
  if Pos('is not a valid BCD value', e.Message) > 0 then begin
   msg:='Número inválido.'
  end else
   if Pos('Image size exceeds', e.Message) > 0 then begin
   msg:='Esta imagem é muito grande para ser inserida, escolha uma imagem menor.'
  end else
   if Pos('Invalid floating point', e.Message) > 0 then begin
   msg:='Número inválido.'
  end else
   if Pos('Unable to complete network', e.Message) > 0 then begin
   msg:='Conexão com servidor de dados foi interrompida, verifique suas conexões de rede ou entre em contato com supoerte técnico.'
  end else begin
   msg:='Erro interno do sistema:'+chr(10)+e.Message
   end;
   application.MessageBox(pchar(msg),'Erro',MB_ICONERROR);
end;

procedure TfMain.FormShow(Sender: TObject);
begin

  Statusbar1.Panels[0].Text:=' Banco de dados: ' + dm1.Current_Server;
end;

procedure TfMain.PageControl1Change(Sender: TObject);
begin
  PageControlChange(Pagecontrol1);
end;

end.
