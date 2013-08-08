-- local aliases for globals
local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL
local TEXT_COLOR_PRIMARY = redditisfun.TEXT_COLOR_PRIMARY
local TEXT_COLOR_SECONDARY = redditisfun.TEXT_COLOR_SECONDARY
local ACTIONBAR_ITEM_BACKGROUND = redditisfun.ACTIONBAR_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts
local Spans = redditisfun.Spans

local shared_state = {}
-- shared state because if the list item scrolls out of view, and you bindView again, it would reset state
shared_state.show_thread_actions = false

-- action strings
local SHARE_TEXT = "share"
local SAVE_TEXT = "save"
local UNSAVE_TEXT = "unsave"
local HIDE_TEXT = "hide"
local UNHIDE_TEXT = "unhide"
local MORE_TEXT = "more"
local COMMENTS_TEXT = "comments"

-- drawables
local DRAWABLE_UNSAVE = "btn_star_on_normal_holo_light.png"
local DRAWABLE_SAVE = "btn_star_off_normal_holo_light.png"
local DRAWABLE_VOTE_UP_GRAY = "vote_up_gray.png"
local DRAWABLE_VOTE_DOWN_GRAY = "vote_down_gray.png"
local DRAWABLE_VOTE_UP_RED = "vote_up_red.png"
local DRAWABLE_VOTE_DOWN_BLUE = "vote_down_blue.png"
local DRAWABLE_SHARE = "ic_menu_share_plain_holo_light.png"
local DRAWABLE_HIDE = "content_remove_holo_light.png"
local DRAWABLE_MORE = "ic_menu_moreoverflow_normal_holo_light.png"
local DRAWABLE_COMMENTS = "social_chat_holo_light.png"
local DRAWABLE_THUMBNAIL_DEFAULT = "thumbnail_default.png"
local DRAWABLE_THUMBNAIL_NSFW = "thumbnail_nsfw.png"
local DRAWABLE_THUMBNAIL_SELF = "thumbnail_self.png"
local DRAWABLE_IMAGE_LINK = "content_picture_holo_light.png"
local DRAWABLE_WEB_LINK = "location_web_site_holo_light.png"

-- http://colllor.com/33b5e5
local CHECKED_BGCOLOR = "#DBF2FA"
local ACTIONS_BGCOLOR = "#B7E5F6"

local CLICKED_BGCOLOR = "#EBEBEB"
--local THUMBNAIL_BGCOLOR = "#DEDEDE"
local THUMBNAIL_BGCOLOR = ""

---
-- @usage exported
function newView(Builder)
	local root = Builder:beginFrameLayout("root")
    root:setLayoutSize("fill_parent", "wrap_content")
	    local view1 = Builder:beginLinearLayout("view1")
	    view1:setLayoutSize("fill_parent", "wrap_content")
	    view1:setLayoutMargin("16dp")
	    view1:setOrientation("vertical")
	    view1:setBackground("#ffffff")
	        local view2 = Builder:addTextView("title")
	        view2:setLayoutSize("fill_parent", "wrap_content")
	        view2:setPaddingLeft("16dp")
	        view2:setPaddingTop("16dp")
	        view2:setPaddingRight("16dp")
	        view2:setText("Title")
	        view2:setTextColor(TEXT_COLOR_PRIMARY)
	        view2:setTextSize("18dp")
	        local view3 = Builder:addTextView("subtitle")
	        view3:setLayoutSize("fill_parent", "wrap_content")
	        view3:setPaddingLeft("16dp")
	        view3:setPaddingRight("16dp")
	        view3:setText("Subtitle")
	        view3:setTextColor(TEXT_COLOR_PRIMARY)
	        view3:setTextSize("14dp")
	        
	        local view4 = Builder:addFitWidthImageView("image")
	        view4:setLayoutSize("fill_parent", "wrap_content")
	        view4:setLayoutMarginTop("16dp")
	        view4:setLayoutMarginBottom("16dp")
	        view4:setAdjustViewBounds(true)
	        view4:setScaleType("fitCenter")
	        local progress = Builder:addProgressBar("image_progress")
	        progress:setLayoutSize("wrap_content", "wrap_content")
	        progress:setLayoutMarginTop("16dp")
	        progress:setLayoutMarginBottom("16dp")
	        progress:setLayoutGravity("center")
	        progress:setIndeterminate()
	        progress:setVisibility("gone")
	    Builder:endLinearLayout()
    Builder:endFrameLayout()
    
    Fonts:registerNormal("Roboto", "fonts/Roboto-Regular.ttf")
    Fonts:registerBold("Roboto", "fonts/Roboto-Bold.ttf")
    Fonts:registerItalic("Roboto", "fonts/Roboto-Italic.ttf")
    Fonts:registerBoldItalic("Roboto", "fonts/Roboto-BoldItalic.ttf")
    view1:setTypeface("Roboto")
