luapath = string.match(GetInfo(35), "^.*\\")
mclpath = GetInfo(67)
include = function(str) dofile(luapath .. str) end
loadmod = function(str) include("mods\\" .. str .. ".lua") end

require "wait"
require "tprint"
require "addxml"
require "socket"

loadmod "config"
loadmod "utils"
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
loadmod "xuezhu"
loadmod "chuanfu"
loadmod "jinhe"

test = test or function() print("initial behavior, does nothing") end

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
    wipe = 0,
    xuezhu = false
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
drug.heal = "chantui yao"
drug.neili = "neixi wan"
drug.neili2 = "chuanbei wan"
drug.neili3 = "huangqi dan"
drug.jingxue = "huoxue dan"
bags = {}
Bag = {}
team = {}
xcexp = 1
lingwudie = 0
needxuexi = 1
xxpot = 0
xuefull = 0
lookxin = 0
leweapon = "none"
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
need_dzxy = "yes"
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
ll.area = ""
ll.room = ""
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
check_step_num = 0
check_step_num1 = 0
check_step_num2 = 0
common_walk = 1
check_step_time = os.clock()
g_stop_flag = false

SMYID = {
    -- �䵱ʧ�ܿ�����ɽ��id
    ["kkfromch"] = true,
    ["xiaogao"] = false,
    ["kuer"] = false
    -- ["cxls"] = false,
    -- ["liumaisj"] = false,
}

pker = {}
pker_name = "none"
pker_id = "none"

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
    create_trigger_t("main", "^���齣\\D*��\\D*�Ѿ�����ִ����", "",
                     "login")
    create_trigger_t("main1", "^Are you using BIG5 font\\(y/N\\)? ", "",
                     "login_choose")
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
    Bag = {}
    weaponUsave = {}
    Chuanfu:addtrigger()

    local xuezhu = GetVariable("xuezhu_status")
    if xuezhu and (xuezhu == "2" or xuezhu == "1") then inwdj = 1 end
    checkBags()
    map.rooms["sld/lgxroom"].ways["#outSld"] = "huanghe/huanghe8"
    exe(
        "down;alias askk ask $*;stand;halt;uweapon;score;cha;hp;jifa all;jiali max;unset no_kill_ap;cond;pfmset")
    return check_bei(hp_dazuo_count)
end

function login_choose() Send("n") end

function login()
    dis_all()
    DeleteTriggerGroup("login")
    create_trigger_t("login1", "^���ϴ����ߵ�ַ��", "", "logincheck")
    create_trigger_t("login2",
                     "^����������������ʶ������\\(passwd\\)��",
                     "", "login_passwd")
    SetTriggerOption("login1", "group", "login")
    SetTriggerOption("login2", "group", "login")
    local l_id = GetVariable("id")
    local l_passwd = GetVariable("passwd")
    Note(l_id, l_passwd)
    if l_id ~= nil and l_passwd ~= nil then
        Send(l_id)
        Send(l_passwd)
        Send("y")
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
    -- if lookxin == 1 and job.name == 'dolost' then sendXin() end
    EnableTrigger("main", true)
    EnableTrigger("main1", true)
    EnableTriggerGroup("hp", true)
    EnableTriggerGroup("score", true)
    EnableTriggerGroup("chuanfu", true)
    -- ain
    EnableTrigger("pk1", true)
    EnableTrigger("pk2", true)
    EnableTriggerGroup("buyao", true)
    if job.name == "diemenglou" then
        dmlTriggers()
        EnableTrigger("dmlfight1", true)
    end
    flag.find = 1
    resume_walk_thread("kill")
    if job.name == "hubiao" then
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
    EnableTrigger("main", true)
    EnableTrigger("main1", true)
    -- EnableTrigger('idle',true)
    EnableTriggerGroup("chat", true)
    EnableTriggerGroup("hp", true)
    EnableTriggerGroup("chuanfu", true)
    EnableTriggerGroup("score", true)
    EnableTriggerGroup("count", true)
    EnableTriggerGroup("fight", true)
    EnableTriggerGroup("job_exp", true)
    EnableTrigger("hp12", false)
    -- if lookxin == 1 and job.name == 'dolost' then sendXin() end
    -- ain
    EnableTrigger("pk1", true)
    EnableTrigger("pk2", true)
    EnableTriggerGroup("buyao", true)
    beihook = test
    busyhook = test
    waithook = test
    flag.find = 1
    resume_walk_thread("kill")
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
function checkQuit()
    -- dis_all()
    -- check_halt(BQuit)
    if job.name == "idle" then check_food() end
    exe("drink jiudai")
