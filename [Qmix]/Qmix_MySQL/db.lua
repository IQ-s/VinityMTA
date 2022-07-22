--//////////////////////////////////////
--[[
	File: db.lua
	Author: TomeQmix @tomaszxd6@gmail.com
	Podłączenie serwera z bazą danych MySQL.
	Exporty in out.
]]
--//////////////////////////////////////
--Settings

local login = "db_85219"
local haslo = "retmdSUx47na"
local host = "87.98.236.134"

--Połączenie
Polaczenie = dbConnect( "mysql", "dbname=" .. login .. ";host=" .. host .. "", login, haslo, "share=1" )
--Polaczenie = dbConnect( "mysql", "dbname=" .. login .. ";host=" .. host .. ";charset=utf8", login, haslo, "share=1" ) Połączenie VPS
if Polaczenie then
	outputDebugString("Qmix_MySQL... Połączono z bazą danych "..host, 3)	
else
	outputDebugString("Qmix_MySQL... Nie udało się połączyć z bazą danych "..host, 3)	
end
--Zapytanie
function Wynik(...)
    local Zapytanie = dbQuery(Polaczenie, ...)
    if (not Zapytanie) then
        return nil
    end
    local rows, num, lastID = dbPoll(Zapytanie, -1)
    return rows, num, lastID
end


