//***********************************************//
//*Summary: business rules of user register******//
//*Date revision:28/09/2018 (pt-br)**************//
//*Version number: 1.0***************************//
//*Created by: Gilmar Carvalho*******************//
//***********************************************//

unit uProductRules;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
   Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons, cxGraphics,FireDAC.Comp.DataSet   ,
    FireDAC.Comp.Client, data.DB;

type
  TProductRules = class
    query:TFDQuery;
    msg: string;
    Function ValidPost:boolean ;
    Function Delete:boolean;
    constructor Create(vQuery:TFDQuery);overload;
    destructor Destroy;override;
    private
      function DuplicatedName:boolean;
      function CountOrderSales(productID:int64):integer;

  end;

implementation

uses uDM1, uGlobalFuncs;

constructor TProductRules.Create(vQuery: TFDQuery);
begin
  self.query:=vQuery;
end;

function tProductRules.Delete:boolean;
var SalesOrders:integer;
begin
  msg:='';
  //busca ped. vendas deste produto
  SalesOrders:=CountOrderSales(query.FieldByName('id').Value);
  if SalesOrders > 0 then begin
    msg:='Não é possível excluir este produto porque'+
        'existem pedidos de venda com este produto ';
    result:=false;
  end
  else
  begin
      dm1.ExecSQL('delete from products where ID='+query.FieldByName('id').AsString);
      msg:='Produto excluído com sucesso.';
      result:=true;
  end;
end;

function tProductRules.ValidPost:boolean;
begin
    msg:='';
    result:=true;
    if trim(query.FieldByName('description').AsString)='' then begin
      msg:='Preencha a descrição do produto.';
      result:=false;
      exit;
    end;

    if DuplicatedName then begin
      msg:='Já existe um produto com esta descrição. Verifique e tente uma outra descrição.';
      result:=false;
      exit;
    end;
   if self.query.FieldByName('id').IsNull then
    self.query.FieldByName('id').Value :=dm1.GetID('products.id');
end;

destructor TProductRules.Destroy;
begin
  inherited;
end;

function TProductRules.DuplicatedName:boolean;
var q:TFDQuery;id:int64;description:string;
begin
  id:= ToInteger(self.query.FieldByName('id').Value);
  description:=self.query.FieldByName('description').AsString;
  q := TFDQuery.Create(nil);
  q.Connection:= dm1.db1;
  q.SQL.Add('select count(products.id) from products where');
  q.SQL.Add(' upper(products.description)=upper(:ds)');
  q.SQL.Add(' and products.ID <>:id ');
  q.ParamByName('ds').Value:=description;
  q.ParamByName('id').Value:=id;
  q.Open;
  result:=q.Fields[0].Value >0;
  q.Free;

end;

function TProductRules.CountOrderSales(productID:int64):integer;
var q:tibquery; r:integer;
begin
 q:=tibquery.create(nil);
 q.database:=dm1.db1;
 q.sql.add('select count(salesorderitens.id) from ');
 q.sql.add('salesorderitens where salesorderitens.productid=:p');
 q.params[0].value:=productID;
 q.open;
 r:=q.fields[0].value;
 q.free;
 result:=r;
 end;




end.
