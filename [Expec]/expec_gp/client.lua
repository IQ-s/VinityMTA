addCommandHandler('gp',function ()
    local x,y,z = getElementPosition(localPlayer)
    outputChatBox(""..x..","..y..","..z)
end)