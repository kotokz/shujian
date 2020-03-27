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
go_on_smy = 0 -- 20161117增加变量go_on_smy开关控制 防止系统重启后自动打开颂摩崖
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
    -- 武当失败开启上山的id
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
    create_trigger_t("main", "^「书剑\\D*」\\D*已经连续执行了", "",
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
    create_trigger_t("login1", "^您上次连线地址是", "", "logincheck")
    create_trigger_t("login2",
                     "^请您输入这个人物的识别密码\\(passwd\\)：",
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
        -- EnableTriggerGroup("hb_kill",true)--小猪猪护镖文件的叫杀触发器
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
    if Trim(w[2]) == "开着" then
        flag.yili = true
    elseif Trim(w[2]) == "关闭" then
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
    return go(wuxingzhenCheck, "襄阳城", "卧房")
end
function wuxingzhenCheck()
    if locl.id["温方山"] then
        return wuxingzhenStart()
    else
        local l_cnt = table.getn(getRooms("卧房", "襄阳城"))
        flag.times = flag.times + 1
        if flag.times > l_cnt then
            return wuxingzhenFinish()
        else
            local l_sour = getRooms("卧房", "襄阳城")[flag.times - 1]
            return go(wuxingzhenCheck, "襄阳城", "卧房", l_sour)
        end
    end
end
function wuxingzhenStart()
    exe("yun jing")
    exe("ask wen fangshan about 五行阵")
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
    if not locl.id["温方山"] or hp.pot < 10 then return wuxingzhenFinish() end
    return checkWait(wuxingzhenStart, 0.5)
end

function dzxy_trigger()
    DeleteTriggerGroup("dzxy")
    create_trigger_t("dzxy1",
                     "^>*\\s*你仰首望天，太阳挂在天空中，白云朵朵，阳光顺着云层的边缘洒下来，你觉得有些刺眼。",
                     "", "dzxy_finish")
    create_trigger_t("dzxy2",
                     "^>*\\s*你仰首望天，天上繁星点点，你体会出了星斗的移动与你所学的“斗转星移”有莫大的联系，却苦于实战经验不足，无法将你看到的东西与实际作战联系到一起。",
                     "", "dzxy_finish")
    create_trigger_t("dzxy3",
                     '^>*\\s*你把 "action" 设定为 "慕容斗转星移" 成功完成。',
                     "", "dzxy_goon")
    create_trigger_t("dzxy4", "^>*\\s*你的内力不够。", "", "dzxy_finish")
    create_trigger_t("dzxy5",
                     "^>*\\s*先从木桩上跳下来\\(down\\)再说吧！",
                     "", "dzxy_finish")
    create_trigger_t("dzxy6",
                     "^>*\\s*恭喜恭喜！你已经融会贯通了斗转星移的绝妙之处！",
                     "", "dzxy_finish")
    create_trigger_t("dzxy7",
                     "^>*\\s*你已经没有潜能来领悟学习斗转星移了。",
                     "", "dzxy_finish")

    create_trigger_t("dzxy8",
                     "^>*\\s*你仰首望天，天上繁星点点，你顺着银河的方向看去，却发现部分的夜空被周围的树冠挡住了。",
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
            "任务监控：慕容领悟斗转星移条件不够！继续任务！",
            "white")
        print("dzxy_level:" .. dzxy_level)
    end

    return go(xueshan_finish_ask, "大雪山", "入幽口")
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
    messageShow("任务监控：去慕容领悟字画去了！", "white")
    go(dzxy1_unwield, "燕子坞", "碧水亭")
end
function dzxy2_go()
    messageShow("任务监控：去慕容领悟秘籍去了！", "white")
    go(dzxy2_unwield, "燕子坞", "还施水阁")
end
function dzxy3_go()
    messageShow("任务监控：去慕容看星星去了！", "white")
    go(dzxy3_unwield, "燕子坞", "观星台")
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
                hp.neili .. "】", "white")
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
function dzxy_alias() exe("alias action 慕容斗转星移") end

function dzxy_finish()
    EnableTimer("mr_dzxy_timer", false)
    DeleteTimer("mr_dzxy_timer")
    messageShow("任务监控：慕容斗转星移完成！")
    exe("jump down")
    EnableTriggerGroup("dzxy", false)
    DeleteTriggerGroup("dzxy")
    exe("cha;hp")
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('unwield ' .. leweapon)
    exe("jump down")
    return go(xueshan_finish_ask, "大雪山", "入幽口")
end

----正负神转换----
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

-----兑换红蓝石头----
function stoneSet()
    stonePrepare = {}
    local t = {["赤晶石"] = "赤晶石", ["海蓝石"] = "海蓝石"}
    if GetVariable("stoneprepare") then
        tmp.stone = utils.split(GetVariable("stoneprepare"), "|")
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
    l_result = utils.inputbox("你兑换石头的次数是？", "stonecishu",
                              GetVariable("stonecishu"), "宋体", "12")
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
                   "珠宝店关门，无法卖石头，请过一阵再尝试！")
    else
        return go(duihuan_prepare, "扬州城", "当铺")
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
                     "^(> )*当铺老板吆喝一声：" .. score.name ..
                         "兑换限制级宝物(赤晶石|海蓝石).*", "",
                     "stone_consider")
    create_trigger_t("duihuanstone2",
                     "^(> )*朱老板一把抓过(赤晶石|海蓝石)道：“哇，好东西呀！”",
                     "", "maistone_set")
    create_trigger_t("duihuanstone3",
                     "^(> )*你还是多努力一段时间吧。", "",
                     "duihuan_done")
    create_trigger_t("duihuanstone4",
                     "^(> )*你先要用完现有的物品才能再次兑换。",
                     "", "check_stoneT")
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
        exe("duihuan redstone")
    end
    return check_busy(duihuanStone1, 3)
