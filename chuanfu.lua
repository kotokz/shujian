luapath = string.match(GetInfo(35), "^.*\\")
mclpath = GetInfo(67)
include = function(str) dofile(luapath .. str) end
loadmod = function(str) include("mods\\" .. str .. ".lua") end

require "wait"
require "tprint"
require "addxml"
require "socket"

loadmod "lujing"
loadmod "rooms"
loadmod "utils"

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

commlist = commlist or {}


function main()
    l_result = utils.inputbox(
        "通知列表是?(格式：abc|bcd|dca)",
        "commlist", GetVariable("commlist"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("commlist", l_result)
        commlist = l_result
    end
    add_triggers()
    setAlias()
    currentLocate = nil
    idle()

end

function add_triggers()
    create_trigger_t('main', "^「书剑\\D*」\\D*已经连续执行了", '',
    'login')
    create_trigger_t('main1', "^Are you using BIG5 font\\(y/N\\)? ", '',
    'login_choose')
    DeleteTriggerGroup("jinheTrigger")
    create_trigger_t('jiang1', '^(> )*艄公(们|)把踏脚板收', '',
    'boatout')
    create_trigger_t('jiang2',
        '^(> )*一艘渡船缓缓地驶了过来，艄公将一块踏脚板搭上堤岸，以便乘客上下',
        '', 'boatarrive')
    SetTriggerOption("jiang1", "group", "jinheTrigger")
    SetTriggerOption("jiang2", "group", "jinheTrigger")
    EnableTriggerGroup("jinheTrigger", true)
end

function login_choose() Send('n') end

function login()
    dis_all()
    DeleteTriggerGroup("login")
    -- create_trigger_t('login1', "^您上次连线地址是", '', 'logincheck')
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
        idle()
    end
end

function setAlias()
    create_alias('sz', '^sz(.*)$', 'go_to("%1")')
    SetAliasOption('sz', 'send_to', '12') 
end

currentLocate = nil

function boatout()

    boatmsg("出发时间:")
end

function boatarrive()

    boatmsg("到达时间:")
end

-- 陕晋渡口 黄河流域大渡口
-- 西夏渡口 兰州渡口
-- 长江渡口 澜沧江

-- 陕晋渡口 changan/road2  changan/road3
-- 黄河流域大渡口 huanghe/road2 huanghe/road3
-- 西夏渡口 lanzhou/dukou2 lanzhou/dukou3
-- 兰州渡口 lanzhou/road2 lanzhou/road3
-- 长江渡口 city/jiangbei city/jiangnan
-- 沧澜江 dali/dalisouth/jiangbei dali/dalisouth/jiangnan
-- /SetVariable("commlist", "rainbow|hnwbh|wbh|xiaohama|parrot|qqqqqqqq|bubble|lakesi|beggar|root|tjkl|android|yuji|aion|lfw|tzssp|zruo|zjj|gjy|hfx|kickall|dzyu|mjjjjlll|tanwr|asura|azi|muxue|daji|dragon|yelang|tuiop|kickcool|juvair|minds|cdm|thaxthx")

function boatmsg(msg)
    wait.make(function()
        if currentLocate  == nil then
            fastLocate(coroutine.running())
            coroutine.yield()
            if locl.where:find("长江") then
                currentLocate = "长江渡船"
            elseif locl.where:find("澜沧江") then
                currentLocate = "澜沧江渡船"
            elseif locl.where:find("西夏渡口") then
                currentLocate = "西夏渡口"
            elseif locl.where:find("兰州城大渡口") then
                currentLocate = "兰州渡口"
            elseif locl.where:find("长安城陕晋渡口") then
                currentLocate = "陕晋渡口"
            elseif locl.where:find("黄河流域大渡口") then
                currentLocate = "黄河流域大渡口" 
            end
        end

        commlist = GetVariable("commlist")
        local comm = utils.split(commlist, '|')
        for _, id in pairs(comm) do
            exe("tell ".. id.." " .. currentLocate ..msg..os.time())
        end

    end)
end

tmp = tmp or {}
hp = {exp = 0}
function idle()
    create_timer_s('idle', 30, 'idle_do')

end

function idle_do()
    exe('yell boat;poem')
end
job = {
    name = "chuanfu"
}

score = {
    gender = "男性"
}

Bag = {}

flag = {}

skills = {}

Chuanfu = {enable= false}
MudUser = {}
weaponPrepare = {}

function dis_all()
end