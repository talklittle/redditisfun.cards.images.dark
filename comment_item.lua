local commentmodule = require "commentmodule"
local palette = require "palette"

-- local aliases for globals
local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL

local TEXT_COLOR_PRIMARY       = redditisfun.TEXT_COLOR_PRIMARY
local TEXT_COLOR_SECONDARY     = redditisfun.TEXT_COLOR_SECONDARY
local TEXT_COLOR_SUBMITTER     = "#888888"
local TEXT_COLOR_OP            = palette.TEXT_COLOR_OP
local TEXT_COLOR_MODERATOR     = "#ff228822"
local TEXT_COLOR_ADMIN         = "#ffff0011"
local TEXT_COLOR_SPECIAL_ADMIN = "#BE1337"
local TEXT_COLOR_GILDED        = "#99895F"

local TEXT_SIZE_BODY   = TEXT_SIZE_SMALL * 1.1
local TEXT_SIZE_GILDED = TEXT_SIZE_SMALL * 0.9

local SELECTABLE_ITEM_BACKGROUND = redditisfun.SELECTABLE_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts
local Toasts = redditisfun.Toasts

---
-- @usage exported
function newView(Builder)
    local view1 = Builder:beginLinearLayout("root_container")
    view1:setLayoutSize("fill_parent", "wrap_content")
    view1:setOrientation("horizontal")
    view1:setOnClick("onListItemClick")
    view1:setBackground(SELECTABLE_ITEM_BACKGROUND)
        for i = 1,10 do
            commentmodule.addIndent(Builder, "left_indent"..i)
        end

        local view2 = Builder:beginLinearLayout("view2")
        view2:setLayoutSize("0dp", "wrap_content")
        view2:setLayoutWeight(1.000000)
        view2:setOrientation("vertical")
        view2:setPadding("5dp", "8dp", "5dp", "8dp")
    
            local comment_nav = Builder:beginLinearLayout("comment_nav")
            comment_nav:setLayoutSize("wrap_content", "wrap_content")
            comment_nav:setOrientation("horizontal")
            comment_nav:setGravity("center")
                local close_comment = Builder:addButtonSmall("close_comment")
                close_comment:setLayoutSize("wrap_content", "wrap_content")
                close_comment:setOnClick("closeComment")
                close_comment:setText("done")
                local hide_comment = Builder:addButtonSmall("hide_comment")
                hide_comment:setLayoutSize("wrap_content", "wrap_content")
                hide_comment:setOnClick("hideComment")
                hide_comment:setText("hide")
                local view6 = Builder:addView("view6")
                view6:setLayoutSize("0dp", "wrap_content")
                view6:setLayoutWeight(1.000000)
                local prev = Builder:addButtonSmall("prev")
                prev:setLayoutSize("wrap_content", "wrap_content")
                prev:setOnClick("prevComment")
                prev:setText("▲ prev")
                local next = Builder:addButtonSmall("next")
                next:setLayoutSize("wrap_content", "wrap_content")
                next:setOnClick("nextComment")
                next:setText("next ▼")
                local root = Builder:addButtonSmall("root")
                root:setLayoutSize("wrap_content", "wrap_content")
                root:setOnClick("rootComment")
                root:setText("▲ root")
                local full_comments = Builder:addButtonSmall("full_comments")
                full_comments:setLayoutSize("wrap_content", "wrap_content")
                full_comments:setOnClick("fullComments")
                full_comments:setText("▲ full")
                local parent = Builder:addButtonSmall("parent")
                parent:setLayoutSize("wrap_content", "wrap_content")
                parent:setOnClick("parentComment")
                parent:setText("▲ parent")
            Builder:endViewGroup()
    
            local view12 = Builder:beginLinearLayout("view12")
            view12:setLayoutSize("wrap_content", "wrap_content")
            view12:setOrientation("horizontal")
            view12:setGravity("center_vertical")

                commentmodule.addCommentVote(Builder, "view13")

                local submitter = commentmodule.addSubmitterWithTags(Builder)

                local view17 = Builder:beginLinearLayout("view17")
                view17:setLayoutSize("wrap_content", "wrap_content")
                view17:setOrientation("horizontal")
                view17:setGravity("center_vertical")
                    local flair = Builder:addTextView("flair")
                    flair:setLayoutSize("0dp", "wrap_content")
                    flair:setLayoutWeight(1.000000)
                    flair:setLayoutMarginRight("5dip")
                    flair:setVisibility("gone")
                    flair:setTextSize(TEXT_SIZE_SMALL)
                    flair:setTextColor(TEXT_COLOR_SECONDARY)
                    flair:setBackground(palette.FLAIR_BGCOLOR)
                    flair:setEllipsize("end")
                    flair:setSingleLine()
                    local num_points = Builder:addTextView("num_points")
                    num_points:setLayoutSize("wrap_content", "wrap_content")
                    num_points:setLayoutMarginRight("4dip")
                    num_points:setTextSize(TEXT_SIZE_SMALL)
                    num_points:setTextColor(TEXT_COLOR_SECONDARY)
                    num_points:setSingleLine()
                    num_points:setEllipsize("marquee")
                    local submission_time = Builder:addTextView("submission_time")
                    submission_time:setLayoutSize("wrap_content", "wrap_content")
                    submission_time:setLayoutMarginRight("4dip")
                    submission_time:setTextSize(TEXT_SIZE_SMALL)
                    submission_time:setTextColor(TEXT_COLOR_SECONDARY)
                    submission_time:setSingleLine()
                    submission_time:setEllipsize("marquee")
                    local comment_gild_container = Builder:beginLinearLayout("comment_gild_container")
                    comment_gild_container:setLayoutSize("wrap_content", "wrap_content")
                    comment_gild_container:setOrientation("horizontal")
                    comment_gild_container:setGravity("center_vertical")
                        local comment_gild_icon = Builder:addImageView("comment_gild_icon")
                        comment_gild_icon:setLayoutSize("13dp", "14dp")
                        comment_gild_icon:setLayoutGravity("center")
                        comment_gild_icon:setLayoutMarginRight("1dp")
                        comment_gild_icon:setScaleType("fitCenter")
                        comment_gild_icon:setDrawable("comment_gild.png")

                        local comment_gild_text = Builder:addTextView("comment_gild_text")
                        comment_gild_text:setLayoutSize("wrap_content", "wrap_content")
                        comment_gild_text:setTextColor(TEXT_COLOR_GILDED)
                        comment_gild_text:setTextSize(TEXT_SIZE_GILDED)
                        comment_gild_text:setSingleLine()
                    Builder:endViewGroup()
                Builder:endViewGroup()
    
            Builder:endViewGroup()
    
            local moderator_notes = Builder:addTextView("moderator_notes")
            moderator_notes:setLayoutSize("wrap_content", "wrap_content")
            moderator_notes:setVisibility("gone")
            moderator_notes:setTextSize(TEXT_SIZE_SMALL)
            moderator_notes:setTextColor(TEXT_COLOR_SECONDARY)
            moderator_notes:setTextColor("#ffF88017")
            moderator_notes:setSingleLine()
            local body = Builder:addTextView("body")
            body:setLayoutSize("fill_parent", "wrap_content")
            body:setLayoutMarginRight("5dip")
            body:setBackground(SELECTABLE_ITEM_BACKGROUND)
            body:setOnClick("onListItemClick")
            body:setClickable(true)
            body:setTextSize(TEXT_SIZE_BODY)
            body:setTextColor(TEXT_COLOR_PRIMARY)
            body:setLinksClickable(true)
            body:setHasContextMenu(true)
    
            local comment_actions = Builder:beginLinearLayout("comment_actions")
            comment_actions:setLayoutSize("fill_parent", "wrap_content")
            comment_actions:setLayoutMarginTop("5dp")
            comment_actions:setOrientation("horizontal")
            comment_actions:setVisibility("gone")
            comment_actions:setGravity("center")
                local vote_up_button = Builder:addImageButton("vote_up_button")
                vote_up_button:setLayoutSize("0dp", "48dp")
                vote_up_button:setLayoutWeight(1.000000)
                vote_up_button:setBackground(SELECTABLE_ITEM_BACKGROUND)
                vote_up_button:setPaddingTop("8dp")
                vote_up_button:setPaddingBottom("8dp")
                vote_up_button:setOnClick("voteUp")
                vote_up_button:setOnLongClick(function(v) Toasts:showHintShort("Upvote", v) end)
                vote_up_button:setDrawable("up_arrow_holo_dark.png")
                vote_up_button:setScaleType("fitCenter")
                local vote_down_button = Builder:addImageButton("vote_down_button")
                vote_down_button:setLayoutSize("0dp", "48dp")
                vote_down_button:setLayoutWeight(1.000000)
                vote_down_button:setBackground(SELECTABLE_ITEM_BACKGROUND)
                vote_down_button:setPaddingTop("8dp")
                vote_down_button:setPaddingBottom("8dp")
                vote_down_button:setOnClick("voteDown")
                vote_down_button:setOnLongClick(function(v) Toasts:showHintShort("Downvote", v) end)
                vote_down_button:setDrawable("down_arrow_holo_dark.png")
                vote_down_button:setScaleType("fitCenter")
                local more_actions = Builder:addImageButton("more_actions")
                more_actions:setLayoutSize("0dp", "48dp")
                more_actions:setLayoutWeight(1.000000)
                more_actions:setBackground(SELECTABLE_ITEM_BACKGROUND)
                more_actions:setPaddingTop("8dp")
                more_actions:setPaddingBottom("8dp")
                more_actions:setOnClick("moreActionsComment")
                more_actions:setOnLongClick(function(v) Toasts:showHintShort("More actions", v) end)
                more_actions:setDrawable("ic_menu_moreoverflow_normal_holo_dark.png")
                more_actions:setScaleType("fitCenter")
                local permalink = Builder:addImageButton("permalink")
                permalink:setLayoutSize("0dp", "48dp")
                permalink:setLayoutWeight(1.000000)
                permalink:setBackground(SELECTABLE_ITEM_BACKGROUND)
                permalink:setPaddingTop("8dp")
                permalink:setPaddingBottom("8dp")
                permalink:setOnClick("permalinkComment")
                permalink:setOnLongClick(function(v) Toasts:showHintShort("Permalink", v) end)
                permalink:setDrawable("ic_menu_share_plain_holo_dark.png")
                permalink:setScaleType("fitCenter")
                local reply = Builder:addImageButton("reply")
                reply:setLayoutSize("0dp", "48dp")
                reply:setLayoutWeight(1.000000)
                reply:setBackground(SELECTABLE_ITEM_BACKGROUND)
                reply:setPaddingTop("8dp")
                reply:setPaddingBottom("8dp")
                reply:setOnClick("reply")
                reply:setOnLongClick(function(v) Toasts:showHintShort("Reply", v) end)
                reply:setDrawable("social_reply_holo_dark.png")
                reply:setScaleType("fitCenter")
            Builder:endViewGroup()
    
        Builder:endViewGroup()
    
    Builder:endViewGroup()
    
    Fonts:registerNormal("Roboto", "fonts/Roboto-Regular.ttf")
    Fonts:registerBold("Roboto", "fonts/Roboto-Bold.ttf")
    Fonts:registerItalic("Roboto", "fonts/Roboto-Italic.ttf")
    Fonts:registerBoldItalic("Roboto", "fonts/Roboto-BoldItalic.ttf")
    view1:setTypeface("Roboto")
    
