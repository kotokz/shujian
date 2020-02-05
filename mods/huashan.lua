-------华山
local huashanArea1 = {
    ["菜地"] = "华山村",
    ["杂货铺"] = "华山村",
    ["民房"] = "华山村",
    ["酒肆"] = "华山村",
    ["铁匠铺"] = "华山村",
    ["东村口"] = "华山村",
    ["碎石路"] = "华山村",
    ["玄坛庙"] = "华山村",
    ["苍龙岭"] = "华山",
    ["侧廊"] = "华山",
    ["瀑布"] = "华山",
    ["朝阳峰"] = "华山",
    ["镇岳宫"] = "华山",
    ["猢狲愁"] = "华山",
    ["莎萝坪"] = "华山",
    ["千尺幢"] = "华山",
    ["百尺峡"] = "华山",
    ["青柯坪"] = "华山",
    ["舍身崖"] = "华山",
    ["松树林"] = "华山",
    ["玉女峰"] = "华山",
    ["玉泉院"] = "华山",
    ["思过崖"] = "华山",
    ["药房"] = "华山",
    ["后堂"] = "华山",
    ["山涧"] = "华山",
    ["小溪"] = "华山",
    ["祭坛"] = "华山",
    ["思过崖洞口"] = "华山",
    ["山路"] = "华山",
    ["石屋"] = "华山",
    ["树林"] = "华山",
    ["华山脚下"] = "华山",
    ["山洪瀑布"] = "华山",
    ["练武场"] = "华山",
    ["饭厅"] = "华山",
    ["书房"] = "华山",
    ["饭厅"] = "华山",
    ["剑房"] = "华山",
    ["前厅"] = "华山",
    ["台阶"] = "华山",
    ["正气堂"] = "华山",
    ["寝室"] = "华山",
    ["休息室"] = "华山",
    ["老君沟"] = "华山",
    ["小山路"] = "华山"
}
job.list["huashan"] = "华山惩恶扬善"
function huashan()
    hsjob2 = 0
    dis_all()
    huashan_trigger()
    job.name = 'huashan'
    job.target = '任务目标'
    return huashan_start()
end
jobFindAgain = jobFindAgain or {}
jobFindAgain["huashan"] = "huashanFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["huashan"] = "huashanFindFail"
faintFunc = faintFunc or {}
faintFunc["huashan"] = "huashanFindAgain"
function huashanFindAgain()
    EnableTriggerGroup("huashan_find", true)
    if flag.times == 3 and dest.area == '华山村' then
        return go(huashanFindAct, '华山村', '菜地')
    end
    if flag.times == 3 and dest.area == '襄阳城' and dest.room ==
        '山间空地' then
        return go(huashanFindAct, '襄阳郊外', '瀑布')
    end
    if flag.times == 2 and job.area == '明教' and
        (job.room == "紫杉林" or string.find(job.room, "字门")) then
        return go(huashanFindAct, '明教', '练武场')
    end
    if flag.times == 3 and job.area == '扬州城' and job.room == '南门' then
        return go(huashanFindAct, '扬州城', '长江南岸')
    end
    if flag.times == 3 and job.area == '兰州城' and job.room == '西城门' then
        return go(huashanFindAct, '兰州城', '永登')
    end
    if flag.times == 3 and job.area == '嵩山少林' and job.room ==
        "罗汉堂" then
        return go(huashanFindAct, '嵩山少林', '罗汉堂五部')
    end
    if flag.times == 3 and job.area == '嵩山少林' and job.room ==
        "般若堂" then
        return go(huashanFindAct, '嵩山少林', '般若堂五部')
    end
    return go(huashanFindAct, dest.area, dest.room)
end
function huashanFindFail() return go(huashan_shibai, '华山', '正气堂') end
function huashan_start()
    DeleteTriggerGroup("all_fight")
    DeleteTriggerGroup("huashan_fight")
    DeleteTriggerGroup("huashan_cut")
    DeleteTriggerGroup("huashan_yls")
    DeleteTriggerGroup("huashan_yls_ask")
    DeleteTriggerGroup("huashan_over")
    DeleteTriggerGroup("huashan_find")
    flag.idle = nil
    return go(hsaskjob, '华山', '正气堂')