end

local function bindTitleAndDomain(textView, Thing)
	local flairBackgroundColor = "#dddddd"
	local flairSize = TEXT_SIZE_SMALL
    local titleColor = (Thing:isClicked() and "#551a8b" or "#0000ff")
	local titleStyle = (Thing:isClicked() and "normal" or "bold")
	local domainColor = "#7f7f7f"
	local domainSize = TEXT_SIZE_SMALL
	
	-- link flair
	local hasFlair = Thing:getLink_flair_text() and "" ~= Thing:getLink_flair_text()
	local flairBuilder
	if hasFlair then
		flairBuilder = Spans:addSize(Thing:getLink_flair_text(), flairSize)
		flairBuilder = Spans:addBackgroundColor(flairBuilder, flairBackgroundColor)
	else
		flairBuilder = Spans:builder()  -- empty SpannableStringBuilder
	end
    
    -- title
    local titleBuilder = Spans:addColor(Thing:getTitle(), titleColor)
    titleBuilder = Spans:addStyle(titleBuilder, titleStyle)
    
    -- domain
	local domainBuilder = Spans:addColor("(" .. Thing:getDomain() .. ")", domainColor)
	domainBuilder = Spans:addSize(domainBuilder, domainSize)
	
	-- combine
	textView:setText(flairBuilder:append(hasFlair and " " or ""):append(titleBuilder):append(" "):append(domainBuilder))
end

local function getDefaultThumbnail(thumbnailUrl)
	if not thumbnailUrl then
		return nil
	elseif thumbnailUrl:sub(-7) == "default" then
		return DRAWABLE_THUMBNAIL_DEFAULT
	elseif thumbnailUrl:sub(-4) == "nsfw" then
		return DRAWABLE_THUMBNAIL_NSFW
	elseif thumbnailUrl:sub(-4) == "self" then
		return DRAWABLE_THUMBNAIL_SELF
	end
end

---
-- schedules a layout pass to set the vertical offset of the list item
local function offsetTop(ListItem)
	ListItem:setTop(ListItem:getTop())
end

---
-- get the label text for image links
local function getImageLabelText(urlLower)
	local last4 = urlLower:sub(-4)
	if last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
		return last4:sub(2)
	elseif urlLower:sub(-5) == ".jpeg" then
		return "jpg"
	elseif urlLower:sub(1, 17) == "http://imgur.com/" or urlLower:sub(1, 19) == "http://i.imgur.com/" then
		return "imgur"
	else
		return nil
	end
end

---
-- get the label text for image links
local function getImageUrl(url)
	local urlLower = url:lower()
	local last4 = urlLower:sub(-4)
	if last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
		return url
	elseif urlLower:sub(-5) == ".jpeg" then
		return url
	elseif urlLower:sub(1, 19) == "http://i.imgur.com/" then
		return "imgur"
	elseif urlLower:sub(1, 19) == "http://imgur.com/a/" then
		return nil
	elseif urlLower:sub(1, 25) == "http://imgur.com/gallery/" then
		return nil
	elseif urlLower:sub(1, 17) == "http://imgur.com/" then
		return url .. ".jpg"
	else
		return nil
	end
end

