
function loadVehicle(id)
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_vehicles WHERE id=?',id)
    if rows and #rows > 0 then
        for i,v in ipairs(rows) do
            local veh = createVehicle(v['model'],110.05014801025,-164.52156066895,1.7193540334702)

            local xd = {
                ['main'] = {
                    ['id'] = v['id'],
                    ['owner'] = v['owner'],
                    ['fuel'] = v['fuel']
                },
                tuning = {
                    ['engine'] = v['engine']
                }
            }
            setElementData(veh,'vehicle',xd)
        end
        print('Wczytano pojazd ID:'..id)
        exports['Qmix_MySQL']:Wynik('UPDATE expec_vehicles SET garage=? WHERE id=?','0',id)
    end
end


function saveVehicle(veh)
    local xd = getElementData(veh,'vehicle')
    if xd and xd['main'] and xd['main']['id'] then
        local id = xd['main']['id']
        local owner = xd['main']['owner']
        local fuel = xd['main']['fuel']
        local engine = xd['tuning']['engine']
        exports['Qmix_MySQL']:Wynik('UPDATE expec_vehicles SET owner=?,fuel=?,engine=? WHERE id=?',owner,fuel,engine,id)
        print('Zapisano pojazd ID:'..id)
    end
end


function loadAllVehicles()
    local rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_vehicles WHERE garage=?','0')
    if rows and #rows > 0 then
        for i,v in ipairs(rows) do
            loadVehicle(v['id'])
        end
    end
end


function saveAllVehicles()
    for i,v in ipairs(getElementsByType('vehicle')) do
        saveVehicle(v)
    end
end

addEventHandler('onResourceStart', resourceRoot, function()
	loadAllVehicles()
end)


addEventHandler('onResourceStop', resourceRoot, function()
	saveAllVehicles()
end)


addEventHandler('onVehicleStartEnter', root, function(player)
    local xd = getElementData(source,'vehicle')
    local xd2 = getElementData(player,'plr:charakter')
    if xd then
        if xd['main']['owner'] == xd2['core']['dbid'] then
            return true
        else
            exports['expec_notki']:noti(player,'error','Nie jesteś właścicielem tego pojazdu!')
            cancelEvent()
        end
    end
end)