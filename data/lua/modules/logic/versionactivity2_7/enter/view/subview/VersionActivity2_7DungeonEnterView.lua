module("modules.logic.versionactivity2_7.enter.view.subview.VersionActivity2_7DungeonEnterView", package.seeall)

slot0 = class("VersionActivity2_7DungeonEnterView", VersionActivityFixedDungeonEnterView)

function slot0.onInitView(slot0)
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "logo/#txt_dec")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "logo/actbg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/actbg/image_TimeBG/#txt_time")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtStoreNum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/normal/#txt_num")
	slot0._txtStoreTime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	slot0._btnenter = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_enter")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/#go_reddot")
	slot0._gohardModeUnLock = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/#go_hardModeUnLock")
	slot0._btnFinished = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Finished")
	slot0._btnLocked = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_Locked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

return slot0
