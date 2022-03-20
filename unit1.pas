{
wpckne
Copyright © 2018-2022 terqüéz <gz0@ro.ru>

This file is part of wpckne.

wpckne is free software: you can redistribute it and/or modify
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
unit Unit1;

interface

uses
Windows, {ShellApi,} Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
ExtCtrls, StdCtrls, CommonCT, LCLIntf;

type

	{ TMainForm }

 TMainForm = class(TForm)
		bGithub: TButton;
		bStrategium: TButton;
		lCopyingNotice: TLabel;
		lEncodingsDescription: TLabel;
		rgEncoding: TRadioGroup;
		rgGames: TRadioGroup;
		tGame: TTimer;
		procedure bGithubClick(Sender: TObject);
		procedure bStrategiumClick(Sender: TObject);
		procedure rgEncodingClick(Sender: TObject);
		procedure rgGamesClick(Sender: TObject);
		procedure tGameTimer(Sender: TObject);
	private

	public

	end;

OEMString = type AnsiString(CP_OEMCP);
ACPString = type AnsiString(CP_ACP);

var
MainForm: TMainForm;

fl_hook: Byte = 0;
game_window: HWND = 0;
game_thread: DWORD = 0;
pdwpi: DWORD = 1;
hook_handle: HHOOK = 0;
hook_library_handle: HINST;
p_hook_function: HOOKPROC;
pf_hook_function: FARPROC;
mf_handle: HANDLE = 0;
p_global_dll_data: PGlobalDLLData;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.tGameTimer(Sender: TObject);
begin
	if (game_window = 0) or IsWindow(game_window) then
	begin
		game_window := 0;
		case rgGames.Items[rgGames.ItemIndex] of
			'Crusader Kings II': game_window := FindWindowExW(0, 0, PWideChar(UnicodeString('SDL_app')), PWideChar(UnicodeString('Crusader Kings II')));
			'Europa Universalis IV': game_window := FindWindowExW(0, 0, PWideChar(UnicodeString('SDL_app')), PWideChar(UnicodeString('Europa Universalis IV')));
		end;
		if (game_window <> 0) and (fl_hook = 0) then
		begin
			fl_hook := 1;
			game_thread := GetWindowThreadProcessId(game_window, pdwpi);
			hook_handle := SetWindowsHookExW(WH_GETMESSAGE, p_hook_function, hook_library_handle, game_thread);
			if hook_handle = 0 then
			begin
				MessageBoxExW(0, PWideChar(UnicodeString('Привязка хука не удалась. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
				halt;
			end;{
			else
			begin
				MessageBoxExW(0,
					PWideChar(UnicodeString('Хук привязан. Процесс: ') +
					UnicodeString(IntToStr(game_thread)) +
					UnicodeString('Дескриптор библиотеки: ') +
					UnicodeString(IntToStr(hook_library_handle)){ +
					UnicodeString('Указатель на хук-функцию: ') +
					UnicodeString(IntToStr(p_hook_function))
					}), nil, MB_OK or MB_ICONERROR, 0);
			end;}
		end;
	end;
end;

procedure TMainForm.rgEncodingClick(Sender: TObject);
begin
	case rgEncoding.Items[rgEncoding.ItemIndex] of
		'CP1251': p_global_dll_data^.encoding := cp1252a;
		'CP1252CYR':
			case rgGames.Items[rgGames.ItemIndex] of
				'Crusader Kings II': p_global_dll_data^.encoding := cp1252c;
				'Europa Universalis IV': p_global_dll_data^.encoding := cp1252b;
			end;
	end;
end;

procedure TMainForm.rgGamesClick(Sender: TObject);
begin
{	game_window := 0;
	game_thread := 0;
	if hook_handle <> 0 then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('Вызвана отвязка.')), nil, MB_OK or MB_ICONERROR, 0);
		if (UnhookWindowsHookEx(hook_handle) = false) then MessageBoxExW(0, PWideChar(UnicodeString('Отвязка хука не удалась. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		else MessageBoxExW(0, PWideChar(UnicodeString('Отвязка удалась.')), nil, MB_OK or MB_ICONERROR, 0);
		hook_handle := 0;
	end;
	tGameTimer(Self);}
	rgEncodingClick(Self);
end;

procedure TMainForm.bGithubClick(Sender: TObject);
begin
	OpenURL('https://github.com/chomobi/wpckne');
end;

procedure TMainForm.bStrategiumClick(Sender: TObject);
begin
	OpenURL('https://www.strategium.ru/forum/');
end;

initialization
begin
	mf_handle := CreateFileMappingW(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TGlobalDLLData), PWideChar(UnicodeString(mf_name)));
	if mf_handle = 0 then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('Не удалось создать объект файлового отображения. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		halt;
	end;
	p_global_dll_data := MapViewOfFile(mf_handle, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TGlobalDLLData));
	if p_global_dll_data = nil then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('Не удалось отобразить файловый объект. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		halt;
	end;
	{MainForm.rgEncoding.OnClick(MainForm.rgEncoding);}
	p_global_dll_data^.encoding := cp1252b;
	hook_library_handle := LoadLibraryW(PWideChar(UnicodeString('wpckhk64.dll')));
	if hook_library_handle = 0 then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('Загрузка библиотеки не удалась. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		halt;
	end;
	pf_hook_function := GetProcAddress(hook_library_handle, PChar(ACPString('hook_function')));
	if pf_hook_function = nil then
	begin
		MessageBoxExW(0, PWideChar(UnicodeString('Получить адрес хук-функции не удалось. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
		halt;
	end;
	p_hook_function := HOOKPROC(pf_hook_function);
{	while true do
	begin
		game_window := 0;
		game_thread := 0;
		while game_window = 0 do
		begin
			Sleep(2000);
			game_window := FindWindowExW(0, 0, PWideChar(UnicodeString('SDL_app')), PWideChar(UnicodeString('Europa Universalis IV')));
		end;
		writeln('Окно: $', IntToHex(game_window, 8));
		game_thread := GetWindowThreadProcessId(game_window, pdwpi);
		writeln('PIDG: ', IntToStr(game_thread));
		writeln('PIDI: ', IntToStr(pdwpi));
		hook_handle := SetWindowsHookExW(WH_GETMESSAGE, p_hook_function, hook_library_handle, game_thread);
		if hook_handle = 0 then
		begin
			MessageBoxExW(0, PWideChar(UnicodeString('Привязка хука не удалась. Код ошибки: ') + UnicodeString(IntToStr(GetLastError))), nil, MB_OK or MB_ICONERROR, 0);
			halt;
		end;
	end;}
end;
finalization
begin
	FreeLibrary(hook_library_handle);
	UnmapViewOfFile(p_global_dll_data);
	CloseHandle(mf_handle);
	UnhookWindowsHookEx(hook_handle);
end;
end.

