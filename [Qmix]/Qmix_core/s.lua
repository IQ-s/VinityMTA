
function load_organitation(player)
	if isElement(player) then
		local data = getElementData(client,"plr:charakter")
		if data and data['core'] and data['core']['dbid'] then	
			local result=exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_organitatnion_player WHERE player_dbid=?", data['core']['dbid'])
			if result and #result > 0 then
				local result2=exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_organitatnion WHERE dbid=?", result[1]['organitation_dbid'])				
				if result2 and #result2 > 0 then
					return result2[1]
				else
					return false				
				end
			else
				return false
			end
		end
	end
end

function load_player(spawn)
	if isElement(client) then
		local data = getElementData(client,"plr:charakter")
		
		if data and data['core'] and data['core']['dbid'] then	
			local dbid = data['core']['dbid']
			local result=exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_users WHERE dbid=?", dbid)
			if result and #result > 0 then
				local dane = {
					['core'] = data['core'],		
					['money'] = result[1]['money'],
					['pp'] = result[1]['pp'],
					['premium'] = result[1]['premium'],
					['organitation'] = {}
				}
				setElementData(client,"plr:charakter",dane)			

				setPlayerSkin(client,result[1]['skin'])

				if not (load_organitation(client) == false ) then
					local result2 = load_organitation(client)
					local data = getElementData(client,"plr:charakter")
					data['organitation'] = {
						['dbid'] = result2['dbid'],
						['name'] = result2['name'],
						['tag'] = result2['tag'],				
					}
					setElementData(client,"plr:charakter",dane)	
					print('Wczytano organizacje')
				end
				print('Ładowanie')
				if spawn then
					print('Ładowanie 1')
					spawnPlayer ( client, spawn[1]+math.random(-1,1),spawn[2]+math.random(-1,1),spawn[3],spawn[4],spawn[5],spawn[6] )
					fadeCamera ( client, true)
					setCameraTarget ( client, client )					
					setElementFrozen(client,false)					
				end
				local data = getElementData(client,"plr:charakter")
				print(inspect(data))
			else
				print('Nie udało się wczytać danych postaci | Brak zapisu w bazie.')
			end
		end
	end
end
addEvent( "core:load", true )
addEventHandler( "core:load", root, load_player )

