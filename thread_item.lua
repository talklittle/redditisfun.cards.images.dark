-- local aliases for globals
local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL
local TEXT_COLOR_PRIMARY = redditisfun.TEXT_COLOR_PRIMARY
local TEXT_COLOR_SECONDARY = redditisfun.TEXT_COLOR_SECONDARY
local ACTIONBAR_ITEM_BACKGROUND = redditisfun.ACTIONBAR_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts
local Spans = redditisfun.Spans
local Toasts = redditisfun.Toasts
local SWIPE_MODE_BOTH = redditisfun.SWIPE_MODE_BOTH

-- drawables
local DRAWABLE_UNSAVE = "btn_star_on_normal_holo_light.png"
local DRAWABLE_SAVE = "btn_star_off_normal_holo_light.png"
local DRAWABLE_VOTE_UP_GRAY = "up_arrow_holo_light.png"
local DRAWABLE_VOTE_DOWN_GRAY = "down_arrow_holo_light.png"
local DRAWABLE_VOTE_UP_RED = "up_arrow_red.png"
local DRAWABLE_VOTE_DOWN_BLUE = "down_arrow_blue.png"
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
	    view1:setLayoutMargins("16dp", "8dp", "16dp", "8dp")
	    view1:setOrientation("vertical")
	    view1:setBackground("cardborder.9.png")
	    view1:setPadding("1")
	    
	    	local click_thread_frame = Builder:beginFrameLayout("click_thread_frame")
	    	click_thread_frame:setLayoutSize("fill_parent", "wrap_content")
	    	click_thread_frame:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	    	click_thread_frame:setClickable(true)
		    click_thread_frame:setOnClick("clickThumbnail")
	    	
			    local click_thread_contents = Builder:beginLinearLayout("click_thread_contents")
			    click_thread_contents:setLayoutSize("fill_parent", "wrap_content")
			    click_thread_contents:setOrientation("vertical")
	    
			        local view2 = Builder:addTextView("title")
			        view2:setLayoutSize("fill_parent", "wrap_content")
			        view2:setPaddingLeft("16dp")
			        view2:setPaddingTop("16dp")
			        view2:setPaddingRight("16dp")
			        view2:setText("Title")
			        view2:setTextColor(TEXT_COLOR_PRIMARY)
			        view2:setTextSize("18sp")
			        
			        local subtitle_row = Builder:beginLinearLayout("subtitle_row")
			        subtitle_row:setLayoutSize("fill_parent", "wrap_content")
			        subtitle_row:setLayoutMarginLeft("16dp")
			        subtitle_row:setLayoutMarginRight("16dp")
			        subtitle_row:setOrientation("horizontal")

				        local votes = Builder:addTextView("votes")
				        votes:setLayoutSize("wrap_content", "wrap_content")
				        votes:setText("9999 points")
				        votes:setTextColor(TEXT_COLOR_PRIMARY)
				        votes:setTextSize("14sp")
				        
				        local and_text = Builder:addTextView("and_text")
				        and_text:setLayoutSize("wrap_content", "wrap_content")
				        and_text:setText(" and ")
				        and_text:setTextColor(TEXT_COLOR_PRIMARY)
				        and_text:setTextSize("14sp")
				        
				        local num_comments = Builder:addTextView("num_comments")
				        num_comments:setLayoutSize("wrap_content", "wrap_content")
				        num_comments:setText("10000 comments")
				        num_comments:setTextColor(TEXT_COLOR_PRIMARY)
				        num_comments:setTextSize("14sp")
				        
			        Builder:endLinearLayout()
			        
			        local more_info_row = Builder:beginLinearLayout("more_info_row")
			        more_info_row:setLayoutSize("fill_parent", "wrap_content")
			        more_info_row:setLayoutMarginLeft("16dp")
			        more_info_row:setLayoutMarginBottom("8dp")
			        more_info_row:setOrientation("horizontal")

				        local domain = Builder:addTextView("domain")
				        domain:setLayoutSize("0dp", "wrap_content")
				        domain:setLayoutWeight(1.0)
				        domain:setText("reddit.com")
				        domain:setTextColor("#b6b6b6")
				        domain:setTextSize("14sp")
				        domain:setSingleLine(true)
				        domain:setEllipsize("end")
				        
				        local view3 = Builder:addTextView("subreddit")
				        view3:setLayoutSize("wrap_content", "wrap_content")
				        view3:setBackground("#eeeeee")
				        view3:setText("aww")
				        view3:setTextColor(TEXT_COLOR_PRIMARY)
				        view3:setTextSize("14sp")
				        view3:setPaddingLeft("4dp")
				        view3:setPaddingRight("4dp")
				        
			        Builder:endLinearLayout()
			        
			        local image_frame = Builder:beginFrameLayout("image_frame")
			        image_frame:setLayoutSize("fill_parent", "wrap_content")
				        local view4 = Builder:addFitWidthImageView("image")
				        view4:setLayoutSize("fill_parent", "wrap_content")
				        view4:setLayoutGravity("center")
				        view4:setAdjustViewBounds(true)
				        view4:setScaleType("fitCenter")
				        view4:setVisibility("invisible")
				        
				        local progress = Builder:addProgressBar("image_progress")
				        progress:setLayoutSize("wrap_content", "wrap_content")
				        progress:setLayoutGravity("center")
				        progress:setIndeterminate(true)
				        progress:setVisibility("gone")
				        progress:setPaddingBottom("16dp")
				        
				        local nsfw = Builder:addImageView("nsfw")
				        nsfw:setLayoutSize("70dp", "70dp")
				        nsfw:setLayoutGravity("center")
				        nsfw:setDrawable(DRAWABLE_THUMBNAIL_NSFW)
				        nsfw:setScaleType("fitCenter")
			        Builder:endFrameLayout()
		        Builder:endLinearLayout()
	        Builder:endFrameLayout()
	        
	        local thread_actions = Builder:beginLinearLayout("thread_actions")
	        thread_actions:setLayoutSize("fill_parent", "wrap_content")
	        thread_actions:setBackground("#dddddd")
	        thread_actions:setOrientation("horizontal")
	        thread_actions:setGravity("center")
	            local vote_up_button = Builder:addImageButton("vote_up_button")
	            vote_up_button:setLayoutSize("0dp", "48dp")
	            vote_up_button:setLayoutWeight(1.000000)
	            vote_up_button:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	            vote_up_button:setOnClick("voteUp")
	            vote_up_button:setOnLongClick(function(v) Toasts:showHintShort("Upvote", v) end)
	            vote_up_button:setDrawable("up_arrow_holo_light.png")
		        vote_up_button:setPaddingTop("8dp")
		        vote_up_button:setPaddingBottom("8dp")
	            vote_up_button:setScaleType("fitCenter")
	            local vote_down_button = Builder:addImageButton("vote_down_button")
	            vote_down_button:setLayoutSize("0dp", "48dp")
	            vote_down_button:setLayoutWeight(1.000000)
	            vote_down_button:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	            vote_down_button:setOnClick("voteDown")
	            vote_down_button:setOnLongClick(function(v) Toasts:showHintShort("Downvote", v) end)
	            vote_down_button:setDrawable("down_arrow_holo_light.png")
		        vote_down_button:setPaddingTop("8dp")
		        vote_down_button:setPaddingBottom("8dp")
	            vote_down_button:setScaleType("fitCenter")
	            local share = Builder:addImageButton("share")
	            share:setLayoutSize("0dp", "48dp")
	            share:setLayoutWeight(1.000000)
	            share:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	            share:setOnClick("shareThread")
	            share:setOnLongClick(function(v) Toasts:showHintShort("Share", v) end)
	            share:setDrawable("ic_menu_share_plain_holo_light.png")
		        share:setPaddingTop("8dp")
		        share:setPaddingBottom("8dp")
	            share:setScaleType("fitCenter")
	            local save = Builder:addImageButton("save")
	            save:setLayoutSize("0dp", "48dp")
	            save:setLayoutWeight(1.000000)
	            save:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	            save:setOnClick("saveThread")
	            save:setOnLongClick(function(v) Toasts:showHintShort("Save/unsave", v) end)
	            save:setDrawable(DRAWABLE_SAVE)
		        save:setPaddingTop("8dp")
		        save:setPaddingBottom("8dp")
	            save:setScaleType("fitCenter")
	            local comments = Builder:addImageButton("comments")
	            comments:setLayoutSize("0dp", "48dp")
	            comments:setLayoutWeight(1.000000)
	            comments:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	            comments:setOnClick("openComments")
	            comments:setOnLongClick(function(v) Toasts:showHintShort("Comments", v) end)
	            comments:setDrawable("social_chat_holo_light.png")
		        comments:setPaddingTop("8dp")
		        comments:setPaddingBottom("8dp")
	            comments:setScaleType("fitCenter")
	            local more_actions = Builder:addImageButton("more_actions")
	            more_actions:setLayoutSize("0dp", "48dp")
	            more_actions:setLayoutWeight(0.5)
	            more_actions:setBackground(ACTIONBAR_ITEM_BACKGROUND)
	            more_actions:setOnClick("moreActionsThread")
	            more_actions:setOnLongClick(function(v) Toasts:showHintShort("More actions", v) end)
	            more_actions:setDrawable("ic_menu_moreoverflow_normal_holo_light.png")
		        more_actions:setPaddingTop("8dp")
		        more_actions:setPaddingBottom("8dp")
	            more_actions:setScaleType("fitCenter")
	        Builder:endViewGroup()
	        
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

