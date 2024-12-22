unit Base24Encoding;

interface

uses
 System.SysUtils, System.Character;

const

 Alphabet = 'ZAC2B3EF4GH5TK67P8RS9WXY';
 AlphabetLength = 24;

resourcestring
  SBase24EncodeDataLenError = 'The data length must be multiple of 7 chars.';
  SBase24UnsupChrError = 'Unsupported character in input: %s';
  SBase24DecodeDataLenError = 'Data length must be a multiple of 4';


 function Encode(const AData : TBytes) : String;
 function Decode(const AData : String) : TBytes;

 // Based on: https://www.kuon.ch/post/2020-02-27-base24/

implementation


function GetIndex(const AChar: Char): UInt32;
var
 i: UInt32;
begin
 Result := UInt32.MaxValue;

 for i := 1 to AlphabetLength do
 begin
  if AChar = Alphabet[i]  then
  begin
   result := i - 1;
   break;
  end;
 end;
end;

function Decode(const AData: String): TBytes;
var
 Len : Integer;
 i, j, l : Integer;
 Idx, Value, mask : UInt32;
begin
 Len := Length(AData);

 if Len = 0 then
  result := nil
 else
 begin

  if (Len mod 7) <> 0 then
   raise Exception.Create(SBase24EncodeDataLenError);

  mask := $FF;

  SetLength(Result, (Len div 7) * 4);

  for i := 0 to (Len div 7) - 1 do
  begin
   j := i * 7;
   Value := 0;

   for l := 1 to 7 do
   begin

    idx := GetIndex(AData[l + j]);

    if idx = UInt32.MaxValue then
    begin
     idx := GetIndex(AData[l + j].ToUpper);

     if idx = UInt32.MaxValue then
      raise Exception.CreateFmt(SBase24UnsupChrError, [AData[l + j]]);
    end;

    Value := AlphabetLength * Value + idx;


   end;

   Result[(i * 4) + 0] := (value and (mask shl 24)) shr 24;
   Result[(i * 4) + 1] := (value and (mask shl 16)) shr 16;
   Result[(i * 4) + 2] := (value and (mask shl 8)) shr 8;
   Result[(i * 4) + 3] := value and mask;

  end;

 end;
end;

function Encode(const AData: TBytes): String;
var
 Len : Integer;
 i, j, l : Integer;
 b0, b1, b2, b3, mask : UInt32;
 Idx, Value : UInt32;
begin
 Len := Length(AData);

 if Len <> 0 then
 begin
  if (Len mod 4) <> 0 then
   raise Exception.Create(SBase24DecodeDataLenError);

  mask := $FF;

  SetLength(Result, (Len div 4) * 7);

  for i := 0 to (Len div 4) - 1 do
  begin
   j := i * 4;

   b3 := AData[j] and mask;
   b2 := AData[j + 1] and mask;
   b1 := AData[j + 2] and mask;
   b0 := AData[j + 3] and mask;

   Value := $FFFFFFFF and ((b3 shl 24) or (b2 shl 16) or (b1 shl 8) or b0);

   for l := 7 downto 1 do
   begin
    Idx := Value mod AlphabetLength;
    Value := Value div AlphabetLength;

    Result[(i * 7) + l] := Alphabet[idx + 1];
   end;

  end;
 end;


end;



end.
