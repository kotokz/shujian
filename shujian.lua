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

-- ����һ����ͨ����
function create_alias(a_name, a_match, a_response)
    return AddAlias(a_name, a_match, a_response, alias_flag.Enabled +
                        alias_flag.Replace + alias_flag.RegularExpression, '')
end
-- ����һ���ű�����
function create_alias_s(a_name, a_match, a_function)
    return AddAlias(a_name, a_match, '',
                    alias_flag.Enabled + alias_flag.Replace, a_function)
end
-- ����һ���ֶ�ʱ��
function create_timer_m(t_name, t_min, t_function)
    return AddTimer(t_name, 0, t_min, 0, '', timer_flag.Enabled +
                        timer_flag.ActiveWhenClosed + timer_flag.Replace,
                    t_function)
end
-- ����һ���붨ʱ��
function create_timer_s(t_name, t_second, t_function)
    return AddTimer(t_name, 0, 0, t_second, '', timer_flag.Enabled +
                        timer_flag.ActiveWhenClosed + timer_flag.Replace,
                    t_function)
end
-- ����һ��һ�����붨ʱ��
function create_timer_st(t_name, t_second, t_function)
    return AddTimer(t_name, 0, 0, t_second, '',
                    timer_flag.Enabled + timer_flag.ActiveWhenClosed +
                        timer_flag.Replace + timer_flag.OneShot, t_function)
end
-- ����һ�������� 
function create_trigger_t(t_name, t_match, t_response, t_function)
    return AddTrigger(t_name, t_match, t_response, trigger_flag.Enabled +
                          trigger_flag.RegularExpression + trigger_flag.Replace,
                      -1, 0, "", t_function)
end
-- ����һ����ʱ�Ĵ����� 
function create_trigger_f(t_name, t_match, t_response, t_function)
    return AddTrigger(t_name, t_match, t_response,
                      trigger_flag.Enabled + trigger_flag.RegularExpression +
                          trigger_flag.Replace + trigger_flag.Temporary, -1, 0,
                      "", t_function)
end
-- ����һ����ʱ��һ���Դ����� 
function create_trigger(t_name, t_match, t_response, t_function)
    return AddTrigger(t_name, t_match, t_response,
                      trigger_flag.Enabled + trigger_flag.RegularExpression +
                          trigger_flag.Replace + trigger_flag.Temporary +
                          trigger_flag.OneShot, -1, 0, "", t_function)
end
-- ����һ��ex������ 
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
-- ����һ����ʱ�Ĵ����� 
function create_triggerex_f(t_name, t_match, t_response, t_function)
    return AddTriggerEx(t_name, t_match, t_response,
                        trigger_flag.Enabled + trigger_flag.RegularExpression +
                            trigger_flag.Replace + trigger_flag.Temporary, -1,
                        0, "", t_function, 12, 100)
end
-- ����һ����ʱ��һ���Դ����� 
function create_triggerex(t_name, t_match, t_response, t_function)
    return AddTriggerEx(t_name, t_match, t_response,
                        trigger_flag.Enabled + trigger_flag.RegularExpression +
                            trigger_flag.Replace + trigger_flag.Temporary +
                            trigger_flag.OneShot, -1, 0, "", t_function, 12, 100)
end
-- ����һ����ʱ��һ���Զ�ʱ��
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
go_on_smy = 0 -- 20161117���ӱ���go_on_smy���ؿ��� ��ֹϵͳ�������Զ�����Ħ��
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

