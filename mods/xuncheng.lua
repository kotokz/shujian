xuncheng = {
    [1] = "wu;eu;wu;nu;n;s;sd;ed;sd;sw;su;nd;w;nw;sw;u;d;ne;se;sw;su;yun jingli",
    [2] = "nd;ne;sw;su;nd;ne;e;ne;ed;e;yun jingli",
    [3] = "n;w;e;n;w;e;n;w;e;n;w;buy huasheng;buy doufu;eat huasheng;#2(drink);eat doufu;yun jingli",
    [4] = "e;n;s;e;s;e;n;n;s;s;s;s;n;e;n;n;n;cun 2 gold;cun 50 silver;s;s;e;e;yun jingli",
    [5] = "s;s;e;e;w;w;n;n;s;e;n;s;e;w;s;e;w;s;e;w;n;w;s;buy ban doufu;buy doufu gan;#2(eat doufu ganyun);#2(eat doufu gan);yun jingli",
    [6] = "n;e;e;w;s;e;w;s;e;w;s;e;e;se;n;s;s;e;w;s;e;w;su;enter;yun jingli",
    [7] = "d;d;d;e;e;up;e;w;d;w;w;up;up;up;out;nd;n;n;nw;yun jingli",
    [8] = "ne;#6(eu);se;se;enter;n;n;n;yun jingli",
    [9] = "s;s;s;out;#4(nw);wd;wd;sw;w;w;yun jingli",
    [10] = "s;e;w;s;e;w;s;e;w;s;e;w;s;n;w;s;n;w;n;e;w;w;yun jingli",
    [11] = "e;n;s;s;s;s;su;e;w;se;w;w;e;e;s;su;yun jingli",
    [12] = "sw;ne;nd;n;su;n;s;s;n;nd;nw;nd;n;n;w;yun jingli",
    [13] = "s;n;w;s;n;w;e;n;w;e;n;w;e;n;w;e;n;w;yun jingli"
}

local xctuna = 0

function xunCheng()
    if hp.exp and hp.exp > 2000000 then
        return fullNeili()
    else
        go(xuncheng_start, "大理城", "西门")
    end
end
function xuncheng_nobody()
    EnableTimer("walkWait4", false)
    DeleteTemporaryTriggers()
end

function xuncheng_start()
    opendummy = kill
    flag.idle = 0
    flag.xuncheng_start = true
    DeleteTemporaryTriggers()
    if hp.exp and hp.exp > 2000000 then
        return fullNeili()
    else
        create_trigger_f("xuncheng_start1",
                         "^>*\\s*你向朱丹臣打听有关『巡城』的消息。",
                         "", "xuncheng_accept")
        create_trigger_f("xuncheng_start2", "^>*\\s*这里没有这个人。",
                         "", "xuncheng_nobody")
        exe("unset 积蓄;ask zhu danchen about 巡城")
        create_timer_s("walkWait4", 1.0, "xuncheng_askagain")
    end
end
function xuncheng_askagain() exe("ask zhu danchen about 巡城") end
function xuncheng_start_wait()
    DeleteTemporaryTriggers()
    wait.make(function()
        wait.time(5)
        xuncheng_start()
    end)
end
function xuncheng_accept()
    EnableTimer("walkWait4", false)
    DeleteTemporaryTriggers()
    create_triggerex_f("xuncheng_accept1",
                       "^>*\\s*朱丹臣说道：「\\D*，你不是本王府随从，此话从何说起？」",
                       "xuncheng_join()", "")
    create_triggerex_f("xuncheng_accept2",
                       "^>*\\s*朱丹臣说道：「好吧，你就在大理城周围四处查看一下",
                       "xuncheng_go()", "")
    create_triggerex_f("xuncheng_accept3",
                       "^>*\\s*朱丹臣说道：「你不是已经领了巡城的任务吗",
                       "xuncheng_go()", "")
    create_triggerex_f("xuncheng_accept4",
                       "^>*\\s*朱丹臣说道：「\\D*你刚做完任务",
                       "xuncheng_start_wait()", "")
end
function xuncheng_join()
    DeleteTemporaryTriggers()
    wait.make(function()
        wait.time(1)
        exe("e;#4s;#4e;#3n;e")
        exe("s;ask fu sigui about join")
        wait_busy()
        xuncheng_join_back()
    end)
end
function xuncheng_join_back()
    exe("n")
    exe("w;#3s;#4w;#4n;w")
    xuncheng_start()
end

