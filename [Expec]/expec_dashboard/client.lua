sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 


toggle = false

page = {
    {"I N F O R M A C J E"},
    {"K O N T O"},
    {"R E G U L A M I N"},
    {"N A G R O D Y"},
    {"W Y Z W A N I A"},
    {"N O W O Ś C I"},
    {"P O J A Z D Y"},
    {"P O L E C E N I A"}
}

jobs = {
    {"Magazynier"},
    {"Sweepery"},
    {"Górnik [kopalnia]"},
    {"Grzybiarz"},
    {"Kurier"},
    {"Laweciarz"},
    {"Wędkarz"},
    {"Przewóz pieniędzy"}
}

fonts = {
    [1] = exports['expec_gui2']:getFont('regular.ttf',12/zoom),
    [2] = exports['expec_gui2']:getFont('bold.ttf',13/zoom),
    [3] = exports['expec_gui2']:getFont('regular.ttf',14/zoom),
    [4] = exports['expec_gui2']:getFont('bold.ttf',14/zoom),
    [5] = exports['expec_gui2']:getFont('bold.ttf',21/zoom),
    [6] = exports['expec_gui2']:getFont('regular.ttf',17/zoom)
}


regulamin = {
    {"Regulamin VinityMTA"},
    {"1. Regulamin zostaje automatycznie akceptowany z twoim wejściem na serwer discord/mta."},
    {"2. Zabrania się reklamowania serwerów mta/discord itp. bez zgody zarządu."},
    {"2.1 Nie tyczy się transmisji na żywo z serwera na platformach jak YouTube lub Twitch."},
    {"3. Łamanie regulaminu może skutkować banem/kickiem bądź też wyciszeniem."},
    {"4. Nieznajomość regulaminu nie zwalnia z jego przestrzegania."},
    {"5. Akceptując ten regulamin akceptujesz również wszystkie regulaminy."},
    {"6. Wszelkie naginanie bądź łamanie regulaminu wiąże się z konsekwencjami serwerowymi."},
    {"7. Kategorycznie zabronione jest działanie na szkodę serwera oraz wszystkich przynależących do nich podmiotów."},
    {"Serwer MTA:"},
    {"1. Na serwerze kategorycznie zabronione jest:"},
    {"1.1. Reklamowanie innych serwerów"},
    {"1.2. Działanie na szkodę serwera."},
    {"1.3. Sprzedawanie majątku/ów za realną gotówkę."},
    {"1.4. Działanie na szkodę innych użytkowników serwera."},
    {"1.5. Organizowanie eventów np. licytacja/e przez graczy."},
    {"1.6. Wykorzystanie pojazdów przystosowanych do prac w celach prywatnych."},
    {"1.7. Przyjmowanie oraz rozdawanie majątku karane jest banem na zawsze."},
    {"2. Na serwerze obowiązują przynajmniej podstawowe zasady kultury."},
    {"3. Wszelakie dane informatyczne należą do właściciela serwera (np. konta/majątki/itp.)."},
    {"4. Wymiany dokonywane poza wyznaczonym do tego miejscem (np. urząd/giełda) są prowadzone na własną odpowiedzialność,"},
    {"5. Zabronione jest jakiekolwiek nakłanianie do łamania regulaminu serwera."},
    {"6. Proszenie się o rangę karane jest wyrzuceniem z serwera."},
    {"7. Udostępnianie kogoś danych osobowych karane jest banem na zawsze."},
    {"8. Zakaz puszczania stereo które mają na celu obrażenia kogoś"},
    {"Komunikacja:"},
    {"1. Na serwerze zabrania się puszczania bindów, ear rapeów, przesterów itp."},
    {"2. Zakazuje się spamu, floodu oraz nadużywania CapsLocka."},
    {"3. Administracja nie ma obowiązku na odpisywanie graczom w wiadomości prywatnej w grze."},
    {"4. Zakazuje się rozpowszechniania danych osobowych, zdjęć, treści video bez zgody tej osoby."},
    {"5. Propagowanie nienawiści, nękanie, obraza na tle kulturowym, rasowym są zabronione."}
}

awards = {
    {
        name = 2000,
        price = 10,
        type = "money"
    },
    {
        name = 150,
        price = 30,
        type = "pp",
    },
    {
        name = 300,
        price = 50,
        type = "pp",
    },
    {
        name = 25000,
        price = 100,
        type = "money",
    },
    {
        name = 50000,
        price = 200,
        type = "money",
    },
    {
        name = 1000,
        price = 350,
        type = "pp",
    }
}

