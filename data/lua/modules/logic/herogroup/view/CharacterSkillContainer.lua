module("modules.logic.herogroup.view.CharacterSkillContainer", package.seeall)

local var_0_0 = class("CharacterSkillContainer", LuaCompBase)
local var_0_1 = "ReplaceSkill"
local var_0_2 = "ndk"
local var_0_3 = "CharacterSkillContainer_Click"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goskills = gohelper.findChild(arg_1_1, "line/go_skills")
	arg_1_0._skillitems = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		local var_1_0 = gohelper.findChild(arg_1_0._goskills, "skillicon" .. tostring(iter_1_0))
		local var_1_1 = {
			icon = gohelper.findChildSingleImage(var_1_0, "imgIcon"),
			tag = gohelper.findChildSingleImage(var_1_0, "tag/tagIcon"),
			btn = gohelper.findChildButtonWithAudio(var_1_0, "bg", AudioEnum.UI.Play_ui_role_description),
			index = iter_1_0,
			go = var_1_0
		}

		var_1_1.btn:AddClickListener(arg_1_0._onSkillCardClick, arg_1_0, var_1_1.index)

		arg_1_0._skillitems[iter_1_0] = var_1_1
	end

	arg_1_0._reddot = gohelper.findChild(arg_1_1, "line/#RedDot")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animationEvent = arg_1_1:GetComponent(typeof(ZProj.AnimationEventWrap))

	if arg_1_0._animationEvent then
		arg_1_0._animationEvent:AddEventListener(var_0_1, arg_1_0._replaceSkill, arg_1_0)
	end

	if arg_1_0._anim then
		arg_1_0._animationPlayer = SLFramework.AnimatorPlayer.Get(arg_1_1)
	end
end

function var_0_0.onDestroy(arg_2_0)
	for iter_2_0 = 1, 3 do
		arg_2_0._skillitems[iter_2_0].btn:RemoveClickListener()
		arg_2_0._skillitems[iter_2_0].icon:UnLoadImage()
		arg_2_0._skillitems[iter_2_0].tag:UnLoadImage()
	end

	if arg_2_0._animationEvent then
		arg_2_0._animationEvent:RemoveEventListener(var_0_1)
	end
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._heroId = arg_3_1
	arg_3_0._heroName = HeroConfig.instance:getHeroCO(arg_3_0._heroId).name
	arg_3_0._heroMo = arg_3_3
	arg_3_0._isBalance = arg_3_4
	arg_3_0._showAttributeOption = arg_3_2 or CharacterEnum.showAttributeOption.ShowCurrent

	arg_3_0:_refreshSkillUI()
end

function var_0_0._refreshSkillUI(arg_4_0)
	if arg_4_0._heroId then
		local var_4_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_4_0._heroId, arg_4_0._showAttributeOption, arg_4_0._heroMo)

		arg_4_0:_showSkillUI(var_4_0)
	end
end

function var_0_0._showSkillUI(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_0 = iter_5_1 ~= 0

		if var_5_0 then
			local var_5_1 = lua_skill.configDict[iter_5_1]

			if not var_5_1 then
				logError(string.format("heroID : %s, skillId not found : %s", arg_5_0._heroId, iter_5_1))
			end

			arg_5_0._skillitems[iter_5_0].icon:LoadImage(ResUrl.getSkillIcon(var_5_1.icon))
			arg_5_0._skillitems[iter_5_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_5_1.showTag))
			gohelper.setActive(arg_5_0._skillitems[iter_5_0].tag.gameObject, iter_5_0 ~= 3)
		end

		gohelper.setActive(arg_5_0._skillitems[iter_5_0].go.gameObject, var_5_0)
	end
end

function var_0_0._onSkillCardClick(arg_6_0, arg_6_1)
	if arg_6_0._heroId then
		local var_6_0 = {}
		local var_6_1 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_6_0._heroId, arg_6_0._showAttributeOption, arg_6_0._heroMo)

		var_6_0.super = arg_6_1 == 3
		var_6_0.skillIdList = var_6_1[arg_6_1]
		var_6_0.isBalance = arg_6_0._isBalance
		var_6_0.monsterName = arg_6_0._heroName
		var_6_0.heroId = arg_6_0._heroId
		var_6_0.heroMo = arg_6_0._heroMo
		var_6_0.skillIndex = arg_6_1

		ViewMgr.instance:openView(ViewName.SkillTipView, var_6_0)

		local var_6_2, var_6_3 = CharacterModel.instance:isNeedShowNewSkillReddot(arg_6_0._heroMo)

		if var_6_2 and var_6_3 then
			PlayerModel.instance:setPropKeyValue(PlayerEnum.SimpleProperty.NuoDiKaNewSkill, arg_6_0._heroId, 1)

			local var_6_4 = PlayerModel.instance:getPropKeyValueString(PlayerEnum.SimpleProperty.NuoDiKaNewSkill)

			PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.NuoDiKaNewSkill, var_6_4)
		end

		arg_6_0:_showSkillReddot(false)
	end
end

function var_0_0._replaceSkill(arg_7_0)
	CharacterModel.instance:setPlayReplaceSkillAnim(arg_7_0._heroMo)
	arg_7_0:_refreshSkillUI()
end

function var_0_0.onFinishreplaceSkillAnim(arg_8_0)
	if arg_8_0._isPlayReplaceSkillAnim then
		UIBlockMgr.instance:endBlock(var_0_3)

		arg_8_0._isPlayReplaceSkillAnim = nil
	end
end

function var_0_0.checkShowReplaceBeforeSkillUI(arg_9_0)
	if not arg_9_0._anim then
		return
	end

	if arg_9_0._heroMo then
		local var_9_0, var_9_1 = CharacterModel.instance:isCanPlayReplaceSkillAnim(arg_9_0._heroMo)

		var_9_0 = var_9_0 and arg_9_0._heroMo:isOwnHero()
		var_9_1 = var_9_1 and arg_9_0._heroMo:isOwnHero()

		if var_9_0 then
			local var_9_2 = arg_9_0._heroMo.config
			local var_9_3 = var_9_2.skill
			local var_9_4 = var_9_2.exSkill
			local var_9_5 = SkillConfig.instance:getHeroBaseSkillIdDictByStr(var_9_3, var_9_4)

			arg_9_0:_showSkillUI(var_9_5)
			arg_9_0._animationPlayer:Play(var_0_2, arg_9_0.onFinishreplaceSkillAnim, arg_9_0)
			UIBlockMgrExtend.setNeedCircleMv(false)
			UIBlockMgr.instance:startBlock(var_0_3)
			TaskDispatcher.runDelay(arg_9_0.playNuodikaReplaceSkillAudio, arg_9_0, 0.5)

			arg_9_0._isPlayReplaceSkillAnim = true
		end

		arg_9_0:_showSkillReddot(var_9_1)
	else
		arg_9_0:_showSkillReddot(false)
	end
end

function var_0_0.clearDelay(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.playNuodikaReplaceSkillAudio, arg_10_0)
end

function var_0_0.playNuodikaReplaceSkillAudio(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_nuodika)
end

function var_0_0._showSkillReddot(arg_12_0, arg_12_1)
	if arg_12_0._reddot then
		gohelper.setActive(arg_12_0._reddot.gameObject, arg_12_1)
	end
end

return var_0_0
