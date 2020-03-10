function wait_busy()
    EnableTrigger("hp12", true)
    while true do
        exe('bei bei bei')
        local l, w = wait.regexp(
                         '^(> )*(�������Ѿ����|����׼����һ�ּ�����|�����ٲ���������ȭ�ż��ܵ�����֮һ|������û�м����κ���Ч���⼼��)',
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
                     "^(> )*(�������Ѿ����|����׼����һ�ּ�����|�����ٲ���������ȭ�ż��ܵ�����֮һ|������û�м����κ���Ч���⼼��)",
                     '', 'beiok')
    -- create_trigger_t('check_bei2',
    --                  "^(> )*������û�м����κ���Ч���⼼�ܡ�",
    --                  '', 'beinone')
    SetTriggerOption("check_bei1", "group", "check_bei")
    -- SetTriggerOption("check_bei2", "group", "check_bei")
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

function checkWait(func, sec)
    wait.make(function()
        EnableTrigger("hp12", true)
        if sec == nil then sec = 5 end
        wait.time(sec)
        repeat
            exe('halt')
            local l, _ = wait.regexp(
                             "^>*\\s*(�����ڲ�æ��|���������һԾ������սȦ�����ˡ�|����������е�����ǿ��ѹ�ص���)",
                             0.5)
        until l
        EnableTrigger("hp12", false)
        func()
    end)
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
    local num2 = 0
    if num:find("��") then
        local idx, e_idx = num:find("��")
        num2 = trans(num:sub(1, idx - 1)) * 10000
        num = num:sub(e_idx + 1)
    end
    num = string.gsub(num, "��ʮ", "10 ")
    num = string.gsub(num, "��", "")
    num = string.gsub(num, "һ", "1")
    num = string.gsub(num, "��", "2")
    num = string.gsub(num, "��", "3")
    num = string.gsub(num, "��", "4")
    num = string.gsub(num, "��", "5")
    num = string.gsub(num, "��", "6")
    num = string.gsub(num, "��", "7")
    num = string.gsub(num, "��", "8")
    num = string.gsub(num, "��", "9")
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
    return i + num2
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
