function takeVehicle(plr,id)
    local xd = id
    exports['expec_vehicles']:loadVehicle(plr,xd)
end

addEvent("takeVehicle", true)
addEventHandler("takeVehicle", root, takeVehicle)


function getVehicles()
    local data = getElementData(client,"plr:charakter")
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_vehicles WHERE owner=? AND garage=?',data['core']['dbid'],'1')
    if rows and #rows > 0 then
        triggerClientEvent(client,"getVehicles",client,rows)
    end
end

addEvent("getVehicles", true)
addEventHandler("getVehicles", root, getVehicles)