end
function BQuit() exe("quit") end
function checkfood()
    if job.name == "songmoya" or (job.name ~= nil and job.name ~= "idle") then
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
            exe("jifa force " .. p)
        end
        if sk and not sk["force"] then
            for q in pairs(sk) do
                if skills[q] and skills[p].lvl >= skills[q].lvl then
                    exe("jifa " .. q .. " " .. p)
                end
            end
        end
    end
end
function jifaDodge()
    for p in pairs(skills) do
        q = skillEnable[p]
        if q == "dodge" and skills[q] and skills[p].lvl >= skills[q].lvl then
            exe("jifa " .. q .. " " .. p)
            break
        end
    end
end

function yunAddInt()
    if perform.force and perform.force == "linji-zhuang" then
        exe("yun zhixin")
    end
    --[[if perform.force and perform.force=="bihai-chaosheng" then
       exe('yun qimen')
    end]]
    if perform.force and perform.force == "yunu-xinjing" then
        exe("yun xinjing")
    end
end

function wuxingzhen()
    DeleteTemporaryTriggers()
    flag.times = 1
    return go(wuxingzhenCheck, "������", "�Է�")
end
function wuxingzhenCheck()
    if locl.id["�·�ɽ"] then
        return wuxingzhenStart()
    else
        local l_cnt = table.getn(getRooms("�Է�", "������"))
        flag.times = flag.times + 1
        if flag.times > l_cnt then
            return wuxingzhenFinish()
        else
            local l_sour = getRooms("�Է�", "������")[flag.times - 1]
            return go(wuxingzhenCheck, "������", "�Է�", l_sour)
        end
    end
end
function wuxingzhenStart()
    exe("yun jing")
    exe("ask wen fangshan about ������")
    if math.random(1, 5) == 1 then
        exe("cha;hp")
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

function dzxy_trigger()
    DeleteTriggerGroup("dzxy")
    create_trigger_t("dzxy1",
                     "^>*\\s*���������죬̫����������У����ƶ�䣬����˳���Ʋ�ı�Ե���������������Щ���ۡ�",
                     "", "dzxy_finish")
    create_trigger_t("dzxy2",
                     "^>*\\s*���������죬���Ϸ��ǵ�㣬���������Ƕ����ƶ�������ѧ�ġ���ת���ơ���Ī�����ϵ��ȴ����ʵս���鲻�㣬�޷����㿴���Ķ�����ʵ����ս��ϵ��һ��",
                     "", "dzxy_finish")
    create_trigger_t("dzxy3",
                     '^>*\\s*��� "action" �趨Ϊ "Ľ�ݶ�ת����" �ɹ���ɡ�',
                     "", "dzxy_goon")
    create_trigger_t("dzxy4", "^>*\\s*�������������", "", "dzxy_finish")
    create_trigger_t("dzxy5",
                     "^>*\\s*�ȴ�ľ׮��������\\(down\\)��˵�ɣ�",
                     "", "dzxy_finish")
    create_trigger_t("dzxy6",
                     "^>*\\s*��ϲ��ϲ�����Ѿ��ڻ��ͨ�˶�ת���Ƶľ���֮����",
                     "", "dzxy_finish")
    create_trigger_t("dzxy7",
                     "^>*\\s*���Ѿ�û��Ǳ��������ѧϰ��ת�����ˡ�",
                     "", "dzxy_finish")

    create_trigger_t("dzxy8",
                     "^>*\\s*���������죬���Ϸ��ǵ�㣬��˳�����ӵķ���ȥ��ȴ���ֲ��ֵ�ҹ�ձ���Χ�����ڵ�ס�ˡ�",
                     "", "dzxy_goon")
    SetTriggerOption("dzxy1", "group", "dzxy")
    SetTriggerOption("dzxy2", "group", "dzxy")
    SetTriggerOption("dzxy3", "group", "dzxy")
    SetTriggerOption("dzxy4", "group", "dzxy")
    SetTriggerOption("dzxy5", "group", "dzxy")
    SetTriggerOption("dzxy6", "group", "dzxy")
    SetTriggerOption("dzxy7", "group", "dzxy")
    SetTriggerOption("dzxy8", "group", "dzxy")
    EnableTriggerGroup("dzxy", false)
    DeleteTimer("mr_dzxy_timer")
    -- create_timer_m('mr_dzxy_timer',4,'dzxy_finish')
end

function checkdzxy()
    dis_all()
    tmp = {}
    -- jobTriggerDel()
    job.name = "heal"
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
            "�����أ�Ľ������ת����������������������",
            "white")
        print("dzxy_level:" .. dzxy_level)
    end

    return go(xueshan_finish_ask, "��ѩɽ", "���Ŀ�")
end
function open_dzxy_timer()
    return create_timer_m("mr_dzxy_timer", 4, "dzxy_finish")
