module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonDescComp", package.seeall)

slot0 = class("Act183DungeonDescComp", Act183DungeonBaseComp)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._gonormal = gohelper.findChild(slot0.go, "#go_normal")
	slot0._gohard = gohelper.findChild(slot0.go, "#go_hard")
	slot0._txttitle = gohelper.findChildText(slot0.go, "title/#txt_title")
	slot0._godone = gohelper.findChild(slot0.go, "title/#go_done")
	slot0._txtdesc = gohelper.findChildText(slot0.go, "#scroll_detail/Viewport/Content/top/#txt_desc")
	slot0._btninfo = gohelper.findChildButtonWithAudio(slot0.go, "title/#btn_Info")
	slot0._gotop = gohelper.findChild(slot0.go, "#scroll_detail/Viewport/Content/top")
	slot0._topTran = slot0._gotop.transform
end

function slot0.addEventListeners(slot0)
	slot0._btninfo:AddClickListener(slot0._btninfoOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btninfo:RemoveClickListener()
end

function slot0.checkIsVisible(slot0)
	return true
end

function slot0.show(slot0)
	uv0.super.show(slot0)

	slot0._txttitle.text = slot0._episodeCo.title
	slot0._txtdesc.text = slot0._episodeCo.desc

	gohelper.setActive(slot0._gonormal, slot0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(slot0._gohard, slot0._groupType == Act183Enum.GroupType.HardMain)
	gohelper.setActive(slot0._godone, slot0._status == Act183Enum.EpisodeStatus.Finished)
end

function slot0._btninfoOnClick(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId) then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot1.battleId)
	end
end

function slot0.getHeight(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._topTran)

	return recthelper.getHeight(slot0._topTran)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
