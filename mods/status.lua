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
score.sww = 0
score.sw = 0
score.dj = 0
score.dz = 0
score.zt = ''

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

hp_dazuo_count = function()
    DeleteTriggerGroup("dz_count")
    create_trigger_t('dz_count1',
                     '^>*\\s*卧室不能打坐，会影响别人休息。', '',
                     'hp_dz_where')
    create_trigger_t('dz_count2', '^>*\\s*你无法静下心来修炼。', '',
                     'hp_dz_where')
    create_trigger_t('dz_count3',
                     '^>*\\s*(这里不准战斗，也不准打坐。|这里可不是让你提高内力的地方。)',
                     '', 'hp_dz_where')
    create_trigger_t('dz_count4',
                     "^(> )*你现在手脚戴着镣铐，不能做出正确的姿势来打坐",
                     '', 'hp_dz_liaokao')
    create_trigger_t('dz_count5',
                     "^(> )*(你正要有所动作|你无法静下心来修炼|你还是专心拱猪吧)",
                     '', 'hp_dz_where')
    create_trigger_t('dz_count6',
                     "^(> )*你现在精不够，无法控制内息的流动！",
                     '', 'loginerror')
    SetTriggerOption("dz_count1", "group", "dz_count")
    SetTriggerOption("dz_count2", "group", "dz_count")
    SetTriggerOption("dz_count3", "group", "dz_count")
    SetTriggerOption("dz_count4", "group", "dz_count")
    SetTriggerOption("dz_count5", "group", "dz_count")
    SetTriggerOption("dz_count6", "group", "dz_count")
    if perform.force and skills[perform.force] then
        exe('jifa force ' .. perform.force)
    else
        for p in pairs(skills) do
            if skillEnable[p] == "force" then
                exe('jifa force ' .. p)
                exe('cha')
            end
        end
    end
    if skills["linji-zhuang"] and skills["linji-zhuang"].lvl > 149 then
        exe('yun yinyang')
    end
    if skills["force"] and skills["force"].lvl < 450 and skills["force"].lvl <
        hp.pot_max - 100 then flag.xuexi = 1 end
    exe('yun qi;hp')
    hp.dazuo = 10
    return check_bei(hp_dazuo_act)
end
loginerror = function()
    DeleteTriggerGroup("dz_count")
    DeleteTimer("dazuo_count")
    return checkWait(check_heal, 0.5)
end
hp_dazuo_act = function()
    tmp.qixue = hp.qixue
    exe('yun jing;dazuo ' .. hp.qixue)
    tmp.i = 0
    return create_timer_s('dazuo_count', 1.5, 'hp_dazuo_timer')
end
hp_dazuo_timer = function()
    if tmp.i == nil then tmp.i = 0 end
    tmp.i = tmp.i + 1
    if tmp.i > 30 then return main() end
    exe('hp;yun jing;yun qi;dazuo ' .. hp.qixue)
    return checkWait(hp_dz_count, 0.5)
end
hp_dz_count = function()
    EnableTriggerGroup("dz_count", false)

    local l_times = 1
    if hp.qixue < tmp.qixue then
        if hp.qixue_max > 1000 then
            l_times = math.modf(math.modf(hp.qixue_max / 5) /
                                    (tmp.qixue - hp.qixue)) + 1
        end
        hp.dazuo = l_times * (tmp.qixue - hp.qixue) + 150
        if hp.dazuo < 10 then hp.dazuo = 10 end
        -- if hp.dazuo>10 and hp.dazuo <100 then
        --   l_times=math.modf(100/hp.dazuo)+1
        --   hp.dazuo=l_times*hp.dazuo
        -- end
        Note('最佳打坐值为：' .. hp.dazuo)
        DeleteTriggerGroup("dz_count")
        DeleteTimer("dazuo_count")
        exe('halt')
        if kdummy == 1 and hp.exp > 2000000 then opendummy() end
        return check_bei(vcheck)
    end
end
function vcheck()
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        job.name = 'ptbx'
        exe('cond')
        return go(VIPask, '扬州城', '当铺')
    else
        return Gstart()
    end
end
function Gstart() return check_bei(check_food) end
hp_dz_where = function()
    EnableTriggerGroup("dz_count", false)
    DeleteTimer("dazuo_count")
    locate()
    check_bei(hp_dz_go)
end
hp_dz_go = function()
    EnableTriggerGroup("dz_count", true)
    exe(locl.dir)
    hp_dazuo_act()
end
function hp_dz_liaokao()
    dis_all()
    return tiaoshui()
