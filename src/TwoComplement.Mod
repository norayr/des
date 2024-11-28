MODULE TwoComplement;

IMPORT Out, S := SYSTEM;

CONST
  MaxPositive = 2147483647;  (* Maximum signed 32-bit integer *)
  Mask32 = 0FFFFFFFFH;       (* Mask for the lower 32 bits *)

PROCEDURE ToSigned*(value: LONGINT): LONGINT;
VAR
  Modulo: LONGINT;
BEGIN
  Modulo := S.LSH(1, 32);  (* Compute 2^32 dynamically *)
  IF value > MaxPositive THEN
    RETURN value - Modulo
  ELSE
    RETURN value
  END
END ToSigned;

PROCEDURE FromHugeIntToSigned*(value: HUGEINT): LONGINT;
VAR
  HighPart, LowPart: LONGINT;
BEGIN
  (* Extract the low 32 bits *)
  LowPart := S.VAL(LONGINT, value MOD S.LSH(1, 32));  (* Correctly get the lower 32 bits *)

  (* Extract the high 32 bits *)
  HighPart := S.VAL(LONGINT, value DIV S.LSH(1, 32));  (* Use DIV to get the upper 32 bits *)

  (* Combine high and low parts into a single LONGINT *)
  RETURN ToSigned(S.LSH(HighPart, 32) + LowPart);
END FromHugeIntToSigned;

BEGIN
  (* Example usage *)
  Out.Int(ToSigned(S.VAL(LONGINT, S.LSH(0AAAAH, 16) + 0AAAAH)), 0);  (* Construct 0AAAAAAAAH dynamically *)
  (*  Should print −1431655766 *)
  Out.Ln;

Out.Int(FromHugeIntToSigned(S.VAL(HUGEINT, 0AAAAAAAAH)), 0);  (* Should print −1431655766 *)
  Out.Ln
END TwoComplement.




(*

The two’s complement signed interpretation for a 32-bit value xx is defined as:

    If x < 2^31, it is interpreted as a positive integer.
    If x ≥ 2^31, it is interpreted as:
    SignedValue = x − 2^32

    2^32 is 4294967296

    it is 1 00000000 00000000 00000000 00000000

    while 2^32 − 1 is
          11111111 11111111 11111111 11111111

For 0AAAAAAAAH:

    0AAAAAAAAH is 2863311530 in decimal
    Determine if it's negative:
        2863311530 is ≥ 2^31 (which is 2147483648), so it's negative.
    Compute the signed value:
    2863311530 − 4294967296 = −1431655766


*)


(* Other note

  2^8 represents the smallest number that requires 9 bits to represent in binary.
  For an 8-bit number, the range of representable values is:

    Unsigned: 0 to 2^8 −1 (0 to 255).
    Signed (Two's Complement): −2^7 − 2^7 (−128 to 127).


*)
