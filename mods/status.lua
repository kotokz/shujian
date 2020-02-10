hp = {
    jingxue = 0,
    jingxue_max = 0,
    jingxue_per = 0,
    jingli = 0,
    jingli_max = 0,
    jingli_lim = 0,
    qixue = 0,
    qixue_max = 0,
    qixue_per = 0,
    neili = 0,
    neili_max = 0,
    neili_lim = 0,
    food = 100,
    water = 100,
    pot = 0,
    pot_max = 0,
    exp = 0,
    heqi = 0,
    dazuo = 10,
    tuna = 10,
    shen = 0
}

score = {}
score.id = 'id'
score.name = 'name'
score.dex = 20
score.dex_t = 20
score.int = 20
score.int_t = 20
score.str = 20
score.str_t = 20
score.con = 20
score.con_t = 20
score.age = 14
score.gold = 0
score.tb = 0
score.yb = 0
score.jjb = 0

check_skills = function(n, l, w)

    local l_skills = " "
    if w[3] then l_skills = l_skills .. w[3] end
    if w[4] then l_skills = l_skills .. w[4] end
    if w[5] then l_skills = l_skills .. w[5] end
    l_skills = Trim(l_skills)
    skills[l_skills] = skills[l_skills] or {}
    skills[l_skills].lvl = tonumber(w[6])
    skills[l_skills].pot = tonumber(w[7])
    skills[l_skills].name = Trim(w[2])
    if skills[l_skills].lvl >= 450 then skills[l_skills].mstlvl = 450 end
    if l_skill == "force" and skills[l_skills].mstlvl < 450 and
        skills[l_skills].mstlvl == hp.pot_max - 101 then
        skills[l_skills].mstlvl = nil
    end

end

hp_jingxue_check = function(n, l, w)
    hp.jingxue = tonumber(w[1])
    hp.jingxue_max = tonumber(w[2])
    hp.jingxue_per = tonumber(w[3])
    hp.jingli = tonumber(w[4])
    hp.jingli_max = tonumber(w[5])
    hp.jingli_lim = tonumber(w[6])
end
hp_qixue_check = function(n, l, w)
    hp.qixue = tonumber(w[1])
    hp.qixue_max = tonumber(w[2])
    hp.qixue_per = tonumber(w[3])
    hp.neili = tonumber(w[4])
    hp.neili_max = tonumber(w[5])
end
hp_shen_check = function(n, l, w)
    local l_type = tostring(w[1])
    hp.shen = tonumber(del_string(tostring(w[2]), ','))
    hp.neili_lim = tonumber(w[3])
    if l_type == '戾' then hp.shen = hp.shen * -1 end
end
hp_pot_check = function(n, l, w)
    hp.food = tonumber(w[1])
    hp.pot = tonumber(w[2])
    hp.pot_max = tonumber(w[3])

    for p in pairs(skillEnable) do
        -- ain 200level->160
        q = skillEnable[p]
        if skills[p] and skills[q] then
            skills[p].full = 0

            if q == 'force' and (hp.pot < 50 or skills[p].lvl < 150) then
                skills[p].full = 1
            end
            -- if (skills[p].lvl==skills[q].lvl and skills[p].pot==(skills[p].lvl+1)*(skills[p].lvl+1)) or skills[p].lvl>skills[q].lvl then
            if skills[p].lvl >= skills[q].lvl then skills[p].full = 1 end
            if skills[p].fullever then skills[p].full = 1 end
            if skills[p].lvl >= hp.pot_max - 100 then
                skills[p].full = 1
            end
            if p == "wuxiang-zhi" then
                if not skills[p].olvl then
                    skills[p].olvl = skills[p].lvl
                end
                if skills[p].lvl > skills[p].olvl then
                    flag.wxjz = 0
                    skills[p].olvl = skills[p].lvl
                end
            end
            if p == "wuxiang-zhi" and (skills[p].lvl < 200 or flag.wxjz == 0) then
                skills[p].full = 1
            end
        end
    end
    if perform.force then
        if not skills[perform.force] then perform.force = nil end
    end
    if not perform.force then
        tmp.lvl = 0
        for p in pairs(skills) do
            q = skillEnable[p]
            if q == "force" then
                if skills[p].lvl > tmp.lvl then
                    tmp.lvl = skills[p].lvl
                    perform.force = p
                end
            end
        end
    end
    if skills["parry"] and skills["parry"].lvl < hp.pot_max - 100 and
        skills["parry"].lvl < 450 then flag.xuexi = 1 end
end
hp_exp_check = function(n, l, w)
    hp.water = tonumber(w[1])
    hp.exp = tonumber(del_string(tostring(w[2]), ','))
end
hp_dazuo_check = function(n, l, w)
    hp.dazuo = trans(w[1])
    exe('dazuo ' .. hp.dazuo)
end
score_tb_check = function(n, l, w)
    score.tb = tonumber(w[1])
    score.yb = tonumber(w[2])
    score.jjb = tonumber(w[3])
end
score_ebook_check = function(n, l, w) ebooktimes = trans(w[1]) end
score_name_check = function(n, l, w)
    if score.name == 'name' then score.name = tostring(w[1]) end
    if score.id == 'id' then score.id = string.lower(tostring(w[2])) end
    score.dex_t = tonumber(w[3])
    score.dex = tonumber(w[4])
    score.int_t = tonumber(w[5])
    score.int = tonumber(w[6])