end
function hsaskjob()
    if newbie == 1 then
        return zhunbeineili(job_huashan)
    else
        return job_huashan()
    end
end
function job_huashan()
    EnableTriggerGroup("huashan_ask", true)
    exe('ask yue buqun about job')
    DeleteTimer("walkWait4")
    create_timer_s('walkWait4', 1.0, 'huashan_ask_test')
end
huashan_ask_test = function() exe('ask yue buqun about job') end
function huashan_trigger()
    DeleteTriggerGroup("huashan_find")
    DeleteTriggerGroup("huashan_ask")
    create_trigger_t('huashan_ask1',
                     "^(> )*你向岳不群打听有关『job』的消息。$",
                     '', 'huashan_ask')
    create_trigger_t('huashan_ask2', "^(> )*这里没有这个人。$", '',
                     'huashan_nobody')
    SetTriggerOption("huashan_ask1", "group", "huashan_ask")
    SetTriggerOption("huashan_ask2", "group", "huashan_ask")
    EnableTriggerGroup("huashan_ask", false)
    DeleteTriggerGroup("huashan_accept")
    create_trigger_t('huashan_accept1',
                     "^(> )*岳不群说道：「你不能光说呀，倒是做出点成绩给我看看！",
                     '', 'huashan_shibai')
    create_trigger_t('huashan_accept2',
                     "^(> )*岳不群说道：「你现在正忙着做其他任务呢！",
                     '', 'huashan_busy')
    create_trigger_t('huashan_accept3',
                     "^(> )*岳不群说道：「现在没有听说有恶人为害百姓",
                     '', 'huashan_fangqi')
    create_trigger_t('huashan_accept4',
                     "^(> )*岳不群给了你一块令牌。$", '',
                     'huashan_npc')
    create_trigger_t('huashan_accept5',
                     "^(> )*岳不群对你说道：你还是先去思过崖面壁思过去吧。",
                     '', 'huashanjjQuest')
    create_trigger_t('huashan_accept6',
                     "^(> )*岳不群说道：「现在没有听说有恶人为害百姓，你自己去修习武功去吧！」",
                     '', 'huashan_fangqi')
    SetTriggerOption("huashan_accept1", "group", "huashan_accept")
    SetTriggerOption("huashan_accept2", "group", "huashan_accept")
    SetTriggerOption("huashan_accept3", "group", "huashan_accept")
    SetTriggerOption("huashan_accept4", "group", "huashan_accept")
    SetTriggerOption("huashan_accept5", "group", "huashan_accept")
    SetTriggerOption("huashan_accept6", "group", "huashan_accept")
    EnableTriggerGroup("huashan_accept", false)
    DeleteTriggerGroup("huashan_npc")
    create_trigger_t('huashan_npc1',
                     "^(> )*(冷不防|突然|猛地|忽然|冷不丁)从树林\\D*你的令牌，向(\\D*)(处|方向)\\D*逃去。$",
                     '', 'huashan_where')
    create_trigger_t('huashan_npc2',
                     "^(> )*你一把抓向蒙面人试图抢回令牌，但被蒙面人敏捷得躲了过去，你顺手扯下蒙面人的面罩，发现原来是曾经名震江湖的(\\D*)。",
                     '', 'huashan_find')
    create_trigger_t('huashan_npc3',
                     '^(> )*你把 "hsjob" 设定为 "闲逛中" 成功完成。',
                     '', 'huashan_npc_goon')
    SetTriggerOption("huashan_npc1", "group", "huashan_npc")
    SetTriggerOption("huashan_npc2", "group", "huashan_npc")
    SetTriggerOption("huashan_npc3", "group", "huashan_npc")
    EnableTriggerGroup("huashan_npc", false)
    DeleteTriggerGroup("huashanQuest")
    create_trigger_t('huashanQuest1',
                     "^(> )*岳不群说道：「" .. score.name ..
                         "你杀了不少恶人，未免杀气过重不如上思过崖面壁忏悔吧",
                     '', 'huashanDgjj')
    SetTriggerOption("huashanQuest1", "group", "huashanQuest")
    EnableTriggerGroup("huashanQuest", false)
