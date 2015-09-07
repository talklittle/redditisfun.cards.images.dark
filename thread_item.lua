-- local aliases for globals
local TEXT_SIZE_LARGE = redditisfun.TEXT_SIZE_LARGE
local TEXT_SIZE_MEDIUM = redditisfun.TEXT_SIZE_MEDIUM
local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL
local TEXT_COLOR_PRIMARY = redditisfun.TEXT_COLOR_PRIMARY
local TEXT_COLOR_SECONDARY = redditisfun.TEXT_COLOR_SECONDARY
local SELECTABLE_ITEM_BACKGROUND = redditisfun.SELECTABLE_ITEM_BACKGROUND
local Fonts = redditisfun.Fonts
local Spans = redditisfun.Spans
local Toasts = redditisfun.Toasts
local SWIPE_MODE_BOTH = redditisfun.SWIPE_MODE_BOTH

local MATCH_PARENT = "-1"  -- string for backwards compatibility app v3.7.1 and earlier
local WRAP_CONTENT = "-2"  -- string for backwards compatibility app v3.7.1 and earlier

-- drawables
local DRAWABLE_UNSAVE = "btn_star_on_normal_holo_dark.png"
local DRAWABLE_SAVE = "btn_star_off_normal_holo_dark.png"
local DRAWABLE_VOTE_UP_GRAY = "up_arrow_holo_dark.png"
local DRAWABLE_VOTE_DOWN_GRAY = "down_arrow_holo_dark.png"
local DRAWABLE_VOTE_UP_RED = "up_arrow_red.png"
local DRAWABLE_VOTE_DOWN_BLUE = "down_arrow_blue.png"
local DRAWABLE_SHARE = "ic_menu_share_plain_holo_dark.png"
local DRAWABLE_HIDE = "content_remove_holo_dark.png"
local DRAWABLE_MORE = "ic_menu_moreoverflow_normal_holo_dark.png"
local DRAWABLE_COMMENTS = "social_chat_holo_dark.png"
local DRAWABLE_THUMBNAIL_DEFAULT = "thumbnail_default.png"
local DRAWABLE_THUMBNAIL_NSFW = "thumbnail_nsfw.png"
local DRAWABLE_THUMBNAIL_SELF = "thumbnail_self.png"
local DRAWABLE_IMAGE_LINK = "content_picture_holo_dark.png"
local DRAWABLE_WEB_LINK = "location_web_site_holo_dark.png"

local thumbnails = require "thumbnails"

