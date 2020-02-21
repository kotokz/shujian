luapath = string.match(GetInfo(35), "^.*\\")
mclpath = GetInfo(67)
include = function(str) dofile(luapath .. str) end
loadmod = function(str) include("mods\\" .. str .. ".lua") end

require "wait"
require "tprint"
require "addxml"
require "socket"

loadmod "status"
loadmod "lujing"
loadmod "chat"
loadmod "job"
loadmod "rooms"
loadmod "xuncheng"
loadmod "skill"
loadmod "weapon"
-- require "hubiao"
loadmod "show_switch"
loadmod "dummy"
loadmod "husong"
loadmod "xueshan"
loadmod "wudang"
loadmod "clb"
loadmod "huashan"
loadmod "songmoya"
loadmod "tdh"
loadmod "songxin"
loadmod "hqgzc"
loadmod "dolost"
loadmod "kezhiwugong"
loadmod "armor"
loadmod "diemenglou"
loadmod "zhuacaishen"
loadmod "guanfu"
loadmod "taohuazhen"
loadmod "sj_egg"
loadmod "lostletter"
loadmod "taohuazhen"

test = test or function() print("initial behavior, does nothing") end

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
skills = {}
-- if hp.exp>800000 then
skillsLingwu = {
    'force', 'finger', 'parry', 'dodge', 'strike', 'blade', 'cuff', 'claw',
    'hand', 'leg', 'whip', 'club', 'sword', 'stick', 'hammer', 'dagger',
    'brush', 'throwing', 'spear', 'staff', 'axe'
}
-- else
-- skillsLingwu={'finger','parry','dodge','strike','blade','cuff','claw','hand','leg','whip','club','sword','stick','hammer','dagger','brush','throwing','spear','staff','axe'}
-- end	

master = {}

perform = {}

lost_name = 0
needdolost = 0
flag = {
    xuexi = 0,
    lingwu = 0,
    lianxi = 0,
    prepare = 0,
    go = 0,
    find = 0,
    wait = 0,
    times = 1,
    gold = 1,
    duhe = 1,
    dujiang = 1,
    jixu = 1,
    wipe = 0
}
flag.autoll = 1
flag.food = 0
flag.month = 0
flag.wxjz = 0
flagFull = {}
tmp = {}
condition = {}
weapon = {}
count = {}
count.gold_max = 5
count.nxw_max = 20
count.cbw_max = 20
count.hqd_max = 20
count.cty_max = 20
count.hxd_max = 5
count.dhd_max = 5
drug = {}
drug.heal = 'chantui yao'
drug.neili = 'neixi wan'
drug.neili2 = 'chuanbei wan'
drug.neili3 = 'huangqi dan'
drug.jingxue = 'huoxue dan'
bags = {}
Bag = {}
team = {}
xcexp = 1
lingwudie = 0
needxuexi = 1
xxpot = 0
xuefull = 0
lookxin = 0
leweapon = 'none'
jherror = 0
inwdj = 0
dugujian = 0
l_pot = 0
haltbusy = 0
smyteam = 17
tdhdz = 1
smyall = 2
lostno = 10
vippoison = 0
ptbxvip = 0
kdummy = 0
mydummy = false
double_kill = nil
ypt_lianskills = 0
scorexy = false
LLlost = 0
needvpearl = 0
doubleexp = 0
dohs2 = 1
hsjob2 = 0
dzxy_level = 0
need_dzxy = 'yes'
hqgzcjl = 0
cty_cur = 0
nxw_cur = 0
cbw_cur = 0
hqd_cur = 0
hxd_cur = 0
dhd_cur = 0
kuang_cur = 0
kuang_cur1 = 0
go_on_smy = 0 -- 20161117增加变量go_on_smy开关控制 防止系统重启后自动打开颂摩崖
ebooktimes = 0
lostletter_locate = ""
ll = {}
ll.area = ''
ll.room = ''
hsruntime = 0
pkheqi = 0
pkset = 0
wdgostart = 0
wd_distance = 4
flag.yili = true
wudang_checkfood = 0
xuezhu_require = 0
needjinchai = 0
cmdck = 0
check_steptest = 0
_check_step_num = 0
check_step_num = 0
check_step_num1 = 0
check_step_num2 = 0
need_waittime = 0
common_walk = 1
check_step_time = os.clock()
quick_locate = 0
g_stop_flag = false

SMYID = { -- 武当失败开启上山的id
    ["kkfromch"] = true,
    ["xiaogao"] = false,
    ["kuer"] = false
    -- ["cxls"] = false,
    -- ["liumaisj"] = false,	
}

pker = {}
pker_name = "none"
pker_id = "none"

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

i = 1

beihook = test
halthook = test

function main()
    needdolost = 0
    autopk = 0
    setAlias()
    delete_all_triggers()
    delete_all_timers()
    DeleteTemporaryTriggers()
    create_trigger_t('main', "^「书剑\\D*」\\D*已经连续执行了", '',
                     'login')
    create_trigger_t('main1', "^Are you using BIG5 font\\(y/N\\)? ", '',
                     'login_choose')
    lujing_trigger()
    chat_trigger()
    hp_trigger()
    fight_trigger()
    fight_prepare()
    idle()
    getVariable()
    userGet()
    hpheqi()
    -- ain
    Openfpk()
    map.rooms["sld/lgxroom"].ways["#outSld"] = "huanghe/huanghe8"
    exe(
        'down;alias askk ask $*;stand;halt;uweapon;score;cha;hp;jifa all;jiali max;unset no_kill_ap;cond;pfmset')
    return check_bei(hp_dazuo_count)

end

function login_choose() Send('n') end

function login()
    dis_all()
    DeleteTriggerGroup("login")
    create_trigger_t('login1', "^您上次连线地址是", '', 'logincheck')
    create_trigger_t('login2',
                     "^请您输入这个人物的识别密码\\(passwd\\)：",
                     '', 'login_passwd')
    SetTriggerOption("login1", "group", "login")
    SetTriggerOption("login2", "group", "login")
    local l_id = GetVariable("id")
    local l_passwd = GetVariable("passwd")
    Note(l_id, l_passwd)
    if l_id ~= nil and l_passwd ~= nil then
        Send(l_id)
        Send(l_passwd)
        Send('y')
    else
        return shujian_set()
    end
end
function logincheck()
    xuezhu_require = 1
    needjinchai = 1
    scrLog()
end
function login_passwd()
    wait.make(function()
        wait.time(2)
        EnableTriggerGroup("login", false)
        main()
    end)
end
function disAll()
    local tl = GetTriggerList()
    if tl then for k, v in ipairs(tl) do EnableTrigger(v, false) end end
    delete_all_timers()
    if lookxin == 1 and job.name == 'dolost' then sendXin() end
    EnableTrigger("main", true)
    EnableTrigger("main1", true)
    EnableTriggerGroup("hp", true)
    EnableTriggerGroup("score", true)
    -- ain
    EnableTrigger("pk1", true)
    EnableTrigger("pk2", true)
    EnableTriggerGroup("buyao", true)
    if job.name == 'diemenglou' then
        dmlTriggers()
        EnableTrigger('dmlfight1', true)
    end
    if job.name == 'hubiao' then
        EnableTrigger("hpheqi1", true)
        EnableTriggerGroup("fight", true)
        EnableTriggerGroup("hb_fight", true)
        hb_kill_look()
        -- EnableTriggerGroup("hb_kill",true)--小猪猪护镖文件的叫杀触发器
        flag.djdh = false
    end
end
function dis_all()
    local tl = GetTriggerList()
    if tl then for k, v in ipairs(tl) do EnableTrigger(v, false) end end
    delete_all_timers()
    EnableTrigger('main', true)
    EnableTrigger('main1', true)
    -- EnableTrigger('idle',true)
    EnableTriggerGroup("chat", true)
    EnableTriggerGroup("hp", true)
    EnableTriggerGroup("score", true)
    EnableTriggerGroup("count", true)
    EnableTriggerGroup("fight", true)
    EnableTriggerGroup("job_exp", true)
    EnableTrigger("hp12", false)
    if lookxin == 1 and job.name == 'dolost' then sendXin() end
    -- ain
    EnableTrigger("pk1", true)
    EnableTrigger("pk2", true)
    EnableTriggerGroup("buyao", true)
    beihook = test
    busyhook = test
    waithook = test
    flag.find = 1
    wdgostart = 0
    -- thread_resume(lookfor)
    idle()
end
function delete_all_triggers()
    local tl = GetTriggerList()
    if tl then for k, v in ipairs(tl) do DeleteTrigger(v) end end
end
function delete_all_timers()
    local tl = GetTimerList()
    if tl then for k, v in ipairs(tl) do DeleteTimer(v) end end