end
function dzxy()
    DeleteTemporaryTriggers()
    dzxy_trigger()

    if dzxy_level == 1 then return check_busy(dzxy1_go) end
    if dzxy_level == 2 then return check_busy(dzxy2_go) end
    if dzxy_level == 3 then return check_busy(dzxy3_go) end
end
function dzxy1_go()
    messageShow("�����أ�ȥĽ�������ֻ�ȥ�ˣ�", "white")
    go(dzxy1_unwield, "������", "��ˮͤ")
end
function dzxy2_go()
    messageShow("�����أ�ȥĽ�������ؼ�ȥ�ˣ�", "white")
    go(dzxy2_unwield, "������", "��ʩˮ��")
end
function dzxy3_go()
    messageShow("�����أ�ȥĽ�ݿ�����ȥ�ˣ�", "white")
    go(dzxy3_unwield, "������", "����̨")
end
function dzxy1_unwield()
    flag.idle = 0
    -- open_dzxy_timer()
    weapon_unwield()
    exe("jump liang")
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
    exe("jump zhuang")
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
                hp.neili .. "��", "white")
        return check_busy(dzxy_finish)
    else
        if dzxy_level == 1 then
            exe("hp;yun jing;#10(lingwu zihua)")
            -- EnableTimer('mr_dzxy_timer',false)
            return check_bei(dzxy_alias, 1)
        end
        if dzxy_level == 2 then
            exe("hp;yun jing;#10(lingwu miji)")
            -- EnableTimer('mr_dzxy_timer',false)
            return check_bei(dzxy_alias, 1)
        end
        if dzxy_level == 3 then
            exe("hp;yun jing;#7(look sky)")
            -- EnableTimer('mr_dzxy_timer',false)
            return check_bei(dzxy_alias, 1)
        end
    end
end
function dzxy_alias() exe("alias action Ľ�ݶ�ת����") end

function dzxy_finish()
    EnableTimer("mr_dzxy_timer", false)
    DeleteTimer("mr_dzxy_timer")
    messageShow("�����أ�Ľ�ݶ�ת������ɣ�")
    exe("jump down")
    EnableTriggerGroup("dzxy", false)
    DeleteTriggerGroup("dzxy")
    exe("cha;hp")
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('unwield ' .. leweapon)
    exe("jump down")
    return go(xueshan_finish_ask, "��ѩɽ", "���Ŀ�")
end

----������ת��----
function turnShen(x)
    if x and x == "+" then
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
    if x and x == "-" then
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

-----�һ�����ʯͷ----
function stoneSet()
    stonePrepare = {}
    local t = {["�ྦྷʯ"] = "�ྦྷʯ", ["����ʯ"] = "����ʯ"}
    if GetVariable("stoneprepare") then
        tmp.stone = utils.split(GetVariable("stoneprepare"), "|")
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
            l_result = l_result .. "|" .. p
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
        tmp.stone = utils.split(GetVariable("stoneprepare"), "|")
        for _, p in pairs(tmp.stone) do stonePrepare[p] = true end
    end
    return duihuan_Stone()
end
function duihuan_Stone()
    if MidNight[locl.time] then
        ColourNote("red", "blue",
                   "�鱦����ţ��޷���ʯͷ�����һ���ٳ��ԣ�")
    else
        return go(duihuan_prepare, "���ݳ�", "����")
    end
end
function duihuan_prepare()
    tmp.redstone = 0
    tmp.bluestone = 0
    flag.redstone = false
    flag.bluestone = false
    flag.duihuan = 0
    DeleteTriggerGroup("duihuanstone")
    create_trigger_t("duihuanstone1",
                     "^(> )*�����ϰ�ߺ��һ����" .. score.name ..
                         "�һ����Ƽ�����(�ྦྷʯ|����ʯ).*", "",
                     "stone_consider")
    create_trigger_t("duihuanstone2",
                     "^(> )*���ϰ�һ��ץ��(�ྦྷʯ|����ʯ)�������ۣ��ö���ѽ����",
                     "", "maistone_set")
    create_trigger_t("duihuanstone3",
                     "^(> )*�㻹�Ƕ�Ŭ��һ��ʱ��ɡ�", "",
                     "duihuan_done")
    create_trigger_t("duihuanstone4",
                     "^(> )*����Ҫ�������е���Ʒ�����ٴζһ���",
                     "", "check_stoneT")
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
        exe("duihuan redstone")
    end
    return check_busy(duihuanStone1, 3)
end
function duihuanStone1()
    if stonePrepare["����ʯ"] and tmp.bluestone <
        tonumber(GetVariable("stonecishu")) then
        flag.duihuan = 2
        exe("duihuan bluestone")
    end
end
function stone_consider(n, l, w)
    local x = tostring(w[2])
    if x == "�ྦྷʯ" then
        flag.redstone = true
        tmp.redstone = tmp.redstone + 1
    end
    if x == "����ʯ" then
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
    if flag.redstone then exe("mai redstone") end
    if flag.bluestone and not flag.redstone then exe("mai bluestone") end
