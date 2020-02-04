luapath = string.match(GetInfo(35), "^.*\\")
mclpath = GetInfo(67)
include = function(str) dofile(luapath .. str) end
loadmod = function(str) include("mods\\" .. str .. ".lua") end

require "wait"
require "tprint"
require "addxml"

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
drug.neili1 = 'neixi wan'
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
    exe('down;alias askk ask $*;stand;halt;uweapon;score;cha;hp;jifa all;jiali max;unset no_kill_ap;cond;pfmset')
    if not perform.skill or not perform.pre or not job.zuhe or
        countTab(job.zuhe) < 2 then
        return shujian_set()
    else
        return check_bei(hp_dazuo_count)
    end
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
        exe('set wimpycmd halt\\down\\hp')
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
function checkLLlost(n, l, w)
    LLlost = tonumber(w[4])
    if (condition.vpearl == 0 or not condition.vpearl) and needdolost == 1 and
        needvpearl == 1 then return Govpearl() end
    if LLlost * 1 >= lostno * 1 and needdolost == 1 then return dolostAg() end
end

function Govpearl() return go(dhvpearl, '���ݳ�', '����') end
function dhvpearl()
    exe('duihuan vpearl;cond')
    if lostletter == 1 and needdolost == 1 then
        needvpearl = 0
        condition.vpearl = 60
        return letterLost()
    end
    if LLlost * 1 >= lostno * 1 and needdolost == 1 then return dolostAg() end
    return check_halt(check_food)
end
function dhlost()
    exe('duihuan pcert')
    return check_halt(check_food)
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
function checklingwu()
    if lingwudie == 0 then return lingwu() end
    if xxpot < hp.pot_max then return lingwu() end
    return check_job()
end
function lingwu()
    DeleteTemporaryTriggers()
    lingwu_trigger()
    skillsLingwu = {}
    skillsLingwu = utils.split(GetVariable("lingwuskills"), '|')
    road.temp = 0
    tmp.lingwu = 1
    lingwudie = 0
    return check_busy(lingwu_go)
end
function lingwu_go()
    exe('nick ���������ĦԺ���')
    messageShow('ȥ��������')
    jifaAll()

    go(lingwu_unwield, '��ɽ����', '��ĦԺ')
end
function lingwu_unwield()
    weapon_unwield()
    exe('hp')
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    return check_busy(lingwuzbok) -- ��׼��������ֱ������
end
function lingwuzb() zhunbeineili(lingwuzbok) end
function lingwuzbok() go(lingwu_goon, '��ɽ����', '��ĦԺ���') end
function lingwuSleep()
    if score.gender == '��' then
        return go(lingwuSleepOver, "songshan/nan-room", "")
    else
        return go(lingwuSleepOver, "songshan/nv-room", "")
    end
end
function lingwuSleepOver()
    exe('sleep')
    checkWait(lingwu_eat, 3)
end
--[[function lingwu_goonpre()
    EnableTimer('walkWait4',false)
	lingwu_goon()
end]]
function lingwu_goon()
    if locl.room ~= "��ĦԺ���" then return lingwu_finish() end
    EnableTriggerGroup("lingwu", true)
    local skill = skillsLingwu[tmp.lingwu]

    if not skills[skill] or skills[skill].lvl == 0 or skills[skill].lvl >=
        hp.pot_max - 100 then return lingwu_next() end

    if hp.neili < 1000 then
        if hp.exp > 20000000 or score.gender == '��' then
            return go(lingwu_eat, '�䵱ɽ', '��ͤ')
        else
            return lingwuSleep()
        end
    end
    -- yunAddInt()
    flag.idle = nil
    exe('yun jing;#10(lingwu ' .. skill .. ')')
    -- exe('alias action ����������Ǻð������Ǻã�')
    create_timer_s('walkWait4', 0.4, 'lingwu_alias')
    -- return check_bei(lingwu_alias,1.8)ԭ���ĳ���
end
function lingwu_eat()
    if locl.room == "��ͤ" then
        flag.food = 0
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#4(drink cha);drop cha;drop tao;fill jiudai')
        check_bei(lingwu_go)
    else
        return go(lingwu_eat, '�䵱ɽ', '��ͤ')
    end
end
function lingwu_alias()
    exe('yun jing')
    -- exe('alias action ����������Ǻð������Ǻã�')
end
function lingwu_next()
    EnableTriggerGroup("lingwu", false)
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
    EnableTimer('walkWait4', false)
    checkWait(lingwu_finish, 1)
end
function lingwu_finish()
    messageShow('�����������')
    local skill = skillsLingwu[tmp.lingwu]
    EnableTriggerGroup("lingwu", false)
    DeleteTriggerGroup("lingwu")
    exe('cha')
    flag.lingwu = 0
    if tmp.lingwu > 1 and tmp.lingwu <= table.getn(skillsLingwu) then
        table.remove(skillsLingwu, tmp.lingwu)
        table.insert(skillsLingwu, 1, skill)
    end
    flag.lingwu = 0
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
                     "^(> )*��(\\D*)" .. score.master .. "(\\D*)ָ��", '',
                     'xuexiAction')
    create_trigger_t('xuexi2', "^(> )*��������æ���ء�", '',
                     'xuexiAction')
    create_trigger_t('xuexi3',
                     "^(> )*�����̫���ˣ����ʲôҲû��ѧ����",
                     '', 'xuexiSleep')
    create_trigger_t('xuexi4',
                     "^(> )*(������|�㲻����ѧϰ��ϲ����|����ѧ|�㲻����ѧϰ|��Ļ��������δ��|�㲻�������|���̫��ȭ���̫ǳ|������Ѩ���˻Ƶ����Ҵ���ѧ|������Ѩ���˶�������ʦ������ѧ|������ԣ��޷�|���\\D*(����|����|��)����|��ɽ������ô�ݵ�|��һ������ү��|���Ѿ��޷����|��Ļ�������̫��|���а��̫��|�����һ���|��ת����ֻ��ͨ�����������|ѧ��ֻ��ѧ��������|����������ʿ|ֻ�д����֮��|�㲻������������|�㲻����ѧϰ����ѧ|����ѧֻ�ܿ��ж�|��Ķ���д��|��������ֻ��ͨ����ϰҽѧ|��Ļ��������δ��|���ŷ�ɮ������|�������ֻ��ͨ������ѧϰ��ʵս|��������Ѿ��޷�ͨ��ѧϰ|���������±����ұ���ѧ��|�����ȥѧ��ѧϰ����д��|Ҳ����ȱ��ʵս����|���(��˷�|�����ķ�)��Ϊ����|�������ĳ̶��Ѿ�������ʦ��)",
                     '', 'xuexiNext')
    create_trigger_t('xuexi5', "^(> )*��û����ô��Ǳ����ѧϰ", '',
                     'xuexiFinish')
    create_trigger_t('xuexi6', "^(> )*��Ҫ��˭��̣�", '', 'xuexiFinish')
    create_trigger_t('xuexi7', "^(> )*��ġ�(\\D*)�������ˣ�", '',
                     'xuexiLvlUp')
    create_trigger_t('xuexi8', "^(> )*����ö�̫��ȭ���������",
                     '', 'xueAskzhang')
    create_trigger_t('xuexi9',
                     "^(> )*Ǭ����Ų��ֻ��ͨ����ϰ��Ǭ����Ų���ķ��������������",
                     '', 'taoJiaozhang')
    create_trigger_t('xuexi10',
                     "^(> )*(�������б���|�����ֲ�����|���ַ�����ϰ|���������|����ʱ�޷���|��ʹ�õ���������|��\\D*����|ѧ\\D*����|\\D*���ﲻ����������)",
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
    exe('nick ������ѧϰ')
    messageShow('������ѧϰ')
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
                       "δ�ҵ�ʦ��סַ������ϵPTBX���£�")
            return xuexiFinish()
        end
    else
        return xuexiFinish()
    end