function xuncheng_go()
    DeleteTemporaryTriggers()
    if hp.neili_lim <= hp.neili_max then exe("yun jingli") end
    -- if hp.jingxue >= hp.jingxue_max * 0.5 then
    --     -- Execute('#8(du book)')
    -- end
    exe("hp")
    job.name = "巡城"
    SetSpeedWalkDelay(math.floor(1000 / 30))
    wait.make(function()
        for key, step in ipairs(xuncheng) do
            wait_busy()
            exe(step, true)
            wait.time(1.5)
            exe("yun jing", true)
        end
        SetSpeedWalkDelay(0)
        xuncheng_task()
    end)
end

function xuncheng_task()
    DeleteTemporaryTriggers()
    create_triggerex_f("xuncheng_task1",
                       "^>*\\s*朱丹臣轻轻地拍了拍你的头。",
                       "xuncheng_check()", "")
    create_triggerex_f("xuncheng_task2",
                       "^>*\\s*你没巡城跑来领什么功？",
                       "xuncheng_start()", "")
    create_triggerex_f("xuncheng_task3",
                       "^>*\\s*朱丹臣很生气地看着你。",
                       "xuncheng_task_wait()", "")
    create_triggerex_f("xuncheng_task4", "^>*\\s*你是不是偷懒，城东",
                       "xunchengdong()", "")
    create_triggerex_f("xuncheng_task5", "^>*\\s*你是不是偷懒，城西",
                       "xunchengxi()", "")
    create_triggerex_f("xuncheng_task6", "^>*\\s*你是不是偷懒，城北",
                       "xunchengbei()", "")
    create_triggerex_f("xuncheng_task7", "^>*\\s*你是不是偷懒，城中",
                       "xuncheng_start()", "")
    create_triggerex_f("xuncheng_task8",
                       "^>*\\s*你的内力修为已经无法靠打坐来提升了。",
                       "xuncheng_tuna()", "")
    create_triggerex_f("xuncheng_task9",
                       "^>*\\s*你的精力修为已经达到了你内功所能控制的极限。",
                       "xuncheng_dazuo()", "")
    wait.make(function()
        wait.time(1)
        exe("task ok")
    end)
end
function xuncheng_tuna()
    print("tuna")
    xctuna = 1
end
function xuncheng_dazuo()
    print("dazuo")
    xctuna = 0
end
function xunchengdong()
    wait.make(function()
        wait.time(2)
        exe(
            "halt;yun jinglil;e;#4 s;#4 e;#4 n;e;e;ne;eu;eu;se;se;enter;#3 n;#3 s;out")
    end)
    wait.make(function()
        wait.time(4)
        exe("nw;nw;wd;wd;sw;w;w;#4 s;#4 w;#4 n;w;task ok")
    end)
end
function xunchengbei()
    wait.make(function()
        wait.time(2)
        exe(
            "halt;yun jinglil;e;#4 s;e;e;s;s;su;e;w;se;w;w;e;e;s;su;sw;ne;nd;n;su;n;s;s;n;nd;nw")
    end)
    wait.make(function()
        wait.time(4)
        exe("nd;n;n;w;s;n;w;s;n;w;e;n;w;e;n;w;e;n;w;e;n;w;task ok")
    end)
end
function xunchengxi()
    wait.make(function()
        wait.time(2)
        exe(
            "halt;yun jingli;wu;eu;wu;nu;n;s;sd;ed;sd;sw;su;nd;w;nw;sw;u;d;ne;se;sw;su")
    end)
    wait.make(function()
        wait.time(3)
        exe("nd;ne;sw;su;nd;ne;e;ne;ed;task ok")
    end)
end
function xuncheng_task_wait()
    wait.make(function()
        if hp.exp and hp.exp > 300000 and hp.jingli_max >= hp.jingli_lim and
            hp.neili_max >= hp.neili_lim then
            if hp.neili > hp.neili_max * 0.8 then
                exe("e;yun jing;yun qi;yun jingli;sxlian;dazuo " .. hp.dazuo)
            else
                exe("e;yun qi;yun jing;dazuo " .. hp.dazuo)
            end
        elseif hp.exp and hp.exp > 300000 and hp.neili_max >= hp.neili_lim and
            hp.neili > hp.neili_max * 0.4 then
            exe("e;yun jing;yun qi;tuna " .. hp.jingxue / 2)
        elseif hp.exp > 100000 and hp.qixue < hp.dazuo then
            exe("e;yun qi;dazuo " .. hp.dazuo)
        elseif hp.qixue < hp.dazuo and score.party == "丐帮" then
            exe("e;sleep")
        else
            exe("e;dazuo " .. hp.dazuo)
        end
        wait_busy()
        DeleteTemporaryTriggers()
        exe("hp;w")
        wait_busy()
        xuncheng_task()
    end)
