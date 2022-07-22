
sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end

local editbox = {}

local editboxFont = getFont('regular.ttf', 16)

local image = {
	[1] = dxCreateTexture('img/editbox/editbox.png',"argb",false,"clamp"),
	[2] = dxCreateTexture("img/editbox/editbox_iconbg.png","argb",false,"clamp"),	
	[3] = dxCreateTexture('img/editbox/editbox_pass-shown.png',"argb",false,"clamp"),	
	[4] = dxCreateTexture('img/editbox/editbox_pass-hidden.png',"argb",false,"clamp"),		
	['icon'] = {
		['user'] = dxCreateTexture('img/editbox/user.png',"argb",false,"clamp"),
		['password'] = dxCreateTexture('img/editbox/password.png',"argb",false,"clamp"),	
	}
}



function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end


function renderEditboxes()
    for i,v in pairs(editbox) do 
        if v.position then 
            
            local x, y, w, h = unpack(v.position)
            local text = v.masked and (v.text and string.gsub(v.text, ".", "*") or v.tooltip) or v.text
            if v.choosed and v.text then
                if not tick then tick = getTickCount() end
                d = interpolateBetween(185, 0, 0, 0, 0, 0, (getTickCount()-tick)/1500, "SineCurve")
                dxDrawRoundedRectangle(x, y+2/zoom, w, h, 10,tocolor(255,140,0,d),false)
            end
            dxDrawImage(x,y,w,h,image[1],0,0,0,tocolor(255,255,255,v.alpha))
            dxDrawImage(x,y,46/zoom,h,image[2],0,0,0,tocolor(255,255,255,v.alpha))

            if text and dxGetTextWidth(text, 1/zoom, editboxFont) > w then 
                dxDrawText(text or v.tooltip, x+54/zoom, y+2/zoom, (x-64/zoom)+w, y+h-1, tocolor(33,33, 33, v.choosed and 255 or v.alpha), 1.00/zoom, editboxFont, 'right', 'center', true)
                dxDrawText(text or v.tooltip, x+55/zoom, y+3/zoom, (x-65/zoom)+w, y+h, tocolor(255, 255, 255, v.choosed and 255 or v.alpha), 1.00/zoom, editboxFont, 'right', 'center', true)
            else
                dxDrawText(text or v.tooltip, x+54/zoom, y+2/zoom, (x-64/zoom)+w, y+h-1, tocolor(33, 33, 33, v.choosed and 255 or v.alpha), 1.00/zoom, editboxFont, 'left', 'center', true)
                dxDrawText(text or v.tooltip, x+55/zoom, y+3/zoom, (x-65/zoom)+w, y+h, tocolor(255, 255, 255, v.choosed and 255 or v.alpha), 1.00/zoom, editboxFont, 'left', 'center', true)

            end
            if v.icon then
                dxDrawImage(x+16/zoom, y+14/zoom, 13/zoom, 18/zoom, image['icon'][v.icon], 0, 0, 0, tocolor(255, 255, 255, v.choosed and 255 or v.alpha))
            end
        if v.hidden == true then
            dxDrawImage(x+345/zoom, y+3/zoom, 45/zoom, 45/zoom, image[3], 0, 0, 0, tocolor(255, 255, 255, v.choosed and 255 or v.alpha), false)
        elseif v.hidden == false then
            dxDrawImage(x+345/zoom, y+3/zoom, 42/zoom, 45/zoom, image[4], 0, 0, 0, tocolor(255, 255, 255, v.choosed and 255 or v.alpha), false)
        end






            if getKeyState("backspace") and v.choosed then
                if not deleteTick or getTickCount()-deleteTick > 45 then
                    if v.text and string.len(v.text) >= 1 then 
                        deleteTick = getTickCount()
                        v.text = string.sub(v.text, 1, string.len(v.text)-1)
                        -- triggerEvent("onClientEditboxChange", localPlayer, id)
                    end
                end
            end
        end
    end
end

function onEditboxesClick(button, state)
    if animation then return end 
    if button == 'left' and state == 'down' then 
        for i,v in pairs(editbox) do 
            local x, y, w, h = unpack(v.position)
            if isMouseInPosition(x+345/zoom, y+3/zoom, 45/zoom, 45/zoom) and v.masked == true or v.masked == false then
                if v.hidden == true then
                    v.hidden = false
                    v.masked = false
                else
                    v.hidden = true
                    v.masked = true
                end
            end
            if isMouseInPosition(x, y, w-65/zoom, h) then 
                v.choosed = true 
                if not v.text then 
                    v.text = ''
                end
            elseif not isMouseInPosition(x, y, w, h) then
                --animate(v.alpha, 150, 'Linear', 100, function(value) v.alpha = value animation = true end, function() animation = false end)
                v.choosed = false  
                if v.text == '' then 
                    v.text = nil 
                end
            end
        end
    end
end

bindKey('tab', 'down', function()
    if editbox and table.size(editbox) > 1 then
    	local a = getActiveEditbox() 
        if a then 
        	editbox[a].choosed = false
            if not editbox[a].text then 
                editbox[a].text = ''
            end
         	if editbox[a].text == '' then 
                editbox[a].text = nil 
        	end
        	editbox[getNextEditbox(editbox[a].uid)].choosed = true
            if not editbox[getNextEditbox(editbox[a].uid)].text then 
                editbox[getNextEditbox(editbox[a].uid)].text = ''
            end
        end 
    end
end)

function getActiveEditbox()
	for index, value in pairs(editbox) do 
		if value.choosed then 
			return index 
		end 
	end 
	return nil
end

function getNextEditbox(uid)
	if editbox[findEditboxByUID(uid)] and editbox[findEditboxByUID(uid + 1)] then 
		return findEditboxByUID(uid + 1)
	else 
		return findEditboxByUID(1)
	end 
	return nil 
