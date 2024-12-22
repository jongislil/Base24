# Base24
A base24 implementation for Delphi. It encodes binary data to human-readable text and reduces human-made errors when transmitting verbally.

This is based on the format introduced in this blogpost: https://www.kuon.ch/post/2020-02-27-base24/


## Usage
```delphi
var
 bytes: TBytes;
 EncodedData: String;
begin
 bytes := TBytes.Create(1, 2, 3, 4);
 EncodedData := Base24Encoding.Encode(bytes);

 Writeln('Encoded data: ' + EncodedData);

 bytes := Base24Encoding.Decode(EncodedData);
end;
```
