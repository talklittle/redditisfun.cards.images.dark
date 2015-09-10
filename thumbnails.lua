local thumbnails = {}

local neturl = require "neturl"

function thumbnails.getImageUrl(url)
    local u = neturl.parse(url)

    local pathLower = u.path:lower()

    -- get common extensions (.jpg, .png, .gif)
    local last4 = pathLower:sub(-4)
    -- 4-char extensions (.jpeg, .gifv)
    local last5 = pathLower:sub(-5)

    if u.host == "imgur.com" and u.path:sub(1, 3) == "/a/" then
        return url
    elseif u.host == "imgur.com" and u.path:sub(1, 9) == "/gallery/" then
        -- image hash is length 7
        local galleryImageHash = string.match(u.path:sub(10), '[0-9A-Za-z][0-9A-Za-z][0-9A-Za-z][0-9A-Za-z][0-9A-Za-z][0-9A-Za-z][0-9A-Za-z]')
        if galleryImageHash then
            return "http://i.imgur.com/" .. galleryImageHash .. "l.jpg"
        else
            -- let Java side handle it
            return url
        end
    elseif u.host == "i.imgur.com" or u.host == "imgur.com" then
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

local methodExists, showThumbnails = pcall(redditisfun.isShowThumbnails, redditisfun)
if methodExists then
    thumbnails.enabled = showThumbnails
else
    thumbnails.enabled = true
end

return thumbnails