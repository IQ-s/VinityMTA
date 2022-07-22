sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 





textures = {
    ['bg'] = dxCreateTexture('images/bg.png','argb',false,'clamp'),
    ['succes'] = dxCreateTexture('images/succes_icon.png','argb',false,'clamp'),
    ['error'] = dxCreateTexture('images/error_icon.png','argb',false,'clamp'),
    ['info'] = dxCreateTexture('images/info_icon.png','argb',false,'clamp')
}

names = {
    ['info'] = 'Informacja',
    ['error'] = 'Błąd',
    ['succes'] = 'Sukces'
}

fonts = {
    [1] = exports['expec_gui2']:getFont('bold.ttf',13/zoom),
    [2] = exports['expec_gui2']:getFont('light.ttf',12/zoom)
}

notki = {}

toggle = false

function render()
    --dxDrawImage(0,0,sx,sy,textures[1])
    for i,v in ipairs(notki) do
        local offset = ((i-1)*45)
        dxDrawImage(sx/2-420/zoom,sy-50/zoom-offset,835/zoom,43/zoom,textures['bg'],0,0,0,tocolor(255,255,255,alpha))
        dxDrawImage(sx/2-408/zoom,sy-42/zoom-offset,26/zoom,26/zoom,textures[v.type],0,0,0,tocolor(255,255,255,alpha))
        dxDrawText(names[v.type],sx/2-375/zoom,sy-35/zoom-offset,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[1],'left','center',nill,nill,true)
        dxDrawText(v.text,sx/2-375/zoom,sy-21/zoom-offset,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[2],'left','center',nill,nill,true)
    end
    for i, v in ipairs(notki) do
        if getTickCount()-v.tick >= 7500+450 then table.remove(notki, i) end
        if #notki <= 0 then
            animate(255, 0, "Linear", 500, function(value) alpha = value end,function ()
                removeEventHandler("onClientRender", getRootElement(), render)
                toggle = false
                for i,v in ipairs(textures) do
                    if v then
                        destroyElement(v)
                        textures[i] = nil
                    end
                end
            end)
        end
    end
end


function noti(type,text)
    if not text or not type then return end
    notki[#notki+1] = {
        type = type or 'info',
        text = text,
        tick = getTickCount(),
    }
    if toggle == false then
        toggle = true
        animate(0, 255, "Linear", 500, function(value) alpha = value end)
        addEventHandler("onClientRender", getRootElement(), render)
    end
end

addEvent('notka',true)
addEventHandler('notka',root,function(type,text)
    noti(type,text)
end)