---
-- @usage exported
function newView(Builder)
	local root = Builder:beginFrameLayout("root")
    root:setLayoutSize("fill_parent", "wrap_content")
    	local backview = Builder:beginFrameLayout("swipelist_backview")
    	backview:setLayoutSize("fill_parent", "wrap_content")
    	Builder:endFrameLayout()
    	
    	local frontview_bg = Builder:beginFrameLayout("frontview_bg")
	    frontview_bg:setLayoutSize("fill_parent", "wrap_content")
	    frontview_bg:setLayoutMargins("16dp", "8dp", "16dp", "8dp")
	    frontview_bg:setBackground("#404040")
	    frontview_bg:setPadding("1")
    
		    local view1 = Builder:beginLinearLayout("swipelist_frontview")
		    view1:setLayoutSize("fill_parent", "wrap_content")
		    view1:setOrientation("vertical")
		    view1:setBackground("#2f2f2f")
		    
		    	local click_thread_frame = Builder:beginFrameLayout("click_thread_frame")
		    	click_thread_frame:setLayoutSize("fill_parent", "wrap_content")
		    	click_thread_frame:setBackground(SELECTABLE_ITEM_BACKGROUND)
		    	click_thread_frame:setClickable(true)
			    click_thread_frame:setOnClick("clickThumbnail")
		    	
				    local click_thread_contents = Builder:beginLinearLayout("click_thread_contents")
				    click_thread_contents:setLayoutSize("fill_parent", "wrap_content")
				    click_thread_contents:setOrientation("vertical")
                    click_thread_contents:setPaddingTop("16dp")

                        local link_flair = Builder:addTextView("link_flair")
                        link_flair:setLayoutSize("wrap_content", "wrap_content")
                        link_flair:setPaddingLeft("16dp")
                        link_flair:setPaddingRight("16dp")
                        link_flair:setTextColor("#707070")
                        link_flair:setTextSize("14sp")
                        link_flair:setSingleLine(true)
                        link_flair:setEllipsize("end")
                        link_flair:setVisibility("gone")

				        local view2 = Builder:addTextView("title")
				        view2:setLayoutSize("fill_parent", "wrap_content")
				        view2:setPaddingLeft("16dp")
				        view2:setPaddingRight("16dp")
				        view2:setText("Title")
				        view2:setTextColor(TEXT_COLOR_PRIMARY)
				        view2:setTextSize("18sp")
				        
				        local subtitle_row = Builder:beginLinearLayout("subtitle_row")
				        subtitle_row:setLayoutSize("fill_parent", "wrap_content")
				        subtitle_row:setLayoutMarginLeft("16dp")
				        subtitle_row:setOrientation("horizontal")
                        subtitle_row:setGravity("center_vertical")
	
					        local votes = Builder:addTextView("votes")
					        votes:setLayoutSize("wrap_content", "wrap_content")
					        votes:setText("9999 points")
					        votes:setTextColor(TEXT_COLOR_SECONDARY)
					        votes:setTextSize("14sp")
					        
					        local and_text = Builder:addTextView("and_text")
					        and_text:setLayoutSize("wrap_content", "wrap_content")
					        and_text:setText(" · ")
					        and_text:setTextColor(TEXT_COLOR_SECONDARY)
					        and_text:setTextSize("14sp")
					        
					        local num_comments = Builder:addTextView("num_comments")
					        num_comments:setLayoutSize("wrap_content", "wrap_content")
					        num_comments:setText("10000 comments")
					        num_comments:setTextColor(TEXT_COLOR_SECONDARY)
					        num_comments:setTextSize("14sp")

                            local and_text2 = Builder:addTextView("and_text2")
                            and_text2:setLayoutSize("0dp", "wrap_content")
                            and_text2:setLayoutWeight(1.0)

                            local clock_symbol = Builder:addTextView("clock_symbol")
                            clock_symbol:setLayoutSize("wrap_content", "wrap_content")
                            clock_symbol:setTextColor(TEXT_COLOR_SECONDARY)
                            clock_symbol:setTextSize("11sp")
                            clock_symbol:setText("⌚")

                            local submission_time = Builder:addTextView("submission_time")
                            submission_time:setLayoutSize("wrap_content", "wrap_content")
                            submission_time:setTextColor(TEXT_COLOR_SECONDARY)
                            submission_time:setTextSize("14sp")
                            submission_time:setPaddingLeft("4dp")
                            submission_time:setPaddingRight("4dp")

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
					        domain:setTextColor("#707070")
					        domain:setTextSize("14sp")
					        domain:setSingleLine(true)
					        domain:setEllipsize("end")
					        
					        local view3 = Builder:addTextView("subreddit")
					        view3:setLayoutSize("wrap_content", "wrap_content")
					        view3:setBackground("#404040")
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
					        view4:setMaxHeight("1280dp")
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
		        thread_actions:setBackground("#404040")
		        thread_actions:setOrientation("horizontal")
		        thread_actions:setGravity("center")
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
		            local share = Builder:addImageButton("share")
		            share:setLayoutSize("0dp", "48dp")
		            share:setLayoutWeight(1.000000)
		            share:setBackground(SELECTABLE_ITEM_BACKGROUND)
                    share:setPaddingTop("8dp")
                    share:setPaddingBottom("8dp")
		            share:setOnClick("shareThread")
		            share:setOnLongClick(function(v) Toasts:showHintShort("Share", v) end)
		            share:setDrawable("ic_menu_share_plain_holo_dark.png")
		            share:setScaleType("fitCenter")
		            local save = Builder:addImageButton("save")
		            save:setLayoutSize("0dp", "48dp")
		            save:setLayoutWeight(1.000000)
		            save:setBackground(SELECTABLE_ITEM_BACKGROUND)
                    save:setPaddingTop("8dp")
                    save:setPaddingBottom("8dp")
		            save:setOnClick("saveThread")
		            save:setOnLongClick(function(v) Toasts:showHintShort("Save/unsave", v) end)
		            save:setDrawable(DRAWABLE_SAVE)
		            save:setScaleType("fitCenter")
		            local comments = Builder:addImageButton("comments")
		            comments:setLayoutSize("0dp", "48dp")
		            comments:setLayoutWeight(1.000000)
		            comments:setBackground(SELECTABLE_ITEM_BACKGROUND)
                    comments:setPaddingTop("8dp")
                    comments:setPaddingBottom("8dp")
		            comments:setOnClick("openComments")
		            comments:setOnLongClick(function(v) Toasts:showHintShort("Comments", v) end)
		            comments:setDrawable("social_chat_holo_dark.png")
		            comments:setScaleType("fitCenter")
		            local more_actions = Builder:addImageButton("more_actions")
                    more_actions:setLayoutSize("0dp", "48dp")
                    more_actions:setLayoutWeight(0.5)
		            more_actions:setBackground(SELECTABLE_ITEM_BACKGROUND)
                    more_actions:setPaddingTop("8dp")
                    more_actions:setPaddingBottom("8dp")
		            more_actions:setOnClick("moreActionsThread")
		            more_actions:setOnLongClick(function(v) Toasts:showHintShort("More actions", v) end)
		            more_actions:setDrawable("ic_menu_moreoverflow_normal_holo_dark.png")
		            more_actions:setScaleType("centerCrop")
		        Builder:endViewGroup()
		        
	    	Builder:endLinearLayout()
    	Builder:endFrameLayout()
    Builder:endFrameLayout()
    
    Fonts:registerNormal("Roboto", "fonts/Roboto-Regular.ttf")
    Fonts:registerBold("Roboto", "fonts/Roboto-Bold.ttf")
    Fonts:registerItalic("Roboto", "fonts/Roboto-Italic.ttf")
    Fonts:registerBoldItalic("Roboto", "fonts/Roboto-BoldItalic.ttf")
    view1:setTypeface("Roboto")
