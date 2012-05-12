// i64          Simple i64 Arithmetic
//
// Purpose:     A Temporary I64 library for Red/System
//
// Author:      Peter W A Wood
//
// Date:        4th May 2012
//
// Version:     0.0.1
//
// Rights:      Copyright (C) 2012 Peter W A Wood'
//
// License:     BSD-3


library i64;

procedure subtract(var i: Int64; var j: Int64; var k: Int64); cdecl;
begin
  k := i - j;
end;

procedure divide  (var i: Int64; var j: Int64; var k: Int64); cdecl;
begin
  k := i div j;
end;

{$ifndef Darwin}
exports
  subtract name 'subtract',
  divide name 'divide';
{$else}
exports
  subtract name '_subtract',
  divide name '_divide';
{$endif}

end.