end
score_title_check = function(n, l, w)
    score.title = Trim(tostring(w[1]))
    score.str_t = tonumber(w[2])
    score.str = tonumber(w[3])
    score.con_t = tonumber(w[4])
    score.con = tonumber(w[5])
end
score_age_check = function(n, l, w) score.age = trans(w[1]) end
score_gold_check = function(n, l, w)
    score.gold = trans(w[2])
    if score.gold == nil then score.gold = 0 end
end
score_party_check = function(n, l, w)
    score.party = w[3]
    score.master = w[4]
    if score.party == "普通百姓" then score.master = "普通百姓" end
end
score_check_xy = function(n, l, w)
    score.xiangyun = Trim(w[1]) -- 六个状态，生、旺、败、平、衰、死
    score.xiangyunvalue = tonumber(w[2])
    if not score.xiangyunvalue then score.xiangyunvalue = 0 end
    if scorexy == false then scorexy = smyteam * 1 end
    if SMY_ID[score.id] then
        if score.xiangyun == '死' then
            smyteam = scorexy - 2
        elseif score.xiangyun == '衰' and score.xiangyunvalue > 10 then
            smyteam = scorexy - 2
        elseif score.xiangyun == '衰' and score.xiangyunvalue <= 10 then
            smyteam = scorexy - 1
        elseif smyteam < scorexy then
            smyteam = scorexy
        end
    else
        if score.xiangyun == '衰' or score.xiangyun == '死' then
            if job.zuhe["songmoya"] then job.zuhe["songmoya"] = nil end
        else
            if smyteam < scorexy then smyteam = scorexy * 1 end
            if go_on_smy ~= 0 and job.zuhe["songmoya"] == nil then
                job.zuhe["songmoya"] = true
            end
        end
    end
end
score_busy_check = function(n, l, w)
    local l_char = del_string(w[2], ' ')
    l_char = del_string(l_char, '??')
    local l_cnt = trans(l_char)
    if w[3] == '分' then
        if w[1] == "雪山强抢美女" then
            condition.xueshan = l_cnt * 60
        end
        if w[1] == "双倍经验" then condition.ebook = l_cnt * 60 end
        if w[1] == "明悟" then condition.mingwu = l_cnt * 60 end
        if w[1] == "真实视野" then condition.vpearl = l_cnt end
        if w[1] == "寒毒" then
            vippoison = 1
            condition.poison = l_cnt * 60
        end
        if w[1] == "蔓陀萝花毒" then vippoison = 1 end
        if w[1] == "星宿掌毒" then
            vippoison = 1
            condition.poison = l_cnt * 60
        end
        if w[1] == "虎爪绝户手伤" then
            condition.poison = l_cnt * 60
        end
        if w[1] == "任务繁忙状态" then condition.busy = l_cnt * 60 end
        if w[1] == "福州镖局护镖倒计时" then
            condition.hubiao = l_cnt * 60
        end
        -- print(condition.poison,condition.busy)
    else
        if w[1] == "雪山强抢美女" then condition.xueshan = l_cnt end
        if w[1] == "双倍经验" then condition.ebook = l_cnt end
        if w[1] == "明悟" then condition.mingwu = l_cnt end
        if w[1] == "真实视野" then condition.vpearl = l_cnt end
        if w[1] == "寒毒" then
            vippoison = 1
            condition.poison = l_cnt
        end
        if w[1] == "蔓陀萝花毒" then vippoison = 1 end
        if w[1] == "星宿掌毒" then
            vippoison = 1
            condition.poison = l_cnt
        end
        if w[1] == "虎爪绝户手伤" then condition.poison = l_cnt end
        if w[1] == "任务繁忙状态" then condition.busy = l_cnt end
        if w[1] == "福州镖局护镖倒计时" then
            condition.hubiao = l_cnt
        end
        -- print(condition.poison,condition.busy)
    end
end
score_gender_check = function(n, l, w)
    if string.len(w[1]) == 2 then score.gender = w[1] end
    if string.len(w[2]) == 8 then score.level = w[2] end
end
hpheqi = function()
    DeleteTriggerGroup("hpheqi")
    create_trigger_t('hpheqi1', "^·合气度·\\s*\\-?\\s*(\\d*)", '',
                     'hp_heqi_check')
    SetTriggerOption("hpheqi1", "group", "hpheqi")
    EnableTriggerGroup("hpheqi", false)
end


hp_dazuo_count=function()
    DeleteTriggerGroup("dz_count")
    create_trigger_t('dz_count1','^>*\\s*卧室不能打坐，会影响别人休息。','','hp_dz_where')
    create_trigger_t('dz_count2','^>*\\s*你无法静下心来修炼。','','hp_dz_where')
    create_trigger_t('dz_count3','^>*\\s*(这里不准战斗，也不准打坐。|这里可不是让你提高内力的地方。)','','hp_dz_where')
	create_trigger_t('dz_count4',"^(> )*你现在手脚戴着镣铐，不能做出正确的姿势来打坐",'','hp_dz_liaokao')
	create_trigger_t('dz_count5',"^(> )*(你正要有所动作|你无法静下心来修炼|你还是专心拱猪吧)",'','hp_dz_where')
	create_trigger_t('dz_count6',"^(> )*你现在精不够，无法控制内息的流动！",'','loginerror')
    SetTriggerOption("dz_count1","group","dz_count")
    SetTriggerOption("dz_count2","group","dz_count")
    SetTriggerOption("dz_count3","group","dz_count")
	SetTriggerOption("dz_count4","group","dz_count")
	SetTriggerOption("dz_count5","group","dz_count")
	SetTriggerOption("dz_count6","group","dz_count")
    if perform.force and skills[perform.force] then
	   exe('jifa force '.. perform.force)
	else
	   for p in pairs(skills) do
	      if skillEnable[p] == "force" then
		     exe('jifa force '.. p)
			 exe('cha')
		  end
	   end
	end
    if skills["linji-zhuang"] and skills["linji-zhuang"].lvl>149 then
       exe('yun yinyang')
    end
	if skills["force"] and skills["force"].lvl<450 and skills["force"].lvl<hp.pot_max-100 then
       flag.xuexi=1
    end
    exe('yun qi;hp')
    hp.dazuo=10
    return check_bei(hp_dazuo_act)
