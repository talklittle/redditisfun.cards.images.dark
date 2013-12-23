local commentmodule = {}

local TEXT_SIZE_SMALL = redditisfun.TEXT_SIZE_SMALL

local TEXT_COLOR_SUBMITTER     = "#888888"
local TEXT_COLOR_OP            = "#ff0000ff"
local TEXT_COLOR_MODERATOR     = "#ff228822"
local TEXT_COLOR_ADMIN         = "#ffff0011"
local TEXT_COLOR_SPECIAL_ADMIN = "#BE1337"

function commentmodule.addCommentVote(Builder, viewId)
    local view13 = Builder:beginFrameLayout("view13")
    view13:setLayoutSize("wrap_content", "wrap_content")
    view13:setLayoutGravity("center")

        local vote_up_comment_image = Builder:addImageView("vote_up_comment_image")
        vote_up_comment_image:setLayoutSize("13dip", "8dip")
        vote_up_comment_image:setPaddingRight("5dip")
        vote_up_comment_image:setVisibility("gone")
        vote_up_comment_image:setDrawable("vote_up_comment_red.png")
        -- FIXME: replace reference "@string/vote_up_arrow_content_description" with value
        vote_up_comment_image:setContentDescription("@string/vote_up_arrow_content_description")
        vote_up_comment_image:setScaleType("fitCenter")

        local vote_down_comment_image = Builder:addImageView("vote_down_comment_image")
        vote_down_comment_image:setLayoutSize("13dip", "8dip")
        vote_down_comment_image:setPaddingRight("5dip")
        vote_down_comment_image:setVisibility("gone")
        vote_down_comment_image:setDrawable("vote_down_comment_blue.png")
        -- FIXME: replace reference "@string/vote_down_arrow_content_description" with value
        vote_down_comment_image:setContentDescription("@string/vote_down_arrow_content_description")
        vote_down_comment_image:setScaleType("fitCenter")

    Builder:endViewGroup()
end

function commentmodule.addIndent(Builder, viewId)
    local left_indent = Builder:addView(viewId)
    left_indent:setLayoutSize("1dp", "fill_parent")
    left_indent:setLayoutMarginLeft("5dp")
    left_indent:setLayoutMarginRight("4dp")
    left_indent:setBackground("#2f2f2f")
end

function commentmodule.addSubmitterWithTags(Builder)
    local submitter = Builder:addTextView("submitter")
    submitter:setLayoutSize("wrap_content", "wrap_content")
    submitter:setLayoutMarginRight("5dip")
    submitter:setTextSize(TEXT_SIZE_SMALL)
    submitter:setTextColor(TEXT_COLOR_SUBMITTER)
    submitter:setTextStyle("bold")
    submitter:setSingleLine()
    submitter:setEllipsize("marquee")
    local submitter_distinguished_op = Builder:addTextView("submitter_distinguished_op")
    submitter_distinguished_op:setLayoutSize("wrap_content", "wrap_content")
    submitter_distinguished_op:setLayoutMarginRight("5dip")
    submitter_distinguished_op:setVisibility("gone")
    submitter_distinguished_op:setText("[S]")
    submitter_distinguished_op:setTextSize(TEXT_SIZE_SMALL)
    submitter_distinguished_op:setTextColor(TEXT_COLOR_OP)
    submitter_distinguished_op:setSingleLine(true)
    local submitter_distinguished_mod = Builder:addTextView("submitter_distinguished_mod")
    submitter_distinguished_mod:setLayoutSize("wrap_content", "wrap_content")
    submitter_distinguished_mod:setLayoutMarginRight("5dip")
    submitter_distinguished_mod:setVisibility("gone")
    submitter_distinguished_mod:setText("[M]")
    submitter_distinguished_mod:setTextSize(TEXT_SIZE_SMALL)
    submitter_distinguished_mod:setTextColor(TEXT_COLOR_MODERATOR)
    submitter_distinguished_mod:setSingleLine(true)
    local submitter_distinguished_admin = Builder:addTextView("submitter_distinguished_admin")
    submitter_distinguished_admin:setLayoutSize("wrap_content", "wrap_content")
    submitter_distinguished_admin:setLayoutMarginRight("5dip")
    submitter_distinguished_admin:setVisibility("gone")
    submitter_distinguished_admin:setText("[A]")
    submitter_distinguished_admin:setTextSize(TEXT_SIZE_SMALL)
    submitter_distinguished_admin:setTextColor(TEXT_COLOR_ADMIN)
    submitter_distinguished_admin:setSingleLine(true)
    local submitter_distinguished_special = Builder:addTextView("submitter_distinguished_special")
    submitter_distinguished_special:setLayoutSize("wrap_content", "wrap_content")
    submitter_distinguished_special:setLayoutMarginRight("5dip")
    submitter_distinguished_special:setVisibility("gone")
    submitter_distinguished_special:setText("[Δ]")
    submitter_distinguished_special:setTextSize(TEXT_SIZE_SMALL)
    submitter_distinguished_special:setTextColor(TEXT_COLOR_SPECIAL_ADMIN)
    submitter_distinguished_special:setSingleLine(true)

    return {
        submitter = submitter,
        op = submitter_distinguished_op,
        mod = submitter_distinguished_mod,
        admin = submitter_distinguished_admin,
        special = submitter_distinguished_special,
    }
end

return commentmodule