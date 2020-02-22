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