end
function huashan_triggerDel()
    DeleteTriggerGroup("all_fight")
    DeleteTriggerGroup("huashan_find")
    DeleteTriggerGroup("huashan_ask")
    DeleteTriggerGroup("huashan_accept")
    DeleteTriggerGroup("huashan_npc")
    DeleteTriggerGroup("huashan_fight")
    DeleteTriggerGroup("huashan_cut")
    DeleteTriggerGroup("huashan_yls")
    DeleteTriggerGroup("huashan_yls_ask")
    DeleteTriggerGroup("huashan_over")
    DeleteTriggerGroup("huashanQuest")
end
function huashan_ask()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_ask", false)
    EnableTriggerGroup("huashan_accept", true)
    quick_locate = 1
end
function huashan_nobody()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_ask", false)
    return huashan_start()
end
function huashan_shibai()
    EnableTriggerGroup("huashan_accept", false)
    kezhiwugongclose()
    return check_busy(huashan_shibai_b)
end
function huashan_shibai_b()
    flag.idle = nil
    DeleteTriggerGroup("all_fight")
    kezhiwugongclose()
    huashan_triggerDel()
    Execute('ask yue buqun about 失败')
    if job.where ~= nil and string.find(job.where, "侠客岛") then
        mjlujingLog("侠客岛")
    end
    messageShow('华山任务：任务失败。', "Plum")
    jobfailLog()
    return check_halt(check_food)
end
function huashan_fangqi()
    DeleteTriggerGroup("all_fight")
    kezhiwugongclose()
    huashan_triggerDel()
    job.last = "huashan"
    hsjob2 = 0
    -- if job.zuhe["wudang"] then
    --   job.last='wudang'
    -- end
    return check_halt(check_food)
end
function huashan_busy()
    EnableTriggerGroup("huashan_accept", false)
    return check_bei(huashan_busy_dazuo)
end
function huashan_busy_dazuo()
    exe('#3s')
    return prepare_lianxi(check_food)
end
function huashan_npc()
    EnableTimer('walkWait4', false)
    exe('nick 华山任务中')
    -- job.time.b=os.time()
    EnableTriggerGroup("huashan_accept", false)
    job.last = "huashan"
    if hsjob2 < 1 then
        job.time.b = os.time()
        messageShow('华山任务：开始任务。')
        return check_bei(huashan_npc_go)
    else
        return check_bei(huashan_npc_go2)
    end

end
function huashan_npc_go()
    go(huashan_npc_get, '华山', '山脚下', 'huashan/zhengqi')
end
function huashan_npc_go2()
    go(huashan_npc_get, '华山', '山脚下', 'huashan/jitan')
end
function huashan_npc_get()
    EnableTriggerGroup("huashan_npc", true)
    if score.id == 'kkfromch' then exe('set 兰花手 蝶舞式') end
    exe('unset wimpy;set wimpycmd pfmpfm\\hp')
    exe('set no_kill_ap')
    exe('s')
    return check_bei(huashan_npc_goon)
end
function huashan_npc_goon()
    DeleteTimer('walkWait4')
    exe('n;e;e')
    locate()
    return check_busy(huashan_ssl, 1)
end
function huashan_ssl()
    if locl.room == "石屋" or locl.room == "玉泉院" then
        return check_bei(huashan_npc_ssl)
    else
        return check_bei(huashan_npc_goon)
    end
end
function huashan_npc_ssl()
    create_timer_s('walkWait4', 2.0, 'hs_wander')
    return exe('w;s;s;alias hsjob 闲逛中')
    -- exe('w;s;s')
    -- huashan_npc_goon()     