function bindView(Holder, Thing, ListItem)
	local imageView = Holder:getView("image")
	local imageProgress = Holder:getView("image_progress")

	local imageUrl = getImageUrl(Thing:getUrl())
	if imageUrl then
		imageView:displayImageWithProgress(imageUrl, imageProgress)
	else
		imageView:displayImageWithProgress(Thing:getThumbnail(), imageProgress)
	end
end

---
-- @usage exported
function oldbindView(Holder, Thing, ListItem)
    -- set click data for clickable elements that delegate to Java
    Holder:getView("vote_up_button"):setClickData(Thing)
    Holder:getView("vote_down_button"):setClickData(Thing)
    Holder:getView("thread_info_layout"):setClickData(Thing)
    local thumbnail_frame = Holder:getView("thumbnail_frame")
    thumbnail_frame:setClickData(Thing)
    Holder:getView("share"):setClickData(Thing)
    Holder:getView("save"):setClickData(Thing)
    Holder:getView("hide"):setClickData(Thing)
    Holder:getView("more_actions"):setClickData(Thing)
    Holder:getView("comments"):setClickData(Thing)
    
    bindTitleAndDomain(Holder:getView("title"), Thing)
    
    -- votes
    local votes = Holder:getView("votes")
    local upArrow = Holder:getView("vote_up_image")
    local downArrow = Holder:getView("vote_down_image")
    votes:setText(tostring(Thing:getScore()));
    if Thing:getLikes() == true then
    	local colorArrowRed = "#ffff8b60"
    	votes:setTextColor(colorArrowRed)
    	upArrow:setDrawable(DRAWABLE_VOTE_UP_RED)
    	downArrow:setDrawable(DRAWABLE_VOTE_DOWN_GRAY)
	elseif Thing:getLikes() == false then
		local colorArrowBlue = "#ff9494ff"
		votes:setTextColor(colorArrowBlue)
		upArrow:setDrawable(DRAWABLE_VOTE_UP_GRAY)
		downArrow:setDrawable(DRAWABLE_VOTE_DOWN_BLUE)
	else -- Thing:getLikes() == nil
		local colorArrowGray = "#ffc0c0c0"
		votes:setTextColor(colorArrowGray)
	    upArrow:setDrawable(DRAWABLE_VOTE_UP_GRAY)
	    downArrow:setDrawable(DRAWABLE_VOTE_DOWN_GRAY)
	end
	
	local num_reports = Holder:getView("num_reports")
	local hasReports = Thing:getNum_reports() ~= nil and Thing:getNum_reports() > 0
	num_reports:setVisible(hasReports)
	if hasReports then
		num_reports:setText(string.format(Thing:getNum_reports()==1 and "%d report" or "%d reports", Thing:getNum_reports()))
	end
	
	Holder:getView("nsfw"):setVisible(Thing:isOver_18())
	Holder:getView("num_comments"):setText(string.format(Thing:getNum_comments()==1 and "%d comment" or "%d comments", Thing:getNum_comments()))
	Holder:getView("subreddit"):setText(Thing:getSubreddit())
	Holder:getView("submission_time"):setText(Thing:getCreatedTimeAgo())
	Holder:getView("submitter"):setText("by "..Thing:getAuthor())
	Holder:getView("submitter_distinguished_mod"):setVisible(Thing:isModerator())
	Holder:getView("submitter_distinguished_admin"):setVisible(Thing:isAdmin())
	Holder:getView("submitter_distinguished_special"):setVisible(Thing:isSpecialAdmin())
	
	-- thumbnail
	local thumbnail = Holder:getView("thumbnail_image")
	local thumbnail_icon_frame = Holder:getView("thumbnail_icon_frame")
	local thumbnail_icon = Holder:getView("thumbnail_icon")
	local thumbnail_icon_label = Holder:getView("thumbnail_icon_label")
	local thumbnail_progress = Holder:getView("thumbnail_progress")
	local defaultThumbnail = getDefaultThumbnail(Thing:getThumbnail())
	if defaultThumbnail then
		thumbnail:setVisibility("visible")
		thumbnail_icon_frame:setVisibility("gone")
		thumbnail:setDrawable(defaultThumbnail)
	elseif Thing:getThumbnail() == "" then
		if Thing:isIs_self() then
			thumbnail:setVisibility("visible")
			thumbnail_icon_frame:setVisibility("gone")
			thumbnail:setDrawable(DRAWABLE_THUMBNAIL_SELF)
		else	
			thumbnail:setVisibility("gone")
			thumbnail_icon_frame:setVisibility("visible")
			local urlLower = Thing:getUrl():lower()
			local imageLabelText = getImageLabelText(urlLower)
			if imageLabelText then
				thumbnail_icon:setDrawable(DRAWABLE_IMAGE_LINK)
				thumbnail_icon_label:setVisibility("visible")
				thumbnail_icon_label:setText(imageLabelText)
			else
				thumbnail_icon:setDrawable(DRAWABLE_WEB_LINK)
				
				local isReddit =
					urlLower:sub(1, 18) == "http://reddit.com/" or
					urlLower:sub(1, 15) == "http://redd.it/" or
					urlLower:find("http://[^./]+%.reddit%.com/") ~= nil
				
				if isReddit then
					thumbnail_icon_label:setVisibility("visible")
					thumbnail_icon_label:setText("reddit")
				else					
					thumbnail_icon_label:setVisibility("gone")
				end
			end
		end
	else
		thumbnail_icon_frame:setVisibility("gone")
		-- displayImageWithProgress will handle visibility of thumbnail and thumbnail_progress
		thumbnail:displayImageWithProgress(Thing:getThumbnail(), thumbnail_progress)
	end
	
	local thread_actions = Holder:getView("thread_actions")
	
	thumbnail_frame:setOnClick(function(v)
		-- hide the actions, then delegate to reddit-is-fun built-in method "clickThumbnail"
		if shared_state.show_thread_actions then
			thread_actions:collapseVertical(EXPAND_ANIMATION_DURATION_MILLIS)
		end
		shared_state.show_thread_actions = false
		v:onClick("clickThumbnail")
		offsetTop(ListItem)
	end)
	
	--
	-- actions
	--
	
	thread_actions:setVisible(ListItem:isChecked() and shared_state.show_thread_actions)
	
