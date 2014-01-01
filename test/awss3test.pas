{
    AWS
    Copyright (C) 2013  -  Marcos Douglas B. dos Santos

    See the files COPYING.GH, included in this
    distribution, for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

unit AWSS3Test;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry,
  AWSS3;

type
  TAWSS3Test = class(TTestCase)
  protected
    FS3: TAWSS3Client;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestHEADBucket;
    procedure TestGETService;
    procedure TestGETBucket_ListObjects;
    procedure TestGETBucket_acl;
    procedure TestGETBucket_cors;
    procedure TestGETBucket_lifecycle;
    procedure TestGETBucket_policy;
    procedure TestGETBucket_location;
    procedure TestGETBucket_logging;
    procedure TestGETBucket_notification;
    procedure TestGETBucket_tagging;
    procedure TestGETBucket_versions;
    procedure TestGETBucket_requestPayment;
    procedure TestGETBucket_versioning;
    procedure TestGETBucket_website;

    procedure TesPUTObject;
  end;

implementation

uses IniFiles;

procedure TAWSS3Test.SetUp;
const
  KEY_FILE = 'key.ini';
var
  Ini: TIniFile;
begin
  if not FileExists(KEY_FILE) then
    raise Exception.CreateFmt('File %s not exists', [KEY_FILE]);

  FS3 := TAWSS3Client.Create;
  Ini := TIniFile.Create(KEY_FILE);
  try
    FS3.UseSSL := True;
    FS3.AccessKeyId := Ini.ReadString('AWS', 'AccessKeyId', '');
    FS3.SecretKey := Ini.ReadString('AWS', 'SecretKey', '');
  finally
    Ini.Free;
  end;
end;

procedure TAWSS3Test.TearDown;
begin
  FS3.Free;
end;

procedure TAWSS3Test.TestHEADBucket;
begin
  CheckTrue(FS3.HEADBucket('integra001'));
end;

procedure TAWSS3Test.TestGETService;
begin
  CheckEquals(200, FS3.GETService);
end;

procedure TAWSS3Test.TestGETBucket_ListObjects;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/'));
end;

procedure TAWSS3Test.TestGETBucket_acl;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?acl'));
end;

procedure TAWSS3Test.TestGETBucket_cors;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?cors'));
end;

procedure TAWSS3Test.TestGETBucket_lifecycle;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?lifecycle'));
end;

procedure TAWSS3Test.TestGETBucket_policy;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?policy'));
end;

procedure TAWSS3Test.TestGETBucket_location;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?location'));
end;

procedure TAWSS3Test.TestGETBucket_logging;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?logging'));
end;

procedure TAWSS3Test.TestGETBucket_notification;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?notification'));
end;

procedure TAWSS3Test.TestGETBucket_tagging;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?tagging'));
end;

procedure TAWSS3Test.TestGETBucket_versions;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?versions'));
end;

procedure TAWSS3Test.TestGETBucket_requestPayment;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?requestPayment'));
end;

procedure TAWSS3Test.TestGETBucket_versioning;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?versioning'));
end;

procedure TAWSS3Test.TestGETBucket_website;
begin
  CheckEquals(200, FS3.GETBucket('integra001', '/?website'));
end;

procedure TAWSS3Test.TesPUTObject;
begin
  CheckEquals(200, FS3.PUTObject('integra001', 'text/plan', 'test.txt', 'test.txt'));
end;

initialization
  RegisterTest(TAWSS3Test);

end.