end

function xuncheng_check()
    DeleteTemporaryTriggers()
    flag.xuncheng_start = false
    job.name = "idle"
    if g_stop_flag then
        print("停止巡城")
        g_stop_flag = false
        return disAll()
    end
    wait.make(function()
        exe("cha;score;yun jingli;hp")
        wait_busy()
        xuncheng_checkpot()
    end)
end
function xuncheng_checkpot()
    if hp.pot >= hp.pot_max * 6 / 7 then
        if hp.jingli > 100 then
            -- return go(xuexi,"大理城","茶馆")
            if score.gold and skills["literate"] and score.gold > 300 and
                skills["literate"].lvl < hp.pot_max - 100 then
                return literate()
            end
            return go(check_xuexi, "大理城", "茶馆")
        else
            -- return checkWait(xuncheng_check, 5)
            wait.time(5)
            return xuncheng_check()
        end
    else
        return xuncheng_start()
    end
end

function dushu(p_book)
    disAll()
    create_triggerex("dushu1",
                     "^(> )*(你先天膂力太高|你研读了一会儿|你的基础功没有打好|你的实战经验不足)",
                     "", "check_heal")
    create_triggerex("dushu2",
                     "^(> )*(你仔细地读了一遍|你已经无法再从秘籍中学到什么|由于你的基本刀法火侯不够|你感觉自己对于五虎断门刀|你将整本秘籍研读至此)",
                     "", "check_heal")
    if p_book == nil then return print("请输入正确书名") end
    tmp.book = p_book
    return check_bei(dushuStart)
end
function dushuStart()
    exe("yun jing;cha;hp")
    check_bei(dushuDazuo)
end
function dushuDazuo()
    if hp.qixue > hp.dazuo then exe("dazuo " .. hp.qixue) end
    check_bei(dushuAct)
end
function dushuAct()
    exe("hp")
    check_bei(dushuCheck)
end
function dushuCheck()
    local bookRead = {
        ["medicine book"] = true,
        ["bo juan"] = true,
        ["miji"] = true,
        ["jiuyin-baiguzhua"] = true,
        ["cuixin-zhang"] = true,
        ["yinlong-bian"] = true,
        ["jianfa"] = true,
        ["zhangfa"] = true
    }
    if hp.neili > hp.neili_max * 0.4 then
        exe("yun jing")
        if bookRead[tmp.book] then
            exe("#5(read " .. tmp.book .. ")")
        else
            exe("#5(du " .. tmp.book .. ")")
        end
        return check_bei(dushuAct)
    else
        return prepare_neili(dushuAct)
    end
end

function fullNeili()
    exe("unset 积蓄")
    exe("cha;hp")
    if score.party and score.party == "丐帮" then
        go(fullNeiliStart, "丐帮", "墓室通道")
    else
        go(fullNeiliStart, "峨嵋山", "大雄殿")
    end
end
function fullNeiliStart()
    exe("unset 积蓄")
    exe("hp")
    check_bei(fullNeiliCheck)
end
function fullNeiliCheck()
    flag.idle = 0

    if hp.neili_max >= hp.neili_lim then return check_heal() end

    if hp.qixue < hp.dazuo * 2 then
        exe("yun qi;dazuo " .. hp.dazuo)
    else
        exe("dazuo " .. hp.dazuo)
    end

    return fullNeiliCon()
end
function fullNeiliCon()
    exe("hp")
    check_bei(fullNeiliCheck)
end
function fulljingli()
    exe("unset 积蓄")
    exe("cha;hp")
    if score.party and score.party == "丐帮" then
        go(fulljingliStart, "丐帮", "墓室通道")
    else
        go(fulljingliStart, "峨嵋山", "大雄殿")
    end
end
function fulljingliStart()
    exe("unset 积蓄")
    exe("hp")
    check_bei(fulljingliCheck)
end
function fulljingliCheck()
    flag.idle = 0

    if hp.jingli_max >= hp.jingli_lim then return check_heal() end

    exe("yun jing;tuna " .. hp.jingxue_max / 2)

    return checkWait(fulljingliCon, 5)
end
function fulljingliCon()
    exe("hp")
    return check_bei(fulljingliCheck)
end

function fullSkill(xskill)
    tmp.i = 0
    tmp.xskill = xskill
    tmp.pskill = nil
    tmp.oskill = nil
    return go(fullSkillStart, "峨嵋山", "大雄殿")
