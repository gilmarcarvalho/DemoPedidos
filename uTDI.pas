unit uTDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ComCtrls, ToolWin;

function IsOpenForm(ClasseForm: TFormClass;  var TabSheet: TTabSheet;PageControl:TPageControl): Boolean;
procedure NewTabForm(ClasseForm: TFormClass;PageControl:TPagecontrol;Sender:TComponent);
procedure CloseTabForm(Aba: TTabSheet;PageControl:TPageControl);
procedure PageControlChange(PageControl:TpageControl);

implementation

function IsOpenForm(ClasseForm: TFormClass;  var TabSheet: TTabSheet;PageControl:TPageControl): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to PageControl.PageCount - 1 do
    if PageControl.Pages[I].Components[0].ClassType = ClasseForm then
    begin
      TabSheet := PageControl.Pages[I];
      Result:=False;
      Break;
    end;
end;

procedure NewTabForm(ClasseForm: TFormClass;PageControl:TPagecontrol;Sender:TComponent);
var
  TabSheet: TTabSheet;
  Form: TForm;
begin
  if not IsOpenForm(ClasseForm, TabSheet,PageControl) then
  begin
    PageControl.ActivePage := TabSheet;
    Exit;
  end;
  TabSheet := TTabSheet.Create(Sender);
  TabSheet.PageControl := PageControl;
  pagecontrol.Visible:= pagecontrol.PageCount >0;
  Form := ClasseForm.Create(TabSheet);
  with Form do
  begin
    Align       := alClient;
    BorderStyle := bsNone;
    Parent      := TabSheet;
  end;

  with TabSheet do
  begin
    Caption     := Form.Caption;
  end;
  Form.Show;
  PageControl.ActivePage := TabSheet;
  PageControlChange(PageControl);
  form.Realign;

end;

procedure CloseTabForm(Aba: TTabSheet;PageControl:TPageControl);
var
  Form: TForm;
  AbaEsquerda: TTabSheet;
begin
  AbaEsquerda := nil;
  Form := Aba.Components[0] as TForm;
  if Form.CloseQuery then
  begin
    if Aba.TabIndex > 0 then
      AbaEsquerda := PageControl.Pages[Aba.TabIndex - 1]
      else
      AbaEsquerda:=PageControl.Pages[0];
    Form.Close;
    Aba.Free;
    PageControl.ActivePage := AbaEsquerda;
  end;
   pagecontrol.Visible:= pagecontrol.PageCount >0;
end;

procedure PageControlChange(PageControl:TpageControl);
begin
 // PageControl.Caption := PageControl.ActivePage.Caption;
  with (PageControl.ActivePage.Components[0] as TForm) do
    if not Assigned(Parent) then Show;
end;



end.