end
function hp_trigger()
    DeleteTriggerGroup("hp")
    create_trigger_t('hp1',
                     "^·精血·\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*·精力·\\s*(\\d*)\\s*\\/\\s*(\\d*)\\((\\d*)\\)$",
                     '', 'hp_jingxue_check')
    create_trigger_t('hp2',
                     "^·气血·\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*·内力·\\s*(\\d*)\\s*\\/\\s*(\\s*\\d*)\\(\\+\\d*\\)$",
                     '', 'hp_qixue_check')
    create_trigger_t('hp3',
                     "^·食物·\\s*(\\d*)\\.\\d*\\%\\s*·潜能·\\s*(\\d*)\\s*\\/\\s*(\\d*)$",
                     '', 'hp_pot_check')
    create_trigger_t('hp4',
                     "^·饮水·\\s*(\\d*)\\.\\d*\\%\\s*·经验·\\s*(.*)\\s*\\(",
                     '', 'hp_exp_check')
    create_trigger_t('hp5',
                     "^·(戾|正)气·\\s*(.*)\\s*·内力上限·\\s*(\\d*)\\s*\\/",
                     '', 'hp_shen_check')
    create_trigger_t('hp7',
                     "^(□)*\\s*(\\D*)\\s*\\((\\D*)(\\-)*(\\D*)\\)\\s*\\-\\s*\\D*\\s*(\\d*)\\/\\s*(\\d*)$",
                     '', 'check_skills')
    create_trigger_t('hp8', "^>*\\s*你至少需要(\\D*)点的气来打坐！",
                     '', 'hp_dazuo_check')
    create_trigger_t('hp9', "^│(\\D*)任务\\s*│\\s*(\\d*) 次\\s*│ ", '',
                     'checkJobtimes')
    create_trigger_t('hp10', "^□(\\D*)\\(\\D*\\)$", '', 'checkWieldCatch')
    create_trigger_t('hp11', "^(> )*你最近刚完成了(\\D*)任务。$", '',
                     'checkJoblast')
    create_triggerex_lvl('hp12', "^(> )*(\\D*)", '', 'resetWait', 200)
    create_trigger_t('hp13',
                     "^(> )*你还在巡城呢，仔细完成你的任务吧。",
                     '', 'checkQuit')
    create_trigger_t('hp14', "^\\D*被一阵风卷走了。$", '',
                     'checkRefresh')
    create_trigger_t('hp15', "^(> )*一个月又过去", '', 'checkMonth')
    create_trigger_t('hp16',
                     "^(> )*昨天完成失落信笺任务(\\N*)次，今天完成失落信笺任务(\\N*)/(\\N*)次。",
                     '', 'checkLLlost')
    create_trigger_t('hp17',
                     "^(> )*你(渴得眼冒金星，全身无力|饿得头昏眼花，直冒冷汗)|满天黄沙，你感到喉咙冒烟，干渴难熬！",
                     '', 'checkQuit')
    create_trigger_t('hp18',
                     "^(> )*(你舔了舔干裂的嘴唇，看来是很久没有喝水了|突然一阵“咕咕”声传来，原来是你的肚子在叫了)",
                     '', 'checkfood')
    create_trigger_t('hp19',
                     "^(> )*(忽然一阵刺骨的奇寒袭来，你中的星宿掌毒发作了|忽然一股寒气犹似冰箭，循着手臂，迅速无伦的射入胸膛，你中的寒毒发作了)",
                     '', 'checkDebug')
    create_trigger_t('hp20',
                     "^(> )*你(服下一颗活血疗精丹，顿时感觉精血不再流失|服下一颗内息丸，顿时觉得内力充沛了不少|服下一颗川贝内息丸，顿时感觉内力充沛|服下一颗黄芪内息丹，顿时感觉空虚的丹田充盈了不少|敷上一副蝉蜕金疮药，顿时感觉伤势好了不少|吃下一颗大还丹顿时伤势痊愈气血充盈)。",
                     '', 'hpeatOver')
    create_trigger_t('hp21',
                     "^(> )*你必须先用 enable 选择你要用的特殊内功。",
                     '', 'jifaOver')
    create_trigger_t('hp22', "^(> )*(\\D*)目前学过(\\D*)种技能：", '',
                     'show_skills')
    create_trigger_t('hp23', "^(> )*你的背囊里有：", '', 'show_beinang')
    create_trigger_t('hp24',
                     '^(> )*你眼中一亮看到\\D*的身边掉落一(件|副|双|袭|顶|个|条|对)(\\D*)(手套|靴|甲胄|腰带|披风|彩衣|头盔)。',
                     '', 'fqyyArmorGet')
    create_trigger_t('hp25',
                     '^(> )*你捡起一(件|副|双|袭|顶|个|条|对)(\\D*)(手套|靴|甲胄|腰带|披风|彩衣|头盔)。',
                     '', 'fqyyArmorCheck')
    create_trigger_t('hp26', '^(> )*\\D*告诉你：城门(\\D*)', '',
                     'yiliCheck')
    create_trigger_t('hp27',
                     '^(> )*客官已经付了银子，怎(么|麽)不住店就走了呢！旁人还以为小店伺候不周呢！',
                     '', 'kedian_sleep')
    create_trigger_t('hp28', '^.*穷光蛋，一边呆着去', '',
                     'newbie_qu_gold')
    create_trigger_t('hp29',
                     '^.*狐疑地看着你：「这信怎么落到你的手上？」',
                     '', 'dolost_hitlog_open')
    create_trigger_t('hp30', '^.*据说' .. score.name .. '被.*打傻了!', '',
                     'dolost_hitlog_close')
    create_trigger_t('hp31',
                     "^\\D*你把钱交给船家，船家领你上了一条小舟",
                     '', 'job_lianstart')
    SetTriggerOption("hp24", "group", "hp")
    SetTriggerOption("hp25", "group", "hp")
    SetTriggerOption("hp26", "group", "hp")
    SetTriggerOption("hp27", "group", "hp")
    SetTriggerOption("hp1", "group", "hp")
    SetTriggerOption("hp2", "group", "hp")
    SetTriggerOption("hp3", "group", "hp")
    SetTriggerOption("hp4", "group", "hp")
    SetTriggerOption("hp5", "group", "hp")
    SetTriggerOption("hp7", "group", "hp")
    SetTriggerOption("hp8", "group", "hp")
    SetTriggerOption("hp9", "group", "hp")
    SetTriggerOption("hp10", "group", "hp")
    SetTriggerOption("hp11", "group", "hp")
    SetTriggerOption("hp12", "group", "hp")
    SetTriggerOption("hp13", "group", "hp")
    SetTriggerOption("hp14", "group", "hp")
    SetTriggerOption("hp15", "group", "hp")
    SetTriggerOption("hp16", "group", "hp")
    SetTriggerOption("hp17", "group", "hp")
    SetTriggerOption("hp18", "group", "hp")
    SetTriggerOption("hp19", "group", "hp")
    SetTriggerOption("hp20", "group", "hp")
    SetTriggerOption("hp21", "group", "hp")
    SetTriggerOption("hp22", "group", "hp")
    SetTriggerOption("hp23", "group", "hp")
    SetTriggerOption("hp28", "group", "hp")
    SetTriggerOption("hp29", "group", "hp")
    SetTriggerOption("hp30", "group", "hp")
    SetTriggerOption("hp31", "group", "hp")
    DeleteTriggerGroup("score")
    create_trigger_t('score1',
                     "^┃姓    名：(\\D*)\\((\\D*)\\)\\s*┃身  法：「(\\d*)/(\\d*)」\\s*悟  性：「(\\d*)/(\\d*)」",
                     '', 'score_name_check')
    create_trigger_t('score2',
                     "^┃头    衔：(\\D*)\\s*┃臂  力：「(\\d*)/(\\d*)」\\s*根  骨：「(\\d*)/(\\d*)」",
                     '', 'score_title_check')
    create_trigger_t('score3',
                     "^┃年    龄：(\\D*)岁\\D*\\s*生    辰：", '',
                     'score_age_check')
    create_trigger_t('score4',
                     "^│(任务繁忙状态|雪山强抢美女|双倍经验|明悟|寒毒|星宿掌毒|蔓陀萝花毒|虎爪绝户手伤|福州镖局护镖倒计时|真实视野)\\s*(\\D*)(分|秒)\\s*",
                     '', 'score_busy_check')
    create_trigger_t('score5',
                     "^┃(婚    姻|娇    妻|夫    君)：(\\D*)\\s*师\\s*承：【(\\D*)】【(\\D*)】",
                     '', 'score_party_check')
    create_trigger_t('score6',
                     "^┃性    别：(\\D*)性\\s*攻：(\\D*)\\s* 躲：",
                     '', 'score_gender_check')
    create_trigger_t('score7',
                     "^┃(婚    姻|娇    妻|夫    君)：(\\D*)\\s*师\\s*承：【(普通百姓)】(\\D*)",
                     '', 'score_party_check')
    create_trigger_t('score9',
                     "^┃注    册：(\\D*)\\s*钱庄存款：(\\D*)", '',
                     'score_gold_check')
    create_trigger_t('score8', "^您目前的存款上限是：(\\D*)锭黄金",
                     '', 'checkGoldLmt')
    create_trigger_t('score10',
                     '^┃致命抗性：\\d*.*理相：(\\D*)\\((\\d*)\\)\\s*┃',
                     '', 'score_check_xy')
    create_trigger_t('score11',
                     '^┃书剑通宝：(\\N*)\\s*书剑元宝：(\\N*)\\s*竞技币：(\\N*)\\s*┃',
                     '', 'score_tb_check')
    create_trigger_t('score12',
                     "^本周您已经使用精英之书(\\D*)次。", '',
                     'score_ebook_check')
    create_trigger_t('score13', '^┃江湖声望：(\\d*)', '',
                     'score_sw_check')

    create_trigger_t('score14',
                     '^┃当前等级：(\\N*)\\s*死亡：(\\N*)\\s*打造机会：(\\N*)\\s*┃',
                     '', 'score_dz_check')
    SetTriggerOption("score1", "group", "score")
    SetTriggerOption("score2", "group", "score")
    SetTriggerOption("score3", "group", "score")
    SetTriggerOption("score4", "group", "score")
    SetTriggerOption("score5", "group", "score")
    SetTriggerOption("score6", "group", "score")
    SetTriggerOption("score7", "group", "score")
    SetTriggerOption("score8", "group", "score")
    SetTriggerOption("score9", "group", "score")
    SetTriggerOption("score10", "group", "score")
    SetTriggerOption("score11", "group", "score")
    SetTriggerOption("score12", "group", "score")
end
score_dz_check = function(n, l, w)
    score.dj = tonumber(w[1])
    score.sww = tonumber(w[2])
    score.dz = tonumber(w[3])
end

score_sw_check = function(n, l, w) score.sw = trans(w[1]) end

function check_pot(p_cmd)
    if hp.exp < 5000000 then
        l_pot = hp.pot_max - 100
    else
        l_pot = hp.pot_max - 200
    end
    flag.lingwu = 0

    job_exp_tongji()

    if flag.autoxuexi == nil then flag.autoxuexi = 0 end

    if hp.pot < l_pot then
        print("潜能不够，继续工作")
        return check_job()
    elseif flag.autoxuexi == 0 then
        print("flag.autoxuexi 为0，继续工作")
        return check_job()
    end

    local max_skill = hp.pot_max - 100
    if score.party == "普通百姓" then
        if score.gold and skills["literate"] and score.gold > 3000 and
            skills["literate"].lvl < max_skill then return literate() end
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
            skills["literate"].lvl < max_skill then return literate() end

        -- flag.xuexi = 1 when parry < 450
        if flag.type and flag.type ~= 'lingwu' and flag.xuexi == 1 then
            return checkxue()
        end

        -- find special force, if level < 100 then xuexi.
        for p in pairs(skills) do
            local q = qrySkillEnable(p)
            if q and q['force'] and perform.force and p == perform.force and
                skills[p].lvl < 100 then
                if skills[p].mstlvl and skills[p].mstlvl > skills[p].lvl then
                    return checkxue()
                end
            end
        end

        -- check perform skill, if less than 450 go xuexi.  This clause might need to remove.
        if perform.skill and skills[perform.skill] and skills[perform.skill].lvl <
            450 then return checkxue() end

        -- if parry > 450, always lingwu.
        if skills["parry"] and skills["parry"].lvl >= 450 then
            if skills["parry"].lvl < max_skill then
                flag.lingwu = 1
            else
                local skillsLingwu = {}
                skillsLingwu = utils.split(GetVariable("lingwuskills"), '|')
                for i, p in pairs(skillsLingwu) do
                    if skillEnable[p] == nil and skills[p] and skills[p].lvl <
                        max_skill then
                        flag.lingwu = 1
                        break
                    end
                end
            end
        end

        if flag.lingwu == 1 then return checklingwu() end

        if not flag.wxjz then flag.wxjz = 0 end
        if skills["wuxiang-zhi"] and flag.wxjz == 0 then
            if skills["finger"].lvl > skills["wuxiang-zhi"].lvl and
                skills["wuxiang-zhi"].lvl < max_skill then
                return wxjzFofa()
            end
        end
    end
    return check_job()
end

function lingwu_trigger()
    DeleteTriggerGroup("lingwu")
    create_trigger_t('lingwu1',
                     "^.*(你只能从特殊技能中领悟。|你不会这种技能。|你要领悟什么？)",
                     '', 'lingwu_next')
    create_trigger_t('lingwu2',
                     "^.*你的\\D*不够，无法领悟更深一层的基本",
                     '', 'lingwu_next')
    create_trigger_t('lingwu3',
                     "^.*以你现在的基本内功修为，尚无法领悟基本内功。",
                     '', 'lingwu_next')
    create_trigger_t('lingwu4',
                     "^.*由于实战经验不足，阻碍了你的「\\D*」进步",
                     '', 'lingwu_next')
    SetTriggerOption("lingwu1", "group", "lingwu")
    SetTriggerOption("lingwu2", "group", "lingwu")
    SetTriggerOption("lingwu3", "group", "lingwu")
    SetTriggerOption("lingwu4", "group", "lingwu")
    EnableTriggerGroup("lingwu", false)
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
    messageShow('去少林领悟')
    jifaAll()
    go(lingwu_unwield, '嵩山少林', '达摩院')
