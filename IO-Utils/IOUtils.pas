// testlib1       Adds or subtracts one to/from an integer
//
// Purpose:       Provide cross-platform IO Library for Red/System
//
// Author:        Peter W A Wood
//
// Date:          22-Sep-2011
//
// Version:       0.0.3
//
// Rights:        Copyright (C) 2011 Peter W A Wood.
//                All rights reserved.
//
// License:       BSD-3
//                https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt
//
// Notes:         Under Mac Xcode < 4.0 the library must be compiled with the 
//                  following option:
//                  -k-no_order_inits
//                (This is due to a bug in the Xcode 3 linker)

library IOUtils;

uses Strings;

function readlnstdin(len: integer; str: pchar): integer;cdecl;
var
  s:                    ANSIString;
begin
  readln(s);
  s := copy(s, 1, len);
      strpcopy(str, s);
  if eof then
    begin
      readlnstdin := 0;
    end
  else
    begin
      readlnstdin := 1;
    end;      
end;

{$ifndef Darwin}
exports  
  readlnstdin name 'readlnstdin';
{$else}
exports
  readlnstdin name '_readlnstdin';
{$endif}

begin
end.