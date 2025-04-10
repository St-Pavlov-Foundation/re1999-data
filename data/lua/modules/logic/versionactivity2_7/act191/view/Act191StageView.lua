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
end

function slot0.onOpen(slot0)
	Act191StatController.instance:onViewOpen(slot0.viewName)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.NodeListItem, slot0._goNodeList), Act191NodeListItem)

	slot2 = Activity191Model.instance:getActInfo():getGameInfo()
	slot0._txtScore.text = slot2.score
	slot0._txtCoin.text = slot2.coin
	slot4 = #Activity191Helper.matchKeyInArray(slot2.nodeInfo, slot2.curNode, "nodeId").selectNodeStr
	slot0.stageItemList = {}
	slot0.nodeDetailMoList = slot0:getUserDataTb_()

	for slot8 = 1, 3 do
		slot10 = gohelper.findChild(slot0.viewGO, "stageList/StageItem" .. (slot4 == 1 and 2 or slot8))

		if slot8 <= slot4 then
			slot11 = Act191NodeDetailMO.New()

			slot11:init(slot3.selectNodeStr[slot8])

			slot0.nodeDetailMoList[slot8] = slot11
			slot14 = Activity191Helper.isPvpBattle(slot11.type)

			if Activity191Helper.isPveBattle(slot11.type) or slot14 then
				slot15 = gohelper.clone(slot0._goFightStage, slot10, "Item")

				slot0:addClickCb(gohelper.findChildButtonWithAudio(slot15, ""), slot0.clickStage, slot0, slot8)

				slot17 = gohelper.findChildButtonWithAudio(slot15, "btn_Check")

				slot0:addClickCb(slot17, slot0.clickCheck, slot0, slot8)
				gohelper.setActive(slot17, slot13)

				slot0:getUserDataTb_().goSelect = gohelper.findChild(slot15, "go_Select")
				slot23 = gohelper.findChild(slot15, "reward")

				gohelper.setActive(gohelper.findChild(slot15, "stage/go_Spine"), slot13)
				gohelper.setActive(gohelper.findChild(slot15, "stage/go_Unknown"), slot14)
				UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot15, "image_NodeNum"), "act174_stage_num_0" .. slot8)

				slot24 = nil

				if slot13 then
					slot25 = lua_activity191_fight_event.configDict[slot11.fightEventId]

					UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot15, "info/image_Level"), "act191_level_" .. string.lower(slot25.fightLevel))
					slot0:createSpine(slot18, slot25)

					slot24 = GameUtil.splitString2(slot25.rewardView, true)

					gohelper.setActive(gohelper.findChild(slot15, "info/go_attribute"), false)
				else
					UISpriteSetMgr.instance:setAct174Sprite(slot21, "act191_level_" .. string.lower(lua_activity191_match_rank.configDict[slot11.matchInfo.rank].fightLevel))

					slot27 = lua_activity191_pvp_match.configDict[Activity191Enum.NodeType2Key[slot11.type]]
					slot24 = GameUtil.splitString2(slot27.rewardView, true)

					if GameUtil.splitString2(slot27.attribute, true) then
						for slot32 = 1, 2 do
							slot33 = gohelper.findChild(slot22, slot32)

							if slot28[slot32] then
								UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot33, "icon"), "icon_att_" .. slot28[slot32][1])

								gohelper.findChildText(slot33, "txt_attribute").text = (slot28[slot32][2] <= 0 or string.format("+%s%%", slot35 / 10)) and string.format("%s%%", slot35 / 10)
							end

							gohelper.setActive(slot33, slot28[slot32])
						end
					end

					gohelper.setActive(slot22, slot28)
				end

				for slot28, slot29 in ipairs(slot24) do
					slot31 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(Activity191Enum.PrefabPath.RewardItem, slot23), Act191RewardItem)

					slot31:setData(slot29[1], slot29[2])
					slot31:setExtraParam({
						index = slot28,
						fromView = slot0.viewName
					})
				end
			else
				slot15 = gohelper.clone(slot0._goNormalStage, slot10)

				slot0:addClickCb(gohelper.findChildButtonWithAudio(slot15, ""), slot0.clickStage, slot0, slot8)

				slot17 = gohelper.findChildSingleImage(slot15, "stage/simage_Stage")
				slot12.goSelect = gohelper.findChild(slot15, "go_Select")
				slot19 = gohelper.findChildText(slot15, "info/txt_Name")
				slot20 = gohelper.findChildText(slot15, "detail/scroll_desc/Viewport/Content/txt_Desc")
				slot21 = gohelper.findChild(slot15, "tag")

				UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot15, "image_NodeNum"), "act174_stage_num_0" .. slot8)

				slot24 = nil

				if Activity191Helper.isShopNode(slot11.type) then
					slot25 = lua_activity191_shop.configDict[slot0.actId][slot11.shopId]

					if slot11.type == Activity191Enum.NodeType.RoleShop then
						gohelper.findChildText(slot15, "tag/txt_Tag").text = lua_activity191_const.configDict[Activity191Enum.ConstKey.RoleTag].value2
					elseif slot11.type == Activity191Enum.NodeType.CollectionShop then
						slot22.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.CollectionTag].value2
					elseif tabletool.indexOf(Activity191Enum.TagShopField, slot11.type) then
						slot22.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.FetterTag].value2
					end

					slot19.text = slot25.name
					slot20.text = slot25.desc
					slot24 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_3")
				elseif slot11.type == Activity191Enum.NodeType.Enhance then
					slot19.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceTitle].value2
					slot20.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceDesc].value2
					slot24 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_2")
				elseif slot11.type == Activity191Enum.NodeType.BattleEvent or slot11.type == Activity191Enum.NodeType.RewardEvent then
					slot25 = lua_activity191_event.configDict[slot11.eventId]
					slot19.text = slot25.title
					slot20.text = slot25.outDesc
					slot24 = ResUrl.getAct191SingleBg("stage/act191_stage_mode_1")

					gohelper.setActive(slot20, true)
				end

				gohelper.setActive(slot21, slot23 and slot11.type ~= Activity191Enum.NodeType.MixStore)
				slot17:LoadImage(slot24)
			end

			gohelper.setActive(slot10, true)

			slot0.stageItemList[slot8] = slot12
		end
	end

	gohelper.setActive(slot0._goFightStage, false)
	gohelper.setActive(slot0._goNormalStage, false)
end

function slot0.onClose(slot0)
	Act191StatController.instance:statViewClose(slot0.viewName, slot0.viewContainer:isManualClose())
end

function slot0.clickStage(slot0, slot1)
	if not slot0.selectIndex then
		gohelper.setActive(slot0._btnEnter, true)
	end

	slot0.selectIndex = slot1

	for slot5, slot6 in ipairs(slot0.stageItemList) do
		gohelper.setActive(slot6.goSelect, slot5 == slot1)
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

return slot0
