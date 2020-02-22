-- 创建一个普通别名
function create_alias(a_name, a_match, a_response)
    return AddAlias(a_name, a_match, a_response, alias_flag.Enabled +
                        alias_flag.Replace + alias_flag.RegularExpression, '')
end
-- 创建一个脚本别名
function create_alias_s(a_name, a_match, a_function)
    return AddAlias(a_name, a_match, '',
                    alias_flag.Enabled + alias_flag.Replace, a_function)
end
-- 创建一个分定时器
function create_timer_m(t_name, t_min, t_function)
    return AddTimer(t_name, 0, t_min, 0, '', timer_flag.Enabled +
                        timer_flag.ActiveWhenClosed + timer_flag.Replace,
                    t_function)
end
-- 创建一个秒定时器
function create_timer_s(t_name, t_second, t_function)
    return AddTimer(t_name, 0, 0, t_second, '', timer_flag.Enabled +
                        timer_flag.ActiveWhenClosed + timer_flag.Replace,
                    t_function)
end
-- 创建一个一次性秒定时器
function create_timer_st(t_name, t_second, t_function)
    return AddTimer(t_name, 0, 0, t_second, '',
                    timer_flag.Enabled + timer_flag.ActiveWhenClosed +
                        timer_flag.Replace + timer_flag.OneShot, t_function)
end
-- 创建一个触发器 
function create_trigger_t(t_name, t_match, t_response, t_function)
    return AddTrigger(t_name, t_match, t_response, trigger_flag.Enabled +
                          trigger_flag.RegularExpression + trigger_flag.Replace,
                      -1, 0, "", t_function)
end
-- 创建一个临时的触发器 
function create_trigger_f(t_name, t_match, t_response, t_function)
    return AddTrigger(t_name, t_match, t_response,
                      trigger_flag.Enabled + trigger_flag.RegularExpression +
                          trigger_flag.Replace + trigger_flag.Temporary, -1, 0,
                      "", t_function)
end
-- 创建一个临时的一次性触发器 
function create_trigger(t_name, t_match, t_response, t_function)
    return AddTrigger(t_name, t_match, t_response,
                      trigger_flag.Enabled + trigger_flag.RegularExpression +
                          trigger_flag.Replace + trigger_flag.Temporary +
                          trigger_flag.OneShot, -1, 0, "", t_function)
end
-- 创建一个ex触发器 
function create_triggerex_t(t_name, t_match, t_response, t_function)
    return AddTriggerEx(t_name, t_match, t_response, trigger_flag.Enabled +
                            trigger_flag.RegularExpression +
                            trigger_flag.Replace, -1, 0, "", t_function, 12, 99)
end
function create_triggerex_t101(t_name, t_match, t_response, t_function)
    return AddTriggerEx(t_name, t_match, t_response, trigger_flag.Enabled +
                            trigger_flag.RegularExpression +
                            trigger_flag.Replace, -1, 0, "", t_function, 12, 101)
end
function create_triggerex_lvl(t_name, t_match, t_response, t_function, lvl)
    return AddTriggerEx(t_name, t_match, t_response, trigger_flag.Enabled +
                            trigger_flag.RegularExpression +
                            trigger_flag.Replace, -1, 0, "", t_function, 12, lvl)
end
-- 创建一个临时的触发器 
function create_triggerex_f(t_name, t_match, t_response, t_function)
    return AddTriggerEx(t_name, t_match, t_response,
                        trigger_flag.Enabled + trigger_flag.RegularExpression +
                            trigger_flag.Replace + trigger_flag.Temporary, -1,
                        0, "", t_function, 12, 100)
end
-- 创建一个临时的一次性触发器 
function create_triggerex(t_name, t_match, t_response, t_function)
    return AddTriggerEx(t_name, t_match, t_response,
                        trigger_flag.Enabled + trigger_flag.RegularExpression +
                            trigger_flag.Replace + trigger_flag.Temporary +
                            trigger_flag.OneShot, -1, 0, "", t_function, 12, 100)
end
-- 创建一个临时的一次性定时器
function create_timer(t_name, t_time, t_com, t_function)
    return AddTimer(t_name, 0, 0, t_time, t_com,
                    timer_flag.Enabled + timer_flag.OneShot +
                        timer_flag.TimerSpeedWalk + timer_flag.Replace +
                        timer_flag.Temporary, t_function)
end

function idle()
    hp.expBak = hp.expBak or -1
    if hp.exp and hp.exp ~= hp.expBak then
        hp.expBak = hp.exp
        cntrI = countR(20)
        -- else
        -- if cntrI()<1 then
        -- cntrI = countR(20)
        -- flag.idle = 100
        -- return idle_set()
        -- end
    end
    flag.idle = 0
    return create_timer_s('idle', 30, 'idle_set')
