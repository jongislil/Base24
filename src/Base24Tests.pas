unit Base24Tests;

interface

uses
 System.SysUtils, System.Classes, Base24Encoding;

const

 TestArray : Array[1..48, 1..2] of string =
  (
  ('00000000', 'ZZZZZZZ'),
  ('000000000000000000000000', 'ZZZZZZZZZZZZZZZZZZZZZ'),
  ('00000001', 'ZZZZZZA'),
  ('000000010000000100000001', 'ZZZZZZAZZZZZZAZZZZZZA'),
  ('00000010', 'ZZZZZZP'),
  ('00000030', 'ZZZZZCZ'),
  ('88553311', '5YEATXA'),
  ('FFFFFFFF', 'X5GGBH7'),
  ('FFFFFFFFFFFFFFFFFFFFFFFF', 'X5GGBH7X5GGBH7X5GGBH7'),
  ('FFFFFFFFFFFFFFFFFFFFFFFF', 'x5ggbh7x5ggbh7x5ggbh7'),
  ('1234567887654321', 'A64KHWZ5WEPAGG'),
  ('1234567887654321', 'a64khwz5wepagg'),
  ('FF0001FF001101FF01023399', 'XGES63FZZ247C7ZC2ZA6G'),
  ('FF0001FF001101FF01023399', 'xges63fzz247c7zc2za6g'),
  ('25896984125478546598563251452658', '2FC28KTA66WRST4XAHRRCF237S8Z'),
  ('25896984125478546598563251452658', '2fc28kta66wrst4xahrrcf237s8z'),
  ('00000001', 'ZZZZZZA'),
  ('00000002', 'ZZZZZZC'),
  ('00000004', 'ZZZZZZB'),
  ('00000008', 'ZZZZZZ4'),
  ('00000010', 'ZZZZZZP'),
  ('00000020', 'ZZZZZA4'),
  ('00000040', 'ZZZZZCP'),
  ('00000080', 'ZZZZZ34'),
  ('00000100', 'ZZZZZHP'),
  ('00000200', 'ZZZZZW4'),
  ('00000400', 'ZZZZARP'),
  ('00000800', 'ZZZZ2K4'),
  ('00001000', 'ZZZZFCP'),
  ('00002000', 'ZZZZ634'),
  ('00004000', 'ZZZABHP'),
  ('00008000', 'ZZZC4W4'),
  ('00010000', 'ZZZB8RP'),
  ('00020000', 'ZZZG5K4'),
  ('00040000', 'ZZZRYCP'),
  ('00080000', 'ZZAKX34'),
  ('00100000', 'ZZ229HP'),
  ('00200000', 'ZZEFPW4'),
  ('00400000', 'ZZT7GRP'),
  ('00800000', 'ZAAESK4'),
  ('01000000', 'ZCCK7CP'),
  ('02000000', 'ZB32E34'),
  ('04000000', 'Z4HETHP'),
  ('08000000', 'ZP9KZW4'),
  ('10000000', 'AG8CARP'),
  ('20000000', 'CSHB2K4'),
  ('40000000', '3694FCP'),
  ('80000000', '53PP634')
  );




procedure Test;


implementation

procedure TestEncode;
var
 BData : TBytes;
 i: Integer;
 EncData : String;
begin
 Writeln('Testing Encode');

 for i := 1 to High(TestArray) do
 begin
  setlength(BData, length(TestArray[i][1]) div 2);
  HexToBin(pwidechar(TestArray[i][1]), BData, length(BData));

  EncData := Base24Encoding.Encode(BData);

  if EncData <> UpperCase(TestArray[i][2]) then
   Writeln(i.ToString + ': Wrong: ' + EncData + ' -> ' + TestArray[i][2]);

 end;


end;

procedure TestDecode;
var
 BData : TBytes;
 i: Integer;
 HexData : String;
begin
 Writeln('Testing Decode');


 for i := 1 to High(TestArray) do
 begin
  BData := Base24Encoding.Decode(TestArray[i][2]);

  setlength(HexData, Length(BData) * 2);

  BinToHex(BData, PWideChar(HexData), Length(BData));

  if HexData <> UpperCase(TestArray[i][1]) then
   Writeln(i.ToString + ': Wrong: ' + HexData + ' -> ' + TestArray[i][1]);

 end;
end;



procedure Test;
begin
 TestEncode;
 TestDecode;

 Writeln('Test done');
end;



end.
