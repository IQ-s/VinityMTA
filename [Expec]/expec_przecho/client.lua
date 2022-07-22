sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 


pos  = {
    {pos2 = {105.73648071289,-160.88401794434,2.0967998504639}}
}

local x,y,z = pos[1].pos2[1],pos[1].pos2[2],pos[1].pos2[3]
local marker = createMarker(x,y,z-1,"cylinder",1.5,255,255,255,150)


addEventHandler("onClientMarkerHit",marker,function(player)
    if player == localPlayer then
        addEventHandler("onClientRender",root,render)
        addEventHandler("onClientClick",root,click)
        triggerServerEvent('getVehicles',localPlayer)
        actuall = "Prywatne"
        animate(0, 255, "Linear", 500, function(value) alpha = value end)
    end
end)

addEventHandler("onClientMarkerLeave",marker,function(player)
    if player == localPlayer then
        animate(255, 0, "Linear", 500, function(value) alpha = value end,function ()
            removeEventHandler("onClientRender",root,render)
            removeEventHandler("onClientClick",root,click)
            actuall = nill
        end)
    end
end)

fonts = {
    [1] = exports['expec_gui2']:getFont('bold.ttf',16/zoom),
    [2] = exports['expec_gui2']:getFont('bold.ttf',14/zoom),
    [3] = exports['expec_gui2']:getFont('bold.ttf',13/zoom),
    [4] = exports['expec_gui2']:getFont('regular.ttf',12/zoom)
}


local scroll = 1
local scroll2 = 9
local scroll3 = 9



function render()
    dxDrawImage(sx/2-275/zoom,sy/2-300/zoom,570/zoom,530/zoom,"images/bg.png",0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-267/zoom,sy/2-293/zoom,35/zoom,35/zoom,"images/aha.png",0,0,0,tocolor(255,255,255,alpha))
    dxDrawText("Przechowywalnia pojazdów",sx/2-225/zoom,sy/2-283/zoom,nill,nill,tocolor(255,255,255,alpha),1,fonts[1], "left", "center")
    dxDrawText("SAN FIERRO",sx/2-225/zoom,sy/2-267/zoom,nill,nill,tocolor(113,113,113,alpha),1,fonts[2], "left", "center")
    x = 0
    for i,v in ipairs(test) do
        if i >= scroll and i <= scroll2 then 
            x = x + 1
            local offset = (x-1)*(50/zoom)
            dxDrawImage(sx/2-255/zoom,sy/2-225/zoom+offset,40/zoom,30/zoom,"images/car.png",0,0,0,tocolor(255,255,255,alpha))
            dxDrawText(getVehicleNameFromModel(v.model),sx/2-205/zoom,sy/2-215/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[3], "left", "center")
            dxDrawText("Przebieg pojazdu: #8a8a8a"..v.mileage.."km",sx/2-110/zoom,sy/2-215/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[4], "left", "center",false,false,false,true,false)
            dxDrawText("Stan techniczny: #8a8a8a"..v.health.."/100%",sx/2-110/zoom,sy/2-200/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[4], "left", "center",false,false,false,true,false)
            dxDrawText("Paliwo: #8a8a8a"..v.fuel.."/100L",sx/2+75/zoom,sy/2-215/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[4], "left", "center",false,false,false,true,false)
            dxDrawText("Silnik: #8a8a8a"..v.engine.." dm3",sx/2+75/zoom,sy/2-200/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[4], "left", "center",false,false,false,true,false)
            dxDrawText("ID: #8a8a8a"..v.id,sx/2-205/zoom,sy/2-200/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[4], "left", "center",false,false,false,true,false)
            if isMouseInPosition(sx/2+200/zoom,sy/2-217/zoom+offset,73/zoom,20/zoom) then
                dxDrawImage(sx/2+200/zoom,sy/2-217/zoom+offset,73/zoom,20/zoom,"images/button2.png",0,0,0,tocolor(255,255,255,255))
            else
                dxDrawImage(sx/2+200/zoom,sy/2-217/zoom+offset,73/zoom,20/zoom,"images/button.png",0,0,0,tocolor(255,255,255,alpha))
            end
            dxDrawText("Odbierz",sx/2+237/zoom,sy/2-206/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1,fonts[4], "center", "center")
        end
    end
end

function click(button,state)
    if button == "left" and state == "down" then
        x = 0
        for i,v in ipairs(test) do
            if i >= scroll and i <= scroll2 then 
                x = x + 1
                local offset = (x-1)*(50/zoom)
                if isMouseInPosition(sx/2+200/zoom,sy/2-217/zoom+offset,73/zoom,20/zoom) then
                    triggerServerEvent("takeVehicle",localPlayer,v.id,v.model)
                    close()
                end
            end
        end
    end
end    


function close()
    animate(255, 0, "Linear", 500, function(value) alpha = value end,function ()
        removeEventHandler("onClientRender",root,render)
        removeEventHandler("onClientClick",root,click)
        actuall = nill
    end)
end


addEvent('getVehicles',true)
addEventHandler('getVehicles',root,function(t)
    test = t
end)


bindKey("mouse_wheel_down", "both", function()
    if actuall ~= "Prywatne" then return end
    scrollUp()
end)

bindKey("mouse_wheel_up", "both", function()
    if actuall ~= "Prywatne" then return end
    scrollDown()
end)

function scrollDown()
    if actuall ~= "Prywatne" then return end
    if scroll2 == scroll3 then return end
    scroll = scroll-1
    scroll2 = scroll2-1
end

function scrollUp()
    if actuall ~= "Prywatne" then return end
    if scroll2 >= #test then return end
    scroll = scroll+1
    scroll2 = scroll2+1
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