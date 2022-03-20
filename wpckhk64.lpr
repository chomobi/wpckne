{
wpckhk64
Copyright © 2018-2022 terqüéz <gz0@ro.ru>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}
{$mode objfpc}
{$H+}
{$codepage utf8}

library wpckhk64;

{$R *.res}

uses
Windows, SysUtils, CommonCT;

var
mf_handle: HANDLE;
p_global_dll_data: PGlobalDLLData;

function hook_function (p1: longint; p2: WPARAM; p3: LPARAM): LRESULT; stdcall;
var
p_msg: PMSG;
begin
	if p1 < 0 then exit(CallNextHookEx(0, p1, p2, p3));
	p_msg := PMSG(p3);
	if loword(p_msg^.message) = WM_CHAR then
	begin
		case p_global_dll_data^.encoding of
			cp1252a:
				case p_msg^.wParam of
					$0410..$044f: p_msg^.wParam := p_msg^.wParam - $0350;
					$0451: p_msg^.wParam := $b8;
					$0401: p_msg^.wParam := $a8;
				end;
			cp1252b:
				case p_msg^.wParam of
					$0410: p_msg^.wParam := $41;
					$0430: p_msg^.wParam := $61;
					$0411: p_msg^.wParam := $80;
					$0431: p_msg^.wParam := $a0;
					$0412: p_msg^.wParam := $42;
					$0432: p_msg^.wParam := $a2;
					$0413: p_msg^.wParam := $82;
					$0433: p_msg^.wParam := $a5;
					$0414: p_msg^.wParam := $83;
					$0434: p_msg^.wParam := $a6;
					$0415: p_msg^.wParam := $45;
					$0435: p_msg^.wParam := $65;
					$0401: p_msg^.wParam := $cb;
					$0451: p_msg^.wParam := $eb;
					$0416: p_msg^.wParam := $84;
					$0436: p_msg^.wParam := $a8;
					$0417: p_msg^.wParam := $85;
					$0437: p_msg^.wParam := $a9;
					$0418: p_msg^.wParam := $86;
					$0438: p_msg^.wParam := $aa;
					$0419: p_msg^.wParam := $87;
					$0439: p_msg^.wParam := $ab;
					$041A: p_msg^.wParam := $4b;
					$043A: p_msg^.wParam := $ac;
					$041B: p_msg^.wParam := $88;
					$043B: p_msg^.wParam := $ae;
					$041C: p_msg^.wParam := $4d;
					$043C: p_msg^.wParam := $af;
					$041D: p_msg^.wParam := $48;
					$043D: p_msg^.wParam := $b0;
					$041E: p_msg^.wParam := $4f;
					$043E: p_msg^.wParam := $6f;
					$041F: p_msg^.wParam := $89;
					$043F: p_msg^.wParam := $b1;
					$0420: p_msg^.wParam := $50;
					$0440: p_msg^.wParam := $70;
					$0421: p_msg^.wParam := $43;
					$0441: p_msg^.wParam := $63;
					$0422: p_msg^.wParam := $54;
					$0442: p_msg^.wParam := $b2;
					$0423: p_msg^.wParam := $8b;
					$0443: p_msg^.wParam := $b3;
					$0424: p_msg^.wParam := $91;
					$0444: p_msg^.wParam := $b4;
					$0425: p_msg^.wParam := $58;
					$0445: p_msg^.wParam := $78;
					$0426: p_msg^.wParam := $92;
					$0446: p_msg^.wParam := $b5;
					$0427: p_msg^.wParam := $93;
					$0447: p_msg^.wParam := $b6;
					$0428: p_msg^.wParam := $94;
					$0448: p_msg^.wParam := $b7;
					$0429: p_msg^.wParam := $95;
					$0449: p_msg^.wParam := $b8;
					$042A: p_msg^.wParam := $96;
					$044A: p_msg^.wParam := $b9;
					$042B: p_msg^.wParam := $97;
					$044B: p_msg^.wParam := $ba;
					$042C: p_msg^.wParam := $98;
					$044C: p_msg^.wParam := $bb;
					$042D: p_msg^.wParam := $99;
					$044D: p_msg^.wParam := $bc;
					$042E: p_msg^.wParam := $9b;
					$044E: p_msg^.wParam := $be;
					$042F: p_msg^.wParam := $d7;
					$044F: p_msg^.wParam := $f7;
				end;
			cp1252c:
				case p_msg^.wParam of
					$0410: p_msg^.wParam := $41;
					$0430: p_msg^.wParam := $61;
					$0411: p_msg^.wParam := $5e;
					$0431: p_msg^.wParam := $a0;
					$0412: p_msg^.wParam := $42;
					$0432: p_msg^.wParam := $a2;
					$0413: p_msg^.wParam := $82;
					$0433: p_msg^.wParam := $a5;
					$0414: p_msg^.wParam := $83;
					$0434: p_msg^.wParam := $a6;
					$0415: p_msg^.wParam := $45;
					$0435: p_msg^.wParam := $65;
					$0401: p_msg^.wParam := $cb;
					$0451: p_msg^.wParam := $eb;
					$0416: p_msg^.wParam := $84;
					$0436: p_msg^.wParam := $a8;
					$0417: p_msg^.wParam := $85;
					$0437: p_msg^.wParam := $a9;
					$0418: p_msg^.wParam := $86;
					$0438: p_msg^.wParam := $aa;
					$0419: p_msg^.wParam := $87;
					$0439: p_msg^.wParam := $ab;
					$041A: p_msg^.wParam := $4b;
					$043A: p_msg^.wParam := $ac;
					$041B: p_msg^.wParam := $88;
					$043B: p_msg^.wParam := $ae;
					$041C: p_msg^.wParam := $4d;
					$043C: p_msg^.wParam := $af;
					$041D: p_msg^.wParam := $48;
					$043D: p_msg^.wParam := $b0;
					$041E: p_msg^.wParam := $4f;
					$043E: p_msg^.wParam := $6f;
					$041F: p_msg^.wParam := $89;
					$043F: p_msg^.wParam := $b1;
					$0420: p_msg^.wParam := $50;
					$0440: p_msg^.wParam := $70;
					$0421: p_msg^.wParam := $43;
					$0441: p_msg^.wParam := $63;
					$0422: p_msg^.wParam := $54;
					$0442: p_msg^.wParam := $b2;
					$0423: p_msg^.wParam := $8b;
					$0443: p_msg^.wParam := $b3;
					$0424: p_msg^.wParam := $91;
					$0444: p_msg^.wParam := $b4;
					$0425: p_msg^.wParam := $58;
					$0445: p_msg^.wParam := $78;
					$0426: p_msg^.wParam := $92;
					$0446: p_msg^.wParam := $b5;
					$0427: p_msg^.wParam := $93;
					$0447: p_msg^.wParam := $b6;
					$0428: p_msg^.wParam := $94;
					$0448: p_msg^.wParam := $b7;
					$0429: p_msg^.wParam := $95;
					$0449: p_msg^.wParam := $b8;
					$042A: p_msg^.wParam := $96;
					$044A: p_msg^.wParam := $b9;
					$042B: p_msg^.wParam := $97;
					$044B: p_msg^.wParam := $ba;
					$042C: p_msg^.wParam := $98;
					$044C: p_msg^.wParam := $bb;
					$042D: p_msg^.wParam := $99;
					$044D: p_msg^.wParam := $bc;
					$042E: p_msg^.wParam := $9b;
					$044E: p_msg^.wParam := $be;
					$042F: p_msg^.wParam := $d7;
					$044F: p_msg^.wParam := $f7;
				end;
			else
				MessageBoxExW(0, PWideChar(UnicodeString('wpckhk64: Неправильная настройка.')), nil, MB_OK or MB_ICONERROR, 0);
		end;
	end;
	exit(CallNextHookEx(0, p1, p2, p3));
	hook_function := 0;
end;
exports
	hook_function;

initialization
begin
	mf_handle := OpenFileMappingW(FILE_MAP_READ, False, PWideChar(UnicodeString(mf_name)));
	if mf_handle = 0 then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('wpckhk64: Не удалось открыть объект файлового отображения. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		halt;
	end;
	p_global_dll_data := MapViewOfFile(mf_handle, FILE_MAP_READ, 0, 0, SizeOf(TGlobalDLLData));
	if p_global_dll_data = nil then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('wpckhk64: Не удалось отобразить файловый объект. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		halt;
	end;
end;

finalization
begin
	UnmapViewOfFile(p_global_dll_data);
	CloseHandle(mf_handle);
end;

end.