end

function bindView(Holder, Thing, ListItem)
	local title = Holder:getView("title")
	local subreddit = Holder:getView("subreddit")
	local domain = Holder:getView("domain")
    local numComments = Holder:getView("num_comments")
    local submissionTime = Holder:getView("submission_time")
    local linkFlair = Holder:getView("link_flair")
    local clickThreadView = Holder:getView("click_thread_frame")
    local voteUpButton = Holder:getView("vote_up_button")
    local voteDownButton = Holder:getView("vote_down_button")
    local comments = Holder:getView("comments")
    local nsfw = Holder:getView("nsfw")
    local share = Holder:getView("share")
    local save = Holder:getView("save")
    local moreActions = Holder:getView("more_actions")
	
	title:setText(Thing:getTitle())
	title:setTextStyle(Thing:isClicked() and "normal" or "bold")
    title:setTextColor(Thing:isStickied() and "#669900" or TEXT_COLOR_PRIMARY)

    local thingLinkFlairText = Thing:getLink_flair_text()
    local hasFlair = thingLinkFlairText ~= nil and "" ~= thingLinkFlairText
    linkFlair:setVisible(hasFlair)
    linkFlair:setText(thingLinkFlairText)

    subreddit:setText(Thing:getSubreddit())
    local thingUrl = Thing:getUrl()
	if Thing:isIs_self() then
		domain:setText("self")
	elseif thingUrl:sub(1, 19) == "http://imgur.com/a/" then
		domain:setText("imgur album")
	else
		domain:setText(Thing:getDomain())
	end

	local imageView = Holder:getView("image")
	local imageProgress = Holder:getView("image_progress")
	local imageFrame = Holder:getView("image_frame")

	local thumbnail = Thing:getThumbnail()
	if thumbnail == "nsfw" or ((thumbnail == "" or thumbnail == nil) and Thing:isOver_18() and not ListItem:isBrowsingOver18Subreddit()) then
		nsfw:setVisibility("visible")
		imageView:cancelDisplayImage()
		imageView:setVisibility("gone")
		imageFrame:setLayoutHeight(WRAP_CONTENT)
		imageProgress:setVisibility("gone")
	else
		nsfw:setVisibility("gone")
		local imageUrl = thumbnails.getImageUrl(thingUrl)
		if imageUrl then
			if imageUrl ~= imageView:getTag("currentUrl") then
				imageView:displayImageWithProgress(imageUrl, imageProgress)
				imageView:setTag("currentUrl", imageUrl)

				local imageFrameWidth = clickThreadView:getWidth()

				if imageFrameWidth > 0 then
					local methodExists, dimenString = pcall(Thing.getPreviewImageSourceDimensions, Thing)
					if methodExists and dimenString ~= nil then
						local xIndex = dimenString:find("x")
						local previewImageWidth = tonumber(dimenString:sub(1, xIndex - 1))
						local previewImageHeight = tonumber(dimenString:sub(xIndex + 1))
						local calculatedHeight = imageFrameWidth * previewImageHeight / previewImageWidth
						imageFrame:setLayoutHeight(calculatedHeight)
						imageView:setLayoutSize(imageFrameWidth, calculatedHeight)
					else
						imageView:setLayoutSize("fill_parent", "wrap_content")
					end
				end
			end
		else
			imageView:cancelDisplayImage()
			imageView:setVisibility("gone")
			imageProgress:setVisibility("gone")
			imageFrame:setLayoutHeight(WRAP_CONTENT)
		end
	end
	
    -- votes
    local votes = Holder:getView("votes")
    local thingScore = Thing:getScore()
    local thingLikes = Thing:getLikes()
    votes:setText(string.format(thingScore==1 and "%d point" or "%d points", thingScore >= 0 and thingScore or 0))
    if thingLikes == true then
    	local colorArrowRed = "#ffff8b60"
    	votes:setTextColor(colorArrowRed)
    	voteUpButton:setDrawable(DRAWABLE_VOTE_UP_RED)
    	voteDownButton:setDrawable(DRAWABLE_VOTE_DOWN_GRAY)
	elseif thingLikes == false then
		local colorArrowBlue = "#ff9494ff"
		votes:setTextColor(colorArrowBlue)
		voteUpButton:setDrawable(DRAWABLE_VOTE_UP_GRAY)
		voteDownButton:setDrawable(DRAWABLE_VOTE_DOWN_BLUE)
	else -- thingLikes == nil
		votes:setTextColor(TEXT_COLOR_SECONDARY)
	    voteUpButton:setDrawable(DRAWABLE_VOTE_UP_GRAY)
	    voteDownButton:setDrawable(DRAWABLE_VOTE_DOWN_GRAY)
	end
	
	-- num comments
    local thingNumComments = Thing:getNum_comments()
	numComments:setText(string.format(thingNumComments==1 and "%d comment" or "%d comments", thingNumComments))

    local createdTimeAgo = Thing:getCreatedTimeAgo()
    createdTimeAgo = createdTimeAgo:gsub("very recently", "now")
    createdTimeAgo = createdTimeAgo:gsub("s ago", " ago")
    createdTimeAgo = createdTimeAgo:gsub(" ago", "")
    createdTimeAgo = createdTimeAgo:gsub("second", "s")
    createdTimeAgo = createdTimeAgo:gsub("minute", "min")
    createdTimeAgo = createdTimeAgo:gsub("hour", "hr")
    createdTimeAgo = createdTimeAgo:gsub("day", "d")
    createdTimeAgo = createdTimeAgo:gsub("week", "wk")
    createdTimeAgo = createdTimeAgo:gsub("month", "mo")
    createdTimeAgo = createdTimeAgo:gsub("year", "yr")
    submissionTime:setText(createdTimeAgo)

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
function onDismiss(Holder, Thing)
	local backview = Holder:getView("swipelist_backview")
	backview:onClick("hideThread")
end