end

function yiliCheck(n, l, w)
    if Trim(w[2]) == "开着" then
        flag.yili = true
    elseif Trim(w[2]) == "关闭" then
        flag.yili = false
    end
end
--[[function jifaOver()
    exe('jifa all')
end]]
function checkDebug()
    messageShow('您中毒了!')
    vippoison = 1
    exe('look bei nang;hp')
    if job.name == 'songmoya' then
        Execute('set wimpycmd halt\\down\\hp')
        job.name = 'poison'
        return check_halt(fangqiypt)
    end
    if hxd_cur > 0 then
        create_timer_s('eatdan', 3, 'hpEat')
    else
        dis_all()
        return check_halt(check_xue)
    end
end
function hpEat() exe('eat huoxue dan') end
function hpeatOver(n, l, w)
    local l = w[2]
    if string.find(l,
                   "敷上一副蝉蜕金疮药，顿时感觉伤势好了不少") then
        cty_cur = cty_cur - 1
    end
    if string.find(l,
                   "服下一颗内息丸，顿时觉得内力充沛了不少") then
        nxw_cur = nxw_cur - 1
    end
    if string.find(l, "服下一颗川贝内息丸，顿时感觉内力充沛") then
        cbw_cur = cbw_cur - 1
    end
    if string.find(l,
                   "服下一颗黄芪内息丹，顿时感觉空虚的丹田充盈了不少") then
        hqd_cur = hqd_cur - 1
    end
    if string.find(l,
                   "服下一颗活血疗精丹，顿时感觉精血不再流失") then
        DeleteTimer("eatdan")
        hxd_cur = hxd_cur - 1
    end
    if string.find(l, "吃下一颗大还丹顿时伤势痊愈气血充盈") then
        messageShow('吃大还丹了！')
        dhd_cur = dhd_cur - 1
    end
end
function checkQuit()
    -- dis_all()
    -- check_halt(BQuit)
    if job.name == 'idle' then check_food() end
    exe('drink jiudai')
end
function BQuit() exe('quit') end
function checkfood()
    if job.name == "songmoya" or (job.name ~= nil and job.name ~= 'idle') then
        return
    else
        dis_all()
        return check_halt(check_food)
    end
end

function checkMonth() flag.month = 1 end
function checkTongbao(n, l, w) score.tongbao = tonumber(w[1]) end
function checkGoldLmt(n, l, w) score.goldlmt = trans(w[1]) end

function jifaAll()
    for p in pairs(skills) do
        local sk = qrySkillEnable(p)
        if sk and sk["force"] and perform.force and perform.force == p then
            exe('jifa force ' .. p)
        end
        if sk and not sk["force"] then
            for q in pairs(sk) do
                if skills[q] and skills[p].lvl >= skills[q].lvl then
                    exe('jifa ' .. q .. ' ' .. p)
                end
            end
        end
    end
end
function jifaDodge()
    for p in pairs(skills) do
        q = skillEnable[p]
        if q == "dodge" and skills[q] and skills[p].lvl >= skills[q].lvl then
            exe('jifa ' .. q .. ' ' .. p)
            break
        end
    end
end

function yunAddInt()
    if perform.force and perform.force == "linji-zhuang" then
        exe('yun zhixin')
    end
    --[[if perform.force and perform.force=="bihai-chaosheng" then
       exe('yun qimen')
    end]]
    if perform.force and perform.force == "yunu-xinjing" then
        exe('yun xinjing')
    end
end

function wuxingzhen()
    DeleteTemporaryTriggers()
    flag.times = 1
    return go(wuxingzhenCheck, '襄阳城', '卧房')
end
function wuxingzhenCheck()
    if locl.id["温方山"] then
        return wuxingzhenStart()
    else
        local l_cnt = table.getn(getRooms('卧房', '襄阳城'))
        flag.times = flag.times + 1
        if flag.times > l_cnt then
            return wuxingzhenFinish()
        else
            local l_sour = getRooms('卧房', '襄阳城')[flag.times - 1]
            return go(wuxingzhenCheck, '襄阳城', '卧房', l_sour)
        end
    end
end
function wuxingzhenStart()
    exe('yun jing')
    exe('ask wen fangshan about 五行阵')
    if math.random(1, 5) == 1 then
        exe('cha;hp')
        locate()
    end
    return check_bei(wuxingzhenCon, 1)
end
function wuxingzhenCon()
    if skills["wuxing-zhen"] and skills["wuxing-zhen"].lvl > 159 then
        return wuxingzhenFinish()
    end
    if not locl.id["温方山"] or hp.pot < 10 then return wuxingzhenFinish() end
    return checkWait(wuxingzhenStart, 0.5)
end
function wuxingzhenFinish() return check_heal() end

function checkPrepare()
    EnableTriggerGroup("poison", false)
    DeleteTriggerGroup("poison")

    if g_stop_flag == true then
        print("任务结束，游戏暂停")
        g_stop_flag = false
        return disAll()
    end
    drugPrepare = drugPrepare or {}
    exe('hp')
    if hp.exp < 150000 then return checkPrepareOver() end
    if hp.food < 40 or hp.water < 40 then return check_food() end
    if hp.jingxue_per < 90 or hp.qixue_per < 60 then return check_heal() end
    if Bag["镣铐"] then return tiaoshui() end

    if Bag and Bag["白银"] and Bag["白银"].cnt and
        (Bag["白银"].cnt > 100 or Bag["白银"].cnt < 50) then
        return check_gold()
    end
    if (Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["黄金"] and Bag["黄金"].cnt and Bag["黄金"].cnt >
            count.gold_max * 4) then return check_gold() end
    if score.gold and score.gold > 100 and nxw_cur < 5 and
        drugPrepare["内息丸"] then return checkNxw() end
    if score.gold and score.gold > 100 and cbw_cur < 5 and
        drugPrepare["川贝内息丸"] then return checkNxw() end

    if score.gold and score.gold > 100 and hqd_cur < 5 and
        drugPrepare["黄芪内息丹"] then return checkNxw() end

    if score.gold and score.gold > 100 and cty_cur < 5 and
        drugPrepare["蝉蜕金疮药"] then return checkHxd() end

    --[[if job.zuhe["wudang"] and job.zuhe["xueshan"] and job.last=="wudang" and (not Bag["邪气丸"] or Bag["邪气丸"].cnt<2) then
       return checkXqw()
	end
	
	if job.zuhe["wudang"] and job.zuhe["xueshan"] and job.last=="wudang" and (not Bag["正气丹"] or Bag["正气丹"].cnt<2) then
       return checkZqd()
	end
	
	if job.zuhe["huashan"] and job.zuhe["xueshan"] and job.last=="huashan" and (not Bag["邪气丸"] or Bag["邪气丸"].cnt<2) then
       return checkXqw()
	end
	
	if job.zuhe["huashan"] and job.zuhe["xueshan"] and job.last=="huashan" and (not Bag["正气丹"] or Bag["正气丹"].cnt<2) then
       return checkZqd()
	end]]

    if not flag.item then
        if score.party and score.party == "峨嵋派" and not Bag["腰带"] then
            return check_item()
        end
        if score.party == "少林派" and not Bag["护腰"] and
            not Bag["护腕"] then return check_item() end
    end
    if locl.weekday == '四' and locl.hour == 8 then
        print(
            '避开周四服务器重启高峰，错后火折和酒袋购买时间一小时！')
    else
        if not Bag["火折"] and drugPrepare["火折"] then
            return checkFire()
        end

        if not Bag["牛皮酒袋"] and drugPrepare["牛皮酒袋"] then
            return checkJiudai()
        end
    end
    if score.gold and score.gold > 100 and hxd_cur < 3 and
        drugPrepare["活血疗精丹"] then return checkLjd() end

    if score.tb and score.tb > 100 and dhd_cur < 1 and drugPrepare["大还丹"] then
        return checkdhd()
    end

    for p in pairs(weaponPrepare) do
        if weaponStore[p] and not Bag[p] and Bag["黄金"].cnt > 3 then
            return checkWeapon(p)
        end
        if weaponFunc[p] and not Bag[p] then
            return _G[weaponFuncName[p]]()
        end
        if weaponPrepare["飞镖"] and Bag["枚飞镖"].cnt < 100 then
            return checkWeapon("飞镖")
        end
    end
    local l_cut = false
    for p in pairs(Bag) do
        if weaponKind[Bag[p].kind] and weaponKind[Bag[p].kind] == "cut" then
            l_cut = true
        end
    end
    if not l_cut and not Bag["木剑"] then
        weaponPrepare["木剑"] = true
        return checkWeapon("木剑")
    end

    if Bag["韦兰之锤"] then return checkHammer() end

    for p in pairs(Bag) do
        if Bag[p] and itemSave[p] then return checkYu(p) end
        if Bag[p].id and Bag[p].id["yu"] and string.find(p, "玉") then
            return checkYu(p)
        end
        if Bag[p].id and Bag[p].id["jintie chui"] and
            string.find(p, "金铁锤") then return checkYu(p) end
        if Bag[p].id and Bag[p].id["shentie chui"] and
            string.find(p, "神铁锤") then return checkYu(p) end
    end
    exe('wear all')

    if needjinchai == 1 then return go(getchai, "扬州城", "杂货铺") end

    if xuezhu_require == 1 then
        if GetVariable("xuezhu_status") ~= nil and GetVariable("xuezhu_status") ==
            '2' then
            SetVariable("xuezhu_status", "0") -- 重启之后初始化自动抓雪蛛变量为0
        end
        if GetVariable("xuezhu_status") ~= nil and GetVariable("xuezhu_status") ==
            '1' then
            SetVariable("xuezhu_status", "-1") -- 如果上周要了真丹，未给雪蛛，重启之后初始化自动抓雪蛛变量为-1
        end
        xuezhu_require = 0
    end

    local x = check_xuezhu_status()
    if x == '0' then return getxuezhu0() end
    if x == '-1' or x == '1' then return getxuezhu1() end

    if Bag and Bag["野菊花"] and not Bag["铜钥匙"] then
        return go(get_key, '扬州城', '小盘古')
    end
    --[[if Bag and not Bag["铜钥匙"] then
	   return check_key()
	end
	if Bag and not Bag["绳子"] then
	   return check_rope()
	end]]

    return checkPrepareOver()