end
function duihuanStone1()
    if stonePrepare["海蓝石"] and tmp.bluestone <
        tonumber(GetVariable("stonecishu")) then
        flag.duihuan = 2
        exe("duihuan bluestone")
    end
end
function stone_consider(n, l, w)
    local x = tostring(w[2])
    if x == "赤晶石" then
        flag.redstone = true
        tmp.redstone = tmp.redstone + 1
    end
    if x == "海蓝石" then
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
    if flag.redstone then exe("mai redstone") end
    if flag.bluestone and not flag.redstone then exe("mai bluestone") end
end
function maistone_set(n, l, w)
    if w[2] == "赤晶石" then flag.redstone = false end
    if w[2] == "海蓝石" then flag.bluestone = false end
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
        -- return checkPrepare()
        ColourNote("red", "blue",
                   "您选择的石头到达兑换的极限，本次兑换完毕！")
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
    create_trigger_t("qk_dny1",
                     '^(> )*\\s*你把 "action" 设定为 "讨教大挪移中" 成功完成',
                     "", "taoJiaozhang")
    create_trigger_t("qk_dny2", "^(> )*你现在正忙着呢。", "",
                     "taoJiaozhang")
    create_trigger_t("qk_dny3",
                     "^(> )*(由于实战经验不足，阻碍了你的「乾坤大挪移」进步！|什么?|你的内力不够)",
                     "", "taojiao_over")
    create_trigger_t("qk_dny4",
                     "^(> )*你感觉全身气息翻腾，原来你真气不够，不能装备\\D*。",
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
        DoAfter(0.5, "alias action 讨教大挪移中")
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
            "#8(taojiao qiankun-danuoyi);yun jing;alias action 讨教大挪移中")
    end)
end
function taojiao_over()
    messageShow("讨教乾坤大挪移完毕！")
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
------扬州当铺兑换道具机器人 by如版.2019.11.09-----
function duihuanSomething()
    exe("score")
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
    create_trigger_t("duihuanSomething1",
                     "^(> )*当铺老板吆喝一声：" .. score.name ..
                         "兑换限制级宝物\\D*，收讫书剑通宝(\\D*)个*",
                     "", "duihuanSomething_add")
    SetTriggerOption("duihuanSomething1", "group", "duihuanSomething")
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_add(n, l, w)
    tmp.duihuan = tmp.duihuan or 0
    tmp.duihuan = tmp.duihuan + 1
    print("本次兑换" .. tmp.duihuan .. "次")
    if tmp.duihuan >= tonumber(GetVariable("duihuanTimes")) then
        EnableTriggerGroup("duihuanSomething", false)
        DeleteTriggerGroup("duihuanSomething")
        return check_food()
    end
    check_busy(duihuanSomething_duihuan)
end
function duihuanSomething_duihuan() exe("duihuan " .. GetVariable("duihuanID")) end
-----扬州自动找徐霞客 by 无法风 2019.12.25------
xxkFind = function()
    DeleteTriggerGroup("xxkFind")
    create_trigger_t("xxkFind1", "^(> )*\\s*徐霞客\\(Xu xiake\\)", "",
                     "xxkFindFollow")
    create_trigger_t("xxkFind2", "^(> )*这里没有 xu xiake", "",
                     "xxkFindGoon")
    create_trigger_t("xxkFind3", "^(> )*你决定跟随\\D*一起行动。", "",
                     "xxkFindDone")
    create_trigger_t("xxkFind4", "^(> )*你已经这样做了。", "",
                     "xxkFindDone")
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
               "【已找到徐霞客这个狗头，请开始你的嘿嘿嘿……】")
    print("by 无法风 2019.12.25")
end
-----扬州自动找空空儿 by 无法风 2019.12.25------
kongkongFind = function()
    DeleteTriggerGroup("kkrFind")
    create_trigger_t("kkrFind1", "^.*空空儿\\(Kong kong\\)", "",
                     "kongkongFindFollow")
    create_trigger_t("kkrFind2", "^(> )*这里没有 kong kong", "",
                     "kongkongFindGoon")
    create_trigger_t("kkrFind3", "^(> )*你决定跟随\\D*一起行动。", "",
                     "kongkongFindDone")
    create_trigger_t("kkrFind4", "^(> )*你已经这样做了。", "",
                     "kongkongFindDone")
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
               "【已找到空空儿这个狗头，请开始你的嘿嘿嘿……】")
    print("by 无法风 2019.12.25")
end
