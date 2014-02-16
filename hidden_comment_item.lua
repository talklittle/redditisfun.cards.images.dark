local commentmodule = require "commentmodule"
local palette = require "palette"

-- local aliases for globals
local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL

local TEXT_COLOR_SECONDARY     = redditisfun.TEXT_COLOR_SECONDARY
local TEXT_COLOR_SUBMITTER     = "#888888"
local TEXT_COLOR_OP            = palette.TEXT_COLOR_OP
local TEXT_COLOR_MODERATOR     = "#ff228822"
local TEXT_COLOR_ADMIN         = "#ffff0011"
local TEXT_COLOR_SPECIAL_ADMIN = "#BE1337"

local TEXT_SIZE_BODY = TEXT_SIZE_SMALL * 1.1

local SELECTABLE_ITEM_BACKGROUND = redditisfun.SELECTABLE_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts
local Toasts = redditisfun.Toasts

---
-- @usage exported
function newView(Builder)
	local view1 = Builder:beginLinearLayout("root_container")
	view1:setLayoutSize("fill_parent", "wrap_content")
	view1:setOrientation("horizontal")
	view1:setBackground(SELECTABLE_ITEM_BACKGROUND)
        for i = 1,8 do
            commentmodule.addIndent(Builder, "left_indent"..i)
        end

	    local view2 = Builder:beginLinearLayout("view2")
	    view2:setLayoutSize("0dp", "wrap_content")
	    view2:setLayoutWeight(1.000000)
	    view2:setOrientation("horizontal")
	    view2:setPadding("5dp", "8dp", "5dp", "8dp")

            local submitter = commentmodule.addSubmitterWithTags(Builder)
            submitter.submitter:setTextStyle("italic")
            submitter.op:setTextStyle("italic")
            submitter.mod:setTextStyle("italic")
            submitter.admin:setTextStyle("italic")
            submitter.special:setTextStyle("italic")

            local view17 = Builder:beginLinearLayout("view17")
            view17:setLayoutSize("wrap_content", "wrap_content")
            view17:setOrientation("horizontal")
                local flair = Builder:addTextView("flair")
                flair:setLayoutSize("0dp", "wrap_content")
                flair:setLayoutWeight(1.000000)
                flair:setLayoutMarginRight("5dip")
                flair:setVisibility("gone")
                flair:setTextSize(TEXT_SIZE_SMALL)
                flair:setTextColor(TEXT_COLOR_SECONDARY)
                flair:setTextStyle("italic")
                flair:setSingleLine()
                local num_points = Builder:addTextView("num_points")
                num_points:setLayoutSize("wrap_content", "wrap_content")
                num_points:setLayoutMarginRight("4dip")
                num_points:setTextSize(TEXT_SIZE_SMALL)
                num_points:setTextColor(TEXT_COLOR_SECONDARY)
                num_points:setTextStyle("italic")
                num_points:setSingleLine()
                num_points:setEllipsize("marquee")
                local submission_time = Builder:addTextView("submission_time")
                submission_time:setLayoutSize("wrap_content", "wrap_content")
                submission_time:setLayoutMarginRight("4dip")
                submission_time:setTextSize(TEXT_SIZE_SMALL)
                submission_time:setTextColor(TEXT_COLOR_SECONDARY)
                submission_time:setTextStyle("italic")
                submission_time:setSingleLine()
                submission_time:setEllipsize("marquee")
                local comment_hidden = Builder:addTextView("comment_hidden")
                comment_hidden:setLayoutSize("wrap_content", "wrap_content")
                comment_hidden:setText("[+]")
                comment_hidden:setTextSize(TEXT_SIZE_SMALL)
                comment_hidden:setTextColor(TEXT_COLOR_SECONDARY)
                comment_hidden:setTextStyle("bold")
                comment_hidden:setSingleLine()
                comment_hidden:setEllipsize("marquee")
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
	-- indentation
    local thingNestingLevel = Thing:getNestingLevel()
	for i = 1,8 do
	    Holder:getView("left_indent" .. i):setVisible(thingNestingLevel >= i)
	end
	
	--
	-- comment info
	--
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
	--Holder:getView("comment_gild"):setVisible(Thing:getGilded() > 0)
end