SMYID = { -- �䵱ʧ�ܿ�����ɽ��id
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
    ["������Ϣ��"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["а����"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["��Ϣ��"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["��ʳ��"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["��ˮ��"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["��ҩ"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["�ƾ���"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["а����"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["����������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["���߲�����"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["����������"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["������Ϣ��"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["���ɽ�ҩ"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["��Ѫ�ƾ���"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["�ⶾ��"] = {"dali/yaopu", "zhiye/yaodian1"},
    ["�󻹵�"] = "city/dangpu",
    ["����"] = {"xueshan/laifu", "suzhou/baodaiqiao"},
    ["ţƤ�ƴ�"] = {"city/xiaochidian"}
}

drugPoison = {["�Ż���¶��"] = true}

-- ain

local cun_hammer = tonumber(GetVariable("autocun_hammer"))
if cun_hammer == 1 then
    itemSave = {
        ["���콳����ƪ"] = true,
        ["����������ƪ"] = true,
        ["Τ��֮��"] = true,
        ["������"] = true,
        ["������"] = true
    }
else
    itemSave = {
        ["���콳����ƪ"] = true,
        ["����������ƪ"] = true,
        ["Τ��֮��"] = true,
        ["������"] = true,
        ["������"] = true
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
    create_trigger_t('main', "^���齣\\D*��\\D*�Ѿ�����ִ����", '',
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
    create_trigger_t('login1', "^���ϴ����ߵ�ַ��", '', 'logincheck')
    create_trigger_t('login2',
                     "^����������������ʶ������\\(passwd\\)��",
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
        -- EnableTriggerGroup("hb_kill",true)--С�������ļ��Ľ�ɱ������
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
    if Trim(w[2]) == "����" then
        flag.yili = true
    elseif Trim(w[2]) == "�ر�" then
        flag.yili = false
    end
end
--[[function jifaOver()
    exe('jifa all')
end]]
function checkDebug()
    messageShow('���ж���!')
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
                   "����һ�����ɽ�ҩ����ʱ�о����ƺ��˲���") then
        cty_cur = cty_cur - 1
    end
    if string.find(l,
                   "����һ����Ϣ�裬��ʱ�������������˲���") then
        nxw_cur = nxw_cur - 1
    end
    if string.find(l, "����һ�Ŵ�����Ϣ�裬��ʱ�о���������") then
        cbw_cur = cbw_cur - 1
    end
    if string.find(l,
                   "����һ�Ż�����Ϣ������ʱ�о�����ĵ����ӯ�˲���") then
        hqd_cur = hqd_cur - 1
    end
    if string.find(l,
                   "����һ�Ż�Ѫ�ƾ�������ʱ�о���Ѫ������ʧ") then
        DeleteTimer("eatdan")
        hxd_cur = hxd_cur - 1
    end
    if string.find(l, "����һ�Ŵ󻹵���ʱ����Ȭ����Ѫ��ӯ") then
        messageShow('�Դ󻹵��ˣ�')
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
    return go(wuxingzhenCheck, '������', '�Է�')
end
function wuxingzhenCheck()
    if locl.id["�·�ɽ"] then
        return wuxingzhenStart()
    else
        local l_cnt = table.getn(getRooms('�Է�', '������'))
        flag.times = flag.times + 1
        if flag.times > l_cnt then
            return wuxingzhenFinish()
        else
            local l_sour = getRooms('�Է�', '������')[flag.times - 1]
            return go(wuxingzhenCheck, '������', '�Է�', l_sour)
        end
    end
end
function wuxingzhenStart()
    exe('yun jing')
    exe('ask wen fangshan about ������')
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
    if not locl.id["�·�ɽ"] or hp.pot < 10 then return wuxingzhenFinish() end
    return checkWait(wuxingzhenStart, 0.5)
end
function wuxingzhenFinish() return check_heal() end

function checkPrepare()
    EnableTriggerGroup("poison", false)
    DeleteTriggerGroup("poison")

    if g_stop_flag == true then
        print("�����������Ϸ��ͣ")
        g_stop_flag = false
        return disAll()
    end
    drugPrepare = drugPrepare or {}
    exe('hp')
    if hp.exp < 150000 then return checkPrepareOver() end
    if hp.food < 40 or hp.water < 40 then return check_food() end
    if hp.jingxue_per < 90 or hp.qixue_per < 60 then return check_heal() end
    if Bag["����"] then return tiaoshui() end

    if Bag and Bag["����"] and Bag["����"].cnt and
        (Bag["����"].cnt > 100 or Bag["����"].cnt < 50) then
        return check_gold()
    end
    if (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt >
            count.gold_max * 4) then return check_gold() end
    if score.gold and score.gold > 100 and nxw_cur < 5 and
        drugPrepare["��Ϣ��"] then return checkNxw() end
    if score.gold and score.gold > 100 and cbw_cur < 5 and
        drugPrepare["������Ϣ��"] then return checkNxw() end

    if score.gold and score.gold > 100 and hqd_cur < 5 and
        drugPrepare["������Ϣ��"] then return checkNxw() end

    if score.gold and score.gold > 100 and cty_cur < 5 and
        drugPrepare["���ɽ�ҩ"] then return checkHxd() end

    --[[if job.zuhe["wudang"] and job.zuhe["xueshan"] and job.last=="wudang" and (not Bag["а����"] or Bag["а����"].cnt<2) then
       return checkXqw()
	end
	
	if job.zuhe["wudang"] and job.zuhe["xueshan"] and job.last=="wudang" and (not Bag["������"] or Bag["������"].cnt<2) then
       return checkZqd()
	end
	
	if job.zuhe["huashan"] and job.zuhe["xueshan"] and job.last=="huashan" and (not Bag["а����"] or Bag["а����"].cnt<2) then
       return checkXqw()
	end
	
	if job.zuhe["huashan"] and job.zuhe["xueshan"] and job.last=="huashan" and (not Bag["������"] or Bag["������"].cnt<2) then
       return checkZqd()
	end]]

    if not flag.item then
        if score.party and score.party == "������" and not Bag["����"] then
            return check_item()
        end
        if score.party == "������" and not Bag["����"] and
            not Bag["����"] then return check_item() end
    end
    if locl.weekday == '��' and locl.hour == 8 then
        print(
            '�ܿ����ķ����������߷壬�����ۺ;ƴ�����ʱ��һСʱ��')
    else
        if not Bag["����"] and drugPrepare["����"] then
            return checkFire()
        end

        if not Bag["ţƤ�ƴ�"] and drugPrepare["ţƤ�ƴ�"] then
            return checkJiudai()
        end
    end
    if score.gold and score.gold > 100 and hxd_cur < 3 and
        drugPrepare["��Ѫ�ƾ���"] then return checkLjd() end

    if score.tb and score.tb > 100 and dhd_cur < 1 and drugPrepare["�󻹵�"] then
        return checkdhd()
    end

    for p in pairs(weaponPrepare) do
        if weaponStore[p] and not Bag[p] and Bag["�ƽ�"].cnt > 3 then
            return checkWeapon(p)
        end
        if weaponFunc[p] and not Bag[p] then
            return _G[weaponFuncName[p]]()
        end
        if weaponPrepare["����"] and Bag["ö����"].cnt < 100 then
            return checkWeapon("����")
        end
    end
    local l_cut = false
    for p in pairs(Bag) do
        if weaponKind[Bag[p].kind] and weaponKind[Bag[p].kind] == "cut" then
            l_cut = true
        end
    end
    if not l_cut and not Bag["ľ��"] then
        weaponPrepare["ľ��"] = true
        return checkWeapon("ľ��")
    end

    if Bag["Τ��֮��"] then return checkHammer() end

    for p in pairs(Bag) do
        if Bag[p] and itemSave[p] then return checkYu(p) end
        if Bag[p].id and Bag[p].id["yu"] and string.find(p, "��") then
            return checkYu(p)
        end
        if Bag[p].id and Bag[p].id["jintie chui"] and
            string.find(p, "������") then return checkYu(p) end
        if Bag[p].id and Bag[p].id["shentie chui"] and
            string.find(p, "������") then return checkYu(p) end
    end
    exe('wear all')

    if needjinchai == 1 then return go(getchai, "���ݳ�", "�ӻ���") end

    if xuezhu_require == 1 then
        if GetVariable("xuezhu_status") ~= nil and GetVariable("xuezhu_status") ==
            '2' then
            SetVariable("xuezhu_status", "0") -- ����֮���ʼ���Զ�ץѩ�����Ϊ0
        end
        if GetVariable("xuezhu_status") ~= nil and GetVariable("xuezhu_status") ==
            '1' then
            SetVariable("xuezhu_status", "-1") -- �������Ҫ���浤��δ��ѩ�룬����֮���ʼ���Զ�ץѩ�����Ϊ-1
        end
        xuezhu_require = 0
    end

    local x = check_xuezhu_status()
    if x == '0' then return getxuezhu0() end
    if x == '-1' or x == '1' then return getxuezhu1() end

    if Bag and Bag["Ұ�ջ�"] and not Bag["ͭԿ��"] then
        return go(get_key, '���ݳ�', 'С�̹�')
    end
    --[[if Bag and not Bag["ͭԿ��"] then
	   return check_key()
	end
	if Bag and not Bag["����"] then
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
        if needxuexi ~= 1 then messageShow('����Ҫѧϰ') end
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
                     '^(> )*�����ϰ�Ϊ����Ǯׯ�д���(\\D*)���ƽ�',
                     '', 'vip_gold')
    create_trigger_t('askfuli2',
                     '^(> )*����ʺ�������(\\D*)��ͨ����', '',
                     'vip_tongbao')
    create_trigger_t('askfuli3', '^(> )*��������(\\D*)��������Ϊ��',
                     '', 'vip_neili')
    SetTriggerOption("askfuli1", "group", "vipfuli")
    SetTriggerOption("askfuli2", "group", "vipfuli")
    SetTriggerOption("askfuli3", "group", "vipfuli")
    return go(askfuli1, "���ݳ�", "����")
end
function askfuli1()
    wait.make(function()
        wait.time(1)
        exe('ask laoban about ��Ա����')
        return check_busy(askfuli2)
    end)
end
function askfuli2()
    exe('ask laoban about ��Ա����')
    wait.make(function()
        wait.time(2)
        return check_busy(checkPrepare)
    end)
end
function vip_gold(n, l, w)
    EnableTriggerGroup("vipfuli", false)
    DeleteTriggerGroup("vipfuli")
    messageShow(
        'ÿ�ܻ�Ա������   �����ϰ�Ϊ����Ǯׯ�д��롾' ..
            w[2] .. '�����ƽ�', 'gold', 'black')
end
function vip_tongbao(n, l, w)
    messageShow('ÿ�ܻ�Ա������   ����ʺ������ˡ�' .. w[2] ..
                    '����ͨ����', 'red', 'black')
end
function vip_neili(n, l, w)
    messageShow('ÿ�ܻ�Ա������   �������ˡ�' .. w[2] ..
                    '����������Ϊ��', 'blue', 'black')
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
                         '^(> )*(�������Ѿ����|����׼����һ�ּ�����|�����ٲ���������ȭ�ż��ܵ�����֮һ)',
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
                     "^(> )*(�������Ѿ����|����׼����һ�ּ�����|�����ٲ���������ȭ�ż��ܵ�����֮һ)",
                     '', 'beiok')
    create_trigger_t('check_bei2',
                     "^(> )*������û�м����κ���Ч���⼼�ܡ�",
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
                     "^>*\\s*(�����ڲ�æ��|���������һԾ������սȦ�����ˡ�)",
                     '', 'haltok')
    create_trigger_t('check_halt2', "^>*\\s*�����ں�æ��ͣ��������",
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
    if locl.room == "ϴ��ر�" then
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
    create_trigger_t('check_busy1', "^>*\\s*û������������࣬��", '',
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
                     '^(> )*��� "action" �趨Ϊ "�ȴ�һ��" �ɹ���ɡ�$',
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
    exe('alias action �ȴ�һ��')
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
                     '^(> )*��� "action" �趨Ϊ "����ǰ��" �ɹ���ɡ�$',
                     '', 'checkNextOk')
    SetTriggerOption("checknext1", "group", "checknext")
    EnableTriggerGroup("checknext", true)
    EnableTrigger("hp12", true)
    nexthook = func
    next_timer_set()
    return create_timer_s('nextimer', 0.5, 'next_timer_set')
end
function next_timer_set() exe('alias action ����ǰ��') end
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
                -- messageShow(v..' '..'�趨ʱ��:'..GetTimerInfo(v, 3)..'�룬��һ��ʱ��:'..GetTimerInfo(v, 13)..'�롣')
                ResetTimers()
                break
            end
        end
    end
end

function trans(num)
    local words = {}
    local i = 0
    num = string.gsub(num, "��ʮ", "10 ");
    num = string.gsub(num, "��", "");
    num = string.gsub(num, "һ", "1");
    num = string.gsub(num, "��", "2");
    num = string.gsub(num, "��", "3");
    num = string.gsub(num, "��", "4");
    num = string.gsub(num, "��", "5");
    num = string.gsub(num, "��", "6");
    num = string.gsub(num, "��", "7");
    num = string.gsub(num, "��", "8");
    num = string.gsub(num, "��", "9");
    i = string.find(num, "ʮ")
    if i == 1 then
        num = string.gsub(num, "ʮ", "10 ")
    else
        num = string.gsub(num, "ʮ", "0 ")
    end
    num = string.gsub(num, "��", "00 ")
    num = string.gsub(num, "ǧ", "000 ")
    num = string.gsub(num, "��", "0000 ")
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
        print('������Ħ�������У���ǰ����������' .. smydie ..
                  '���Σ��趨ɱ����ʿ��������Ϊ��' .. smyteam ..
                  '���顣��������Ϊ�ڡ�' .. yptteam .. '���顣')
        exe('flatter')
        return
    end
    if job.name == 'husong' then
        exe('aq')
        print('���ڻ���������')
        return
    end
    if job.name == 'refine' then
        exe('admire2')
        print('����������ʯ��')
        return
    end
    if job.name == 'hubiao' then
        exe('admire2')
        print('���ڻ�����')
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
        if dest.area == '����ɽ' or dest.area == '�置' then
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
        chats_log("ROBOT �����ѷ���" .. flag.idle / 2 .. "����!",
                  "deepskyblue")
        return
    end
    scrLog()
    dis_all()
    chats_locate('��λϵͳ������6���Ӻ��ڡ�' .. locl.area ..
                     locl.room .. '����������ϵͳ��', 'red')
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
                   "��Ҫѧϰ��SKILLS(��ʽ��force|shenyuan-gong|dodge|yanling-shenfa|sword|blade|parry)��?",
                   "xuexiskill", GetVariable("xuexiskill"), "����", "12")
    if not isNil(l_result) then
        SetVariable("xuexiskill", l_result)
        Note("ѧϰ�趨���")
        print(GetVariable("xuexiskill"))
    end
    l_result = utils.inputbox(
                   "��Ҫ�����SKILLS(��ʽ��force|dodge|sword|blade|parry)��?",
                   "lingwuskills", GetVariable("lingwuskills"), "����", "12")
    if not isNil(l_result) then
        SetVariable("lingwuskills", l_result)
        Note("�����趨���")
        print(GetVariable("lingwuskills"))
    end
    l_result = utils.inputbox("��ѧϰ����ʱʹ�õļ�����������?",
                              "learnweapon", GetVariable("learnweapon"),
                              "����", "12")
    if not isNil(l_result) then SetVariable("learnweapon", l_result) end
    l_result = utils.inputbox(
                   "��ս�����л������ָ�������ָ���ǣ����磺unwield xxx sword;wield xxx blade��?",
                   "recoveryweapon", GetVariable("recoveryweapon"), "����",
                   "12")
    if not isNil(l_result) then SetVariable("recoveryweapon", l_result) end
    l_result = utils.inputbox("���Ӣ��ID��?", "ID", GetVariable("id"),
                              "����", "12")
    if l_result ~= nil then
        SetVariable("id", l_result)
    else
        DeleteVariable("id")
    end
    l_result = utils.inputbox("���������?", "Passwd",
                              GetVariable("passwd"), "����", "12")
    if l_result ~= nil then
        SetVariable("passwd", l_result)
    else
        DeleteVariable("passwd")
    end

    l_result = utils.msgbox("�Ƿ�򿪼�¼����?", "FlagLog", "yesno",
                            "?", 1)
    if l_result and l_result == "yes" then
        flag.log = "yes"
    else
        flag.log = "no"
    end
    SetVariable("flaglog", flag.log)

    l_result = utils.msgbox("�Ƿ��Զ�ѧϰ������", "XuexiLingwu",
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
               "��ʹ��start�������������ˣ�stop����ֹͣ�����ˣ�iset���û����ˣ�")
end

function masterSet()
    local l_result, l_tmp, t
    if score.party ~= "��ͨ����" then
        l_result = utils.inputbox("���ʦ���ļ��ID��?", "MasterId",
                                  GetVariable("masterid"), "����", "12")
        if not isNil(l_result) then
            SetVariable("masterid", l_result)
            master.id = l_result
        end
        if not score.master or not masterRoom[score.master] then
            l_result = utils.inputbox("���ʦ���ľ�ס����?",
                                      "MasterRoom", GetVariable("masterroom"),
                                      "����", "12")
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
        l_result = utils.listbox("��ʹ�õ������ڹ���", "�����ڹ�",
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
        l_result = utils.listbox("��׼��ս��ʹ�õĹ�����?",
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
                   "ս��Ĭ��׼��PFM(��ʽ��bei none;bei claw;jifa parry jiuyin-baiguzhua;perform sanjue)��?",
                   "PerformPre", GetVariable("performpre"), "����", "12")
    if not isNil(l_result) then
        SetVariable("performpre", l_result)
        perform.pre = l_result
        l_pfm = perform.pre
        create_alias('pfmset', 'pfmset', 'alias pfmpfm ' .. l_pfm)
        Note("Ĭ��PFM")
        Execute('pfmset')
    end
    l_result = utils.inputbox("��Ŀ���PFM(��ʹ��������PFM)��?",
                              "pfmks", GetVariable("pfmks"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmks", l_result)
        l_pfm = l_result
        create_alias('pfmks', 'pfmks', 'alias pfmpfm ' .. l_pfm)
        Note("����PFM")
        Execute('pfmks')
    end
    l_result = utils.inputbox(
                   "����Ľ�ݽ����õ�PFM(ʹ�ò��ý����Կ���Ľ�ݵ�skills,Ľ�ݽ���������Ϊ����)��?",
                   "pfmmrjf", GetVariable("pfmmrjf"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmmrjf", l_result)
        l_pfm = l_result
        create_alias('pfmmrjf', 'pfmmrjf', 'alias pfmpfm ' .. l_pfm)
        Note("���ý���PFM")
        Execute('pfmmrjf')
    end
    l_result = utils.inputbox(
                   "��������ʥ���PFM(ʹ���������������̵�skills��ʥ���������Ϊ����)��?",
                   "pfmshlf", GetVariable("pfmshlf"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmshlf", l_result)
        l_pfm = l_result
        create_alias('pfmshlf', 'pfmshlf', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmshlf')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(ʹ�������Ե�skills�����������Ĺ���Ϊ��)��?",
                   "pfmwu", GetVariable("pfmwu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmwu", l_result)
        l_pfm = l_result
        create_alias('pfmwu', 'pfmwu', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmwu')
    end
    l_result = utils.inputbox("��д��Ŀ���������PFM��?", "pwu",
                              GetVariable("pwu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pwu", l_result)
        l_pfm = l_result
        create_alias('pwu', 'pwu', 'alias pfmpfm ' .. l_pfm)
        Note("����������PFM")
        Execute('pwu')
    end
    l_result = utils.inputbox(
                   "��д��Ŀ�����PFM(ʹ�ÿ����Ե�skills)��?",
                   "pkong", GetVariable("pkong"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pkong", l_result)
        l_pfm = l_result
        create_alias('pkong', 'pkong', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pkong')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(�����书����)��?",
                   "pfmsanqing", GetVariable("pfmsanqing"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmsanqing", l_result)
        l_pfm = l_result
        create_alias('pfmsanqing', 'pfmsanqing', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmsanqing')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���ա����Կ�����ֵΪ����130 �տ�120 ��110 ������100���������Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pzhen", GetVariable("pzhen"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pzhen", l_result)
        perform.zhen = l_result
        l_pfm = perform.zhen
        create_alias('pfmzhen', 'pfmzhen', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmzhen')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ������Կ�����ֵΪ����130 ���120 ��110 ������100���������Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pqi", GetVariable("pqi"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pqi", l_result)
        perform.qi = l_result
        l_pfm = perform.qi
        create_alias('pfmqi', 'pfmqi', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmqi')
    end
    l_result = utils.inputbox(
                   "��д��ĸ�����PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���������Կ�����ֵΪ����130 ����120 ��110 ������100���޸����Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pgang", GetVariable("pgang"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pgang", l_result)
        perform.gang = l_result
        l_pfm = perform.gang
        create_alias('pfmgang', 'pfmgang', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmgang')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���졣���Կ�����ֵΪ����130 ���120 ��110 ������100���������Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "prou", GetVariable("prou"), "����", "12")
    if not isNil(l_result) then
        SetVariable("prou", l_result)
        perform.rou = l_result
        l_pfm = perform.rou
        create_alias('pfmrou', 'pfmrou', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmrou')
    end
    l_result = utils.inputbox(
                   "��д��Ŀ�����PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���ա����Կ�����ֵΪ����130 ���120 ��110 �޸���100���޿����Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pkuai", GetVariable("pkuai"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pkuai", l_result)
        perform.kuai = l_result
        l_pfm = perform.kuai
        create_alias('pfmkuai', 'pfmkuai', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmkuai')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���ᡣ���Կ�����ֵΪ����130 �տ�120 ��110 �޸���100���������Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pman", GetVariable("pman"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pman", l_result)
        perform.man = l_result
        l_pfm = perform.man
        create_alias('pfmman', 'pfmman', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmman')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���������Կ�����ֵΪ����130 ���120 ��110 ������100���������Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pmiao", GetVariable("pmiao"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pmiao", l_result)
        perform.miao = l_result
        l_pfm = perform.miao
        create_alias('pfmmiao', 'pfmmiao', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmmiao')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(��verify ���鿴���pfm����������д����ʽ��verify yunu-jianfa)��?         ������������Ϊ���档���Կ�����ֵΪ����130 ����120 ��110 ������100���������Կɰ��������ֵ�ߵ�����������ж�Ӧ���Ե�FPM��",
                   "pxian", GetVariable("pxian"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pxian", l_result)
        perform.xian = l_result
        l_pfm = perform.xian
        create_alias('pfmxian', 'pfmxian', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmxian')
    end
    l_result = utils.inputbox(
                   "��FPK��PFM(��verify ���鿴���pfm����������д��ʽ��verify yunu-jianfa)��?",
                   "pkpfm", GetVariable("pkpfm"), "����", "12")
    if not isNil(l_result) then SetVariable("pkpfm", l_result) end
    l_result = utils.inputbox("�������Ĵ����ǣ�", "mycishu",
                              GetVariable("mycishu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("mycishu", l_result)
        lianxi_times = l_result
    end
    Note("ʹ��Ĭ��PFM")
    Execute('pfmset')
end

function myUweapon()
    l_result = utils.inputbox("����ҪGET�ĵ�һ������ID��?",
                              "myweapon", GetVariable("myweapon"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("myweapon", l_result) end
    l_result = utils.inputbox("����ҪGET�ĵڶ�������ID��?",
                              "muweapon", GetVariable("muweapon"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("muweapon", l_result) end
end

function jobSet()
    local l_result, l_tmp, t

    t = {
        ["wudang"] = "�䵱��Զ��",
        ["huashan"] = "��ɽ����Ⱥ",
        ["gaibang"] = "ؤ���ⳤ��",
        ["songmoya"] = "��Ħ�¿�������",
        ["zhuoshe"] = "ؤ��׽��",
        ["songxin"] = "��������",
        ["songxin2"] = "��������2",
        ["xueshan"] = "ѩɽ����Ů",
        ["sldsm"] = "������ʦ��",
        ["songshan"] = "��ɽ������",
        --   ["hubiao"]  ="���ݻ���",
        ["tmonk"] = "���ֽ̺���",
        ["clb"] = "���ְ�����1",
        ["husong"] = "���ֻ���",
        ["hqgzc"] = "���߹�����"
    }

    t = {}

    for p, q in pairs(job.list) do t[p] = q end

    if score.party ~= "ؤ��" then t["zhuoshe"] = nil end
    if score.party ~= "������" then t["sldsm"] = nil end
    if score.party ~= "������" or hp.exp > 2000000 or hp.exp < 300000 then
        t["tmonk"] = nil
    end
    if score.party ~= "������" or hp.exp < 2000000 then t["husong"] = nil end
    if hp.exp < 5000000 then t["songmoya"] = nil end
    if hp.shen < 0 then t["gaibang"] = nil end
    if hp.shen < 0 and score.party == "��ɽ��" then t["huashan"] = nil end
    if hp.shen < 0 then t["wudang"] = nil end
    if hp.shen > 0 then t["songshan"] = nil end

    job.zuhe = {}
    if GetVariable("jobzuhe") then
        tmp.job = utils.split(GetVariable("jobzuhe"), '_')
        tmp.zuhe = {}
        for _, p in pairs(tmp.job) do tmp.zuhe[p] = true end
    end
    l_tmp = utils.multilistbox("����������(�밴CTRL��ѡ)��?",
                               "�������", t, tmp.zuhe)
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
        l_result = utils.listbox("���һ����ȥ������",
                                 "��������", t, GetVariable("jobfirst"))
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
        l_result = utils.listbox("��ڶ�����ȥ������",
                                 "��������", t, GetVariable("jobsecond"))
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
        l_result = utils.listbox("�������ȥ������", "��������",
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
                       "����һƷ������ɱ���ڼ���?(Ĭ��Ϊ7��)ʹ��Ĭ��������հײ�Ҫ��д��",
                       "ypttab", GetVariable("ypttab"), "����", "12")
        if not isNil(l_result) then
            SetVariable("ypttab", l_result)
            smyteam = tonumber(l_result)
        else
            smyteam = 16
        end
        l_result = utils.inputbox(
                       "����һƷ�������������β�����SMY!(Ĭ��Ϊ2��)ʹ��Ĭ��������հײ�Ҫ��д��",
                       "yptdie", GetVariable("yptdie"), "����", "12")
        if not isNil(l_result) then
            SetVariable("yptdie", l_result)
            smyall = tonumber(l_result)
        else
            smyall = 2
        end
        l_result = utils.msgbox(
                       "����һƷ�������Ƿ���˫ɱ!(Ĭ��Ϊno������)��",
                       "˫ɱ", "yesno", "?", 1)
        if l_result and l_result == "yes" then
            double_kill = yes
        else
            double_kill = no
        end
        l_result = utils.inputbox(
                       "����һƷ������ǰ��BUFF!(Perform and Yun��û������дnone)��",
                       "pfbuff", GetVariable("pfbuff"), "����", "12")
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
                       "��ػ������м��Ƿ������(1Ϊ���� 0Ϊ������)",
                       "tdhdazuo", GetVariable("tdhdazuo"), "����", "12")
        if not isNil(l_result) then
            SetVariable("tdhdazuo", l_result)
            tdhdz = l_result
        else
            tdhdz = 1
        end
    end

    if job.zuhe["hqgzc"] then
        l_result = utils.inputbox("��Pot����Gold��(1ΪPot 0ΪGold)",
                                  "hqgzcjiangli", GetVariable("hqgzcjiangli"),
                                  "����", "12")
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
                           "����ӻ��ڵĶ���(��������)��?",
                           "TeamName", GetVariable("teamname"), "����", "12")
        else
            l_result = utils.inputbox(
                           "����ӻ��ڵĶ���(��������)��?",
                           "TeamName", job.teamname, "����", "12")
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
                           "����ӻ��ڵĶӳ�(��������)��?",
                           "TeamLead", GetVariable("teamlead"), "����", "12")
        else
            l_result = utils.inputbox(
                           "����ӻ��ڵĶӳ�(��������)��?",
                           "TeamLead", job.teamlead, "����", "12")
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
        ["��Ϣ��"] = "��Ϣ��",
        ["������Ϣ��"] = "������Ϣ��",
        ["������Ϣ��"] = "������Ϣ��",
        ["���ɽ�ҩ"] = "���ɽ�ҩ",
        ["��Ѫ�ƾ���"] = "��Ѫ�ƾ���",
        ["�󻹵�"] = "�󻹵�",
        ["����"] = "����",
        ["ţƤ�ƴ�"] = "ţƤ�ƴ�"
    }
    if GetVariable("drugprepare") then
        tmp.drug = utils.split(GetVariable("drugprepare"), '|')
        tmp.pre = {}
        for _, p in pairs(tmp.drug) do tmp.pre[p] = true end
    end
    local l_tmp = utils.multilistbox(
                      "������ǰ׼������Ʒ(�밴CTRL��ѡ)��?",
                      "��Ʒ���", t, tmp.pre)
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
        print("��Ϸֹͣ")
        disAll()
    else
        g_stop_flag = true
        print("��ǰ���������У�" .. job.name ..
                  ". ���������������ֹͣ")
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
                   "Ľ�ݶ�ת����ѧϰ����(Ĭ��Ϊ��Yes)��", "dzxy",
                   "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('��Ҫѧϰ��ת����')
        need_dzxy = 'yes'
    else
        need_dzxy = 'no'
        print('�Ҳ�Ҫѧϰ��ת����')
    end
end
function inWdj()
    l_result = utils.msgbox("��Ҫ���置�嶾����", "inwdj", "yesno",
                            "?", 1)
    if l_result and l_result == "yes" then
        print('��Ҫ���置�嶾��')
        inwdj = 1
    else
        inwdj = 0
        print('�Ҳ����置�嶾��')
    end
end
function setLearn()
    l_result = utils.inputbox(
                   "��Ҫѧϰ��SKILLS(��ʽ��force|shenyuan-gong|dodge|yanling-shenfa|sword|blade|parry)��?",
                   "xuexiskill", GetVariable("xuexiskill"), "����", "12")
    if not isNil(l_result) then
        SetVariable("xuexiskill", l_result)
        Note("ѧϰ�趨���")
        print(GetVariable("xuexiskill"))
    end
    l_result = utils.inputbox("��ѧϰʱʹ�õļ�����������?",
                              "learnweapon", GetVariable("learnweapon"),
                              "����", "12")
    if not isNil(l_result) then
        SetVariable("learnweapon", l_result)
        print(GetVariable("learnweapon"))
    end
end
function setLingwu()
    l_result = utils.inputbox(
                   "��Ҫ�����SKILLS(��ʽ��force|dodge|sword|blade|parry)��?",
                   "lingwuskills", GetVariable("lingwuskills"), "����", "12")
    if not isNil(l_result) then
        SetVariable("lingwuskills", l_result)
        Note("�����趨���")
        print(GetVariable("lingwuskills"))
    end
    l_result = utils.inputbox("������ʱʹ�õļ�����������?",
                              "learnweapon", GetVariable("learnweapon"),
                              "����", "12")
    if not isNil(l_result) then
        SetVariable("learnweapon", l_result)
        print(GetVariable("learnweapon"))
    end
end
function setLian()
    l_result = utils.inputbox("�������Ĵ����ǣ�", "mycishu",
                              GetVariable("mycishu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("mycishu", l_result)
        lianxi_times = l_result
    end
end
function set_autoxue()
    l_result = utils.msgbox("�Ƿ��Զ�ѧϰ������", "XuexiLingwu",
                            "yesno", "?", 1)
    if l_result and l_result == "yes" then
        flag.autoxuexi = 1
    else
        flag.autoxuexi = 0
    end
    SetVariable("flagautoxuexi", flag.autoxuexi)
end
function pk_start()
    l_result = utils.inputbox("��ҪPK��Ŀ���ǣ�Ӣ��ID����",
                              "PK-Target", GetVariable("pk_target"), "����",
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
    l_result = utils.inputbox("��������ٺ�����(����Ĭ��240)",
                              "heqi_number", GetVariable("heqi_number"),
                              "����", "12")
    if not isNil(l_result) then
        SetVariable("heqi_number", l_result)
    else
        SetVariable("heqi_number", "240")
    end
    l_result = utils.inputbox(
                   "��д��Ŀ���������PK-PFM(������)��?",
                   "zpk_pwu", GetVariable("zpk_pwu"), "����", "12")
    if not isNil(l_result) then SetVariable("zpk_pwu", l_result) end
    l_result = utils.inputbox(
                   "��д��Ŀ��ƿ�����PK-PFM(���ƿ�)��?",
                   "zpk_pkong", GetVariable("zpk_pkong"), "����", "12")
    if not isNil(l_result) then SetVariable("zpk_pkong", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM��? (������)",
                              "zpk_pzhen", GetVariable("zpk_pzhen"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pzhen", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "zpk_pqi", GetVariable("zpk_pqi"), "����", "12")
    if not isNil(l_result) then SetVariable("zpk_pqi", l_result) end
    l_result = utils.inputbox("��д��ĸ�����PK-PFM(������)",
                              "zpk_pgang", GetVariable("zpk_pgang"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pgang", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(���ƿ�)",
                              "zpk_prou", GetVariable("zpk_prou"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_prou", l_result) end
    l_result = utils.inputbox("��д��Ŀ�����PK-PFM(���Ƹ�)",
                              "zpk_pkuai", GetVariable("zpk_pkuai"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pkuai", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "zpk_pman", GetVariable("zpk_pman"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pman", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "zpk_pmiao", GetVariable("zpk_pmiao"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pmiao", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "zpk_pxian", GetVariable("zpk_pxian"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("zpk_pxian", l_result) end
    l_result = utils.inputbox(
                   "��д���Ĭ��PK-PFM(����pfm���޷�ʶ��Է��书��Ӧ�ԣ�����pfmpfm�趨)��?",
                   "pkpfm", GetVariable("pkpfm"), "����", "12")
    if not isNil(l_result) then SetVariable("pkpfm", l_result) end
    l_result = utils.inputbox(
                   "��д���PK-PFM(ֻ����pfm��������wield������jifa)",
                   "mypfm", GetVariable("mypfm"), "����", "12")
    if not isNil(l_result) then SetVariable("mypfm", l_result) end
    l_result = utils.inputbox(
                   "��д���PK-PFM��Ҫ���ٺ����ͷţ�ֻ�����֣���",
                   "pk_pfm_heqi", GetVariable("pk_pfm_heqi"), "����", "12")
    if not isNil(l_result) then SetVariable("pk_pfm_heqi", l_result) end
    l_result = utils.inputbox("��д���buff-PFM(pkʱʹ�õ�buff����)",
                              "mybuff", GetVariable("mybuff"), "����", "12")
    if not isNil(l_result) then SetVariable("mybuff", l_result) end
    l_result = utils.inputbox(
                   "��д���buff-PFM��Ҫ���ٺ����ͷţ�ֻ�����֣���",
                   "pk_buff_heqi", GetVariable("pk_buff_heqi"), "����", "12")
    if not isNil(l_result) then SetVariable("pk_buff_heqi", l_result) end
    l_result = utils.inputbox(
                   "��д���debuff-PFM(pkʱʹ�õ�debuff����)",
                   "mydebuff", GetVariable("mydebuff"), "����", "12")
    if not isNil(l_result) then SetVariable("mydebuff", l_result) end
    l_result = utils.inputbox(
                   "��д���debuff-PFM��Ҫ���ٺ����ͷţ�ֻ�����֣���",
                   "pk_debuff_heqi", GetVariable("pk_debuff_heqi"), "����",
                   "12")
    if not isNil(l_result) then SetVariable("pk_debuff_heqi", l_result) end
end
function setsmy()
    l_result = utils.inputbox(
                   "��д��Ŀ���������PK-PFM(������)��?",
                   "smy_pwu", GetVariable("smy_pwu"), "����", "12")
    if not isNil(l_result) then SetVariable("smy_pwu", l_result) end
    l_result = utils.inputbox(
                   "��д��Ŀ��ƿ�����PK-PFM(���ƿ�)��?",
                   "smy_pkong", GetVariable("smy_pkong"), "����", "12")
    if not isNil(l_result) then SetVariable("smy_pkong", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM��? (������)",
                              "smy_pzhen", GetVariable("smy_pzhen"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pzhen", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "smy_pqi", GetVariable("smy_pqi"), "����", "12")
    if not isNil(l_result) then SetVariable("smy_pqi", l_result) end
    l_result = utils.inputbox("��д��ĸ�����PK-PFM(������)",
                              "smy_pgang", GetVariable("smy_pgang"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pgang", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(���ƿ�)",
                              "smy_prou", GetVariable("smy_prou"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_prou", l_result) end
    l_result = utils.inputbox("��д��Ŀ�����PK-PFM(���Ƹ�)",
                              "smy_pkuai", GetVariable("smy_pkuai"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pkuai", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "smy_pman", GetVariable("smy_pman"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pman", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "smy_pmiao", GetVariable("smy_pmiao"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pmiao", l_result) end
    l_result = utils.inputbox("��д���������PK-PFM(������)",
                              "smy_pxian", GetVariable("smy_pxian"), "����",
                              "12")
    if not isNil(l_result) then SetVariable("smy_pxian", l_result) end
    l_result = utils.inputbox(
                   "��д��ĵͺ���PFM(���磺�һ�����perform leg.fengwu)��?",
                   "smy_pfm1", GetVariable("smy_pfm1"), "����", "12")
    if not isNil(l_result) then SetVariable("smy_pfm1", l_result) end
    l_result = utils.inputbox(
                   "��д��ĸ���PFM(���磺�һ�����perform sword.qimen)�ǣ�",
                   "smy_pfm2", GetVariable("smy_pfm2"), "����", "12")
    if not isNil(l_result) then SetVariable("smy_pfm2", l_result) end
    l_result = utils.inputbox(
                   "��д��Ĵ���PFM(ֻ����pfm��������wield������jifa�����磺�һ�����perform leg.kuangfeng)�ǣ�",
                   "smy_pfm3", GetVariable("smy_pfm3"), "����", "12")
    if not isNil(l_result) then SetVariable("smy_pfm3", l_result) end
    l_result = utils.inputbox(
                   "��д���buff-PFM(��ɽʱʹ�õ�buff���ܣ����磺�һ�����perform dodge.wuzhuan;perform finger.xinghe)�ǣ�",
                   "mybuff", GetVariable("smybuff"), "����", "12")
    if not isNil(l_result) then SetVariable("smybuff", l_result) end
end
function setxcexp()
    l_result = utils.msgbox("Ѳ�ǵ�2M", "xcexp", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('Ѳ�ǵ�2M')
        xcexp = 1
    else
        print('Ѳ�ǵ�1M')
        xcexp = 0
    end
end
function xuepot()
    l_result = utils.msgbox("�Ƿ�ѧϰ", "xuexi", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('ѧϰ����')
        needxuexi = 1
    else
        needxuexi = 0
        print('ѧϰ�ر�')
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
                     "^>*\\s*���������죬̫����������У����ƶ�䣬����˳���Ʋ�ı�Ե���������������Щ���ۡ�",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy2',
                     "^>*\\s*���������죬���Ϸ��ǵ�㣬���������Ƕ����ƶ�������ѧ�ġ���ת���ơ���Ī�����ϵ��ȴ����ʵս���鲻�㣬�޷����㿴���Ķ�����ʵ����ս��ϵ��һ��",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy3',
                     '^>*\\s*��� "action" �趨Ϊ "Ľ�ݶ�ת����" �ɹ���ɡ�',
                     '', 'dzxy_goon')
    create_trigger_t('dzxy4', "^>*\\s*�������������", '', 'dzxy_finish')
    create_trigger_t('dzxy5',
                     "^>*\\s*�ȴ�ľ׮��������\\(down\\)��˵�ɣ�",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy6',
                     "^>*\\s*��ϲ��ϲ�����Ѿ��ڻ��ͨ�˶�ת���Ƶľ���֮����",
                     '', 'dzxy_finish')
    create_trigger_t('dzxy7',
                     "^>*\\s*���Ѿ�û��Ǳ��������ѧϰ��ת�����ˡ�",
                     '', 'dzxy_finish')

    create_trigger_t('dzxy8',
                     "^>*\\s*���������죬���Ϸ��ǵ�㣬��˳�����ӵķ���ȥ��ȴ���ֲ��ֵ�ҹ�ձ���Χ�����ڵ�ס�ˡ�",
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
            dzxy_level = 1 -- Ľ�ݸ���ʼ(#3 w;jump liang;lingwu zihua)�����Ե�171����
            return dzxy()
        end
        if skills["douzhuan-xingyi"].lvl > 170 and skills["douzhuan-xingyi"].lvl <
            200 then
            dzxy_level = 2 -- ��ʩˮ�� ȥ:sit chair;zhuan;n;lingwu miji ��:s;push shujia�����Ե�201����
            return dzxy()
        end
        if skills["douzhuan-xingyi"].lvl > 200 and skills["douzhuan-xingyi"].lvl <
            hp.pot_max - 100 and
            (locl.time == "��" or locl.time == "��" or locl.time == "��" or
                locl.time == "��") then
            dzxy_level = 3 -- ����̨ ��ȥjump zhuang;look sky������jump down��ֻ������look sky�����Ե�N����
            return dzxy()
        end
        messageShow(
            '�����أ�Ľ������ת����������������������',
            'white')
        print("dzxy_level:" .. dzxy_level)
    end

    return go(xueshan_finish_ask, '��ѩɽ', '���Ŀ�')
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
    messageShow('�����أ�ȥĽ�������ֻ�ȥ�ˣ�', 'white')
    go(dzxy1_unwield, '������', '��ˮ��')
end
function dzxy2_go()
    messageShow('�����أ�ȥĽ�������ؼ�ȥ�ˣ�', 'white')
    go(dzxy2_unwield, '������', '��ʩˮ��')
end
function dzxy3_go()
    messageShow('�����أ�ȥĽ�ݿ�����ȥ�ˣ�', 'white')
    go(dzxy3_unwield, '������', '����̨')
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
    if not (locl.room == "����̨" or locl.room == "��ʩˮ��" or locl.room ==
        "����") then
        messageShow(
            "Ľ�����򣺶�ת���Ƶ�λ�ò��ԣ���ǰλ�ã�" ..
                locl.room)
        return dzxy_finish()
    end
    EnableTriggerGroup("dzxy", true)
    weaponWieldLearn()
    if not skills["douzhuan-xingyi"] or skills["douzhuan-xingyi"].lvl == 0 or
        skills["douzhuan-xingyi"].lvl >= hp.pot_max - 100 then
        messageShow(
            "Ľ�����򣺶�ת���Ƶĵȼ����ԣ���ǰ�ȼ���" ..
                skills["douzhuan-xingyi"].lvl)
        return check_busy(dzxy_finish)
    end
    if flag.idle > 7 then return check_busy(dzxy_finish) end
    if hp.neili < hp.neili_max * 0.5 then
        messageShow(
            "Ľ�����򣺶�ת���Ƶ�������������ǰ������" ..
                hp.neili .. "��", 'white')
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
function dzxy_alias() exe('alias action Ľ�ݶ�ת����') end

function dzxy_finish()
    EnableTimer('mr_dzxy_timer', false)
    DeleteTimer("mr_dzxy_timer")
    messageShow('�����أ�Ľ�ݶ�ת������ɣ�')
    exe('jump down')
    EnableTriggerGroup("dzxy", false)
    DeleteTriggerGroup("dzxy")
    exe('cha;hp')
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('unwield ' .. leweapon)
    exe('jump down')
    return go(xueshan_finish_ask, '��ѩɽ', '���Ŀ�')
end
-----�Զ�����������----
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
    tmp_lxskill = tmp_lxskill .. 'hp;unset ����;bei finger;i'
end
function set_sxlian()
    dazuo_lianxi_auto()
    create_alias('sx1lian', 'sx1lian', 'alias sxlian ' .. tmp_lxskill)
    Execute('sx1lian')
end
function weapon_lost()
    DeleteTriggerGroup("weapon_lose")
    create_trigger_t('weapon_lose1',
                     "^>*\\s*��ʿ��һת�۾���ûӰ���ˣ�һ����������һ��(\\D*)��Ȼ��֪������ȥ�ˡ�",
                     '', 'weapon_found')
    create_trigger_t('weapon_lose2',
                     "^>*\\s*��ʿ������ص����㣬����ܲ����˵����ӡ�",
                     '', 'weapon_no_found')
    create_trigger_t('weapon_lose3',
                     "^>*\\s*���״̬���ȶ������Ժ�", '',
                     'weapon_no_found')
    SetTriggerOption("weapon_lose1", "group", "weapon_lose")
    SetTriggerOption("weapon_lose2", "group", "weapon_lose")
    SetTriggerOption("weapon_lose3", "group", "weapon_lose")
    EnableTriggerGroup("weapon_lose", true)
    return go(weapon_lost_get, '���ݳ�', '����')
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
    messageShow('������ʧ���һ���ʿ���һأ�', 'red')
    return check_busy(weapon_found_get)
end
function weapon_found_get()
    exe('get all')
    return check_halt(check_food)
end
function kedian_sleep()
    if locl.area == '������' then
        exe('up;n;sleep')
    else
        exe('up;enter;sleep')
    end
    locate()
    walk_wait()
end
function check_rope() go(get_rope, '��ɽ', '����') end
function get_rope()
    exe('tell rope ����')
    check_busy(checkPrepareOver)
end
function check_key() go(get_juhua, '���ݳ�', '��԰') end
function get_juhua()
    exe('tell daisy ����')
    go(get_key, '���ݳ�', 'С�̹�')
end
function get_key()
    exe('give juyou ye juhua')
    check_busy(checkPrepareOver)
end
-----------�Զ�ץѩ��by�һ����޷���2019.3.16----------
function check_xuezhu_status()
    local xuezhu_status = GetVariable("xuezhu_status")
    if xuezhu_status == nil then
        messageShow(
            'δ�ҵ�ѩ�������xuezhu_status���뾡�����ã�',
            'white', 'black')
    elseif xuezhu_status == "0" then
        messageShow(
            '���ܻ�δץ��ѩ�룬�����Զ�ץѩ������ˣ�ǰ��ץѩ�룡',
            'white', 'black')
        return xuezhu_status
    elseif xuezhu_status == "1" then
        messageShow('���ʳ�����Ҫ���浤������ǰ��ץѩ�룡',
                    'white', 'black')
        return xuezhu_status
    elseif xuezhu_status == "-1" then
        messageShow(
            '�����ظ��˼ٵ���С���ˣ�ŭ����������ǰ��ץѩ�룡',
            'white', 'black')
        return xuezhu_status
    end
end
function xuezhuTrigger()
    DeleteTriggerGroup("xuezhuAsk")
    create_trigger_t('xuezhuAsk1',
                     "^(> )*��������ش����йء��嶾�̡�����Ϣ",
                     '', 'xuezhuAsk')
    create_trigger_t('xuezhuAsk2', "^(> )*����û������ˡ�$", '',
                     'xuezhuNobody')
    SetTriggerOption("xuezhuAsk1", "group", "xuezhuAsk")
    SetTriggerOption("xuezhuAsk2", "group", "xuezhuAsk")
    EnableTriggerGroup("xuezhuAsk", false)
    DeleteTriggerGroup("xuezhuAccept")
    create_trigger_t('xuezhuAccept1',
                     "^(> )*������˵�������嶾�̵Ľ��������˸����滨��ݣ����д󲿷־��о޶�\\D*",
                     '', 'xuezhuAccept')
    create_trigger_t('xuezhuAccept2',
                     "^(> )*����һ�ž�ѩ���Ƶ���$", '', 'eatDan')
    create_trigger_t('xuezhuAccept3',
                     "^(> )*���һ�ž�ѩ���Ƶ�������ҧ�麬������پ��������ʣ���ɫ����$",
                     '', 'xuezhu_go')
    create_trigger_t('xuezhuAccept4',
                     "^(> )*������˵���������ϴδ�Ӧ�ҵ����黹û��\\D*",
                     '', 'fakeDan')
    SetTriggerOption("xuezhuAccept1", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept2", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept3", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept4", "group", "xuezhuAccept")
    EnableTriggerGroup("xuezhuAccept", false)
    DeleteTriggerGroup("xuezhuFight")
    create_trigger_t('xuezhuFight1',
                     '^(> )*��ζ��˰��죬����ʲ��Ҳû�С�', '',
                     'xuezhuFail')
    create_trigger_t('xuezhuFight2',
                     '^(> )*������ҡ�����٣���Ȼ����һֻѩ�롣',
                     '', 'xuezhuFight')
    create_trigger_t('xuezhuFight3',
                     "^(> )*ѩ����־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��",
                     '', 'getxuezhu')
    create_trigger_t('xuezhuFight4',
                     "^(> )*�㽫ѩ������������ڱ��ϡ�", '',
                     'givecheng')
    create_trigger_t('xuezhuFight5',
                     "^(> )*ѩ�롸ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�",
                     '', 'xuezhuFail')
    create_trigger_t('xuezhuFight6',
                     "^(> )*(�㸽��û������������|ѩ��ͻȻ�ڵ����ϲ����ˡ�)",
                     '', 'xuezhuFail')
    -- create_trigger_t('xuezhuFight6',"^(> )*ѩ��ͻȻ�ڵ����ϲ����ˡ�",'','xuezhuFail')
    SetTriggerOption("xuezhuFight1", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight2", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight3", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight4", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight5", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight6", "group", "xuezhuFight")
    EnableTriggerGroup("xuezhuFight", false)
    DeleteTriggerGroup("xuezhuFinish")
    create_trigger_t('xuezhuFinish1',
                     '^(> )*������˵���������Ȼ�Զ����ţ��´���Ҫ��ȥ�嶾�������Ұɡ���',
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
        messageShow('ץѩ�룺�置��ͼ���ɵ�����������',
                    "Plum")
        SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepare)
    end
    go(askcheng, '�置', 'ҩ����')
end
function getxuezhu1()
    xuezhuTrigger()
    xuezhu_go()
end
function askcheng()
    EnableTriggerGroup("xuezhuAsk", true)
    EnableTriggerGroup("xuezhuAccept", true)
    exe('ask cheng about �嶾��')
    create_timer_s('walkWait4', 3.0, 'askcheng1')
end
function askcheng1() exe('ask cheng about �嶾��') end
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
    if not Bag["����"] and drugPrepare["����"] then
        if locl.weekday == '��' and locl.hour == 8 then
            return checkPrepareOver()
        else
            return checkFire()
        end
    end
    if inwdj == 0 then
        messageShow('ץѩ�룺�置ɽ�����ɵ�����������',
                    "Plum")
        SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepare)
    end
    EnableTriggerGroup("xuezhuAccept", false)
    go(yaoshuteng, '�置', 'ɽ��')
end
function yaoshuteng()
    EnableTriggerGroup("xuezhuFight", true)
    exe('fang dfly;dian fire;yao shuteng')
    create_timer_st('walkWait4', 3.0, 'yaoshuteng1')
end
function yaoshuteng1() exe('fang dfly;dian fire;yao shuteng') end
function xuezhuFail()
    xuezhuTriDel()
    messageShow('ѩ�벻�ڣ�һ������ץ��', 'white', 'black')
    return checkPrepareOver()
end
--[[function xuezhuFail1()
	xuezhuTriDel()
	messageShow('ѩ�뱻������ˣ���鿴log��','white','black')
	scrLog()
	return checkPrepareOver()
end
function xuezhuFail2()
	xuezhuTriDel()
	messageShow('ѩ���Լ����˻���ץ���ˣ���鿴log��','white','black')
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
    go(givexuezhu, '�置', 'ҩ����')
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
        messageShow('�����ѳɹ�ץ��ѩ�룬�밲����Ϸ����)',
                    'red', 'black')
    end
    xuezhuTriDel()
    return checkPrepareOver()
end
-----------�Զ�ץѩ��by�һ����޷���2019.3.16----------
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
----������ת��----
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
--------------������-------------
jinheTrigger = function()
    DeleteTriggerGroup("jinheTrigger")
    create_trigger_t('jinheTrigger1',
                     "^>*\\s*�㿴�˰��죬Ҳû����������ӵ�������ô���¡�",
                     '', 'jinhe_goon')
    create_trigger_t('jinheTrigger2',
                     "^>*\\s*���ӵļв��Ѿ��򿪣��������ϸ�����ӣ�look jinhe��Ȼ���ȡ��Ӧ�ж���",
                     '', 'jinhe_find')
    create_trigger_t('jinheTrigger3',
                     "^>*\\s*���ݺὭ��ʱ����(\\D*)����Щ�����£�����Ե��ǰȥ�ھ�",
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
-----�һ�����ʯͷ----
function stoneSet()
    stonePrepare = {}
    local t = {["�ྦྷʯ"] = "�ྦྷʯ", ["����ʯ"] = "����ʯ"}
    if GetVariable("stoneprepare") then
        tmp.stone = utils.split(GetVariable("stoneprepare"), '|')
        tmp.pre = {}
        for _, p in pairs(tmp.stone) do tmp.pre[p] = true end
    end
    local l_tmp = utils.multilistbox(
                      "��׼���Ե�ʯͷ(�밴CTRL��ѡ)��?",
                      "��Ʒ���", t, tmp.pre)
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
    l_result = utils.inputbox("��һ�ʯͷ�Ĵ����ǣ�", "stonecishu",
                              GetVariable("stonecishu"), "����", "12")
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
                   "�鱦����ţ��޷���ʯͷ�����һ���ٳ��ԣ�")
    else
        return go(duihuan_prepare, '���ݳ�', '����')
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
                     "^(> )*�����ϰ�ߺ��һ����" .. score.name ..
                         "�һ����Ƽ�����(�ྦྷʯ|����ʯ).*", '',
                     'stone_consider')
    create_trigger_t('duihuanstone2',
                     "^(> )*���ϰ�һ��ץ��(�ྦྷʯ|����ʯ)�������ۣ��ö���ѽ����",
                     '', 'maistone_set')
    create_trigger_t('duihuanstone3',
                     "^(> )*�㻹�Ƕ�Ŭ��һ��ʱ��ɡ�", '',
                     'duihuan_done')
    create_trigger_t('duihuanstone4',
                     "^(> )*����Ҫ�������е���Ʒ�����ٴζһ���",
                     '', 'check_stoneT')
    SetTriggerOption("duihuanstone1", "group", "duihuanstone")
    SetTriggerOption("duihuanstone2", "group", "duihuanstone")
    SetTriggerOption("duihuanstone3", "group", "duihuanstone")
    SetTriggerOption("duihuanstone4", "group", "duihuanstone")
    return duihuanStone()
end
function duihuanStone()
    if stonePrepare["�ྦྷʯ"] and tmp.redstone <
        tonumber(GetVariable("stonecishu")) then
        flag.duihuan = 1
        exe('duihuan redstone')
    end
    return check_busy(duihuanStone1, 3)
end
function duihuanStone1()
    if stonePrepare["����ʯ"] and tmp.bluestone <
        tonumber(GetVariable("stonecishu")) then
        flag.duihuan = 2
        exe('duihuan bluestone')
    end
end
function stone_consider(n, l, w)
    local x = tostring(w[2])
    if x == '�ྦྷʯ' then
        flag.redstone = true
        tmp.redstone = tmp.redstone + 1
    end
    if x == '����ʯ' then
        flag.bluestone = true
        tmp.bluestone = tmp.bluestone + 1
    end
    return stone_consider_go()
end
function stone_consider_go()
    if stonePrepare["�ྦྷʯ"] and stonePrepare["����ʯ"] and flag.redstone and
        flag.bluestone then return check_busy(mai_stone, 3) end
    if stonePrepare["�ྦྷʯ"] and not stonePrepare["����ʯ"] and
        flag.redstone then return check_busy(mai_stone, 3) end
    if not stonePrepare["�ྦྷʯ"] and stonePrepare["����ʯ"] and
        flag.bluestone then return check_busy(mai_stone, 3) end
end
function duihuan_done()
    if stonePrepare["�ྦྷʯ"] and stonePrepare["����ʯ"] then
        if flag.duihuan == 1 then
            stonePrepare["�ྦྷʯ"] = false
            tmp.redstone = tonumber(GetVariable("stonecishu"))
            return
        end
        if flag.duihuan == 2 then
            stonePrepare["����ʯ"] = false
            tmp.bluestone = tonumber(GetVariable("stonecishu"))
        end
    end
    if stonePrepare["�ྦྷʯ"] and not stonePrepare["����ʯ"] then
        stonePrepare["�ྦྷʯ"] = false
        tmp.redstone = tonumber(GetVariable("stonecishu"))
        tmp.bluestone = tonumber(GetVariable("stonecishu"))
    end
    if not stonePrepare["�ྦྷʯ"] and stonePrepare["����ʯ"] then
        stonePrepare["����ʯ"] = false
        tmp.redstone = tonumber(GetVariable("stonecishu"))
        tmp.bluestone = tonumber(GetVariable("stonecishu"))
    end
    return check_stone()
end
function mai_stone() return go(mai_stone_check, "���ݳ�", "�鱦��") end
function mai_stone_check()
    if flag.redstone then exe('mai redstone') end
    if flag.bluestone and not flag.redstone then exe('mai bluestone') end
end
function maistone_set(n, l, w)
    if w[2] == '�ྦྷʯ' then flag.redstone = false end
    if w[2] == '����ʯ' then flag.bluestone = false end
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
    return go(duihuanStone, "���ݳ�", "����")
end
function check_stone1()
    if Bag and Bag["�ྦྷʯ"] then flag.redstone = true end
    if Bag and Bag["����ʯ"] then flag.bluestone = true end
    if flag.redstone or flag.bluestone then
        return mai_stone()
    else
        ColourNote("red", "blue",
                   "��ѡ���ʯͷ����һ��ļ��ޣ����ζһ���ϣ�")
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
-------�����ֽ�-----
function dnyTrigger()
    DeleteTriggerGroup("qk_dny")
    create_trigger_t('qk_dny1',
                     '^(> )*\\s*��� "action" �趨Ϊ "�̴ֽ�Ų����" �ɹ����',
                     '', 'taoJiaozhang')
    create_trigger_t('qk_dny2', "^(> )*��������æ���ء�", '',
                     'taoJiaozhang')
    create_trigger_t('qk_dny3',
                     "^(> )*(����ʵս���鲻�㣬�谭����ġ�Ǭ����Ų�ơ�������|ʲô?|�����������)",
                     '', 'taojiao_over')
    create_trigger_t('qk_dny4',
                     "^(> )*��о�ȫ����Ϣ���ڣ�ԭ������������������װ��\\D*��",
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
        DoAfter(0.5, 'alias action �̴ֽ�Ų����')
    else
        ColourNote("white", "blue", "ʦ�����ڼң���һ��������ɣ�")
        return taojiao_over()
    end
end
function taoJiaozhang()
    flag.idle = nil
    EnableTriggerGroup("qk_dny", true)
    wait.make(function()
        wait.time(0.2)
        exe(
            '#8(taojiao qiankun-danuoyi);yun jing;alias action �̴ֽ�Ų����')
    end)
end
function taojiao_over()
    messageShow('�ֽ�Ǭ����Ų����ϣ�')
    EnableTriggerGroup("qk_dny", false)
    DeleteTriggerGroup("qk_dny")
    weaponWieldLearn()
    dis_all()
    return check_busy(check_food)
end
function fightoverweapon()
    if GetVariable("recoveryweapon") then exe(GetVariable("recoveryweapon")) end
end
------���ݵ��̶һ����߻����� by���.2019.11.09-----
function duihuanSomething()
    exe('score')
    tmp.duihuan = 0
    local l_result
    local l_duihuan
    local l_duihuanTimes
    l_result = utils.inputbox("����Ҫ�һ�����ƷID��", "duihuanID",
                              GetVariable("duihuanID"), "����", "12")
    if not isNil(l_result) then
        SetVariable("duihuanID", l_result)
        l_duihuan = l_result
        print(GetVariable("duihuanID"))
    end
    l_result = utils.inputbox("����Ҫ�һ��Ĵ���", "duihuanTimes",
                              GetVariable("duihuanTimes"), "����", "12")
    if not isNil(l_result) then
        SetVariable("duihuanTimes", l_result)
        l_duihuanTimes = l_result
        print(GetVariable("duihuanTimes"))
    end
    DeleteTriggerGroup("duihuanSomething")
    create_trigger_t('duihuanSomething1',
                     "^(> )*�����ϰ�ߺ��һ����" .. score.name ..
                         "�һ����Ƽ�����\\D*�������齣ͨ��(\\D*)��*",
                     '', 'duihuanSomething_add')
    SetTriggerOption("duihuanSomething1", "group", "duihuanSomething")
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_add(n, l, w)
    tmp.duihuan = tmp.duihuan or 0
    tmp.duihuan = tmp.duihuan + 1
    print('���ζһ�' .. tmp.duihuan .. '��')
    if tmp.duihuan >= tonumber(GetVariable("duihuanTimes")) then
        EnableTriggerGroup("duihuanSomething", false)
        DeleteTriggerGroup("duihuanSomething")
        return check_food()
    end
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_duihuan() exe('duihuan ' .. GetVariable("duihuanID")) end
-----�����Զ�����ϼ�� by �޷��� 2019.12.25------
xxkFind = function()
    DeleteTriggerGroup("xxkFind")
    create_trigger_t('xxkFind1', '^(> )*\\s*��ϼ��\\(Xu xiake\\)', '',
                     'xxkFindFollow')
    create_trigger_t('xxkFind2', '^(> )*����û�� xu xiake', '',
                     'xxkFindGoon')
    create_trigger_t('xxkFind3', '^(> )*���������\\D*һ���ж���', '',
                     'xxkFindDone')
    create_trigger_t('xxkFind4', '^(> )*���Ѿ��������ˡ�', '',
                     'xxkFindDone')
    SetTriggerOption("xxkFind1", "group", "xxkFind")
    SetTriggerOption("xxkFind2", "group", "xxkFind")
    SetTriggerOption("xxkFind3", "group", "xxkFind")
    SetTriggerOption("xxkFind4", "group", "xxkFind")
    EnableTriggerGroup("xxkFind", false)
    cntr1 = countR(20)
    job.name = "����ϼ��"
    return go(xxkFindFact, "���ݳ�", "������")
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
               "�����ҵ���ϼ�������ͷ���뿪ʼ��ĺٺٺ١�����")
    print("by �޷��� 2019.12.25")
end
-----�����Զ��ҿտն� by �޷��� 2019.12.25------
kongkongFind = function()
    DeleteTriggerGroup("kkrFind")
    create_trigger_t('kkrFind1', '^.*�տն�\\(Kong kong\\)', '',
                     'kongkongFindFollow')
    create_trigger_t('kkrFind2', '^(> )*����û�� kong kong', '',
                     'kongkongFindGoon')
    create_trigger_t('kkrFind3', '^(> )*���������\\D*һ���ж���', '',
                     'kongkongFindDone')
    create_trigger_t('kkrFind4', '^(> )*���Ѿ��������ˡ�', '',
                     'kongkongFindDone')
    SetTriggerOption("kkrFind1", "group", "kkrFind")
    SetTriggerOption("kkrFind2", "group", "kkrFind")
    SetTriggerOption("kkrFind3", "group", "kkrFind")
    SetTriggerOption("kkrFind4", "group", "kkrFind")
    EnableTriggerGroup("kkrFind", false)
    cntr1 = countR(20)
    job.name = "�ҿտն�"
    return go(kongkongFindFact, "���ݳ�", "С�Ե�")
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
               "�����ҵ��տն������ͷ���뿪ʼ��ĺٺٺ١�����")
    print("by �޷��� 2019.12.25")
end

