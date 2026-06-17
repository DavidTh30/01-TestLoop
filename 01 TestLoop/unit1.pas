unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, EpikTimer;

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
    timer_: TEpikTimer;
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
  Timer_before:Extended;
  i,ProcessWait:integer;
  IsOneSec:Boolean;
  S1:String;

begin
  if Not Run_ then
  begin
    Run_:=True;
    Timer_before:=0;
    Frame_:=0;
    Line_:=0;
    timer_.Clear;
    timer_.Start;
    i:=0;
    IsOneSec:=False;
    ProcessWait:=1;

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

      if ((timer_.Elapsed -Timer_before >= Speed_frame) and (Run_)) then
      //(timer_.Elapsed < 1) and (Run_)) do //and (timer_.Elapsed < 1) do
      begin

        //Manage your timer here
        S1:=FloatToStr((timer_.Elapsed -Timer_before)*1000) + ' ms/Frame';
        Timer_before:=timer_.Elapsed;
        if timer_.Elapsed >= 1 then
        begin
          IsOneSec:=True;
          timer_.Stop;
          Timer_before:=0;
          timer_.Clear;
          timer_.Start;
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

    If not Run_ then  timer_.Stop;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Speed_frame:=0.02;  //50 frqme per second
  timer_ := TEpikTimer.Create(nil);
  Run_:=False;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Main_Loop();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Speed_frame:=0.02;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Speed_frame:=0.029;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Run_:=False;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Speed_frame:=0.0134;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Speed_frame:=0.1;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Run_:=False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  timer_.Free;
end;

end.