end
function xuexiCheck()
    checkWield()
    if locl.id[score.master] then
        if score.party and score.party == "������" and score.master ==
            "������ɮ" and skills["buddhism"] and skills["buddhism"].lvl ==
            200 then exe('ask wuming about ��') end
        return check_bei(xuexiStart)
    else
        ColourNote("white", "blue",
                   "ʦ�����ڼң�������ֵ�ַ�д�����ϵPTBX���£�")
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
    print('ѧϰ����:' .. master.times)
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
    print('��С��Ǭ����Ų��')
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
    print('������̫��ȭ��')
    wait.make(function()
        wait.time(1)
        exe('ask zhang about ̫��ȭ��')
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
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "������", "����")
    end
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "shaolin/sengshe3", "")
    end
    if score.party and score.party == "�һ���" then
        if score.master and score.master == "��ҩʦ" then
            return go(xuexiSleepOver, "�һ���", "�ͷ�")
        else
            return go(xuexiSleepOver, "����ׯ", "�ͷ�")
        end
    end
    if score.master and score.master == "���" then
        return go(xuexiSleepOver, "gumu/jqg/wshi", "")
    end
    if score.master and score.master == "С��Ů" then
        return go(xuexiSleepOver, "gumu/jqg/wshi", "")
    end
    if score.party and score.party == "�䵱��" and score.gender == 'Ů' then
        return go(xuexiSleepOver, "�䵱ɽ", "Ů��Ϣ��")
    end
    if score.party and score.party == "�䵱��" and score.gender == '��' then
        return go(xuexiSleepOver, "�䵱ɽ", "����Ϣ��")
    end
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "dali/wangfu/woshi2", "")
    end
    if score.party and score.party == "����Ľ��" then
        return go(xuexiSleepOver, "����Ľ��", "�᷿")
    end
    if score.party and score.party == "������" then
        return go(xxSleepcheck, "���޺�", "��ң��")
    end
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "����ɽ", "��Ϣ��")
    end
    if score.party and score.party == "��ɽ��" and score.gender == '��' then
        return go(xuexiSleepOver, "��ɽ", "����Ϣ��")
    end
    if score.party and score.party == "��ɽ��" and score.gender == 'Ů' then
        return go(xuexiSleepOver, "��ɽ", "Ů��Ϣ��")
    end
    if score.party and score.party == "���ư�" and score.gender == '��' then
        return go(xuexiSleepOver, "����ɽ", "����Ϣ��")
    end
    if score.party and score.party == "���ư�" and score.gender == 'Ů' then
        return go(xuexiSleepOver, "����ɽ", "Ů��Ϣ��")
    end
    return xuexiFinish()
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
    messageShow('ѧϰ��ϣ�')
    flag.xuexi = 0
    EnableTriggerGroup("xuexi", false)
    DeleteTriggerGroup("xuexi")
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('cha;unwield ' .. leweapon)
    dis_all()
    return check_busy(check_food)
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

function literate()
    exe('nick ѧϰ����д��')
    messageShow('ѧϰ����д�֣�')
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
    go(literateCheck, '���ݳ�', '��Ժ')
