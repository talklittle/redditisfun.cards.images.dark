local thumbnails = {}

function thumbnails.getImageUrl(url)
    local urlLower = url:lower()

    local scheme
    if urlLower:sub(1, 5) == "https" then
        scheme = "https"
    else
        scheme = "http"
    end

    local withoutScheme = urlLower:sub(scheme:len() + 4)
    local pathSlashIndex = withoutScheme:find("/")

    local host
    if pathSlashIndex ~= nil then
        host = withoutScheme:sub(1, pathSlashIndex - 1)
    else
        host = withoutScheme:sub(1)
    end

    -- get common extensions (.jpg, .png, .gif)
    local last4 = urlLower:sub(-4)
    -- 4-char extensions (.jpeg, .gifv)
    local last5 = urlLower:sub(-5)

    if withoutScheme:sub(1, 12) == "imgur.com/a/" then
        return url
    elseif withoutScheme:sub(1, 18) == "imgur.com/gallery/" then
        return nil
    elseif host == "i.imgur.com" or host == "imgur.com" then
        if last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
            return url:sub(1, -5) .. "l.jpg"
        elseif last5 == ".jpeg" or last5 == ".gifv" then
            return url:sub(1, -6) .. "l.jpg"
        else
            return url .. "l.jpg"
        end
    elseif last4 == ".jpg" or last4 == ".gif" or last4 == ".png" or last5 == ".jpeg" then
        return url
    else
        return nil
    end
end

return thumbnails