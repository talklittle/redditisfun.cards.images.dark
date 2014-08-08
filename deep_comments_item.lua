local commentmodule = require "commentmodule"

-- local aliases for globals
--local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
--local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL

--local TEXT_COLOR_SECONDARY     = redditisfun.TEXT_COLOR_SECONDARY
local TEXT_COLOR_MORE_COMMENTS = "#ff268bd2"

local SELECTABLE_ITEM_BACKGROUND = redditisfun.SELECTABLE_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts

---
-- @usage exported
function newView(Builder)
	local view1 = Builder:beginLinearLayout("root_container")
	view1:setLayoutSize("fill_parent", "wrap_content")
	view1:setOrientation("horizontal")
	view1:setBackground(SELECTABLE_ITEM_BACKGROUND)
        for i = 1,10 do
            commentmodule.addIndent(Builder, "left_indent"..i)
        end

	    local view2 = Builder:beginLinearLayout("view2")
	    view2:setLayoutSize("match_parent", "wrap_content")
	    view2:setOrientation("horizontal")
	    view2:setPadding("6dp", "8dp", "6dp", "8dp")
	
	        local deep_comments_text = Builder:addTextView("deep_comments_text")
	        deep_comments_text:setLayoutSize("wrap_content", "wrap_content")
	        deep_comments_text:setText("continue this thread →")
	        deep_comments_text:setTextSize(TEXT_SIZE_SMALL)
	        deep_comments_text:setTextColor(TEXT_COLOR_MORE_COMMENTS)
	        deep_comments_text:setTextStyle("bold")
	        deep_comments_text:setSingleLine()

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
	for i = 1,10 do
	    Holder:getView("left_indent" .. i):setVisible(thingNestingLevel >= i)
	end
end