end
function idle_set()
    if job.name == 'ptbx' then return exe('praise ptbx') end
    if job.name == 'songmoya' then
        print('正在颂摩崖任务中，当前死亡次数【' .. smydie ..
                  '】次！设定杀死武士组数上限为【' .. smyteam ..
                  '】组。进行组数为第【' .. yptteam .. '】组。')
        exe('flatter')
        return
    end
    if job.name == 'husong' then
        exe('aq')
        print('正在护送任务中')
        return
    end
    if job.name == 'refine' then
        exe('admire2')
        print('正在提练矿石中')
        return
    end
    if job.name == 'hubiao' then
        exe('admire2')
        print('正在护镖中')
        return
    end
    print(flag.idle)
    exe('poem')
    if not flag.idle or type(flag.idle) ~= "number" then flag.idle = 0 end
    flag.idle = flag.idle + 1
    if flag.idle < 10 then
        DeleteTimer("walkWait10")
        DeleteTimer("walkWait9")
        if dest.area == nil then return end
        if dest.area == '铁掌山' or dest.area == '苗疆' then
            locate()
            if locl.room ~= job.room then
                return walk_wait()
            else
                if job.name == 'wudang' then
                    return wudangFindAct()
                end
                if job.name == 'huashan' then
                    return huashanFindAct()
                end
                if job.name == 'xueshan' then
                    return xueshan_find_act()
                end
                if job.name == 'songxin' or job.name == 'songxin2' then
                    return songxin_find_go()
                end
            end
        end
        return
    end
    if flag.idle < 11 then
        if job.name == 'wudang' then return wudangFindFail() end
        if job.name == 'huashan' then return huashanFindFail() end
        if job.name == 'xueshan' then return xueshanFindFail() end
        if job.name == 'songxin' or job.name == 'songxin2' then
            return songxinFindFail()
        end
    end
    if flag.idle < 12 then
        chats_log("ROBOT 可能已发呆" .. flag.idle / 2 .. "分钟!",
                  "deepskyblue")
        return
    end
    scrLog()
    dis_all()
    chats_locate('定位系统：发呆6分钟后，于【' .. locl.area ..
                     locl.room .. '】重新启动系统！', 'red')
    Disconnect()
    Connect()
end

