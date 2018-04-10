# RC4
RC4 cipher to Hex for Delphi / Lazarus (Pascal).

## How to use
* Delphi

Import the **cipherrc4.pas** file into the same folder as your project.
* Lazarus

Import the **cipherrc4.pas** and **unicodehelper.pas** files into the same folder as your project. 

Later, in the session *uses* declare:
```pascal
uses
  CipherRC4
```

## Example
We created a form with some *Memo*, *Label* and *Edit* components for demonstration, and implemented actions in button click (you can adapt according to your project):
```pascal
procedure TForm1.Button1Click(Sender: TObject);
var
  ResultMd5: String;
  ResultRc4: String;
  Rc4Key: String;

  ValEncrypted: String;
  ValDecrypted: String;
begin
  // Edit1 has value that will be converted using some MD5 function. In our code, ResultMd5 has that value.
  if (Edit1.Text <> '') and (Edit2.Text <> '') then
  begin
    // Encryption Key
    ResultMd5 := 'de720e4e2f21470cb416785b6c2dc1be';

    Rc4Key := UpperCase(ResultMd5);

    ResultRc4 := RC4.Encrypt(Rc4Key,String(Edit2.Text));

    Memo1.Lines.Add('MD5: ' + ResultMd5);
    Memo1.Lines.Add('RC4 Encrypted: ' + ResultRc4);
    Memo1.Lines.Add('RC4 Decrypted: ' + RC4.Decrypt(Rc4Key,ResultRc4));

    ValEncrypted := RC4.Encrypt(Rc4Key,Edit3.Text);
    ValDecrypted := RC4.Decrypt(Rc4Key,ValEncrypted);

    Memo2.Lines.Add(ValEncrypted);
    Memo3.Lines.Add(ValDecrypted);
  end;
end;
```
