function getFaction(plr)
    local data = getElementData(plr,"plr:charakter")
    rows = exports['Qmix_MySQL']:Wynik('SELECT * FROM expec_factions WHERE dbid=? AND faction=?', data['core']['dbid'],"SAPD")
    if rows and #rows > 0 then
        return true
    end
end


local marker = createMarker(109.70892333984,-155.52529907227,1.7492110729218,'cylinder',1)


addEventHandler('onMarkerHit',marker,function (xd)
    if getFaction(xd) then
        if getElementData(xd,"plr:faction") then
            exports['expec_notki']:noti(xd,"succes","Pomyślnie zakończono służbę")
            setElementData(xd,"plr:faction",nill)
        else
            exports['expec_notki']:noti(xd,"succes","Pomyślnie rozpoczęto służbę")
            setElementData(xd,"plr:faction",{['faction'] = "SAPD",['rank'] = rows[1].rank})
            local data = getElementData(xd,"plr:charakter")
            exports['Qmix_MySQL']:Wynik('UPDATE expec_factions SET wejscia=wejscia+1 WHERE dbid=? AND faction=?',data['core']['dbid'],"SAPD")
        end
    else
        exports['expec_notki']:noti(xd,"error","Nie jesteś dodany do frakcji")
    end
end)