end
function lingwu_unwield()
    exe('hp')
    weaponWieldLearn()
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
    tmp.lingwustart = true
    if hp.neili < 1000 then
        if hp.exp > 20000000 or score.gender == '无' then
            exe('eat ' .. drug.neili)
            -- return go(lingwu_eat, '武当山', '茶亭')
        else
            return lingwuSleep()
        end
    end
    flag.idle = nil
    local skill_max = hp.pot_max - 100
    wait.make(function()
        SetSpeedWalkDelay(math.floor(1000 / 30))
        for i, skill in pairs(skillsLingwu) do
            if not skills[skill] or skills[skill].lvl == 0 or skills[skill].lvl >=
                skill_max then
                print("不需要学习:" .. skill)
            else
                tmp.lingwunext = false
                local l, w
                while true do
                    exe('#9(lingwu ' .. skill .. ');yun jing')
                    l, w = wait.regexp(
                               '.*(你的内力不够|你深深吸了几口气，精神看起来好多了|你现在精神饱满|潜能已经用完了)',
                               1)
                    if l == nil then
                        -- 可能昏迷了或者flood，超时返回,

                    elseif l:find('内力不够') then
                        exe('eat ' .. drug.neili)
                        exe('eat ' .. drug.neili2 .. ';yun jing')
                    elseif l:find('潜能已经用完了') then
                        return lingwu_finish()
                    elseif tmp.lingwunext then
                        tmp.lingwunext = false
                        break
                    end
                end
            end
        end
        flag.lingwu = 0
        lingwudie = 1
        xxpot = hp.pot_max
        -- return check_bei(lingwu_finish)
        wait_busy()
        -- SetSpeedWalkDelay(0)  --no need to set it back just set the flag and let queue auto determinate
        return lingwu_finish()
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

function lingwu_next() tmp.lingwunext = true end

function lingwu_finish()
    tmp.stop = true
    tmp.lingwustart = false
    messageShow('少林领悟完成')
    local skill = skillsLingwu[tmp.lingwu]
    EnableTriggerGroup("lingwu", false)
    DeleteTriggerGroup("lingwu")
    exe('cha')
    flag.lingwu = 0
    if tmp.lingwu ~= nil and tmp.lingwu > 1 and tmp.lingwu <=
        table.getn(skillsLingwu) then
        table.remove(skillsLingwu, tmp.lingwu)
        table.insert(skillsLingwu, 1, skill)
    end
    return check_jobx()
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
    checkWield()
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
        -- checkWield()
    end
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    checkWield()
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
    -- local leweapon = GetVariable("learnweapon")
    -- exe('cha;unwield ' .. leweapon)
    checkWield()
    dis_all()
    return check_busy(check_food)
end

function check_xuexi()
    if MidHsDay[locl.time] and score.master == '风清扬' then
        return check_job()
    end
    -- if needxuexi==0 then
    -- return check_job()
    -- end
    -- if needxuexi==1 then
    return check_pot()
    -- end
end
function literate()
    messageShow('学习读书写字！')
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 10
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then
            master.times = 50
        elseif master.times < 10 then
            master.times = 10
        end
    end
    return check_busy(literateGo)
end
function literateGo()
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    checkWield()
    go(literateCheck, '扬州城', '书院')
end
function literateCheck()
    DeleteTriggerGroup("litxuexi")
    create_trigger_t('litxuexi1',
                     "^(> )*顾炎武对着你端详了一番道：“你因经验所制，暂时无法再进修更高深的学问了。”",
                     '', 'litxuexiover')
    create_trigger_t('litxuexi2',
                     "^(> )*你今天太累了，结果什么也没有学到",
                     '', 'litxuexisleep')
    create_trigger_t('litxuexi3',
                     "^.*说道：您太客气了，这怎么敢当？", '',
                     'litxuexiover')
    SetTriggerOption("litxuexi1", "group", "litxuexi")
    SetTriggerOption("litxuexi2", "group", "litxuexi")
    SetTriggerOption("litxuexi3", "group", "litxuexi")
    EnableTriggerGroup("litxuexi", true)
    flag.idle = nil
    exe('hp')
    return checkWait(literateXue, 0.8)
end
function litxuexiover()
    DeleteTriggerGroup("litxuexi")
    dis_all()
    return check_halt(literateBack)
end
function literateXue()
    if not locl.id["顾炎武"] then return literateBack() end
    if hp.neili < 100 then
        if hqd_cur > 0 then
            exe('eat huangqi dan')
        elseif hp.exp < 800000 and needxuexi == 1 then
            return xuexi()
        else
            return literateBack()
        end
    end
    if hp.neili < 1000 then exe('eat ' .. drug.neili2) end
    if hp.pot > master.times - 1 then
        -- yunAddInt()
        exe('yun jing;xue gu literate ' .. master.times)
        return check_busy(literateCheck)
    elseif hp.pot < master.times then
        return literateBack()
    else
        return literateBack()
    end
end
function literateBack()
    messageShow('读书写字学习完毕！')
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('unwield ' .. leweapon)
    exe('hp;score;cha;yun jing;yun qi;yun jingli')
    dis_all()
    checkWield()
    return check_busy(check_food)
end
function litxuexisleep()
    if score.gender == '男' then
        return go(litxuexiSleepOver, "songshan/nan-room", "")
    else
        return go(litxuexiSleepOver, "songshan/nv-room", "")
    end
end
function litxuexiSleepOver()
    exe('sleep')
    checkWait(checkPrepare, 3)
end
function duanzao()
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 3
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then master.times = 50 end
    end
    return check_busy(duanzaoGo)
end
function duanzaoGo() return go(duanzaoCheck, '扬州城', '兵器铺') end
function duanzaoCheck()
    flag.idle = nil
    exe('score;hp;cha')
    checkBags()
    return checkWait(duanzaoXue, 0.8)
end
function duanzaoXue()
    if not locl.id["铸剑师"] then return duanzaoBack() end
    if hp.neili < 100 then
        if hqd_cur > 0 then
            exe('eat huangqi dan')
        else
            return duanzaoBack()
        end
    end
    if hp.neili < 1000 then exe('eat ' .. drug.neili2) end
    if skills["duanzao"] and skills["duanzao"].lvl >= 221 then
        return duanzaoBack()
    end
    if Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt > 30 and
        hp.pot > master.times - 1 then
        -- yunAddInt()
        exe('yun jing;xue shi duanzao ' .. master.times)
        return duanzaoCheck()
    elseif hp.pot < master.times then
        return duanzaoBack()
    elseif score.gold > 300 then
        return check_bei(duanzaoQu, 1)
    else
        return duanzaoBack()
    end
end
function duanzaoQu()
    exe('n;#3w;#3n;w;qu 30 gold')
    exe('e;#3s;#3e;s')
    return check_busy(duanzaoCheck, 1)
end
function duanzaoBack()
    exe('hp')
    return check_busy(check_food)
end

function zhizao()
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 3
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then master.times = 50 end
    end
    return check_busy(zhizaoGo)
end
function zhizaoGo() return go(zhizaoCheck, '大理城', '裁缝店') end
function zhizaoCheck()
    flag.idle = nil
    exe('score;hp;cha')
    checkBags()
    return checkWait(zhizaoXue, 0.8)
end
function zhizaoXue()
    if not locl.id["老裁缝"] then return zhizaoBack() end
    if hp.neili < 100 then
        if hqd_cur > 0 then
            exe('eat huangqi dan')
        else
            return zhizaoBack()
        end
    end
    if hp.neili < 1000 then exe('eat ' .. drug.neili2) end
    if skills["zhizao"] and skills["zhizao"].lvl >= 221 then
        return zhizaoBack()
    end
    if Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt > 30 and hp.pot >
        master.times - 1 then
        -- yunAddInt()
        exe('yun jing;xue caifeng zhizao ' .. master.times)
        return zhizaoCheck()
    elseif hp.pot < master.times then
        return zhizaoBack()
    elseif score.gold > 300 then
        return check_bei(zhizaoQu, 1)
    else
        return zhizaoBack()
    end
end
function zhizaoQu()
    exe('e;n;#3e;n;qu 30 gold')
    exe('s;#3w;s;w')
    return check_busy(zhizaoCheck, 1)
end
function zhizaoBack()
    exe('hp')
    return check_busy(check_food)
end

function lianxi(times, xskill)
    local weapontype
    flag.lianxi = 1
    local lianxi_times = 5
    if times ~= nil then lianxi_times = times end
    tmp.xskill = xskill
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
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if (not tmp.xskill or tmp.xskill == p) and q == "force" and
                skills[p].full == 0 and perform.force and perform.force == p then
                lianxi_times = lianxi_times * 0.5
                exe('lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                exe('hp')
                break
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if (not tmp.xskill or tmp.xskill == p) and q == "dodge" and
                skills[p].full == 0 then
                exe('bei none;jifa ' .. q .. ' ' .. p)
                exe('lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                break
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if p == "yuxiao-jian" then
                weapontype = "xiao"
            else
                weapontype = q
            end
            if (not tmp.xskill or tmp.xskill == p) and q and p == perform.skill and
                skills[p].full == 0 and
                ((weaponKind[weapontype] and weaponInBag(weapontype)) or
                    unarmedKind[q]) then
                exe('bei none;jifa ' .. q .. ' ' .. p)
                weapon_unwield()
                if weaponKind[q] then
                    exe('wield ' .. q)
                    for k, v in pairs(Bag) do
                        if Bag[k].kind == weapontype then
                            exe('wield ' .. Bag[k].fullid)
                        end
                    end
                end
                exe('i;lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                break
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if p == "yuxiao-jian" then
                weapontype = "xiao"
            else
                weapontype = q
            end
            if (not tmp.xskill or tmp.xskill == p) and q and q ~= "force" and
                skills[p].full == 0 and
                ((weaponKind[weapontype] and weaponInBag(weapontype)) or
                    unarmedKind[q]) then
                exe('bei none;jifa ' .. q .. ' ' .. p)
                weapon_unwield()
                if weaponKind[q] then
                    exe('wield ' .. q)
                    for k, v in pairs(Bag) do
                        if Bag[k].kind == weapontype then
                            exe('wield ' .. Bag[k].fullid)
                        end
                    end
                end
                exe('i;lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                break
            end
        end
    end
    beiUnarmed()
end
function beiUnarmed()
    local l_skill = beiUnarmedSkill()
    if l_skill and type(l_skill) == "string" and skillEnable[l_skill] then
        exe('bei none')
        exe('jifa ' .. skillEnable[l_skill] .. ' ' .. l_skill)
        exe('bei ' .. skillEnable[l_skill])
    end
    if skillHubei[l_skill] and skills[skillHubei[l_skill]] then
        l_skill = skillHubei[l_skill]
        exe('jifa ' .. skillEnable[l_skill] .. ' ' .. l_skill)
        exe('bei ' .. skillEnable[l_skill])
    end
end
function beiUnarmedSkill()
    local l_lvl = 0
    local l_skill
    if perform and perform.skill and skillEnable[perform.skill] and
        unarmedKind[skillEnable[perform.skill]] then
        -- exe('bei '.. skillEnable[perform.skill])
        return perform.skill
    end
    for p in pairs(flagFull) do
        if skills[p] and skillEnable[p] and unarmedKind[skillEnable[p]] then
            q = skillEnable[p]
            -- exe('bei none;jifa '..q..' '..p..';bei '..q)
            return p
        end
    end
    if score.party then
        if score.party == "峨嵋派" and skills["hand"] and
            skills["jieshou-jiushi"] then
            -- exe('bei none;jifa hand jieshou-jiushi;bei hand')
            return "jieshou-jiushi"
        end
        if score.party == "丐帮" and skills["strike"] and
            skills["xianglong-zhang"] then
            -- exe('bei none;jifa strike xianglong-zhang;bei strike')
            return "xianglong-zhang"
        end
    end
    for p in pairs(skills) do
        if skillEnable[p] then
            q = skillEnable[p]
            if unarmedKind[q] then
                if skills[p].lvl > l_lvl then
                    l_lvl = skills[p].lvl
                    l_skill = p
                    -- exe('bei none;jifa '..q..' '..p..';bei '..q)
                end
            end
        end
    end
    return l_skill
end

function checkWield()
    itemWield = {}
    exe('i')
end
function checkWieldCatch(n, l, w)
    itemWield = itemWield or {}
    local l_item = w[1]
    for p in pairs(weaponThrowing) do
        if string.find(l_item, p) then l_item = p end
    end
    itemWield[l_item] = true
end
function show_beinang()
    DeleteTriggerGroup("beinang")
    create_trigger_t('beinang1', '^(> )*(\\D*)\\(', '', 'checkbeinang')
    SetTriggerOption("beinang1", "group", "beinang")
    EnableTriggerGroup("beinang", true)
    Beinang = {}
end
function checkbeinang(n, l, w) table.insert(Beinang, Trim(w[2])) end
function checkYaoBags(func)
    DeleteTriggerGroup("Yaobags")
    create_trigger_t('Yaobags1',
                     '^(> )*(\\D*)(锭|两|张)(白银|黄金|壹仟两银票)\\(',
                     '', 'checkBagsMoney')
    create_trigger_t('Yaobags2',
                     '^(> )*你把 "action" 设定为 "检查药品" 成功完成。$',
                     '', 'checkYaoBagsOver')
    create_trigger_t('Yaobags3', '^(> )*(\\D*)封失落的信笺', '',
                     'checkBagsletter')
    SetTriggerOption("Yaobags1", "group", "Yaobags")
    SetTriggerOption("Yaobags2", "group", "Yaobags")
    SetTriggerOption("Yaobags3", "group", "Yaobags")
    EnableTriggerGroup("Yaobags", true)
    cty_cur = 0
    nxw_cur = 0
    cbw_cur = 0
    hqd_cur = 0
    hxd_cur = 0
    -- print(cty_cur,nxw_cur,hxd_cur)
    Bag["黄金"].cnt = 0
    Bag["白银"].cnt = 0
    tmp.yaobags = func
    exe('i;look bei nang')
    exe('alias action 检查药品')
end
function checkYaoBagsOver()
    checkBY()
    draw_beinangwindow()
    EnableTriggerGroup("Yaobags", false)
    DeleteTriggerGroup("Yaobags")
    EnableTriggerGroup("beinang", false)
    DeleteTriggerGroup("beinang")
    -- print(cty_cur,nxw_cur,hxd_cur)
    if tmp.yaobags ~= nil then return tmp.yaobags() end
end

function checkBY()
    if not Beinang then Beinang = {"空"} end
    for i = 1, #Beinang do
        if Beinang[i] == "" or Beinang[i] == nil then
            Beinang[i] = "数据丢失"
        end
        local l_name = Beinang[i]
        if string.find(l_name, "蝉蜕金疮药") then
            cty_cur = trans(Beinang[i])
        end
        if string.find(l_name, "颗内息丸") then
            nxw_cur = trans(Beinang[i])
        end
        if string.find(l_name, "川贝内息丸") then
            cbw_cur = trans(Beinang[i])
        end
        if string.find(l_name, "黄芪内息丹") then
            hqd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "活血疗精丹") then
            hxd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "大还丹") then
            dhd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "铁矿石") then
            kuang_cur = trans(Beinang[i])
        elseif l_name:find("金矿石") then
            kuang_cur1 = trans(Beinang[i])
        end
        -- print(cty_cur,nxw_cur,hxd_cur,dhd_cur)
    end
end

function checkBags(func)
    DeleteTriggerGroup("bags")
    create_trigger_t('bags1', "^(> )*你身上携带物品的别称如下", '',
                     'checkBagsStart')
    create_trigger_t('bags2', "^\\d*:(\\D*) = (\\D*)$", '', 'checkBagsId')
    create_trigger_t('bags3',
                     '^(> )*你目前已经拥有了(\\D*)件私有装备：(\\D*)。$',
                     '', 'checkBagsU')
    create_trigger_t('bags4',
                     '^(> )*(\\D*)(锭|两|张)(白银|黄金|壹仟两银票)\\(',
                     '', 'checkBagsMoney')
    create_trigger_t('bags5',
                     '^(> )*你把 "action" 设定为 "检查包裹" 成功完成。$',
                     '', 'checkBagsOver')
    create_trigger_t('bags6', '^(> )*(\\D*)封失落的信笺', '',
                     'checkBagsletter')
    create_trigger_t('bags7', '^(> )*(\\D*)枚飞镖\\(', '', 'checkBagsDart')
    create_trigger_t('bags8',
                     '^(> )*你身上带着(\\D*)件东西\\(负重\\s*(\\d*)\\.\\d*\\%\\)：',
                     '', 'checkBagsW')
    SetTriggerOption("bags1", "group", "bags")
    SetTriggerOption("bags2", "group", "bags")
    SetTriggerOption("bags3", "group", "bags")
    SetTriggerOption("bags4", "group", "bags")
    SetTriggerOption("bags5", "group", "bags")
    SetTriggerOption("bags6", "group", "bags")
    SetTriggerOption("bags7", "group", "bags")
    SetTriggerOption("bags8", "group", "bags")
    EnableTriggerGroup("bags", false)
    EnableTrigger("bags1", true)
    cty_cur = 0
    nxw_cur = 0
    cbw_cur = 0
    hqd_cur = 0
    hxd_cur = 0
    -- print(cty_cur,nxw_cur,hxd_cur)
    bags = {}
    Bag = {}
    Bag["黄金"] = {}
    Bag["黄金"].id = {}
    Bag["黄金"].cnt = 0
    Bag["白银"] = {}
    Bag["白银"].id = {}
    Bag["白银"].cnt = 0
    Bag["枚飞镖"] = {}
    Bag["枚飞镖"].id = {}
    Bag["枚飞镖"].cnt = 0
    tmp.bags = func
    weaponUsave = {}
    exe('id')
    checkWield()
    exe('look bei nang')
    exe('uweapon;alias action 检查包裹')
end
function checkBagsletter() lostletter = 1 end
function checkBagsStart() EnableTriggerGroup("bags", true) end
function checkBagsId(n, l, w)
    local l_name = Trim(w[1])
    local l_id = w[2]
    local l_set = {}
    local l_cnt = 0
    if not Bag[l_name] then Bag[l_name] = {} end
    Bag[l_name].id = {}
    if string.find(l_id, ",") then
        l_set = utils.split(l_id, ',')
        l_id = l_set[1]
        for k, v in ipairs(l_set) do
            -- table.insert(Bag[l_name].id,1,Trim(v))
            Bag[l_name].id[Trim(v)] = true
            if string.len(Trim(v)) > l_cnt then
                Bag[l_name].fullid = Trim(v)
                l_cnt = string.len(Trim(v))
            end
        end
    else
        Bag[l_name].id[Trim(l_id)] = true
        -- table.insert(Bag[l_name].id,1,Trim(l_id))
        Bag[l_name].fullid = Trim(l_id)
    end
    if Bag[l_name].id["armor"] then Bag[l_name].kind = "armor" end
    if Bag[l_name].id["glove"] then Bag[l_name].kind = "glove" end
    if Bag[l_name].id["boot"] then Bag[l_name].kind = "boot" end
    if Bag[l_name].id["mantle"] then Bag[l_name].kind = "mantle" end
    if Bag[l_name].id["coat"] then Bag[l_name].kind = "coat" end
    if Bag[l_name].id["cap"] then Bag[l_name].kind = "cap" end
    if Bag[l_name].id["belt"] then Bag[l_name].kind = "belt" end
    if Bag[l_name].id["dao"] or Bag[l_name].id["blade"] then
        Bag[l_name].kind = "blade"
    end
    if Bag[l_name].id["jian"] or Bag[l_name].id["sword"] then
        Bag[l_name].kind = "sword"
    end
    if Bag[l_name].id["xiao"] then Bag[l_name].kind = "xiao" end
    if Bag[l_name].id["gun"] or Bag[l_name].id["club"] then
        Bag[l_name].kind = "club"
    end
    if Bag[l_name].id["stick"] or Bag[l_name].id["zhubang"] or
        Bag[l_name].id["bang"] then Bag[l_name].kind = "stick" end
    if Bag[l_name].id["bi"] or Bag[l_name].id["brush"] then
        Bag[l_name].kind = "brush"
    end
    if Bag[l_name].id["qiang"] or Bag[l_name].id["spear"] then
        Bag[l_name].kind = "spear"
    end
    if Bag[l_name].id["chui"] or Bag[l_name].id["hammer"] then
        Bag[l_name].kind = "hammer"
    end
    if Bag[l_name].id["gangzhang"] or Bag[l_name].id["staff"] or
        Bag[l_name].id["zhang"] or Bag[l_name].id["jiang"] then
        Bag[l_name].kind = "staff"
    end
    if Bag[l_name].id["bian"] or Bag[l_name].id["whip"] then
        Bag[l_name].kind = "whip"
    end
    if Bag[l_name].id["hook"] then Bag[l_name].kind = "hook" end
    if Bag[l_name].id["fu"] or Bag[l_name].id["axe"] then
        Bag[l_name].kind = "axe"
    end
    if Bag[l_name].id["bishou"] or Bag[l_name].id["dagger"] then
        Bag[l_name].kind = "dagger"
    end
    if weaponThrowing[l_name] then Bag[l_name].kind = "throwing" end
    if (string.find(l_name, "残篇") or string.find(l_name, "精要")) and
        not itemSave[l_name] then
        exe('read book')
        exe('drop ' .. Bag[l_name].fullid)
    end
    if string.len(l_name) == 6 and
        (string.sub(l_name, 5, 6) == "药" or string.sub(l_name, 5, 6) == "丸" or
            string.sub(l_name, 5, 6) == "丹") and
        (not drugPoison[l_name] and not drugBuy[l_name]) then
        exe('eat ' .. Bag[l_name].fullid)
    end
    bags[l_name] = Trim(l_id)
    if Bag[l_name].cnt then
        Bag[l_name].cnt = Bag[l_name].cnt + 1
    else
        Bag[l_name].cnt = 1
    end
end
function checkBagsU(n, l, w)
    local t = Trim(w[3])
    local s = utils.split(t, ',')
    for p, q in pairs(s) do
        if string.find(q, '⊕') then q = string.sub(q, 3) end
        weaponUsave[q] = true
    end
end
function checkBagsMoney(n, l, w)
    local l_cnt = trans(Trim(w[2]))
    local l_name = Trim(w[4])
    if Bag[l_name] then Bag[l_name].cnt = l_cnt end
end
function checkBagsW(n, l, w)
    local t = tonumber(w[3])
    Bag = Bag or {}
    Bag["ENCB"] = {}
    Bag["ENCB"].value = t
end
function checkBagsDart(n, l, w)
    local l_cnt = trans(Trim(w[2]))
    local l_name = '枚飞镖'
    if Bag[l_name] then Bag[l_name].cnt = l_cnt end
end
--[[function checkBagsYao(n,l,w)
   local l_cnt=trans(Trim(w[2]))
   local l_name=Trim(w[3])
  if string.find(l_name,"蝉蜕金疮药") then
	   cty_cur = l_cnt
	end
	if string.find(l_name,"黄芪内息丹") then
	   nxw_cur = l_cnt
	end
	if string.find(l_name,"活血疗精丹") then
	   hxd_cur = l_cnt
	end
	if string.find(l_name,"大还丹") then
	   dhd_cur = l_cnt
	end
end]]
function checkBagsOver()
    draw_bagwindow()
    checkBY()
    draw_beinangwindow()
    EnableTriggerGroup("bags", false)
    DeleteTriggerGroup("bags")
    EnableTriggerGroup("beinang", false)
    DeleteTriggerGroup("beinang")
    if Bag["大碗茶"] then exe("drop cha") end
    if Bag["棉花种子"] then exe('drop ' .. Bag["棉花种子"].fullid) end
    if Bag["棉花"] then exe('drop ' .. Bag["棉花"].fullid) end
    if Bag["青铜"] then exe('drop ' .. Bag["青铜"].fullid) end
    if Bag["生铁"] then exe('drop ' .. Bag["生铁"].fullid) end
    if Bag["粗绳子"] and Bag["粗绳子"].cnt > 2 then
        exe('drop cu shengzi 2')
    end
    -- print(cty_cur,nxw_cur,hxd_cur)
    if tmp.bags ~= nil then return tmp.bags() end
end

function isInBags(p_item)
    if p_item == nil then return false end
    local l_cnt = 0
    local l_item
    if Bag[p_item] then
        l_item = p_item
        l_cnt = l_cnt + Bag[p_item].cnt
        -- return p_item,Bag[p_item].cnt
    end
    for k, v in pairs(Bag) do
        if type(v.id) == "table" then
            if v.id[p_item] then
                l_item = k
                l_cnt = l_cnt + Bag[k].cnt
            end
        end
    end
    if l_cnt > 0 then return l_item, l_cnt end
    return false
end

function check_item()
    if score.party and score.party == "峨嵋派" and not Bag["腰带"] then
        return check_item_go()
    elseif score.party == "少林派" and not Bag["护腰"] and
        not Bag["护腕"] then
        return go(checkSengxie, '嵩山少林', '防具库')
    else
        return check_item_over()
    end
end
function checkSengxie()
    exe('ask chanshi about 僧鞋')
    return check_bei(checkHuyao)
end
function checkHuyao()
    exe('ask chanshi about 护腰')
    return check_bei(checkHuwan)
end
function checkHuwan()
    exe('ask chanshi about 护腕')
    return check_bei(check_item_over)
end
function check_item_go() go(check_item_belt, '峨嵋山', '储物间') end
function check_item_belt()
    exe('ask shitai about 皮腰带')
    check_bei(check_item_over)
end
function check_item_over()
    exe('drop shoes 2')
    exe('remove all')
    exe('wear all')

    flag.item = true

    return checkPrepare()
end
function VIPask()
    exe('ask laoban about 会员成长')
    check_bei(VIPask2)
end
function VIPask2()
    exe('ask laoban about 会员福利')
    check_bei(Ebookcheck)
end
function Ebookcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Ebookcheck
    create_trigger_t('vipchk1',
                     "^(> )*您是本站终身会员，本次购物免费。",
                     '', 'vipEbookck')
    create_trigger_t('vipchk2', "^(> )*本周你已无法使用精英之书。",
                     '', 'Yjwcheck')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        return exe('duihuan ebook')
    else
        return Gstart()
    end
end
function vipEbookck() check_halt(vipEbook) end
function vipEbook() exe('duihuan ebook') end
function Yjwcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Yjwcheck
    create_trigger_t('vipchk1',
                     "^(> )*您是本站终身会员，本次购物免费。",
                     '', 'vipYjwck')
    create_trigger_t('vipchk2', "^(> )*本周你已无法使用玉肌丸。",
                     '', 'Ygcheck')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        return check_halt(vipYjw)
    else
        return Gstart()
    end
end
function vipYjwck() check_halt(vipYjw) end
function vipYjw() exe('duihuan yuji wan') end
function Ygcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Yjwcheck
    create_trigger_t('vipchk1',
                     "^(> )*您是本站终身会员，本次购物免费。",
                     '', 'vipYggo')
    create_trigger_t('vipchk2', "^(> )*本周你已无法使用鸳鸯锦帕。",
                     '', 'Gstart')
    create_trigger_t('vipchk3', "^(> )*你给瑛姑一方鸳鸯锦帕", '',
                     'vipYgok')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    SetTriggerOption("vipchk3", "group", "vipchk")
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        return check_halt(vipYg)
    else
        return Gstart()
    end
end
function vipYggo() return go(vipGhyg, '大理城', '茶馆') end
function vipGhyg() exe('guihuan ying gu') end
function vipYgok() return go(vipYg, '扬州城', '当铺') end
function vipYg() exe('duihuan jinpa') end
function Vipcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id vipcheck
    create_trigger_t('vipchk1',
                     "^(> )*您是本站终身会员，本次购物免费。",
                     '', 'vipxidu')
    create_trigger_t('vipchk2', "^(> )*你的朱睛冰蟾已经用完了。",
                     '', 'vipxidu_over')
    create_trigger_t('vipchk3', "^(> )*本周你已无法使用", '', 'vipover')
    create_trigger_t('vipchk4',
                     "^(> )*你先要用完现有的物品才能再次兑换。",
                     '', 'vipxidu')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    SetTriggerOption("vipchk3", "group", "vipchk")
    SetTriggerOption("vipchk4", "group", "vipchk")
    -- if vippoison==1 and ptbxvip==1 then
    -- return exe('duihuan bingchan')
    -- else
    return check_xue()
    -- end
end
function vipxidu() return check_busy(xidu) end
function xidu() exe('xidu') end
function vipxidu_over()
    EnableTriggerGroup("vipchk", false)
    DeleteTriggerGroup("vipchk")
    vippoison = 0
    return check_halt(vipdhd)
end
function vipdhd()
    DeleteTriggerGroup("vipdhd")
    -- ain dls nv id vipcheck
    create_trigger_t('vipdhd1',
                     "^(> )*您是本站终身会员，本次购物免费。",
                     '', 'vipeatdhd')
    create_trigger_t('vipdhd2', "^(> )*你的大还丹已经用完了。", '',
                     'vipdhd_over')
    create_trigger_t('vipdhd3', "^(> )*本周你已无法使用", '', 'vipover')
    create_trigger_t('vipdhd4',
                     "^(> )*你先要用完现有的物品才能再次兑换。",
                     '', 'vipeatdhd')
    create_trigger_t('vipdhd5', "^(> )*看清楚点，这东西能吃吗？",
                     '', 'vipdhd_over')
    SetTriggerOption("vipdhd1", "group", "vipdhd")
    SetTriggerOption("vipdhd2", "group", "vipdhd")
    SetTriggerOption("vipdhd3", "group", "vipdhd")
    SetTriggerOption("vipdhd4", "group", "vipdhd")
    SetTriggerOption("vipdhd5", "group", "vipdhd")
    exe('duihuan dahuan dan')
end
function vipeatdhd() return check_busy(eatdhd) end
function eatdhd() exe('eat dan') end
function vipdhd_over()
    EnableTriggerGroup("vipdhd", false)
    DeleteTriggerGroup("vipdhd")
    return check_halt(checkPrepare)
end
function vipover()
    EnableTriggerGroup("vipchk", false)
    DeleteTriggerGroup("vipchk")
    EnableTriggerGroup("vipdhd", false)
    DeleteTriggerGroup("vipdhd")
    ptbxvip = 0
    inwdj = 0
    return check_xue()
end
function checkvip()
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        exe('cond')
        return go(Vipcheck, '扬州城', '当铺')
    else
        return check_xue()
    end
end
function check_heal()
    collectgarbage("collect")
    dis_all()
    tmp = {}
    jobTriggerDel()
    job.name = 'heal'
    if score.party and score.party == "神龙教" then
        exe('yun shougong ' .. score.id)
    end
    if perform.force and skills[perform.force] then
        exe('jifa force ' .. perform.force)
    end
    button_smyteam()
    button_lostletter()
    check_halt(check_jingxue_count)
end
function check_jingxue_count()
    checkBags()
    if hp.exp < 150000 then
        return checkWait(check_heal_over, 1)
    elseif (hp.exp > 150000 and hp.exp < 800000) then
        -- return checkWait(check_heal_newbie,1)
        return go(check_heal_newbie, "扬州城", "药铺")
    elseif hp.jingxue_per < 96 or hp.qixue_per < 88 then
        return checkWait(checkvip, 1)
    else
        return checkWait(check_jingxue, 1)
    end
end
function check_jingxue()
    if (hp.qixue_per < 98 and hp.qixue_per > 88) and cty_cur > 0 then
        exe('eat chantui yao;hp')
        return check_busy(check_jingxue, 1)
    else
        if cty_cur == 0 then return checkHxd() end
        -- ain
        if score.party == "大轮寺" and hp.neili > 2000 then
            exe('yun juxue')
        end
        return check_halt(check_heal_over, 1)
    end
end
function check_heal_newbie()
    if hp.qixue_per < 100 then
        exe('buy jinchuang yao;eat jinchuang yao;hp')
        return check_busy(check_heal_newbie, 3)
    else
        if hp.jingxue_per < 100 then
            exe('buy yangjing dan;eat yangjing dan')
        end
        return check_halt(check_heal_over, 1)
    end
end
function check_heal_over()
    DeleteTriggerGroup("ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    DeleteTriggerGroup("ck_xue_teach")
    return check_halt(checkPrepare)
end
function check_xue()
    EnableTrigger("hp19", false)
    tmp.xueSkills = {}
    tmp.xueCount = 1
    tmp.xueTimes = 0
    for p in pairs(skills) do
        if skills[p].lvl > 100 then table.insert(tmp.xueSkills, p) end
    end
    if hp.exp > 500000 then
        return go(check_xue_ask, '柳宗镇', '正厅')
    else
        return check_xue_fail()
    end
end
function check_xue_ask()
    DeleteTriggerGroup("ck_xue_ask")
    create_trigger_t('ck_xue_ask1',
                     '^(> )*你向薛慕华打听有关『疗伤』的消息。$',
                     '', 'check_xue_accept')
    create_trigger_t('ck_xue_ask2', '^(> )*这里没有这个人', '',
                     'check_xue_fail')
    SetTriggerOption("ck_xue_ask1", "group", "ck_xue_ask")
    SetTriggerOption("ck_xue_ask2", "group", "ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    create_trigger_t('ck_xue_accept1',
                     '^(> )*薛慕华「嘿嘿嘿」奸笑了几声。$', '',
                     'check_xue_teach')
    create_trigger_t('ck_xue_accept2',
                     '^(> )*一柱香的工夫过去了，你觉得伤势已经基本痊愈了。',
                     '', 'check_xue_heal')
    create_trigger_t('ck_xue_accept3',
                     '^(> )*薛神医拿出一根银针轻轻捻入你受伤部位附近的穴道',
                     '', 'check_xue_wait')
    create_trigger_t('ck_xue_accept4',
                     '^(> )*薛慕华似乎不懂你的意思。$', '',
                     'check_xue_heal')
    create_trigger_t('ck_xue_accept5',
                     '^(> )*薛慕华「啪」的一声倒在地上，挣扎着抽动了几下就死了',
                     '', 'check_xue_fail')
    SetTriggerOption("ck_xue_accept1", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept2", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept3", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept4", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept5", "group", "ck_xue_accept")
    EnableTriggerGroup("ck_xue_accept", false)
    DeleteTriggerGroup("ck_xue_teach")
    create_trigger_t('ck_xue_teach1',
                     '^(> )*薛神医的这个技能已经不能再进步了。$',
                     '', 'check_xue_next')
    SetTriggerOption("ck_xue_teach1", "group", "ck_xue_teach")
    EnableTriggerGroup("ck_xue_teach", false)
    DeleteTriggerGroup("ck_xue_busy")
    create_trigger_t('ck_xue_busy1', '^(> )*您先歇口气再说话吧。$',
                     '', 'check_xue_busy')
    SetTriggerOption("ck_xue_busy1", "group", "ck_xue_busy")
    EnableTriggerGroup("ck_xue_busy", true)
    exe('ask xue muhua about 疗伤')
    create_timer_s('walkWait4', 3.0, 'check_xue_ask1')
end
function check_xue_ask1() exe('ask xue muhua about 疗伤') end
function check_xue_busy() return check_busy(check_xue_ok, 2) end
function check_xue_ok()
    EnableTriggerGroup("ck_xue_accept", true)
    exe('ask xue muhua about 疗伤')
end
function check_xue_fail()
    EnableTriggerGroup("ck_xue_ask", false)
    EnableTriggerGroup("ck_xue_accept", false)
    EnableTriggerGroup("ck_xue_teach", false)
    return check_jingxue()
end
function check_xue_accept()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("ck_xue_ask", false)
    EnableTriggerGroup("ck_xue_accept", true)
end
function check_xue_wait()
    EnableTrigger("ck_xue_accept1", false)
    EnableTrigger("ck_xue_accept3", false)
    EnableTrigger("ck_xue_accept4", false)
end
function check_xue_teach()
    EnableTrigger("ck_xue_accept1", false)
    EnableTriggerGroup("ck_xue_accept", false)
    EnableTriggerGroup("ck_xue_teach", true)
    if tmpxueskill then
        for i = 1, 10 do exe('teach xue ' .. tmpxueskill) end
    else
        for i = 1, 10 do exe('teach xue ' .. tmp.xueSkills[tmp.xueCount]) end
    end
    wait.make(function()
        wait.time(0.5)
        return check_busy(check_xue_ok)
    end)
end
function check_xue_next()
    EnableTriggerGroup("ck_xue_teach", false)
    if tmpxueskill then
        tmpxueskill = nil
        tmp.xueCount = 0
    end
    tmp.xueCount = tmp.xueCount + 1
    if tmp.xueCount > table.getn(tmp.xueSkills) then
        return check_jingxue()
    else
        return checkWait(check_xue_teach, 0.2)
    end
end
function check_xue_heal()
    EnableTriggerGroup("ck_xue_accept", false)
    DeleteTriggerGroup("ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    DeleteTriggerGroup("ck_xue_teach")
    DeleteTriggerGroup("ck_xue_busy")
    return check_bei(check_poison)
end
function check_poison()
    prepare_neili_stop()
    poison_dazuo()
    condition = {}
    exe('cond')
    return check_busy(preparePoison)
end
function preparePoison()
    EnableTrigger("hp19", true)
    if (not condition.poison or condition.poison == 0) then
        return check_halt(check_heal_over)
    end
    return dazuoPoison()
end
function dazuoPoison()
    condition.poison = 0
    exe('set 积蓄;hp;yun qi;yun jing;yun jingli;cond')
    exe('dazuo ' .. hp.dazuo)
end
function poison_dazuo()
    DeleteTriggerGroup("poison")
    create_trigger_t('poison1',
                     "^(> )*(过了片刻，你感觉自己已经将玄天无极神功|你将寒冰真气按周天之势搬运了一周|你只觉真力运转顺畅，周身气力充沛|你将纯阳神通功运行完毕|你只觉神元归一，全身精力弥漫|你将内息走了个一个周天|你将内息游走全身，但觉全身舒畅|你将真气逼入体内，将全身聚集的蓝色气息|你将紫气在体内运行了一个周天|你运功完毕，站了起来|你一个周天行将下来，精神抖擞的站了起来|你分开双手，黑气慢慢沉下|你将内息走满一个周天，只感到全身通泰|你真气在体内运行了一个周天，冷热真气收于丹田|你真气在体内运行了一个周天，缓缓收气于丹田|你双眼微闭，缓缓将天地精华之气吸入体内|你慢慢收气，归入丹田，睁开眼睛|你将内息又运了一个小周天，缓缓导入丹田|你感觉毒素越转越快，就快要脱离你的控制了！|你将周身内息贯通经脉，缓缓睁开眼睛，站了起来|你呼翕九阳，抱一含元，缓缓睁开双眼|你吸气入丹田，真气运转渐缓，慢慢收功|你将真气在体内沿脉络运行了一圈，缓缓纳入丹田|你将内息在体内运行十二周天，返回丹田|你将内息走了个小周天，流回丹田，收功站了起来|过了片刻，你已与这大自然融合在一起，精神抖擞的站了起|你感到自己和天地融为一体，全身清爽如浴春风，忍不住舒畅的呻吟了一声，缓缓睁开了眼睛)",
                     '', 'poisondazuo_desc')
    create_trigger_t('poison2',
                     "^(> )*你现在精不够，无法控制内息的流动！",
                     '', 'checkDebug')
    SetTriggerOption("poison1", "group", "poison")
    SetTriggerOption("poison2", "group", "poison")
    EnableTriggerGroup("poison", true)
end
function poisondazuo_desc()
    if condition.poison and condition.poison == 0 then
        EnableTriggerGroup("poison", false)
        DeleteTriggerGroup("poison")
        exe('yun jing;yun qi;yun jingli')
        return check_bei(check_food)
    end
    return poisonLianxi()
end
function poisonLianxi()
    exe('sxlian')
    wait.make(function()
        wait.time(2)
        return check_busy(preparePoison)
    end)
end

function Ronglian()
    dis_all()
    job.name = "refine"
    return go(Brefine, '扬州城', '兵器铺')
end
function Brefine()
    if kuang_cur and kuang_cur > 2000 then
        kuang_cur = math.modf(kuang_cur / 1000) * 1000
    else
        kuang_cur = 1000
    end
    kuangshi = "tiekuang shi"
    DeleteTriggerGroup("refine")
    create_trigger_t('refine1', "^(> )*你没有足够的铁矿石。", '',
                     'refineGold')
    create_trigger_t('refine2', "^(> )*你没有足够的金矿石。", '',
                     'refineOK')
    create_trigger_t('refine3',
                     "^(> )*你努力地催动炉火开始精炼铁矿石", '',
                     'refinecheck')
    create_trigger_t('refine4', "^(> )*你要精炼矿石的数量必须整千",
                     '', 'refinenumber')
    SetTriggerOption("refine1", "group", "refine")
    SetTriggerOption("refine2", "group", "refine")
    SetTriggerOption("refine3", "group", "refine")
    SetTriggerOption("refine4", "group", "refine")
    EnableTriggerGroup("refine", true)
    create_timer_s('refine', 2, 'refine')
end
function refinecheck() exe('cond') end
function refinenumber() kuang_cur = 1000 end
function refine()
    exe('refine ' .. kuang_cur .. ' ' .. kuangshi)
    exe('l bei nang')
end
function refineGold()
    kuang_cur = 0
    if kuang_cur1 and kuang_cur1 > 2000 then
        kuang_cur1 = math.modf(kuang_cur1 / 1000) * 1000
    else
        kuang_cur1 = 1000
    end
    kuang_cur = kuang_cur1
    kuangshi = "jinkuang shi"
end
function refineOK()
    kuang_cur = 0
    kuang_cur1 = 0
    DeleteTriggerGroup("refine")
    checkBags()
    wait.make(function()
        wait.time(3)
        dis_all()
        fqyyArmorMessage('熔炼矿石完毕！')
        job.name = nil
        return checkWait(checkPrepare)
    end)
end

function check_food()
    exe('cha') -- 自动练功机器人设定。
    set_sxlian()
    if score.gender == '无1' then -- 厂公专用，封闭房间
        map.rooms["city/mingyufang"].ways["north"] = nil
        map.rooms["changan/eastjie1"].ways["north"] = nil
    end
    map.rooms["sld/lgxroom"].ways["#outSld"] = "huanghe/huanghe8"
    if score.party == '华山派' and hp.shen < 0 then
        map.rooms["huashan/houtang"].ways["north"] = nil
        map.rooms["huashan/qianting"].ways["south"] = nil
    end
    if score.party == '姑苏慕容' then
        map.rooms["mtl/anbian1"].ways["qu xiaozhu;#CboatWait"] = nil
        map.rooms["mtl/anbian1"].ways["qu yanziwu;#CboatWait"] = nil
        map.rooms["mr/testmatou1"].ways["qu yanziwu;#boatWait"] = nil
        map.rooms["mr/testmatou1"].ways["qu mr;#boatWait"] = nil
        map.rooms["mr/tingyuju"].ways["tan qin;#boatWait"] = nil
        map.rooms["mr/xiaodao"].ways["#boatYell"] = nil
        map.rooms["yanziwu/anbian3"].ways["#boatYell"] = nil
        map.rooms["yanziwu/anbian4"].ways["#boatYell"] = nil
        if skills["douzhuan-xingyi"] ~= nil then
            if not skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl >
                130 and skills["douzhuan-xingyi"].lvl < 170 then
                dzxy_level = 1
            end
            if not skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl >
                170 and skills["douzhuan-xingyi"].lvl < 200 then
                dzxy_level = 2
            end
            if not skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl >
                200 and skills["douzhuan-xingyi"].lvl < hp.pot_max - 100 then
                dzxy_level = 3
            end
        end
    end
    beiUnarmed()
    dis_all()
    hpheqi()
    if mydummy == true then return dummyfind() end
    -- if job.zuhe["wudang"] then wait_kill='yes' end

    if flag.xuncheng_start then return xunCheng() end
    exe('remove all;wear all')
    exe('hp;unset no_kill_ap;yield no')
    score.zt = '去武当吃喝'
    wait.make(function()
        wait_busy()
        if (hp.food < 60 or hp.water < 60) and hp.exp < 500000 then
            return go(dali_eat, '大理城', '茶馆')
        elseif hp.food < 60 or hp.water < 60 then
            return go(wudang_eat, '武当山', '茶亭')
        else
            check_bei(check_food_over)
        end
    end)
end
function wudang_eat()
    if locl.room == "茶亭" then
        flag.food = 0
        DeleteTimer("food")
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#4(drink cha);drop cha;drop tao;fill jiudai')
        check_bei(check_food_over)
    else
        return go(wudang_eat, '武当山', '茶亭')
    end
end
function check_food_over()
    if (kuang_cur and kuang_cur > 2000) or (kuang_cur1 and kuang_cur1 > 2000) then
        return Ronglian()
    end
    return check_heal()
end

function dali_eat()
    if locl.room == "茶馆" then
        flag.food = 0
        DeleteTimer("food")
        exe('#5(drink);e;e;s;buy baozi;#2(eat baozi)')
        check_bei(check_food_over)
    else
        return go(dali_eat, '大理城', '茶馆')
    end
end

function checkHammer() return go(checkHmGive, "扬州城", "兵器铺") end
function checkHmGive()
    if Bag["韦兰之锤"] then
        exe('give ' .. Bag["韦兰之锤"].fullid .. ' to zhujian shi')
    end
    Bag["韦兰之锤"] = nil
    return checkPrepare()
end

function check_gold()
    tmp.cnt = 0
    return go(check_gold_dali, "大理城", "大理钱庄")
end
function check_gold_dali()
    if not locl.id["严掌柜"] then
        return go(check_gold_xy, "襄阳城", "宝龙斋")
    else
        return check_gold_count()
    end
end
function check_gold_xy()
    if not locl.id["钱善人"] then
        return go(check_gold_cd, "成都城", "墨玉斋")
    else
        return check_gold_count()
    end
end
-- function check_gold_cd()
--    if not locl.id["王掌柜"] then
--	   return go(check_gold_yz,"扬州城","天阁斋")
--	else
--	   return check_gold_count()
--	end
-- end
-- ain
function newbie_qu_gold() return go(check_gold_qu, "大理城", "大理钱庄") end
function check_gold_cd()
    if not locl.id["钱缝"] then
        return go(check_gold_dali, "大理城", "大理钱庄")
    else
        return check_gold_count()
    end
end
function check_gold_count()
    if Bag['壹仟两银票'] and Bag['壹仟两银票'].cnt > 10 then
        exe('score;chazhang')
        if score.goldlmt and score.gold and (score.goldlmt - score.gold) > 50 then
            return check_cash_cun()
        end
    end
    if Bag and Bag["白银"] and Bag["白银"].cnt and
        (Bag["白银"].cnt > 100 or Bag["白银"].cnt < 50) then
        return check_silver_qu()
    end
    if (Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt >
            count.gold_max * 4) then return check_gold_qu() end

    return check_gold_over()
end
function check_cash_cun()
    if Bag['壹仟两银票'] then
        local l_cnt
        if score.goldlmt and score.gold and (score.goldlmt - score.gold) <
            Bag['壹仟两银票'].cnt * 10 then
            l_cnt = math.modf((score.goldlmt - score.gold) / 10) - 1
        else
            l_cnt = Bag['壹仟两银票'].cnt
        end
        if l_cnt > 0 then exe('cun ' .. l_cnt .. ' cash') end
    end
    checkBags()
    return checkWait(check_gold_check)
end
function check_silver_qu()
    local l_cnt = Bag["白银"].cnt - 50
    exe('cun ' .. l_cnt .. ' silver')
    exe('qu 50 silver')
    -- checkBags()
    -- return checkWait(check_gold_check,3)
    return checkPrepareOver()
end
function check_gold_qu()
    local l_cnt = Bag["黄金"].cnt - count.gold_max * 2
    exe('cun ' .. l_cnt .. ' gold')
    if Bag["黄金"].cnt < count.gold_max then
        exe('qu ' .. count.gold_max .. ' gold')
    end
    -- checkBags()
    -- return checkWait(check_gold_check,3)
    return checkPrepareOver()
end
function check_gold_check()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then return check_heal() end
    return check_gold_count()
end
function check_gold_over() return checkPrepare() end

function checkZqd()
    tmp.cnt = 0
    return go(checkZqdBuy, randomElement(drugBuy["正气丹"]))
end
function checkZqdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkZqdOver()
    else
        exe('buy zhengqi dan')
        checkBags()
        return check_bei(checkZqdi)
    end
end
function checkZqdi()
    if Bag["黄金"] and Bag["黄金"].cnt > 4 and
        (not Bag["正气丹"] or Bag["正气丹"].cnt < 4) then
        return checkWait(checkZqdBuy, 1)
    else
        return checkZqdOver()
    end
end
function checkZqdOver()
    checkBags()
    return check_bei(checkPrepare, 1)
end

function checkXqw()
    tmp.cnt = 0
    return go(checkXqwBuy, randomElement(drugBuy["邪气丸"]))
end
function checkXqwBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkXqwOver()
    else
        exe('buy xieqi wan')
        checkBags()
        return check_bei(checkXqwi)
    end
end
function checkXqwi()
    if Bag["黄金"] and Bag["黄金"].cnt > 4 and
        (not Bag["邪气丸"] or Bag["邪气丸"].cnt < 4) then
        return checkWait(checkXqwBuy, 1)
    else
        return checkXqwOver()
    end
end
function checkXqwOver()
    checkBags()
    return check_bei(checkPrepare, 1)
end

function checkNxw()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and
        (nxw_cur < count.nxw_max or cbw_cur < count.cbw_max or hqd_cur <
            count.hqd_max) then
        return go(checkNxwBuy, randomElement(drugBuy["内息丸"]))
    else
        return checkNxwOver()
    end
end
function checkNxwBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkNxwOver()
    else
        if hqd_cur < count.hqd_max then exe('buy ' .. drug.neili3) end
        if cbw_cur < count.cbw_max then exe('buy ' .. drug.neili2) end
        if nxw_cur < count.nxw_max then exe('buy ' .. drug.neili) end
        checkYaoBags()
        return check_bei(checkNxwi)
    end
end
function checkNxwi()
    if (nxw_cur < count.nxw_max or cbw_cur < count.cbw_max or hqd_cur <
        count.hqd_max) and Bag["黄金"] and Bag["黄金"].cnt > 4 then
        return checkWait(checkNxwBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkNxwOver() return check_bei(checkPrepare, 1) end

function checkHxd()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and cty_cur < count.cty_max then
        return go(checkHxdBuy, randomElement(drugBuy["蝉蜕金疮药"]))
    else
        return checkNxwOver()
    end
end
function checkHxdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 25 then
        return checkNxwOver()
    else
        exe('buy ' .. drug.heal)
        checkYaoBags()
        return check_bei(checkHxdBag)
    end
end
function checkHxdBag()
    if cty_cur < count.cty_max and Bag["黄金"] and Bag["黄金"].cnt > 4 then
        return checkWait(checkHxdBuy, 1)
    else
        return checkNxwOver()
    end
end

function checkLjd()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and hxd_cur < count.hxd_max then
        return go(checkLjdBuy, randomElement(drugBuy["活血疗精丹"]))
    else
        return checkNxwOver()
    end
end
function checkLjdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkNxwOver()
    else
        exe('buy ' .. drug.jingxue)
        checkYaoBags()
        return check_bei(checkLjdBag)
    end
end
function checkLjdBag()
    if hxd_cur < count.hxd_max and Bag["黄金"] and Bag["黄金"].cnt > 4 then
        return checkWait(checkLjdBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkdhd()
    tmp.cnt = 0
    if score.tb and score.tb > 100 and dhd_cur < count.dhd_max then
        return go(checkdhdBuy, randomElement(drugBuy["大还丹"]))
    else
        return checkNxwOver()
    end
end
function checkdhdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkNxwOver()
    else
        exe('duihuan dahuan dan;score')
        checkYaoBags()
        return check_halt(checkdhdBag)
    end
end
function checkdhdBag()
    if dhd_cur < count.dhd_max and score.tb and score.tb > 100 then
        return checkWait(checkdhdBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkFire()
    if not Bag["火折"] then
        return go(checkFireBuy, randomElement(drugBuy["火折"]))
    else
        return checkFireOver()
    end
end
function checkFireBuy()
    exe('buy fire')
    checkBags()
    return checkFireOver()
end
function checkFireOver()
    exe('drop fire 2')
    return check_busy(checkPrepare, 1)
end

function checkJiudai()
    if not Bag["牛皮酒袋"] then
        return go(checkJiudaiBuy, randomElement(drugBuy["牛皮酒袋"]))
    else
        return checkJiudaiOver()
    end
end
function checkJiudaiBuy()
    exe('buy jiudai;buy jiudai;buy jiudai')
    checkBags()
    return checkJiudaiOver()
end
function checkJiudaiOver() return check_busy(checkPrepare, 1) end

function checkYu(p_yu)
    tmp.yu = p_yu
    return go(checkYuCun, "扬州城", "杂货铺")
end
function checkYuCun()
    exe('cun ' .. Bag[tmp.yu].fullid)
    return check_bei(checkYuOver)
end
function checkYuOver()
    exe('cun yu;drop yu')
    checkBags()
    return check_busy(checkPrepare, 1)
end

function checkSell(p_sell)
    tmp.sell = p_sell
    return go(checkSellDo, "扬州城", "当铺")
end
function checkSellDo()
    if Bag[tmp.sell] then exe('sell ' .. Bag[tmp.sell].fullid) end
    return check_bei(checkSellOver)
end
function checkSellOver()
    if Bag[tmp.sell] then
        exe('sell ' .. Bag[tmp.sell].fullid)
        exe('drop ' .. Bag[tmp.sell].fullid)
    end
    checkBags()
    return check_busy(checkPrepare, 1)
end

function checkWeapon(p_weapon)
    tmp.cnt = 0
    tmp.weapon = p_weapon
    return go(checkWeaponBuy, weaponStore[p_weapon], '')
end
function checkWeaponBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 10 then
        checkBags()
        return check_heal()
    else
        if tmp.weapon and weaponStoreId[tmp.weapon] then
            exe('list;buy ' .. weaponStoreId[tmp.weapon])
            checkBags()
            return checkWait(checkWeaponI)
        else
            return check_heal()
        end
    end
end
function checkWeaponI()
    if not Bag[tmp.weapon] then
        return checkWeaponBuy()
    else
        return checkWeaponOver()
    end
end
function checkWeaponOver() return checkPrepare() end

function checkCodeError() return dis_all() end

function checkRefresh() job.time["refresh"] = os.time() % 900 end
