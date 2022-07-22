function gerRank()
    local data = getElementData(client,"plr:faction")
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_factions_info WHERE faction=? AND rank=?',"SAPD",data['rank'])
    triggerClientEvent('getRank',client,rows[1].name)
end

addEvent('getRank',true)
addEventHandler('getRank',root,gerRank)



function getUserInfo()
    local data = getElementData(client,"plr:charakter")
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_factions WHERE dbid=? AND faction=?', data['core']['dbid'],"SAPD")
    triggerClientEvent('getUserInfo',client,rows)
end

addEvent('getUserInfo',true)
addEventHandler('getUserInfo',root,getUserInfo)


function getFactionMembers()
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_factions WHERE faction=?', "SAPD")
    triggerClientEvent('getFactionMembers',client,rows)
end

addEvent('getFactionMembers',true)
addEventHandler('getFactionMembers',root,getFactionMembers)


function getVehiclesSapd()
    local rows = exports['Qmix_MySQL']:Wynik("SELECT * FROM expec_factions_vehicles WHERE faction=?", "SAPD")
    triggerClientEvent('getVehiclesSapd',client,rows)
end

addEvent('getVehiclesSapd',true)
addEventHandler('getVehiclesSapd',root,getVehiclesSapd)

function getSAPDRank()
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_factions_info WHERE faction=?',"SAPD")
    triggerClientEvent('getSAPDRank',client,rows)
end

addEvent('getSAPDRank',true)
addEventHandler('getSAPDRank',root,getSAPDRank)

function addRank(name,money,level)
    local name2 = name
    local money2 = money
    local level2 = level
    exports['Qmix_MySQL']:Wynik('INSERT INTO expec_factions_info (name,money,faction,rank) VALUES (?,?,?,?)',name2,money2,"SAPD",level2)
    exports['expec_notki']:noti(client,'succes','Dodano rangę!')
end


addEvent('sapd:addRank',true)
addEventHandler('sapd:addRank',root,addRank)