end
function maistone_set(n, l, w)
    if w[2] == "�ྦྷʯ" then flag.redstone = false end
    if w[2] == "����ʯ" then flag.bluestone = false end
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
        -- return checkPrepare()
        ColourNote("red", "blue",
                   "��ѡ���ʯͷ����һ��ļ��ޣ����ζһ���ϣ�")
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
    create_trigger_t("qk_dny1",
                     '^(> )*\\s*��� "action" �趨Ϊ "�̴ֽ�Ų����" �ɹ����',
                     "", "taoJiaozhang")
    create_trigger_t("qk_dny2", "^(> )*��������æ���ء�", "",
                     "taoJiaozhang")
    create_trigger_t("qk_dny3",
                     "^(> )*(����ʵս���鲻�㣬�谭����ġ�Ǭ����Ų�ơ�������|ʲô?|�����������)",
                     "", "taojiao_over")
    create_trigger_t("qk_dny4",
                     "^(> )*��о�ȫ����Ϣ���ڣ�ԭ������������������װ��\\D*��",
                     "", "taojiao_over")
    for i = 1, 4 do SetTriggerOption("qk_dny" .. i, "group", "qk_dny") end
    EnableTriggerGroup("qk_dny", false)
end
function check_dny() return go(taojiao_dny, "mingjiao/sht", "") end
function taojiao_dny()
    dnyTrigger()
    if locl.id[score.master] then
        EnableTriggerGroup("qk_dny", true)
        weaponWieldLearn()
        DoAfter(0.5, "alias action �̴ֽ�Ų����")
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
            "#8(taojiao qiankun-danuoyi);yun jing;alias action �̴ֽ�Ų����")
    end)
end
function taojiao_over()
    messageShow("�ֽ�Ǭ����Ų����ϣ�")
    EnableTriggerGroup("qk_dny", false)
    DeleteTriggerGroup("qk_dny")
    weaponWieldLearn()
    dis_all()
    return check_busy(check_food)
end
function fightoverweapon()
    if GetVariable("recoveryweapon") then
        exe(GetVariable("recoveryweapon"))
        checkWield()
    else
        weapon_unwield()
        weapon_wield()
    end
end
------���ݵ��̶һ����߻����� by���.2019.11.09-----
function duihuanSomething()
    exe("score")
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
    create_trigger_t("duihuanSomething1",
                     "^(> )*�����ϰ�ߺ��һ����" .. score.name ..
                         "�һ����Ƽ�����\\D*�������齣ͨ��(\\D*)��*",
                     "", "duihuanSomething_add")
    SetTriggerOption("duihuanSomething1", "group", "duihuanSomething")
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_add(n, l, w)
    tmp.duihuan = tmp.duihuan or 0
    tmp.duihuan = tmp.duihuan + 1
    print("���ζһ�" .. tmp.duihuan .. "��")
    if tmp.duihuan >= tonumber(GetVariable("duihuanTimes")) then
        EnableTriggerGroup("duihuanSomething", false)
        DeleteTriggerGroup("duihuanSomething")
        return check_food()
    end
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_duihuan() exe("duihuan " .. GetVariable("duihuanID")) end
-----�����Զ�����ϼ�� by �޷��� 2019.12.25------
xxkFind = function()
    DeleteTriggerGroup("xxkFind")
    create_trigger_t("xxkFind1", "^(> )*\\s*��ϼ��\\(Xu xiake\\)", "",
                     "xxkFindFollow")
    create_trigger_t("xxkFind2", "^(> )*����û�� xu xiake", "",
                     "xxkFindGoon")
    create_trigger_t("xxkFind3", "^(> )*���������\\D*һ���ж���", "",
                     "xxkFindDone")
    create_trigger_t("xxkFind4", "^(> )*���Ѿ��������ˡ�", "",
                     "xxkFindDone")
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
    exe("look")
    return find()
end
xxkFindFollow = function()
    flag.find = 1
    exe("follow xu xiake")
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
    create_trigger_t("kkrFind1", "^.*�տն�\\(Kong kong\\)", "",
                     "kongkongFindFollow")
    create_trigger_t("kkrFind2", "^(> )*����û�� kong kong", "",
                     "kongkongFindGoon")
    create_trigger_t("kkrFind3", "^(> )*���������\\D*һ���ж���", "",
                     "kongkongFindDone")
    create_trigger_t("kkrFind4", "^(> )*���Ѿ��������ˡ�", "",
                     "kongkongFindDone")
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
    exe("look")
    return find()
end
kongkongFindFollow = function()
    flag.find = 1
    exe("follow kong kong")
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
