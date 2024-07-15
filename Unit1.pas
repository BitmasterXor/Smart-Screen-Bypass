unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure AddZoneIdentifier(const FileName: string; ZoneID: Integer);
    procedure RemoveZoneIdentifier(const FileName: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AddZoneIdentifier(const FileName: string; ZoneID: Integer);
var
  ZoneFile: THandle;
  BytesWritten: DWORD;
  ZoneInfo: string;
begin
  ZoneInfo := '[ZoneTransfer]' + sLineBreak + 'ZoneId=' + ZoneID.ToString;
  ZoneFile := CreateFile(PChar(FileName + ':Zone.Identifier'), GENERIC_WRITE, 0, nil, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0);
  if ZoneFile = INVALID_HANDLE_VALUE then
    RaiseLastOSError;
  try
    if not WriteFile(ZoneFile, PChar(ZoneInfo)^, Length(ZoneInfo) * SizeOf(Char), BytesWritten, nil) then
      RaiseLastOSError;
  finally
    CloseHandle(ZoneFile);
  end;
end;

procedure TForm1.RemoveZoneIdentifier(const FileName: string);
var
  ZoneFile: string;
begin
  ZoneFile := FileName + ':Zone.Identifier';
  if not DeleteFile(PChar(ZoneFile)) then
    RaiseLastOSError;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Initialization code if needed
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
  //Do not forget to add the correct path to the file you  wish to remove the zone ID from on the next line of code! Or add in another way of pointing to it!
    RemoveZoneIdentifier('C:\Users\YOUR  USERNAME GOES HERE!\Desktop\yourfile.exe');
    ShowMessage('Zone.Identifier removed successfully.');
  except
    on E: Exception do
      ShowMessage('Failed to remove Zone.Identifier: ' + E.Message);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  try
   //Do not forget to add the correct path to the file you  wish to Add the zone ID to on the next line of code! Or add in another way of pointing to it!
    AddZoneIdentifier('C:\Users\YOUR  USERNAME GOES HERE!\Desktop\yourfile.exe', 3); // 3 = Internet Zone
    ShowMessage('Zone.Identifier added successfully.');
  except
    on E: Exception do
      ShowMessage('Failed to add Zone.Identifier: ' + E.Message);
  end;
end;

end.