---
-- get the label text for image links
local function getImageUrl(url)
	local urlLower = url:lower()
	local last4 = urlLower:sub(-4)
	if urlLower:sub(1, 19) == "http://i.imgur.com/" then
		if last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
			return url:sub(1, url:len() - 4) .. "l" .. last4
		else
			local last5 = urlLower:sub(-5)
			if last5 == ".jpeg" then
				return url:sub(1, url:len() - 5) .. "l" .. last5
			end
		end
		return url .. "l.jpg"
	elseif urlLower:sub(1, 19) == "http://imgur.com/a/" then
		return url
	elseif urlLower:sub(1, 25) == "http://imgur.com/gallery/" then
		return nil
	elseif urlLower:sub(1, 17) == "http://imgur.com/" then
		if last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
			return url:sub(1, url:len() - 4) .. "l" .. last4
		else
			local last5 = urlLower:sub(-5)
			if last5 == ".jpeg" then
				return url:sub(1, url:len() - 5) .. "l" .. last5
			end
		end
		return url .. "l.jpg"
	elseif last4 == ".jpg" or last4 == ".gif" or last4 == ".png" then
		return url
	elseif urlLower:sub(-5) == ".jpeg" then
		return url
	else
		return nil
	end
end

function bindView(Holder, Thing, ListItem)
	local title = Holder:getView("title")
	local subreddit = Holder:getView("subreddit")
	local domain = Holder:getView("domain")
    local numComments = Holder:getView("num_comments")
    local clickThreadView = Holder:getView("click_thread_frame")
    local voteUpButton = Holder:getView("vote_up_button")
    local voteDownButton = Holder:getView("vote_down_button")
    local comments = Holder:getView("comments")
    local nsfw = Holder:getView("nsfw")
    local share = Holder:getView("share")
    local save = Holder:getView("save")
    local moreActions = Holder:getView("more_actions")
	
    -- set click data for clickable elements that delegate to Java
    voteUpButton:setClickData(Thing)
    voteDownButton:setClickData(Thing)
    clickThreadView:setClickData(Thing)
    share:setClickData(Thing)
    moreActions:setClickData(Thing)
    save:setClickData(Thing)
    comments:setClickData(Thing)
    -- TODO
