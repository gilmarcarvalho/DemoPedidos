//**********************************************//
//*file: uCustomerRules.pas*********************//
//*Summary: business rules of customer register*//
//*Date revision:07/09/2018 (pt-br)*************//
//*Version number:1.0***************************//
//*Created by: Gilmar Carvalho******************//
//**********************************************//

unit uCustomerRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, cxGraphics,   IBX.IBCustomDataSet,
   ibx.ibquery, data.DB;

type
  TCustomerRules = class
    dataset:TIBDataset;
    query:TIBquery;
    msg: string;
    Function ValidPost:boolean ;
    Function Delete:boolean;
    constructor Create(vDataset:TIBDataSet);overload;
    constructor Create(vQuery:TIBQuery);overload;
    destructor Destroy;override;
    private
      function DuplicatedName:boolean;
      function CountOrderSales(customerID:int64):integer;

  end;

implementation

uses uDM1, uGlobalFuncs;

constructor TCustomerRules.Create(vDataset: TIBDataSet);
begin
  self.dataset:=vDataset;
end;
constructor TCustomerRules.Create(vQuery: TIBQuery);
begin
  self.query:=vQuery;
end;

function TCustomerRules.Delete:boolean;
var  SalesOrders:integer;
begin
  msg:='';
  //busca ped. vendas deste cliente
  SalesOrders:=CountOrderSales(query.FieldByName('id').Value);
  if SalesOrders > 0 then begin
    msg:='Não é possível excluir este cliente porque'+
        'existem pedidos de venda com este cliente. ';
    result:=false;
  end
  else
  begin
      dm1.ExecSQL('delete from customers where ID='+query.FieldByName('id').AsString);
      msg:='Cliente excluído com sucesso.';
      result:=true;
  end;
end;

function TCustomerRules.ValidPost:boolean;
begin
    msg:='';
    result:=true;
    if trim(dataset.FieldByName('fantasy_name').AsString)='' then begin
      msg:='Preencha o noem fantasia do cliente.';
      result:=false;
      exit;
    end;

    if DuplicatedName then begin
      msg:='Já existe um cliente com este nome fantasia. Verifique e tente um outro nome.';
      result:=false;
      exit;
    end;
   if self.dataset.FieldByName('id').IsNull then
    self.dataset.FieldByName('id').Value :=dm1.GetID('customers.id');
end;

destructor TCustomerRules.Destroy;
begin
  inherited;
end;

function TCustomerRules.DuplicatedName:boolean;
var q:tibquery;id:int64;name:string;
begin
  id:= ToInteger(self.dataset.FieldByName('id').Value);
  name:=self.dataset.FieldByName('fantasy_name').AsString;
  q := tibquery.Create(nil);
  q.Database := dm1.db1;
  q.SQL.Add('select count(customers.id) from customers where');
  q.SQL.Add(' upper(customers.fantasy_name)=upper(:nm)');
  q.SQL.Add(' and customers.ID <>:id ');
  q.ParamByName('nm').Value:=name;
  q.ParamByName('id').Value:=id;
  q.Open;
  result:=q.Fields[0].Value >0;
  q.Free;

end;

function TCustomerRules.CountOrderSales(customerID:int64):integer;
var q:tibquery; r:integer;
begin
 q:=tibquery.create(nil);
 q.database:=dm1.db1;
 q.sql.add('select count(salesorder.number) from ');
 q.sql.add('salesorder where salesorder.customerid=:p');
 q.params[0].value:=customerID;
 q.open;
 r:=q.fields[0].value;
 q.free;
 result:=r;
 end;




end.