testpojazdy = {
    {
        model = 411,
        id = 1,
        fuel = 100,
        health = 100,
        engine = 2.4,
    }
}

local k5 = 1
local n5 = 26
local m5 = 26


playerData = {}
promoInfo = {}

function render()
    --dxDrawImage(0,0,sx,sy,textures[1],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-540/zoom,sy/2-305/zoom,1070/zoom,620/zoom,textures[2],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-480/zoom,sy/2-280/zoom,65/zoom,57/zoom,textures[5],0,0,0,tocolor(255,255,255,alpha))
    dxDrawImage(sx/2-350/zoom,sy/2-220/zoom,5/zoom,15/zoom,textures[6],0,0,0,tocolor(255,255,255,alpha))
    dxDrawText(actuall,sx/2-335/zoom,sy/2-212/zoom,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[2],'left','center',nill,nill,true)
    for i,v in ipairs(page) do
        local offset = math.floor(35/zoom)*(i-1)
        dxDrawImage(sx/2-517/zoom,sy/2-200/zoom+offset,138/zoom,25/zoom,textures[3],0,0,0,tocolor(255,255,255,alpha))
        if actuall == v[1] then
            dxDrawImage(sx/2-517/zoom,sy/2-200/zoom+offset,138/zoom,25/zoom,textures[4],0,0,0,tocolor(255,255,255,alpha))
        elseif isMouseInPosition(sx/2-517/zoom,sy/2-200/zoom+offset,138/zoom,25/zoom) then
            dxDrawImage(sx/2-517/zoom,sy/2-200/zoom+offset,138/zoom,25/zoom,textures[4],0,0,0,tocolor(255,255,255,alpha))
        end
        dxDrawText(v[1],sx/2-445/zoom,sy/2-187/zoom+offset,nill,nill,tocolor(255,255,255,alpha),1.00,fonts[1],'center','center',nill,nill,true)
    end
    if actuall == "I N F O R M A C J E" then
        local name = getPlayerName(localPlayer)
        dxDrawText("Witaj #e16103"..name.."#ffffff na polskim serwerze Roleplaygame.",sx/2+70/zoom,sy/2-150/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[3],'center','center',nill,nill,true,true,false)
        dxDrawText("Dobrze będzie jak na samym początku gry zdasz egzamin na prawo jazdy [ #e16103Kat. B#ffffff ], aby rozpocząc swoją\npierwszą pracę",sx/2+70/zoom,sy/2-100/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[3],'center','center',nill,nill,true,true,false)
        dxDrawText("Zdałeś już prawo jazdy? To dobry krok do tego, abyś poszedł do pracy, gdzie zbierając śmieci, bedziesz mógł zdobyć swoją\npierwszą gotówke na pracy [ #e16103Sweepery#ffffff ]",sx/2+70/zoom,sy/2-50/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[3],'center','center',nill,nill,true,true,false)
        dxDrawText("Praca ci się już znudziła? Możesz pójśc do pracy magazyniera, lecz tam otrzymasz mniejsze pieniądze, ale jednak\nzdobędziesz więcej reputacji.",sx/2+70/zoom,sy/2,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[3],'center','center',nill,nill,true,true,false)
        dxDrawText("Posiadasz jakieś pytania / problem z graczem? Zgłoś to na #e16103/report",sx/2+70/zoom,sy/2+300/zoom,nill,nill,tocolor(160,160,160,alphaPage),1.00,fonts[3],'center','center',nill,nill,true,true,false)
        dxDrawText("Prace które sa na serwerze:",sx/2+70/zoom,sy/2+40/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[4],'center','center',nill,nill,true,true,false)
        for i,v in ipairs(jobs) do
            local offset = math.floor(20/zoom)*(i-1)
            dxDrawText(v[1],sx/2+70/zoom,sy/2+60/zoom+offset,nill,nill,tocolor(230,230,230,alphaPage),1.00,fonts[3],'center','center',nill,nill,true,true,false)
        end
    elseif actuall == "K O N T O" then
        for i,v in ipairs(playerData) do
        local login = v['name'] or "Trwa ładowanie danych.."
        local name = getPlayerName(localPlayer)
        if zakryte == true then
            serial = "[ ukryty ] ^#e16103naciśnij#ffffff^"
        else
            serial = ""..getPlayerSerial(localPlayer).." ^#e16103naciśnij#ffffff^"
        end
        local data = getElementData(localPlayer,"plr:charakter")
        local rep = data['core']['rep'] or 0
        local czas = secondsToClock(data['core']['hours']) or "0"
        local registerDate = v['data_register'] or "Trwa ładowanie danych.."
        local money = getPlayerMoney(localPlayer) or 0
        local bank_money = v['bank'] or 0
        premiumDate = v['premium'] or "Trwa ładowanie danych.."
        if premiumDate == "0000-00-00 00:00:00" then
            premiumDate = "Brak statusu premium"
        else
            premiumDate = "#FFFF00"..premiumDate..""
        end
        dxDrawText("Twój login: "..login.."\nTwój nick: "..name.."\nSerial: "..serial.."\nPrzegrany czas online: "..czas.."\nData założenia konta: "..registerDate.."\nPunkty reputacji: "..rep.."\nGotówka: "..convertNumber(money).." $\nGotówka w banku: "..convertNumber(bank_money).." $\nKonto premium do: "..premiumDate.."",sx/2-340/zoom,sy/2-170/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[3],'left','top',nill,nill,true,true,false)
        end
    elseif actuall == "R E G U L A M I N" then
        x = 0
        for i,v in ipairs(regulamin) do
            if i >= k5 and i <= n5 then 
                x = x + 1
                local offset = math.floor(20/zoom)*(x-1)
            dxDrawText(v[1],sx/2-340/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[3],'left','top',nill,nill,true,true,false)
            end
        end
    elseif actuall == "P O J A Z D Y" then
        x = 0
        for i,v in ipairs(testpojazdy) do
            if i >= k5 and i <= n5 then 
                x = x + 1
                local offset = math.floor(20/zoom)*(x-1)
    
            dxDrawText(""..getVehicleNameFromModel(v.model).." [ID:"..v.id.."] - Paliwo: "..v.fuel.." % | Stan: "..v.health.." % | Silnik: "..v.engine.." dm3",sx/2-340/zoom,sy/2-190/zoom+offset,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[4],'left','top',nill,nill,true,true,false)
            end
        end
    elseif actuall == "P O L E C E N I A" then
        dxDrawText("Polecaj serwer znajomym i Zarabiaj!",sx/2+70/zoom,sy/2-190/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[5],'center','center',nill,nill,true,true,false)
        dxDrawText("Wszedłeś na serwer dzięki znajomemu? Zapytaj się go o jego kod i zgarnij nagrody",sx/2+70/zoom,sy/2-165/zoom,nill,nill,tocolor(200,200,200,alphaPage),1.00,fonts[6],'center','center',nill,nill,true,true,false)
        dxDrawImage(sx/2-95/zoom,sy/2-140/zoom,324/zoom,31/zoom,textures[7],0,0,0,tocolor(255,255,255,alphaPage))
        if isMouseInPosition(sx/2-20/zoom,sy/2-60/zoom,180/zoom,24/zoom) then
            dxDrawImage(sx/2-20/zoom,sy/2-60/zoom,180/zoom,24/zoom,textures[8],0,0,0,tocolor(255,255,255,200))
        else
            dxDrawImage(sx/2-20/zoom,sy/2-60/zoom,180/zoom,24/zoom,textures[8],0,0,0,tocolor(255,255,255,alphaPage))
        end
        dxDrawText("ODBIERZ SWOJĄ NAGRODE",sx/2+70/zoom,sy/2-48/zoom,nill,nill,tocolor(226,97,2,alphaPage),1.00,fonts[1],'center','center',nill,nill,true,true,false)
        for i,v in ipairs(promoInfo) do
            local code = v['code'] or "Błąd z db zgłoś się do developera serwera!"
            local used = v['used']
            dxDrawText("Twój kod zaproszenia to: #e16103"..code,sx/2+70/zoom,sy/2-124/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[4],'center','center',nill,nill,true,true,false)
            dxDrawText("Twój kod został użyty: #e16103"..used.."#ffffff razy",sx/2+70/zoom,sy/2-95/zoom,nill,nill,tocolor(255,255,255,alphaPage),1.00,fonts[2],'center','center',nill,nill,true,true,false)
        end
        for i,v in ipairs(awards) do
            local offset = math.floor(40/zoom)*(i-1)
            dxDrawImage(sx/2-55/zoom,sy/2+offset,255/zoom,27/zoom,textures[9],0,0,0,tocolor(255,255,255,alphaPage))
            if v.type == "pp" then
                xd = "PP"
            elseif v.type == "money" then
                xd = "$"
            end
            dxDrawText(""..v.price.." poleceń",sx/2-50/zoom,sy/2+3/zoom+offset,nill,nill,tocolor(200,200,200,alphaPage),1.00,fonts[2],'left','top',nill,nill,true,true,false)
            dxDrawText(""..v.name.." #e16103"..xd.."",sx/2+195/zoom,sy/2+3/zoom+offset,nill,nill,tocolor(200,200,200,alphaPage),1.00,fonts[2],'right','top',nill,nill,true,true,false)
        end
    end
