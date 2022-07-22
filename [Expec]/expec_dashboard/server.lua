addEvent('getPlayerData',true)
addEventHandler('getPlayerData',root,function()
    local data = getElementData(client,"plr:charakter")
    local dbid = data['core']['dbid']
    local result = exports["Qmix_MySQL"]:Wynik("SELECT * FROM Qmix_users WHERE dbid=?", dbid)
    if not result then return end
    triggerClientEvent(client,"getPlayerData",resourceRoot,result)
end)

addEvent('getPromoInfo',true)
addEventHandler('getPromoInfo',root,function ()
    local data = getElementData(client,"plr:charakter")
    local dbid = data['core']['dbid']
    local result = exports["Qmix_MySQL"]:Wynik("SELECT * FROM expec_promocodes WHERE dbid=?", dbid)
    if not result then return end
    triggerClientEvent(client,"getPromoInfo",resourceRoot,result)
end)