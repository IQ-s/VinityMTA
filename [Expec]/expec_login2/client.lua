--[[sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 
]]
local sx,sy = guiGetScreenSize();
local zoom = 1;
if(sx < 1920)then
    zoom = math.min(2, 1920/sx);
end;



fonts = {
    [1] = exports['expec_gui2']:getFont('semibold.ttf',16),
    [2] = exports['expec_gui2']:getFont('regular.ttf',17)
}

song = "testowa nuta - cos tam elo"

function render()
 --   dxDrawImage(0,0,sx,sy,textures[1])
    dxDrawImage(0,0,sx,sy,textures[2],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-150/zoom,70/zoom,300/zoom,200/zoom,textures[4],0,0,0,tocolor(255,255,255,alpha))
    if page ~= "Wybieranie" then
    dxDrawImage(sx/2-57/zoom,sy/2-212/zoom,111/zoom,107/zoom,textures[3],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(20/zoom,sy - 58/zoom,42/zoom,39/zoom,textures[5],0,0,0,tocolor(255,255,255,alpha))
    dxDrawText(song,75/zoom,sy-42/zoom,nill,sy-35/zoom,tocolor(255,255,255,alpha),1.00/zoom,fonts[2],'left','center',false,false,false,false)
    if page == "LOGOWANIE" then
        dxDrawText('LOGOWANIE',sx/2+62/zoom,sy/2-55/zoom,nill,nill,tocolor(225,97,3,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
    else
        dxDrawText('LOGOWANIE',sx/2+62/zoom,sy/2-55/zoom,nill,nill,tocolor(255,255,255,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false) 
    end
    if page == "REJESTRACJA" then
        dxDrawText('REJESTRACJA',sx/2-62/zoom,sy/2-55/zoom,nill,nill,tocolor(225,97,3,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
    else
        dxDrawText('REJESTRACJA',sx/2-62/zoom,sy/2-55/zoom,nill,nill,tocolor(255,255,255,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false) 
    end
elseif page == "Wybieranie" then
    dxDrawImage(sx/2-300/zoom,sy/2+155/zoom,182/zoom,30/zoom,textures[6],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-90/zoom,sy/2+155/zoom,182/zoom,30/zoom,textures[6],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2+118/zoom,sy/2+155/zoom,182/zoom,30/zoom,textures[6],0,0,0,tocolor(255,255,255,alpha))
    dxDrawRectangle(sx/2-355/zoom,sy/2-265/zoom,702/zoom,400/zoom,tocolor(31,31,31,alpha))
    if isMouseInPosition(sx/2-300/zoom,sy/2+155/zoom,182/zoom,30/zoom) then
        dxDrawText('Spawn San Fierro',sx/2-205/zoom,sy/2+168/zoom,nill,nill,tocolor(225,97,3,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
        dxDrawImage(sx/2-355/zoom,sy/2-265/zoom,702/zoom,400/zoom,"images/Spawn.png",0,0,0,tocolor(255,255,255,alpha2))
    else
        dxDrawText('Spawn San Fierro',sx/2-205/zoom,sy/2+168/zoom,nill,nill,tocolor(200,200,200,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
    end
    if isMouseInPosition(sx/2-90/zoom,sy/2+155/zoom,182/zoom,30/zoom) then
        dxDrawText('Przechowywalnia',sx/2+4/zoom,sy/2+168/zoom,nill,nill,tocolor(225,97,3,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
        dxDrawImage(sx/2-355/zoom,sy/2-265/zoom,702/zoom,400/zoom,"images/przecho.png",0,0,0,tocolor(255,255,255,alpha2))
    else
        dxDrawText('Przechowywalnia',sx/2+4/zoom,sy/2+168/zoom,nill,nill,tocolor(200,200,200,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
    end
        if isMouseInPosition(sx/2+118/zoom,sy/2+155/zoom,182/zoom,30/zoom) then
        dxDrawText('Urzad miasta',sx/2+205/zoom,sy/2+168/zoom,nill,nill,tocolor(225,97,3,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
        dxDrawImage(sx/2-355/zoom,sy/2-265/zoom,702/zoom,400/zoom,"images/Spawn.png",0,0,0,tocolor(255,255,255,alpha2))
    else
        dxDrawText('Urzad miasta',sx/2+205/zoom,sy/2+168/zoom,nill,nill,tocolor(200,200,200,alpha),1.00/zoom,fonts[1],'center','center',false,false,false,false)
    end
end
end





click = function(button, state)
    if button == "left" and state == "up" then
        if isMouseInPosition(sx/2,sy/2-63/zoom,120/zoom,20/zoom) and page ~= "LOGOWANIE" then
            page = "LOGOWANIE"
            exports['expec_gui2']:destroyEditbox('register:nick')
            exports['expec_gui2']:destroyEditbox('register:password')
            exports['expec_gui2']:destroyEditbox('register:email')
            exports['expec_gui2']:destroyButton('button:register')
            exports['expec_gui2']:createEditbox('login:nick',sx/2-184/zoom, sy/2-28/zoom, 365/zoom, 46/zoom,"Podaj login...","user")
            exports['expec_gui2']:createEditbox('login:password',sx/2-184/zoom, sy/2+34/zoom, 365/zoom, 46/zoom,"Podaj hasło...","password")
            exports['expec_gui2']:setEditboxMasked('login:password',true)
            exports['expec_gui2']:createButton('button:login', 'Wejdź do gry!', sx/2-97/zoom, sy/2+103/zoom, 192/zoom, 39/zoom)
        elseif isMouseInPosition(sx/2-120/zoom,sy/2-63/zoom,120/zoom,20/zoom) and page ~= "REJESTRACJA" then
            page = "REJESTRACJA"
            exports['expec_gui2']:destroyEditbox('login:nick')
            exports['expec_gui2']:destroyEditbox('login:password')
            exports['expec_gui2']:destroyButton('button:login')
            exports['expec_gui2']:createEditbox('register:nick',sx/2-184/zoom, sy/2-27/zoom, 365/zoom, 46/zoom,"Podaj login...","user")
            exports['expec_gui2']:createEditbox('register:password',sx/2-184/zoom, sy/2+34/zoom, 365/zoom, 46/zoom,"Podaj hasło...","password")
            exports['expec_gui2']:createEditbox('register:email',sx/2-184/zoom, sy/2+96/zoom, 365/zoom, 46/zoom,"Podaj E-MAIL...","password")
            exports['expec_gui2']:setEditboxMasked('register:password',true)
            exports['expec_gui2']:createButton('button:register', 'Zarejestruj się', sx/2-97/zoom, sy/2+162/zoom, 192/zoom, 39/zoom)
        elseif isMouseInPosition(sx/2-99/zoom, sy/2+110/zoom, 200/zoom, 40/zoom) and page == "LOGOWANIE" then
            local nick = exports['expec_gui2']:getEditboxText('login:nick')
            local password = exports['expec_gui2']:getEditboxText('login:password')
			if dozwolone_znaki(nick) == false then
                exports['expec_notki']:noti('error','Nazwa użytkownika ma nie dozwolone znaki')
				return false
			end
			if dozwolone_znaki(password) == false then
                exports['expec_notki']:noti('error','Hasło użytkownika ma nie dozwolone znaki')
				return false
			end			
			if string.len(nick) < 3 then
                exports['expec_notki']:noti('error','Nazwa użytkownika jest za krótka.')
				return
			end
			if string.len(password) < 3 then
                exports['expec_notki']:noti('error','Hasło jest za krótkie.')	
				return
			end

			
            triggerServerEvent("expec_loggin:login",resourceRoot,nick,password)
        elseif isMouseInPosition(sx/2-99/zoom, sy/2+170/zoom, 200/zoom, 40/zoom) and page == "REJESTRACJA" then
            local nick = exports['expec_gui2']:getEditboxText('register:nick')
            local password = exports['expec_gui2']:getEditboxText('register:password')
            local email = exports['expec_gui2']:getEditboxText('register:email')
			if dozwolone_znaki(nick) == false then
				exports['expec_notki']:noti('error','Nazwa użytkownika ma nie dozwolone znaki')
				return false
			end
			if dozwolone_znaki(password) == false then
				exports['expec_notki']:noti('error','Hasło użytkownika ma nie dozwolone znaki')
				return false
			end			
			if dozwolone_znaki(email) == false then
				exports['expec_notki']:noti('error','Email ma nie dozwolone znaki')
				return false
			end	
			if string.len(nick) < 3 then
				exports['expec_notki']:noti('error','Nazwa użytkownika jest za krótka.')
				return
			end
			if string.len(password) < 3 then
                exports['expec_notki']:noti('error','Hasło jest za krótkie.')	
				return
			end			
			if string.len(email) < 3 then
                xports['expec_notki']:noti('error','Email jest za krótki.')	
				return
			end				
			
			
            triggerServerEvent("expec_loggin:register",resourceRoot,nick,password,email)
        elseif isMouseInPosition(sx/2-300/zoom,sy/2+155/zoom,182/zoom,30/zoom) and page == "Wybieranie" then
            spawn()
            triggerServerEvent('core:load',root,{135, -132, 2})	
		elseif isMouseInPosition(sx/2-90/zoom,sy/2+155/zoom,182/zoom,30/zoom) and page == "Wybieranie" then
            spawn()
            triggerServerEvent('core:load',root,{135, -132, 2})					
		elseif isMouseInPosition(sx/2+118/zoom,sy/2+155/zoom,182/zoom,30/zoom) and page == "Wybieranie" then
            spawn()
            triggerServerEvent('core:load',root,{135, -132, 2})		
        end
    end
end

function spawn()
    removeEventHandler("onClientRender",root,render)
    removeEventHandler('onClientClick',root,click)
	for i,v in ipairs(textures) do
		destroyElement(v)
	end
	textures = {}
	showChat(true)
	showCursor(false)	
end

function register_success(login,password)
    page = "LOGOWANIE"
    exports['expec_gui2']:destroyEditbox('register:nick')
    exports['expec_gui2']:destroyEditbox('register:password')
    exports['expec_gui2']:destroyEditbox('register:email')
    exports['expec_gui2']:destroyButton('button:register')
    exports['expec_gui2']:createEditbox('login:nick',sx/2-184/zoom, sy/2-28/zoom, 365/zoom, 46/zoom,"Podaj login...","user",login)
    exports['expec_gui2']:createEditbox('login:password',sx/2-184/zoom, sy/2+34/zoom, 365/zoom, 46/zoom,"Podaj hasło...","password",password)
    exports['expec_gui2']:setEditboxMasked('login:password',true)
    exports['expec_gui2']:createButton('button:login', 'Wejdź do gry!', sx/2-97/zoom, sy/2+103/zoom, 192/zoom, 39/zoom)

end
addEvent( "expec_loggin:register_success", true )
addEventHandler( "expec_loggin:register_success", resourceRoot, register_success )


addEvent('expec_login:succes_login',true)
addEventHandler('expec_login:succes_login',root,function()
    page = "Wybieranie"
    exports['expec_gui2']:destroyEditbox('login:nick')
    exports['expec_gui2']:destroyEditbox('login:password')
    exports['expec_gui2']:destroyButton('button:login')
    exports['expec_gui2']:destroyEditbox('register:nick')
    exports['expec_gui2']:destroyEditbox('register:password')
    exports['expec_gui2']:destroyEditbox('register:email')
    exports['expec_gui2']:destroyButton('button:register')
end)

function dozwolone_znaki(fraza)
	if string.find(fraza, "'") then
		return false
	end
	if string.find(fraza, '"') then
		return false
	end		
	if string.find(fraza, '=') then
			return false
		end					
	if string.find(fraza, '#') then
		return false
	end			
	return true
end

function create()
    if getElementData(localPlayer,"plr:charakter") then return end
	textures = {
	  --  [1] = dxCreateTexture('images/preview.png',"argb",false,"clamp"),
		[2] = dxCreateTexture('images/bg.png',"argb",false,"clamp"),
		[3] = dxCreateTexture('images/avatar_bg.png',"argb",false,"clamp"),
		[4] = dxCreateTexture('images/logo.png',"argb",false,"clamp"),
		[5] = dxCreateTexture('images/music.png',"argb",false,"clamp"),
		[6] = dxCreateTexture('images/button.png','argb',false,'clamp'),
		[7] = dxCreateTexture('images/spawn_bg.png','argb',false,'clamp')
	}
	
    showChat(false)
    page = "LOGOWANIE"
    showCursor(true)
    setPlayerHudComponentVisible("all",false)
    addEventHandler('onClientRender', root, render)
    addEventHandler('onClientClick', root, click)
    animate(0, 255, "Linear", 500, function(value) alpha = value end)
    exports['expec_gui2']:createEditbox('login:nick',sx/2-184/zoom, sy/2-28/zoom, 365/zoom, 46/zoom,"Podaj login...","user")
    exports['expec_gui2']:createEditbox('login:password',sx/2-184/zoom, sy/2+34/zoom, 365/zoom, 46/zoom,"Podaj hasło...","password")
    exports['expec_gui2']:setEditboxMasked('login:password',true)
    exports['expec_gui2']:createButton('button:login', 'Wejdź do gry!', sx/2-97/zoom, sy/2+103/zoom, 192/zoom, 39/zoom)
end
create()


addEventHandler("onClientResourceStop", resourceRoot,function ()
    showChat(true)
    showCursor(false)
    removeEventHandler('onClientRender',root,render)
    removeEventHandler('onClientClick',root,click)
    exports['expec_gui2']:destroyEditbox('login:nick')
    exports['expec_gui2']:destroyEditbox('login:password')
    exports['expec_gui2']:destroyButton('button:login')
    exports['expec_gui2']:destroyEditbox('register:nick')
    exports['expec_gui2']:destroyEditbox('register:password')
    exports['expec_gui2']:destroyEditbox('register:email')
    exports['expec_gui2']:destroyButton('button:register')
	for i,v in ipairs(textures) do
		destroyElement(v)
	end
	textures = {}
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