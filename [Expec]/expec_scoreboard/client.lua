sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 

toggle = false

pos = {}
selected = nil
menu = false


fonts = {
	[1] = exports['expec_gui2']:getFont('semibold.ttf',13/zoom),
	[2] = exports['expec_gui2']:getFont('semibold.ttf',14/zoom),
}

textures = {}




k = 1
m = 20
n = 20

function render()
    players = {}
    for i,v in ipairs(getElementsByType("player")) do
        table.insert(players, v)
    end
    dxDrawImage(sx/2-379/zoom,sy/2-413/zoom,757/zoom,844/zoom,textures[2],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-349/zoom,sy/2-395/zoom,55/zoom,50/zoom,textures[3],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2+5/zoom,sy/2-385/zoom,375/zoom,28/zoom,textures[4],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-379/zoom,sy/2-323/zoom,757/zoom,32/zoom,textures[5],0,0,0,tocolor(255,255,255,alpha))
    dxDrawText("Ilość graczy na serwerze: "..#players,sx/2+190/zoom,sy/2-370/zoom,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[2],'center','center',nill,nill,true)
    dxDrawText("ID",sx/2-353/zoom,sy/2-307/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
    dxDrawText("Nazwa użytkownika",sx/2-205/zoom,sy/2-307/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
    dxDrawText("Reputacja",sx/2-55/zoom,sy/2-307/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
    dxDrawText("Frakcja/Służba",sx/2+136/zoom,sy/2-307/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
    dxDrawText("Ping",sx/2+324/zoom,sy/2-307/zoom,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
    X = 0
    for i,v in ipairs(players) do
        if i >= k and i <= n then 
        X = X + 1
        offsetY = math.floor(40/zoom)*(X-1)
        local id = getElementData(v,'id') or 0
        local name = getPlayerName(v)
        local rp = getElementData(v,'player:rp') or 0
        local data = getElementData(v,"plr:faction") or {}
        local faction = data['faction'] or "Brak"
        local ping = getPlayerPing(v)
        dxDrawText(id,sx/2-353/zoom,sy/2-275/zoom+offsetY,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
        dxDrawText(name,sx/2-205/zoom,sy/2-275/zoom+offsetY,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
        dxDrawText(rp,sx/2-55/zoom,sy/2-275/zoom+offsetY,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
        dxDrawText(faction,sx/2+136/zoom,sy/2-275/zoom+offsetY,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
        dxDrawText(ping,sx/2+324/zoom,sy/2-275/zoom+offsetY,nill,nill,tocolor(200,200,200,alpha),1.00,fonts[1],'center','center',nill,nill,true)
        if isMouseInPosition(sx/2+350/zoom,sy/2-283/zoom+offsetY,15/zoom,15/zoom) then
            dxDrawImage(sx/2+350/zoom,sy/2-283/zoom+offsetY,15/zoom,15/zoom,textures[6],0,0,0,tocolor(255,255,255,alpha))
        else
            dxDrawImage(sx/2+350/zoom,sy/2-283/zoom+offsetY,15/zoom,15/zoom,textures[6],0,0,0,tocolor(200,200,200,alpha))
        end
        end
    end
    if menu == true then
        dxDrawRectangle(pos.x+40/zoom,pos.y+50/zoom, 195/zoom, 180/zoom,tocolor(36,36,36,alpha2))
    end
end

function onClick(button, state, x, y)
    if button == 'left' and state == 'down' then
        if not isMouseInPosition(sx/2+350/zoom,sy/2-283/zoom+offsetY,15/zoom,15/zoom) and menu == true and not isMouseInPosition(pos.x,pos.y, 170/zoom, 180/zoom) then
            menu = false
            pos = {x=0, y=0}
        end
        X = 0
        for i,v in ipairs(players) do
            if i >= k and i <= n then 
            X = X + 1
            offsetY = math.floor(40/zoom)*(X-1)
            if isMouseInPosition(sx/2+350/zoom,sy/2-283/zoom+offsetY,15/zoom,15/zoom) then
                selected = v
                menu = false
                pos = {x=0,y=0}
                menu = true
                pos = {x=sx/2+1010/zoom-650/zoom,y=sy-900/zoom+offsetY}
                animate(0, 255, "Linear", 500, function(value) alpha2 = value end)
            end
        end
            
        end
        end
    end

bindKey("tab", "down", function()
    if toggle == true then
        animate(255, 0, "Linear", 500, function(value) alpha = value end,function ()
            removeEventHandler("onClientRender", root, render)
            removeEventHandler("onClientClick", root, onClick)
            showCursor(false)
            toggle = false
            for i,v in ipairs(textures) do
                if v then
                    destroyElement(v)
                    textures[i] = nil
                end
            end
            textures = {}
        end)
    else
		textures = {
			[1] = dxCreateTexture('images/Score.png',"argb",false,"clamp"),
			[2] = dxCreateTexture('images/bg.png',"argb",false,"clamp"),
			[3] = dxCreateTexture('images/logo.png',"argb",false,"clamp"),
			[4] = dxCreateTexture('images/pasek.png',"argb",false,"clamp"),
			[5] = dxCreateTexture('images/pasek2.png',"argb",false,"clamp"),
			[6] = dxCreateTexture('images/more.png',"argb",false,"clamp"),
		}
        addEventHandler("onClientRender", root, render)
        animate(0, 255, "Linear", 500, function(value) alpha = value end)
        addEventHandler("onClientClick", root, onClick)
        showCursor(true)
        toggle = true
        selected = nill
        menu = false
        pos = {x=0,y=0}
    end
end)

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end