end
function hs_wander() exe('alias hsjob 闲逛中') end
huashan_where = function(n, l, w)
    job.where = tostring(w[3])
    -- print("1"..job.where)
    if string.find(job.where, "华山石洞") and not Bag['绳子'] then
        job.where = "华山山涧"
    end
    if string.find(job.where, "嵩山少林菜地") then
        job.where = '嵩山少林寺前广场'
        messageShow('地点由嵩山少林菜地改为嵩山少林寺前广场',
                    'violet')
    end
    if string.find(job.where, "心禅堂") then
        job.where = "嵩山少林心禅坪"
    end
    if string.find(job.where, "萧府大厅") or
        string.find(job.where, "萧府书房") or
        string.find(job.where, "萧府厨房") or
        string.find(job.where, "萧府后院") then
        job.where = "萧府萧府大门"
    end
    if string.find(job.where, "苏州城闺房") and not Bag["铜钥匙"] then
        job.where = "苏州城翰林府院"
    end
    if (string.find(job.where, "瘦西湖酒馆") or
        string.find(job.where, "瘦西湖雅楼") or
        string.find(job.where, "珠宝店")) then
        job.where = "扬州城西大街"
    end
end
huashan_find = function(n, l, w)
    local flag_huashan = 0
    dis_all()
    job.target = tostring(w[2])
    job.killer = {}
    job.killer[job.target] = true
    DeleteTriggerGroup("huashan_find")
    create_trigger_t('huashan_find1', '^( )*' .. job.target .. '\\((\\D*)\\)',
                     '', 'huashan_fight')
    create_trigger_t('huashan_find2', '^(> )*看起来(\\D*)想杀死你！',
                     '', 'huashan_debug_fight')
    create_trigger_t('huashan_find3',
                     '^(> )*采花大盗正盯着你看，不知道打些什么主意。',
                     '', 'huashan_dadao')
    create_trigger_t('huashan_find4', '^( )*这不是抢走你令牌的人', '',
                     'huashan_find_again')
    SetTriggerOption("huashan_find1", "group", "huashan_find")
    SetTriggerOption("huashan_find2", "group", "huashan_find")
    SetTriggerOption("huashan_find3", "group", "huashan_find")
    SetTriggerOption("huashan_find4", "group", "huashan_find")
    SetTriggerOption("huashan_find1", "keep_evaluating", "y")
    SetTriggerOption("huashan_find2", "keep_evaluating", "y")
    if string.find(job.where, "洗象池") or
        string.find(job.where, "地下黑拳市") or
        string.find(job.where, '绝情谷石窟') then
        messageShow('华山任务②：任务地点【' .. job.where ..
                        '】不可到达，任务放弃。')
        return check_halt(huashanFindFail)
    end
    if string.find(job.where, "梅林") then job.where = '梅庄西湖边' end
    -- print("2"..job.where)
    if huashanArea1[job.where] then
        job.room = job.where
        job.area = huashanArea1[job.where]
    else
        job.room, job.area = getAddr(job.where)
    end
    dest.room = job.room
    dest.area = job.area
    if not job.room or not path_cal() or
        string.find(job.where, '绝情谷石窟') then
        messageShow('华山任务：任务地点【' .. job.where ..
                        '】不可到达，任务放弃。', "Plum")
        return check_halt(huashanFindFail)
    end
    print(dest.room, dest.area, job.room, job.area)
    messageShow(
        '华山任务：追杀逃跑到【' .. job.where .. '】的【' ..
            job.target .. '】。')
    locl.area = '华山'
    locl.room = '树林'
    quick_locate = 1
    if job.room == '侧廊' then flag.times = 2 end
    if job.area == '明教' and
        (job.room == "紫杉林" or string.find(job.room, "字门")) then
        job.room = "紫杉林"
    end
    if string.find(job.where, '蝴蝶谷') then return hudiegu() end
    return go(huashanFindAct, job.area, job.room, "huashan/shulin")
end
function huashan_find_again()
    EnableTimer('hskill', false)
    DeleteTimer('hskill')
    EnableTriggerGroup("huashan_find", false)
    go("华山", "正气堂")
    flag.wait = 0
    wait.make(function()
        wait.time(3.0)
        dis_all()
        EnableTriggerGroup("huashan_find", true)
        if string.find(job.where, '蝴蝶谷') then return hudiegu() end
        go(huashanFindAct, job.area, job.room)
    end)