end
function checkPrepareOver()
    if lostletter == 1 and needdolost == 1 then return letterLost() end
    condition.busy = 0
    vippoison = 0
    exe('score;cond')
    if wudang_checkfood == 1 or (condition.busy and condition.busy > 10) or
        needxuexi == 1 then
        return check_xuexi()
    else
        if needxuexi ~= 1 then messageShow('不需要学习') end
        return check_job()
    end
end
function getchai()
    wait.make(function()
        wait.time(1)
        exe('qu jin chai')
        needjinchai = 0
        return check_busy(getshengzi, 3)
    end)
end
function getshengzi()
    exe('qu sheng zi')
    return check_busy(getshengzi1, 3)
end
function getshengzi1()
    exe('qu cu shengzi')
    return check_busy(getfire, 3)
end
function getfire()
    exe('qu fire')
    return check_busy(getjuhua, 3)
end
function getjuhua()
    exe('qu ye juhua')
    return check_busy(askfuli, 3)
end
function askfuli()
    DeleteTriggerGroup("vipfuli")
    create_trigger_t('askfuli1',
                     '^(> )*当铺老板为你在钱庄中存入(\\D*)锭黄金。',
                     '', 'vip_gold')
    create_trigger_t('askfuli2',
                     '^(> )*你的帐号增加了(\\D*)个通宝。', '',
                     'vip_tongbao')
    create_trigger_t('askfuli3', '^(> )*你增加了(\\D*)点内力修为。',
                     '', 'vip_neili')
    SetTriggerOption("askfuli1", "group", "vipfuli")
    SetTriggerOption("askfuli2", "group", "vipfuli")
    SetTriggerOption("askfuli3", "group", "vipfuli")
    return go(askfuli1, "扬州城", "当铺")
end
function askfuli1()
    wait.make(function()
        wait.time(1)
        exe('ask laoban about 会员福利')
        return check_busy(askfuli2)
    end)
end
function askfuli2()
    exe('ask laoban about 会员基金')
    wait.make(function()
        wait.time(2)
        return check_busy(checkPrepare)
    end)
end
function vip_gold(n, l, w)
    EnableTriggerGroup("vipfuli", false)
    DeleteTriggerGroup("vipfuli")
    messageShow(
        '每周会员福利：   当铺老板为你在钱庄中存入【' ..
            w[2] .. '】锭黄金。', 'gold', 'black')
end
function vip_tongbao(n, l, w)
    messageShow('每周会员福利：   你的帐号增加了【' .. w[2] ..
                    '】个通宝。', 'red', 'black')
end
function vip_neili(n, l, w)
    messageShow('每周会员福利：   你增加了【' .. w[2] ..
                    '】点内力修为。', 'blue', 'black')
end
function vip_get_rope()
    wait.make(function()
        wait.time(3)
        exe('qu sheng zi')
        return check_busy(check_jobx, 3)
    end)
end
function vip_get_juhua()
    wait.make(function()
        wait.time(3)
        exe('qu ye juhua')
        return check_busy(check_jobx, 3)
    end)
end
function wait_busy()
    EnableTrigger("hp12", true)
    while true do
        exe('bei bei bei')
        local l, w = wait.regexp(
                         '^(> )*(你现在已经组合|你已准备有一种技能了|你至少不会这两种拳脚技能的其中之一)',
                         1)
        if l ~= nil then
            EnableTrigger("hp12", false)
            break
        end
        wait.time(0.4)
    end
end

function check_busy(func, p_cmd)
    disWait()
    DeleteTriggerGroup("check_bei")
    create_trigger_t('check_bei1',
                     "^(> )*(你现在已经组合|你已准备有一种技能了|你至少不会这两种拳脚技能的其中之一)",
                     '', 'beiok')
    create_trigger_t('check_bei2',
                     "^(> )*你现在没有激发任何有效特殊技能。",
                     '', 'beinone')
    SetTriggerOption("check_bei1", "group", "check_bei")
    SetTriggerOption("check_bei2", "group", "check_bei")
    EnableTriggerGroup("check_bei", true)
    EnableTrigger("hp12", true)
    beihook = func
    if not p_cmd then exe('bei bei bei') end
    return bei_timer()
end
function bei_timer() return create_timer_s('bei', 0.4, 'bei_timer_set') end
function bei_timer_set()
    -- EnableTriggerGroup("check_bei",true)
    exe('bei bei bei')
end
function beinone()
    for p, q in pairs(skillEnable) do
        if skills[p] and q ~= "force" then
            exe('jifa ' .. q .. ' ' .. p)
            if math.random(1, 3) == 1 then break end
        end
    end
