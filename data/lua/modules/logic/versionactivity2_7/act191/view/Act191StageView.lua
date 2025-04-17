module("modules.logic.versionactivity2_7.act191.view.Act191StageView", package.seeall)

slot0 = class("Act191StageView", BaseView)

function slot0.onInitView(slot0)
	slot0._goNodeList = gohelper.findChild(slot0.viewGO, "#go_NodeList")
	slot0._goNormalStage = gohelper.findChild(slot0.viewGO, "#go_NormalStage")
	slot0._goFightStage = gohelper.findChild(slot0.viewGO, "#go_FightStage")
	slot0._goTeam = gohelper.findChild(slot0.viewGO, "#go_Team")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Enter")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._txtCoin = gohelper.findChildText(slot0.viewGO, "go_topright/Coin/#txt_Coin")
	slot0._txtScore = gohelper.findChildText(slot0.viewGO, "go_topright/Score/#txt_Score")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0.onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnter:RemoveClickListener()
end

function slot0._btnEnterOnClick(slot0)
	if not slot0.selectIndex then
		return
	end

	Activity191Rpc.instance:sendSelect191NodeRequest(slot0.actId, slot0.selectIndex - 1, slot0.onSelectNode, slot0)
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity191Model.instance:getCurActId()

	gohelper.setActive(slot0._btnEnter, false)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.TeamComp, slot0._goTeam), Act191TeamComp, slot0)

	slot0.nodeListComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.NodeListItem, slot0._goNodeList), Act191NodeListItem, slot0)
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_unfold)

	slot1 = Activity191Model.instance:getActInfo():getGameInfo()
	slot0._txtScore.text = slot1.score
	slot0._txtCoin.text = slot1.coin
	slot3 = #Activity191Helper.matchKeyInArray(slot1.nodeInfo, slot1.curNode, "nodeId").selectNodeStr
	slot0.stageItemList = {}
	slot0.nodeDetailMoList = slot0:getUserDataTb_()

	for slot7 = 1, 3 do
		slot9 = gohelper.findChild(slot0.viewGO, "stageList/StageItem" .. (slot3 == 1 and 2 or slot7))

		if slot7 <= slot3 then
			slot10 = Act191NodeDetailMO.New()

			slot10:init(slot2.selectNodeStr[slot7])

			slot0.nodeDetailMoList[slot7] = slot10
			slot11 = slot0:getUserDataTb_()
			slot13 = Activity191Helper.isPvpBattle(slot10.type)

			if Activity191Helper.isPveBattle(slot10.type) or slot13 then
				slot14 = gohelper.clone(slot0._goFightStage, slot9)
				slot11.canvasGroup = slot14:GetComponent(gohelper.Type_CanvasGroup)

				slot0:addClickCb(gohelper.findChildButton(slot14, ""), slot0.clickStage, slot0, slot7)

				slot16 = gohelper.findChildButtonWithAudio(slot14, "btn_Check")

				slot0:addClickCb(slot16, slot0.clickCheck, slot0, slot7)
				gohelper.setActive(slot16, slot12)

				slot11.goMask = gohelper.findChild(slot14, "stage/go_mask")
				slot11.goSelect = gohelper.findChild(slot14, "go_Select")
				slot22 = gohelper.findChild(slot14, "reward")

				gohelper.setActive(gohelper.findChild(slot14, "stage/go_Spine"), slot12)
				gohelper.setActive(gohelper.findChild(slot14, "stage/go_Unknown"), slot13)
				UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot14, "image_NodeNum"), "act174_stage_num_0" .. slot7)

				slot23 = nil

				if slot12 then
					slot24 = lua_activity191_fight_event.configDict[slot10.fightEventId]

					UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot14, "info/image_Level"), "act191_level_" .. string.lower(slot24.fightLevel))
					slot0:createSpine(slot17, slot24)

					slot23 = GameUtil.splitString2(slot24.rewardView, true)

					gohelper.setActive(gohelper.findChild(slot14, "info/go_attribute"), false)
				else
					UISpriteSetMgr.instance:setAct174Sprite(slot20, "act191_level_" .. string.lower(lua_activity191_match_rank.configDict[slot10.matchInfo.rank].fightLevel))

					slot26 = lua_activity191_pvp_match.configDict[Activity191Enum.NodeType2Key[slot10.type]]
					slot23 = GameUtil.splitString2(slot26.rewardView, true)

					if GameUtil.splitString2(slot26.attribute, true) then
						for slot31 = 1, 2 do
							slot32 = gohelper.findChild(slot21, slot31)

							if slot27[slot31] then
								UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot32, "icon"), "icon_att_" .. slot27[slot31][1])

								gohelper.findChildText(slot32, "txt_attribute").text = (slot27[slot31][2] <= 0 or string.format("+%s%%", slot34 / 10)) and string.format("%s%%", slot34 / 10)
							end

							gohelper.setActive(slot32, slot27[slot31])
						end
					end

					gohelper.setActive(slot21, slot27)
				end

				for slot27, slot28 in ipairs(slot23) do
					slot30 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.RewardItem, slot22), Act191RewardItem)

					slot30:setData(slot28[1], slot28[2])
					slot30:setExtraParam({
						index = slot27,
						fromView = slot0.viewName
					})
				end
			else
				slot14 = gohelper.clone(slot0._goNormalStage, slot9)
				slot11.canvasGroup = slot14:GetComponent(gohelper.Type_CanvasGroup)

				slot0:addClickCb(gohelper.findChildButton(slot14, ""), slot0.clickStage, slot0, slot7)

				slot16 = gohelper.findChildSingleImage(slot14, "stage/simage_Stage")
				slot11.goSelect = gohelper.findChild(slot14, "go_Select")
				slot18 = gohelper.findChildText(slot14, "info/txt_Name")
				slot19 = gohelper.findChildText(slot14, "detail/scroll_desc/Viewport/Content/txt_Desc")
				slot20 = gohelper.findChild(slot14, "tag")

				UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot14, "image_NodeNum"), "act174_stage_num_0" .. slot7)

				slot23 = nil

				if Activity191Helper.isShopNode(slot10.type) then
					slot24 = lua_activity191_shop.configDict[slot0.actId][slot10.shopId]

					if slot10.type == Activity191Enum.NodeType.RoleShop then
						gohelper.findChildText(slot14, "tag/txt_Tag").text = lua_activity191_const.configDict[Activity191Enum.ConstKey.RoleTag].value2
					elseif slot10.type == Activity191Enum.NodeType.CollectionShop then
						slot21.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.CollectionTag].value2
					elseif tabletool.indexOf(Activity191Enum.TagShopField, slot10.type) then
						slot21.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.FetterTag].value2
					end

					slot18.text = slot24.name
					slot19.text = slot24.desc
					slot23 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_3")
				elseif slot10.type == Activity191Enum.NodeType.Enhance then
					slot18.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceTitle].value2
					slot19.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceDesc].value2
					slot23 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_2")
				elseif slot10.type == Activity191Enum.NodeType.BattleEvent or slot10.type == Activity191Enum.NodeType.RewardEvent then
					slot24 = lua_activity191_event.configDict[slot10.eventId]
					slot18.text = slot24.title
					slot19.text = slot24.outDesc
					slot23 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_1")

					gohelper.setActive(slot19, true)
				end

				gohelper.setActive(slot20, slot22 and slot10.type ~= Activity191Enum.NodeType.MixStore)
				slot16:LoadImage(slot23)
			end

			gohelper.setActive(slot9, true)

			slot0.stageItemList[slot7] = slot11
		end
	end

	gohelper.setActive(slot0._goFightStage, false)
	gohelper.setActive(slot0._goNormalStage, false)
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.playSalaryAnim, slot0)
end

