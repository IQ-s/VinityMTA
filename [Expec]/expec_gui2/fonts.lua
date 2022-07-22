fonts = {}

function getFont(path, size)
    if not fileExists('fonts/'..path) then 
        print('Brak fontu: '..path)
    end

    if not fonts[path] then 
        fonts[path] = {}
    end 

    if not fonts[path][size] then 
        fonts[path][size] = dxCreateFont('fonts/'..path, size) 
    end 

    return fonts[path][size] or 'default'
end