end
function huashan_debug_fight()
    -- dis_all()
    EnableTrigger("huashan_find1", true)
    exe('look')
end
function huashanFindAct()
    DeleteTimer('hskill')
    EnableTriggerGroup("beinang", false)
    EnableTriggerGroup("huashan_find", true)
    job.flag()
    exe('look')
    find()
end
function huashanFindKill()
    dis_all()
    EnableTrigger("huashan_find1", true)
    exe('look')
end
huashan_dadao = function()
    dis_all()
    exe('yes')
    return go(huashanFindAct, dest.area, dest.room)
end
huashan_fight = function(n, l, w)
    flag.wait = 1
    EnableTrigger("huashan_find2", false)
    job.id = string.lower(w[2])
    exe('unset no_kill_ap;yield no')
    exe('follow ' .. job.id)
    job.killer[job.target] = job.id
    exe('kick ' .. job.id)
    exe('kill ' .. job.id)
    exe('set wimpycmd pfmpfm\\hp')
    exe('pfmwu')
    -- exe('set wimpy 100')
    dis_all()
    wait.make(function()
        wait.time(2)
        exe('set wimpy 100')
    end)
    -- kezhiwugong(job.target,job.id,'pfmpfm')
    kezhiwugong()
    kezhiwugongAddTarget(job.target, job.id)
    fight.time.b = os.time()
    EnableTrigger("hpheqi1", true)
    DeleteTriggerGroup("huashan_fight")
    create_trigger_t('huashan_fight1', '^(> )*' .. job.target ..
                         '「啪」的一声倒在地上', '', 'huashan_cut')
    create_trigger_t('huashan_fight2', '^(> )*' .. job.target ..
                         '神志迷糊，脚下一个不稳，倒在地上昏了过去。',
                     '', 'huashan_faint')
    create_trigger_t('huashan_fight3',
                     '^(> )*' .. job.target .. '匆匆离开。', '',
                     'huashanFindFail')
    create_trigger_t('huashan_fight4', '^(> )*这里没有 ' .. job.id .. '。',
                     '', 'huashanFindAct')
    -- create_trigger_t('huashan_fight4','^(> )*这里没有 '..job.id..'。','','huashanFindAgain')
    SetTriggerOption("huashan_fight1", "group", "huashan_fight")
    SetTriggerOption("huashan_fight2", "group", "huashan_fight")
    SetTriggerOption("huashan_fight3", "group", "huashan_fight")
    SetTriggerOption("huashan_fight4", "group", "huashan_fight")

    -- hs flood后kill命令出不来的workaround by joyce@tj
    addxml.trigger {
        custom_colour = "2",
        enabled = "y",
        group = "huashan_fight",
        match = "^(> )*你对着" .. job.target ..
            "(大喝一声：|喝道：|猛吼一声：|吼道：)",
        name = "huashan_fight_hskill",
        regexp = "y",
        script = "hskill_timer_stop",
        sequence = "100"
    }
    create_timer_s('hskill', 0.4, 'hskill')
end
function hskill() -- hs flood后kill命令出不来的workaround by joyce@tj
    exe('unset no_kill_ap;yield no')
    exe('set wimpycmd pfmpfm\\hp')
    exe('follow ' .. job.id)
    exe('kick ' .. job.id)
    exe('kill ' .. job.id)
    -- exe('set wimpy 100')
end
function hskill_timer_stop() -- hs flood后kill命令出不来的workaround by joyce@tj
    DeleteTimer('hskill')
    EnableTrigger("huashan_fight_hskill", false)
    quick_locate = 1
end
huashan_faint = function()
    exe('unset wimpy;unset no_kill_ap;yield no')
    exe('kill ' .. job.id)
