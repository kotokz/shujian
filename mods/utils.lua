function wait_busy()
    EnableTrigger("hp12", true)
    while true do
        exe("bei bei bei")
        local l, w = wait.regexp("^(> )*(你现在已经组合|你已准备有一种技能了|你至少不会这两种拳脚技能的其中之一|你现在没有激发任何有效特殊技能)", 1)
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
    create_trigger_t("check_bei1", "^(> )*(你现在已经组合|你已准备有一种技能了|你至少不会这两种拳脚技能的其中之一|你现在没有激发任何有效特殊技能)", "", "beiok")
    -- create_trigger_t('check_bei2',
    --                  "^(> )*你现在没有激发任何有效特殊技能。",
    --                  '', 'beinone')
    SetTriggerOption("check_bei1", "group", "check_bei")
    -- SetTriggerOption("check_bei2", "group", "check_bei")
    EnableTriggerGroup("check_bei", true)
    EnableTrigger("hp12", true)
    beihook = func
    if not p_cmd then
        exe("bei bei bei")
    end
    return bei_timer()
end
function bei_timer()
    return create_timer_s("bei", 0.4, "bei_timer_set")
end
function bei_timer_set()
    -- EnableTriggerGroup("check_bei",true)
    exe("bei bei bei")
end
function beinone()
    for p, q in pairs(skillEnable) do
        if skills[p] and q ~= "force" then
            exe("jifa " .. q .. " " .. p)
            if math.random(1, 3) == 1 then
                break
            end
        end
    end