end

function onClick(button, state, x, y)
    if button == 'left' and state == 'down' then
        for i,v in ipairs(page) do
            local offset = math.floor(35/zoom)*(i-1)
            if isMouseInPosition(sx/2-517/zoom,sy/2-200/zoom+offset,138/zoom,25/zoom) then
                actuall = v[1]
                animate(0, 255, "Linear", 500, function(value) alphaPage = value end)
        end
        end
        if isMouseInPosition(sx/2-250/zoom,sy/2-118/zoom,100/zoom,15/zoom) and actuall == "K O N T O" and zakryte == true then
            zakryte = false
        elseif isMouseInPosition(sx/2-30/zoom,sy/2-118/zoom,100/zoom,15/zoom) and actuall == "K O N T O" and zakryte == false then
            zakryte = true
        end
    end
end



addEvent('getPlayerData',true)
addEventHandler('getPlayerData',root,function(table)
    playerData = table
end)

addEvent('getPromoInfo',true)
addEventHandler('getPromoInfo',root,function(table)
    promoInfo = table
end)

bindKey("F1", "down", function()
    if not getElementData(localPlayer,"plr:charakter") then return end
    if toggle == true then
        animate(255, 0, "Linear", 500, function(value) alpha = value alphaPage = value end,function ()
            removeEventHandler("onClientRender", root, render)
            removeEventHandler('onClientClick',root,onClick)
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
            [1] = dxCreateTexture('images/info.png','argb',false,'clamp'),
            [2] = dxCreateTexture('images/bg.png','argb',false,'clamp'),
            [3] = dxCreateTexture('images/button_off.png','argb',false,'clamp'),
            [4] = dxCreateTexture('images/button_on.png','argb',false,'clamp'),
            [5] = dxCreateTexture('images/logo.png','argb',false,'clamp'),
            [6] = dxCreateTexture('images/xd.png','argb',false,'clamp'),
            [7] = dxCreateTexture('images/invite_bg.png','argb',false,'clamp'),
            [8] = dxCreateTexture('images/use_button.png','argb',false,'clamp'),
            [9] = dxCreateTexture('images/award_bg.png','argb',false,'clamp')
        }
        actuall = "I N F O R M A C J E"
        addEventHandler("onClientRender", root, render)
        addEventHandler('onClientClick',root,onClick)
        triggerServerEvent('getPlayerData',localPlayer)
        triggerServerEvent('getPromoInfo',localPlayer)
        zakryte = true
        animate(0, 255, "Linear", 500, function(value) alpha = value end)
        animate(0, 255, "Linear", 500, function(value) alphaPage = value end)
        toggle = true
        showCursor(true)
    end
end)

