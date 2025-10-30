﻿-- chunkname: @modules/logic/story/view/StoryViewMgr.lua

module("modules.logic.story.view.StoryViewMgr", package.seeall)

local StoryViewMgr = class("StoryViewMgr")

function StoryViewMgr:open(storyId)
	return
end

function StoryViewMgr:close()
	return
end

function StoryViewMgr:getStoryBackgroundView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:getStoryBlitEff()
	local go = self:getStoryBackgroundView()

	if not go then
		return
	end

	local blitGo = gohelper.findChild(go, "#go_blitbg")
	local blitEff = blitGo:GetComponent(typeof(UrpCustom.UIBlitEffect))

	return blitEff
end

function StoryViewMgr:getStoryBlitEffSecond()
	local go = self:getStoryBackgroundView()

	if not go then
		return
	end

	local blitGo = gohelper.findChild(go, "#go_blitbgsecond")
	local blitEff = blitGo:GetComponent(typeof(UrpCustom.UIBlitEffect))

	return blitEff
end

function StoryViewMgr:getStoryFrontBgGo()
	local bgRootGo = self:getStoryBackgroundView()

	if not bgRootGo then
		return nil
	end

	local go = gohelper.findChild(bgRootGo, "#go_upbg")

	return go
end

function StoryViewMgr:getStoryHeroView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryHeroView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:getStoryView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:setStoryViewLayer(layer)
	local viewGo = self:getStoryView()

	if not viewGo then
		return
	end

	gohelper.setLayer(viewGo, layer, true)
end

function StoryViewMgr:getStoryLeadRoleSpineView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryLeadRoleSpineView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

function StoryViewMgr:setStoryLeadRoleSpineViewLayer(layer)
	local viewGo = self:getStoryLeadRoleSpineView()

	if not viewGo then
		return
	end

	local maskGo = gohelper.findChild(viewGo, "#go_spineroot")

	gohelper.setLayer(maskGo, layer, true)
end

function StoryViewMgr:getStoryFrontView()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.StoryFrontView)

	if not viewContainer then
		return nil
	end

	return viewContainer.viewGO
end

StoryViewMgr.instance = StoryViewMgr.New()

return StoryViewMgr