end
loginerror=function()
	  DeleteTriggerGroup("dz_count")
	  DeleteTimer("dazuo_count")
    return checkWait(check_heal,0.5)
end
hp_dazuo_act=function()
    tmp.qixue=hp.qixue
    exe('yun jing;dazuo '..hp.qixue)
    tmp.i=0
    return create_timer_s('dazuo_count',1.5,'hp_dazuo_timer')
end
hp_dazuo_timer=function()
    if tmp.i == nil then tmp.i = 0 end
    tmp.i = tmp.i + 1
    if tmp.i > 30 then
       return main()
    end
    exe('hp;yun jing;yun qi;dazuo '..hp.qixue)
    return checkWait(hp_dz_count,0.5)
end
hp_dz_count=function()
    EnableTriggerGroup("dz_count",false)

    local l_times=1
       if hp.qixue<tmp.qixue then
          if hp.qixue_max>1000 then
             l_times=math.modf(math.modf(hp.qixue_max/5)/(tmp.qixue-hp.qixue))+1
	  end
	  hp.dazuo=l_times*(tmp.qixue-hp.qixue)+150
	  if hp.dazuo<10 then
	     hp.dazuo=10
	  end
	  --if hp.dazuo>10 and hp.dazuo <100 then
	  --   l_times=math.modf(100/hp.dazuo)+1
	  --   hp.dazuo=l_times*hp.dazuo
	  --end
	  Note('最佳打坐值为：'..hp.dazuo)
	  DeleteTriggerGroup("dz_count")
	  DeleteTimer("dazuo_count")
	  exe('halt')
	  if kdummy==1 and hp.exp>2000000 then opendummy() end
	  return check_bei(vcheck)
	 end
end
function vcheck()
if score.id and score.id=='ptbx' and ptbxvip==1 then
      job.name='ptbx'
      exe('cond')
      return go(VIPask,'扬州城','当铺')
   else
      return Gstart()
   end
end
function Gstart()
	  return check_bei(check_food)
end
hp_dz_where=function()
   EnableTriggerGroup("dz_count",false)
   DeleteTimer("dazuo_count")
   locate()
   check_bei(hp_dz_go)
end
hp_dz_go=function()
   EnableTriggerGroup("dz_count",true)
   exe(locl.dir)
   hp_dazuo_act()
end
function hp_dz_liaokao()
    dis_all()
	return tiaoshui()
