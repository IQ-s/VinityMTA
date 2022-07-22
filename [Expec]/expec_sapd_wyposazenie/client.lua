sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 

options = {
	{name = "Paralizator",type="gun",value="23",icon="paralizator"},
	{name = "Pałka policyjna",type="gun",value="3",icon="palka"},
	{name = "Karabin [M4]",type="gun",value="31",icon="m4",},
	{name = "Kamizelka",type="armor",value="100",icon="kamizelka"},
}

fonts = {
	[1] = exports['expec_gui2']:getFont('regular.ttf',18/zoom),
	[2] = exports['expec_gui2']:getFont('semibold.ttf',14/zoom)
}

function render()
	dxDrawImage(sx/2-300/zoom,sy-340/zoom,552/zoom,295/zoom,"images/bg.png",0,0,0,tocolor(255,255,255,alpha))
	dxDrawText('WYPOSAŻENIE POJAZDU FRAKCYJNEGO',sx/2-277/zoom,sy-323/zoom,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[1], "left", "center")
	for i,v in ipairs(options) do
	dxDrawImage(sx/2-260/zoom,sy-340/zoom+i*50/zoom,33/zoom,33/zoom,"images/bg_item.png",0,0,0,tocolor(255,255,255,alpha))
	dxDrawImage(sx/2-251/zoom,sy-330/zoom+i*50/zoom,15/zoom,15/zoom,"images/"..v.icon..".png",0,0,0,tocolor(255,255,255,alpha))
	if isMouseInPosition(sx/2+180/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom) then
		dxDrawImage(sx/2+180/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom,"images/add.png",0,0,0,tocolor(255,255,255,200))
	else
		dxDrawImage(sx/2+180/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom,"images/add.png",0,0,0,tocolor(255,255,255,alpha))
	end
	if isMouseInPosition(sx/2+200/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom) then
		dxDrawImage(sx/2+200/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom,"images/remove.png",0,0,0,tocolor(255,255,255,200))
	else
		dxDrawImage(sx/2+200/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom,"images/remove.png",0,0,0,tocolor(255,255,255,alpha))
	end
	dxDrawText(v.name,sx/2-220/zoom,sy-323/zoom+i*50/zoom,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[2], "left", "center")
	end
end
function click(button,state)
	if button == "left" and state == "down" then
		for i,v in ipairs(options) do
			if isMouseInPosition(sx/2+180/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom) then
				triggerServerEvent("addItem",localPlayer,v.type,v.value)
				exports['expec_notki']:noti('succes','Pomyślnie odebrano '..v.name..'')
			elseif isMouseInPosition(sx/2+200/zoom,sy-325/zoom+i*50/zoom,12/zoom,11/zoom) then
				triggerServerEvent("removeItem",localPlayer,v.type,v.value)
				exports['expec_notki']:noti('succes','Pomyślnie odłożono '..v.name)
			end
		end
	end
end

local marker = createMarker(106.36977386475,-150.0033416748,2.049177646637,'cylinder',1)

addEventHandler('onClientMarkerHit',marker,function (xd)
	if xd == localPlayer then
		if not getElementData(xd,"plr:faction") then
			exports['expec_notki']:noti('error','Nie jesteś na duty frakcji.')
			return false
		end
		addEventHandler('onClientRender',root,render)
		addEventHandler('onClientClick',root,click)
		animate(0, 255, "Linear", 500, function(value) alpha = value end)
	end
end)

addEventHandler('onClientMarkerLeave',marker,function (xd)
	if xd == localPlayer then
		animate(255, 0, "Linear", 500, function(value) alpha = value end,function ()
			removeEventHandler('onClientRender',root,render)
			removeEventHandler('onClientClick',root,click)
		end)
	end
end)

bindKey('f3','down',function ()
	if xd == true then
		showCursor(false)
		xd = false
	else
		showCursor(true)
		xd = true
	end
end)

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