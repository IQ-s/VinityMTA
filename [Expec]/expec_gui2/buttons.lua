
sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end



buttons = {}

font = getFont('regular.ttf', 16)

local image = {
	[1] = dxCreateTexture('img/buttons/button.png',"argb",false,"clamp"),
}	

function drawButton()
    for i, v in pairs(buttons) do 
        if isMouseInPosition(v.x, v.y, v.w, v.h) then
            dxDrawImage(v.x, v.y, v.w, v.h, image[1], 0, 0, 0, tocolor(255, 255, 255, v.alpha),true)
        else
            dxDrawImage(v.x, v.y, v.w, v.h, image[1], 0, 0, 0, tocolor(255, 255, 255, v.alpha*0.7),true)
        end
        local text = v.text
        dxDrawText(text, v.x + (v.w / 2), v.y + (v.h / 2), nill, nill, tocolor(255, 255, 255, v.alpha), 1.00/zoom, font, 'center', 'center', nill, nill, true)
    end
end
addEventHandler('onClientRender', root, drawButton)

function createButton(id,text, x, y, w, h, color)
    buttons[id] = {}
    buttons[id].text = text
    buttons[id].x = x 
    buttons[id].y = y
    buttons[id].w = w
    buttons[id].h = h
    buttons[id].color = color
    buttons[id].alpha = 255
    animate(0, 255, "Linear", 500, function(value) buttons[id].alpha = value end) 
end



function destroyButton(id)
    if buttons[id] then 
        buttons[id] = nil 
    end 
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end