end
function hp_trigger()
    DeleteTriggerGroup("hp")
    create_trigger_t('hp1',"^·精血·\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*·精力·\\s*(\\d*)\\s*\\/\\s*(\\d*)\\((\\d*)\\)$",'','hp_jingxue_check')
    create_trigger_t('hp2',"^·气血·\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*·内力·\\s*(\\d*)\\s*\\/\\s*(\\s*\\d*)\\(\\+\\d*\\)$",'','hp_qixue_check')
    create_trigger_t('hp3',"^·食物·\\s*(\\d*)\\.\\d*\\%\\s*·潜能·\\s*(\\d*)\\s*\\/\\s*(\\d*)$",'','hp_pot_check')
    create_trigger_t('hp4',"^·饮水·\\s*(\\d*)\\.\\d*\\%\\s*·经验·\\s*(.*)\\s*\\(",'','hp_exp_check')
    create_trigger_t('hp5',"^·(戾|正)气·\\s*(.*)\\s*·内力上限·\\s*(\\d*)\\s*\\/",'','hp_shen_check')
    create_trigger_t('hp7',"^(□)*\\s*(\\D*)\\s*\\((\\D*)(\\-)*(\\D*)\\)\\s*\\-\\s*\\D*\\s*(\\d*)\\/\\s*(\\d*)$",'','check_skills')
    create_trigger_t('hp8',"^>*\\s*你至少需要(\\D*)点的气来打坐！",'','hp_dazuo_check')
    create_trigger_t('hp9',"^│(\\D*)任务\\s*│\\s*(\\d*) 次\\s*│ ",'','checkJobtimes')
    create_trigger_t('hp10',"^□(\\D*)\\(\\D*\\)$",'','checkWieldCatch')
    create_trigger_t('hp11',"^(> )*你最近刚完成了(\\D*)任务。$",'','checkJoblast')
    create_triggerex_lvl('hp12',"^(> )*(\\D*)",'','resetWait',200)
    create_trigger_t('hp13',"^(> )*你还在巡城呢，仔细完成你的任务吧。",'','checkQuit')
    create_trigger_t('hp14',"^\\D*被一阵风卷走了。$",'','checkRefresh')
    create_trigger_t('hp15',"^(> )*一个月又过去",'','checkMonth')
    create_trigger_t('hp16',"^(> )*昨天完成失落信笺任务(\\N*)次，今天完成失落信笺任务(\\N*)/(\\N*)次。",'','checkLLlost')
    create_trigger_t('hp17',"^(> )*你(渴得眼冒金星，全身无力|饿得头昏眼花，直冒冷汗)|满天黄沙，你感到喉咙冒烟，干渴难熬！",'','checkQuit')
    create_trigger_t('hp18',"^(> )*(你舔了舔干裂的嘴唇，看来是很久没有喝水了|突然一阵“咕咕”声传来，原来是你的肚子在叫了)",'','checkfood')
    create_trigger_t('hp19',"^(> )*(忽然一阵刺骨的奇寒袭来，你中的星宿掌毒发作了|忽然一股寒气犹似冰箭，循着手臂，迅速无伦的射入胸膛，你中的寒毒发作了)",'','checkDebug')
    create_trigger_t('hp20',"^(> )*你(服下一颗活血疗精丹，顿时感觉精血不再流失|服下一颗内息丸，顿时觉得内力充沛了不少|服下一颗川贝内息丸，顿时感觉内力充沛|服下一颗黄芪内息丹，顿时感觉空虚的丹田充盈了不少|敷上一副蝉蜕金疮药，顿时感觉伤势好了不少|吃下一颗大还丹顿时伤势痊愈气血充盈)。",'','hpeatOver')
    create_trigger_t('hp21',"^(> )*你必须先用 enable 选择你要用的特殊内功。",'','jifaOver')
    create_trigger_t('hp22',"^(> )*(\\D*)目前学过(\\D*)种技能：",'','show_skills')
    create_trigger_t('hp23',"^(> )*你的背囊里有：",'','show_beinang')
    create_trigger_t('hp24','^(> )*你眼中一亮看到\\D*的身边掉落一(件|副|双|袭|顶|个|条|对)(\\D*)(手套|靴|甲胄|腰带|披风|彩衣|头盔)。','','fqyyArmorGet')
    create_trigger_t('hp25','^(> )*你捡起一(件|副|双|袭|顶|个|条|对)(\\D*)(手套|靴|甲胄|腰带|披风|彩衣|头盔)。','','fqyyArmorCheck')
	create_trigger_t('hp26','^(> )*\\D*告诉你：城门(\\D*)','','yiliCheck')
	create_trigger_t('hp27','^(> )*客官已经付了银子，怎(么|麽)不住店就走了呢！旁人还以为小店伺候不周呢！','','kedian_sleep')
	create_trigger_t('hp28','^.*穷光蛋，一边呆着去','','newbie_qu_gold')
	create_trigger_t('hp29','^.*狐疑地看着你：「这信怎么落到你的手上？」','','dolost_hitlog_open')
    create_trigger_t('hp30','^.*据说'..score.name..'被.*打傻了!','','dolost_hitlog_close')
    create_trigger_t('hp71',"^(> )*【活动公告】书剑永恒天玑站砸金蛋活动开始了！",'','egg_huodong')
    SetTriggerOption("hp71","group","hp")
    SetTriggerOption("hp24","group","hp")
    SetTriggerOption("hp25","group","hp")
	SetTriggerOption("hp26","group","hp")
	SetTriggerOption("hp27","group","hp")
    SetTriggerOption("hp1","group","hp")
    SetTriggerOption("hp2","group","hp")
    SetTriggerOption("hp3","group","hp")
    SetTriggerOption("hp4","group","hp")
    SetTriggerOption("hp5","group","hp")
    SetTriggerOption("hp7","group","hp")
    SetTriggerOption("hp8","group","hp")
    SetTriggerOption("hp9","group","hp")
    SetTriggerOption("hp10","group","hp")
    SetTriggerOption("hp11","group","hp")
    SetTriggerOption("hp12","group","hp")
    SetTriggerOption("hp13","group","hp")
    SetTriggerOption("hp14","group","hp")
    SetTriggerOption("hp15","group","hp")
    SetTriggerOption("hp16","group","hp")
    SetTriggerOption("hp17","group","hp")
    SetTriggerOption("hp18","group","hp")
    SetTriggerOption("hp19","group","hp")
    SetTriggerOption("hp20","group","hp")
    SetTriggerOption("hp21","group","hp")
    SetTriggerOption("hp22","group","hp")
    SetTriggerOption("hp23","group","hp")
	SetTriggerOption("hp28","group","hp")
	SetTriggerOption("hp29","group","hp")
	SetTriggerOption("hp30","group","hp")
    DeleteTriggerGroup("score")
    create_trigger_t('score1',"^┃姓    名：(\\D*)\\((\\D*)\\)\\s*┃身  法：「(\\d*)\/(\\d*)」\\s*悟  性：「(\\d*)\/(\\d*)」",'','score_name_check')
    create_trigger_t('score2',"^┃头    衔：(\\D*)\\s*┃臂  力：「(\\d*)\/(\\d*)」\\s*根  骨：「(\\d*)\/(\\d*)」",'','score_title_check')
    create_trigger_t('score3',"^┃年    龄：(\\D*)岁\\D*\\s*生    辰：",'','score_age_check')
    create_trigger_t('score4',"^│(任务繁忙状态|雪山强抢美女|双倍经验|明悟|寒毒|星宿掌毒|蔓陀萝花毒|虎爪绝户手伤|福州镖局护镖倒计时|真实视野)\\s*(\\D*)(分|秒)\\s*",'','score_busy_check')
    create_trigger_t('score5',"^┃(婚    姻|娇    妻|夫    君)：(\\D*)\\s*师\\s*承：【(\\D*)】【(\\D*)】",'','score_party_check')
    create_trigger_t('score6',"^┃性    别：(\\D*)性\\s*攻：(\\D*)\\s* 躲：",'','score_gender_check')
    create_trigger_t('score7',"^┃(婚    姻|娇    妻|夫    君)：(\\D*)\\s*师\\s*承：【(普通百姓)】(\\D*)",'','score_party_check')
    create_trigger_t('score9',"^┃注    册：(\\D*)\\s*钱庄存款：(\\D*)",'','score_gold_check')
    create_trigger_t('score8',"^您目前的存款上限是：(\\D*)锭黄金",'','checkGoldLmt')
    create_trigger_t('score10','^┃致命抗性：\\d*.*理相：(\\D*)\\((\\d*)\\)\\s*┃','','score_check_xy')
    create_trigger_t('score11','^┃书剑通宝：(\\N*)\\s*书剑元宝：(\\N*)\\s*竞技币：(\\N*)\\s*┃','','score_tb_check')
    create_trigger_t('score12',"^本周您已经使用精英之书(\\D*)次。",'','score_ebook_check')
    SetTriggerOption("score1","group","score")
    SetTriggerOption("score2","group","score")
    SetTriggerOption("score3","group","score")
    SetTriggerOption("score4","group","score")
    SetTriggerOption("score5","group","score")
    SetTriggerOption("score6","group","score")
    SetTriggerOption("score7","group","score")
    SetTriggerOption("score8","group","score")
    SetTriggerOption("score9","group","score")
    SetTriggerOption("score10","group","score")
    SetTriggerOption("score11","group","score")
    SetTriggerOption("score12","group","score")