end
function beiok()
    EnableTriggerGroup("check_bei", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('bei')
    -- DeleteTriggerGroup("check_bei")
    EnableTimer("bei", false)
    if beihook == nil then
        beihook = test
    end
    return beihook()
end
function check_halt(func)
    disWait()
    DeleteTriggerGroup("check_halt")
    create_trigger_t("check_halt1", "^>*\\s*(你现在不忙。|你身形向后一跃，跳出战圈不打了。)", "", "haltok")
    create_trigger_t("check_halt2", "^>*\\s*你现在很忙，停不下来。", "", "halterror")
    SetTriggerOption("check_halt1", "group", "check_halt")
    SetTriggerOption("check_halt2", "group", "check_halt")
    EnableTriggerGroup("check_halt", true)
    EnableTrigger("hp12", true)
    halthook = func
    exe("halt")
    return halt_timer()
end
function halterror()
    haltbusy = haltbusy + 1
    if haltbusy > 30 then
        haltbusy = 0
        locate()
    end
    if locl.room == "洗象池边" then
        EnableTimer("halt", false)
        wait.make(
            function()
                wait.time(5)
                haltok()
            end
        )
    end
end
function halt_timer()
    return create_timer_s("halt", 0.4, "halt_timer_set")
end
function halt_timer_set()
    -- EnableTriggerGroup("check_halt",true)
    exe("halt")
end
function haltok()
    haltbusy = 0
    EnableTriggerGroup("check_halt", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('halt')
    EnableTimer("halt", false)
    -- DeleteTriggerGroup("check_halt")
    if halthook == nil then
        halthook = test
    end
    return halthook()
end
busyhook = test
function check_bei(func, p_cmd)
    disWait()
    DeleteTriggerGroup("check_busy")
    create_trigger_t("check_busy1", "^>*\\s*没有这个技能种类，用", "", "busyok")
    SetTriggerOption("check_busy1", "group", "check_busy")
    EnableTriggerGroup("check_busy", true)
    EnableTrigger("hp12", true)
    busyhook = func
    if not p_cmd then
        exe("jifa jifa jifa")
    end
    jifa_timer()
end
function jifa_timer()
    return create_timer_s("jifa", 0.4, "jifa_timer_set")
end
function jifa_timer_set()
    -- EnableTriggerGroup("check_busy",true)
    exe("jifa jifa jifa")
end
function busyok()
    EnableTriggerGroup("check_busy", false)
    EnableTrigger("hp12", false)
    -- DeleteTimer('jifa')
    EnableTimer("jifa", false)
    if busyhook == nil then
        busyhook = test
    end
    return busyhook()
end

function checkWait(func, sec)
    wait.make(
        function()
            EnableTrigger("hp12", true)
            if sec == nil then
                sec = 5
            end
            wait.time(sec)
            repeat
                exe("halt")
                local l, _ = wait.regexp("^>*\\s*(你现在不忙。|你身形向后一跃，跳出战圈不打了。|你把正在运行的真气强行压回丹田)", 0.5)
            until l
            EnableTrigger("hp12", false)
            func()
        end
    )
end

nexthook = test
function checkNext(func)
    disWait()
    DeleteTriggerGroup("checknext")
    create_trigger_t("checknext1", '^(> )*你把 "action" 设定为 "继续前进" 成功完成。$', "", "checkNextOk")
    SetTriggerOption("checknext1", "group", "checknext")
    EnableTriggerGroup("checknext", true)
    EnableTrigger("hp12", true)
    nexthook = func
    next_timer_set()
    return create_timer_s("nextimer", 0.5, "next_timer_set")
end
function next_timer_set()
    exe("alias action 继续前进")
end
function checkNextOk()
    EnableTriggerGroup("checknext", false)
    EnableTrigger("hp12", false)
    EnableTimer("nextimer", false)
    if nexthook == nil then
        nexthook = test
    end
    return nexthook()
end

function disWait()
    DeleteTriggerGroup("checkwait")
    DeleteTriggerGroup("check_bei")
    DeleteTriggerGroup("check_busy")
    DeleteTriggerGroup("check_halt")
    EnableTimer("waitimer", false)
    EnableTimer("jifa", false)
    EnableTimer("halt", false)
    EnableTimer("bei", false)
end
function resetWait()
    local t = GetTimerList()
    if t and type(t) == "table" then
        for k, v in pairs(GetTimerList()) do
            -- messageShow(v)
            if IsTimer(v) == 0 and GetTimerInfo(v, 6) and tonumber(GetTimerInfo(v, 3)) < tonumber(GetTimerInfo(v, 13)) then
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
    local num2 = 0
    if num:find("万") then
        local idx, e_idx = num:find("万")
        num2 = trans(num:sub(1, idx - 1)) * 10000
        num = num:sub(e_idx + 1)
    end
    num = string.gsub(num, "零十", "10 ")
    num = string.gsub(num, "零", "")
    num = string.gsub(num, "一", "1")
    num = string.gsub(num, "二", "2")
    num = string.gsub(num, "三", "3")
    num = string.gsub(num, "四", "4")
    num = string.gsub(num, "五", "5")
    num = string.gsub(num, "六", "6")
    num = string.gsub(num, "七", "7")
    num = string.gsub(num, "八", "8")
    num = string.gsub(num, "九", "9")
    i = string.find(num, "十")
    if i == 1 then
        num = string.gsub(num, "十", "10 ")
    else
        num = string.gsub(num, "十", "0 ")
    end
    num = string.gsub(num, "百", "00 ")
    num = string.gsub(num, "千", "000 ")
    num = string.gsub(num, "万", "0000 ")
    for w in string.gmatch(num, "(%w+)") do
        table.insert(words, w)
    end
    i = 0
    for p = 1, table.getn(words) do
        i = i + tonumber(words[p])
    end
    return i + num2
end

function isNil(p_str)
    if p_str == nil then
        return true
    end
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
            if l_i == l_cnt then
                return l_element
            end
        end
    else
        l_element = p_set
    end

    return l_element
end

Log = Log or {}

function Log:info(text)
    print(text)
    messageShow(text, "white")
end

function Log:warn(text)
    print(text)
    messageShow(text, "yellow")
end

function Log:green(text)
    print(text)
    messageShow(text, "lime")
end

function Log:error(text)
    print(text)
    messageShow(text, "red")
end

function messageShow(p_msg, ccolor, bcolor)
    local c_color = ccolor or "white"
    local b_color = bcolor or "green"

    if isNil(p_msg) then
        return
    end

    if GetVariable("flagnote") then
        flag.note = tonumber(GetVariable("flagnote"))
    end
    if flag.note and flag.note == 1 then
        if flag.log and flag.log == "yes" then
            chats_log(p_msg, c_color, b_color)
        else
            ColourNote("white", "black", p_msg)
        end
    else
        chats_log(p_msg, c_color, b_color)
    end
end
function messageShowT(p_msg, ccolor, bcolor)
    local c_color = ccolor or "yellow"
    local b_color = bcolor or "green"

    if isNil(p_msg) then
        return
    end

    chats_log(p_msg, c_color, b_color)
end

function setJobwhere(p)
    job.where = p
end

function scrLog()
    local filename = GetInfo(67) .. "logs\\" .. score.id .. "发呆" .. os.date("%Y%m%d_%H时%M分%S秒") .. ".log"

    local file = io.open(filename, "w")

    local t = {}

    for i = 1, GetLinesInBufferCount() do
        table.insert(t, GetLineInfo(i, 1))
    end

    local s = table.concat(t, "\n") .. "\n"

    file:write(s)

    file:close()
end
function dieLog()
    local filename = GetInfo(67) .. "logs\\" .. score.id .. "死亡" .. os.date("%Y%m%d_%H时%M分%S秒") .. ".log"

    local file = io.open(filename, "w")

    local t = {}

    for i = 1, GetLinesInBufferCount() do
        table.insert(t, GetLineInfo(i, 1))
    end

    local s = table.concat(t, "\n") .. "\n"

    file:write(s)

    file:close()
end
function jobbugLog()
    local filename = GetInfo(67) .. "logs\\" .. score.id .. "任务BUG" .. os.date("%Y%m%d_%H时%M分%S秒") .. ".log"

    local file = io.open(filename, "w")

    local t = {}

    for i = 1, GetLinesInBufferCount() do
        table.insert(t, GetLineInfo(i, 1))
    end

    local s = table.concat(t, "\n") .. "\n"

    file:write(s)

    file:close()
end

function jobfailLog()
    local filename = GetInfo(67) .. "logs\\" .. score.id .. "任务失败" .. os.date("%Y%m%d_%H时%M分%S秒") .. ".log"

    local file = io.open(filename, "w")

    local t = {}

    for i = 1, GetLinesInBufferCount() do
        table.insert(t, GetLineInfo(i, 1))
    end

    local s = table.concat(t, "\n") .. "\n"

    file:write(s)

    file:close()
end
function smyfailLog()
    local filename = GetInfo(67) .. "logs\\" .. score.id .. "smy" .. os.date("%Y%m%d_%H时%M分%S秒") .. ".log"

    local file = io.open(filename, "w")

    local t = {}

    for i = 1, GetLinesInBufferCount() do
        table.insert(t, GetLineInfo(i, 1))
    end

    local s = table.concat(t, "\n") .. "\n"

    file:write(s)

    file:close()
end

-- removes an entry from a table by specifying its key (table, key)
function table.removeKey(t, k)
    local i = 0
    local keys, values = {}, {}
    for k, v in pairs(t) do
        i = i + 1
        keys[i] = k
        values[i] = v
    end

    while i > 0 do
        if keys[i] == k then
            table.remove(keys, i)
            table.remove(values, i)
            break
        end
        i = i - 1
    end

    local a = {}
    for i = 1, #keys do
        a[keys[i]] = values[i]
    end

    return a
end

-- copies a table exactly
-- can potentially present problems with tables that have very
-- deep amount of levels, be sure to check the copy if you do this
-- usage: myNewTable = deepcopy(myOldTable)

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- check if an item is a member of a table
-- use caution if table is anything but a simple
-- dictionary or indexed array
-- returns index if it is found or first key that is found
-- returns false otherwise
-- usage: isMember(alphabet,"d") -> 4, isMember(beatles,"obama") -> false
function isMember(t, val)
    for k, v in pairs(t) do
        if v == val then
            return k
        end
    end
    return false
end

-- function to check if a table is an indiced array
-- will not return true if indices are non-sequential
function isArray(t)
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if t[i] == nil then
            return false
        end
    end
    return true
end
