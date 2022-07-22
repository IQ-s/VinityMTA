sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 

local marker = createMarker(103.62621307373,-151.4937286377,2.2929100990295,'cylinder',1)


fonts = {
	[1] = exports['expec_gui2']:getFont('semibold.ttf',20/zoom),
	[2] = exports['expec_gui2']:getFont('regular.ttf',15/zoom),
	[3] = exports['expec_gui2']:getFont('semibold.ttf',14/zoom),
	[4] = exports['expec_gui2']:getFont('regular.ttf',13/zoom),
	[5] = exports['expec_gui2']:getFont('semibold.ttf',15/zoom),
}

tabs = {
	{"Profil"},
	{"Członkowie"},
	{"Pojazdy"},
	{"Stopnie"},
}

local scroll = 1
local scroll2 = 17
local scroll3 = 17


profil_info = {
	{"Twój Nick służbowy:"},
	{"Stopień służbowy:"},
	{"Data dołączenia do frakcji:"},
	{"Ilość wystawionych mandatów:"},
	{"Ilość wejść na służbę:"},
	{"Ilość gotówki do wypłaty:"},
	{"Ilość przegranych minut na służbie:"}
}


function render()
	dxDrawImage(sx/2-540/zoom,sy/2-310/zoom,1074/zoom,620/zoom,"images/bg.png",0,0,0,tocolor(255,255,255,alpha))
	dxDrawImage(sx/2-485/zoom,sy/2-270/zoom,73/zoom,74/zoom,"images/logo.png",0,0,0,tocolor(255,255,255,alpha))
	dxDrawText("SAN ANDREAS POLICE DEPARTMENT",sx/2+80/zoom,sy/2-270/zoom,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[1], "center", "center")
	if isMouseInPosition(sx/2-520/zoom,sy/2+265/zoom,150/zoom,35/zoom) then
		dxDrawText("Zamknij",sx/2-449/zoom,sy/2+285/zoom,nill,nill,tocolor(226,97,2,alpha),1.00,fonts[2], "center", "center")
	else
		dxDrawText("Zamknij",sx/2-449/zoom,sy/2+285/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[2], "center", "center")
	end
	for i,v in ipairs(tabs) do
		if actuall == v[1] then
			dxDrawText(v[1],sx/2-449/zoom,sy/2-200/zoom+i*40/zoom,nill,nill,tocolor(226,97,2,alpha),1.00,fonts[2], "center", "center")
		elseif isMouseInPosition(sx/2-520/zoom,sy/2-220/zoom+i*40/zoom,150/zoom,35/zoom) then
			dxDrawText(v[1],sx/2-449/zoom,sy/2-200/zoom+i*40/zoom,nill,nill,tocolor(226,97,2,alpha),1.00,fonts[2], "center", "center")
		else
			dxDrawText(v[1],sx/2-449/zoom,sy/2-200/zoom+i*40/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[2], "center", "center")
		end
	end
	if actuall == "Profil" then
		for i,v in ipairs(profil_info) do
			dxDrawText(v[1],sx/2-340/zoom,sy/2-250/zoom+i*50/zoom,nill,nill,tocolor(255,255,255,page_animate),1.00,fonts[3], "left", "center")
		end
		for i,v in ipairs(user_data) do
			local name = getPlayerName(localPlayer)
			local added = v['added'] or "Trwa ładowanie danych..."
			local wystwione = v['mandaty'] or "Trwa ładowanie danych..."
			local wejscia = v['wejscia'] or "Trwa ładowanie danych..."
			dxDrawText(rank_name,sx/2-340/zoom,sy/2-135/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(name,sx/2-340/zoom,sy/2-185/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(added,sx/2-340/zoom,sy/2-85/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(wystwione,sx/2-340/zoom,sy/2-35/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(wejscia,sx/2-340/zoom,sy/2+15/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText('0',sx/2-340/zoom,sy/2+65/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText('0',sx/2-340/zoom,sy/2+115/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
		end
	elseif actuall == "Członkowie" then
		dxDrawText("Nick służbowy",sx/2-340/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		dxDrawText("Stopień",sx/2-100/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		dxDrawText("Data dodania",sx/2+100/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		x = 0
		for i,v in ipairs(faction_members) do
			if i >= scroll and i <= scroll2 then 
				x = x + 1
				local offset = (x-1)*(30/zoom)
				local name = v['nick'] or "Trwa ładowanie danych..."
				local rank = v['rank'] or "Trwa ładowanie danych..."
				local added = v['added'] or "Trwa ładowanie danych..."
				dxDrawText(name,sx/2-340/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
				dxDrawText(getRankName(rank),sx/2-100/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
				dxDrawText(added,sx/2+100/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			end
		end
	elseif actuall == "Pojazdy" then
		dxDrawText("Nazwa pojazdu",sx/2-340/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		dxDrawText("Ostatni kierowca",sx/2-100/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		dxDrawText("Stan paliwa",sx/2+100/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		dxDrawText("Stan pojazdu",sx/2+300/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
		for i,v in ipairs(vehicles_sapd) do
			local model = v['model'] or "Trwa ładowanie danych..."
			local name = getVehicleNameFromModel(model) or "Trwa ładowanie danych..."
			local last_driver = v['last_driver'] or "Trwa ładowanie danych..."
			local health = v['health'] or "Trwa ładowanie danych..."
			local fuel = v['fuel'] or "Trwa ładowanie danych..."
			local offset = (i-1)*(30/zoom)
			dxDrawText(name,sx/2-340/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(last_driver,sx/2-100/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(health.." / 100",sx/2+100/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(fuel.." / 100 L",sx/2+300/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
		end
	elseif actuall == "Stopnie" then
		for i,v in ipairs(sapd_rank) do
			local offset = (i-1)*(30/zoom)
			dxDrawText("ID rangi",sx/2-340/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
			dxDrawText("Stopień",sx/2-100/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
			dxDrawText("Zarobek za minute gry na duty",sx/2+100/zoom,sy/2-215/zoom,nill,nill,tocolor(230,230,230,page_animate),1.00,fonts[3], "left", "center")
			dxDrawText(v['id'],sx/2-340/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(v['name'],sx/2-100/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			dxDrawText(convertNumber(v['money']).. "$",sx/2+100/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "left", "center")
			if isMouseInPosition(sx/2+380/zoom,sy/2-203/zoom+offset,130/zoom,25/zoom) then
				dxDrawRectangle(sx/2+380/zoom,sy/2-203/zoom+offset,130/zoom,25/zoom,tocolor(226,97,2,page_animate))
			else
				dxDrawRectangle(sx/2+380/zoom,sy/2-203/zoom+offset,130/zoom,25/zoom,tocolor(51,51,51,page_animate))
			end
			if isMouseInPosition(sx/2-340/zoom,sy/2+275/zoom,130/zoom,25/zoom) then
				dxDrawRectangle(sx/2-340/zoom,sy/2+275/zoom,130/zoom,25/zoom,tocolor(226,97,2,page_animate))
			else
				dxDrawRectangle(sx/2-340/zoom,sy/2+275/zoom,130/zoom,25/zoom,tocolor(51,51,51,page_animate))
			end
			dxDrawText("Edytuj",sx/2+445/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "center", "center")
			dxDrawText("Dodaj rangę",sx/2-273/zoom,sy/2+287/zoom,nill,nill,tocolor(200,200,200,page_animate),1.00,fonts[4], "center", "center")
		end
	end
end

function getRankName(rank_id)
	for i,v in ipairs(sapd_rank) do
		if v['rank'] == rank_id then
			return v['name']
		end
	end
end

function getRank(player)
	local data = getElementData(player,'plr:faction')
	if data then
		return data['rank']
	end
end



bindKey("mouse_wheel_down", "both", function()
    if actuall ~= "Członkowie" then return end
    scrollUp()
end)

bindKey("mouse_wheel_up", "both", function()
    if actuall ~= "Członkowie" then return end
    scrollDown()
end)

function scrollDown()
    if actuall ~= "Członkowie" then return end
    if scroll2 == scroll3 then return end
    scroll = scroll-1
    scroll2 = scroll2-1
end

function scrollUp()
    if actuall ~= "Członkowie" then return end
    if scroll2 >= #faction_members then return end
    scroll = scroll+1
    scroll2 = scroll2+1
end

function click(button,state)
	if button == "left" and state == "down" then
		for i,v in ipairs(tabs) do
			if isMouseInPosition(sx/2-520/zoom,sy/2-220/zoom+i*40/zoom,150/zoom,35/zoom) and actuall ~= v[1] then
				actuall = v[1]
				exports['expec_gui2']:destroyEditbox('add:name')
				exports['expec_gui2']:destroyEditbox('add:money')
				exports['expec_gui2']:destroyEditbox('add:level')
				exports['expec_gui2']:destroyButton('button:create')
				animate(0, 255, "Linear", 500, function(value) page_animate = value end)
			end
		end
		if isMouseInPosition(sx/2-520/zoom,sy/2+265/zoom,150/zoom,35/zoom) then
			animate(255, 0, "Linear", 500, function(value) alpha = value page_animate = value end,function ()
				showCursor(false)
				removeEventHandler("onClientRender",root,render)
				removeEventHandler("onClientClick",root,click)	
				exports['expec_gui2']:destroyEditbox('add:name')
				exports['expec_gui2']:destroyEditbox('add:money')
				exports['expec_gui2']:destroyEditbox('add:level')
				exports['expec_gui2']:destroyButton('button:create')
			end)
		elseif isMouseInPosition(sx/2-340/zoom,sy/2+275/zoom,130/zoom,25/zoom) and actuall == "Stopnie" then
			exports['expec_gui2']:createEditbox('add:name',sx/2-340/zoom, sy/2-220/zoom, 310/zoom, 46/zoom,"Podaj nazwę rangi","user")
			exports['expec_gui2']:createEditbox('add:money',sx/2-340/zoom, sy/2-170/zoom, 310/zoom, 46/zoom,"Podaj zarobek na minutę","user")
			exports['expec_gui2']:createEditbox('add:level',sx/2-340/zoom, sy/2-120/zoom, 310/zoom, 46/zoom,"Podaj poziom rangi","user")
			exports['expec_gui2']:createButton('button:create', 'Stwórz rangę!', sx/2-340/zoom, sy/2-70/zoom, 192/zoom, 39/zoom)
			actuall = "add"
		elseif isMouseInPosition(sx/2-340/zoom, sy/2-70/zoom, 192/zoom, 39/zoom) and actuall == "add" then
			local name = exports['expec_gui2']:getEditboxText('add:name')
			local money = exports['expec_gui2']:getEditboxText('add:money')
			local level = exports['expec_gui2']:getEditboxText('add:level')
			local money2 = tonumber(money)
			triggerServerEvent("sapd:addRank",localPlayer,name,money2,level)
		end
		for i,v in ipairs(sapd_rank) do
			local offset = (i-1)*(30/zoom)
			if isMouseInPosition(sx/2+380/zoom,sy/2-203/zoom+offset,130/zoom,25/zoom) and actuall == "Stopnie" then
				selected = v
				actuall = "edytowanie"
			end
		end
	end
end

function isMouseInPosition(x,y,w,h)
	if isCursorShowing() then
		local mx,my = getCursorPosition()
		local cx,cy = sx*mx,sy*my
		if cx >= x and cx <= x+w and cy >= y and cy <= y+h then
			return true
		end
	end
	return false
end



function convertNumber(xd)  
    local format = xd  
    while true do      
        format, k = string.gsub(format, "^(-?%d+)(%d%d%d)", '%1,%2')    
        if ( k==0 ) then      
            break  
        end  
    end  
    return format
end

addEvent('getRank',true)
addEventHandler('getRank',root,function (rank)
	rank_name = rank
end)

addEvent('getUserInfo',true)
addEventHandler('getUserInfo',root,function (data)
	user_data = data
end)

addEvent('getFactionMembers',true)
addEventHandler('getFactionMembers',root,function (data)
	faction_members = data
end)

addEvent('getVehiclesSapd',true)
addEventHandler('getVehiclesSapd',root,function (data)
	vehicles_sapd = data
end)

addEvent('getSAPDRank',true)
addEventHandler('getSAPDRank',root,function (data)
	sapd_rank = data
end)

addEventHandler('onClientMarkerHit',marker,function(player)
	if player == localPlayer then
		if not getElementData(player,"plr:faction") then
			exports['expec_notki']:noti('error','Nie jesteś na służbie!')
			return false
		end
		actuall = "Profil"
		triggerServerEvent('getRank',localPlayer)
		triggerServerEvent('getUserInfo',localPlayer)
		triggerServerEvent('getFactionMembers',localPlayer)
		triggerServerEvent('getVehiclesSapd',localPlayer)
		triggerServerEvent('getSAPDRank',localPlayer)
		animate(0, 255, "Linear", 500, function(value) alpha = value end)
		animate(0, 255, "Linear", 500, function(value) page_animate = value end)
		showCursor(true)
		addEventHandler('onClientRender',root,render)
		addEventHandler('onClientClick',root,click)
	end
end)

