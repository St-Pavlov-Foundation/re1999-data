module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183MainBossEpisodeItem", package.seeall)

slot0 = class("Act183MainBossEpisodeItem", Act183BaseEpisodeItem)

function slot0.getItemParentPath(slot0)
	return "root/middle/#go_episodecontainer/go_pointboss"
end

function slot0.getItemTemplatePath()
	return "root/middle/#go_episodecontainer/#go_bossepisode"
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gostars = gohelper.findChild(slot0.go, "go_finish/go_stars")
	slot0._gostaritem = gohelper.findChild(slot0.go, "go_finish/go_stars/stars/go_staritem")
	slot0._animunlock = gohelper.onceAddComponent(slot0._gounlock, gohelper.Type_Animator)

	slot0:addEventCb(Act183Controller.instance, Act183Event.OnInitDungeonDone, slot0._onInitDungeonDone, slot0)
end

function slot0.onUpdateMo(slot0, slot1)
	uv0.super.onUpdateMo(slot0, slot1)
	slot0:refreshPassStarList(slot0._gostaritem)
end

function slot0._onInitDungeonDone(slot0)
	slot0:_checkPlayNewUnlockAnim()
end

function slot0._checkPlayNewUnlockAnim(slot0)
	if slot0._status ~= Act183Enum.EpisodeStatus.Unlocked then
		return
	end

	if Act183Model.instance:isEpisodeNewUnlock(slot0._episodeId) then
		slot0._animunlock:Play("unlock", 0, 0)
	end
end

function slot0.playFinishAnim(slot0)
	uv0.super.playFinishAnim(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished_Star)
end

return slot0