end
huashan_cut = function()
    EnableTriggerGroup("huashan_fight", false)
    EnableTriggerGroup("huashan_find", false)
    DeleteTriggerGroup("huashan_cut")
    create_trigger_t('huashan_cut1',
                     '^(> )*只听“咔”的一声，你将(\\D*)的首级斩了下来，提在手中。',
                     '', 'huashan_cut_con')
    create_trigger_t('huashan_cut2',
                     '^(> )*(光天化日的想抢劫啊|乱切别人杀的人干嘛啊|你手上这件兵器无锋无刃|你得用件锋利的器具才能切下这尸体的头来)',
                     '', 'huashan_cut_weapon')
    create_trigger_t('huashan_cut3',
                     '^(> )*你将(\\D*)的尸体扶了起来背在背上。',
                     '', 'huashan_get_con')
    create_trigger_t('huashan_cut4',
                     '^(> )*你上一个动作还没有完成！', '',
                     'huashan_get_con1')
    SetTriggerOption("huashan_cut1", "group", "huashan_cut")
    SetTriggerOption("huashan_cut2", "group", "huashan_cut")
    SetTriggerOption("huashan_cut3", "group", "huashan_cut")
    SetTriggerOption("huashan_cut4", "group", "huashan_cut")
    SetTriggerOption("huashan_cut4", "keep_evaluating", "y")
    job.killer = {}
    fight.time.e = os.time()
    fight.time.over = fight.time.e - fight.time.b
    messageShowT('华山任务：战斗用时:【' .. fight.time.over ..
                     '】秒,搞定蒙面人：【' .. job.target .. '】。')
    -- return check_halt(huashan_cut_act)
    tmp.cnt = 0
    if job.area == '绝情谷' then
        exe('drop corspe')
        for i = 1, 5 do
            exe('halt;get ling pai from corpse ' .. i)
            exe('qie corpse ' .. i)
        end
        create_timer_st('walkWait2', 1.0, 'huashan_cut_act1')
    else
        -- for i=1,5 do
        -- exe('get ling pai from corpse '..i)
        -- end
        exe('get corpse')
        create_timer_st('walkWait2', 1.0, 'huashan_cut_act1')
    end
end
huashan_get_con1 = function()
    EnableTimer('walkWait2', false)
    EnableTriggerGroup("huashan_fight", false)
    EnableTriggerGroup("huashan_find", false)
    checkWait(huashan_cut, 3)
end
huashan_cut1 = function()
    exe('get corpse')
    for i = 1, 5 do exe('get ling pai from corpse ' .. i) end
end
--[[huashan_cut_act=function()
    DeleteTimer('perform')
    weapon_unwield()
    weaponWieldCut()
    for i=1,5 do
       exe('halt;get ling pai from corpse '..i)
       exe('qie corpse '..i)
    end
	if fqyytmp.goArmorD==1 then
       return	
    end
	checkBags()
end]]
huashan_cut_act = function()
    tmp.cnt = 0
    weapon_unwield()
    weaponWieldCut()
    -- wipe_kill=0
    wait.make(function()
        wait.time(1.5)
        exe('drop corpse')
        for i = 1, 3 do
            exe('get ling pai from corpse ' .. i)
            exe('qie corpse ' .. i)
        end
        create_timer_s('walkWait2', 1.0, 'huashan_cut_act1')
    end)
end
function huashan_cut_act1()
    if tmp.cnt then tmp.cnt = tmp.cnt + 1 end
    if not tmp.cnt or tmp.cnt > 10 then
        dis_all()
        return huashanFindFail()
    end
    exe('drop corpse')
    for i = 1, 3 do
        exe('get ling pai from corpse ' .. i)
        exe('qie corpse ' .. i)
    end
end
huashan_cut_weapon = function()
    DeleteTimer('walkWait2')
    return check_halt(huashan_cut_act, 1)
end
huashan_get_con = function(n, l, w)
    DeleteTimer('walkWait2')
    DeleteTriggerGroup("all_fight")
    EnableTriggerGroup("huashan_npc", false)
    kezhiwugongclose()
    if fqyytmp.goArmorD ~= 1 then checkBags() end
    if job.target == tostring(w[2]) then
        EnableTriggerGroup("huashan_npc", false)
        EnableTriggerGroup("huashan_cut", false)
        -- fpk_prepare()--预防pk的设置，定义在skill.lua中
        for i = 1, 3 do exe('get ling pai from corpse ' .. i) end
        road.id = nil
        fightoverweapon()
        return go(huashan_yls_give, '华山', '祭坛')
    else
        return check_halt(huashan_cut_act)
    end
