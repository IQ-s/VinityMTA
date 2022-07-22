function noti(element, type, text)
    if not element or not text then return false end 
    triggerClientEvent(element, 'notka', element, type, text)
end