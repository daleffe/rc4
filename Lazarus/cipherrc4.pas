unit CipherRC4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, UnicodeHelper;

type
  RC4 = class
      protected
      private
      public
        class function Encrypt(Key, Text: String): String;
        class function Decrypt(Key, Text: String): String;
  end;

implementation

class function RC4.Encrypt(Key, Text: String): String;
var
  i,j,x,y: Integer;
  s: array[0..255] of Integer;

  unicodeKey: UnicodeString;
  unicodeText: UnicodeString;

  charCodeAt: Integer;

  ct: String;
  ctInt: Integer;
begin
  for i := 0 to 255 do
  begin
    s[i] := i;
  end;

  unicodeKey := UnicodeString(Key);

  j := 0;

  for i := 0 to 255 do
  begin
    charCodeAt := unicodeKey.charCodeAt(i MOD Length(Key));

    j := (j + s[i] + charCodeAt) MOD 256;
    x := s[i];
    s[i] := s[j];
    s[j] := x;
  end;

  // Reset variables
  i := 0;
  j := 0;

  unicodeText := UnicodeString(Text);

  ct := '';

  for y:= 0 to (Length(Text) - 1) do
  begin
    i := (i + 1) MOD 256;
    j := (j + s[i]) MOD 256;
    x := s[i];

    s[i] := s[j];
    s[j] := x;

    ctInt := unicodeText.charCodeAt(y) xor (s[((s[i] + s[j]) MOD 256)]);

    ct := concat(ct, IntToHex(ctInt, 2));
  end;

  Result := UpperCase(ct);
end;

class function RC4.Decrypt(Key, Text: String): String;
var
   c,i,j,x,y: Integer;
   s: array[0..255] of Integer;

   unicodeKey: UnicodeString;

   copyText: String;

   charCodeAt: Integer;
   fromCharCode: WideChar;

   ct: String;
begin
  for i := 0 to 255 do
  begin
    s[i] := i;
  end;

  j := 0;

  unicodeKey := UnicodeString(Key);

  for i := 0 to 255 do
  begin
    charCodeAt := unicodeKey.charCodeAt(i MOD Length(Key));

    j := (j + s[i] + charCodeAt) MOD 256;
    x := s[i];
    s[i] := s[j];
    s[j] := x;
  end;

  // Reset variables
  i := 0;
  j := 0;

  ct := '';

  if (0 = (Length(Text) and 1)) and (Length(Text) > 0) then
  begin
    c := 0;
    y := 0;

    while y < (Length(Text)) do
    begin
      i := (i + 1) MOD 256;
      j := (j + s[i]) MOD 256;
      x := s[i];

      s[i] := s[j];
      s[j] := x;

      copyText := Copy(Text,c,2);

      charCodeAt := Hex2Dec(copyText) xor (s[((s[i] + s[j]) MOD 256)]);
      fromCharCode := WideChar(charCodeAt);

      ct := concat(ct, String(fromCharCode));

      // Increasing loop counter
      y := y + 2;
      // Increasing copy counter
      c := y + 1;
    end;
  end;

  Result := ct;
end;

end.
