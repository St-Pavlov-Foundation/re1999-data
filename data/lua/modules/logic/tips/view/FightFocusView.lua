module("modules.logic.tips.view.FightFocusView", package.seeall)

local var_0_0 = class("FightFocusView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "fightinfocontainer/#btn_close")
	arg_1_0._btnDetailClose = gohelper.findChildButton(arg_1_0.viewGO, "fightinfocontainer/#go_detailView/#btn_detailClose")
	arg_1_0._goinfoView = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView")
	arg_1_0._goinfoViewContent = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#image_career")
	arg_1_0.levelRoot = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#txt_name")
	arg_1_0._gostress = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/#go_fightstressitem")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level/#image_dmgtype")
	arg_1_0._goplayerpassive = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive")
	arg_1_0._scrollenemypassive = gohelper.findChildScrollRect(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive")
	arg_1_0._goenemyemptyskill = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/emptyskill")
	arg_1_0._goenemypassive = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive")
	arg_1_0._goenemypassiveitem = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	arg_1_0._goenemypassiveSkill = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill")
	arg_1_0._enemypassiveSkillPrefab = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/item")
	arg_1_0._btnenemypassiveSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/btn_passiveclick")
	arg_1_0._goresistance = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#go_resistance")
	arg_1_0._txthp = gohelper.findChildText(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#txt_hp")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#slider_hp")
	arg_1_0._goattributeroot = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_attribute_root")
	arg_1_0._btnattribute = gohelper.findChildButton(arg_1_0.viewGO, "fightinfocontainer/#go_attribute_root/#btn_attribute")
	arg_1_0._scrollbuff = gohelper.findChildScrollRect(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff/Viewport/Content/buffitem")
	arg_1_0._godetailView = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_detailView")
	arg_1_0._goplayer = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player")
	arg_1_0._goenemy = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/enemy")
	arg_1_0._scrollplotenemypassive = gohelper.findChildScrollRect(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive")
	arg_1_0._goplotenemypassive = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive")
	arg_1_0._goplotenemypassiveitem = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	arg_1_0._godetailpassiveitem = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content/#go_detailpassiveitem")
	arg_1_0._btnplayerpassive = gohelper.findChildButton(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/#btn_playerpassive")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "fightinfocontainer/#go_detailView/bg/#scroll_content")
	arg_1_0._gobuffpassiveview = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_buffpassiveview")
	arg_1_0._gobuffpassiveitem = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	arg_1_0._gotargetframe = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_targetframe")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Bg")
	arg_1_0._containerGO = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer")
	arg_1_0._noskill = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/noskill")
	arg_1_0._skill = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/skill")
	arg_1_0._goplayerequipinfo = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo")
	arg_1_0._goequip = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip")
	arg_1_0._txtequiplv = gohelper.findChildText(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#txt_equiplv")
	arg_1_0._equipIconImage = gohelper.findChildImage(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	arg_1_0._goequipEmpty = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equipEmpty")
	arg_1_0._btnclosebuffpassive = gohelper.findChildButton(arg_1_0.viewGO, "fightinfocontainer/#go_buffpassiveview/#btn_detailClose")

	gohelper.setActive(arg_1_0._enemypassiveSkillPrefab, false)

	arg_1_0._enemypassiveiconGOs = arg_1_0:getUserDataTb_()
	arg_1_0._enemybuffpassiveGOs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveSkillImgs = arg_1_0:getUserDataTb_()
	arg_1_0._passiveiconImgs = arg_1_0:getUserDataTb_()
	arg_1_0._bossSkillInfos = {}
	arg_1_0._isbuffviewopen = false
	arg_1_0._canClickAttribute = false
	arg_1_0._multiHpRoot = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/image_HPFrame/image_HPBG")
	arg_1_0._multiHpItem = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/image_HPFrame/image_HPBG/image_HpItem")
	arg_1_0._btnSwitchEnemy = gohelper.findChildButton(arg_1_0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy")
	arg_1_0._btnSwitchMember = gohelper.findChildButton(arg_1_0.viewGO, "fightinfocontainer/#go_switch/#btn_member")
	arg_1_0._switchEnemyNormal = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/normal")
	arg_1_0._switchEnemySelect = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/select")
	arg_1_0._switchMemberNormal = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_switch/#btn_member/normal")
	arg_1_0._switchMemberSelect = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_switch/#btn_member/select")
	arg_1_0._btnBuffObj = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#btn_more")
	arg_1_0._btnBuffMore = gohelper.getClickWithDefaultAudio(arg_1_0._btnBuffObj)
	arg_1_0._goAssistBoss = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_assistBoss")
	arg_1_0._ani = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0.go_fetter = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/go_fetter")
	arg_1_0.go_quality = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/go_quality")
	arg_1_0.go_collection = gohelper.findChild(arg_1_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_collection")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnDetailClose:AddClickListener(arg_2_0._hideDetail, arg_2_0)
	arg_2_0._btnplayerpassive:AddClickListener(arg_2_0._btnplayerpassiveOnClick, arg_2_0)
	arg_2_0._btnclosebuffpassive:AddClickListener(arg_2_0._onCloseBuffPassive, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._onAttributeClick, arg_2_0)
	arg_2_0._btnSwitchEnemy:AddClickListener(arg_2_0._onSwitchEnemy, arg_2_0)
	arg_2_0._btnSwitchMember:AddClickListener(arg_2_0._onSwitchMember, arg_2_0)
	arg_2_0._btnBuffMore:AddClickListener(arg_2_0._onBtnBuffMore, arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.onReceiveEntityInfoReply, arg_2_0._onReceiveEntityInfoReply)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnDetailClose:RemoveClickListener()
	arg_3_0._btnplayerpassive:RemoveClickListener()
	arg_3_0._btnenemypassiveSkill:RemoveClickListener()
	arg_3_0._btnclosebuffpassive:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnSwitchEnemy:RemoveClickListener()
	arg_3_0._btnSwitchMember:RemoveClickListener()
	arg_3_0._btnBuffMore:RemoveClickListener()
	arg_3_0:_releasePassiveSkillGOs()
end

function var_0_0._releasePassiveSkillGOs(arg_4_0)
	if #arg_4_0._passiveSkillGOs then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._passiveSkillGOs) do
			iter_4_1.btn:RemoveClickListener()
			gohelper.destroy(iter_4_1.go)
		end
	end

	arg_4_0._passiveSkillGOs = {}
end

function var_0_0._onSwitchEnemy(arg_5_0)
	arg_5_0:_onClickSwitchBtn(FightEnum.EntitySide.EnemySide)
end

function var_0_0._onSwitchMember(arg_6_0)
	arg_6_0:_onClickSwitchBtn(FightEnum.EntitySide.MySide)
end

function var_0_0._onClickSwitchBtn(arg_7_0, arg_7_1)
	arg_7_0:closeAllTips()

	arg_7_0._curSelectSide = arg_7_1

	arg_7_0:_refreshEntityList()

	arg_7_0._curSelectId = arg_7_0._entityList[1].id

	arg_7_0:_refreshUI()
	arg_7_0._ani:Play("switch", nil, nil)
end

function var_0_0._btncloseOnClick(arg_8_0)
	if arg_8_0.openEquipInfoTipView then
		ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

		arg_8_0.openEquipInfoTipView = false

		return
	end

	if arg_8_0.openFightAttributeTipView then
		ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

		arg_8_0.openFightAttributeTipView = false

		return
	end

	if arg_8_0._hadPopUp then
		arg_8_0:_hideDetail()

		arg_8_0._hadPopUp = false
	else
		arg_8_0:closeThis()
	end
end

function var_0_0._onCloseBuffPassive(arg_9_0)
	gohelper.setActive(arg_9_0._gobuffpassiveview, false)

	arg_9_0._isbuffviewopen = false
end

function var_0_0._btnplayerpassiveOnClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_10_0:_showPassiveDetail()
end

function var_0_0._btnenemypassiveOnClick(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_11_0:_showPassiveDetail()
end

function var_0_0.initScrollEnemyNode(arg_12_0)
	arg_12_0.enemyItemList = {}
	arg_12_0.goScrollEnemy = gohelper.findChild(arg_12_0.viewGO, "fightinfocontainer/#scroll_enemy")
	arg_12_0._entityScrollHeight = recthelper.getHeight(arg_12_0.goScrollEnemy.transform)
	arg_12_0.goScrollEnemyContent = gohelper.findChild(arg_12_0.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent")
	arg_12_0.contentSizeFitter = arg_12_0.goScrollEnemyContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	arg_12_0.contentEnemyItem = gohelper.findChild(arg_12_0.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent/enemyitem")

	gohelper.setActive(arg_12_0.contentEnemyItem, false)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._equipIconImage.enabled = false

	gohelper.setActive(arg_13_0._godetailView, false)
	arg_13_0:initScrollEnemyNode()
	arg_13_0._simagebg:LoadImage(ResUrl.getFightImage("fightfocus/full/bg_bossjieshao_mengban.png"))
	gohelper.setActive(arg_13_0._goenemypassiveitem, false)
	gohelper.setActive(arg_13_0._goexitem, false)
	gohelper.setActive(arg_13_0._gobuffitem, false)
	gohelper.setActive(arg_13_0._godetailpassiveitem, false)

	arg_13_0._passiveSkillGOs = {}
	arg_13_0._exItemTables = {}
	arg_13_0._buffTables = {}
	arg_13_0._detailPassiveTables = {}
	arg_13_0._playerpassiveGOList = arg_13_0:getUserDataTb_()

	for iter_13_0 = 1, 3 do
		local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/playerpassivelevel/go_playerpassivelevel" .. iter_13_0)

		table.insert(arg_13_0._playerpassiveGOList, var_13_0)
	end

	arg_13_0._txttalent = gohelper.findChildTextMesh(arg_13_0.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/talent/tmp_talent")
	arg_13_0._gosuperitem = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_superitem")
	arg_13_0._goskillitem = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_skillitem")

	gohelper.setActive(arg_13_0._gosuperitem, false)
	gohelper.setActive(arg_13_0._goskillitem, false)

	arg_13_0._superItemList = {}

	local var_13_1

	for iter_13_1 = 1, 3 do
		local var_13_2 = arg_13_0:createSuperItem()

		table.insert(arg_13_0._superItemList, var_13_2)
	end

	arg_13_0._skillGOs = {}

	local var_13_3

	for iter_13_2 = 1, 3 do
		local var_13_4 = arg_13_0:createSkillItem()

		table.insert(arg_13_0._skillGOs, var_13_4)
	end

	arg_13_0._godetailcontent = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content")
	arg_13_0._gobg = gohelper.findChild(arg_13_0.viewGO, "fightinfocontainer/#go_detailView/bg")
	arg_13_0._onCloseNeedResetCamera = true
	arg_13_0._hadPopUp = false
	arg_13_0.openEquipInfoTipView = false
	arg_13_0.openFightAttributeTipView = false

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)

	local var_13_5 = DungeonModel.instance.curSendChapterId

	if var_13_5 then
		local var_13_6 = DungeonConfig.instance:getChapterCO(var_13_5)

		arg_13_0.isSimple = var_13_6 and var_13_6.type == DungeonEnum.ChapterType.Simple
	end

	arg_13_0.resistanceComp = FightEntityResistanceComp.New(arg_13_0._goresistance, arg_13_0.viewContainer)

	arg_13_0.resistanceComp:onInitView()
end

function var_0_0.createSuperItem(arg_14_0)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = gohelper.cloneInPlace(arg_14_0._gosuperitem)
	var_14_0.icon = gohelper.findChildSingleImage(var_14_0.go, "lv/imgIcon")
	var_14_0.btn = gohelper.findChildButtonWithAudio(var_14_0.go, "btn_click")

	var_14_0.btn:AddClickListener(function(arg_15_0)
		arg_14_0:_showSkillDetail(arg_15_0.info)
	end, var_14_0)
	gohelper.setActive(var_14_0.go, false)

	return var_14_0
end

function var_0_0.createSkillItem(arg_16_0)
	local var_16_0 = arg_16_0:getUserDataTb_()

	var_16_0.go = gohelper.cloneInPlace(arg_16_0._goskillitem)
	var_16_0.icon = gohelper.findChildSingleImage(var_16_0.go, "lv/imgIcon")
	var_16_0.tag = gohelper.findChildSingleImage(var_16_0.go, "tag/pos/tag/tagIcon")
	var_16_0.btn = gohelper.findChildButtonWithAudio(var_16_0.go, "btn_click")

	var_16_0.btn:AddClickListener(function(arg_17_0)
		arg_16_0:_showSkillDetail(arg_17_0.info)
	end, var_16_0)
	gohelper.setActive(var_16_0.go, false)

	return var_16_0
end

function var_0_0._getEntityList(arg_18_0)
	local var_18_0 = FightDataHelper.entityMgr:getNormalList(arg_18_0._curSelectSide)
	local var_18_1 = FightDataHelper.entityMgr:getSpList(arg_18_0._curSelectSide)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		table.insert(var_18_0, iter_18_1)
	end

	if FightModel.instance:isSeason2() and arg_18_0._curSelectSide == FightEnum.EntitySide.MySide then
		local var_18_2 = FightDataHelper.entityMgr:getSubList(arg_18_0._curSelectSide)

		for iter_18_2, iter_18_3 in ipairs(var_18_2) do
			table.insert(var_18_0, iter_18_3)
		end
	end

	for iter_18_4 = #var_18_0, 1, -1 do
		local var_18_3 = FightHelper.getEntity(var_18_0[iter_18_4].id)

		if var_18_3 and var_18_3.spine and var_18_3.spine.detectDisplayInScreen and not var_18_3.spine:detectDisplayInScreen() then
			table.remove(var_18_0, iter_18_4)
		end
	end

	arg_18_0:sortFightEntityList(var_18_0)

	local var_18_4 = FightDataHelper.entityMgr:getAssistBoss()

	if var_18_4 and arg_18_0._curSelectSide == FightEnum.EntitySide.MySide then
		table.insert(var_18_0, var_18_4)
	end

	return var_18_0
end

function var_0_0.sortFightEntityList(arg_19_0, arg_19_1)
	arg_19_0.bossIdDict = {}

	local var_19_0 = FightModel.instance:getFightParam()

	if not var_19_0.monsterGroupIds then
		return
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_0.monsterGroupIds) do
		local var_19_1 = lua_monster_group.configDict[iter_19_1].bossId

		if not string.nilorempty(var_19_1) then
			local var_19_2 = string.splitToNumber(var_19_1, "#")

			for iter_19_2, iter_19_3 in ipairs(var_19_2) do
				arg_19_0.bossIdDict[iter_19_3] = true
			end
		end
	end

	table.sort(arg_19_1, function(arg_20_0, arg_20_1)
		if arg_19_0.bossIdDict[arg_20_0.modelId] and not arg_19_0.bossIdDict[arg_20_1.modelId] then
			return true
		elseif not arg_19_0.bossIdDict[arg_20_0.modelId] and arg_19_0.bossIdDict[arg_20_1.modelId] then
			return false
		elseif arg_19_0.bossIdDict[arg_20_0.modelId] and arg_19_0.bossIdDict[arg_20_1.modelId] then
			return arg_20_0.modelId < arg_20_1.modelId
		else
			local var_20_0 = FightDataHelper.entityMgr:isSub(arg_20_0.id)
			local var_20_1 = FightDataHelper.entityMgr:isSub(arg_20_1.id)

			if var_20_0 and not var_20_1 then
				return false
			elseif not var_20_0 and var_20_1 then
				return true
			elseif not var_20_0 and not var_20_1 then
				return arg_20_0.modelId < arg_20_1.modelId
			else
				return arg_20_0.position > arg_20_1.position
			end
		end
	end)
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0.subEntityList = {}
	arg_21_0._attrEntityDic = {}
	arg_21_0._group = arg_21_0.viewParam and arg_21_0.viewParam.group or HeroGroupModel.instance:getCurGroupMO()

	if FightModel.instance:isSeason2() then
		arg_21_0._group = Season166HeroGroupModel.instance:getCurGroupMO()
	end

	arg_21_0._setEquipInfo = arg_21_0.viewParam and arg_21_0.viewParam.setEquipInfo
	arg_21_0._balanceHelper = arg_21_0.viewParam and arg_21_0.viewParam.balanceHelper or HeroGroupBalanceHelper

	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, false)
	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)

	local var_21_0 = arg_21_0.viewParam and arg_21_0.viewParam.entityId and FightHelper.getEntity(arg_21_0.viewParam.entityId)

	if var_21_0 then
		arg_21_0._curSelectSide = var_21_0:getSide()
	else
		arg_21_0._curSelectSide = FightEnum.EntitySide.EnemySide
	end

	arg_21_0:_refreshEntityList()

	arg_21_0._curSelectId = var_21_0 and var_21_0.id or arg_21_0._entityList[1].id

	TaskDispatcher.runDelay(arg_21_0._refreshUI, arg_21_0, 0.3)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_roledetails)
	NavigateMgr.instance:addEscape(arg_21_0.viewContainer.viewName, arg_21_0._btncloseOnClick, arg_21_0)
end

function var_0_0._refreshEntityList(arg_22_0)
	arg_22_0._entityList = arg_22_0:_getEntityList()

	gohelper.setActive(arg_22_0._switchEnemyNormal, arg_22_0._curSelectSide == FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_22_0._switchEnemySelect, arg_22_0._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_22_0._switchMemberNormal, arg_22_0._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(arg_22_0._switchMemberSelect, arg_22_0._curSelectSide == FightEnum.EntitySide.MySide)
	arg_22_0:refreshScrollEnemy()
end

function var_0_0._refreshUI(arg_23_0)
	local var_23_0 = FightDataHelper.entityMgr:getById(arg_23_0._curSelectId)

	if arg_23_0._entityMO ~= var_23_0 then
		arg_23_0:_focusEntity(var_23_0)
	end

	arg_23_0._entityMO = var_23_0

	local var_23_1 = var_23_0:isAssistBoss()

	if not var_23_1 then
		gohelper.setActive(arg_23_0._gotargetframe, true)
		gohelper.setActive(arg_23_0._goattributeroot, true)
		gohelper.setActive(arg_23_0._goinfoView, true)

		if var_23_0:isCharacter() then
			arg_23_0.isCharacter = true

			arg_23_0:_refreshCharacterInfo(var_23_0)
		else
			if var_23_0.side == FightEnum.EntitySide.MySide then
				arg_23_0.isCharacter = true
			else
				arg_23_0.isCharacter = false
			end

			arg_23_0:_refreshInfo(var_23_0:getCO())
		end

		gohelper.setActive(arg_23_0._goplayer, arg_23_0.isCharacter)
		gohelper.setActive(arg_23_0._goenemy, not arg_23_0.isCharacter)
		arg_23_0:_refreshMO(var_23_0)
		arg_23_0:_hideDetail()
		arg_23_0:_detectBossMultiHp(var_23_0)
	else
		gohelper.setActive(arg_23_0._gotargetframe, false)
		gohelper.setActive(arg_23_0._goattributeroot, false)
		gohelper.setActive(arg_23_0._goinfoView, false)
	end

	arg_23_0:setAssistBossStatus(var_23_1)
	arg_23_0:refreshScrollEnemySelectStatus()
	arg_23_0:refreshDouQuQuFetter()
	arg_23_0:refreshDouQuQuStar()
	arg_23_0:refreshDouQuQuCollection()
end

function var_0_0.setAssistBossStatus(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 then
		if not arg_24_0._assistBossView then
			arg_24_0._assistBossView = FightFocusTowerView.New(arg_24_0._goAssistBoss)
		end

		arg_24_0._assistBossView.bossId = arg_24_0._entityMO.modelId

		arg_24_0._assistBossView:show(arg_24_2)
	elseif arg_24_0._assistBossView then
		arg_24_0._assistBossView:hide(arg_24_2)
	end
end

function var_0_0._refreshInfo(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.isSimple and "levelEasy" or "level"

	UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imagecareer, "lssx_" .. tostring(arg_25_1.career))

	arg_25_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(arg_25_1[var_25_0])

	local var_25_1 = FightConfig.instance:getNewMonsterConfig(arg_25_1)

	arg_25_0._txtname.text = var_25_1 and arg_25_1.highPriorityName or arg_25_1.name

	if isDebugBuild then
		logNormal(string.format("monster id=%d template=%d skillTemplate=%d", arg_25_1.id, arg_25_1.template, arg_25_1.skillTemplate))
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_25_0._imagedmgtype, "dmgtype" .. tostring(arg_25_1.dmgType))

	local var_25_2

	if arg_25_0.isCharacter then
		var_25_2 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_25_1.id)

		if next(var_25_2) then
			arg_25_0:_refreshPassiveSkill(var_25_2, arg_25_0._goplotenemypassiveitem)
		end

		gohelper.setActive(arg_25_0._scrollplotenemypassive.gameObject, true)
		gohelper.setActive(arg_25_0._goplayerpassive, false)
	else
		local var_25_3 = arg_25_0:_getBossId()

		if FightHelper.isBossId(var_25_3, arg_25_1.id) then
			var_25_2 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_25_1.id)
			var_25_2 = FightConfig.instance:_filterSpeicalSkillIds(var_25_2, false)
		else
			var_25_2 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_25_1.id)
		end

		arg_25_0:_refreshPassiveSkill(var_25_2, arg_25_0._goenemypassiveitem)
		gohelper.setActive(arg_25_0._goplayerpassive, false)
	end

	local var_25_4 = {}
	local var_25_5 = string.nilorempty(arg_25_1.activeSkill)
	local var_25_6 = #arg_25_1.uniqueSkill < 1
	local var_25_7 = var_25_5 and var_25_6

	if not var_25_5 then
		var_25_4 = string.split(arg_25_1.activeSkill, "|")
	end

	gohelper.setActive(arg_25_0._noskill, var_25_7)
	gohelper.setActive(arg_25_0._skill, not var_25_7)

	local var_25_8 = {}
	local var_25_9
	local var_25_10

	for iter_25_0, iter_25_1 in pairs(var_25_4) do
		local var_25_11 = string.splitToNumber(iter_25_1, "#")
		local var_25_12 = var_25_11[1]

		var_25_8[var_25_12] = {}

		for iter_25_2 = 2, #var_25_11 do
			table.insert(var_25_8[var_25_12], var_25_11[iter_25_2])
		end
	end

	arg_25_0:_refreshSuper(arg_25_1.uniqueSkill)
	arg_25_0:_refreshSkill(var_25_8)
	arg_25_0:_refreshAttrList(arg_25_0:_getMontBaseAttr(arg_25_1))
	arg_25_0:_refreshResistance()
	arg_25_0:refreshStress(arg_25_0._entityMO)
	gohelper.setActive(arg_25_0._goplayerequipinfo, false)
end

var_0_0.StressUiType2Cls = {
	[FightNameUIStressMgr.UiType.Normal] = FightFocusStressComp,
	[FightNameUIStressMgr.UiType.Act183] = FightFocusAct183StressComp
}

function var_0_0.refreshStress(arg_26_0, arg_26_1)
	if not arg_26_1 or not arg_26_1:hasStress() then
		arg_26_0:removeStressComp()

		return
	end

	local var_26_0 = FightStressHelper.getStressUiType(arg_26_1.id)

	if not arg_26_0.stressComp then
		arg_26_0:createStressComp(var_26_0)
		arg_26_0.stressComp:refreshStress(arg_26_1)

		return
	end

	if arg_26_0.stressComp:getUiType() == var_26_0 then
		arg_26_0.stressComp:refreshStress(arg_26_1)

		return
	end

	arg_26_0:removeStressComp()
	arg_26_0:createStressComp(var_26_0)
	arg_26_0.stressComp:refreshStress(arg_26_1)
end

function var_0_0.createStressComp(arg_27_0, arg_27_1)
	arg_27_0.stressComp = (var_0_0.StressUiType2Cls[arg_27_1] or FightFocusStressCompBase).New()

	arg_27_0.stressComp:init(arg_27_0._gostress)
end

function var_0_0._refreshResistance(arg_28_0)
	if arg_28_0.isCharacter then
		arg_28_0.resistanceComp:refresh(nil)

		return
	end

	local var_28_0 = arg_28_0._entityMO:getResistanceDict()

	arg_28_0.resistanceComp:refresh(var_28_0)
end

function var_0_0._getBossId(arg_29_0)
	local var_29_0 = FightModel.instance:getCurMonsterGroupId()
	local var_29_1 = var_29_0 and lua_monster_group.configDict[var_29_0]

	return var_29_1 and not string.nilorempty(var_29_1.bossId) and var_29_1.bossId or nil
end

local var_0_1 = {
	"attack",
	"technic",
	"defense",
	"mdefense"
}

function var_0_0._onMonsterAttrItemShow(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = arg_30_1.transform
	local var_30_1 = var_30_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_30_2 = var_30_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_30_3 = HeroConfig.instance:getHeroAttributeCO(arg_30_2.id)

	if SLFramework.UGUI.GuiHelper.GetPreferredWidth(var_30_2, var_30_3.name) > recthelper.getWidth(var_30_2.transform) then
		var_30_2.overflowMode = TMPro.TextOverflowModes.Ellipsis
		arg_30_0._canClickAttribute = true
	end

	var_30_2.text = var_30_3.name

	UISpriteSetMgr.instance:setCommonSprite(var_30_1, "icon_att_" .. var_30_3.id)

	local var_30_4 = var_30_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_30_5 = var_30_0:Find("rate"):GetComponent(gohelper.Type_Image)

	if arg_30_0.isCharacter then
		gohelper.setActive(var_30_4.gameObject, true)
		gohelper.setActive(var_30_5.gameObject, false)

		var_30_4.text = arg_30_0._curAttrMO[var_0_1[arg_30_3]]
	else
		gohelper.setActive(var_30_4.gameObject, false)
		gohelper.setActive(var_30_5.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(var_30_5, "sx_" .. arg_30_2.value, true)
	end
end

function var_0_0._refreshCharacterInfo(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_1:getTrialAttrCo()

	gohelper.setActive(arg_31_0._scrollplotenemypassive.gameObject, false)

	local var_31_1 = arg_31_1:getCO()

	arg_31_0:_refreshHeroEquipInfo(arg_31_1)
	UISpriteSetMgr.instance:setCommonSprite(arg_31_0._imagecareer, "lssx_" .. tostring(var_31_1.career))

	arg_31_0._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(arg_31_1.level)
	arg_31_0._txtname.text = var_31_1.name

	if var_31_0 then
		arg_31_0._txtname.text = var_31_0.name
	end

	UISpriteSetMgr.instance:setCommonSprite(arg_31_0._imagedmgtype, "dmgtype" .. tostring(var_31_1.dmgType))
	arg_31_0:_refreshCharacterPassiveSkill(arg_31_1)
	gohelper.setActive(arg_31_0._goenemypassive, false)
	gohelper.setActive(arg_31_0._noskill, false)
	gohelper.setActive(arg_31_0._skill, true)

	local var_31_2
	local var_31_3 = not PlayerModel.instance:isPlayerSelf(arg_31_1.userId)

	if tonumber(arg_31_1.uid) < 0 or var_31_3 then
		var_31_2 = arg_31_1.exSkillLevel
	end

	local var_31_4 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(var_31_1.id, nil, nil, var_31_2)

	if var_31_0 then
		var_31_4 = SkillConfig.instance:getHeroAllSkillIdDictByStr(var_31_0.activeSkill, var_31_0.uniqueSkill)
	end

	local var_31_5 = var_31_4[3][1]

	var_31_4[3] = nil

	if arg_31_1.exSkill and arg_31_1.exSkill > 0 then
		var_31_5 = arg_31_1.exSkill
	end

	if #arg_31_1.skillGroup1 > 0 then
		var_31_4[1] = LuaUtil.deepCopySimple(arg_31_1.skillGroup1)
	end

	if #arg_31_1.skillGroup2 > 0 then
		var_31_4[2] = LuaUtil.deepCopySimple(arg_31_1.skillGroup2)
	end

	arg_31_0:_refreshSuper({
		var_31_5
	})
	arg_31_0:_refreshSkill(var_31_4)
	arg_31_0:_refreshAttrList(arg_31_0:_getHeroBaseAttr(var_31_1))
	arg_31_0:refreshStress(arg_31_0._entityMO)
end

function var_0_0._refreshHeroEquipInfo(arg_32_0, arg_32_1)
	local var_32_0
	local var_32_1

	if tonumber(arg_32_1.uid) < 0 then
		if tonumber(arg_32_1.equipUid) > 0 then
			var_32_0 = EquipModel.instance:getEquip(arg_32_1.equipUid)
		elseif tonumber(arg_32_1.equipUid) < 0 then
			local var_32_2 = lua_equip_trial.configDict[-tonumber(arg_32_1.equipUid)]

			if var_32_2 then
				var_32_0 = EquipMO.New()

				var_32_0:initByTrialEquipCO(var_32_2)
			end
		elseif arg_32_1.trialEquip and arg_32_1.trialEquip.equipId > 0 then
			var_32_0 = EquipMO.New()

			local var_32_3 = {
				equipId = arg_32_1.trialEquip.equipId,
				equipLv = arg_32_1.trialEquip.equipLv,
				equipRefine = arg_32_1.trialEquip.refineLv
			}

			var_32_0:initByTrialCO(var_32_3)
		end
	else
		local var_32_4

		if not PlayerModel.instance:isPlayerSelf(arg_32_1.userId) then
			var_32_4 = arg_32_1.uid
		else
			local var_32_5 = arg_32_1:getCO()
			local var_32_6 = HeroModel.instance:getByHeroId(var_32_5.id)

			var_32_4 = var_32_6 and var_32_6.id
		end

		local var_32_7

		if arg_32_0._group then
			for iter_32_0, iter_32_1 in pairs(arg_32_0._group.heroList) do
				if var_32_4 and iter_32_1 == var_32_4 then
					var_32_7 = arg_32_0._group.equips[iter_32_0 - 1].equipUid[1]
					var_32_1 = iter_32_0
				end
			end
		end

		if tonumber(var_32_7) and tonumber(var_32_7) < 0 then
			local var_32_8 = lua_equip_trial.configDict[-tonumber(var_32_7)]

			if var_32_8 then
				var_32_0 = EquipMO.New()

				var_32_0:initByTrialEquipCO(var_32_8)
			end
		else
			var_32_0 = EquipModel.instance:getEquip(var_32_7)
		end
	end

	if var_32_0 and arg_32_0._balanceHelper.getIsBalanceMode() then
		local var_32_9, var_32_10, var_32_11 = arg_32_0._balanceHelper.getBalanceLv()

		if var_32_11 > var_32_0.level then
			local var_32_12 = EquipMO.New()

			var_32_12:initByConfig(nil, var_32_0.equipId, var_32_11, var_32_0.refineLv)

			var_32_0 = var_32_12
		end
	end

	if var_32_0 and var_32_1 and arg_32_0._setEquipInfo then
		local var_32_13 = arg_32_0._setEquipInfo[1]
		local var_32_14 = arg_32_0._setEquipInfo[2]

		var_32_0 = var_32_13(var_32_14, {
			posIndex = var_32_1,
			equipMO = var_32_0
		})
	end

	arg_32_0.equipMO = var_32_0

	if arg_32_0.equipMO then
		arg_32_0._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_32_0.equipMO.config.icon), arg_32_0._equipIconLoaded, arg_32_0)

		arg_32_0._txtequiplv.text = string.format("Lv.%s", arg_32_0.equipMO.level)
		arg_32_0.equipClick = gohelper.getClick(arg_32_0._simageequipicon.gameObject)

		arg_32_0.equipClick:AddClickListener(arg_32_0.onEquipClick, arg_32_0)
	end

	gohelper.setActive(arg_32_0._goequip, arg_32_0.equipMO)
	gohelper.setActive(arg_32_0._goplayerequipinfo, arg_32_0.equipMO)
end

function var_0_0._equipIconLoaded(arg_33_0)
	arg_33_0._equipIconImage.enabled = true
end

function var_0_0.onEquipClick(arg_34_0)
	if arg_34_0.openEquipInfoTipView then
		return
	end

	arg_34_0:closeAllTips()
	gohelper.setActive(arg_34_0._godetailView, false)

	arg_34_0.openEquipInfoTipView = true

	ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
		notShowLockIcon = true,
		equipMo = arg_34_0.equipMO,
		heroCo = arg_34_0._entityMO:getCO()
	})
end

function var_0_0._refreshAttrList(arg_35_0, arg_35_1)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	arg_35_0._attrDataList = arg_35_1
	arg_35_0._curAttrMO = arg_35_0._attrEntityDic[arg_35_0._entityMO.id]

	if arg_35_0._curAttrMO then
		gohelper.CreateObjList(arg_35_0, arg_35_0._onMonsterAttrItemShow, arg_35_0._attrDataList, arg_35_0._goattributeroot)
	else
		FightRpc.instance:sendEntityInfoRequest(arg_35_0._entityMO.id)
	end
end

function var_0_0._onReceiveEntityInfoReply(arg_36_0, arg_36_1)
	arg_36_0._attrEntityDic[arg_36_1.entityInfo.uid] = arg_36_1.entityInfo.attr
	arg_36_0._curAttrMO = arg_36_0._attrEntityDic[arg_36_0._entityMO.id]

	if arg_36_0._curAttrMO then
		gohelper.CreateObjList(arg_36_0, arg_36_0._onMonsterAttrItemShow, arg_36_0._attrDataList, arg_36_0._goattributeroot)
	end
end

function var_0_0._getHeroBaseAttr(arg_37_0, arg_37_1)
	local var_37_0 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		table.insert(var_37_1, {
			id = HeroConfig.instance:getIDByAttrType(var_37_0[iter_37_0]),
			value = HeroConfig.instance:getHeroAttrRate(arg_37_1.id, iter_37_1)
		})
	end

	return var_37_1
end

function var_0_0._getMontBaseAttr(arg_38_0, arg_38_1)
	local var_38_0 = lua_monster_skill_template.configDict[arg_38_1.skillTemplate]
	local var_38_1 = CharacterDataConfig.instance:getMonsterAttributeScoreList(arg_38_1.id)

	table.insert(var_38_1, 2, table.remove(var_38_1, 4))

	local var_38_2 = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local var_38_3 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_1) do
		table.insert(var_38_3, {
			id = HeroConfig.instance:getIDByAttrType(var_38_2[iter_38_0]),
			value = iter_38_1
		})
	end

	return var_38_3
end

function var_0_0._onAttributeClick(arg_39_0)
	return
end

function var_0_0._refreshPassiveSkill(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:_releasePassiveSkillGOs()

	for iter_40_0 = 1, #arg_40_1 do
		local var_40_0 = arg_40_0._passiveSkillGOs[iter_40_0]

		if not var_40_0 then
			local var_40_1 = gohelper.cloneInPlace(arg_40_2, "item" .. iter_40_0)

			var_40_0 = arg_40_0:getUserDataTb_()
			var_40_0.go = var_40_1
			var_40_0.name = gohelper.findChildTextMesh(var_40_1, "tmp_talent")
			var_40_0.btn = gohelper.findChildButton(var_40_1, "#btn_enemypassive")

			table.insert(arg_40_0._passiveSkillGOs, var_40_0)
		end

		local var_40_2 = tonumber(arg_40_1[iter_40_0])
		local var_40_3 = lua_skill.configDict[var_40_2]

		var_40_0.btn:AddClickListener(arg_40_0._btnenemypassiveOnClick, arg_40_0)

		var_40_0.name.text = var_40_3.name

		gohelper.setActive(var_40_0.go, true)
	end

	for iter_40_1 = #arg_40_1 + 1, #arg_40_0._passiveSkillGOs do
		gohelper.setActive(arg_40_0._passiveSkillGOs[iter_40_1].go, false)
	end

	gohelper.setActive(arg_40_0._goenemypassive, #arg_40_1 > 0)

	arg_40_0._passiveSkillIds = arg_40_1

	local var_40_4 = arg_40_0._scrollenemypassive.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	local var_40_5 = 80
	local var_40_6 = math.ceil(#arg_40_1 / 3)
	local var_40_7 = 200

	if var_40_6 <= 2 then
		var_40_7 = var_40_5 * var_40_6
	end

	var_40_4.minHeight = var_40_7
end

function var_0_0._refreshCharacterPassiveSkill(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1:getCO()
	local var_41_1, var_41_2 = SkillConfig.instance:getHeroExSkillLevelByLevel(var_41_0.id, arg_41_1.level)
	local var_41_3 = {}
	local var_41_4 = arg_41_0:getPassiveSkillList(arg_41_1)

	if var_41_4 and #var_41_4 > 0 then
		gohelper.setActive(arg_41_0._goplayerpassive, true)

		local var_41_5 = var_41_4[1]

		arg_41_0._txttalent.text = lua_skill.configDict[var_41_5].name

		for iter_41_0 = 1, #var_41_4 do
			local var_41_6 = iter_41_0 <= var_41_1

			gohelper.setActive(arg_41_0._playerpassiveGOList[iter_41_0], var_41_6)

			if var_41_6 then
				table.insert(var_41_3, FightHelper.getPassiveSkill(arg_41_1.id, var_41_4[iter_41_0]))
			end
		end

		for iter_41_1 = #var_41_4 + 1, #arg_41_0._playerpassiveGOList do
			gohelper.setActive(arg_41_0._playerpassiveGOList[iter_41_1], false)
		end
	end

	gohelper.setActive(arg_41_0._goplayerpassive, #var_41_3 > 0)

	arg_41_0._passiveSkillIds = var_41_3
end

function var_0_0.getPassiveSkillList(arg_42_0, arg_42_1)
	local var_42_0 = {}
	local var_42_1
	local var_42_2 = arg_42_1:getTrialAttrCo()

	if var_42_2 then
		var_42_1 = arg_42_1.modelId

		local var_42_3 = string.splitToNumber(var_42_2.passiveSkill, "|")

		for iter_42_0, iter_42_1 in ipairs(var_42_3) do
			table.insert(var_42_0, iter_42_1)
		end
	else
		var_42_1 = arg_42_1:getCO().id

		local var_42_4 = arg_42_1.exSkillLevel
		local var_42_5 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(var_42_1, var_42_4)

		for iter_42_2, iter_42_3 in ipairs(var_42_5) do
			table.insert(var_42_0, iter_42_3.skillPassive)
		end
	end

	local var_42_6 = FightModel.instance:getFightParam()
	local var_42_7 = var_42_6 and var_42_6:getCurEpisodeConfig()

	if var_42_7 and var_42_7.type == DungeonEnum.EpisodeType.BossRush then
		local var_42_8 = BossRushConfig.instance:getEpisodeCoByEpisodeId(var_42_7.id)

		if var_42_8 and var_42_8.enhanceRole == 1 then
			var_42_0 = arg_42_0:exchangeHeroPassiveSkill(var_42_0, var_42_1)
		end
	end

	return var_42_0
end

function var_0_0.exchangeHeroPassiveSkill(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_1 then
		return arg_43_1
	end

	if not arg_43_2 then
		return arg_43_1
	end

	for iter_43_0, iter_43_1 in ipairs(lua_activity128_enhance.configList) do
		if iter_43_1.characterId == arg_43_2 then
			local var_43_0 = FightStrUtil.splitString2(iter_43_1.exchangeSkills, true)

			if var_43_0 then
				for iter_43_2, iter_43_3 in ipairs(arg_43_1) do
					for iter_43_4, iter_43_5 in ipairs(var_43_0) do
						if iter_43_5[1] == iter_43_3 then
							arg_43_1[iter_43_2] = iter_43_5[2]
						end
					end
				end
			end

			return arg_43_1
		end
	end

	return arg_43_1
end

function var_0_0._refreshSkill(arg_44_0, arg_44_1)
	local var_44_0
	local var_44_1
	local var_44_2

	for iter_44_0 = 1, #arg_44_1 do
		if iter_44_0 > #arg_44_0._skillGOs then
			logError("技能超过支持显示数量")

			break
		end

		local var_44_3 = arg_44_0._skillGOs[iter_44_0]
		local var_44_4 = arg_44_1[iter_44_0][1]
		local var_44_5 = lua_skill.configDict[var_44_4]

		if not var_44_5 then
			logError("技能表找不到id:" .. var_44_4)

			return
		end

		var_44_3.icon:LoadImage(ResUrl.getSkillIcon(var_44_5.icon))
		var_44_3.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_44_5.showTag))

		local var_44_6 = {}

		var_44_6.super = false
		var_44_6.skillIdList = arg_44_1[iter_44_0]
		var_44_6.skillIndex = iter_44_0
		var_44_3.info = var_44_6

		gohelper.setActive(var_44_3.go, true)
	end

	for iter_44_1 = #arg_44_1 + 1, #arg_44_0._skillGOs do
		gohelper.setActive(arg_44_0._skillGOs[iter_44_1].go, false)
	end
end

function var_0_0._refreshSuper(arg_45_0, arg_45_1)
	if arg_45_1 and #arg_45_1 > 0 then
		local var_45_0
		local var_45_1
		local var_45_2

		for iter_45_0 = 1, #arg_45_1 do
			local var_45_3 = arg_45_0._superItemList[iter_45_0]

			if not var_45_3 then
				logError("技能超过支持显示数量 : " .. table.concat(arg_45_1, "|"))

				return
			end

			gohelper.setActive(var_45_3.go, true)

			local var_45_4 = arg_45_1[iter_45_0]
			local var_45_5 = lua_skill.configDict[var_45_4]

			var_45_3.icon:LoadImage(ResUrl.getSkillIcon(var_45_5.icon))

			local var_45_6 = {}

			var_45_6.super = true
			var_45_6.skillIdList = {
				var_45_4
			}
			var_45_6.skillIndex = CharacterEnum.skillIndex.SkillEx
			var_45_3.info = var_45_6
		end
	end

	for iter_45_1 = #arg_45_1 + 1, #arg_45_0._superItemList do
		gohelper.setActive(arg_45_0._superItemList[iter_45_1].go, false)
	end
end

function var_0_0._refreshMO(arg_46_0, arg_46_1)
	arg_46_0:_refreshHp(arg_46_1)
	arg_46_0:_refreshBuff(arg_46_1)

	if arg_46_1:isMonster() then
		local var_46_0 = arg_46_1:getCO()

		if FightHelper.isBossId(arg_46_0:_getBossId(), var_46_0.id) then
			arg_46_0:_refreshEnemyPassiveSkill(var_46_0)
		else
			gohelper.setActive(arg_46_0._goenemypassiveSkill, false)
		end
	end
end

function var_0_0._refreshEnemyPassiveSkill(arg_47_0, arg_47_1)
	arg_47_0._bossSkillInfos = {}

	local var_47_0 = FightConfig.instance:getPassiveSkillsAfterUIFilter(arg_47_1.id)
	local var_47_1 = FightConfig.instance:_filterSpeicalSkillIds(var_47_0, true)

	for iter_47_0 = 1, #var_47_1 do
		local var_47_2 = var_47_1[iter_47_0]
		local var_47_3 = lua_skill_specialbuff.configDict[var_47_2]

		if var_47_3 then
			local var_47_4 = arg_47_0._enemypassiveiconGOs[iter_47_0]

			if not var_47_4 then
				var_47_4 = arg_47_0:getUserDataTb_()
				var_47_4.go = gohelper.cloneInPlace(arg_47_0._enemypassiveSkillPrefab, "item" .. iter_47_0)
				var_47_4._gotag = gohelper.findChild(var_47_4.go, "tag")
				var_47_4._txttag = gohelper.findChildText(var_47_4.go, "tag/#txt_tag")

				table.insert(arg_47_0._enemypassiveiconGOs, var_47_4)

				local var_47_5 = gohelper.findChildImage(var_47_4.go, "icon")

				table.insert(arg_47_0._passiveiconImgs, var_47_5)
				gohelper.setActive(var_47_4.go, true)
			else
				gohelper.setActive(var_47_4.go, true)
			end

			if arg_47_0._bossSkillInfos[iter_47_0] == nil then
				arg_47_0._bossSkillInfos[iter_47_0] = {
					skillId = var_47_2,
					icon = var_47_3.icon
				}
			end

			if not string.nilorempty(var_47_3.lv) then
				gohelper.setActive(var_47_4._gotag, true)

				var_47_4._txttag.text = var_47_3.lv
			else
				gohelper.setActive(var_47_4._gotag, false)
			end

			if string.nilorempty(var_47_3.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. var_47_3.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(arg_47_0._passiveiconImgs[iter_47_0], var_47_3.icon)
		end
	end

	if #var_47_1 < #arg_47_0._enemypassiveiconGOs then
		for iter_47_1 = #var_47_1 + 1, #arg_47_0._enemypassiveiconGOs do
			gohelper.setActive(arg_47_0._enemypassiveiconGOs[iter_47_1].go, false)
		end
	end

	if #arg_47_0._bossSkillInfos > 0 then
		gohelper.setActive(arg_47_0._goenemypassiveSkill, true)
	else
		gohelper.setActive(arg_47_0._goenemypassiveSkill, false)
	end

	gohelper.setAsLastSibling(arg_47_0._btnenemypassiveSkill.gameObject)
	arg_47_0._btnenemypassiveSkill:AddClickListener(arg_47_0._onBuffPassiveSkillClick, arg_47_0)
end

function var_0_0._onBuffPassiveSkillClick(arg_48_0)
	if arg_48_0._isbuffviewopen then
		return
	end

	arg_48_0:closeAllTips()
	arg_48_0:_hideDetail()

	local var_48_0

	if arg_48_0._bossSkillInfos then
		for iter_48_0, iter_48_1 in pairs(arg_48_0._bossSkillInfos) do
			local var_48_1 = iter_48_1.skillId
			local var_48_2 = arg_48_0._enemybuffpassiveGOs[iter_48_0]

			if not var_48_2 then
				var_48_2 = arg_48_0:getUserDataTb_()
				var_48_2.go = gohelper.cloneInPlace(arg_48_0._gobuffpassiveitem, "item" .. iter_48_0)

				table.insert(arg_48_0._enemybuffpassiveGOs, var_48_2)

				local var_48_3 = gohelper.findChildImage(var_48_2.go, "title/simage_icon")

				table.insert(arg_48_0._passiveSkillImgs, var_48_3)
				gohelper.setActive(var_48_2.go, true)
			else
				gohelper.setActive(var_48_2.go, true)
			end

			local var_48_4 = gohelper.findChild(var_48_2.go, "txt_desc/image_line")

			gohelper.setActive(var_48_4, true)
			arg_48_0:_setPassiveSkillTip(var_48_2.go, iter_48_1)
			UISpriteSetMgr.instance:setFightPassiveSprite(arg_48_0._passiveSkillImgs[iter_48_0], iter_48_1.icon)
		end

		if #arg_48_0._bossSkillInfos < #arg_48_0._enemybuffpassiveGOs then
			for iter_48_2 = #arg_48_0._bossSkillInfos + 1, #arg_48_0._enemybuffpassiveGOs do
				gohelper.setActive(arg_48_0._enemybuffpassiveGOs[iter_48_2], false)
			end
		end

		local var_48_5 = gohelper.findChild(arg_48_0._enemybuffpassiveGOs[#arg_48_0._bossSkillInfos].go, "txt_desc/image_line")

		gohelper.setActive(var_48_5, false)
		gohelper.setActive(arg_48_0._gobuffpassiveview, true)

		arg_48_0._isbuffviewopen = true
	end
end

function var_0_0._setPassiveSkillTip(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = gohelper.findChildText(arg_49_1, "title/txt_name")
	local var_49_1 = gohelper.findChildText(arg_49_1, "txt_desc")

	SkillHelper.addHyperLinkClick(var_49_1, arg_49_0.onClickHyperLink, arg_49_0)

	local var_49_2 = lua_skill.configDict[arg_49_2.skillId]

	var_49_0.text = var_49_2.name
	var_49_1.text = SkillHelper.getEntityDescBySkillCo(arg_49_0._curSelectId, var_49_2, "#CC492F", "#485E92")
end

function var_0_0.onClickPassiveHyperLink(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.commonBuffTipAnchorPos = arg_50_0.commonBuffTipAnchorPos or Vector2(-387.28, 168.6)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_50_1, arg_50_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0._refreshHp(arg_51_0, arg_51_1)
	local var_51_0 = math.max(arg_51_1.currentHp, 0)
	local var_51_1 = arg_51_1.attrMO and math.max(arg_51_1.attrMO.hp, 0)
	local var_51_2 = var_51_1 > 0 and var_51_0 / var_51_1 or 0

	arg_51_0._txthp.text = string.format("%d/%d", var_51_0, var_51_1)

	arg_51_0._sliderhp:SetValue(var_51_2)
end

function var_0_0._refreshBuff(arg_52_0, arg_52_1)
	local var_52_0 = arg_52_1:getBuffList()
	local var_52_1 = FightBuffHelper.filterBuffType(var_52_0, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(var_52_1)
	table.sort(var_52_1, function(arg_53_0, arg_53_1)
		if arg_53_0.time ~= arg_53_1.time then
			return arg_53_0.time < arg_53_1.time
		end

		return arg_53_0.id < arg_53_1.id
	end)

	local var_52_2 = var_52_1 and #var_52_1 or 0
	local var_52_3 = 0
	local var_52_4 = 0

	for iter_52_0 = 1, var_52_2 do
		local var_52_5 = var_52_1[iter_52_0]
		local var_52_6 = lua_skill_buff.configDict[var_52_5.buffId]

		if var_52_6 and var_52_6.isNoShow == 0 then
			var_52_3 = var_52_3 + 1

			local var_52_7 = arg_52_0._buffTables[var_52_3]

			if not var_52_7 then
				local var_52_8 = gohelper.cloneInPlace(arg_52_0._gobuffitem, "item" .. var_52_3)

				var_52_7 = MonoHelper.addNoUpdateLuaComOnceToGo(var_52_8, FightBuffItem)
				arg_52_0._buffTables[var_52_3] = var_52_7
			end

			var_52_7:updateBuffMO(var_52_5)
			var_52_7:setClickCallback(arg_52_0._onClickBuff, arg_52_0)
			gohelper.setActive(arg_52_0._buffTables[var_52_3].go, true)
		end
	end

	for iter_52_1 = var_52_3 + 1, #arg_52_0._buffTables do
		gohelper.setActive(arg_52_0._buffTables[iter_52_1].go, false)
	end

	gohelper.setActive(arg_52_0._scrollbuff.gameObject, var_52_3 > 0)
	gohelper.setActive(arg_52_0._btnBuffMore, var_52_3 > 6)
end

function var_0_0._onClickBuff(arg_54_0, arg_54_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)

	arg_54_1 = arg_54_1 or arg_54_0._entityMO.id

	arg_54_0:closeAllTips()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, arg_54_1)

	if arg_54_0._hadPopUp then
		arg_54_0:_hideDetail()

		arg_54_0._hadPopUp = false
	end
end

function var_0_0._showPassiveDetail(arg_55_0)
	arg_55_0:closeAllTips()

	if arg_55_0._passiveSkillIds and #arg_55_0._passiveSkillIds > 0 then
		gohelper.setActive(arg_55_0._godetailView, true)
		arg_55_0:_refreshPassiveDetail()

		arg_55_0._hadPopUp = true
	end
end

function var_0_0.refreshScrollEnemy(arg_56_0)
	arg_56_0:_releaseHeadItemList()

	arg_56_0.enemyItemList = {}

	gohelper.setActive(arg_56_0.goScrollEnemy, true)

	local var_56_0

	for iter_56_0, iter_56_1 in ipairs(arg_56_0._entityList) do
		local var_56_1 = arg_56_0.enemyItemList[iter_56_0] or arg_56_0:createEnemyItem()

		gohelper.setActive(var_56_1.go, true)

		var_56_1.entityMo = iter_56_1

		local var_56_2 = iter_56_1:getCO()
		local var_56_3 = iter_56_1:getSpineSkinCO()

		if var_56_2 then
			UISpriteSetMgr.instance:setEnemyInfoSprite(var_56_1.imageCareer, "sxy_" .. tostring(var_56_2.career))
		end

		gohelper.getSingleImage(var_56_1.imageIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_56_3.headIcon))

		if var_56_2 and var_56_2.heartVariantId and var_56_2.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(var_56_2.heartVariantId), var_56_1.imageIcon)
		end

		gohelper.setActive(var_56_1.goBossTag, arg_56_0.bossIdDict[var_56_2.id])

		if iter_56_1.side ~= FightEnum.EntitySide.MySide then
			transformhelper.setLocalRotation(var_56_1.imageIcon.transform, 0, 180, 0)
		else
			transformhelper.setLocalRotation(var_56_1.imageIcon.transform, 0, 0, 0)
		end
	end

	for iter_56_2 = #arg_56_0._entityList + 1, #arg_56_0.enemyItemList do
		gohelper.setActive(arg_56_0.enemyItemList[iter_56_2].go, false)
	end
end

function var_0_0.refreshScrollEnemySelectStatus(arg_57_0)
	if arg_57_0.enemyItemList then
		for iter_57_0, iter_57_1 in ipairs(arg_57_0.enemyItemList) do
			local var_57_0 = arg_57_0._entityMO.uid == iter_57_1.entityMo.uid

			gohelper.setActive(iter_57_1.goSelectFrame, var_57_0)

			local var_57_1 = arg_57_0._entityMO.uid == iter_57_1.entityMo.uid and "#ffffff" or "#8C8C8C"
			local var_57_2 = arg_57_0._entityMO.uid == iter_57_1.entityMo.uid and "#ffffff" or "#828282"

			SLFramework.UGUI.GuiHelper.SetColor(iter_57_1.imageIcon, var_57_1)
			SLFramework.UGUI.GuiHelper.SetColor(iter_57_1.imageCareer, var_57_2)

			if var_57_0 then
				local var_57_3 = -106 - 193 * (iter_57_0 - 1) + recthelper.getAnchorY(arg_57_0.goScrollEnemyContent.transform) + arg_57_0._entityScrollHeight / 2
				local var_57_4 = recthelper.getHeight(iter_57_1.go.transform)
				local var_57_5 = var_57_3 - var_57_4
				local var_57_6 = var_57_3 + var_57_4
				local var_57_7 = arg_57_0._entityScrollHeight / 2

				if var_57_5 < -var_57_7 then
					local var_57_8 = var_57_5 + var_57_7

					recthelper.setAnchorY(arg_57_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_57_0.goScrollEnemyContent.transform) - var_57_8 - 54)
				end

				if var_57_7 < var_57_6 then
					local var_57_9 = var_57_6 - var_57_7

					recthelper.setAnchorY(arg_57_0.goScrollEnemyContent.transform, recthelper.getAnchorY(arg_57_0.goScrollEnemyContent.transform) - var_57_9 + 54)
				end
			end

			gohelper.setActive(iter_57_1.subTag, FightDataHelper.entityMgr:isSub(iter_57_1.entityMo.uid))
		end
	end
end

function var_0_0.createEnemyItem(arg_58_0)
	local var_58_0 = arg_58_0:getUserDataTb_()

	var_58_0.go = gohelper.cloneInPlace(arg_58_0.contentEnemyItem)
	var_58_0.imageIcon = gohelper.findChildImage(var_58_0.go, "item/icon")
	var_58_0.goBossTag = gohelper.findChild(var_58_0.go, "item/bosstag")
	var_58_0.imageCareer = gohelper.findChildImage(var_58_0.go, "item/career")
	var_58_0.goSelectFrame = gohelper.findChild(var_58_0.go, "item/go_selectframe")
	var_58_0.subTag = gohelper.findChild(var_58_0.go, "item/#go_SubTag")
	var_58_0.btnClick = gohelper.findChildButtonWithAudio(var_58_0.go, "item/btn_click")

	var_58_0.btnClick:AddClickListener(arg_58_0.onClickEnemyItem, arg_58_0, var_58_0)
	table.insert(arg_58_0.enemyItemList, var_58_0)

	return var_58_0
end

function var_0_0.onClickEnemyItem(arg_59_0, arg_59_1)
	if arg_59_1.entityMo.uid == arg_59_0._entityMO.uid then
		return
	end

	arg_59_0._curSelectId = arg_59_1.entityMo.id

	arg_59_0:closeAllTips()
	arg_59_0:_refreshUI()
	arg_59_0._ani:Play("switch", nil, nil)
end

function var_0_0.closeAllTips(arg_60_0)
	arg_60_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_60_0._godetailView, false)
	gohelper.setActive(arg_60_0._gobuffpassiveview, false)

	arg_60_0._isbuffviewopen = false

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

	arg_60_0.openEquipInfoTipView = false
	arg_60_0.openFightAttributeTipView = false
end

function var_0_0._showSkillDetail(arg_61_0, arg_61_1)
	arg_61_0:closeAllTips()
	arg_61_0.viewContainer:showSkillTipView(arg_61_1, arg_61_0.isCharacter, arg_61_0._curSelectId)

	arg_61_0._hadPopUp = true
end

function var_0_0._hideDetail(arg_62_0)
	arg_62_0.viewContainer:hideSkillTipView()
	gohelper.setActive(arg_62_0._godetailView, false)
	gohelper.setActive(arg_62_0._gobuffpassiveview, false)

	arg_62_0._isbuffviewopen = false
end

function var_0_0._refreshPassiveDetail(arg_63_0)
	local var_63_0 = arg_63_0._passiveSkillIds
	local var_63_1 = #var_63_0
	local var_63_2 = arg_63_0:_checkDestinyEffect(var_63_0)

	for iter_63_0 = 1, var_63_1 do
		local var_63_3 = tonumber(var_63_2[iter_63_0])
		local var_63_4 = lua_skill.configDict[var_63_3]

		if var_63_4 then
			local var_63_5 = arg_63_0._detailPassiveTables[iter_63_0]

			if not var_63_5 then
				local var_63_6 = gohelper.cloneInPlace(arg_63_0._godetailpassiveitem, "item" .. iter_63_0)

				var_63_5 = arg_63_0:getUserDataTb_()
				var_63_5.go = var_63_6
				var_63_5.name = gohelper.findChildText(var_63_6, "title/txt_name")
				var_63_5.icon = gohelper.findChildSingleImage(var_63_6, "title/simage_icon")
				var_63_5.desc = gohelper.findChildText(var_63_6, "txt_desc")

				SkillHelper.addHyperLinkClick(var_63_5.desc, arg_63_0.onClickHyperLink, arg_63_0)

				var_63_5.line = gohelper.findChild(var_63_6, "txt_desc/image_line")

				table.insert(arg_63_0._detailPassiveTables, var_63_5)
			end

			var_63_5.name.text = var_63_4.name

			local var_63_7 = SkillHelper.getEntityDescBySkillCo(arg_63_0._curSelectId, var_63_4, "#CC492F", "#485E92")

			var_63_5.desc.text = var_63_7

			gohelper.setActive(var_63_5.go, true)
			gohelper.setActive(var_63_5.line, iter_63_0 < var_63_1)
		else
			logError(string.format("被动技能配置没找到, id: %d", var_63_3))
		end
	end

	for iter_63_1 = var_63_1 + 1, #arg_63_0._detailPassiveTables do
		gohelper.setActive(arg_63_0._detailPassiveTables[iter_63_1].go, false)
	end
end

function var_0_0._checkDestinyEffect(arg_64_0, arg_64_1)
	if arg_64_1 and arg_64_0._entityMO then
		local var_64_0 = arg_64_0._entityMO:getHeroDestinyStoneMo()

		if var_64_0 then
			arg_64_1 = var_64_0:_replaceSkill(arg_64_1)
		end
	end

	return arg_64_1
end

function var_0_0.onClickHyperLink(arg_65_0, arg_65_1, arg_65_2)
	arg_65_0.commonBuffTipAnchorPos = arg_65_0.commonBuffTipAnchorPos or Vector2(-389.14, 168.4)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_65_1, arg_65_0.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right)
end

function var_0_0._detectBossMultiHp(arg_66_0, arg_66_1)
	local var_66_0 = BossRushModel.instance:getBossEntityMO()

	arg_66_0._isBossRush = BossRushController.instance:isInBossRushInfiniteFight(true) and var_66_0 and var_66_0.id == arg_66_1.id

	local var_66_1 = arg_66_1.attrMO.multiHpNum

	if arg_66_0._isBossRush then
		var_66_1 = BossRushModel.instance:getMultiHpInfo().multiHpNum
	end

	gohelper.setActive(arg_66_0._multiHpRoot, var_66_1 > 1)

	if var_66_1 > 1 then
		arg_66_0:com_createObjList(arg_66_0._onMultiHpItemShow, var_66_1, arg_66_0._multiHpRoot, arg_66_0._multiHpItem)
	end
end

function var_0_0._onMultiHpItemShow(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	local var_67_0 = arg_67_0._entityMO.attrMO.multiHpNum
	local var_67_1 = arg_67_0._entityMO.attrMO:getCurMultiHpIndex()

	if arg_67_0._isBossRush then
		local var_67_2 = BossRushModel.instance:getMultiHpInfo()

		var_67_0 = var_67_2.multiHpNum
		var_67_1 = var_67_2.multiHpIdx
	end

	local var_67_3 = gohelper.findChild(arg_67_1, "hp")

	gohelper.setActive(var_67_3, arg_67_3 <= var_67_0 - var_67_1)

	if arg_67_3 == 1 and arg_67_0._isBossRush then
		gohelper.setActive(var_67_3, true)
	end
end

function var_0_0._onCloseView(arg_68_0, arg_68_1)
	if arg_68_1 == ViewName.EquipInfoTipsView then
		arg_68_0.openEquipInfoTipView = false
	end

	if arg_68_1 == ViewName.FightAttributeTipView then
		arg_68_0.openFightAttributeTipView = false
	end
end

function var_0_0.onClose(arg_69_0)
	TaskDispatcher.cancelTask(arg_69_0._refreshUI, arg_69_0)
	arg_69_0:_releaseTween()

	if arg_69_0._focusFlow then
		arg_69_0._focusFlow:stop()

		arg_69_0._focusFlow = nil
	end

	if arg_69_0.subEntityList then
		for iter_69_0, iter_69_1 in ipairs(arg_69_0.subEntityList) do
			GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(iter_69_1:getTag(), iter_69_1.id)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, true)
	arg_69_0:setAssistBossStatus(false, true)
end

function var_0_0.onDestroyView(arg_70_0)
	FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	arg_70_0._simagebg:UnLoadImage()

	for iter_70_0 = 1, #arg_70_0._skillGOs do
		local var_70_0 = arg_70_0._skillGOs[iter_70_0]

		var_70_0.icon:UnLoadImage()
		var_70_0.btn:RemoveClickListener()
	end

	for iter_70_1, iter_70_2 in ipairs(arg_70_0._superItemList) do
		iter_70_2.icon:UnLoadImage()
		iter_70_2.btn:RemoveClickListener()
	end

	arg_70_0._superItemList = nil

	arg_70_0._simageequipicon:UnLoadImage()

	if arg_70_0.equipClick then
		arg_70_0.equipClick:RemoveClickListener()
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_70_0._onCloseView, arg_70_0)
	arg_70_0:_releaseHeadItemList()
	arg_70_0.resistanceComp:destroy()

	arg_70_0.resistanceComp = nil

	arg_70_0:removeStressComp()

	if arg_70_0._assistBossView then
		arg_70_0._assistBossView:destory()

		arg_70_0._assistBossView = nil
	end
end

function var_0_0.removeStressComp(arg_71_0)
	if arg_71_0.stressComp then
		arg_71_0.stressComp:destroy()

		arg_71_0.stressComp = nil
	end
end

function var_0_0._releaseHeadItemList(arg_72_0)
	if arg_72_0.enemyItemList then
		for iter_72_0, iter_72_1 in ipairs(arg_72_0.enemyItemList) do
			iter_72_1.btnClick:RemoveClickListener()
			gohelper.destroy(iter_72_1.go)
		end

		arg_72_0.enemyItemList = nil
	end
end

function var_0_0._setVirtualCameDamping(arg_73_0)
	FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
end

function var_0_0._setEntityPosAndActive(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_1.id
	local var_74_1 = false
	local var_74_2 = FightHelper.getEntity(var_74_0)

	if var_74_2 then
		local var_74_3 = var_74_2:getMO()

		if var_74_3 then
			local var_74_4 = FightConfig.instance:getSkinCO(var_74_3.skin)

			if var_74_4 and var_74_4.canHide == 1 then
				var_74_1 = true
			end
		end
	end

	local var_74_5 = FightHelper.getAllEntitys()

	for iter_74_0, iter_74_1 in ipairs(var_74_5) do
		if not FightHelper.isAssembledMonster(iter_74_1) then
			iter_74_1:setVisibleByPos(var_74_1 or var_74_0 == iter_74_1.id)
		elseif arg_74_1.side ~= iter_74_1:getSide() then
			iter_74_1:setVisibleByPos(var_74_1 or var_74_0 == iter_74_1.id)
		else
			iter_74_1:setVisibleByPos(true)
		end

		if iter_74_1.buff then
			if var_74_0 ~= iter_74_1.id then
				iter_74_1.buff:hideBuffEffects()
			else
				iter_74_1.buff:showBuffEffects()
			end
		end

		if iter_74_1.nameUI then
			iter_74_1.nameUI:setActive(var_74_0 == iter_74_1.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	local var_74_6

	if arg_74_1.side == FightEnum.EntitySide.MySide then
		local var_74_7 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
		local var_74_8 = FightHelper.getEntityStanceId(arg_74_1, FightModel.instance:getCurWaveId())
		local var_74_9 = lua_stance.configDict[var_74_8].pos1

		var_74_6 = var_74_9

		for iter_74_2, iter_74_3 in ipairs(var_74_7) do
			if iter_74_3.id == arg_74_1.id then
				transformhelper.setLocalPos(iter_74_3.go.transform, var_74_9[1], var_74_9[2], var_74_9[3])

				if iter_74_3.buff then
					iter_74_3.buff:hideBuffEffects()
					iter_74_3.buff:showBuffEffects()
				end
			else
				iter_74_3:setVisibleByPos(false)
			end
		end

		for iter_74_4, iter_74_5 in ipairs(arg_74_0.subEntityList) do
			transformhelper.setLocalPos(iter_74_5.go.transform, 20000, 20000, 20000)
		end
	end

	local var_74_10 = FightHelper.getEntity(var_74_0)
	local var_74_11 = FightDataHelper.entityMgr:isSub(var_74_0)

	if var_74_11 then
		var_74_10 = nil

		for iter_74_6, iter_74_7 in ipairs(arg_74_0.subEntityList) do
			if iter_74_7.id == var_74_0 .. "focusSub" then
				local var_74_12 = FightHelper.getEntity(var_74_0)

				if var_74_12 then
					var_74_12:setVisibleByPos(false)
				end

				var_74_10 = iter_74_7

				transformhelper.setLocalPos(iter_74_7.go.transform, var_74_6[1], var_74_6[2], var_74_6[3])
			end
		end
	end

	if var_74_10 then
		local var_74_13 = var_74_10:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
		local var_74_14, var_74_15, var_74_16 = transformhelper.getPos(var_74_13.transform)
		local var_74_17 = var_74_14 + 2.7
		local var_74_18 = var_74_15 - 2
		local var_74_19 = var_74_16 + 5.4
		local var_74_20

		if var_74_11 then
			var_74_20 = FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getById(var_74_0).skin)
		else
			var_74_20 = FightConfig.instance:getSkinCO(var_74_10:getMO().skin)
		end

		local var_74_21 = var_74_20.focusOffset

		if #var_74_21 == 3 then
			var_74_17 = var_74_17 + var_74_21[1]
			var_74_18 = var_74_18 + var_74_21[2]
			var_74_19 = var_74_19 + var_74_21[3]
		end

		arg_74_0:_releaseTween()

		local var_74_22 = CameraMgr.instance:getVirtualCameraTrs()

		transformhelper.setPos(var_74_22, var_74_17 + 0.2, var_74_18, var_74_19)
	end
end

function var_0_0._releaseTween(arg_75_0)
	if arg_75_0._tweenId then
		ZProj.TweenHelper.KillById(arg_75_0._tweenId)
	end
end

function var_0_0._playCameraTween(arg_76_0)
	local var_76_0 = CameraMgr.instance:getVirtualCameraTrs()
	local var_76_1, var_76_2, var_76_3 = transformhelper.getPos(var_76_0)

	arg_76_0._tweenId = ZProj.TweenHelper.DOMove(var_76_0, var_76_1 - 0.6, var_76_2, var_76_3, 0.5)
end

function var_0_0._focusEntity(arg_77_0, arg_77_1)
	if arg_77_0._focusFlow then
		arg_77_0._focusFlow:stop()

		arg_77_0._focusFlow = nil
	end

	arg_77_0._focusFlow = FlowSequence.New()

	arg_77_0._focusFlow:addWork(FunctionWork.New(arg_77_0._setVirtualCameDamping, arg_77_0))
	arg_77_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_77_0._focusFlow:addWork(FightWorkFocusSubEntity.New(arg_77_1))
	arg_77_0._focusFlow:addWork(FunctionWork.New(arg_77_0._setEntityPosAndActive, arg_77_0, arg_77_1))
	arg_77_0._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	arg_77_0._focusFlow:addWork(FunctionWork.New(arg_77_0._playCameraTween, arg_77_0))
	arg_77_0._focusFlow:addWork(WorkWaitSeconds.New(0.5))

	local var_77_0 = {
		subEntityList = arg_77_0.subEntityList
	}

	arg_77_0._focusFlow:start(var_77_0)
end

function var_0_0._onBtnBuffMore(arg_78_0)
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, arg_78_0._curSelectId)
end

function var_0_0.refreshDouQuQuFetter(arg_79_0)
	local var_79_0 = FightDataHelper.fieldMgr.customData

	if not var_79_0 then
		return
	end

	if var_79_0[FightCustomData.CustomDataType.Act191] then
		if arg_79_0.douQuQuFetterView then
			arg_79_0.douQuQuFetterView:refreshEntityMO(arg_79_0._entityMO)
		else
			arg_79_0.douQuQuFetterView = arg_79_0:com_openSubView(FightDouQuQuFetterView, "ui/viewres/fight/fight_act191fetterview.prefab", arg_79_0.go_fetter, arg_79_0._entityMO)
		end
	end
end

function var_0_0.refreshDouQuQuStar(arg_80_0)
	gohelper.setActive(arg_80_0.levelRoot, false)
end

function var_0_0.refreshDouQuQuCollection(arg_81_0)
	local var_81_0 = FightDataHelper.fieldMgr.customData

	if not var_81_0 then
		return
	end

	if var_81_0[FightCustomData.CustomDataType.Act191] then
		gohelper.setActive(arg_81_0.go_collection, true)

		if arg_81_0.douQuQuCollectionView then
			arg_81_0.douQuQuCollectionView:refreshEntityMO(arg_81_0._entityMO)
		else
			arg_81_0.douQuQuCollectionView = arg_81_0:com_openSubView(FightDouQuQuCollectionView, "ui/viewres/fight/fight_act191collectionview.prefab", arg_81_0.go_collection, arg_81_0._entityMO)
		end
	end
end

return var_0_0
