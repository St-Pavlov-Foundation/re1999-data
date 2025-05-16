module("modules.logic.survival.view.shelter.ShelterRecruitView", package.seeall)

local var_0_0 = class("ShelterRecruitView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goDemand = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand")
	arg_1_0.goTagItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand/#scroll_List/Viewport/Content/#go_item")

	gohelper.setActive(arg_1_0.goTagItem, false)

	arg_1_0.txtDemandTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#go_Demand/txt_Tips")
	arg_1_0.goAnnounce = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce")
	arg_1_0.btnRecuit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/#btn_Recruit")
	arg_1_0.txtRecuitCost = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/RecruitCost")
	arg_1_0.imageRecuitCost = gohelper.findChildImage(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/RecruitCost/#image_Currency")
	arg_1_0.btnRefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/#btn_RefreshBtn")
	arg_1_0.goStandby = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Demand/#go_Standby")
	arg_1_0.txtRefreshCost = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/#go_Demand/#go_Announce/RefreshCost")
	arg_1_0.goMember = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Member")
	arg_1_0.goNpcItem = gohelper.findChild(arg_1_0.viewGO, "Panel/#go_Member/#scroll_List/Viewport/#go_content/#go_item")

	gohelper.setActive(arg_1_0.goNpcItem, false)

	arg_1_0.btnMemberRecuit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Member/#btn_Recruit")
	arg_1_0.btnCloseRecruit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#go_Member/#btn_CloseRecruit")
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/#btn_Close")
	arg_1_0.tagList = {}
	arg_1_0.npcList = {}
	arg_1_0.selectTags = {}
	arg_1_0.selectNpcId = 0
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRecuit, arg_2_0.onClickBtnRecuit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRefresh, arg_2_0.onClickBtnRefresh, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnMemberRecuit, arg_2_0.onClickBtnMemberRecuit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCloseRecruit, arg_2_0.onClickBtnCloseRecruit, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitDataUpdate, arg_2_0.onRecruitDataUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitRefresh, arg_2_0.onRecruitRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeClickCb(arg_3_0.btnRecuit)
	arg_3_0:removeClickCb(arg_3_0.btnRefresh)
	arg_3_0:removeClickCb(arg_3_0.btnMemberRecuit)
	arg_3_0:removeClickCb(arg_3_0.btnCloseRecruit)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitDataUpdate, arg_3_0.onRecruitDataUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnRecruitRefresh, arg_3_0.onRecruitRefresh, arg_3_0)
end

function var_0_0.onClickClose(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onRecruitRefresh(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.tagList) do
		iter_5_1.animator:Play(UIAnimationName.Switch, 0, 0)
	end

	UIBlockHelper.instance:startBlock(arg_5_0.viewName, 0.167, arg_5_0.viewName)
	TaskDispatcher.runDelay(arg_5_0.refreshView, arg_5_0, 0.167)
end

function var_0_0.onShelterBagUpdate(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onClickBtnRecuit(arg_7_0)
	if not arg_7_0.recruitInfo or not arg_7_0.recruitInfo:isCanRecruit() then
		return
	end

	local var_7_0 = arg_7_0.recruitInfo.config

	if not var_7_0 then
		return
	end

	local var_7_1, var_7_2, var_7_3, var_7_4 = SurvivalShelterModel.instance:getWeekInfo().bag:costIsEnough(var_7_0.cost)

	if not var_7_1 then
		local var_7_5 = lua_survival_item.configDict[var_7_2]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_7_5.name)

		return
	end

	local var_7_6 = arg_7_0.recruitInfo.selectCount
	local var_7_7 = tabletool.len(arg_7_0.selectTags)

	if var_7_7 == 0 or var_7_7 ~= var_7_6 then
		return
	end

	local var_7_8 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0.selectTags) do
		table.insert(var_7_8, iter_7_0)
	end

	SurvivalWeekRpc.instance:sendSurvivalPublishRecruitTagRequest(var_7_8)
end