end


function check_pot(p_cmd)
    if hp.exp < 5000000 then
        l_pot = hp.pot_max - 100
    else
        l_pot = hp.pot_max - 200
    end
    flag.lingwu = 0

    job_exp_tongji()

    if flag.autoxuexi == nil then flag.autoxuexi = 0 end

    if hp.pot < l_pot  then
        print("潜能不够，继续工作")
        return check_job()
    elseif flag.autoxuexi == 0 then
        print("flag.autoxuexi 为0，继续工作")
        return check_job()
    end

    local max_skill = hp.pot_max - 100
    if score.party == "普通百姓" then
        if score.gold and skills["literate"] and score.gold > 3000 and skills["literate"].lvl < max_skill then
            return literate()
        end
        if skills["parry"].lvl < max_skill and skills["parry"].lvl >= 101 then 
            return checklingwu()
        end
        if skills["force"].lvl > 50 and skills["force"].lvl < 101 then
            if skills["force"].lvl == 101 then
                exe('fangqi force 1;y;y;y')
            end
            return huxi()
        end
        if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl < 200 then 
            return learnSzj()
        end
    else
        if score.gold and skills["literate"] and score.gold > 3000 and
                skills["literate"].lvl < max_skill then
                return literate()
            end
        
        if flag.type and flag.type ~= 'lingwu' and flag.xuexi == 1 then
            return checkxue()
        end
        
        for p in pairs(skills) do
            local q = qrySkillEnable(p)
            if q and q['force'] and perform.force and p == perform.force and
                skills[p].lvl < 100  then
                if skills[p].mstlvl and skills[p].mstlvl > skills[p].lvl then
                    return checkxue()
                end
            end
            if flagFull[p] and not skillEnable[p] and skills[p].lvl < 450 and
            skills[p].lvl <= skills["dodge"].lvl  then
                if not skills[p].mstlvl or skills[p].mstlvl > skills[p].lvl then
                    return checkxue()
                end
            end
        end

        if perform.skill and skills[perform.skill] and skills[perform.skill].lvl < 450 then 
            return checkxue()
        end

        if skills["parry"] and skills["parry"].lvl < max_skill and skills["parry"].lvl >= 450 then
            flag.lingwu = 1
        end

        if flag.lingwu == 1 then return checklingwu() end
        
        if not flag.wxjz then flag.wxjz = 0 end
        if skills["wuxiang-zhi"] and flag.wxjz == 0 then
            if skills["finger"].lvl > skills["wuxiang-zhi"].lvl and skills["wuxiang-zhi"].lvl < max_skill then
                return wxjzFofa()
            end
        end
    end
    return check_job()
end

function lingwu_trigger()
    DeleteTriggerGroup("lingwu")
    create_trigger_t('lingwu1',"^.*(你只能从特殊技能中领悟。|你不会这种技能。|你要领悟什么？)",'','lingwu_next')
    create_trigger_t('lingwu2',"^.*你从实战中得到的潜能已经用完了。",'','lingwu_finish1')
    create_trigger_t('lingwu3',"^.*你的\\D*不够，无法领悟更深一层的基本",'','lingwu_next')
    create_trigger_t('lingwu9',"^.*以你现在的基本内功修为，尚无法领悟基本内功。",'','lingwu_next')
    create_trigger_t('lingwu5',"^.*由于实战经验不足，阻碍了你的「\\D*」进步",'','lingwu_next')
    create_trigger_t('lingwu6','^.*(你深深吸了几口气，精神看起来好多了。|你现在精神饱满。)','','lingwu_goon')
    create_trigger_t('lingwu7',"^.*你的内力不够。",'','lingwu_finish') 
    SetTriggerOption("lingwu1","group","lingwu")
    SetTriggerOption("lingwu2","group","lingwu")
    SetTriggerOption("lingwu3","group","lingwu")
    SetTriggerOption("lingwu9","group","lingwu")
    SetTriggerOption("lingwu5","group","lingwu")
    SetTriggerOption("lingwu6","group","lingwu")
    SetTriggerOption("lingwu7","group","lingwu")
    EnableTriggerGroup("lingwu",false)