--	OnClick:setOnClick(Holder:getView("thread_info_layout"), function(v)
	Holder:getView("thread_info_layout"):setOnClick(function(v)
		if ListItem:isChecked() then
			-- keep it checked (like a temp bookmark) but toggle actions visibility
			shared_state.show_thread_actions = not shared_state.show_thread_actions
			if shared_state.show_thread_actions then
				thread_actions:expandVertical(EXPAND_ANIMATION_DURATION_MILLIS)
			else
				thread_actions:collapseVertical(EXPAND_ANIMATION_DURATION_MILLIS)
			end
		else
			-- not checked; check it
			if not shared_state.show_thread_actions then
				-- show actions. animate only if not already showing on another list item
				shared_state.show_thread_actions = true
				thread_actions:expandVertical(EXPAND_ANIMATION_DURATION_MILLIS)
			else
				-- if already showing on another list item, skip animation to avoid jarring visual effect
				thread_actions:expandVertical(0)
			end
			ListItem:toggleChecked()
			offsetTop(ListItem)
		end
	end)
	
	if ListItem:isChecked() then
		Holder:getView("root"):setBackground(CHECKED_BGCOLOR)
		
		if Thing:isSaved() then
			Holder:getView("save_image"):setDrawable(DRAWABLE_UNSAVE)
			Holder:getView("save_text"):setText(UNSAVE_TEXT)
		else
			Holder:getView("save_image"):setDrawable(DRAWABLE_SAVE)
			Holder:getView("save_text"):setText(SAVE_TEXT)
		end
		
		if Thing:isHidden() then
			Holder:getView("hide_text"):setText(UNHIDE_TEXT)
		else
			Holder:getView("hide_text"):setText(HIDE_TEXT)
		end
	else
		if Thing:isClicked() then
			Holder:getView("root"):setBackground(CLICKED_BGCOLOR)
		else
			Holder:getView("root"):setBackground("#ffffff")
		end
	end
end

