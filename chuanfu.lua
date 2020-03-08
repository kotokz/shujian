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

commlist = commlist or {}


function main()
    l_result = utils.inputbox(
        "֪ͨ�б���?(��ʽ��abc|bcd|dca)",
        "commlist", GetVariable("commlist"), "����", "12")
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
    create_trigger_t('main', "^���齣\\D*��\\D*�Ѿ�����ִ����", '',
    'login')
    create_trigger_t('main1', "^Are you using BIG5 font\\(y/N\\)? ", '',
    'login_choose')
    DeleteTriggerGroup("jinheTrigger")
    create_trigger_t('jiang1', '^(> )*����(��|)��̤�Ű���', '',
    'boatout')
    create_trigger_t('jiang2',
        '^(> )*һ�Ҷɴ�������ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿�����',
        '', 'boatarrive')
    SetTriggerOption("jiang1", "group", "jinheTrigger")
    SetTriggerOption("jiang2", "group", "jinheTrigger")
    EnableTriggerGroup("jinheTrigger", true)
end

function login_choose() Send('n') end

function login()
    dis_all()
    DeleteTriggerGroup("login")
    -- create_trigger_t('login1', "^���ϴ����ߵ�ַ��", '', 'logincheck')
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
        idle()
    end
end

function setAlias()
    create_alias('sz', '^sz(.*)$', 'go_to("%1")')
    SetAliasOption('sz', 'send_to', '12') 
end

currentLocate = nil

function boatout()

    boatmsg("����ʱ��:")
end

function boatarrive()

    boatmsg("����ʱ��:")
end

-- �½��ɿ� �ƺ������ɿ�
-- ���Ķɿ� ���ݶɿ�
-- �����ɿ� ���׽�

-- �½��ɿ� changan/road2  changan/road3
-- �ƺ������ɿ� huanghe/road2 huanghe/road3
-- ���Ķɿ� lanzhou/dukou2 lanzhou/dukou3
-- ���ݶɿ� lanzhou/road2 lanzhou/road3
-- �����ɿ� city/jiangbei city/jiangnan
-- ������ dali/dalisouth/jiangbei dali/dalisouth/jiangnan
-- /SetVariable("commlist", "rainbow|hnwbh|wbh|xiaohama|parrot|qqqqqqqq|bubble|lakesi|beggar|root|tjkl|android|yuji|aion|lfw|tzssp|zruo|zjj|gjy|hfx|kickall|dzyu|mjjjjlll|tanwr|asura|azi|muxue|daji|dragon|yelang|tuiop|kickcool|juvair|minds|cdm|thaxthx")

function boatmsg(msg)
    wait.make(function()
        if currentLocate  == nil then
            fastLocate(coroutine.running())
            coroutine.yield()
            if locl.where:find("����") then
                currentLocate = "�����ɴ�"
            elseif locl.where:find("���׽�") then
                currentLocate = "���׽��ɴ�"
            elseif locl.where:find("���Ķɿ�") then
                currentLocate = "���Ķɿ�"
            elseif locl.where:find("���ݳǴ�ɿ�") then
                currentLocate = "���ݶɿ�"
            elseif locl.where:find("�������½��ɿ�") then
                currentLocate = "�½��ɿ�"
            elseif locl.where:find("�ƺ������ɿ�") then
                currentLocate = "�ƺ������ɿ�" 
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
    gender = "����"
}

Bag = {}

flag = {}

skills = {}

Chuanfu = {enable= false}
MudUser = {}
weaponPrepare = {}

function dis_all()
end