end

---
-- @usage exported
function bindView(Holder, Thing, ListItem)
    local isListItemChecked = ListItem:isChecked()

    local rootContainer = Holder:getView("root_container")
    rootContainer:setBackground(isListItemChecked and palette.CHECKED_BGCOLOR or SELECTABLE_ITEM_BACKGROUND)
    rootContainer:setClickable(not isListItemChecked)
    
    local voteUpButton = Holder:getView("vote_up_button")
    local voteDownButton = Holder:getView("vote_down_button")
    local thingLikes = Thing:getLikes()
    voteUpButton:setDrawable(thingLikes==true and "up_arrow_red.png" or "up_arrow_holo_dark.png")
    voteDownButton:setDrawable(thingLikes==false and "down_arrow_blue.png" or "down_arrow_holo_dark.png")

    local next = Holder:getView("next")
    local prev = Holder:getView("prev")
    local parent = Holder:getView("parent")
    local body = Holder:getView("body")

    -- indentation
    local thingNestingLevel = Thing:getNestingLevel()
    for i = 1,10 do
        Holder:getView("left_indent" .. i):setVisible(thingNestingLevel >= i)
    end
    
    Holder:getView("comment_nav"):setVisible(isListItemChecked)
    Holder:getView("comment_actions"):setVisible(isListItemChecked)
    
    -- nav buttons
    local linkToFullComments = Thing:isLinkToFullComments()
    next:setVisible(thingNestingLevel == 0 and not linkToFullComments)
    prev:setVisible(thingNestingLevel == 0 and not linkToFullComments)
    prev:setEnabled(ListItem:getPosition() > 1)
    parent:setVisible(thingNestingLevel ~= 0 or linkToFullComments)
    parent:setEnabled(Thing:getParent_id():sub(1, 2) == "t1")  -- enable link to parent, if parent is a comment
    Holder:getView("root"):setVisible(thingNestingLevel ~= 0)
    Holder:getView("full_comments"):setVisible(linkToFullComments)
    
    --
    -- comment info
    --
    if Thing:isDeleted() or thingLikes == nil then
        Holder:getView("vote_up_comment_image"):setVisibility("gone")
        Holder:getView("vote_down_comment_image"):setVisibility("gone")
    elseif thingLikes == true then
        Holder:getView("vote_up_comment_image"):setVisibility("visible")
        Holder:getView("vote_down_comment_image"):setVisibility("gone")
    else --if thingLikes == false then
        Holder:getView("vote_up_comment_image"):setVisibility("gone")
        Holder:getView("vote_down_comment_image"):setVisibility("visible")
    end
    
    local submitter = Holder:getView("submitter")
    submitter:setText(Thing:getAuthor())

    local isThingOp = Thing:isOp()
    local isThingModerator = Thing:isModerator()
    local isThingAdmin = Thing:isAdmin()
    local isThingSpecialAdmin = Thing:isSpecialAdmin()
    if isThingOp then
        submitter:setTextColor(TEXT_COLOR_OP)
    elseif isThingModerator then
        submitter:setTextColor(TEXT_COLOR_MODERATOR)
    elseif isThingAdmin then
        submitter:setTextColor(TEXT_COLOR_ADMIN)
    elseif isThingSpecialAdmin then
        submitter:setTextColor(TEXT_COLOR_SPECIAL_ADMIN)
    else
        submitter:setTextColor(TEXT_COLOR_SUBMITTER)
    end
    Holder:getView("submitter_distinguished_op"):setVisible(isThingOp)
    Holder:getView("submitter_distinguished_mod"):setVisible(isThingModerator)
    Holder:getView("submitter_distinguished_admin"):setVisible(isThingAdmin)
    Holder:getView("submitter_distinguished_special"):setVisible(isThingSpecialAdmin)
    
        
    local score = Thing:getUps() - Thing:getDowns()
    if Thing:isScore_hidden() then
        Holder:getView("num_points"):setText("[~] points")
    else
        Holder:getView("num_points"):setText(string.format(score==1 and "%d point" or "%d points", score))
    end
    Holder:getView("submission_time"):setText(Thing:getCreatedTimeAgo())

    local gildedCount = Thing:getGilded()
    Holder:getView("comment_gild_icon"):setVisible(gildedCount > 0)
    if gildedCount > 1 then
        Holder:getView("comment_gild_text"):setText("x" .. gildedCount)
    else
        Holder:getView("comment_gild_text"):setText("")
    end
    
    -- flair
    local flairView = Holder:getView("flair")
    local flair
    local flairText = Thing:getAuthor_flair_text()
    local flairCssClass = Thing:getAuthor_flair_css_class()
    if flairText ~= nil and "" ~= flairText then
        flair = flairText
    elseif (flairCssClass ~= nil and "" ~= flairCssClass) then
        flair = flairCssClass
    else
        flair = nil
    end
    
    if flair ~= nil then
        flairView:setVisible(true)
        flairView:setText(flair)
    else
        flairView:setVisible(false)
    end

    local thingRenderedBody = Thing:getRenderedBody()
    if thingRenderedBody then
        -- TODO catch ArrayIndexOutOfBoundsException
        -- JellyBean bug http://code.google.com/p/android/issues/detail?id=34872
        body:setText(thingRenderedBody)
    else
        body:setText(Thing:getBody())
    end
    body:setMovementMethod("LinkMovementMethod")
end