end
function fullSkillStart() return prepare_neili(fullSkillCheck) end
function fullSkillCheck()
    flag.idle = 0
    messageShow(tmp.xskill)
    lianxi(5, tmp.xskill)
    if (tmp.pskill and tmp.oskill == nil) or
        (tmp.oskill and tmp.pskill and tmp.oskill ~= tmp.pskill) then
        tmp.oskill = tmp.pskill
        tmp.skillpot = nil
        tmp.i = 0
    end
    if tmp.oskill and tmp.pskill and tmp.oskill == tmp.pskill and
        skills[tmp.pskill] then
        if tmp.skillpot == nil then tmp.skillpot = skills[tmp.pskill].pot end
        if tmp.skillpot == skills[tmp.pskill].pot then
            tmp.i = tmp.i + 1
            if tmp.i > 100 then
                skills[tmp.pskill].fullever = true
                return check_heal()
            end
        end
    end
    if flag.lianxi == 1 then
        if tmp.xskill and tmp.pskill then
            messageShow(tmp.xskill .. " " .. tmp.pskill)
        end
        if tmp.xskill and tmp.pskill and tmp.xskill == tmp.pskill and
            skills[tmp.xskill].lvl < skills["force"].lvl and
            skills[tmp.xskill].lvl < hp.pot_max - 100 then
            return lingwu()
        else
            return check_heal()
        end
    end
    if hp.neili < hp.neili_max / 2 then return fullSkillStart() end
    if hp.neili == hp.neili_max * 2 then return check_heal() end
    local l_cnt = math.modf(hp.neili_max / 50)
    if l_cnt < 1 then l_cnt = 1 end
    exe("yun jingli")
    lianxi(l_cnt, tmp.xskill)
    exe("cha;hp")
    return check_bei(fullSkillCheck)
end

function learnSzj() return go(learnSzjChk, "苏州城", "北门兵营") end
function learnSzjChk()
    if hp.exp > 500000 then
        return wipe("zhao liangdong", learnSzjGo)
    else
        return learnSzjGo()
    end
end
function learnSzjGo()
    exe("west")
    locate()
    return check_busy(learnSzjAsk, 1)
end
function learnSzjAsk()
    flag.idle = 0
    if not locl.id["丁典"] then return check_bei(learnSzjOver) end
    if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl >= 200 then
        return check_bei(learnSzjOver)
    end
    if hp.pot < 10 then return check_bei(learnSzjOver) end
    if hp.neili < 1000 and Bag["川贝内息丸"] then
        exe("eat chuanbei wan")
    end
    if hp.neili < 500 then
        if Bag["大还丹"] then
            exe("eat dan")
        else
            return check_bei(learnSzjOver)
        end
    end
    exe("yun jing;ask ding dian about 神照经;cha;hp")
    locate()
    checkBags()
    return check_busy(learnSzjAsk, 1)
end
function learnSzjOver()
    if hp.pot >= hp.pot_max then return potSave() end
    return check_heal()
end

function huxi() return go(huxiStart, "昆仑山", "白牛山") end
function huxiStart()
    if locl.room ~= "白牛山" then return huxi() end
    DeleteTriggerGroup("huxi")
    create_trigger_t("huxi1",
                     "^(> )*你集聚体内真气，深深吸进几口气", "",
                     "huxiCheck")
    create_trigger_t("huxi2", "^(> )*寒风凛冽，你刚运过功", "",
                     "huxiChk")
    SetTriggerOption("huxi1", "group", "huxi")
    SetTriggerOption("huxi2", "group", "huxi")
    exe("enable force shenzhao-jing")
    exe("wo stone;huxi;hp")
end
function huxiChk()
    flag.idle = 0
    if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl == hp.pot_max -
        100 then return check_bei(huxiOver, 1) end
    wait.make(function()
        wait.time(1)
        if hp.jingxue < 60 then exe("yun jing") end
        if hp.qixue < 60 then exe("yun qi") end
        exe("wo stone;huxi;hp;cha")
    end)
end
function huxiCheck()
    flag.idle = 0
    if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl == hp.pot_max -
        100 then return check_bei(huxiOver, 1) end
    wait.make(function()
        wait.time(2)
        if hp.jingxue < 60 then exe("yun jing") end
        if hp.qixue < 60 then exe("yun qi") end
        exe("wo stone;huxi;hp;cha")
    end)
end
function huxiOver()
    DeleteTriggerGroup("huxi")
    return check_heal()