function var_0_0.onClickBtnRefresh(arg_8_0)
	if not arg_8_0.recruitInfo then
		return
	end

	if arg_8_0.recruitInfo.canRefreshTimes == 0 then
		local var_8_0 = arg_8_0.recruitInfo.config
		local var_8_1, var_8_2 = SurvivalShelterModel.instance:getWeekInfo().bag:costIsEnough(var_8_0 and var_8_0.refreshCost)

		if not var_8_1 then
			local var_8_3 = lua_survival_item.configDict[var_8_2]

			GameFacade.showToast(ToastEnum.DiamondBuy, var_8_3.name)

			return
		end
	end

	SurvivalWeekRpc.instance:sendSurvivalRefreshRecruitTagRequest()
end

function var_0_0.onClickBtnMemberRecuit(arg_9_0)
	if arg_9_0.selectNpcId == nil or arg_9_0.selectNpcId == 0 then
		return
	end

	SurvivalWeekRpc.instance:sendSurvivalRecruitNpcRequest(arg_9_0.selectNpcId)
end

function var_0_0.onClickBtnCloseRecruit(arg_10_0)
	SurvivalWeekRpc.instance:sendSurvivalAbandonRecruitNpcRequest()
end

function var_0_0.onClickTag(arg_11_0, arg_11_1)
	if not arg_11_0.recruitInfo then
		return
	end

	local var_11_0 = arg_11_1.tagId

	if var_11_0 == nil or var_11_0 == 0 then
		return
	end

	if not arg_11_0.recruitInfo:isCanRecruit() then
		return
	end

	if arg_11_0.selectTags[var_11_0] ~= nil then
		arg_11_0.selectTags[var_11_0] = nil
	else
		if arg_11_0.recruitInfo.selectCount == tabletool.len(arg_11_0.selectTags) then
			return
		end

		arg_11_0.selectTags[var_11_0] = true
	end

	arg_11_0:refreshTagList()
end

function var_0_0.onClickNpc(arg_12_0, arg_12_1)
	if not arg_12_1.data then
		return
	end

	local var_12_0 = arg_12_1.data.npcId

	if var_12_0 == arg_12_0.selectNpcId then
		arg_12_0.selectNpcId = 0
	else
		arg_12_0.selectNpcId = var_12_0
	end

	arg_12_0:refreshNpcList()
end

function var_0_0.onRecruitDataUpdate(arg_13_0)
	arg_13_0:refreshView()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:refreshView()
end

function var_0_0.refreshView(arg_15_0)
	arg_15_0.recruitInfo = SurvivalShelterModel.instance:getWeekInfo():getRecruitInfo()

	if not arg_15_0.recruitInfo then
		return
	end

	local var_15_0 = arg_15_0.recruitInfo:isCanSelectNpc()

	gohelper.setActive(arg_15_0.goDemand, not var_15_0)
	gohelper.setActive(arg_15_0.goMember, var_15_0)

	if var_15_0 then
		arg_15_0:refreshMemberView()
	else
		arg_15_0:refreshDemandView()
	end
end

function var_0_0.refreshDemandView(arg_16_0)
	if arg_16_0.recruitInfo:isCanRecruit() then
		gohelper.setActive(arg_16_0.goStandby, false)
		gohelper.setActive(arg_16_0.goAnnounce, true)
		arg_16_0:refreshDemandButton()
	else
		gohelper.setActive(arg_16_0.goStandby, true)
		gohelper.setActive(arg_16_0.goAnnounce, false)
	end

	local var_16_0 = arg_16_0.recruitInfo.selectedTags

	arg_16_0.selectTags = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		arg_16_0.selectTags[iter_16_1] = true
	end

	arg_16_0:refreshTagList()
end

function var_0_0.refreshDemandButton(arg_17_0)
	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_17_1 = arg_17_0.recruitInfo.config
	local var_17_2 = arg_17_0.recruitInfo.canRefreshTimes > 0

	gohelper.setActive(arg_17_0.txtRefreshCost, not var_17_2)

	if not var_17_2 then
		local var_17_3, var_17_4, var_17_5, var_17_6 = var_17_0.bag:costIsEnough(var_17_1 and var_17_1.refreshCost)

		if var_17_3 then
			arg_17_0.txtRefreshCost.text = string.format("%s/%s", var_17_6, var_17_5)
		else
			arg_17_0.txtRefreshCost.text = string.format("<color=#D74242>%s</color>/%s", var_17_6, var_17_5)
		end
	end

	local var_17_7, var_17_8, var_17_9, var_17_10 = var_17_0.bag:costIsEnough(var_17_1 and var_17_1.cost)

	if var_17_7 then
		arg_17_0.txtRecuitCost.text = string.format("%s/%s", var_17_10, var_17_9)
	else
		arg_17_0.txtRecuitCost.text = string.format("<color=#D74242>%s</color>/%s", var_17_10, var_17_9)
	end
