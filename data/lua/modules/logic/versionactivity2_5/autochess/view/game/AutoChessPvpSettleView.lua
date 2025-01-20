module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPvpSettleView", package.seeall)

slot0 = class("AutoChessPvpSettleView", BaseView)

function slot0.onInitView(slot0)
	slot0._goWin = gohelper.findChild(slot0.viewGO, "root/#go_Win")
	slot0._goLose = gohelper.findChild(slot0.viewGO, "root/#go_Lose")
	slot0._goBadge = gohelper.findChild(slot0.viewGO, "root/Left/#go_Badge")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "root/Right/Round/image/#txt_Round")
	slot0._txtDamage = gohelper.findChildText(slot0.viewGO, "root/Right/Damage/image/#txt_Damage")
	slot0._goHp = gohelper.findChild(slot0.viewGO, "root/Right/#go_Hp")
	slot0._txtHp = gohelper.findChildText(slot0.viewGO, "root/Right/#go_Hp/image/#txt_Hp")
	slot0._goLeaderMesh = gohelper.findChild(slot0.viewGO, "root/Right/Team/Content/Laeder/#go_LeaderMesh")
	slot0._goChess = gohelper.findChild(slot0.viewGO, "root/Right/Team/Content/#go_Chess")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if AutoChessModel.instance.settleData then
		slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(AutoChessEnum.BadgeItemPath, slot0._goBadge), AutoChessBadgeItem)

		slot3:setData(slot1.rank, slot1.score, true, true)
		slot3:playProgressAnim(slot1.rank, slot1.score)

		slot0._txtRound.text = string.format("%d/%d", slot1.round, lua_auto_chess_episode.configDict[slot1.episodeId].maxRound)
		slot5 = tonumber(slot1.remainingHp)
		slot0._txtDamage.text = slot1.totalInjury
		slot0._txtHp.text = slot1.remainingHp

		if lua_auto_chess_master.configDict[slot1.masterId] then
			MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goLeaderMesh, AutoChessMeshComp):setData(slot6.image, false, true)
		end

		for slot10, slot11 in ipairs(slot1.chessIds) do
			MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(gohelper.cloneInPlace(slot0._goChess, slot11), "Mesh"), AutoChessMeshComp):setData(lua_auto_chess.configDict[slot11][1].image)
		end

		gohelper.setActive(slot0._goHp, slot5 ~= 0)
		gohelper.setActive(slot0._goWin, slot5 ~= 0)
		gohelper.setActive(slot0._goLose, slot5 == 0)
		gohelper.setActive(slot0._goChess, false)
	end
end

function slot0.onClose(slot0)
	slot0:closeThis()
	AutoChessController.instance:onSettleViewClose()
end

function slot0.onDestroyView(slot0)
end

return slot0
