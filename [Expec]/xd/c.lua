local screenW, screenH = guiGetScreenSize()
local pokazywane = false
local wysokosc = 10
local tabela = {}
local function render()
	if getKeyState('num_9') then
		wysokosc = wysokosc + 5
	elseif getKeyState('num_3') then
		wysokosc = wysokosc - 5
	elseif getKeyState('num_0') then
		wysokosc = 10
	end
	dxDrawText(inspect(tabela), screenW * 0.5571, wysokosc, screenW, screenH, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, true, false, false, false)
end

addEvent('wyswietlaj', true)
addEventHandler('wyswietlaj', resourceRoot, function(stan)
	if stan and stan ~= pokazywane then
		pokazywane = true
		addEventHandler('onClientRender', root, render)
	elseif not stan and stan ~= pokazywane then
		pokazywane = false
		removeEventHandler('onClientRender', root, render)
	end
end)

addEvent('dane', true)
addEventHandler('dane', resourceRoot, function(tbl)
	tabela = tbl
end)

--[[print('====================================')
print('==== ELEMENTDATY NA EKRANIE ====')
print('/elementdaty - wyświetlanie elementdat')
print('Num9 - przesuwanie do góry')
print('Num3 - przesuwanie w dół')
print('Num0 - wracanie do zwykłej pozycji')
print('====================================')]]