end
function literateCheck()
    DeleteTriggerGroup("litxuexi")
    create_trigger_t('litxuexi1',
                     "^(> )*����������������һ�����������������ƣ���ʱ�޷��ٽ��޸������ѧ���ˡ���",
                     '', 'litxuexiover')
    create_trigger_t('litxuexi2',
                     "^(> )*�����̫���ˣ����ʲôҲû��ѧ��",
                     '', 'litxuexisleep')
    create_trigger_t('litxuexi3',
                     "^.*˵������̫�����ˣ�����ô�ҵ���", '',
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
    if not locl.id["������"] then return literateBack() end
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
    messageShow('����д��ѧϰ��ϣ�')
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('unwield ' .. leweapon)
    exe('hp;score;cha;yun jing;yun qi;yun jingli')
    dis_all()
    return check_busy(check_food)
end
function litxuexisleep()
    if score.gender == '��' then
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
    exe('nick ѧϰ����')
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 3
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then master.times = 50 end
    end
    return check_busy(duanzaoGo)
end
function duanzaoGo() return go(duanzaoCheck, '���ݳ�', '������') end
function duanzaoCheck()
    flag.idle = nil
    exe('score;hp;cha')
    checkBags()
    return checkWait(duanzaoXue, 0.8)
end
function duanzaoXue()
    if not locl.id["����ʦ"] then return duanzaoBack() end
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
    if Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt > 30 and
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
    exe('nick ѧϰ֯��')
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 3
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then master.times = 50 end
    end
    return check_busy(zhizaoGo)
end
function zhizaoGo() return go(zhizaoCheck, '�����', '�÷��') end
function zhizaoCheck()
    flag.idle = nil
    exe('score;hp;cha')
    checkBags()
    return checkWait(zhizaoXue, 0.8)
end
function zhizaoXue()
    if not locl.id["�ϲ÷�"] then return zhizaoBack() end
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
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt > 30 and hp.pot >
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
function letterLost()
    job.name = 'dolost'
    sLetterlost()
    go(letterLostBegin, "������", "����")
end
function letterLostBegin()
    if needvpearl == 1 and (condition.vpearl == 0 or not condition.vpearl) then
        return Govpearl()
    end
    if lostletter == 1 then
        exe('chakan letter')
        exe('look letter')
        tmp.cnt = 0
        create_timer_s('walkWaitX', 1, 'llagain')
    end
end
function llagain()
    if tmp.cnt then tmp.cnt = tmp.cnt + 1 end
    if not tmp.cnt or tmp.cnt > 2 then return llagain_finish() end
    exe('chakan letter')
    exe('look letter')
end
function llagain_finish()
    EnableTimer("walkWaitX", false)
    DeleteTimer("walkWaitX")
end
function sLetterlost()
    DeleteTriggerGroup("lostletter")
    create_trigger_t('lostletter1',
                     "^(> )*�����ҳ(\\N*)�鿴�����ˡ�$", '',
                     'goMark')
    create_trigger_t('lostletter2',
                     "^(> )*����˲�ע�⣬͵͵��ʧ����ż��ӽ���·�ߵĲݴԡ�$",
                     '', 'sendOk')
    create_trigger_t('lostletter3',
                     "^(> )*�ŷ��ϵ��ּ�ģ�����壬��֪�������䵽�˴���$",
                     '', 'sendOk')
    create_trigger_t('lostletter4', "^(> )*�㽫ʧ����ż㽻��", '',
                     'sendOk')
    create_trigger_t('lostletter5',
                     "^(> )*����������д�������˵����֡�$", '',
                     'lookXin')
    create_trigger_t('lostletter6', "^(> )*���ٿ����һ�㡣$", '',
                     'letterLostBegin')
    create_trigger_t('lostletter7',
                     "^(> )*�ŷ���д�ţ�(\\D*)\\((\\D*)\\)", '',
                     'lostName')
    -- create_trigger_t('lostletter8',"^[> ]*��������������(\\D*)һ�����֡�$",'','get_lost_locate')
    SetTriggerOption("lostletter1", "group", "lostletter")
    SetTriggerOption("lostletter2", "group", "lostletter")
    SetTriggerOption("lostletter3", "group", "lostletter")
    SetTriggerOption("lostletter4", "group", "lostletter")
    SetTriggerOption("lostletter5", "group", "lostletter")
    SetTriggerOption("lostletter6", "group", "lostletter")
    SetTriggerOption("lostletter7", "group", "lostletter")
    -- SetTriggerOption("lostletter8","group","lostletter")
    -- SetTriggerOption("lostletter8","keep_evaluating","y")
    llgo()
    EnableTriggerGroup("lostletter", true)
end
function goMark(n, l, w)
    llagain_finish()
    print('��ʼ��дʧ���ż�����ID')
    local m_cmd = w[2]
    OpenBrowser(m_cmd)
    return Markletter()
end
function Markletter()
    l_result = utils.inputbox(
                   "�����ż�����ID������������discard��",
                   "lostname", GetVariable("lostname"), "����", "12")
    if not isNil(l_result) then SetVariable("lostname", l_result) end
    return MarkName()
end
function MarkName()
    local lost_cmd = GetVariable("lostname")
    if lost_cmd == 'discard' then
        return exe('discard letter')
    else
        return exe('mark ' .. lost_cmd)
    end
end
function lookXin()
    lookxin = 1
    exe('look letter')
    create_timer_st('lookxin_again', 20, 'lookxin_again')
end
function lookxin_again() exe('look letter') end
function lostName(n, l, w)
    lost_name = string.lower(w[3])
    return create_timer_s('sendTo', 0.5, 'sendTo')
end
function sendXin()
    sLetterlost()
    create_timer_st('lookxin_again', 20, 'lookxin_again')
    return create_timer_s('sendTo', 0.5, 'sendTo')
end
function sendTo()
    exe('follow ' .. lost_name)
    exe('sendto ' .. lost_name)
end
function sendOk()
    job.name = 'idle'
    lookxin = 0
    lostletter = 0
    m_cmd = nil
    lostletter_locate = ''
    mousedown_lostletter() -- ����ˢ�µص�
    condition.vpearl = 0
    EnableTimer("sendTo", false)
    DeleteTimer('sendTo')
    EnableTimer("lookxin_again", false)
    DeleteTimer('lookxin_again')
    DeleteTriggerGroup("lostletter")
    EnableTriggerGroup("duhe", true)
    EnableTriggerGroup("dujiang", true)
    exe('follow none;cond;jobtimes')
    sendOk_fix()
    return check_food()
    -- return checkPrepareOver()--���ź󲻼��״̬��
end
function dolost_hitlog_open()
    local fn = GetInfo(67) .. "logs\\" .. score.id .. '_dolost��ɵ��¼_' ..
                   os.time() .. ".log"
    OpenLog(fn, false)
    WriteLog(
        "<!-- Produced by MUSHclient v 4.84 - [url]www.mushclient.com[/url] -->")
    WriteLog("[table=800,Black]")
    WriteLog("[tr][td][font=������]")
    ColourNote('Lime', 'black', '��ʼд���ɵ��¼��' .. fn .. '��')
end
function dolost_hitlog_close()
    ColourNote('Lime', 'black', '��¼��ɵ��ϣ�(by �޷���)')
    WriteLog("[/font][/td][/tr][/table]")
    CloseLog()
end
function check_xuexi()
    if MidHsDay[locl.time] and score.master == '������' then
        return check_job()
    end
    -- if needxuexi==0 then
    -- return check_job()
    -- end
    -- if needxuexi==1 then
    return check_pot()
    -- end
end
jobtimes = {}
function checkJobtimes(n, l, w) jobtimes[w[1]] = tonumber(w[2]) end
function checkJoblast(n, l, w)
    local joblast = {
        ["�䵱����"] = "wudang",
        ["��������"] = "songxin",
        ["ǿ����Ů"] = "xueshan",
        ["�Ͷ�����"] = "huashan",
        ["���ְ�"] = "clb",
        ["��ػ�"] = "tdh",
        ["��ɽ����"] = "songshan",
        ["ؤ������"] = "gaibang",
        ["��Ħ�¿�������"] = "songmoya"

    }

    if joblast[w[2]] then job.last = joblast[w[2]] end
end

function check_job()
    job_exp_tongji()
    if locl.weekday == '��' and locl.hour == 7 and locl.min >= 58 then
        if not flag.cun then
            Note('�������������ˣ�ȥ�涫����')
            return go(reboot_before_cun, "���ݳ�", "�ӻ���")
        end
    end
    if xcexp == 0 and hp.exp < 1000000 then
        print('Ѳ�ǵ�1M')
        kdummy = 0
        return xunCheng()
    end
    if xcexp == 1 and hp.exp < 2000000 then
        print('Ѳ�ǵ�2M')
        kdummy = 0
        return xunCheng()
    end
    create_triggerex_lvl('dmlflag1',
                         '^(> )*���������š���Ҿ������ʼ�ˣ�',
                         '', 'dml_on', 95)
    SetTriggerOption('dmlflag1', 'group', 'hp')
    if not dml_cnt then dml_cnt = 0 end
    if dml_cnt < 5 and (not condition.busy or condition.busy == 0) and vippoison ==
        0 then
        local fn = 'logs\\diemenglou_mark_' .. score.id .. '.log'
        local f = io.open(fn, "r")
        if not f then
            ColourNote('orange', 'black',
                       'δ��⵽����¥��¼��׼�����е���¥������')
            return dml_check()
        else
            local s = f:read()
            f:close()
            if s ~= os.date("%Y%m%d%H") then
                if os.date("%Y%m%d%H") - s >= 100 then
                    local x = tostring(os.date("%Y%m%d%H"))
                    local y1 = tonumber(string.sub(x, -4, -3))
                    if y1 == 1 then
                        local y = tonumber(string.sub(x, -2, -1))
                        s = tostring(s)
                        local z = tonumber(string.sub(s, -2, -1))
                        if y >= z then
                            ColourNote('lime', 'black', '�ҵ�' .. s ..
                                           '����¥��¼������Ϊ���졣׼�����е���¥������')
                            return dml_check()
                        else
                            ColourNote('white', 'red', '�ҵ�' .. s ..
                                           '����¥��¼��ʱ�������㡾',
                                       'yellow', 'black', '24', 'white', 'red',
                                       '��Сʱ����������¥������')
                        end
                    else
                        ColourNote('lime', 'black', '�ҵ�' .. s ..
                                       '����¥��¼������Ϊ���졣׼�����е���¥������')
                        return dml_check()
                    end
                else
                    ColourNote('white', 'red', '�ҵ�' .. s ..
                                   '����¥��¼��ʱ�������㡾',
                               'yellow', 'black', '24', 'white', 'red',
                               '��Сʱ����������¥������')
                end
            end
        end
    end
    if score.party == "�һ���" and (hp.shen > 150000 or hp.shen < -150000) then
        return thdJiaohui()
    end
    if condition.busy and condition.busy > 10 then
        return check_halt(weaponUcheck)
    end
    if job.last == "xueshan" or job.last == "wudang" or job.last == "songxin" or
        hsruntime ~= 0 then
        return check_halt(check_jobx) -- ѩɽ���䵱��������󲻼������״̬��ֱ������һ������
    else
        return check_halt(weaponUcheck)
    end
end

function check_jobx()
    for p in pairs(weaponUsave) do
        if Bag and not Bag[p] then job.zuhe["songmoya"] = nil end
    end
    --[[if score.id=='kkfromch' and (isInBags('����Ǭ����')==nil or isInBags('����Ǭ����')==nil or isInBags('���Ʒ�����')==nil) then
   return weapon_lost()
end]]
    if fqyytmp.goArmorD == 1 then return fqyyArmorGoCheck() end
    if job.zuhe == nil then job.zuhe = {} end
    if job.zuhe["zhuoshe"] and score.party ~= "ؤ��" then
        job.zuhe["zhuoshe"] = nil
    end
    if job.zuhe["sldsm"] and score.party ~= "������" then
        job.zuhe["sldsm"] = nil
    end
    if job.zuhe["songmoya"] and hp.exp < 5000000 then
        job.zuhe["songmoya"] = nil
    end
    if smydie * 1 >= smyall * 1 then job.zuhe["songmoya"] = nil end
    if job.zuhe["husong"] and (score.party ~= "������" or hp.exp < 2000000) then
        job.zuhe["husong"] = nil
    end
    if job.zuhe["songmoya"] and job.last ~= "songmoya" and mytime <= os.time() then
        return songmoya()
    end
    if job.zuhe["hubiao"] and job.last ~= "hubiao" and job.teamname and
        ((not condition.hubiao) or (condition.hubiao and condition.hubiao <= 0)) then
        return hubiao()
    elseif job.zuhe["husong"] then
        return husong()
    else
        return checkJob()
    end
end
function checkJob()
    if job.last ~= 'hqgzc' then
        local fn = 'logs\\hqgzc_mark_' .. score.id .. '.log'
        local f = io.open(fn, "r")
        if not f then
            return hqgzc()
        else
            local s = f:read()
            f:close()
            if s ~= os.date("%Y%m%d%H") then
                if os.date("%Y%m%d%H") - s >= 100 then
                    local x = tostring(os.date("%Y%m%d%H"))
                    local y1 = tonumber(string.sub(x, -4, -3))
                    if y1 == 1 then
                        local y = tonumber(string.sub(x, -2, -1))
                        s = tostring(s)
                        local z = tonumber(string.sub(s, -2, -1))
                        if y >= z then return hqgzc() end
                    else
                        return hqgzc()
                    end
                end
            end
        end
    end
    -- if hp.exp>2000000 then job.zuhe["zhuoshe"]=nil end
    -- if hp.shen>0 or hp.exp>6000000 then job.zuhe["songshan"]=nil end
    if job.zuhe["songxin2"] then
        job.zuhe["songxin2"] = nil
        job.zuhe["songxin"] = true
        flag.sx2 = true
    end
    if job.last and job.zuhe[job.last] then
        if type(job.zuhe[job.last]) == "number" then
            job.zuhe[job.last] = job.zuhe[job.last] + 1
        else
            job.zuhe[job.last] = 1
        end
    end
    if countTab(job.zuhe) > 2 and not skills["xixing-dafa"] and
        job.zuhe["huashan"] and job.zuhe["wudang"] and
        jobtimes["��ɽ����Ⱥ�Ͷ�����"] and
        jobtimes["�䵱��Զ��ɱ����"] then
        local t_hs = jobtimes["��ɽ����Ⱥ�Ͷ�����"]
        local t_wd = jobtimes["�䵱��Զ��ɱ����"]
        local t_times = math.fmod((t_hs + t_wd), 50)
        if t_times > 48 then
            exe('pray pearl')
            if job.last ~= "huashan" then
                return huashan()
            else
                for p in pairs(job.zuhe) do
                    if p ~= "huashan" and p ~= "wudang" and p ~= "hubiao" and p ~=
                        "husong" and p ~= "songmoya" then
                        return _G[p]()
                    end
                end
            end
        end
    end
    if score.party and score.party == "��ɽ��" and countTab(job.zuhe) > 2 and
        not skills["dugu-jiujian"] and job.zuhe["huashan"] and
        job.zuhe["songxin"] then
        local t_hs, t_sx, t_gb

        if jobtimes["��ɽ����Ⱥ�Ͷ�����"] then
            t_hs = jobtimes["��ɽ����Ⱥ�Ͷ�����"]
        else
            t_hs = 0
        end
        if jobtimes["����������������"] then
            t_sx = jobtimes["����������������"]
        else
            t_sx = 0
        end
        if jobtimes["ؤ���ⳤ��ɱ������"] then
            t_gb = jobtimes["ؤ���ⳤ��ɱ������"]
        else
            t_gb = 0
        end
        local t_times = math.fmod((t_hs + t_sx + t_gb), 50)
        if t_times > 47 then
            exe('pray pearl')
            if job.last ~= "huashan" then
                return huashan()
            else
                for p in pairs(job.zuhe) do
                    if p ~= "huashan" and p ~= "songxin" and p ~= "hubiao" and p ~=
                        "husong" and p ~= "songmoya" then
                        return _G[p]()
                    end
                end
            end
        end
    end

    if job.third and job.zuhe[job.third] and job.last ~= job.third then
        if job.second and job.last == job.second then
            if job.third == "wudang" and
                (not job.wdtime or job.wdtime <= os.time()) then
                return _G[job.third]()
            end
            if job.third ~= "wudang" and job.third ~= "songmoya" then
                return _G[job.third]()
            end
        end
    end
    if job.first and job.zuhe[job.first] and job.last ~= job.first then
        if job.first ~= "xueshan" and job.first ~= "wudang" and job.first ~=
            "songmoya" then return _G[job.first]() end
        if job.first == "xueshan" and
            ((not condition.xueshan) or
                (condition.xueshan and condition.xueshan <= 0)) then
            return _G[job.first]()
        end
        if job.first == "wudang" and (not job.wdtime or job.wdtime <= os.time()) then
            return _G[job.first]()
        end
        if job.first == "xueshan" and condition.xueshan and condition.busy and
            condition.busy >= condition.xueshan then
            return _G[job.first]()
        end
    end
    if job.second and job.zuhe[job.second] and job.last ~= job.second then
        if job.second ~= "xueshan" and job.second ~= "wudang" and job.second ~=
            "songmoya" then return _G[job.second]() end
        if job.second == "xueshan" and
            ((not condition.xueshan) or
                (condition.xueshan and condition.xueshan <= 0)) then
            return _G[job.second]()
        end
        if job.second == "wudang" and
            (not job.wdtime or job.wdtime <= os.time()) then
            return _G[job.second]()
        end
        if job.second == "xueshan" and condition.xueshan and condition.busy and
            condition.busy >= condition.xueshan then
            return _G[job.second]()
        end
    end

    for p in pairs(job.zuhe) do
        if job.last ~= p and job.first ~= p and job.second ~= p and p ~=
            "songmoya" then return _G[p]() end
    end

    for p in pairs(job.zuhe) do
        if job.last ~= p and p ~= "songmoya" then return _G[p]() end
    end
    if job.zuhe["xueshan"] and job.last ~= "xueshan" then return xueshan() end
    if job.zuhe["huashan"] and job.last ~= "huashan" then return huashan() end
    if job.zuhe["tmonk"] and job.last ~= "tmonk" then return tmonk() end
    if job.zuhe["songxin"] and job.last ~= "songxin" then return songxin() end
    if job.zuhe["wudang"] and job.last ~= "wudang" then return wudang() end
    if job.zuhe["gaibang"] and job.last ~= "gaibang" then return gaibang() end
    if job.zuhe["zhuoshe"] and job.last ~= "zhuoshe" then return zhuoshe() end
    if job.zuhe["sldsm"] and job.last ~= "sldsm" then return sldsm() end
    if job.zuhe["songshan"] and job.last ~= "songshan" then return songshan() end
    if job.last ~= "songxin" then return songxin() end
    if job.last ~= "xueshan" and hp.shen < 0 then return xueshan() end
    if job.last ~= "wudang" and hp.shen > 100000 then return wudang() end
    if job.last ~= "gaibang" and hp.exp < 2000000 and hp.shen > 0 then
        return gaibang()
    end
    if job.last ~= "songshan" and hp.shen < 0 and hp.exp < 2000000 then
        return songshan()
    end

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
        if score.party == "������" and skills["hand"] and
            skills["jieshou-jiushi"] then
            -- exe('bei none;jifa hand jieshou-jiushi;bei hand')
            return "jieshou-jiushi"
        end
        if score.party == "ؤ��" and skills["strike"] and
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
                     '^(> )*(\\D*)(��|��|��)(����|�ƽ�|ҼǪ����Ʊ)\\(',
                     '', 'checkBagsMoney')
    create_trigger_t('Yaobags2',
                     '^(> )*��� "action" �趨Ϊ "���ҩƷ" �ɹ���ɡ�$',
                     '', 'checkYaoBagsOver')
    create_trigger_t('Yaobags3', '^(> )*(\\D*)��ʧ����ż�', '',
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
    Bag["�ƽ�"].cnt = 0
    Bag["����"].cnt = 0
    tmp.yaobags = func
    exe('i;look bei nang')
    exe('alias action ���ҩƷ')
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
    if not Beinang then Beinang = {"��"} end
    for i = 1, #Beinang do
        if Beinang[i] == "" or Beinang[i] == nil then
            Beinang[i] = "���ݶ�ʧ"
        end
        local l_name = Beinang[i]
        if string.find(l_name, "���ɽ�ҩ") then
            cty_cur = trans(Beinang[i])
        end
        if string.find(l_name, "����Ϣ��") then
            nxw_cur = trans(Beinang[i])
        end
        if string.find(l_name, "������Ϣ��") then
            cbw_cur = trans(Beinang[i])
        end
        if string.find(l_name, "������Ϣ��") then
            hqd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "��Ѫ�ƾ���") then
            hxd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "�󻹵�") then
            dhd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "����ʯ") then
            kuang_cur = trans(Beinang[i])
        end
        -- print(cty_cur,nxw_cur,hxd_cur,dhd_cur)
    end
