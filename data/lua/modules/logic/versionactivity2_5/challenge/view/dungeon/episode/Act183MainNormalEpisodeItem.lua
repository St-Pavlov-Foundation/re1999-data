module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183MainNormalEpisodeItem", package.seeall)

slot0 = class("Act183MainNormalEpisodeItem", Act183BaseEpisodeItem)

function slot0.getItemParentPath(slot0)
	return "root/middle/#go_episodecontainer/go_point" .. slot0
end

function slot0.getItemTemplatePath(slot0)
	return "root/middle/#go_episodecontainer/#go_normalepisode"
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._goinfo = gohelper.findChild(slot0.go, "Info")
	slot0._imagerule1 = gohelper.findChildImage(slot0.go, "Info/rules/image_rule1")
	slot0._gorepress1 = gohelper.findChild(slot0.go, "Info/rules/image_rule1/go_repress1")
	slot0._imagerule2 = gohelper.findChildImage(slot0.go, "Info/rules/image_rule2")
	slot0._gorepress2 = gohelper.findChild(slot0.go, "Info/rules/image_rule2/go_repress2")
	slot0._imageindex = gohelper.findChildImage(slot0.go, "go_finish/image_index")
	slot0._imagecondition = gohelper.findChildImage(slot0.go, "Info/image_condition")
	slot0._goescape1 = gohelper.findChild(slot0.go, "Info/rules/image_rule1/go_repressbutterfly1")
	slot0._goescape2 = gohelper.findChild(slot0.go, "Info/rules/image_rule2/go_repressbutterfly2")
	slot0._gostars = gohelper.findChild(slot0.go, "go_finish/go_stars")
	slot0._gostaritem = gohelper.findChild(slot0.go, "go_finish/go_stars/stars/go_staritem")
	slot0._animrepress1 = gohelper.onceAddComponent(slot0._gorepress1, gohelper.Type_Animator)
	slot0._animrepress2 = gohelper.onceAddComponent(slot0._gorepress2, gohelper.Type_Animator)
	slot0._animescape1 = gohelper.onceAddComponent(slot0._goescape1, gohelper.Type_Animator)
	slot0._animescape2 = gohelper.onceAddComponent(slot0._goescape2, gohelper.Type_Animator)
	slot0._animcondition = gohelper.onceAddComponent(slot0._imagecondition, gohelper.Type_Animator)

	Act183Helper.setEpisodeConditionStar(slot0._imagecondition, true)
end

function slot0.addEventListeners(slot0)
	uv0.super.addEventListeners(slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, slot0._onUpdateRepressInfo, slot0)
end

function slot0.removeEventListeners(slot0)
	uv0.super.removeEventListeners(slot0)
end

function slot0._onUpdateRepressInfo(slot0, slot1, slot2)
	if slot0._episodeId ~= slot1 then
		return
	end

	slot0:refreshRules()
	slot0:playRepressAnim()
end

function slot0.onUpdateMo(slot0, slot1)
	uv0.super.onUpdateMo(slot0, slot1)

	if slot0._status == Act183Enum.EpisodeStatus.Finished then
		UISpriteSetMgr.instance:setChallengeSprite(slot0._imageindex, "v2a5_challenge_dungeon_level_" .. slot1:getPassOrder())
	end

	slot0._isAllConditionPass = slot0._episodeMo:isAllConditionPass()

	slot0._animcondition:Play(slot0._isAllConditionPass and "lighted" or "gray", 0, 0)
	slot0:refreshRules()
	slot0:refreshPassStarList(slot0._gostaritem)
end

function slot0.refreshRules(slot0)
	Act183Helper.setRuleIcon(slot0._episodeId, 1, slot0._imagerule1)
	Act183Helper.setRuleIcon(slot0._episodeId, 2, slot0._imagerule2)

	slot0._rule1status = slot0._episodeMo:getRuleStatus(1)
	slot0._rule2status = slot0._episodeMo:getRuleStatus(2)

	gohelper.setActive(slot0._gorepress1, slot0._rule1status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(slot0._gorepress2, slot0._rule2status == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(slot0._goescape1, slot0._rule1status == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(slot0._goescape2, slot0._rule2status == Act183Enum.RuleStatus.Escape)
end

function slot0.playFinishAnim(slot0)
	uv0.super.playFinishAnim(slot0)
	slot0:playRepressAnim()
	slot0:playAllConditionPassAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished_Star)
end

function slot0.playRepressAnim(slot0)
	if slot0._rule1status == Act183Enum.RuleStatus.Repress then
		slot0._animrepress1:Play("in", 0, 0)
	else
		slot0._animescape1:Play("in", 0, 0)
	end

	if slot0._rule2status == Act183Enum.RuleStatus.Repress then
		slot0._animrepress2:Play("in", 0, 0)
	else
		slot0._animescape2:Play("in", 0, 0)
	end
end

function slot0.playAllConditionPassAnim(slot0)
	if slot0._isAllConditionPass then
		slot0._animcondition:Play("light", 0, 0)
	end
end

return slot0