end


function checklingwu()
    if lingwudie == 0 then return lingwu() end
    if xxpot < hp.pot_max then return lingwu() end
    messageShow('不需要领悟')
    return check_job()
end
function lingwu()
    DeleteTemporaryTriggers()
    skillsLingwu = {}
    skillsLingwu = utils.split(GetVariable("lingwuskills"), '|')
    road.temp = 0
    tmp.lingwu = 1
    tmp.stop = false
    lingwudie = 0
    return check_busy(lingwu_go)
end
function lingwu_go()
    exe('nick 少林领悟达摩院后殿')
    messageShow('去少林领悟')
    jifaAll()
    go(lingwu_unwield, '嵩山少林', '达摩院')
end
function lingwu_unwield()
    weapon_unwield()
    exe('hp')
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    wait.make(function()
        wait_busy()
        if newbie == 1 then
            return lingwuzb()
        else
            return lingwuzbok()
        end
    end)
    -- return check_busy(lingwuzb) -- 不准备内力，直接领悟。
end
function lingwuzb() zhunbeineili(lingwuzbok) end
function lingwuzbok() 
    lingwu_trigger()
    go(lingwu_goon, '嵩山少林', '达摩院后殿') 
end
function lingwuSleep()
    if score.gender == '男' then
        return go(lingwuSleepOver, "songshan/nan-room", "")
    else
        return go(lingwuSleepOver, "songshan/nv-room", "")
    end
end
function lingwuSleepOver()
    exe('sleep')
    checkWait(lingwu_eat, 3)
end

function lingwu_goon()
    if locl.room ~= "达摩院后殿" then return lingwu_finish() end
    EnableTriggerGroup("lingwu", true)
    local skill = skillsLingwu[tmp.lingwu]

    if not skills[skill] or skills[skill].lvl == 0 or skills[skill].lvl >=
        hp.pot_max - 100 then return lingwu_next() end

    if hp.neili < 1000 then
        if hp.exp > 20000000 or score.gender == '无' then
            return go(lingwu_eat, '武当山', '茶亭')
        else
            return lingwuSleep()
        end
    end
    flag.idle = nil
    wait.make(function()
        exe('#10(lingwu ' .. skill .. ')')
        if tmp.stop then
           return lingwu_finish()
        else
           exe('yun jing')
        end
    end)
end
function lingwu_eat()
    if locl.room == "茶亭" then
        flag.food = 0
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#4(drink cha);drop cha;drop tao;fill jiudai')
        check_bei(lingwu_go)
    else
        return go(lingwu_eat, '武当山', '茶亭')
    end
end
function lingwu_next()
    EnableTriggerGroup("lingwu", false)
    if tmp.lingwu == nil then tmp.lingwu = 1 end
    tmp.lingwu = tmp.lingwu + 1
    local length = table.getn(skillsLingwu)
    if tmp.lingwu > length then
        flag.lingwu = 0
        lingwudie = 1
        xxpot = hp.pot_max
        -- return check_bei(lingwu_finish)
        return lingwu_finish()
    else
        local skill = skillsLingwu[tmp.lingwu]
        -- print(skillsLingwu[tmp.lingwu])
        if skills[skill] and skills[skill].lvl > 0 and skills[skill].lvl <
            hp.pot_max - 100 then
            return check_bei(lingwu_goon, 1)
        else
            return lingwu_next()
        end
    end
end
function lingwu_finish1()
    -- EnableTimer('walkWait4', false)
    tmp.stop = true
    -- checkWait(lingwu_finish, 1)
end
function lingwu_finish()
    tmp.stop = true
    messageShow('少林领悟完成')
    local skill = skillsLingwu[tmp.lingwu]
    EnableTriggerGroup("lingwu", false)
    DeleteTriggerGroup("lingwu")
    exe('cha')
    flag.lingwu = 0
    if tmp.lingwu > 1 and tmp.lingwu <= table.getn(skillsLingwu) then
        table.remove(skillsLingwu, tmp.lingwu)
        table.insert(skillsLingwu, 1, skill)
    end
    -- weapon_unwield()
    -- local leweapon=GetVariable("learnweapon")
    -- exe('cha;unwield '..leweapon)
    return check_jobx()
    -- return check_busy(check_food)
end