end

function var_0_0.refreshTagList(arg_18_0)
	local var_18_0 = arg_18_0.recruitInfo.selectCount
	local var_18_1 = tabletool.len(arg_18_0.selectTags)
	local var_18_2 = arg_18_0.recruitInfo:isInRecruit()
	local var_18_3 = var_18_0 == var_18_1 or var_18_2
	local var_18_4 = arg_18_0.recruitInfo.tags

	for iter_18_0 = 1, math.max(#var_18_4, #arg_18_0.tagList) do
		local var_18_5 = arg_18_0:getTagItem(iter_18_0)

		arg_18_0:refreshTagItem(var_18_5, var_18_4[iter_18_0], var_18_3)
	end

	if var_18_2 then
		arg_18_0.txtDemandTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_recruitview_menber_tips"), var_18_1, var_18_0)
	else
		arg_18_0.txtDemandTips.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_recruitview_demand_tips"), var_18_1, var_18_0)
	end
end

function var_0_0.getTagItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.tagList[arg_19_1]

	if not var_19_0 then
		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.go = gohelper.cloneInPlace(arg_19_0.goTagItem, tostring(arg_19_1))
		var_19_0.imageBg = gohelper.findChildImage(var_19_0.go, "#image_BG")
		var_19_0.goSelect = gohelper.findChild(var_19_0.go, "#go_Selected")
		var_19_0.txtTile = gohelper.findChildTextMesh(var_19_0.go, "#txt_Title")
		var_19_0.txtDesc = gohelper.findChildTextMesh(var_19_0.go, "#txt_Descr")
		var_19_0.canvasGroup = gohelper.onceAddComponent(var_19_0.go, typeof(UnityEngine.CanvasGroup))
		var_19_0.goMask = gohelper.findChild(var_19_0.go, "mask")
		var_19_0.btn = gohelper.findChildButtonWithAudio(var_19_0.go, "Click")

		var_19_0.btn:AddClickListener(arg_19_0.onClickTag, arg_19_0, var_19_0)

		var_19_0.animator = var_19_0.go:GetComponent(gohelper.Type_Animator)
		arg_19_0.tagList[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.refreshTagItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_1.tagId = arg_20_2

	if not arg_20_2 then
		gohelper.setActive(arg_20_1.go, false)

		return
	end

	gohelper.setActive(arg_20_1.go, true)

	local var_20_0 = SurvivalConfig.instance:getTagCo(arg_20_2)

	if not var_20_0 then
		return
	end

	arg_20_1.txtTile.text = var_20_0.name
	arg_20_1.txtDesc.text = var_20_0.desc

	local var_20_1 = arg_20_0.selectTags[arg_20_2]

	gohelper.setActive(arg_20_1.goSelect, var_20_1)

	local var_20_2 = arg_20_3 and not var_20_1 and 0.5 or 1

	arg_20_1.canvasGroup.alpha = var_20_2

	gohelper.setActive(arg_20_1.goMask, var_20_2 ~= 1)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_20_1.imageBg, string.format("survivalshelterrecruit_charbg%s", var_20_0.tagType))
end

function var_0_0.refreshMemberView(arg_21_0)
	arg_21_0.selectNpcId = 0

	arg_21_0:refreshNpcList()
end

function var_0_0.refreshNpcList(arg_22_0)
	local var_22_0 = arg_22_0.recruitInfo.goodList

	for iter_22_0 = 1, math.max(#var_22_0, #arg_22_0.npcList) do
		local var_22_1 = arg_22_0:getNpcItem(iter_22_0)

		arg_22_0:refreshNpcItem(var_22_1, var_22_0[iter_22_0])
	end

	local var_22_2 = arg_22_0.selectNpcId ~= nil and arg_22_0.selectNpcId ~= 0

	ZProj.UGUIHelper.SetGrayscale(arg_22_0.btnMemberRecuit.gameObject, not var_22_2)
end

function var_0_0.getNpcItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.npcList[arg_23_1]

	if not var_23_0 then
		var_23_0 = arg_23_0:getUserDataTb_()
		var_23_0.go = gohelper.cloneInPlace(arg_23_0.goNpcItem, tostring(arg_23_1))
		var_23_0.imageChess = gohelper.findChildImage(var_23_0.go, "#image_Chess")
		var_23_0.txtName = gohelper.findChildTextMesh(var_23_0.go, "#txt_PartnerName")
		var_23_0.goSelect = gohelper.findChild(var_23_0.go, "#go_Selected")
		var_23_0.goAttrItem = gohelper.findChild(var_23_0.go, "Scroll View/Viewport/#go_content/#go_Attr")

		gohelper.setActive(var_23_0.goAttrItem, false)

		var_23_0.attrItemList = {}
		var_23_0.btn = gohelper.findChildButtonWithAudio(var_23_0.go, "")

		var_23_0.btn:AddClickListener(arg_23_0.onClickNpc, arg_23_0, var_23_0)

		arg_23_0.npcList[arg_23_1] = var_23_0
	end

	return var_23_0
end

function var_0_0.refreshNpcItem(arg_24_0, arg_24_1, arg_24_2)
	arg_24_1.data = arg_24_2

	if not arg_24_2 then
		gohelper.setActive(arg_24_1.go, false)

		return
	end

	gohelper.setActive(arg_24_1.go, true)

	local var_24_0 = arg_24_2.npcId
	local var_24_1 = SurvivalConfig.instance:getNpcConfig(var_24_0)

	gohelper.setActive(arg_24_1.goSelect, var_24_0 == arg_24_0.selectNpcId)

	if not var_24_1 then
		return
	end

	arg_24_1.txtName.text = var_24_1.name

	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_24_1.imageChess, var_24_1.headIcon)

	local var_24_2 = string.splitToNumber(var_24_1.tag, "#")

	for iter_24_0 = 1, math.max(#var_24_2, #arg_24_1.attrItemList) do
		local var_24_3 = arg_24_0:getNpcAttrItem(arg_24_1, iter_24_0)

		arg_24_0:refreshNpcAttrItem(var_24_3, var_24_2[iter_24_0])
	end
end

function var_0_0.getNpcAttrItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_1.attrItemList[arg_25_2]

	if not var_25_0 then
		var_25_0 = arg_25_0:getUserDataTb_()
		var_25_0.go = gohelper.cloneInPlace(arg_25_1.goAttrItem, tostring(arg_25_2))
		var_25_0.txtTitle = gohelper.findChildTextMesh(var_25_0.go, "image_TitleBG/#txt_Title")
		var_25_0.txtDesc = gohelper.findChildTextMesh(var_25_0.go, "")
		var_25_0.imgTitle = gohelper.findChildImage(var_25_0.go, "image_TitleBG")
		arg_25_1.attrItemList[arg_25_2] = var_25_0
	end

	return var_25_0
end

function var_0_0.refreshNpcAttrItem(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_2 then
		gohelper.setActive(arg_26_1.go, false)

		return
	end

	gohelper.setActive(arg_26_1.go, true)

	local var_26_0 = lua_survival_tag.configDict[arg_26_2]

	arg_26_1.txtTitle.text = var_26_0.name
	arg_26_1.txtDesc.text = var_26_0.desc

	UISpriteSetMgr.instance:setSurvivalSprite(arg_26_1.imgTitle, string.format("survivalpartnerteam_attrbg%s", var_26_0.color))
end

function var_0_0.onClose(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.tagList) do
		iter_27_1.btn:RemoveClickListener()
	end

	for iter_27_2, iter_27_3 in pairs(arg_27_0.npcList) do
		iter_27_3.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_27_0.refreshView, arg_27_0)
end

return var_0_0
