unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Spin,
  MaskEdit, StdCtrls, math;

type
  TPrefix = record
    name : String;
    factor: real;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    ResultLabel: TLabel;
    PowerUnitBox: TComboBox;
    TimeUnitBox: TComboBox;
    PowerEdit: TFloatSpinEdit;
    TimeEdit: TFloatSpinEdit;
    PriceEdit: TFloatSpinEdit;
    procedure ReCalculate(Sender: TObject);
  private
    function CalcEnergy(Power: real; Time : real): real;
    function CalcPrice(Power: real; Time: real): real;
    function EnergyToText(Energy:real):String;
    function RealtoText(v:real):String;
    function RealtoText(v:real;u:string):String;
  public

  end;

var
  Form1: TForm1;
const
  Prefixes : array[0..16] of TPrefix =
    (
       (name : 'y'; factor: 1e-24 ),
       (name : 'z'; factor: 1e-21 ),
       (name : 'a'; factor: 1e-18 ),
       (name : 'f'; factor: 1e-15 ),
       (name : 'p'; factor: 1e-12 ),
       (name : 'n'; factor: 1e-9  ),
       (name : 'µ'; factor: 1e-6  ),
       (name : 'm'; factor: 1e-3  ),
       (name : '' ; factor: 1     ),
       (name : 'k'; factor: 1e3   ),
       (name : 'M'; factor: 1e6   ),
       (name : 'G'; factor: 1e9   ),
       (name : 'T'; factor: 1e12  ),
       (name : 'P'; factor: 1e15  ),
       (name : 'E'; factor: 1e18  ),
       (name : 'Z'; factor: 1e21  ),
       (name : 'Y'; factor: 1e24  )
       );

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ReCalculate(Sender: TObject);
var Energy, Price : real;
begin
  Energy := CalcEnergy(PowerEdit.Value,TimeEdit.Value);
  Price := CalcPrice(Energy,PriceEdit.Value);
  ResultLabel.Caption:= 'Es werden ' + EnergyToText(Energy)
                        + ' verbraucht und das kostet ' + RealToText(Price,'€');
end;

function TForm1.CalcEnergy(Power: real; Time: real): real;
begin
  result := Power * Time;
end;

function TForm1.CalcPrice(Power: real; Time: real): real;
begin
  result := Power * Time;
end;

function TForm1.EnergyToText(Energy: real): String;
begin
  result := RealtoText(Energy,'Wh');
end;

function TForm1.RealtoText(v: real): String;
begin
 result := RealtoText(v,'');
end;

function TForm1.RealtoText(v: real; u: string): String;
var p: String; iP : integer = 0;
begin

 p := Prefixes[iP].name;
 while((v > Prefixes[iP+1].factor) and (iP < length(Prefixes)-1)) do
        Inc(iP);

 result := FloattoStrF((v / Prefixes[iP].factor),ffFixed,8,2) + ' ' + Prefixes[iP].name + u;

end;

end.