function shujian_set()
    checkBags()
    exe('score;cha;hp')
    local l_result
    local l_tmp
    local t
    l_result = utils.inputbox(
                   "你要学习的SKILLS(格式：force|shenyuan-gong|dodge|yanling-shenfa|sword|blade|parry)是?",
                   "xuexiskill", GetVariable("xuexiskill"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("xuexiskill", l_result)
        Note("学习设定完成")
        print(GetVariable("xuexiskill"))
    end
    l_result = utils.inputbox(
                   "你要领悟的SKILLS(格式：force|dodge|sword|blade|parry)是?",
                   "lingwuskills", GetVariable("lingwuskills"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("lingwuskills", l_result)
        Note("领悟设定完成")
        print(GetVariable("lingwuskills"))
    end
    l_result = utils.inputbox("你学习领悟时使用的加悟性武器是?",
                              "learnweapon", GetVariable("learnweapon"),
                              "宋体", "12")
    if not isNil(l_result) then SetVariable("learnweapon", l_result) end
    l_result = utils.inputbox(
                   "你战斗后切换内力恢复武器的指令是（例如：unwield xxx sword;wield xxx blade）?",
                   "recoveryweapon", GetVariable("recoveryweapon"), "宋体",
                   "12")
    if not isNil(l_result) then SetVariable("recoveryweapon", l_result) end
    l_result = utils.inputbox("你的英文ID是?", "ID", GetVariable("id"),
                              "宋体", "12")
    if l_result ~= nil then
        SetVariable("id", l_result)
    else
        DeleteVariable("id")
    end
    l_result = utils.inputbox("你的密码是?", "Passwd",
                              GetVariable("passwd"), "宋体", "12")
    if l_result ~= nil then
        SetVariable("passwd", l_result)
    else
        DeleteVariable("passwd")
    end

    l_result = utils.msgbox("是否打开记录窗口?", "FlagLog", "yesno",
                            "?", 1)
    if l_result and l_result == "yes" then
        flag.log = "yes"
    else
        flag.log = "no"
    end
    SetVariable("flaglog", flag.log)

    l_result = utils.msgbox("是否自动学习及领悟", "XuexiLingwu",
                            "yesno", "?", 1)
    if l_result and l_result == "yes" then
        flag.autoxuexi = 1
    else
        flag.autoxuexi = 0
    end
    SetVariable("flagautoxuexi", flag.autoxuexi)

    -- masterSet()

    pfmSet()

    weaponSet()

    setShenQi()

    myUweapon()

    jobSet()

    drugSet()

    Save()

    ColourNote("red", "blue",
               "请使用start命令启动机器人，stop命令停止机器人，iset设置机器人！")
end

function masterSet()
    local l_result, l_tmp, t
    if score.party ~= "普通百姓" then
        l_result = utils.inputbox("你的师傅的简短ID是?", "MasterId",
                                  GetVariable("masterid"), "宋体", "12")
        if not isNil(l_result) then
            SetVariable("masterid", l_result)
            master.id = l_result
        end
        if not score.master or not masterRoom[score.master] then
            l_result = utils.inputbox("你的师傅的居住地是?",
                                      "MasterRoom", GetVariable("masterroom"),
                                      "宋体", "12")
            if l_result ~= nil then
                SetVariable("masterroom", l_result)
                master.room, master.area = getAddr(l_result)
            end
        end
    end
end

function pfmSet()
    local l_result, l_tmp, t

    t = {}
    for p in pairs(skills) do
        if skillEnable[p] == "force" then t[p] = skills[p].name end
    end
    if countTab(t) == 1 then
        for p in pairs(t) do perform.force = p end
    elseif countTab(t) > 1 then
        l_result = utils.listbox("你使用的特殊内功是", "特殊内功",
                                 t, GetVariable("performforce"))
        if isNil(l_result) then
            perform.force = nil
            DeleteVariable("performforce")
        else
            perform.force = l_result
            SetVariable("performforce", l_result)
        end
    else
        perform.force = nil
    end

    t = {}
    for p in pairs(skills) do
        if skillEnable[p] and skillEnable[p] ~= "force" then
            t[p] = skills[p].name
        end
    end
    if countTab(t) > 0 then
        l_result = utils.listbox("你准备战斗使用的功夫是?",
                                 "performSkill", t, GetVariable("performskill"))
        if not isNil(l_result) then
            SetVariable("performskill", l_result)
            perform.skill = l_result
        else
            perform.skill = nil
            SetVariable("performskill", l_result)
        end
    end
    l_result = utils.inputbox(
                   "战斗默认准备PFM(格式：bei none;bei claw;jifa parry jiuyin-baiguzhua;perform sanjue)是?",
                   "PerformPre", GetVariable("performpre"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("performpre", l_result)
        perform.pre = l_result
        l_pfm = perform.pre
        create_alias('pfmset', 'pfmset', 'alias pfmpfm ' .. l_pfm)
        Note("默认PFM")
        Execute('pfmset')
    end
    l_result = utils.inputbox("你的空手PFM(不使用武器的PFM)是?",
                              "pfmks", GetVariable("pfmks"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pfmks", l_result)
        l_pfm = l_result
        create_alias('pfmks', 'pfmks', 'alias pfmpfm ' .. l_pfm)
        Note("空手PFM")
        Execute('pfmks')
    end
    l_result = utils.inputbox(
                   "遇到慕容剑法用的PFM(使用不拿剑可以克制慕容的skills,慕容剑法的属性为：险)是?",
                   "pfmmrjf", GetVariable("pfmmrjf"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pfmmrjf", l_result)
        l_pfm = l_result
        create_alias('pfmmrjf', 'pfmmrjf', 'alias pfmpfm ' .. l_pfm)
        Note("不用剑的PFM")
        Execute('pfmmrjf')
    end
    l_result = utils.inputbox(
                   "遇到明教圣火令法PFM(使用拿武器克制明教的skills，圣火令法的属性为：奇)是?",
                   "pfmshlf", GetVariable("pfmshlf"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pfmshlf", l_result)
        l_pfm = l_result
        create_alias('pfmshlf', 'pfmshlf', 'alias pfmpfm ' .. l_pfm)
        Note("带兵器PFM")
        Execute('pfmshlf')
    end
    l_result = utils.inputbox(
                   "填写你的无属性PFM(使用无属性的skills，玄铁剑法改归属为空)是?",
                   "pfmwu", GetVariable("pfmwu"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pfmwu", l_result)
        l_pfm = l_result
        create_alias('pfmwu', 'pfmwu', 'alias pfmpfm ' .. l_pfm)
        Note("无属性PFM")
        Execute('pfmwu')
    end
    l_result = utils.inputbox("填写你的克制无属性PFM是?", "pwu",
                              GetVariable("pwu"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pwu", l_result)
        l_pfm = l_result
        create_alias('pwu', 'pwu', 'alias pfmpfm ' .. l_pfm)
        Note("克制无属性PFM")
        Execute('pwu')
    end
    l_result = utils.inputbox(
                   "填写你的空属性PFM(使用空属性的skills)是?",
                   "pkong", GetVariable("pkong"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pkong", l_result)
        l_pfm = l_result
        create_alias('pkong', 'pkong', 'alias pfmpfm ' .. l_pfm)
        Note("空属性PFM")
        Execute('pkong')
    end
    l_result = utils.inputbox(
                   "填写你的最大合气PFM(不管武功属性)是?",
                   "pfmsanqing", GetVariable("pfmsanqing"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pfmsanqing", l_result)
        l_pfm = l_result
        create_alias('pfmsanqing', 'pfmsanqing', 'alias pfmpfm ' .. l_pfm)
        Note("最大合气PFM")
        Execute('pfmsanqing')
    end
    l_result = utils.inputbox(
                   "填写你的正属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：险。属性克制数值为：正130 刚空120 快110 妙险无100】无正属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pzhen", GetVariable("pzhen"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pzhen", l_result)
        perform.zhen = l_result
        l_pfm = perform.zhen
        create_alias('pfmzhen', 'pfmzhen', 'alias pfmpfm ' .. l_pfm)
        Note("正属性PFM")
        Execute('pfmzhen')
    end
    l_result = utils.inputbox(
                   "填写你的奇属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：妙。属性克制数值为：奇130 柔空120 慢110 无妙险100】无奇属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pqi", GetVariable("pqi"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pqi", l_result)
        perform.qi = l_result
        l_pfm = perform.qi
        create_alias('pfmqi', 'pfmqi', 'alias pfmpfm ' .. l_pfm)
        Note("奇属性PFM")
        Execute('pfmqi')
    end
    l_result = utils.inputbox(
                   "填写你的刚属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：慢。属性克制数值为：刚130 正空120 险110 慢快无100】无刚属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pgang", GetVariable("pgang"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pgang", l_result)
        perform.gang = l_result
        l_pfm = perform.gang
        create_alias('pfmgang', 'pfmgang', 'alias pfmpfm ' .. l_pfm)
        Note("刚属性PFM")
        Execute('pfmgang')
    end
    l_result = utils.inputbox(
                   "填写你的柔属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：快。属性克制数值为：柔130 奇空120 妙110 快慢无100】无柔属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "prou", GetVariable("prou"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("prou", l_result)
        perform.rou = l_result
        l_pfm = perform.rou
        create_alias('pfmrou', 'pfmrou', 'alias pfmpfm ' .. l_pfm)
        Note("柔属性PFM")
        Execute('pfmrou')
    end
    l_result = utils.inputbox(
                   "填写你的快属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：刚。属性克制数值为：快130 妙空120 奇110 无刚柔100】无快属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pkuai", GetVariable("pkuai"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pkuai", l_result)
        perform.kuai = l_result
        l_pfm = perform.kuai
        create_alias('pfmkuai', 'pfmkuai', 'alias pfmpfm ' .. l_pfm)
        Note("快属性PFM")
        Execute('pfmkuai')
    end
    l_result = utils.inputbox(
                   "填写你的慢属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：柔。属性克制数值为：慢130 险空120 正110 无刚柔100】无慢属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pman", GetVariable("pman"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pman", l_result)
        perform.man = l_result
        l_pfm = perform.man
        create_alias('pfmman', 'pfmman', 'alias pfmpfm ' .. l_pfm)
        Note("慢属性PFM")
        Execute('pfmman')
    end
    l_result = utils.inputbox(
                   "填写你的秒属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：正。属性克制数值为：妙130 快空120 刚110 无正奇100】无妙属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pmiao", GetVariable("pmiao"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pmiao", l_result)
        perform.miao = l_result
        l_pfm = perform.miao
        create_alias('pfmmiao', 'pfmmiao', 'alias pfmpfm ' .. l_pfm)
        Note("妙属性PFM")
        Execute('pfmmiao')
    end
    l_result = utils.inputbox(
                   "填写你的险属性PFM(用verify 来查看你的pfm的属性再填写。格式：verify yunu-jianfa)是?         【被克制属性为：奇。属性克制数值为：险130 慢空120 柔110 无正奇100】无险属性可按后面的数值高低来填入对你有对应属性的FPM！",
                   "pxian", GetVariable("pxian"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("pxian", l_result)
        perform.xian = l_result
        l_pfm = perform.xian
        create_alias('pfmxian', 'pfmxian', 'alias pfmpfm ' .. l_pfm)
        Note("险属性PFM")
        Execute('pfmxian')
    end
    l_result = utils.inputbox(
                   "你FPK的PFM(用verify 来查看你的pfm的属性再填写格式：verify yunu-jianfa)是?",
                   "pkpfm", GetVariable("pkpfm"), "宋体", "12")
    if not isNil(l_result) then SetVariable("pkpfm", l_result) end
    l_result = utils.inputbox("你练功的次数是？", "mycishu",
                              GetVariable("mycishu"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("mycishu", l_result)
        lianxi_times = l_result
    end
    Note("使用默认PFM")
    Execute('pfmset')
end

function myUweapon()
    l_result = utils.inputbox("你需要GET的第一把武器ID是?",
                              "myweapon", GetVariable("myweapon"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("myweapon", l_result) end
    l_result = utils.inputbox("你需要GET的第二把武器ID是?",
                              "muweapon", GetVariable("muweapon"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("muweapon", l_result) end
end

function jobSet()
    local l_result, l_tmp, t

    t = {
        ["wudang"] = "武当宋远桥",
        ["huashan"] = "华山岳不群",
        ["gaibang"] = "丐帮吴长老",
        ["songmoya"] = "颂摩崖抗敌任务",
        ["zhuoshe"] = "丐帮捉蛇",
        ["songxin"] = "大理送信",
        ["songxin2"] = "大理送信2",
        ["xueshan"] = "雪山抢美女",
        ["sldsm"] = "神龙岛师门",
        ["songshan"] = "嵩山左冷禅",
        --   ["hubiao"]  ="福州护镖",
        ["tmonk"] = "少林教和尚",
        ["clb"] = "长乐帮任务1",
        ["husong"] = "少林护送",
        ["hqgzc"] = "洪七公做菜"
    }

    t = {}

    for p, q in pairs(job.list) do t[p] = q end

    if score.party ~= "丐帮" then t["zhuoshe"] = nil end
    if score.party ~= "神龙教" then t["sldsm"] = nil end
    if score.party ~= "少林派" or hp.exp > 2000000 or hp.exp < 300000 then
        t["tmonk"] = nil
    end
    if score.party ~= "少林派" or hp.exp < 2000000 then t["husong"] = nil end
    if hp.exp < 5000000 then t["songmoya"] = nil end
    if hp.shen < 0 then t["gaibang"] = nil end
    if hp.shen < 0 and score.party == "华山派" then t["huashan"] = nil end
    if hp.shen < 0 then t["wudang"] = nil end
    if hp.shen > 0 then t["songshan"] = nil end

    job.zuhe = {}
    if GetVariable("jobzuhe") then
        tmp.job = utils.split(GetVariable("jobzuhe"), '_')
        tmp.zuhe = {}
        for _, p in pairs(tmp.job) do tmp.zuhe[p] = true end
    end
    l_tmp = utils.multilistbox("你的任务组合(请按CTRL多选)是?",
                               "任务组合", t, tmp.zuhe)
    l_result = nil
    for p in pairs(l_tmp) do
        job.zuhe[p] = true
        if l_result then
            l_result = l_result .. '_' .. p
        else
            l_result = p
        end
    end
    if l_result ~= nil then SetVariable("jobzuhe", l_result) end
    for p in pairs(t) do if not job.zuhe[p] then t[p] = nil end end
    job.first = nil
    job.second = nil
    t["husong"] = nil
    t["hubiao"] = nil
    if countTab(t) > 2 then
        l_result = utils.listbox("你第一优先去的任务：",
                                 "优先任务", t, GetVariable("jobfirst"))
        if l_result ~= nil then
            SetVariable("jobfirst", l_result)
            job.first = l_result
            t[job.first] = nil
        else
            job.first = nil
            DeleteVariable("jobfirst")
        end
    end
    if countTab(t) > 1 and job.first then
        l_result = utils.listbox("你第二优先去的任务：",
                                 "优先任务", t, GetVariable("jobsecond"))
        if l_result ~= nil then
            SetVariable("jobsecond", l_result)
            job.second = l_result
            t[job.second] = nil
        else
            job.second = nil
            DeleteVariable("jobsecond")
        end
    else
        job.second = nil
        DeleteVariable("jobsecond")
    end
    if countTab(t) == 1 and job.second then
        l_result = utils.listbox("你第三个去的任务：", "优先任务",
                                 t, GetVariable("jobthird"))
        if l_result ~= nil then
            SetVariable("jobthird", l_result)
            job.third = l_result
        else
            job.third = nil
            DeleteVariable("jobthird")
        end
    else
        job.third = nil
        DeleteVariable("jobthird")
    end
    if not job.first then DeleteVariable("jobfirst") end
    if not job.second then DeleteVariable("jobsecond") end
    if not job.third then DeleteVariable("jobthird") end

    if job.zuhe["songmoya"] then
        l_result = utils.inputbox(
                       "设置一品堂任务杀到第几组?(默认为7组)使用默认组数请空白不要填写。",
                       "ypttab", GetVariable("ypttab"), "宋体", "12")
        if not isNil(l_result) then
            SetVariable("ypttab", l_result)
            smyteam = tonumber(l_result)
        else
            smyteam = 16
        end
        l_result = utils.inputbox(
                       "设置一品堂任务死亡几次不再上SMY!(默认为2次)使用默认组数请空白不要填写。",
                       "yptdie", GetVariable("yptdie"), "宋体", "12")
        if not isNil(l_result) then
            SetVariable("yptdie", l_result)
            smyall = tonumber(l_result)
        else
            smyall = 2
        end
        l_result = utils.msgbox(
                       "设置一品堂任务是否开启双杀!(默认为no不开启)。",
                       "双杀", "yesno", "?", 1)
        if l_result and l_result == "yes" then
            double_kill = yes
        else
            double_kill = no
        end
        l_result = utils.inputbox(
                       "设置一品堂任务前置BUFF!(Perform and Yun、没有请填写none)。",
                       "pfbuff", GetVariable("pfbuff"), "宋体", "12")
        if not isNil(l_result) then
            SetVariable("pfbuff", l_result)
            perform.buff = l_result
            l_pfm = perform.buff
            create_alias('pbuff', 'pbuff', 'alias pfmbuff ' .. l_pfm)
            exe('pbuff')
        end
    end

    if job.zuhe["tdh"] then
        l_result = utils.inputbox(
                       "天地会任务中间是否打座？(1为打座 0为不打座)",
                       "tdhdazuo", GetVariable("tdhdazuo"), "宋体", "12")
        if not isNil(l_result) then
            SetVariable("tdhdazuo", l_result)
            tdhdz = l_result
        else
            tdhdz = 1
        end
    end

    if job.zuhe["hqgzc"] then
        l_result = utils.inputbox("拿Pot还是Gold？(1为Pot 0为Gold)",
                                  "hqgzcjiangli", GetVariable("hqgzcjiangli"),
                                  "宋体", "12")
        if not isNil(l_result) then
            SetVariable("hqgzcjiangli", l_result)
            hqgzcjl = 0
        else
            hqgzcjl = 1
        end
    end

    if job.zuhe["hubiao"] or job.zuhe["haizhan"] then
        if GetVariable("teamname") then
            l_result = utils.inputbox(
                           "你组队护镖的队友(中文名称)是?",
                           "TeamName", GetVariable("teamname"), "宋体", "12")
        else
            l_result = utils.inputbox(
                           "你组队护镖的队友(中文名称)是?",
                           "TeamName", job.teamname, "宋体", "12")
        end
        if not isNil(l_result) then
            SetVariable("teamname", l_result)
            job.teamname = l_result
        else
            DeleteVariable("teamname")
            job.teamname = nil
        end
        if GetVariable("teamlead") then
            l_result = utils.inputbox(
                           "你组队护镖的队长(中文名称)是?",
                           "TeamLead", GetVariable("teamlead"), "宋体", "12")
        else
            l_result = utils.inputbox(
                           "你组队护镖的队长(中文名称)是?",
                           "TeamLead", job.teamlead, "宋体", "12")
        end
        if not isNil(l_result) then
            SetVariable("teamlead", l_result)
            job.teamlead = l_result
        else
            DeleteVariable("teamlead")
            job.teamlead = nil
        end
    end

end

function drugSet()
    drugPrepare = {}
    local t = {
        ["内息丸"] = "内息丸",
        ["川贝内息丸"] = "川贝内息丸",
        ["黄芪内息丹"] = "黄芪内息丹",
        ["蝉蜕金疮药"] = "蝉蜕金疮药",
        ["活血疗精丹"] = "活血疗精丹",
        ["大还丹"] = "大还丹",
        ["火折"] = "火折",
        ["牛皮酒袋"] = "牛皮酒袋"
    }
    if GetVariable("drugprepare") then
        tmp.drug = utils.split(GetVariable("drugprepare"), '|')
        tmp.pre = {}
        for _, p in pairs(tmp.drug) do tmp.pre[p] = true end
    end
    local l_tmp = utils.multilistbox(
                      "你任务前准备的物品(请按CTRL多选)是?",
                      "物品组合", t, tmp.pre)
    local l_result = nil
    for p in pairs(l_tmp) do
        drugPrepare[p] = true
        if l_result then
            l_result = l_result .. '|' .. p
        else
            l_result = p
        end
    end
    if isNil(l_result) then
        DeleteVariable("drugprepare")
    else
        SetVariable("drugprepare", l_result)
    end
end

function getVariable()
    if GetVariable("flagautoxuexi") then
        flag.autoxuexi = GetVariable("flagautoxuexi")
        if flag.autoxuexi == '1' or flag.autoxuexi == '0' then
            flag.autoxuexi = tonumber(flag.autoxuexi)
        end
    end
    if GetVariable("flaglog") then flag.log = GetVariable("flaglog") end

    if GetVariable("masterid") then master.id = GetVariable("masterid") end
    if GetVariable("masterroom") then
        master.room, master.area = getAddr(GetVariable("masterroom"))
    end
    if GetVariable("mastertimes") then
        master.times = GetVariable("mastertimes")
    end

    if GetVariable("performforce") then
        perform.force = GetVariable("performforce")
    end
    if GetVariable("performskill") then
        perform.skill = GetVariable("performskill")
    end
    if GetVariable("performpre") then perform.pre = GetVariable("performpre") end
    if GetVariable("performhuaxue") then
        perform.huaxue = GetVariable("performhuaxue")
    end
    if GetVariable("performxiqi") then
        perform.xiqi = GetVariable("performxiqi")
    end

    if GetVariable("jobzuhe") then
        tmp.job = utils.split(GetVariable("jobzuhe"), '_')
        for _, p in pairs(tmp.job) do job.zuhe[p] = true end
    end
    if GetVariable("jobfirst") then
        job.first = GetVariable("jobfirst")
        if job.first == "songxin2" then job.first = "songxin" end
    else
        job.first = nil
    end
    if GetVariable("jobsecond") then
        job.second = GetVariable("jobsecond")
        if job.second == "songxin2" then job.second = "songxin" end
    else
        job.second = nil
    end
    if GetVariable("jobthird") then
        job.third = GetVariable("jobthird")
        if job.third == "songxin2" then job.third = "songxin" end
    else
        job.third = nil
    end
    if GetVariable("flagtype") then flag.type = GetVariable("flagtype") end
    if GetVariable("gaibangcancel") then
        gaibangCancel = GetVariable("gaibangcancel")
    end
    if GetVariable("sldsmcancel") then
        sldsmCancel = GetVariable("sldsmcancel")
    end
    if GetVariable("teamname") then job.teamname = GetVariable("teamname") end
    if GetVariable("teamlead") then job.teamlead = GetVariable("teamlead") end

    drugGetVar()

    weaponGetVar()
end

function drugGetVar()
    drugPrepare = {}
    if GetVariable("drugprepare") then
        tmp.drug = utils.split(GetVariable("drugprepare"), '|')
        for _, p in pairs(tmp.drug) do drugPrepare[p] = true end
    end
end

function g_stop()
    if job.name == nil or job.name == 'idle' then
        print("游戏停止")
        disAll()
    else
        g_stop_flag = true
        print("当前正在任务中：" .. job.name ..
                  ". 将会在任务结束后停止")
    end
end
function setAlias()
    create_alias_s('dazao', 'dazao', 'dazaoWeapon')
    create_alias_s('xxk', 'xxk', 'xxkFind')
    create_alias_s('kkr', 'kkr', 'kongkongFind')
    create_alias_s('dhsome', 'dhsome', 'duihuanSomething')
    create_alias_s('kjh', 'kjh', 'jinheTrigger')
    create_alias_s('setstone', 'sst', 'stoneSet')
    create_alias_s('dst', 'dst', 'stoneGetVar')
    create_alias_s('gothd', 'gothd', 'thz_bfstart')
    create_alias_s('hbgo', 'hbgo', 'hubiao_start')
    create_alias_s('csgo', 'csgo', 'zhuacaishen_find')
    create_alias_s('gfgo', 'gfgo', 'guanfu_start')
    create_alias_s('stop', 'stop', 'disAll')
    create_alias_s('gstop', 'gstop', 'g_stop')
    create_alias_s('iset', 'iset', 'shujian_set')
    create_alias_s('start', 'start', 'main')
    create_alias_s('pkset', 'pkset', 'setpk')
    create_alias_s('pkstart', 'pks', 'pk_start')
    create_alias_s('smyset', 'smyset', 'setsmy')
    create_alias_s('qu_wd', 'qu_wd', 'goto_set.wd')
    create_alias_s('qu_sl', 'qu_sl', 'goto_set.sl')
    create_alias_s('qu_xy', 'qu_xy', 'goto_set.xy')
    create_alias_s('qu_xs', 'qu_xs', 'goto_set.xs')
    create_alias_s('qu_hs', 'qu_hs', 'goto_set.hs')
    create_alias_s('qu_yz', 'qu_yz', 'goto_set.yz')
    create_alias_s('qu_lzdk', 'qu_lzdk', 'goto_set.lzdk')
    create_alias_s('qu_thd', 'qu_thd', 'goto_set.thd')
    create_alias_s('qu_dl', 'qu_dl', 'goto_set.dl')
    create_alias_s('tj', 'tj', 'jobExpTongji')
    create_alias_s('setlian', 'setlian', 'setLian')
    create_alias_s('setautoxue', 'setautoxue', 'set_autoxue')
    create_alias_s('setlearn', 'setlearn', 'setLearn')
    create_alias_s('setlingwu', 'setlingwu', 'setLingwu')
    create_alias_s('setdzxy', 'setdzxy', 'setdzxy')
    create_alias_s('duanzao', 'duanzao', 'duanzao')
    create_alias_s('zhizao', 'zhizao', 'zhizao')
    create_alias_s('xuexi', 'xuexi', 'xuepot')
    create_alias_s('xc', 'xc', 'setxcexp')
    create_alias_s('wdj', 'wdj', 'inWdj')
    create_alias_s('dolost', 'dolost', 'dolostletter')
    create_alias_s('setjob', 'setjob', 'jobSet')
    create_alias('sz', '^sz(.*)$', 'go_to("%1")')
    SetAliasOption('sz', 'send_to', '12')
    create_alias('dushu', '^dushu(.*)$', 'dushu("%1")')
    SetAliasOption('dushu', 'send_to', '12')
    create_alias('full', '^full(.*)$', 'fullSkill("%1")')
    SetAliasOption('full', 'send_to', '12')
end

function setdzxy()
    l_result = utils.msgbox(
                   "慕容斗转星移学习设置(默认为：Yes)？", "dzxy",
                   "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('我要学习斗转星移')
        need_dzxy = 'yes'
    else
        need_dzxy = 'no'
        print('我不要学习斗转星移')
    end
end
function inWdj()
    l_result = utils.msgbox("是要进苗疆五毒教吗？", "inwdj", "yesno",
                            "?", 1)
    if l_result and l_result == "yes" then
        print('我要进苗疆五毒教')
        inwdj = 1
    else
        inwdj = 0
        print('我不进苗疆五毒教')
    end
end
function setLearn()
    l_result = utils.inputbox(
                   "你要学习的SKILLS(格式：force|shenyuan-gong|dodge|yanling-shenfa|sword|blade|parry)是?",
                   "xuexiskill", GetVariable("xuexiskill"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("xuexiskill", l_result)
        Note("学习设定完成")
        print(GetVariable("xuexiskill"))
    end
    l_result = utils.inputbox("你学习时使用的加悟性武器是?",
                              "learnweapon", GetVariable("learnweapon"),
                              "宋体", "12")
    if not isNil(l_result) then
        SetVariable("learnweapon", l_result)
        print(GetVariable("learnweapon"))
    end
end
function setLingwu()
    l_result = utils.inputbox(
                   "你要领悟的SKILLS(格式：force|dodge|sword|blade|parry)是?",
                   "lingwuskills", GetVariable("lingwuskills"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("lingwuskills", l_result)
        Note("领悟设定完成")
        print(GetVariable("lingwuskills"))
    end
    l_result = utils.inputbox("你领悟时使用的加悟性武器是?",
                              "learnweapon", GetVariable("learnweapon"),
                              "宋体", "12")
    if not isNil(l_result) then
        SetVariable("learnweapon", l_result)
        print(GetVariable("learnweapon"))
    end
end
function setLian()
    l_result = utils.inputbox("你练功的次数是？", "mycishu",
                              GetVariable("mycishu"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("mycishu", l_result)
        lianxi_times = l_result
    end
end

function setShenQi()
    l_result = utils.inputbox("你的神器id是？", "myshenqi_id",
                              GetVariable("myshenqi_id"), "宋体", "12")
    if not isNil(l_result) then SetVariable("myshenqi_id", l_result) end
end
function set_autoxue()
    l_result = utils.msgbox("是否自动学习及领悟", "XuexiLingwu",
                            "yesno", "?", 1)
    if l_result and l_result == "yes" then
        flag.autoxuexi = 1
    else
        flag.autoxuexi = 0
    end
    SetVariable("flagautoxuexi", flag.autoxuexi)
end
function pk_start()
    l_result = utils.inputbox("你要PK的目标是（英文ID）？",
                              "PK-Target", GetVariable("pk_target"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("pk_target", l_result) end
    if l_result then create_timer_s('walkWait4', 0.4, 'pk_start1') end
    pk_prepare()
end
function pk_start1()
    exe('follow ' .. GetVariable("pk_target"))
    exe('kill ' .. GetVariable("pk_target"))
end
function setpk()
    l_result = utils.inputbox("你打算憋多少合气？(不填默认240)",
                              "heqi_number", GetVariable("heqi_number"),
                              "宋体", "12")
    if not isNil(l_result) then
        SetVariable("heqi_number", l_result)
    else
        SetVariable("heqi_number", "240")
    end
    l_result = utils.inputbox(
                   "填写你的克制无属性PK-PFM(克制无)是?",
                   "zpk_pwu", GetVariable("zpk_pwu"), "宋体", "12")
    if not isNil(l_result) then SetVariable("zpk_pwu", l_result) end
    l_result = utils.inputbox(
                   "填写你的克制空属性PK-PFM(克制空)是?",
                   "zpk_pkong", GetVariable("zpk_pkong"), "宋体", "12")
    if not isNil(l_result) then SetVariable("zpk_pkong", l_result) end
    l_result = utils.inputbox("填写你的正属性PK-PFM是? (克制险)",
                              "zpk_pzhen", GetVariable("zpk_pzhen"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pzhen", l_result) end
    l_result = utils.inputbox("填写你的奇属性PK-PFM(克制妙)",
                              "zpk_pqi", GetVariable("zpk_pqi"), "宋体", "12")
    if not isNil(l_result) then SetVariable("zpk_pqi", l_result) end
    l_result = utils.inputbox("填写你的刚属性PK-PFM(克制慢)",
                              "zpk_pgang", GetVariable("zpk_pgang"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pgang", l_result) end
    l_result = utils.inputbox("填写你的柔属性PK-PFM(克制快)",
                              "zpk_prou", GetVariable("zpk_prou"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_prou", l_result) end
    l_result = utils.inputbox("填写你的快属性PK-PFM(克制刚)",
                              "zpk_pkuai", GetVariable("zpk_pkuai"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pkuai", l_result) end
    l_result = utils.inputbox("填写你的慢属性PK-PFM(克制柔)",
                              "zpk_pman", GetVariable("zpk_pman"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pman", l_result) end
    l_result = utils.inputbox("填写你的秒属性PK-PFM(克制正)",
                              "zpk_pmiao", GetVariable("zpk_pmiao"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pmiao", l_result) end
    l_result = utils.inputbox("填写你的险属性PK-PFM(克制奇)",
                              "zpk_pxian", GetVariable("zpk_pxian"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pxian", l_result) end
    l_result = utils.inputbox(
                   "填写你的默认PK-PFM(起手pfm或无法识别对方武功的应对，类似pfmpfm设定)是?",
                   "pkpfm", GetVariable("pkpfm"), "宋体", "12")
    if not isNil(l_result) then SetVariable("pkpfm", l_result) end
    l_result = utils.inputbox(
                   "填写你的PK-PFM(只包含pfm，不包含wield武器或jifa)",
                   "mypfm", GetVariable("mypfm"), "宋体", "12")
    if not isNil(l_result) then SetVariable("mypfm", l_result) end
    l_result = utils.inputbox(
                   "填写你的PK-PFM需要多少合气释放（只填数字）？",
                   "pk_pfm_heqi", GetVariable("pk_pfm_heqi"), "宋体", "12")
    if not isNil(l_result) then SetVariable("pk_pfm_heqi", l_result) end
    l_result = utils.inputbox("填写你的buff-PFM(pk时使用的buff技能)",
                              "mybuff", GetVariable("mybuff"), "宋体", "12")
    if not isNil(l_result) then SetVariable("mybuff", l_result) end
    l_result = utils.inputbox(
                   "填写你的buff-PFM需要多少合气释放（只填数字）？",
                   "pk_buff_heqi", GetVariable("pk_buff_heqi"), "宋体", "12")
    if not isNil(l_result) then SetVariable("pk_buff_heqi", l_result) end
    l_result = utils.inputbox(
                   "填写你的debuff-PFM(pk时使用的debuff技能)",
                   "mydebuff", GetVariable("mydebuff"), "宋体", "12")
    if not isNil(l_result) then SetVariable("mydebuff", l_result) end
    l_result = utils.inputbox(
                   "填写你的debuff-PFM需要多少合气释放（只填数字）？",
                   "pk_debuff_heqi", GetVariable("pk_debuff_heqi"), "宋体",
                   "12")
    if not isNil(l_result) then SetVariable("pk_debuff_heqi", l_result) end
end
function setsmy()
    l_result = utils.inputbox(
                   "填写你的克制无属性PK-PFM(克制无)是?",
                   "smy_pwu", GetVariable("smy_pwu"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smy_pwu", l_result) end
    l_result = utils.inputbox(
                   "填写你的克制空属性PK-PFM(克制空)是?",
                   "smy_pkong", GetVariable("smy_pkong"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smy_pkong", l_result) end
    l_result = utils.inputbox("填写你的正属性PK-PFM是? (克制险)",
                              "smy_pzhen", GetVariable("smy_pzhen"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pzhen", l_result) end
    l_result = utils.inputbox("填写你的奇属性PK-PFM(克制妙)",
                              "smy_pqi", GetVariable("smy_pqi"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smy_pqi", l_result) end
    l_result = utils.inputbox("填写你的刚属性PK-PFM(克制慢)",
                              "smy_pgang", GetVariable("smy_pgang"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pgang", l_result) end
    l_result = utils.inputbox("填写你的柔属性PK-PFM(克制快)",
                              "smy_prou", GetVariable("smy_prou"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_prou", l_result) end
    l_result = utils.inputbox("填写你的快属性PK-PFM(克制刚)",
                              "smy_pkuai", GetVariable("smy_pkuai"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pkuai", l_result) end
    l_result = utils.inputbox("填写你的慢属性PK-PFM(克制柔)",
                              "smy_pman", GetVariable("smy_pman"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pman", l_result) end
    l_result = utils.inputbox("填写你的秒属性PK-PFM(克制正)",
                              "smy_pmiao", GetVariable("smy_pmiao"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pmiao", l_result) end
    l_result = utils.inputbox("填写你的险属性PK-PFM(克制奇)",
                              "smy_pxian", GetVariable("smy_pxian"), "宋体",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pxian", l_result) end
    l_result = utils.inputbox(
                   "填写你的低合气PFM(例如：桃花岛的perform leg.fengwu)是?",
                   "smy_pfm1", GetVariable("smy_pfm1"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smy_pfm1", l_result) end
    l_result = utils.inputbox(
                   "填写你的辅助PFM(例如：桃花岛的perform sword.qimen)是？",
                   "smy_pfm2", GetVariable("smy_pfm2"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smy_pfm2", l_result) end
    l_result = utils.inputbox(
                   "填写你的大招PFM(只包含pfm，不包含wield武器或jifa，例如：桃花岛的perform leg.kuangfeng)是？",
                   "smy_pfm3", GetVariable("smy_pfm3"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smy_pfm3", l_result) end
    l_result = utils.inputbox(
                   "填写你的buff-PFM(上山时使用的buff技能，例如：桃花岛的perform dodge.wuzhuan;perform finger.xinghe)是？",
                   "mybuff", GetVariable("smybuff"), "宋体", "12")
    if not isNil(l_result) then SetVariable("smybuff", l_result) end
end
function setxcexp()
    l_result = utils.msgbox("巡城到2M", "xcexp", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('巡城到2M')
        xcexp = 1
    else
        print('巡城到1M')
        xcexp = 0
    end
end
function xuepot()
    l_result = utils.msgbox("是否学习", "xuexi", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('学习开启')
        needxuexi = 1
    else
        needxuexi = 0
        print('学习关闭')
    end
end

drugBuy = {
    ["川贝内息丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["邪气丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["正气丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["养精丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["补气丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["续精丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["内息丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["补食丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["补水丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["金疮药"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["疗精丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["正气丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["邪气丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["延年养精丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["茯苓补气丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["当归续精丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["黄芪内息丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["蝉蜕金疮药"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["活血疗精丹"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["解毒丸"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["大还丹"] = "city/dangpu",
    ["火折"] = {"xueshan/laifu", "suzhou/baodaiqiao"},
    ["牛皮酒袋"] = {"city/xiaochidian"}
}

drugPoison = {["九花玉露丸"] = true}

-- ain

local cun_hammer = tonumber(GetVariable("autocun_hammer"))
if cun_hammer == 1 then
    itemSave = {
        ["倚天匠技残篇"] = true,
        ["屠龙匠技残篇"] = true,
        ["韦兰之锤"] = true,
        ["金铁锤"] = true,
        ["神铁锤"] = true
    }
else
    itemSave = {
        ["倚天匠技残篇"] = true,
        ["屠龙匠技残篇"] = true,
        ["韦兰之锤"] = true,
        ["金铁锤"] = true,
        ["神铁锤"] = true
    }
end
