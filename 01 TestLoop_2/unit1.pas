unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, DateUtils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    Run_:Boolean;
    Speed_frame:Extended;
    procedure Main_Loop();
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Main_Loop();
//Use Case 1 disable case 2; design for running one program only
//Use Case 2 disable case 2; design for Share CUP to other program

//Case 1 at 50F/S Maximum: 21000000 line/Sec;  Minimum: 17000000 Line/Sec;  400000 Line/Frame
//Case 2 at 50F/S Maximum: 700000 line/Sec;  Minimum: 500000 Line/Sec;  13000 Line/Frame

//const
//IO : array[0..1] of char = ('0','1');
var
  Frame_, Line_ :integer;
  LoopSec,StartLoopSec,EndLoopSec : TDateTime;
  i,ProcessWait:integer;
  IsOneSec:Boolean;
  S1:String;


begin
  if Not Run_ then
  begin
    Run_:=True;
    Frame_:=0;
    Line_:=0;
    i:=0;
    IsOneSec:=False;
    ProcessWait:=1;

    StartLoopSec:=Now;
    EndLoopSec:=Now;
    LoopSec:=Now;

    while Run_ do
    begin
      //application.ProcessMessages; //Work one program only   Case 1.

      //Run your program here
      //.
      //.
      //.

      //Any text information here
      //.
      //.

      //Render here
      //.
      //.
      //.

      //Clear your hardware here
      //.
      //.

      EndLoopSec:=Now;
      if ((MilliSecondsBetween(StartLoopSec,EndLoopSec) >= Speed_frame) and (Run_)) then
      begin

        //Manage your timer here
        S1:=FloatToStr(MilliSecondsBetween(StartLoopSec,EndLoopSec)) + ' ms/Frame';
        StartLoopSec:=Now;
        if MilliSecondsBetween(LoopSec,EndLoopSec) >=1000 then
        begin
          IsOneSec:=True;
          StartLoopSec:=Now;
          EndLoopSec:=Now;
          LoopSec:=Now;
        end;

        //If your hardware active then code hear
        //.
        //.

        //Moving object code hear
        Frame_:=Frame_+1;

        //Run_:=not Run_; //For run only 1 cycle
      end;

       //Detect your hardware here
      //.
      //.

      //Clear something and do some other status here
      Line_:=Line_+1;
      if IsOneSec then
      begin
        S1:=S1+Chr(13) + IntToStr(Frame_) + ' Frame/Sec' + Chr(13);
        S1:=S1 + IntToStr(Line_) + ' Line left over';
        Label1.Caption:=S1;
        Frame_:=0;
        Line_:=0;
        IsOneSec:=False;
      end;

      for i:=1 to ProcessWait do
        application.ProcessMessages; //Share CUP  Case 2

    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Speed_frame:=20;  //50 frqme per second
  Run_:=False;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Main_Loop();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Speed_frame:=20;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Speed_frame:=29;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Run_:=False;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Speed_frame:=13;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Speed_frame:=100;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Run_:=False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin

end;

end.