function slot0.clickStage(slot0, slot1)
	if not slot0.selectIndex then
		gohelper.setActive(slot0._btnEnter, true)
	end

	if slot0.selectIndex == slot1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_fire_interface)

	slot0.selectIndex = slot1

	for slot5, slot6 in ipairs(slot0.stageItemList) do
		slot6.canvasGroup.alpha = slot5 == slot1 and 1 or 0.5

		gohelper.setActive(slot6.goSelect, slot5 == slot1)
		gohelper.setActive(slot6.goMask, slot5 ~= slot1)
	end
end

function slot0.clickCheck(slot0, slot1)
	if slot0.nodeDetailMoList[slot1] then
		EnemyInfoController.instance:openAct191EnemyInfoView(DungeonConfig.instance:getEpisodeCO(lua_activity191_fight_event.configDict[slot2.fightEventId].episodeId).battleId)
		Act191StatController.instance:statButtonClick(slot0.viewName, string.format("clickCheck_%s_%s", slot1, slot2.fightEventId))
	end
end

function slot0.onSelectNode(slot0, slot1, slot2)
	if slot2 == 0 then
		Activity191Controller.instance:nextStep()
		ViewMgr.instance:closeView(slot0.viewName)
	end
end

function slot0.createSpine(slot0, slot1, slot2)
	GuiSpine.Create(slot1, false):setResPath(ResUrl.getSpineUIPrefab(FightConfig.instance:getSkinCO(slot2.skinId).spine), nil, , true)

	if not string.nilorempty(slot2.offset) then
		slot5 = string.splitToNumber(slot2.offset, "#")

		recthelper.setAnchor(slot1.transform, slot5[1], slot5[2])

		if slot5[3] then
			transformhelper.setLocalScale(slot1.transform, slot5[3], slot5[3], 1)
		end
	end
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.Act191SwitchView and slot0.nodeListComp.firstNode then
		slot0.nodeListComp:showSalary()
		TaskDispatcher.runDelay(slot0.playSalaryAnim, slot0, 0.5)
	end
end

function slot0.playSalaryAnim(slot0)
	slot0.nodeListComp:playSalaryAnim(slot0._txtCoin.gameObject, slot0._txtScore.gameObject)
end

return slot0