--    Holder:getView("hide"):setClickData(Thing)
	
	title:setText(Thing:getTitle())
	title:setTextStyle(Thing:isClicked() and "normal" or "bold")
	subreddit:setText(Thing:getSubreddit())
	if Thing:isIs_self() then
		domain:setText("self")
	elseif Thing:getUrl():sub(1, 19) == "http://imgur.com/a/" then
		domain:setText("imgur album")
	else
		domain:setText(Thing:getDomain())
	end

	local imageView = Holder:getView("image")
	local imageProgress = Holder:getView("image_progress")

	if Thing:isOver_18() and not ListItem:isBrowsingOver18Subreddit() then
		nsfw:setVisibility("visible")
		imageView:cancelDisplayImage()
		imageView:setVisibility("gone")
	else
		nsfw:setVisibility("gone")
		local imageUrl = getImageUrl(Thing:getUrl())
		if imageUrl then
			if imageUrl ~= imageView:getTag("currentUrl") then
				imageView:displayImageWithProgress(imageUrl, imageProgress)
				imageView:setTag("currentUrl", imageUrl)
			end
		else
			imageView:cancelDisplayImage()
			imageView:setVisibility("gone")
			imageProgress:setVisibility("gone")
		end
	end
	
    -- votes
    local votes = Holder:getView("votes")
    votes:setText(string.format(Thing:getScore()==1 and "%d point" or "%d points", Thing:getScore()))
    if Thing:getLikes() == true then
    	local colorArrowRed = "#ffff8b60"
    	votes:setTextColor(colorArrowRed)
    	voteUpButton:setDrawable(DRAWABLE_VOTE_UP_RED)
    	voteDownButton:setDrawable(DRAWABLE_VOTE_DOWN_GRAY)
	elseif Thing:getLikes() == false then
		local colorArrowBlue = "#ff9494ff"
		votes:setTextColor(colorArrowBlue)
		voteUpButton:setDrawable(DRAWABLE_VOTE_UP_GRAY)
		voteDownButton:setDrawable(DRAWABLE_VOTE_DOWN_BLUE)
	else -- Thing:getLikes() == nil
		votes:setTextColor(TEXT_COLOR_PRIMARY)
	    voteUpButton:setDrawable(DRAWABLE_VOTE_UP_GRAY)
	    voteDownButton:setDrawable(DRAWABLE_VOTE_DOWN_GRAY)
	end
	
	-- num comments
	numComments:setText(string.format(Thing:getNum_comments()==1 and "%d comment" or "%d comments", Thing:getNum_comments()))
	
	-- save/unsave
	if Thing:isSaved() then
		save:setDrawable(DRAWABLE_UNSAVE)
	else
		save:setDrawable(DRAWABLE_SAVE)
	end
end

---
-- @usage exported
function onChangeSwipeMode(Thing)
	return SWIPE_MODE_BOTH
end

---
-- @usage exported
function onDismiss(Thing)
	-- TODO
end
