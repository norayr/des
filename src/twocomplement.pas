program TwoComplement;

const
  MaxPositive = 2147483647;  { Maximum signed 32-bit integer }
  Modulo = 4294967296;       { 2^32 }

function ToSigned(value: LongWord): LongInt;
begin
  if value > MaxPositive then
    ToSigned := value - Modulo
  else
    ToSigned := value;
end;

begin
  { Example usage }
  WriteLn(ToSigned($0AAAAAAAA));  { Should print -1431655766 }
end.