function xuexiTrigger()
    DeleteTriggerGroup("xuexi")
    DeleteTriggerGroup("litxuexi")
    create_trigger_t('xuexi1',
                     "^(> )*你(\\D*)" .. score.master .. "(\\D*)指导", '',
                     'xuexiAction')
    create_trigger_t('xuexi2', "^(> )*你现在正忙着呢。", '',
                     'xuexiAction')
    create_trigger_t('xuexi3',
                     "^(> )*你今天太累了，结果什么也没有学到。",
                     '', 'xuexiSleep')
    create_trigger_t('xuexi4',
                     "^(> )*(六脉神剑|你不能再学习欢喜禅了|经脉学|你不能再学习|你的基本功火候未到|你不能再提高|你的太极拳火候太浅|兰花拂穴手乃黄岛主家传绝学|兰花拂穴手乃峨嵋派祖师郭襄秘学|你的悟性，无法|你的\\D*(级别|悟性|身法)不够|华山门下怎么容得|你一个大老爷们|你已经无法提高|你的基本棒法太差|你的邪气太重|你刚听一会儿|斗转星移只能通过领悟来提高|学就只能学的这里了|你是侠义正士|只有大奸大恶之人|你不能再修炼毒技|你不能再学习经脉学|经脉学只能靠研读|你的读书写字|本草术理只能通过研习医学|你的基本功火候未到|你屡犯僧家数戒|这项技能你只能通过读书学习或实战|这项技能你已经无法通过学习|这项技能你恐怕必须找别人学了|你必须去学堂学习读书写字|也许是缺乏实战经验|你的(大乘佛法|禅宗心法)修为不够|这项技能你的程度已经不输你师父)",
                     '', 'xuexiNext')
    create_trigger_t('xuexi5', "^(> )*你没有这么多潜能来学习", '',
                     'xuexiFinish')
    create_trigger_t('xuexi6', "^(> )*你要向谁求教？", '', 'xuexiFinish')
    create_trigger_t('xuexi7', "^(> )*你的「(\\D*)」进步了！", '',
                     'xuexiLvlUp')
    create_trigger_t('xuexi8', "^(> )*你觉得对太极拳理还不够理解",
                     '', 'xueAskzhang')
    create_trigger_t('xuexi9',
                     "^(> )*乾坤大挪移只能通过研习《乾坤大挪移心法》和领悟来提高",
                     '', 'taoJiaozhang')
    create_trigger_t('xuexi10',
                     "^(> )*(你手里有兵器|空了手才能练|空手方能练习|你必须先找|空手时无法练|你使用的武器不对|练\\D*空手|学\\D*空手|\\D*手里不能拿武器。)",
                     '', 'xueWeapon')
    SetTriggerOption("xuexi1", "group", "xuexi")
    SetTriggerOption("xuexi2", "group", "xuexi")
    SetTriggerOption("xuexi3", "group", "xuexi")
    SetTriggerOption("xuexi4", "group", "xuexi")
    SetTriggerOption("xuexi5", "group", "xuexi")
    SetTriggerOption("xuexi6", "group", "xuexi")
    SetTriggerOption("xuexi7", "group", "xuexi")
    SetTriggerOption("xuexi8", "group", "xuexi")
    SetTriggerOption("xuexi9", "group", "xuexi")
    SetTriggerOption("xuexi10", "group", "xuexi")
    EnableTriggerGroup("xuexi", false)
end
function checkxue()
    if xuefull == 0 then return xuexi() end
    if xxpot < hp.pot_max then return xuexi() end
    return check_job()
end

function xuexi()
    exe('nick 回门派学习')
    messageShow('回门派学习')
    master = {}

    if hp.exp < 150000 then
        master.times = 10
    else
        -- ain usepot
        master.times = math.modf(hp.jingxue / 60)
        if master.times > 50 then
            master.times = 50
        elseif master.times < 10 then
            master.times = 10
        end
    end

    master.skills = {}
    master.skills = utils.split(GetVariable("xuexiskill"), '|')

    flag.times = 1

    return check_halt(xuexiParty)
end
function xuexiParty()
    xuexiTrigger()
    if score.master then
        master.area = locateroom(score.master)
        if master.area then
            return go(xuexiCheck, master.area, master.room)
        else
            ColourNote("white", "blue",
                       "未找到师傅住址，请联系PTBX更新！")
            return xuexiFinish()
        end
    else
        return xuexiFinish()
    end
end
function xuexiCheck()
    checkWield()
    if locl.id[score.master] then
        if score.party and score.party == "少林派" and score.master ==
            "无名老僧" and skills["buddhism"] and skills["buddhism"].lvl ==
            200 then exe('ask wuming about 佛法') end
        return check_bei(xuexiStart)
    else
        ColourNote("white", "blue",
                   "师傅不在家！如果发现地址有错，请联系PTBX更新！")
        return xuexiFinish()
    end
end
function xuexiStart()
    EnableTriggerGroup("xuexi", true)
    tmp.xuexi = 1

    if master.id and locl.item and locl.item[score.master] and
        not locl.item[score.master][master.id] then master.id = nil end
    if not master.id and locl.item and locl.item[score.master] then
        master.id = locl.item[score.master]
        for p in pairs(locl.item[score.master]) do
            if not string.find(p, " ") then master.id = p end
        end
    end
    exe('bai ' .. master.id)

    weapon_unwield()

    if l_skill and weaponKind[l_skill] then
        if master.skills[tmp.xuexi] == "yuxiao-jian" then
            l_skill = "xiao"
        end
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == l_skill then
                exe('wield ' .. Bag[p].fullid)
            end
        end
    end
    -- yunAddInt()
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    return xuexiContinue()
end
function xuexiAction()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    if hp.exp > 2000000 and hp.neili < 300 then
        prepare_neili(xuexiContinue)
    else
        check_bei(xuexiContinue)
    end
end
function xuexiContinue()
    flag.idle = nil
    xuefull = 0
    if hp.neili < 1000 and hqd_cur > 0 then exe('eat huangqi dan') end
    if hp.neili < 600 and hqd_cur > 0 then exe('eat huangqi dan') end
    EnableTriggerGroup("xuexi", true)
    wait.make(function()
        wait.time(1)
        exe('yun jing;xue ' .. master.id .. ' ' .. master.skills[tmp.xuexi] ..
                ' ' .. master.times)
        DeleteTimer("walkWait4")
        create_timer_s('walkWait4', 1.0, 'xuexi_again')
    end)
    print('学习点数:' .. master.times)
    exe('hp')
