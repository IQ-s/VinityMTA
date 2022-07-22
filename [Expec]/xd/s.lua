function przelacz(plr)

		if getElementData(plr, getResourceName(getThisResource())..'-wyswietlanieElementDat') then
			removeElementData(plr, getResourceName(getThisResource())..'-wyswietlanieElementDat')
			triggerClientEvent(plr, 'wyswietlaj', resourceRoot, false)
		else
			setElementData(plr, getResourceName(getThisResource())..'-wyswietlanieElementDat', true, false)
			triggerClientEvent(plr, 'wyswietlaj', resourceRoot, true)
		end
end
addCommandHandler('elementdaty', przelacz)

function wysylaj()
	for _, v in pairs(getElementsByType('player')) do
		if getElementData(v, getResourceName(getThisResource())..'-wyswietlanieElementDat') then
			triggerClientEvent(v, 'dane', resourceRoot, getAllElementData(v))
		end
	end
end
setTimer(wysylaj, 100, 0)

function przystarcie()
	for _, v in pairs(getElementsByType('player')) do
		if getElementData(v, getResourceName(getThisResource())..'-wyswietlanieElementDat') then
			triggerClientEvent(v, 'wyswietlaj', resourceRoot, true)
		end
	end
end
setTimer(przystarcie, 500, 1)