end

function checkBags(func)
    DeleteTriggerGroup("bags")
    create_trigger_t('bags1', "^(> )*������Я����Ʒ�ı������", '',
                     'checkBagsStart')
    create_trigger_t('bags2', "^\\d*:(\\D*) = (\\D*)$", '', 'checkBagsId')
    create_trigger_t('bags3',
                     '^(> )*��Ŀǰ�Ѿ�ӵ����(\\D*)��˽��װ����(\\D*)��$',
                     '', 'checkBagsU')
    create_trigger_t('bags4',
                     '^(> )*(\\D*)(��|��|��)(����|�ƽ�|ҼǪ����Ʊ)\\(',
                     '', 'checkBagsMoney')
    create_trigger_t('bags5',
                     '^(> )*��� "action" �趨Ϊ "������" �ɹ���ɡ�$',
                     '', 'checkBagsOver')
    create_trigger_t('bags6', '^(> )*(\\D*)��ʧ����ż�', '',
                     'checkBagsletter')
    create_trigger_t('bags7', '^(> )*(\\D*)ö����\\(', '', 'checkBagsDart')
    create_trigger_t('bags8',
                     '^(> )*�����ϴ���(\\D*)������\\(����\\s*(\\d*)\\.\\d*\\%\\)��',
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
    Bag["�ƽ�"] = {}
    Bag["�ƽ�"].id = {}
    Bag["�ƽ�"].cnt = 0
    Bag["����"] = {}
    Bag["����"].id = {}
    Bag["����"].cnt = 0
    Bag["ö����"] = {}
    Bag["ö����"].id = {}
    Bag["ö����"].cnt = 0
    tmp.bags = func
    weaponUsave = {}
    exe('id')
    checkWield()
    exe('look bei nang')
    exe('uweapon;alias action ������')
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
    if (string.find(l_name, "��ƪ") or string.find(l_name, "��Ҫ")) and
        not itemSave[l_name] then
        exe('read book')
        exe('drop ' .. Bag[l_name].fullid)
    end
    if string.len(l_name) == 6 and
        (string.sub(l_name, 5, 6) == "ҩ" or string.sub(l_name, 5, 6) == "��" or
            string.sub(l_name, 5, 6) == "��") and
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
        if string.find(q, '��') then q = string.sub(q, 3) end
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
    local l_name = 'ö����'
    if Bag[l_name] then Bag[l_name].cnt = l_cnt end
end
--[[function checkBagsYao(n,l,w)
   local l_cnt=trans(Trim(w[2]))
   local l_name=Trim(w[3])
  if string.find(l_name,"���ɽ�ҩ") then
	   cty_cur = l_cnt
	end
	if string.find(l_name,"������Ϣ��") then
	   nxw_cur = l_cnt
	end
	if string.find(l_name,"��Ѫ�ƾ���") then
	   hxd_cur = l_cnt
	end
	if string.find(l_name,"�󻹵�") then
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
    if Bag["�����"] then exe("drop cha") end
    if Bag["�޻�����"] then exe('drop ' .. Bag["�޻�����"].fullid) end
    if Bag["�޻�"] then exe('drop ' .. Bag["�޻�"].fullid) end
    if Bag["��ͭ"] then exe('drop ' .. Bag["��ͭ"].fullid) end
    if Bag["����"] then exe('drop ' .. Bag["����"].fullid) end
    if Bag["������"] and Bag["������"].cnt > 2 then
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
    if score.party and score.party == "������" and not Bag["����"] then
        return check_item_go()
    elseif score.party == "������" and not Bag["����"] and
        not Bag["����"] then
        return go(checkSengxie, '��ɽ����', '���߿�')
    else
        return check_item_over()
    end
end
function checkSengxie()
    exe('ask chanshi about ɮЬ')
    return check_bei(checkHuyao)
end
function checkHuyao()
    exe('ask chanshi about ����')
    return check_bei(checkHuwan)
end
function checkHuwan()
    exe('ask chanshi about ����')
    return check_bei(check_item_over)
end
function check_item_go() go(check_item_belt, '����ɽ', '�����') end
function check_item_belt()
    exe('ask shitai about Ƥ����')
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
    exe('ask laoban about ��Ա�ɳ�')
    check_bei(VIPask2)
end
function VIPask2()
    exe('ask laoban about ��Ա����')
    check_bei(Ebookcheck)
end
function Ebookcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Ebookcheck
    create_trigger_t('vipchk1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipEbookck')
    create_trigger_t('vipchk2', "^(> )*���������޷�ʹ�þ�Ӣ֮�顣",
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
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipYjwck')
    create_trigger_t('vipchk2', "^(> )*���������޷�ʹ�����衣",
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
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipYggo')
    create_trigger_t('vipchk2', "^(> )*���������޷�ʹ��ԧ�������",
                     '', 'Gstart')
    create_trigger_t('vipchk3', "^(> )*�������һ��ԧ�����", '',
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
function vipYggo() return go(vipGhyg, '�����', '���') end
function vipGhyg() exe('guihuan ying gu') end
function vipYgok() return go(vipYg, '���ݳ�', '����') end
function vipYg() exe('duihuan jinpa') end
function Vipcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id vipcheck
    create_trigger_t('vipchk1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipxidu')
    create_trigger_t('vipchk2', "^(> )*����쾦����Ѿ������ˡ�",
                     '', 'vipxidu_over')
    create_trigger_t('vipchk3', "^(> )*���������޷�ʹ��", '', 'vipover')
    create_trigger_t('vipchk4',
                     "^(> )*����Ҫ�������е���Ʒ�����ٴζһ���",
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
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipeatdhd')
    create_trigger_t('vipdhd2', "^(> )*��Ĵ󻹵��Ѿ������ˡ�", '',
                     'vipdhd_over')
    create_trigger_t('vipdhd3', "^(> )*���������޷�ʹ��", '', 'vipover')
    create_trigger_t('vipdhd4',
                     "^(> )*����Ҫ�������е���Ʒ�����ٴζһ���",
                     '', 'vipeatdhd')
    create_trigger_t('vipdhd5', "^(> )*������㣬�ⶫ���ܳ���",
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
        return go(Vipcheck, '���ݳ�', '����')
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
    exe('nick ��·��')
    if score.party and score.party == "������" then
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
        return go(check_heal_newbie, "���ݳ�", "ҩ��")
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
        if score.party == "������" and hp.neili > 2000 then
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
        return go(check_xue_ask, '������', '����')
    else
        return check_xue_fail()
    end
end
function check_xue_ask()
    DeleteTriggerGroup("ck_xue_ask")
    create_trigger_t('ck_xue_ask1',
                     '^(> )*����ѦĽ�������йء����ˡ�����Ϣ��$',
                     '', 'check_xue_accept')
    create_trigger_t('ck_xue_ask2', '^(> )*����û�������', '',
                     'check_xue_fail')
    SetTriggerOption("ck_xue_ask1", "group", "ck_xue_ask")
    SetTriggerOption("ck_xue_ask2", "group", "ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    create_trigger_t('ck_xue_accept1',
                     '^(> )*ѦĽ�����ٺٺ١���Ц�˼�����$', '',
                     'check_xue_teach')
    create_trigger_t('ck_xue_accept2',
                     '^(> )*һ����Ĺ����ȥ�ˣ�����������Ѿ�����Ȭ���ˡ�',
                     '', 'check_xue_heal')
    create_trigger_t('ck_xue_accept3',
                     '^(> )*Ѧ��ҽ�ó�һ�������������������˲�λ������Ѩ��',
                     '', 'check_xue_wait')
    create_trigger_t('ck_xue_accept4',
                     '^(> )*ѦĽ���ƺ����������˼��$', '',
                     'check_xue_heal')
    create_trigger_t('ck_xue_accept5',
                     '^(> )*ѦĽ����ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����',
                     '', 'check_xue_fail')
    SetTriggerOption("ck_xue_accept1", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept2", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept3", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept4", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept5", "group", "ck_xue_accept")
    EnableTriggerGroup("ck_xue_accept", false)
    DeleteTriggerGroup("ck_xue_teach")
    create_trigger_t('ck_xue_teach1',
                     '^(> )*Ѧ��ҽ����������Ѿ������ٽ����ˡ�$',
                     '', 'check_xue_next')
    SetTriggerOption("ck_xue_teach1", "group", "ck_xue_teach")
    EnableTriggerGroup("ck_xue_teach", false)
    DeleteTriggerGroup("ck_xue_busy")
    create_trigger_t('ck_xue_busy1', '^(> )*����Ъ������˵���ɡ�$',
                     '', 'check_xue_busy')
    SetTriggerOption("ck_xue_busy1", "group", "ck_xue_busy")
    EnableTriggerGroup("ck_xue_busy", true)
    exe('ask xue muhua about ����')
    create_timer_s('walkWait4', 3.0, 'check_xue_ask1')
end
function check_xue_ask1() exe('ask xue muhua about ����') end
function check_xue_busy() return check_busy(check_xue_ok, 2) end
function check_xue_ok()
    EnableTriggerGroup("ck_xue_accept", true)
    exe('ask xue muhua about ����')
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
    exe('set ����;hp;yun qi;yun jing;yun jingli;cond')
    exe('dazuo ' .. hp.dazuo)
end
function poison_dazuo()
    DeleteTriggerGroup("poison")
    create_trigger_t('poison1',
                     "^(> )*(����Ƭ�̣���о��Լ��Ѿ��������޼���|�㽫��������������֮�ư�����һ��|��ֻ��������ת˳����������������|�㽫������ͨ���������|��ֻ����Ԫ��һ��ȫ��������|�㽫��Ϣ���˸�һ������|�㽫��Ϣ����ȫ������ȫ���泩|�㽫�����������ڣ���ȫ��ۼ�����ɫ��Ϣ|�㽫����������������һ������|���˹���ϣ�վ������|��һ�������н������������ӵ�վ������|��ֿ�˫�֣�������������|�㽫��Ϣ����һ�����죬ֻ�е�ȫ��̩ͨ|������������������һ�����죬�����������ڵ���|������������������һ�����죬���������ڵ���|��˫��΢�գ���������ؾ���֮����������|���������������뵤������۾�|�㽫��Ϣ������һ��С���죬�������뵤��|��о�����ԽתԽ�죬�Ϳ�Ҫ������Ŀ����ˣ�|�㽫������Ϣ��ͨ���������������۾���վ������|������������һ��Ԫ����������˫��|�������뵤�������ת�����������չ�|�㽫����������������������һȦ���������뵤��|�㽫��Ϣ����������ʮ�����죬���ص���|�㽫��Ϣ���˸�С���죬���ص���չ�վ������|����Ƭ�̣������������Ȼ�ں���һ�𣬾����ӵ�վ����|��е��Լ��������Ϊһ�壬ȫ����ˬ��ԡ���磬�̲�ס�泩��������һ���������������۾�)",
                     '', 'poisondazuo_desc')
    create_trigger_t('poison2',
                     "^(> )*�����ھ��������޷�������Ϣ��������",
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
    return go(Brefine, '���ݳ�', '������')
end
function Brefine()
    if kuang_cur and kuang_cur > 2000 then
        kuang_cur = math.modf(kuang_cur / 1000) * 1000
    else
        kuang_cur = 1000
    end
    kuangshi = "tiekuang shi"
    DeleteTriggerGroup("refine")
    create_trigger_t('refine1', "^(> )*��û���㹻������ʯ��", '',
                     'refineGold')
    create_trigger_t('refine2', "^(> )*��û���㹻�Ľ��ʯ��", '',
                     'refineOK')
    create_trigger_t('refine3',
                     "^(> )*��Ŭ���ش߶�¯��ʼ��������ʯ", '',
                     'refinecheck')
    create_trigger_t('refine4', "^(> )*��Ҫ������ʯ������������ǧ",
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
        fqyyArmorMessage('������ʯ��ϣ�')
        return checkWait(checkPrepare)
    end)
end

function check_food()
    exe('cha') -- �Զ������������趨��
    set_sxlian()
    if score.gender == '��1' then -- ����ר�ã���շ���
        map.rooms["city/mingyufang"].ways["north"] = nil
        map.rooms["changan/eastjie1"].ways["north"] = nil
    end
    map.rooms["sld/lgxroom"].ways["#outSld"] = "huanghe/huanghe8"
    if score.party == '��ɽ��' and hp.shen < 0 then
        map.rooms["huashan/houtang"].ways["north"] = nil
        map.rooms["huashan/qianting"].ways["south"] = nil
    end
    if score.party == '����Ľ��' then
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
    exe('nick ȥ�䵱�Ժ�;remove all;wear all')
    exe('hp;unset no_kill_ap;yield no')
    if (hp.food < 60 or hp.water < 60) and hp.exp < 500000 then
        return go(dali_eat, '�����', '���')
    elseif hp.food < 60 or hp.water < 60 then
        return go(wudang_eat, '�䵱ɽ', '��ͤ')
    else
        check_bei(check_food_over)
    end
end
function wudang_eat()
    if locl.room == "��ͤ" then
        flag.food = 0
        DeleteTimer("food")
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#4(drink cha);drop cha;drop tao;fill jiudai')
        check_bei(check_food_over)
    else
        return go(wudang_eat, '�䵱ɽ', '��ͤ')
    end
end
function check_food_over()
    if (kuang_cur and kuang_cur > 2000) or (kuang_cur1 and kuang_cur1 > 2000) then
        return Ronglian()
    end
    return check_heal()
end

function dali_eat()
    if locl.room == "���" then
        flag.food = 0
        DeleteTimer("food")
        exe('#5(drink);e;e;s;buy baozi;#2(eat baozi)')
        check_bei(check_food_over)
    else
        return go(dali_eat, '�����', '���')
    end
end

function check_pot(p_cmd)
    if hp.exp < 5000000 then
        l_pot = hp.pot_max - 100
    else
        l_pot = hp.pot_max - 200
    end
    flag.lingwu = 0
    local l_skill
    if perform.skill then l_skill = skillEnable[perform.skill] end

    job_exp_tongji()

    for p in pairs(skillEnable) do
        if skills[p] then
            q = skillEnable[p]
            -- ain ��ǰ����
            if q and skills[q] and q ~= "force" and
                (skills[q].lvl > 219 or
                    (score.party == "��ͨ����" and skills[q].lvl > 100)) and
                skills[q].lvl < hp.pot_max - 100 and skills[q].lvl <=
                skills[p].lvl and hp.pot >= l_pot then
                flag.lingwu = 1
            end
        end
    end
    if GetVariable("lingwuskill") or
        (tmp.xskill and skills[tmp.xskill] and skillEnable[tmp.xskill] and
            skills[skillEnable[tmp.xskill]]) then
        flag.lingwu = 0

        if tmp.xskill and skills[tmp.xskill] and skillEnable[tmp.xskill] and
            skills[skillEnable[tmp.xskill]] then
            local p = tmp.xskill
            local q = skillEnable[p]
            if skills[q].lvl < hp.pot_max - 100 and skills[q].lvl <=
                skills[p].lvl and skills[q].lvl < hp.pot_max - 100 then
                flag.lingwu = 1
            end
        end
        if GetVariable("lingwuskill") then
            local q = GetVariable("lingwuskill")
            for p in pairs(skills) do
                if skillEnable[p] == q and skills[q].lvl < hp.pot_max - 100 and
                    skills[q].lvl <= skills[p].lvl and skills[q].lvl <
                    hp.pot_max - 100 then flag.lingwu = 1 end
            end
        end
    end
    if score.party == "��ͨ����" and hp.pot >= l_pot and score.gold and
        skills["literate"] and score.gold > 3000 and skills["literate"].lvl <
        hp.pot_max - 100 then return literate() end
    if score.party == "��ͨ����" and hp.pot >= l_pot and skills["parry"].lvl <
        hp.pot_max - 100 and skills["parry"].lvl >= 101 then flag.lingwu = 1 end
    if score.party == "��ͨ����" and flag.lingwu == 1 then
        return checklingwu()
    end

    if score.party == "��ͨ����" and skills["force"].lvl > 50 then
        if skills["force"].lvl < 101 then return huxi() end
        if score.party == "��ͨ����" and skills["force"].lvl == 101 then
            exe('fangqi force 1;y;y;y')
            return huxi()
        end
        if score.party == "��ͨ����" and skills["shenzhao-jing"] and
            skills["shenzhao-jing"].lvl < 200 then return learnSzj() end
    end

    if score.party ~= "��ͨ����" and hp.pot >= l_pot and flag.autoxuexi and
        flag.autoxuexi == 1 then
        if score.gold and skills["literate"] and score.gold > 3000 and
            skills["literate"].lvl < hp.pot_max - 100 then
            return literate()
        end

        if score.party ~= "��ͨ����" then
            for p in pairs(skills) do
                local q = qrySkillEnable(p)
                if q and q['force'] and perform.force and p == perform.force and
                    skills[p].lvl < 100 and hp.pot >= l_pot then
                    if skills[p].mstlvl and skills[p].mstlvl <= skills[p].lvl then
                    else
                        return checkxue()
                    end
                end
            end

            for p in pairs(skills) do
                if flagFull[p] and not skillEnable[p] and skills[p].lvl < 450 and
                    skills[p].lvl <= skills["dodge"].lvl and hp.pot >= l_pot then
                    if not skills[p].mstlvl or skills[p].mstlvl > skills[p].lvl then
                        return checkxue()
                    end
                end
            end

            if score.party ~= "��ͨ����" and perform.skill and
                skills[perform.skill] and skills[perform.skill].lvl < 450 and
                hp.pot >= l_pot then return checkxue() end

            if flag.type and flag.type ~= 'lingwu' and flag.xuexi == 1 and
                hp.pot >= l_pot then return checkxue() end
        end
        if hp.pot >= l_pot and skills["parry"] and skills["parry"].lvl <
            hp.pot_max - 100 and skills["parry"].lvl >= 450 then
            flag.lingwu = 1
        end
        if flag.lingwu == 1 then return checklingwu() end

        if flag.xuexi == 1 and score.party ~= "��ͨ����" then
            return checkxue()
        end

        if hp.pot >= l_pot then
            if skills["wuxiang-zhi"] then
                if not flag.wxjz then flag.wxjz = 0 end
                if flag.wxjz == 0 and skills["finger"].lvl >
                    skills["wuxiang-zhi"].lvl and skills["wuxiang-zhi"].lvl <
                    hp.pot_max - 100 then return wxjzFofa() end
            end
        end
    end
    return check_job()

end

function checkHammer() return go(checkHmGive, "���ݳ�", "������") end
function checkHmGive()
    if Bag["Τ��֮��"] then
        exe('give ' .. Bag["Τ��֮��"].fullid .. ' to zhujian shi')
    end
    Bag["Τ��֮��"] = nil
    return checkPrepare()
end

function check_gold()
    tmp.cnt = 0
    return go(check_gold_dali, "�����", "����Ǯׯ")
end
function check_gold_dali()
    if not locl.id["���ƹ�"] then
        return go(check_gold_xy, "������", "����ի")
    else
        return check_gold_count()
    end
end
function check_gold_xy()
    if not locl.id["Ǯ����"] then
        return go(check_gold_cd, "�ɶ���", "ī��ի")
    else
        return check_gold_count()
    end
end
-- function check_gold_cd()
--    if not locl.id["���ƹ�"] then
--	   return go(check_gold_yz,"���ݳ�","���ի")
--	else
--	   return check_gold_count()
--	end
-- end
-- ain
function newbie_qu_gold() return go(check_gold_qu, "�����", "����Ǯׯ") end
function check_gold_cd()
    if not locl.id["Ǯ��"] then
        return go(check_gold_dali, "�����", "����Ǯׯ")
    else
        return check_gold_count()
    end
end
function check_gold_count()
    if Bag['ҼǪ����Ʊ'] and Bag['ҼǪ����Ʊ'].cnt > 10 then
        exe('score;chazhang')
        if score.goldlmt and score.gold and (score.goldlmt - score.gold) > 50 then
            return check_cash_cun()
        end
    end
    if Bag and Bag["����"] and Bag["����"].cnt and
        (Bag["����"].cnt > 100 or Bag["����"].cnt < 50) then
        return check_silver_qu()
    end
    if (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt >
            count.gold_max * 4) then return check_gold_qu() end

    return check_gold_over()
end
function check_cash_cun()
    if Bag['ҼǪ����Ʊ'] then
        local l_cnt
        if score.goldlmt and score.gold and (score.goldlmt - score.gold) <
            Bag['ҼǪ����Ʊ'].cnt * 10 then
            l_cnt = math.modf((score.goldlmt - score.gold) / 10) - 1
        else
            l_cnt = Bag['ҼǪ����Ʊ'].cnt
        end
        if l_cnt > 0 then exe('cun ' .. l_cnt .. ' cash') end
    end
    checkBags()
    return checkWait(check_gold_check, 3)
end
function check_silver_qu()
    local l_cnt = Bag["����"].cnt - 50
    exe('cun ' .. l_cnt .. ' silver')
    exe('qu 50 silver')
    -- checkBags()
    -- return checkWait(check_gold_check,3)
    return checkPrepareOver()
end
function check_gold_qu()
    local l_cnt = Bag["�ƽ�"].cnt - count.gold_max * 2
    exe('cun ' .. l_cnt .. ' gold')
    if Bag["�ƽ�"].cnt < count.gold_max then
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
    return go(checkZqdBuy, randomElement(drugBuy["������"]))
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
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 and
        (not Bag["������"] or Bag["������"].cnt < 4) then
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
    return go(checkXqwBuy, randomElement(drugBuy["а����"]))
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
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 and
        (not Bag["а����"] or Bag["а����"].cnt < 4) then
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
        return go(checkNxwBuy, randomElement(drugBuy["��Ϣ��"]))
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
        if nxw_cur < count.nxw_max then exe('buy ' .. drug.neili1) end
        checkYaoBags()
        return check_bei(checkNxwi)
    end
end
function checkNxwi()
    if (nxw_cur < count.nxw_max or cbw_cur < count.cbw_max or hqd_cur <
        count.hqd_max) and Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 then
        return checkWait(checkNxwBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkNxwOver() return check_bei(checkPrepare, 1) end

function checkHxd()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and cty_cur < count.cty_max then
        return go(checkHxdBuy, randomElement(drugBuy["���ɽ�ҩ"]))
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
    if cty_cur < count.cty_max and Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 then
        return checkWait(checkHxdBuy, 1)
    else
        return checkNxwOver()
    end
end

function checkLjd()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and hxd_cur < count.hxd_max then
        return go(checkLjdBuy, randomElement(drugBuy["��Ѫ�ƾ���"]))
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
    if hxd_cur < count.hxd_max and Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 then
        return checkWait(checkLjdBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkdhd()
    tmp.cnt = 0
    if score.tb and score.tb > 100 and dhd_cur < count.dhd_max then
        return go(checkdhdBuy, randomElement(drugBuy["�󻹵�"]))
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
    if not Bag["����"] then
        return go(checkFireBuy, randomElement(drugBuy["����"]))
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
    if not Bag["ţƤ�ƴ�"] then
        return go(checkJiudaiBuy, randomElement(drugBuy["ţƤ�ƴ�"]))
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
    return go(checkYuCun, "���ݳ�", "�ӻ���")
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
    return go(checkSellDo, "���ݳ�", "����")
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
            return checkWait(checkWeaponI, 3)
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
        exe('pfmset')
    end
    l_result = utils.inputbox("��Ŀ���PFM(��ʹ��������PFM)��?",
                              "pfmks", GetVariable("pfmks"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmks", l_result)
        l_pfm = l_result
        create_alias('pfmks', 'pfmks', 'alias pfmpfm ' .. l_pfm)
        Note("����PFM")
        exe('pfmks')
    end
    l_result = utils.inputbox(
                   "����Ľ�ݽ����õ�PFM(ʹ�ò��ý����Կ���Ľ�ݵ�skills,Ľ�ݽ���������Ϊ����)��?",
                   "pfmmrjf", GetVariable("pfmmrjf"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmmrjf", l_result)
        l_pfm = l_result
        create_alias('pfmmrjf', 'pfmmrjf', 'alias pfmpfm ' .. l_pfm)
        Note("���ý���PFM")
        exe('pfmmrjf')
    end
    l_result = utils.inputbox(
                   "��������ʥ���PFM(ʹ���������������̵�skills��ʥ���������Ϊ����)��?",
                   "pfmshlf", GetVariable("pfmshlf"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmshlf", l_result)
        l_pfm = l_result
        create_alias('pfmshlf', 'pfmshlf', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        exe('pfmshlf')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(ʹ�������Ե�skills�����������Ĺ���Ϊ��)��?",
                   "pfmwu", GetVariable("pfmwu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmwu", l_result)
        l_pfm = l_result
        create_alias('pfmwu', 'pfmwu', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        exe('pfmwu')
    end
    l_result = utils.inputbox("��д��Ŀ���������PFM��?", "pwu",
                              GetVariable("pwu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pwu", l_result)
        l_pfm = l_result
        create_alias('pwu', 'pwu', 'alias pfmpfm ' .. l_pfm)
        Note("����������PFM")
        exe('pwu')
    end
    l_result = utils.inputbox(
                   "��д��Ŀ�����PFM(ʹ�ÿ����Ե�skills)��?",
                   "pkong", GetVariable("pkong"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pkong", l_result)
        l_pfm = l_result
        create_alias('pkong', 'pkong', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        exe('pkong')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(�����书����)��?",
                   "pfmsanqing", GetVariable("pfmsanqing"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmsanqing", l_result)
        l_pfm = l_result
        create_alias('pfmsanqing', 'pfmsanqing', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        exe('pfmsanqing')
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
        exe('pfmzhen')
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
        exe('pfmqi')
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
        exe('pfmgang')
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
        exe('pfmrou')
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
        exe('pfmkuai')
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
        exe('pfmman')
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
        exe('pfmmiao')
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
        exe('pfmxian')
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
    exe('pfmset')
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
            hqgzcjl = l_result
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
    create_alias('sz', '^sz(.*)$', 'goto("%1")')
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
function dolostletter()
    l_result = utils.inputbox(
                   "�����뵱ǰʧ����ſɽ���������? Ĭ��Ϊ10�⣡",
                   "mylostletter", GetVariable("mylostletter"), "����", "12")
    if not isNil(l_result) then
        SetVariable("mylostletter", l_result)
        lostno = l_result
    end
    l_result = utils.msgbox("�Ƿ���LL", "ʧ�����", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('������LL')
        needdolost = 1
        switch_name4 = "ʧ����ż�--��"
    else
        needdolost = 0
        switch_name4 = "ʧ����ż�--��"
        print('�ر���LL')
    end
    l_result = utils.msgbox("��LL�Ƿ��Զ���Vpearl", "�Զ���Vpearl",
                            "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('�����Զ��һ�Vpearl')
        needvpearl = 1
    else
        print('�ر��Զ��һ�Vpearl')
        needvpearl = 0
    end
end
function dolostAg()
    l_result = utils.msgbox(
                   "��Ҫ����ʧ�������YES����10�⣬NO���˲�����",
                   "����", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('����ʧ�����10�Σ�')
        lostno = lostno + 10
        dis_all()
        return go(dhlost, '���ݳ�', '����')
    else
        needdolost = 0
        print('�ر���LL')
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
    exe('nick �������ˮ������')
    messageShow('�����أ�ȥĽ�������ֻ�ȥ�ˣ�', 'white')
    go(dzxy1_unwield, '������', '��ˮ��')
end
function dzxy2_go()
    exe('nick �����뻹ʩˮ������')
    messageShow('�����أ�ȥĽ�������ؼ�ȥ�ˣ�', 'white')
    go(dzxy2_unwield, '������', '��ʩˮ��')
end
function dzxy3_go()
    exe('nick ���������̨����')
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
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)

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
    local leweapon = GetVariable("learnweapon")
    exe('unwield ' .. leweapon)
    exe('jump down')
    return go(xueshan_finish_ask, '��ѩɽ', '���Ŀ�')
end
-----�Զ�����������----
function dazuo_lianxi_auto()
    tmp_lxskill =
        'bei none;unwield sword;unwield sword 2;uweapon shape lianyu sword;unwield xiao;'
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
                                  ';wield sword;lian sword ' .. lianxi_times ..
                                  ';unwield sword;yun jingli;'
            end
            if skillEnable[p] == "whip" then
                tmp_lxskill = tmp_lxskill .. 'wield whip;lian whip ' ..
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
                                  ';wield blade;lian blade ' .. lianxi_times ..
                                  ';unwield blade;yun jingli;'
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
                tmp_lxskill = tmp_lxskill .. 'wield hammer;lian hammer ' ..
                                  lianxi_times .. ';unwield hammer;yun jingli;'
            end
            if skillEnable[p] == "hook" then
                tmp_lxskill = tmp_lxskill .. 'wield hook;lian hook ' ..
                                  lianxi_times .. ';unwield hook;yun jingli;'
            end
            if skillEnable[p] == "dagger" then
                tmp_lxskill = tmp_lxskill .. 'wield dagger;lian dagger ' ..
                                  lianxi_times .. ';unwield dagger;yun jingli;'
            end
        end
    end
    tmp_lxskill = tmp_lxskill .. 'hp;unset ����;bei finger'
end
function set_sxlian()
    dazuo_lianxi_auto()
    create_alias('sx1lian', 'sx1lian', 'alias sxlian ' .. tmp_lxskill)
    exe('sx1lian')
end
function weapon_lost() return go(weapon_lost_get, '���ݳ�', '����') end
function weapon_lost_get()
    exe('duihuan husky;get all')
    scrLog()
    messageShow('������ʧ���һ���ʿ���һأ�', 'red')
    return check_halt(check_food)
end
function kedian_sleep()
    if locl.area == '������' then
        exe('up;n;sleep')
    else
        exe('up;enter;sleep')
    end
    checkWait(locate, 3)
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
function check_dny()
    exe('nick �ֽ�Ǭ����Ų��')
    return go(taojiao_dny, "mingjiao/sht", '')
end
function taojiao_dny()
    dnyTrigger()
    if locl.id[score.master] then
        EnableTriggerGroup("qk_dny", true)
        weapon_unwield()
        local leweapon = GetVariable("learnweapon")
        exe('wield ' .. leweapon)
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
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('cha;unwield ' .. leweapon)
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
