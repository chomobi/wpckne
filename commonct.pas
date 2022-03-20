{
wpckhk64
Copyright © 2018, 2022 terqüéz <gz0@ro.ru>

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
unit CommonCT;

{$mode objfpc}{$H+}

interface

type

PGlobalDLLData = ^TGlobalDLLData;
TGlobalDLLData = packed record
	encoding: Byte;
end;

const
mf_name = 'wpckne_mf';
cp1252a = 1;
cp1252b = 2;
cp1252c = 3;

implementation

end.

