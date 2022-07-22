sx, sy = guiGetScreenSize()
local zoom = 1 
if sx < 2048 then
	zoom = math.min(2.2, 2048/sx)
end 

mask_texture = dxCreateTexture('images/mask.png', 'argb', false, 'clamp')
noavatar = dxCreateTexture('images/noavatar.png', 'argb', false, 'clamp')

mask = dxCreateShader("images/masked.fx")

dxSetShaderValue(mask, 'sPicTexture', noavatar)
dxSetShaderValue(mask, 'sMaskTexture', mask_texture)
dxSetShaderValue(mask, 'gUVScale', 1, 1)

font1 = exports['expec_gui2']:getFont('semibold.ttf',14/zoom)

function render()
	if not getElementData(localPlayer,"plr:charakter") then return end
	local money = getPlayerMoney(localPlayer)
	local health = getElementHealth(localPlayer)
	local armor = getPedArmor(localPlayer)
	dxDrawImage(sx-160/zoom,sy-1130/zoom,113/zoom,113/zoom,mask)
	dxDrawText("#e26102$#ffffff "..formatNumber(string.format("%09d", money), ','),sx-48/zoom,sy-880/zoom,sx-160/zoom,sy-1130/zoom,tocolor(255,255,255,255),1.00,font1,"center","center",false,false,false,true,false)
	dxDrawImage(sx-40/zoom,sy-1130/zoom,5/zoom,113/zoom,"images/hp.png")
	dxDrawImage(sx-30/zoom,sy-1130/zoom,5/zoom,113/zoom,"images/armor.png")
	dxDrawImageSection(sx-40/zoom,sy-1017/zoom, 5/zoom, (-113*(health/100))/zoom, 0,0, 5/zoom, (113*(health)/100),"images/hp_full.png")
	dxDrawImageSection(sx-30/zoom,sy-1017/zoom, 5/zoom, (-113*(armor/100))/zoom, 0,0, 5/zoom, (113*(armor)/100),"images/armor_full.png")
end

addEventHandler('onClientRender',root,render)



function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end