end
function beiok()
    EnableTriggerGroup("check_bei", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('bei')
    -- DeleteTriggerGroup("check_bei")
    EnableTimer('bei', false)
    if beihook == nil then beihook = test end
    return beihook()
end
function check_halt(func)
    disWait()
    DeleteTriggerGroup("check_halt")
    create_trigger_t('check_halt1',
                     "^>*\\s*(你现在不忙。|你身形向后一跃，跳出战圈不打了。)",
                     '', 'haltok')
    create_trigger_t('check_halt2', "^>*\\s*你现在很忙，停不下来。",
                     '', 'halterror')
    SetTriggerOption("check_halt1", "group", "check_halt")
    SetTriggerOption("check_halt2", "group", "check_halt")
    EnableTriggerGroup("check_halt", true)
    EnableTrigger("hp12", true)
    halthook = func
    exe('halt')
    return halt_timer()
end
function halterror()
    haltbusy = haltbusy + 1
    if haltbusy > 30 then
        haltbusy = 0
        locate()
    end
    if locl.room == "洗象池边" then
        EnableTimer('halt', false)
        wait.make(function()
            wait.time(5)
            haltok()
        end)
    end
end
function halt_timer() return create_timer_s('halt', 0.4, 'halt_timer_set') end
function halt_timer_set()
    -- EnableTriggerGroup("check_halt",true)
    exe('halt')
end
function haltok()
    haltbusy = 0
    EnableTriggerGroup("check_halt", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('halt')
    EnableTimer('halt', false)
    -- DeleteTriggerGroup("check_halt")
    if halthook == nil then halthook = test end
    return halthook()
end
busyhook = test
function check_bei(func, p_cmd)
    disWait()
    DeleteTriggerGroup("check_busy")
    create_trigger_t('check_busy1', "^>*\\s*没有这个技能种类，用", '',
                     'busyok')
    SetTriggerOption("check_busy1", "group", "check_busy")
    EnableTriggerGroup("check_busy", true)
    EnableTrigger("hp12", true)
    busyhook = func
    if not p_cmd then exe('jifa jifa jifa') end
    jifa_timer()
end
function jifa_timer() return create_timer_s('jifa', 0.4, 'jifa_timer_set') end
function jifa_timer_set()
    -- EnableTriggerGroup("check_busy",true)	
    exe('jifa jifa jifa')
end
function busyok()
    EnableTriggerGroup("check_busy", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('jifa')
    EnableTimer('jifa', false)
    if busyhook == nil then busyhook = test end
    return busyhook()
end

waithook = test
function checkWait(func, sec)
    disWait()
    DeleteTriggerGroup("checkwait")
    create_trigger_t('checkwait1',
                     '^(> )*你把 "action" 设定为 "等待一下" 成功完成。$',
                     '', 'checkWaitOk')
    SetTriggerOption("checkwait1", "group", "checkwait")
    EnableTriggerGroup("checkwait", true)
    EnableTrigger("hp12", true)
    waithook = func
    if sec == nil then sec = 5 end
    return create_timer_s('waitimer', sec, 'wait_timer_set')
end
function wait_timer_set()
    -- EnableTriggerGroup("checkwait",true)
    exe('alias action 等待一下')
end
function checkWaitOk()
    EnableTriggerGroup("checkwait", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('waitimer
    EnableTimer('waitimer', false)
    if waithook == nil then waithook = test end
    return waithook()
end

nexthook = test
function checkNext(func)
    disWait()
    DeleteTriggerGroup("checknext")
    create_trigger_t('checknext1',
                     '^(> )*你把 "action" 设定为 "继续前进" 成功完成。$',
                     '', 'checkNextOk')
    SetTriggerOption("checknext1", "group", "checknext")
    EnableTriggerGroup("checknext", true)
    EnableTrigger("hp12", true)
    nexthook = func
    next_timer_set()
    return create_timer_s('nextimer', 0.5, 'next_timer_set')
end
function next_timer_set() exe('alias action 继续前进') end
function checkNextOk()
    EnableTriggerGroup("checknext", false)
    EnableTrigger("hp12", false)
    EnableTimer('nextimer', false)
    if nexthook == nil then nexthook = test end
    return nexthook()
end

function disWait()
    DeleteTriggerGroup("checkwait")
    DeleteTriggerGroup("check_bei")
    DeleteTriggerGroup("check_busy")
    DeleteTriggerGroup("check_halt")
    EnableTimer('waitimer', false)
    EnableTimer('jifa', false)
    EnableTimer('halt', false)
    EnableTimer('bei', false)
end
function resetWait()
    local t = GetTimerList()
    if t and type(t) == "table" then
        for k, v in pairs(GetTimerList()) do
            -- messageShow(v)
            if IsTimer(v) == 0 and GetTimerInfo(v, 6) and
                tonumber(GetTimerInfo(v, 3)) < tonumber(GetTimerInfo(v, 13)) then
                -- messageShow(v..' '..'设定时间:'..GetTimerInfo(v, 3)..'秒，下一次时间:'..GetTimerInfo(v, 13)..'秒。')
                ResetTimers()
                break
            end
        end
    end
end

function trans(num)
    local words = {}
    local i = 0
    num = string.gsub(num, "零十", "10 ");
    num = string.gsub(num, "零", "");
    num = string.gsub(num, "一", "1");
    num = string.gsub(num, "二", "2");
    num = string.gsub(num, "三", "3");
    num = string.gsub(num, "四", "4");
    num = string.gsub(num, "五", "5");
    num = string.gsub(num, "六", "6");
    num = string.gsub(num, "七", "7");
    num = string.gsub(num, "八", "8");
    num = string.gsub(num, "九", "9");
    i = string.find(num, "十")
    if i == 1 then
        num = string.gsub(num, "十", "10 ")
    else
        num = string.gsub(num, "十", "0 ")
    end
    num = string.gsub(num, "百", "00 ")
    num = string.gsub(num, "千", "000 ")
    num = string.gsub(num, "万", "0000 ")
    for w in string.gmatch(num, "(%w+)") do table.insert(words, w) end
    i = 0
    for p = 1, table.getn(words) do i = i + tonumber(words[p]) end
    return i
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

function isNil(p_str)
    if p_str == nil then return true end
    if type(p_str) ~= "string" then
        return false
    else
        p_str = Trim(p_str)
        if p_str == "" then
            return true
        else
            return false
        end
    end
end
function countR(p_number)
    local i = p_number or 10
    return function()
        i = i - 1
        return i
    end
end

function randomElement(p_set)
    local l_element

    if p_set and type(p_set) == "table" then
        local l_cnt = math.random(1, countTab(p_set))
        local l_i = 0
        for p, q in pairs(p_set) do
            l_element = q
            l_i = l_i + 1
            if l_i == l_cnt then return l_element end
        end
    else
        l_element = p_set
    end

    return l_element
end

function dzxy_trigger()
    DeleteTriggerGroup("dzxy")
    create_trigger_t('dzxy1',
                     "^>*\\s*你仰首望天，太阳挂在天空中，白云朵朵，阳光顺着云层的边缘洒下来，你觉得有些刺眼。",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy2',
                     "^>*\\s*你仰首望天，天上繁星点点，你体会出了星斗的移动与你所学的“斗转星移”有莫大的联系，却苦于实战经验不足，无法将你看到的东西与实际作战联系到一起。",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy3',
                     '^>*\\s*你把 "action" 设定为 "慕容斗转星移" 成功完成。',
                     '', 'dzxy_goon')
    create_trigger_t('dzxy4', "^>*\\s*你的内力不够。", '', 'dzxy_finish')
    create_trigger_t('dzxy5',
                     "^>*\\s*先从木桩上跳下来\\(down\\)再说吧！",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy6',
                     "^>*\\s*恭喜恭喜！你已经融会贯通了斗转星移的绝妙之处！",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy7',
                     "^>*\\s*你已经没有潜能来领悟学习斗转星移了。",
                     '', 'dzxy_finish')

    create_trigger_t('dzxy8',
                     "^>*\\s*你仰首望天，天上繁星点点，你顺着银河的方向看去，却发现部分的夜空被周围的树冠挡住了。",
                     '', 'dzxy_goon')
    SetTriggerOption("dzxy1", "group", "dzxy")
    SetTriggerOption("dzxy2", "group", "dzxy")
    SetTriggerOption("dzxy3", "group", "dzxy")
    SetTriggerOption("dzxy4", "group", "dzxy")
    SetTriggerOption("dzxy5", "group", "dzxy")
    SetTriggerOption("dzxy6", "group", "dzxy")
    SetTriggerOption("dzxy7", "group", "dzxy")
    SetTriggerOption("dzxy8", "group", "dzxy")
    EnableTriggerGroup("dzxy", false)
    DeleteTimer('mr_dzxy_timer')
    -- create_timer_m('mr_dzxy_timer',4,'dzxy_finish')
end

function checkdzxy()
    dis_all()
    tmp = {}
    -- jobTriggerDel()  
    job.name = 'heal'
    if skills["douzhuan-xingyi"] ~= nil then
        if skills["douzhuan-xingyi"].lvl > 130 and skills["douzhuan-xingyi"].lvl <
            170 then
            dzxy_level = 1 -- 慕容复开始(#3 w;jump liang;lingwu zihua)，可以到171级。
            return dzxy()
        end
        if skills["douzhuan-xingyi"].lvl > 170 and skills["douzhuan-xingyi"].lvl <
            200 then
            dzxy_level = 2 -- 还施水阁 去:sit chair;zhuan;n;lingwu miji 回:s;push shujia，可以到201级。
            return dzxy()
        end
        if skills["douzhuan-xingyi"].lvl > 200 and skills["douzhuan-xingyi"].lvl <
            hp.pot_max - 100 and
            (locl.time == "戊" or locl.time == "亥" or locl.time == "子" or
                locl.time == "丑") then
            dzxy_level = 3 -- 观星台 上去jump zhuang;look sky，下来jump down。只能晚上look sky。可以到N级。
            return dzxy()
        end
        messageShow(
            '任务监控：慕容领悟斗转星移条件不够！继续任务！',
            'white')
        print("dzxy_level:" .. dzxy_level)
    end

    return go(xueshan_finish_ask, '大雪山', '入幽口')
end
function open_dzxy_timer()
    return create_timer_m('mr_dzxy_timer', 4, 'dzxy_finish')
end
function dzxy()
    DeleteTemporaryTriggers()
    dzxy_trigger()

    if dzxy_level == 1 then return check_busy(dzxy1_go) end
    if dzxy_level == 2 then return check_busy(dzxy2_go) end
    if dzxy_level == 3 then return check_busy(dzxy3_go) end
end
function dzxy1_go()
    messageShow('任务监控：去慕容领悟字画去了！', 'white')
    go(dzxy1_unwield, '燕子坞', '碧水厅')
end
function dzxy2_go()
    messageShow('任务监控：去慕容领悟秘籍去了！', 'white')
    go(dzxy2_unwield, '燕子坞', '还施水阁')
end
function dzxy3_go()
    messageShow('任务监控：去慕容看星星去了！', 'white')
    go(dzxy3_unwield, '燕子坞', '观星台')
end
function dzxy1_unwield()
    flag.idle = 0
    -- open_dzxy_timer()
    weapon_unwield()
    exe('jump liang')
    return check_busy(dzxy_goon)
end
function dzxy2_unwield()
    flag.idle = 0
    -- open_dzxy_timer()
    weapon_unwield()
    return check_busy(dzxy_goon)
end
function dzxy3_unwield()
    flag.idle = 0
    -- open_dzxy_timer()
    weapon_unwield()
    exe('jump zhuang')
    return check_busy(dzxy_goon)
end

function dzxy_goon()
    -- EnableTimer('mr_dzxy_timer',true)
    if not (locl.room == "观星台" or locl.room == "还施水阁" or locl.room ==
        "梁上") then
        messageShow(
            "慕容领悟：斗转星移的位置不对！当前位置：" ..
                locl.room)
        return dzxy_finish()
    end
    EnableTriggerGroup("dzxy", true)
    weaponWieldLearn()
    if not skills["douzhuan-xingyi"] or skills["douzhuan-xingyi"].lvl == 0 or
        skills["douzhuan-xingyi"].lvl >= hp.pot_max - 100 then
        messageShow(
            "慕容领悟：斗转星移的等级不对！当前等级：" ..
                skills["douzhuan-xingyi"].lvl)
        return check_busy(dzxy_finish)
    end
    if flag.idle > 7 then return check_busy(dzxy_finish) end
    if hp.neili < hp.neili_max * 0.5 then
        messageShow(
            "慕容领悟：斗转星移的内力不够！当前内力【" ..
                hp.neili .. "】", 'white')
        return check_busy(dzxy_finish)
    else
        if dzxy_level == 1 then
            exe('hp;yun jing;#10(lingwu zihua)')
            -- EnableTimer('mr_dzxy_timer',false)
            return check_bei(dzxy_alias, 1)
        end
        if dzxy_level == 2 then
            exe('hp;yun jing;#10(lingwu miji)')
            -- EnableTimer('mr_dzxy_timer',false)
            return check_bei(dzxy_alias, 1)
        end
        if dzxy_level == 3 then
            exe('hp;yun jing;#7(look sky)')
            -- EnableTimer('mr_dzxy_timer',false)
            return check_bei(dzxy_alias, 1)
        end
    end
end
function dzxy_alias() exe('alias action 慕容斗转星移') end

function dzxy_finish()
    EnableTimer('mr_dzxy_timer', false)
    DeleteTimer("mr_dzxy_timer")
    messageShow('任务监控：慕容斗转星移完成！')
    exe('jump down')
    EnableTriggerGroup("dzxy", false)
    DeleteTriggerGroup("dzxy")
    exe('cha;hp')
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('unwield ' .. leweapon)
    exe('jump down')
    return go(xueshan_finish_ask, '大雪山', '入幽口')
end
-----自动练功机器人----
function dazuo_lianxi_auto()

    tmp_lxskill = 'bei none;'
    for p in pairs(Bag) do
        if Bag[p].kind then
            local _, l_cnt = isInBags(Bag[p].fullid)
            for i = 1, l_cnt do
                tmp_lxskill =
                    tmp_lxskill .. 'unwield ' .. Bag[p].fullid .. ' ' .. i ..
                        ';'
            end
        end
    end
    lianxi_times = GetVariable('mycishu')
    for p in pairs(skills) do
        if (skillEnable[p] and skills[p].lvl < hp.pot_max - 100) or
            (skillEnable[p] and skills[p].lvl == hp.pot_max - 100 and
                skills[p].pot < (skills[p].lvl + 1) ^ 2) then
            if skillEnable[p] == "force" then
                tmp_lxskill = tmp_lxskill .. 'lian force ' .. lianxi_times ..
                                  ';'
            end
            if skillEnable[p] == "dodge" then
                tmp_lxskill = tmp_lxskill .. 'jifa dodge ' .. p ..
                                  ';lian dodge ' .. lianxi_times ..
                                  ';yun jingli;'
            end
            if skillEnable[p] == "finger" then
                tmp_lxskill = tmp_lxskill .. 'jifa finger ' .. p ..
                                  ';lian finger ' .. lianxi_times ..
                                  ';yun jingli;'
            end
            if skillEnable[p] == "cuff" then
                tmp_lxskill =
                    tmp_lxskill .. 'jifa cuff ' .. p .. ';lian cuff ' ..
                        lianxi_times .. ';yun jingli;'
            end
            if skillEnable[p] == "strike" then
                tmp_lxskill = tmp_lxskill .. 'jifa strike ' .. p ..
                                  ';lian strike ' .. lianxi_times ..
                                  ';yun jingli;'
            end
            if skillEnable[p] == "hand" then
                tmp_lxskill =
                    tmp_lxskill .. 'jifa hand ' .. p .. ';lian hand ' ..
                        lianxi_times .. ';yun jingli;'
            end
            if skillEnable[p] == "leg" then
                tmp_lxskill = tmp_lxskill .. 'lian leg ' .. lianxi_times ..
                                  ';yun jingli;'
            end
            if skillEnable[p] == "sword" then
                tmp_lxskill = tmp_lxskill .. 'jifa sword ' .. p ..
                                  ';wield sword;uweapon shape sword sword;lian sword ' ..
                                  lianxi_times .. ';unwield sword;yun jingli;'
            end
            if skillEnable[p] == "whip" then
                tmp_lxskill = tmp_lxskill ..
                                  'wield whip;uweapon shape whip whip;lian whip ' ..
                                  lianxi_times .. ';unwield whip;yun jingli;'
            end
            if skillEnable[p] == "axe" then
                tmp_lxskill = tmp_lxskill .. 'wield axe;lian axe ' ..
                                  lianxi_times .. ';unwield axe;yun jingli;'
            end
            if skillEnable[p] == "claw" then
                tmp_lxskill =
                    tmp_lxskill .. 'jifa claw ' .. p .. ';lian claw ' ..
                        lianxi_times .. ';yun jingli;'
            end
            if skillEnable[p] == "throwing" then
                tmp_lxskill = tmp_lxskill .. 'wield coin;lian throwing ' ..
                                  lianxi_times .. ';unwield coin;yun jingli;'
            end
            if skillEnable[p] == "blade" then
                tmp_lxskill = tmp_lxskill .. 'jifa blade ' .. p ..
                                  ';wield blade;uweapon shape blade blade;lian blade ' ..
                                  lianxi_times .. ';unwield blade;yun jingli;'
            end
            if skillEnable[p] == "stick" then
                tmp_lxskill = tmp_lxskill .. 'wield stick;lian stick ' ..
                                  lianxi_times .. ';unwield stick;yun jingli;'
            end
            if skillEnable[p] == "staff" then
                tmp_lxskill = tmp_lxskill .. 'wield staff;lian staff ' ..
                                  lianxi_times .. ';unwield staff;yun jingli;'
            end
            if skillEnable[p] == "club" then
                tmp_lxskill = tmp_lxskill .. 'wield club;lian club ' ..
                                  lianxi_times .. ';unwield club;yun jingli;'
            end
            if skillEnable[p] == "hammer" then
                tmp_lxskill = tmp_lxskill ..
                                  'wield hammer;uweapon shape hammer hammer;lian hammer ' ..
                                  lianxi_times .. ';unwield hammer;yun jingli;'
            end
            if skillEnable[p] == "hook" then
                tmp_lxskill = tmp_lxskill .. 'wield hook;lian hook ' ..
                                  lianxi_times .. ';unwield hook;yun jingli;'
            end
            if skillEnable[p] == "dagger" then
                tmp_lxskill = tmp_lxskill ..
                                  'wield dagger;uweapon shape dagger dagger;lian dagger ' ..
                                  lianxi_times .. ';unwield dagger;yun jingli;'
            end
        end
    end
    if weapon.first and Bag[weapon.first] then
        tmp_lxskill = tmp_lxskill .. 'wield ' .. Bag[weapon.first].fullid .. ';'
    end
    tmp_lxskill = tmp_lxskill .. 'hp;unset 积蓄;bei finger;i'
end
function set_sxlian()
    dazuo_lianxi_auto()
    create_alias('sx1lian', 'sx1lian', 'alias sxlian ' .. tmp_lxskill)
    Execute('sx1lian')
end
function weapon_lost()
    DeleteTriggerGroup("weapon_lose")
    create_trigger_t('weapon_lose1',
                     "^>*\\s*哈士奇一转眼就跑没影儿了，一会给你叼来了一柄(\\D*)，然后不知道跑哪去了。",
                     '', 'weapon_found')
    create_trigger_t('weapon_lose2',
                     "^>*\\s*哈士奇呆呆地瞪着你，好象很不高兴的样子。",
                     '', 'weapon_no_found')
    create_trigger_t('weapon_lose3',
                     "^>*\\s*你的状态不稳定，请稍候。", '',
                     'weapon_no_found')
    SetTriggerOption("weapon_lose1", "group", "weapon_lose")
    SetTriggerOption("weapon_lose2", "group", "weapon_lose")
    SetTriggerOption("weapon_lose3", "group", "weapon_lose")
    EnableTriggerGroup("weapon_lose", true)
    return go(weapon_lost_get, '扬州城', '当铺')
end

function weapon_lost_get()
    exe('duihuan husky')
    exe('save')
end
function weapon_no_found()
    check_halt(BQuit)
    exe('drink jiudai')
end
function weapon_found()
    EnableTriggerGroup("weapon_lose", false)
    scrLog()
    messageShow('武器丢失，兑换哈士奇找回！', 'red')
    return check_busy(weapon_found_get)
end
function weapon_found_get()
    exe('get all')
    return check_halt(check_food)
end
function kedian_sleep()
    if locl.area == '长安城' then
        exe('up;n;sleep')
    else
        exe('up;enter;sleep')
    end
    locate()
    walk_wait()
end
function check_rope() go(get_rope, '华山', '寝室') end
function get_rope()
    exe('tell rope 交货')
    check_busy(checkPrepareOver)
end
function check_key() go(get_juhua, '扬州城', '个园') end
function get_juhua()
    exe('tell daisy 交货')
    go(get_key, '扬州城', '小盘古')
end
function get_key()
    exe('give juyou ye juhua')
    check_busy(checkPrepareOver)
end
-----------自动抓雪蛛by桃花岛无法风2019.3.16----------
function check_xuezhu_status()
    local xuezhu_status = GetVariable("xuezhu_status")
    if xuezhu_status == nil then
        messageShow(
            '未找到雪蛛变量：xuezhu_status，请尽快设置！',
            'white', 'black')
    elseif xuezhu_status == "0" then
        messageShow(
            '本周还未抓到雪蛛，启动自动抓雪蛛机器人，前往抓雪蛛！',
            'white', 'black')
        return xuezhu_status
    elseif xuezhu_status == "1" then
        messageShow('已问程灵素要了真丹，现在前往抓雪蛛！',
                    'white', 'black')
        return xuezhu_status
    elseif xuezhu_status == "-1" then
        messageShow(
            '程灵素给了假丹，小贱人！怒！！！现在前往抓雪蛛！',
            'white', 'black')
        return xuezhu_status
    end
end
function xuezhuTrigger()
    DeleteTriggerGroup("xuezhuAsk")
    create_trigger_t('xuezhuAsk1',
                     "^(> )*你向程灵素打听有关『五毒教』的消息",
                     '', 'xuezhuAsk')
    create_trigger_t('xuezhuAsk2', "^(> )*这里没有这个人。$", '',
                     'xuezhuNobody')
    SetTriggerOption("xuezhuAsk1", "group", "xuezhuAsk")
    SetTriggerOption("xuezhuAsk2", "group", "xuezhuAsk")
    EnableTriggerGroup("xuezhuAsk", false)
    DeleteTriggerGroup("xuezhuAccept")
    create_trigger_t('xuezhuAccept1',
                     "^(> )*程灵素说道：「五毒教的禁地种满了各种奇花异草，其中大部分具有巨毒\\D*",
                     '', 'xuezhuAccept')
    create_trigger_t('xuezhuAccept2',
                     "^(> )*你获得一颗九雪碧云丹。$", '', 'eatDan')
    create_trigger_t('xuezhuAccept3',
                     "^(> )*你把一颗九雪碧云丹，轻轻咬碎含进嘴里，顿觉神明意朗，脸色红润。$",
                     '', 'xuezhu_go')
    create_trigger_t('xuezhuAccept4',
                     "^(> )*程灵素说道：「你上次答应我的事情还没做\\D*",
                     '', 'fakeDan')
    SetTriggerOption("xuezhuAccept1", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept2", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept3", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept4", "group", "xuezhuAccept")
    EnableTriggerGroup("xuezhuAccept", false)
    DeleteTriggerGroup("xuezhuFight")
    create_trigger_t('xuezhuFight1',
                     '^(> )*你晃动了半天，发现什麽也没有。', '',
                     'xuezhuFail')
    create_trigger_t('xuezhuFight2',
                     '^(> )*你轻轻摇晃树藤，忽然掉下一只雪蛛。',
                     '', 'xuezhuFight')
    create_trigger_t('xuezhuFight3',
                     "^(> )*雪蛛神志迷糊，脚下一个不稳，倒在地上昏了过去。",
                     '', 'getxuezhu')
    create_trigger_t('xuezhuFight4',
                     "^(> )*你将雪蛛扶了起来背在背上。", '',
                     'givecheng')
    create_trigger_t('xuezhuFight5',
                     "^(> )*雪蛛「啪」的一声倒在地上，挣扎着抽动了几下就死了。",
                     '', 'xuezhuFail')
    create_trigger_t('xuezhuFight6',
                     "^(> )*(你附近没有这样东西。|雪蛛突然蹿到地上不见了。)",
                     '', 'xuezhuFail')
    -- create_trigger_t('xuezhuFight6',"^(> )*雪蛛突然蹿到地上不见了。",'','xuezhuFail')
    SetTriggerOption("xuezhuFight1", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight2", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight3", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight4", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight5", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight6", "group", "xuezhuFight")
    EnableTriggerGroup("xuezhuFight", false)
    DeleteTriggerGroup("xuezhuFinish")
    create_trigger_t('xuezhuFinish1',
                     '^(> )*程灵素说道：「你果然言而有信，下次你要再去五毒教来找我吧。」',
                     '', 'xuezhuFinish')
    SetTriggerOption("xuezhuFinish1", "group", "xuezhuFinish")
    EnableTriggerGroup("xuezhuFinish", false)
end
function xuezhuTriDel()
    dis_all()
    DeleteTriggerGroup("xuezhuAsk")
    DeleteTriggerGroup("xuezhuAccept")
    DeleteTriggerGroup("xuezhuFight")
    DeleteTriggerGroup("xuezhuFinish")
end
function getxuezhu0()
    xuezhuTrigger()
    if inwdj == 0 then
        messageShow('抓雪蛛：苗疆地图不可到达，任务放弃。',
                    "Plum")
        SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepare)
    end
    go(askcheng, '苗疆', '药王居')
end
function getxuezhu1()
    xuezhuTrigger()
    xuezhu_go()
end
function askcheng()
    EnableTriggerGroup("xuezhuAsk", true)
    EnableTriggerGroup("xuezhuAccept", true)
    exe('ask cheng about 五毒教')
    create_timer_s('walkWait4', 3.0, 'askcheng1')
end
function askcheng1() exe('ask cheng about 五毒教') end
function xuezhuAsk()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuezhuAsk", false)
end
function xuezhuAccept()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    wait.make(function()
        wait.time(2)
        exe('yes')
    end)
    SetVariable("xuezhu_status", "1")
end
function eatDan()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    exe('fu dan')
    create_timer_s('walkWait4', 1.0, 'eatDan1')
end
function eatDan1() exe('fu dan') end
function fakeDan()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    SetVariable("xuezhu_status", "-1")
    return xuezhu_go()
end
function xuezhu_go()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    if not Bag["火折"] and drugPrepare["火折"] then
        if locl.weekday == '四' and locl.hour == 8 then
            return checkPrepareOver()
        else
            return checkFire()
        end
    end
    if inwdj == 0 then
        messageShow('抓雪蛛：苗疆山洞不可到达，任务放弃。',
                    "Plum")
        SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepare)
    end
    EnableTriggerGroup("xuezhuAccept", false)
    go(yaoshuteng, '苗疆', '山洞')
end
function yaoshuteng()
    EnableTriggerGroup("xuezhuFight", true)
    exe('fang dfly;dian fire;yao shuteng')
    create_timer_st('walkWait4', 3.0, 'yaoshuteng1')
end
function yaoshuteng1() exe('fang dfly;dian fire;yao shuteng') end
function xuezhuFail()
    xuezhuTriDel()
    messageShow('雪蛛不在，一会再来抓！', 'white', 'black')
    return checkPrepareOver()
end
--[[function xuezhuFail1()
	xuezhuTriDel()
	messageShow('雪蛛被你打死了，请查看log！','white','black')
	scrLog()
	return checkPrepareOver()
end
function xuezhuFail2()
	xuezhuTriDel()
	messageShow('雪蛛自己跑了或被人抓走了，请查看log！','white','black')
	scrLog()
	return checkPrepareOver()
end]]
function xuezhuFight()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    wait.make(function()
        wait.time(3)
        weapon_unwield()
        exe('unset wimpy;wield mu jian;jiali 100;hit xue zhu')
    end)
end
function getxuezhu() exe('get xue zhu') end
function givecheng()
    EnableTriggerGroup("xuezhuFinish", true)
    go(givexuezhu, '苗疆', '药王居')
end
function givexuezhu()
    exe('give cheng xue zhu')
    create_timer_st('walkWait4', 1.0, 'givexuezhu1')
end
function givexuezhu1() exe('give cheng xue zhu') end
function xuezhuFinish()
    local x = GetVariable("xuezhu_status")
    if x == '-1' then SetVariable("xuezhu_status", "0") end
    if x == '1' then
        SetVariable("xuezhu_status", "2")
        messageShow('本周已成功抓到雪蛛，请安心游戏！：)',
                    'red', 'black')
    end
    xuezhuTriDel()
    return checkPrepareOver()
end
-----------自动抓雪蛛by桃花岛无法风2019.3.16----------
function reboot_before_cun()
    flag.cun = true
    wait.make(function()
        wait.time(3)
        cun_shengzi()
    end)
end
function cun_shengzi()
    exe('cun sheng zi')
    return check_busy(cun_shengzi1, 3)
end
function cun_shengzi1()
    exe('cun cu shengzi')
    return check_busy(cun_fire, 3)
end
function cun_fire()
    exe('cun fire')
    return check_busy(cun_save, 3)
end
function cun_save()
    exe('save;n;n;n')
    return prepare_lianxi()
end
----正负神转换----
function turnShen(x)
    if x and x == '+' then
        if hp.shen <= -10000 then
            if job.zuhe["wudang"] then
                job.zuhe["wudang"] = job.zuhe["xueshan"]
            end
            return xueshan()
        end
        if hp.shen > -10000 and hp.shen <= 20000 then
            if job.zuhe["wudang"] then return checkZqd() end
        end
    end
    if x and x == '-' then
        if hp.shen >= 10000 then
            if job.zuhe["xueshan"] then
                job.zuhe["xueshan"] = job.zuhe["wudang"]
            end
            return wudang()
        end
        if hp.shen > -10000 and hp.shen < 10000 then
            if job.zuhe["xueshan"] then return checkXqw() end
        end
    end
end
--------------检查锦盒-------------
jinheTrigger = function()
    DeleteTriggerGroup("jinheTrigger")
    create_trigger_t('jinheTrigger1',
                     "^>*\\s*你看了半天，也没有明白这盒子到底是怎么回事。",
                     '', 'jinhe_goon')
    create_trigger_t('jinheTrigger2',
                     "^>*\\s*盒子的夹层已经打开，你可以仔细看盒子（look jinhe）然后采取相应行动。",
                     '', 'jinhe_find')
    create_trigger_t('jinheTrigger3',
                     "^>*\\s*吾纵横江湖时曾在(\\D*)留下些许物事，待有缘人前去挖掘",
                     '', 'jinhe_get')
    SetTriggerOption("jinheTrigger1", "group", "jinheTrigger")
    SetTriggerOption("jinheTrigger2", "group", "jinheTrigger")
    SetTriggerOption("jinheTrigger3", "group", "jinheTrigger")
    EnableTriggerGroup("jinheTrigger", true)
    exe('jiancha jinhe')
end
jinhe_goon = function() exe('jiancha he') end
function jinhe_get(n, l, w)
    jinhe_dd = tostring(w[1])
    exe('sz ' .. jinhe_dd)
    EnableTriggerGroup("jinheTrigger", false)
    DeleteTriggerGroup("jinheTrigger")
end
jinhe_find = function() exe('look he') end
-----兑换红蓝石头----
function stoneSet()
    stonePrepare = {}
    local t = {["赤晶石"] = "赤晶石", ["海蓝石"] = "海蓝石"}
    if GetVariable("stoneprepare") then
        tmp.stone = utils.split(GetVariable("stoneprepare"), '|')
        tmp.pre = {}
        for _, p in pairs(tmp.stone) do tmp.pre[p] = true end
    end
    local l_tmp = utils.multilistbox(
                      "你准备吃的石头(请按CTRL多选)是?",
                      "物品组合", t, tmp.pre)
    local l_result = nil
    for p in pairs(l_tmp) do
        stonePrepare[p] = true
        if l_result then
            l_result = l_result .. '|' .. p
        else
            l_result = p
        end
    end
    if isNil(l_result) then
        DeleteVariable("stoneprepare")
    else
        SetVariable("stoneprepare", l_result)
    end
    l_result = utils.inputbox("你兑换石头的次数是？", "stonecishu",
                              GetVariable("stonecishu"), "宋体", "12")
    if not isNil(l_result) then SetVariable("stonecishu", l_result) end
end
function stoneGetVar()
    stonePrepare = {}
    if GetVariable("stoneprepare") then
        tmp.stone = utils.split(GetVariable("stoneprepare"), '|')
        for _, p in pairs(tmp.stone) do stonePrepare[p] = true end
    end
    return duihuan_Stone()
end
function duihuan_Stone()
    if MidNight[locl.time] then
        ColourNote("red", "blue",
                   "珠宝店关门，无法卖石头，请过一阵再尝试！")
    else
        return go(duihuan_prepare, '扬州城', '当铺')
    end
end
function duihuan_prepare()
    tmp.redstone = 0
    tmp.bluestone = 0
    flag.redstone = false
    flag.bluestone = false
    flag.duihuan = 0
    DeleteTriggerGroup("duihuanstone")
    create_trigger_t('duihuanstone1',
                     "^(> )*当铺老板吆喝一声：" .. score.name ..
                         "兑换限制级宝物(赤晶石|海蓝石).*", '',
                     'stone_consider')
    create_trigger_t('duihuanstone2',
                     "^(> )*朱老板一把抓过(赤晶石|海蓝石)道：“哇，好东西呀！”",
                     '', 'maistone_set')
    create_trigger_t('duihuanstone3',
                     "^(> )*你还是多努力一段时间吧。", '',
                     'duihuan_done')
    create_trigger_t('duihuanstone4',
                     "^(> )*你先要用完现有的物品才能再次兑换。",
                     '', 'check_stoneT')
    SetTriggerOption("duihuanstone1", "group", "duihuanstone")
    SetTriggerOption("duihuanstone2", "group", "duihuanstone")
    SetTriggerOption("duihuanstone3", "group", "duihuanstone")
    SetTriggerOption("duihuanstone4", "group", "duihuanstone")
    return duihuanStone()
end
function duihuanStone()
    if stonePrepare["赤晶石"] and tmp.redstone <
        tonumber(GetVariable("stonecishu")) then
        flag.duihuan = 1
        exe('duihuan redstone')
    end
    return check_busy(duihuanStone1, 3)
end
function duihuanStone1()
    if stonePrepare["海蓝石"] and tmp.bluestone <
        tonumber(GetVariable("stonecishu")) then
        flag.duihuan = 2
        exe('duihuan bluestone')
    end
end
function stone_consider(n, l, w)
    local x = tostring(w[2])
    if x == '赤晶石' then
        flag.redstone = true
        tmp.redstone = tmp.redstone + 1
    end
    if x == '海蓝石' then
        flag.bluestone = true
        tmp.bluestone = tmp.bluestone + 1
    end
    return stone_consider_go()
end
function stone_consider_go()
    if stonePrepare["赤晶石"] and stonePrepare["海蓝石"] and flag.redstone and
        flag.bluestone then return check_busy(mai_stone, 3) end
    if stonePrepare["赤晶石"] and not stonePrepare["海蓝石"] and
        flag.redstone then return check_busy(mai_stone, 3) end
    if not stonePrepare["赤晶石"] and stonePrepare["海蓝石"] and
        flag.bluestone then return check_busy(mai_stone, 3) end
end
function duihuan_done()
    if stonePrepare["赤晶石"] and stonePrepare["海蓝石"] then
        if flag.duihuan == 1 then
            stonePrepare["赤晶石"] = false
            tmp.redstone = tonumber(GetVariable("stonecishu"))
            return
        end
        if flag.duihuan == 2 then
            stonePrepare["海蓝石"] = false
            tmp.bluestone = tonumber(GetVariable("stonecishu"))
        end
    end
    if stonePrepare["赤晶石"] and not stonePrepare["海蓝石"] then
        stonePrepare["赤晶石"] = false
        tmp.redstone = tonumber(GetVariable("stonecishu"))
        tmp.bluestone = tonumber(GetVariable("stonecishu"))
    end
    if not stonePrepare["赤晶石"] and stonePrepare["海蓝石"] then
        stonePrepare["海蓝石"] = false
        tmp.redstone = tonumber(GetVariable("stonecishu"))
        tmp.bluestone = tonumber(GetVariable("stonecishu"))
    end
    return check_stone()
end
function mai_stone() return go(mai_stone_check, "扬州城", "珠宝店") end
function mai_stone_check()
    if flag.redstone then exe('mai redstone') end
    if flag.bluestone and not flag.redstone then exe('mai bluestone') end
end
function maistone_set(n, l, w)
    if w[2] == '赤晶石' then flag.redstone = false end
    if w[2] == '海蓝石' then flag.bluestone = false end
    if flag.redstone or flag.bluestone then
        return check_busy(mai_stone)
    else
        return check_busy(check_stone)
    end
end
function check_stone()
    if tmp.redstone >= tonumber(GetVariable("stonecishu")) and tmp.bluestone >=
        tonumber(GetVariable("stonecishu")) then
        checkBags()
        wait.make(function()
            wait.time(2)
            return check_stone1()
        end)
    end
    return go(duihuanStone, "扬州城", "当铺")
end
function check_stone1()
    if Bag and Bag["赤晶石"] then flag.redstone = true end
    if Bag and Bag["海蓝石"] then flag.bluestone = true end
    if flag.redstone or flag.bluestone then
        return mai_stone()
    else
        ColourNote("red", "blue",
                   "您选择的石头到达兑换的极限，本次兑换完毕！")
        -- return checkPrepare()
    end
end
function check_stoneT()
    checkBags()
    wait.make(function()
        wait.time(2)
        return check_stone1()
    end)
end
-------明教讨教-----
function dnyTrigger()
    DeleteTriggerGroup("qk_dny")
    create_trigger_t('qk_dny1',
                     '^(> )*\\s*你把 "action" 设定为 "讨教大挪移中" 成功完成',
                     '', 'taoJiaozhang')
    create_trigger_t('qk_dny2', "^(> )*你现在正忙着呢。", '',
                     'taoJiaozhang')
    create_trigger_t('qk_dny3',
                     "^(> )*(由于实战经验不足，阻碍了你的「乾坤大挪移」进步！|什么?|你的内力不够)",
                     '', 'taojiao_over')
    create_trigger_t('qk_dny4',
                     "^(> )*你感觉全身气息翻腾，原来你真气不够，不能装备\\D*。",
                     '', 'taojiao_over')
    for i = 1, 4 do SetTriggerOption("qk_dny" .. i, "group", "qk_dny") end
    EnableTriggerGroup("qk_dny", false)
end
function check_dny() return go(taojiao_dny, "mingjiao/sht", '') end
function taojiao_dny()
    dnyTrigger()
    if locl.id[score.master] then
        EnableTriggerGroup("qk_dny", true)
        weaponWieldLearn()
        DoAfter(0.5, 'alias action 讨教大挪移中')
    else
        ColourNote("white", "blue", "师傅不在家！过一会儿再来吧！")
        return taojiao_over()
    end
end
function taoJiaozhang()
    flag.idle = nil
    EnableTriggerGroup("qk_dny", true)
    wait.make(function()
        wait.time(0.2)
        exe(
            '#8(taojiao qiankun-danuoyi);yun jing;alias action 讨教大挪移中')
    end)
end
function taojiao_over()
    messageShow('讨教乾坤大挪移完毕！')
    EnableTriggerGroup("qk_dny", false)
    DeleteTriggerGroup("qk_dny")
    weaponWieldLearn()
    dis_all()
    return check_busy(check_food)
end
function fightoverweapon()
    if GetVariable("recoveryweapon") then exe(GetVariable("recoveryweapon")) end
end
------扬州当铺兑换道具机器人 by如版.2019.11.09-----
function duihuanSomething()
    exe('score')
    tmp.duihuan = 0
    local l_result
    local l_duihuan
    local l_duihuanTimes
    l_result = utils.inputbox("你需要兑换的物品ID是", "duihuanID",
                              GetVariable("duihuanID"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("duihuanID", l_result)
        l_duihuan = l_result
        print(GetVariable("duihuanID"))
    end
    l_result = utils.inputbox("你需要兑换的次数", "duihuanTimes",
                              GetVariable("duihuanTimes"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("duihuanTimes", l_result)
        l_duihuanTimes = l_result
        print(GetVariable("duihuanTimes"))
    end
    DeleteTriggerGroup("duihuanSomething")
    create_trigger_t('duihuanSomething1',
                     "^(> )*当铺老板吆喝一声：" .. score.name ..
                         "兑换限制级宝物\\D*，收讫书剑通宝(\\D*)个*",
                     '', 'duihuanSomething_add')
    SetTriggerOption("duihuanSomething1", "group", "duihuanSomething")
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_add(n, l, w)
    tmp.duihuan = tmp.duihuan or 0
    tmp.duihuan = tmp.duihuan + 1
    print('本次兑换' .. tmp.duihuan .. '次')
    if tmp.duihuan >= tonumber(GetVariable("duihuanTimes")) then
        EnableTriggerGroup("duihuanSomething", false)
        DeleteTriggerGroup("duihuanSomething")
        return check_food()
    end
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_duihuan() exe('duihuan ' .. GetVariable("duihuanID")) end
-----扬州自动找徐霞客 by 无法风 2019.12.25------
xxkFind = function()
    DeleteTriggerGroup("xxkFind")
    create_trigger_t('xxkFind1', '^(> )*\\s*徐霞客\\(Xu xiake\\)', '',
                     'xxkFindFollow')
    create_trigger_t('xxkFind2', '^(> )*这里没有 xu xiake', '',
                     'xxkFindGoon')
    create_trigger_t('xxkFind3', '^(> )*你决定跟随\\D*一起行动。', '',
                     'xxkFindDone')
    create_trigger_t('xxkFind4', '^(> )*你已经这样做了。', '',
                     'xxkFindDone')
    SetTriggerOption("xxkFind1", "group", "xxkFind")
    SetTriggerOption("xxkFind2", "group", "xxkFind")
    SetTriggerOption("xxkFind3", "group", "xxkFind")
    SetTriggerOption("xxkFind4", "group", "xxkFind")
    EnableTriggerGroup("xxkFind", false)
    cntr1 = countR(20)
    job.name = "找徐霞客"
    return go(xxkFindFact, "扬州城", "城隍庙")
end
xxkFindFact = function()
    EnableTriggerGroup("xxkFind", true)
    exe('look')
    return find()
end
xxkFindFollow = function()
    flag.find = 1
    exe('follow xu xiake')
end
xxkFindGoon = function()
    flag.wait = 0
    flag.find = 0
    return walk_wait()
end
function xxkFindDone()
    DeleteTriggerGroup("xxkFind")
    ColourNote("red", "blue",
               "【已找到徐霞客这个狗头，请开始你的嘿嘿嘿……】")
    print("by 无法风 2019.12.25")
end
-----扬州自动找空空儿 by 无法风 2019.12.25------
kongkongFind = function()
    DeleteTriggerGroup("kkrFind")
    create_trigger_t('kkrFind1', '^.*空空儿\\(Kong kong\\)', '',
                     'kongkongFindFollow')
    create_trigger_t('kkrFind2', '^(> )*这里没有 kong kong', '',
                     'kongkongFindGoon')
    create_trigger_t('kkrFind3', '^(> )*你决定跟随\\D*一起行动。', '',
                     'kongkongFindDone')
    create_trigger_t('kkrFind4', '^(> )*你已经这样做了。', '',
                     'kongkongFindDone')
    SetTriggerOption("kkrFind1", "group", "kkrFind")
    SetTriggerOption("kkrFind2", "group", "kkrFind")
    SetTriggerOption("kkrFind3", "group", "kkrFind")
    SetTriggerOption("kkrFind4", "group", "kkrFind")
    EnableTriggerGroup("kkrFind", false)
    cntr1 = countR(20)
    job.name = "找空空儿"
    return go(kongkongFindFact, "扬州城", "小吃店")
end
kongkongFindFact = function()
    EnableTriggerGroup("kkrFind", true)
    exe('look')
    return find()
end
kongkongFindFollow = function()
    flag.find = 1
    exe('follow kong kong')
end
kongkongFindGoon = function()
    flag.wait = 0
    flag.find = 0
    return walk_wait()
end
function kongkongFindDone()
    DeleteTriggerGroup("kkrFind")
    ColourNote("red", "blue",
               "【已找到空空儿这个狗头，请开始你的嘿嘿嘿……】")
    print("by 无法风 2019.12.25")
end

