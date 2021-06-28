program Vendas;

uses
  Vcl.Forms,
  ufMain in 'ufMain.pas' {fMain},
  uDM1 in 'uDM1.pas' {dm1: TDataModule},
  uGlobalFuncs in 'uGlobalFuncs.pas',
  ufSalesOrders in 'ufSalesOrders.pas' {fSalesOrders},
  ufEditSalesOrder in 'ufEditSalesOrder.pas' {fEditSalesOrder},
  uProductRules in 'uProductRules.pas',
  ufProducts in 'ufProducts.pas' {fProducts},
  uCustomerRules in 'uCustomerRules.pas',
  ufEditProduct in 'ufEditProduct.pas' {fEditProduct},
  ufCustomers in 'ufCustomers.pas' {fCustomers},
  ufEditCustomer in 'ufEditCustomer.pas' {fEditCustomer},
  uSalesOrderRules in 'uSalesOrderRules.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Obras';
  Application.CreateForm(Tdm1, dm1);
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