end

function wxjzFofa() return go(wxjzFofaPre, "嵩山少林", "心禅堂") end
function wxjzFofaPre()
    EnableTrigger("fight16", false)
    if Bag["挠钩"] and Bag["套索"] then
        exe("n")
        exe("pray pearl")
        for p in pairs(Bag) do
            if Bag[p].kind then
                for i = 1, Bag[p].cnt do
                    exe("drop " .. Bag[p].fullid)
                end
            end
        end
        exe("drop silver")
        exe("shuai tao suo")
        exe("da nao gou;pa up;enter")
        locate()
        return check_busy(wxjzFofaAsk, 1)
    end
    if locl.id["方生大师"] then
        if not Bag["挠钩"] then exe("ask fangsheng about 挠钩") end
        if not Bag["套索"] then exe("ask fangsheng about 套索") end
        checkBags()
        return check_busy(wxjzFofaPre, 1)
    else
        return check_heal()
    end
end
function wxjzFofaAsk()
    if locl.room == "心禅堂" then
        exe("n")
        exe("pray pearl")
        exe("shuai tao suo")
        exe("da nao gou;pa up;enter")
        locate()
        return check_busy(wxjzFofaAsk, 1)
    end
    if not locl.id["无相禅师"] then return check_heal() end
    DeleteTriggerGroup("fofa")
    create_trigger_t("fofa1",
                     "^(> )*你向无相禅师打听有关『佛法』的消息",
                     "", "fofaAccept")
    create_trigger_t("fofa2", "^(> )*这里没有这个人。$", "",
                     "fofaNobody")
    SetTriggerOption("fofa1", "group", "fofa")
    SetTriggerOption("fofa2", "group", "fofa")
    exe("ask wuxiang chanshi about 佛法")
end
function fofaNobody()
    EnableTriggerGroup("fofa", false)
    return check_bei(wxjzFofaOver)
end
function wxjzFofaOver()
    DeleteTriggerGroup("fofa")
    DeleteTriggerGroup("ffacp")
    exe("out;d;get all")
    return check_heal()
end
function fofaAccept()
    EnableTriggerGroup("fofa", false)
    DeleteTriggerGroup("ffacp")
    create_trigger_t("ffacp1", "^(> )*你端坐良久，若有所悟。", "",
                     "fofaAskCon")
    create_trigger_t("ffacp2",
                     "^(> )*无相禅师(对你|)说道：(「|)你的潜能不够了。",
                     "", "fofaAskPot")
    create_trigger_t("ffacp3",
                     "^(> )*无相禅师(对你|)说道：(「|)大师佛法精深",
                     "", "fofaAskOver")
    SetTriggerOption("ffacp1", "group", "ffacp")
    SetTriggerOption("ffacp2", "group", "ffacp")
    SetTriggerOption("ffacp3", "group", "ffacp")
end
function fofaAskCon()
    EnableTriggerGroup("ffacp", false)
    return check_bei(wxjzFofaAsk, 1)
end
function fofaAskPot()
    EnableTriggerGroup("ffacp", false)
    return check_bei(wxjzFofaOver, 1)
end
function fofaAskOver()
    EnableTriggerGroup("ffacp", false)
    flag.wxjz = 1
    return check_bei(wxjzFofaOver, 1)
end

function tiaoshui() return go(tiaoshuiAsk, "嵩山少林", "后殿") end
function tiaoshuiAsk()
    if locl.id["慧空尊者"] then
        wait.make(function()
            exe("ask huikong zunzhe about 挑水")
            wait.time(3)
            exe("get tie tong")
            await_check_bags()
            return check_busy(tiaoshuiTong, 1)
        end)
    end
    return go(tiaoshuiAsk, "嵩山少林", "后殿")
end
function tiaoshuiTong()
    if Bag["大铁桶"] then
        return go(tiaoshuiFill, "嵩山少林", "佛心井")
    end
    return go(tiaoshuiAsk, "嵩山少林", "后殿")
end
function tiaoshuiFill()
    flag.idle = 0
    exe("fill tie tong")
    return go(tiaoshuiPour, "嵩山少林", "后殿")
end
function tiaoshuiPour()
    exe("pour gang")
    checkBags()
    return check_busy(tiaoshuiChk, 1)
end
function tiaoshuiChk()
    if not Bag["镣铐"] then return check_heal() end
    if not Bag["大铁桶"] then
        return go(tiaoshuiAsk, "嵩山少林", "后殿")
    end
    return go(tiaoshuiFill, "嵩山少林", "佛心井")
end