end
huashan_cut_con = function(n, l, w)
    EnableTimer('walkWait2', false)
    DeleteTriggerGroup("all_fight")
    EnableTriggerGroup("huashan_npc", false)
    kezhiwugongclose()
    flag.find = 0
    if job.target ~= tostring(w[2]) then
        exe('drop head')
        return check_halt(huashan_cut_act)
    else
        EnableTriggerGroup("huashan_cut", false)
        road.id = nil
        wait.make(function()
            wait.time(1)
            fightoverweapon()
            return go(huashan_yls_give, '华山', '祭坛')
        end)
    end
end
huashan_yls = function()
    huashan_yls_trigger()
    EnableTriggerGroup("ylshead", true)
    exe('alias action 华山任务完成')
    create_timer_s('walkWait4', 0.6, 'huashan_yls_timer')
end

huashan_yls_trigger = function()
    DeleteTriggerGroup("ylshead")
    create_trigger_t('ylshead1',
                     '^(> )*你把 "action" 设定为 "华山任务完成" 成功完成。$',
                     '', 'huashan_yls_give')
    SetTriggerOption("ylshead1", "group", "ylshead")
    EnableTriggerGroup("ylshead", false)
end

huashan_yls_timer = function()
    exe('get ling pai from corpse;give head to yue lingshan')
    exe('give corpse to yue lingshan')
end

huashan_yls_give = function()
    EnableTriggerGroup("ylshead", false)
    DeleteTriggerGroup("huashan_yls")
    -- create_trigger_t('huashan_yls1','^(> )*(这里没有这个人。|你身上没有这样东西。|这人好象不是你杀的吧？|你的令牌呢|你还没有去找恶贼，怎么就来祭坛了？)','','huashan_yls_fail')
    -- create_trigger_t('huashan_yls1','^(> )*(这人好象不是你杀的吧？|你的令牌呢|你还没有去找恶贼，怎么就来祭坛了？)','','huashan_yls_fail')
    create_trigger_t('huashan_yls1',
                     '^(> )*(你的令牌呢|你还没有去找恶贼，怎么就来祭坛了？)',
                     '', 'huashan_yls_fail')
    create_trigger_t('huashan_yls2',
                     '^(> )*岳灵珊在你的令牌上写下了一个 (一|二) 字。',
                     '', 'huashan_yls_ask')
    create_trigger_t('huashan_yls3',
                     '^(> )*这好象不是你领的令牌吧？', '',
                     'huashan_yls_lingpai')
    SetTriggerOption("huashan_yls1", "group", "huashan_yls")
    SetTriggerOption("huashan_yls2", "group", "huashan_yls")
    SetTriggerOption("huashan_yls3", "group", "huashan_yls")
    EnableTriggerGroup("huashan_yls", true)
    exe('get ling pai from corpse;give head to yue lingshan')
    exe('give corpse to yue lingshan')
    create_timer_s('walkWait4', 2.0, 'huashan_yls_timer')
end
--[[huashan_head_return=function()
    exe('give head to yue lingshan;hp')        
end]]
huashan_yls_fail = function()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls", false)
    if locl.room ~= "祭坛" then return go(huashan_yls, '华山', '祭坛') end
    exe('out;w;s;se;su;su;s')
    return check_halt(huashan_shibai_b)
end
huashan_yls_lingpai = function()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls", false)
    exe('drop ling pai')
    return check_halt(huashan_yls)
