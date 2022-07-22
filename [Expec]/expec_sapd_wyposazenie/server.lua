function addItem(type,value)
    local type2 = type
    local value2 = value
    if type2 ~= "armor" then
        giveWeapon(client,value2,200)
    else
        setPedArmor(client,value2)
    end    
end

addEvent("addItem",true)
addEventHandler("addItem",root,addItem)


function removeItem(type,value)
    local type2 = type
    local value2 = value
    if type2 ~= "armor" then
        takeWeapon(client,value2)
    else
        setPedArmor(client,0)
    end    
end

addEvent("removeItem",true)
addEventHandler("removeItem",root,removeItem)