bindKey("mouse_wheel_down", "both", function()
    if actuall ~= "P O J A Z D Y" then return end
    scrollUp2()
end)

bindKey("mouse_wheel_up", "both", function()
    if actuall ~= "P O J A Z D Y" then return end
    scrollDown2()
end)

function scrollDown2()
    if actuall ~= "P O J A Z D Y" then return end
    if n5 == m5 then return end
    k5 = k5-1
    n5 = n5-1
end

function scrollUp2()
    if actuall ~= "P O J A Z D Y" then return end
    if n5 >= #testpojazdy then return end
    k5 = k5+1
    n5 = n5+1
end

bindKey("mouse_wheel_down", "both", function()
    if actuall ~= "R E G U L A M I N" then return end
    scrollUp()
end)

bindKey("mouse_wheel_up", "both", function()
    if actuall ~= "R E G U L A M I N" then return end
    scrollDown()
end)

function scrollDown()
    if actuall ~= "R E G U L A M I N" then return end
    if n5 == m5 then return end
    k5 = k5-1
    n5 = n5-1
end

function scrollUp()
    if actuall ~= "R E G U L A M I N" then return end
    if n5 >= #regulamin then return end
    k5 = k5+1
    n5 = n5+1
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

function secondsToClock(seconds)
	seconds = seconds or 0
	seconds = seconds*60
	if seconds <= 0 then
		return "0 godz. 0 min."
	else
		hours = string.format("%02.f", math.floor(seconds/3600))
		mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
		secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
		return ""..hours.." godz. "..mins.." min."
	end
end

function convertNumber(liczba)  
    local format = liczba  
    while true do      
        format, k = string.gsub(format, "^(-?%d+)(%d%d%d)", '%1,%2')    
        if ( k==0 ) then      
            break  
        end  
    end  
    return format
end