end

function findFreeUID()
	for index, value in pairs(editbox) do 
		if not value.uid then 
			return value.uid 
		end 
	end 
	return table.size(editbox) + 1
end

function findEditboxByUID(uid)
	for index, value in pairs(editbox) do 
		if value.uid == uid then 
			return index
		end 
	end 
end
                
function onEditboxCharacter(char)
    if not allowedCharacters[char] then return false end
    for i,v in pairs(editbox) do
        if v.choosed then
            local x, y, w, h = unpack(v.position)
            v.text = v.text..char
            -- if dxGetTextWidth(v.text, 1/zoom, editboxFont) > w then 
            --     v.clip = v.clip+dxGetTextWidth(string.sub(v.text, string.len(v.text)-1, string.len(v.text)), 1/zoom, editboxFont)
            -- end
            -- triggerEvent("onClientEditboxChange", localPlayer, i)
        end
    end
end

function setEditboxMasked(id, bool)
    if not id or not editbox[id] then return end 
    editbox[id].masked = bool 
    editbox[id].hidden = bool
end

function getEditboxText(id)
    if not id or not editbox[id] then return end 
    return editbox[id].text or ''
end

function createEditbox(id, x, y, w, h, tooltip, icon,texts)
    if not id or not x or not y or not w or not h then 
        return false 
    end

    print(findFreeUID())
    editbox[id] = { 
    	uid = findFreeUID(),
        position = {x, y, w, h},
        tooltip = tooltip or 'Pole do wpisywania',
        alpha = 255, 
        clip = 0, 
        icon = icon,
        hidden = nill,
		text = texts or nil
    }

    removeEventHandler('onClientRender', root, renderEditboxes)
    addEventHandler('onClientRender', root, renderEditboxes)

    removeEventHandler('onClientClick', root, onEditboxesClick)
    addEventHandler('onClientClick', root, onEditboxesClick)

    removeEventHandler('onClientCharacter', root, onEditboxCharacter)
    addEventHandler('onClientCharacter', root, onEditboxCharacter)
    animate(0, 255, "Linear", 500, function(value) editbox[id].alpha = value end)
end 



function destroyEditbox(id)
    if not id or not editbox[id] then 
        return false 
    end

    editbox[id] = nil 
    animation = false 

    if not editbox or table.size(editbox) <= 0 then 
        removeEventHandler('onClientRender', root, renderEditboxes)
        removeEventHandler('onClientClick', root, onEditboxesClick)
        removeEventHandler('onClientCharacter', root, onEditboxCharacter)
    end
end

allowedCharacters = {}
    allowedCharacters["a"] = true
    allowedCharacters["b"] = true
    allowedCharacters["c"] = true
    allowedCharacters["d"] = true
    allowedCharacters["e"] = true
    allowedCharacters["f"] = true
    allowedCharacters["g"] = true
    allowedCharacters["h"] = true
    allowedCharacters["i"] = true
    allowedCharacters["j"] = true
    allowedCharacters["k"] = true
    allowedCharacters["l"] = true
    allowedCharacters["m"] = true
    allowedCharacters["n"] = true
    allowedCharacters["o"] = true
    allowedCharacters["u"] = true
    allowedCharacters["p"] = true
    allowedCharacters["r"] = true
    allowedCharacters["s"] = true
    allowedCharacters["t"] = true
    allowedCharacters["u"] = true
    allowedCharacters["v"] = true
    allowedCharacters["w"] = true
    allowedCharacters["x"] = true
    allowedCharacters["y"] = true
    allowedCharacters["z"] = true
    allowedCharacters["q"] = true

    allowedCharacters[" "] = true
    allowedCharacters["."] = true
    allowedCharacters[","] = true
    allowedCharacters["!"] = true
    allowedCharacters["@"] = true
    allowedCharacters["#"] = true
    allowedCharacters["$"] = true
    allowedCharacters["%"] = true
    allowedCharacters["^"] = true
    allowedCharacters["&"] = true
    allowedCharacters["*"] = true
    allowedCharacters["("] = true
    allowedCharacters[")"] = true
    allowedCharacters["["] = true
    allowedCharacters["]"] = true
    allowedCharacters["/"] = true
    allowedCharacters["?"] = true

    allowedCharacters["A"] = true
    allowedCharacters["B"] = true
    allowedCharacters["C"] = true
    allowedCharacters["D"] = true
    allowedCharacters["E"] = true
    allowedCharacters["F"] = true
    allowedCharacters["G"] = true
    allowedCharacters["H"] = true
    allowedCharacters["I"] = true
    allowedCharacters["J"] = true
    allowedCharacters["K"] = true
    allowedCharacters["L"] = true
    allowedCharacters["M"] = true
    allowedCharacters["N"] = true
    allowedCharacters["O"] = true
    allowedCharacters["U"] = true
    allowedCharacters["V"] = true
    allowedCharacters["P"] = true
    allowedCharacters["R"] = true
    allowedCharacters["S"] = true
    allowedCharacters["T"] = true
    allowedCharacters["U"] = true
    allowedCharacters["W"] = true
    allowedCharacters["X"] = true
    allowedCharacters["Y"] = true
    allowedCharacters["Z"] = true
    allowedCharacters["Q"] = true

    allowedCharacters["1"] = true
    allowedCharacters["2"] = true
    allowedCharacters["3"] = true
    allowedCharacters["4"] = true
    allowedCharacters["5"] = true
    allowedCharacters["6"] = true
    allowedCharacters["7"] = true
    allowedCharacters["8"] = true
    allowedCharacters["9"] = true
    allowedCharacters["0"] = true