end
function xuexi_again()
    exe(
        'yun jing;xue ' .. master.id .. ' ' .. master.skills[tmp.xuexi] .. ' ' ..
            master.times)
end
function taoJiaozhang()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    print('问小张乾坤大挪移')
    wait.make(function()
        wait.time(1)
        exe('#5 taojiao qiankundanuoyi;yun jing')
    end)
    check_busy(xuexiContinue)
end
function xueAskzhang()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    print('问老张太极拳理')
    wait.make(function()
        wait.time(1)
        exe('ask zhang about 太极拳理')
    end)
    check_busy(xuexiContinue)
end
function xueWeapon()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    tmp.skill = master.skills[tmp.xuexi]
    if skills[tmp.skill] then
        if skills[tmp.skill].lvl >= 450 then
            skills[tmp.skill].mstlvl = 450
        else
            skills[tmp.skill].mstlvl = skills[tmp.skill].lvl
        end
    end
    local l_skill = skillEnable[master.skills[tmp.xuexi]]
    weapon_unwield()
    if l_skill and weaponKind[l_skill] then
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == l_skill then
                exe('wield ' .. Bag[p].fullid)
            end
        end
        checkWield()
    end
    return check_bei(xuexiContinue)
end
function xuexiNext()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    tmp.skill = master.skills[tmp.xuexi]
    if skills[tmp.skill] then
        if skills[tmp.skill].lvl >= 450 then
            skills[tmp.skill].mstlvl = 450
        else
            skills[tmp.skill].mstlvl = skills[tmp.skill].lvl
        end
    end
    tmp.xuexi = tmp.xuexi + 1
    if tmp.xuexi > table.getn(master.skills) then
        xxpot = hp.pot_max
        xuefull = 1
        return xuexiFinish()
    end
    local l_skill = skillEnable[master.skills[tmp.xuexi]]
    weapon_unwield()
    if l_skill and weaponKind[l_skill] then
        if master.skills[tmp.xuexi] == "yuxiao-jian" then
            l_skill = "xiao"
        end
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == l_skill then
                exe('wield ' .. Bag[p].fullid)
            end
        end
        checkWield()
    end
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    return check_bei(xuexiContinue)
end
function xuexiLvlUp(n, l, w)
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    for p in pairs(skills) do
        if skills[p].name == w[2] then
            skills[p].mstlvl = nil
            break
        end
    end
end
function xuexiSleep()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    if score.party and score.party == "神龙教" then
        return go(xuexiSleepOver, "神龙岛", "卧室")
    end
    if score.party and score.party == "少林派" then
        return go(xuexiSleepOver, "shaolin/sengshe3", "")
    end
    if score.party and score.party == "桃花岛" then
        if score.master and score.master == "黄药师" then
            return go(xuexiSleepOver, "桃花岛", "客房")
        else
            return go(xuexiSleepOver, "归云庄", "客房")
        end
    end
    if score.master and score.master == "杨过" then
        return go(xuexiSleepOver, "gumu/jqg/wshi", "")
    end
    if score.master and score.master == "小龙女" then
        return go(xuexiSleepOver, "gumu/jqg/wshi", "")
    end
    if score.party and score.party == "武当派" and score.gender == '女' then
        return go(xuexiSleepOver, "武当山", "女休息室")
    end
    if score.party and score.party == "武当派" and score.gender == '男' then
        return go(xuexiSleepOver, "武当山", "男休息室")
    end
    if score.party and score.party == "天龙寺" then
        return go(xuexiSleepOver, "dali/wangfu/woshi2", "")
    end
    if score.party and score.party == "姑苏慕容" then
        return go(xuexiSleepOver, "姑苏慕容", "厢房")
    end
    if score.party and score.party == "星宿派" then
        return go(xxSleepcheck, "星宿海", "逍遥洞")
    end
    if score.party and score.party == "昆仑派" then
        return go(xuexiSleepOver, "昆仑山", "休息室")
    end
    if score.party and score.party == "华山派" and score.gender == '男' then
        return go(xuexiSleepOver, "华山", "男休息室")
    end
    if score.party and score.party == "华山派" and score.gender == '女' then
        return go(xuexiSleepOver, "华山", "女休息室")
    end
    if score.party and score.party == "铁掌帮" and score.gender == '男' then
        return go(xuexiSleepOver, "铁掌山", "男休息室")
    end
    if score.party and score.party == "铁掌帮" and score.gender == '女' then
        return go(xuexiSleepOver, "铁掌山", "女休息室")
    end
    if score.party and score.party == "丐帮" then
        -- return go(xuexiSleepOver, "chengdu/houyuan", "")
        wait.make(function()
            wait_busy()
            exe('sleep')
            wait_busy()
            return xuexiStart()
        end)
    else
        return xuexiFinish()
    end
end
function xxSleepcheck()
    exe('give caihua 1 coin')
    wait.make(function()
        wait.time(1)
        exe('enter;sleep')
        xuexiSleepOver()
    end)
end
function xuexiSleepOver()
    exe('sleep')
    checkWait(xuexiParty, 3)
end
function xuexiFinish()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    messageShow('学习完毕！')
    flag.xuexi = 0
    EnableTriggerGroup("xuexi", false)
    DeleteTriggerGroup("xuexi")
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('cha;unwield ' .. leweapon)
    dis_all()
    return check_busy(check_food)
end