end
huashan_yls_ask = function(n, l, w)
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls", false)
    DeleteTriggerGroup("huashan_yls_ask")
    create_trigger_t('huashan_yls_ask1',
                     '^(> )*你向岳灵珊打听有关『力不从心』的消息。',
                     '', 'huashan_yls_back')
    SetTriggerOption("huashan_yls_ask1", "group", "huashan_yls_ask")
    EnableTriggerGroup("huashan_yls_ask", false)
    quick_locate = 1
    if w[2] == '二' then return huashan_yls_back() end
    if w[2] == '一' and (dohs2 == 0 or (lostletter == 1 and needdolost == 1)) then
        wait.make(function()
            wait.time(2.0)
            return check_bei(huashan_yls_lbcx)
        end)
        -- return check_bei(huashan_yls_lbcx)
    else
        wait.make(function()
            wait.time(2.0)
            return check_bei(huashan_heal)
        end)
        -- return check_bei(huashan_heal)
    end
end
huashan_heal = function()
    exe('set no_kill_ap')
    exe('drop head;drop corpse')
    return check_bei(huashan_neili)
end
huashan_neili = function()
    hsjob2 = 1
    if newbie == 1 then
        return zhunbeineili(huashan_npc)
    else
        print("不是新手不打坐！")
        return check_bei(huashan_npc)
    end
end
huashan_yls_lbcx = function()
    EnableTriggerGroup("huashan_yls_ask", true)
    weapon_unwield()
    return exe('drop head;askk yue lingshan about 力不从心')
end
huashan_yls_back = function()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls_ask", false)
    EnableTriggerGroup("huashanQuest", true)
    DeleteTriggerGroup("huashan_over")
    create_trigger_t('huashan_over1', '^(> )*你给岳不群一块令牌。',
                     '', 'huashan_finish')
    create_trigger_t('huashan_over2', '^(> )*这里没有这个人。', '', '')
    SetTriggerOption("huashan_over1", "group", "huashan_over")
    SetTriggerOption("huashan_over2", "group", "huashan_over")
    quick_locate = 1
    return go(huashan_over, '华山', '正气堂', 'huashan/jitan')
end
huashan_over = function()
    -- weapon_unwield()
    EnableTriggerGroup("huashanQuest", true)
    job.time.e = os.time()
    job.time.over = job.time.e - job.time.b
    messageShowT('华山任务：完成任务，用时:【' .. job.time.over ..
                     '】秒。')
    exe('give ling pai to yue buqun')
    DeleteTimer("walkWait4")
    create_timer_s('walkWait4', 1.0, 'job_huashan_over1')
end
function job_huashan_over1() exe('give ling pai to yue buqun') end
huashan_finish = function()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    job.name = 'idle'
    wudang_checkfood = 0 -- 可以重新检查食物，在武当那里检查。
    map.rooms["village/zhongxin"].ways["northwest"] = "village/caidi"
    map.rooms["village/zhongxin"].ways["northeast"] = "village/caidi"
    EnableTriggerGroup("huashan_over", false)
    EnableTriggerGroup("huashanQuest", true)
    flag.times = 1
    quick_locate = 1
    locl.area = '华山'
    locl.room = '正气堂'
    hsjob2 = 0
    exe('drop ling pai;drop head;drop corpse')
    -- jobExpTongji()
    huashan_triggerDel()
    -- if job.zuhe["wudang"] then
    --     job.last='wudang'
    -- end
    setLocateRoomID = 'huashan/zhengqi'
    -- return check_halt(check_food)原来的check_food注销掉。
    if Bag and Bag["白银"] and Bag["白银"].cnt and Bag["白银"].cnt > 500 then
        return check_gold()
    end
    if (Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt >
            count.gold_max * 4) then return check_gold() end
    hsruntime = hsruntime + 1
    if hsruntime > 9 then
        hsruntime = 0
        return check_food()
    else
        return checkPrepare()
    end
end
function huashanDgjj()
    if score.party and score.party == "华山派" then
        messageShow('华山任务：出现面壁提示了！')
    end
    return huashan_finish()
end
function huashanjjQuest()
    EnableTriggerGroup("huashan_accept", false)
    if score.party and score.party == "华山派" then
        messageShow(
            '华山任务：提示要求面壁思过，停止做华山任务')
        job.zuhe["huashan"] = nil
        return check_heal()
    else
        return huashan_finish()
    end
end

