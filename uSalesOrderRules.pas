//**********************************************//
//*file: uSalesOrderRules.pas*******************//
//*Summary: business rules of sales Orders******//
//*Date revision:07/09/2018 (pt-br)*************//
//*Version number:1.0***************************//
//*Created by: Gilmar Carvalho******************//
//**********************************************//

unit uSalesOrderRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, cxGraphics,   IBX.IBCustomDataSet,
   ibx.ibquery, data.DB;

type
  TSalesOrderRules = class
    datasetMaster:TIBDataset;
    datatsetItens:TIBDataset;
    query:TIBquery;
    msg: string;
    Function ValidPost:boolean ;
    function ValidPostItem:boolean;
    procedure OnChangeProductID;
    Function Delete:boolean;
    constructor Create(vDatasetMaster: TIBDataSet;vDatasetItens:TIBDataset);overload;
    constructor Create(vQuery:TIBQuery);overload;
    destructor Destroy;override;
    private
      procedure SetItensForeignKey;
      Function GetItemUnitPrice:double;

  end;

implementation

uses uDM1, uGlobalFuncs;

constructor TSalesOrderRules.Create(vDatasetMaster: TIBDataSet;vDatasetItens:TIBDataset);
begin
  self.datasetMaster:=vDatasetMaster;
  self.datatsetItens:=vDatasetItens;
end;
constructor TSalesOrderRules.Create(vQuery: TIBQuery);
begin
  self.query:=vQuery;
end;

function TSalesOrderRules.Delete:boolean;
begin
  dm1.ExecSQL('delete from salesOrder where number='+query.FieldByName('number').AsString);
  msg:='Pedido de venda excluído com sucesso.';
  result:=true;
end;

function TSalesOrderRules.ValidPost:boolean;
begin
    msg:='';
    result:=true;
    if datasetMaster.FieldByName('emissiondate').IsNull then begin
      msg:='Preencha a data de emissão do pedido de venda.';
      result:=false;
      exit;
    end;
    if datasetMaster.FieldByName('customerid').IsNull then begin
      msg:='Preencha o nome do cliente.';
      result:=false;
      exit;
    end;

   if self.datasetMaster.FieldByName('number').IsNull then
      self.datasetMaster.FieldByName('number').Value :=dm1.GetID('salesorder.number');
   SetItensForeignKey;
end;

function TSalesOrderRules.ValidPostItem:boolean;
begin
    msg:='';
    result:=true;
    if datatsetItens.FieldByName('productid').IsNull then begin
      msg:='Preencha a descrição do ítem.';
      result:=false;
      exit;
    end;
    if datatsetItens.FieldByName('quantity').IsNull then begin
      msg:='Preencha a quantidade do ítem.';
      result:=false;
      exit;
    end;

   if datatsetItens.FieldByName('id').IsNull then
      datatsetItens.FieldByName('id').Value :=dm1.GetID('salesorderitens.id');
   if datatsetItens.FieldByName('salesordernumber').IsNull then
      datatsetItens.FieldByName('salesordernumber').Value :=datasetMaster.FieldByName('number').Value;
end;

Function TSalesOrderRules.GetItemUnitPrice:double;
var q:tibquery;
begin
  q:=tibquery.Create(nil);
  q.Database:=dm1.db1;
  q.SQL.Add('select products.price from products ');
  q.SQL.Add('where products.id=:id');
  q.Params[0].Value:=datatsetItens.FieldByName('productid').Value;
  q.Open;
  result:=q.Fields[0].Value;
  q.Free;
end;

procedure TSalesOrderRules.OnChangeProductID;
begin
  //set unitPrice of new item
  if datatsetItens.FieldByName('productid').NewValue <>
    datatsetItens.FieldByName('productid').OldValue then
    datatsetItens.FieldByName('unitprice').Value:=GetItemUnitPrice;
end;


procedure TSalesOrderRules.SetItensForeignKey;
begin
  datatsetItens.First;
  while not datatsetItens.Eof do begin
    if datatsetItens.FieldByName('salesordernumber').IsNull then begin
      datatsetItens.Edit;
      datatsetItens.FieldByName('salesordernumber').Value:=datasetMaster.FieldByName('number').Value;
    end;
    datatsetItens.Next;  
  end;
end;

destructor TSalesOrderRules.Destroy;
begin
  inherited;
end;


end.
