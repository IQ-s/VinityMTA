


function login(login,password)
	if client and isElement(client) then
		local result=exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_users WHERE name=?", login)
		if result and #result < 1 then
			exports['expec_notki']:noti(client,'error','Nie ma takiego konta')				
		else
			if result[1]['password'] == md5(password) then
				exports['expec_notki']:noti(client,'succes','Dane sie zgadzają, logowanie..')
				for i,v in ipairs(getElementsByType("player")) do
					local data = getElementData(v,"player:charakter")
					if data and data['core'] and data['core']['dbid'] then
						if result[1]['dbid'] == data['core']['dbid'] then
							exports['expec_notki']:noti(client,'error','Konto jest już w grze.')				
							return
						end
					end
				end	
				--logowanie
				local dane = {
					['core'] = {
						['dbid'] = result[1]['dbid'],
						['email'] = result[1]['email'],						
						['data_register'] = result[1]['data_register'],					
					},
					--['money'] = result[1]['money'],
				}
				setElementData(client,"plr:charakter",dane)
				setPlayerName(client,login)
				--exports['Qmix_MySQL']:Wynik('INSERT INTO expec_promocodes SET dbid=?,promocode=?', result[1]['dbid'],"VMTA"..result[1]['dbid'].."")
				
				--Trigger do core.
				triggerClientEvent(client,'expec_login:succes_login',resourceRoot)
			else
				exports['expec_notki']:noti(client,'error','Hasło sie nie zgadza.')	
			end
		end
	else
		exports['expec_notki']:noti(client,'error','Nie znaleziono clienta.')	
	end
end
addEvent( "expec_loggin:login", true )
addEventHandler( "expec_loggin:login", resourceRoot, login )

function register(login,password,email)
	if client and isElement(client) then
		if login and password and email then
			local result=exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_users WHERE name=?", login)
			if result and #result > 0 then
				exports['expec_notki']:noti(client,'error','Nazwa użytkownika jest zajęta.')			
			else
				local result=exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_users WHERE register_serial=?", getPlayerSerial(client))
				if result and #result >= 1 then		
					exports['expec_notki']:noti(client,'error','Maksymalnie możesz posiadać 1 konto.')		
					return
				end
				local query=exports["Qmix_MySQL"]:Wynik("INSERT INTO Qmix_users (name,password,email,data_register,register_serial) VALUES (?,?,?,curdate(),?)", login, md5(password),email,getPlayerSerial(client))
				if query then				
					exports['expec_notki']:noti(client,'succes','Zarejestrowano sie.')	
					triggerClientEvent ( client, "expec_loggin:register_success", resourceRoot, login,password )					
				end
			end
		else
			exports['expec_notki']:noti(client,'error','Nie znaleziono danych logowania.')
		end
	else
		exports['expec_notki']:noti(client,'error','Nie znaleziono clienta.')
	end
end
addEvent( "expec_loggin:register", true )
addEventHandler( "expec_loggin:register", resourceRoot, register )


















