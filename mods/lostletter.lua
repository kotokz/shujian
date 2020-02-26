function checkLLlost(n, l, w)
    LLlost = tonumber(w[4])
    if (condition.vpearl == 0 or not condition.vpearl) and needdolost == 1 and
        needvpearl == 1 then return Govpearl() end
    if LLlost * 1 >= lostno * 1 and needdolost == 1 then return dolostAg() end
end

function dolostletter()
    l_result = utils.inputbox(
                   "请输入当前失落的信可接上限数量? 默认为10封！",
                   "mylostletter", GetVariable("mylostletter"), "宋体", "12")
    if not isNil(l_result) then
        SetVariable("mylostletter", l_result)
        lostno = l_result
    end
    l_result = utils.msgbox("是否做LL", "失落的信", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('开启做LL')
        needdolost = 1
        switch_name4 = "失落的信笺--开"
    else
        needdolost = 0
        switch_name4 = "失落的信笺--关"
        print('关闭做LL')
    end
    l_result = utils.msgbox("做LL是否自动买Vpearl", "自动买Vpearl",
                            "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('开启自动兑换Vpearl')
        needvpearl = 1
    else
        print('关闭自动兑换Vpearl')
        needvpearl = 0
    end
end
function dolostAg()
    l_result = utils.msgbox(
                   "还要再做失落的信吗？YES再做10封，NO算了不做了",
                   "次数", "yesno", "?", 1)
    if l_result and l_result == "yes" then
        print('再做失落的信10次！')
        lostno = lostno + 10
        dis_all()
        return go(dhlost, '扬州城', '当铺')
    else
        needdolost = 0
        print('关闭做LL')
    end
end

function Govpearl() return go(dhvpearl, '扬州城', '当铺') end
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

function letterLost()
    job.name = 'dolost'
    sLetterlost()
    -- go(letterLostBegin, "襄阳城", "当铺")
    letterLostBegin()
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
                     "^(> )*请打开网页(\\N*)查看收信人。$", '',
                     'goMark')
    create_trigger_t('lostletter2',
                     "^(> )*你乘人不注意，偷偷把失落的信笺扔进了路边的草丛。$",
                     '', 'sendOk')
    create_trigger_t('lostletter3',
                     "^(> )*信封上的字迹模糊不清，不知何人遗落到此处。$",
                     '', 'sendOk')
    create_trigger_t('lostletter4', "^(> )*你将失落的信笺交给", '',
                     'sendOk')
    create_trigger_t('lostletter5',
                     "^(> )*你在信卦上写上收信人的名字。$", '',
                     'lookXin')
    create_trigger_t('lostletter6', "^(> )*你再看清楚一点。$", '',
                     'letterLostBegin')
    create_trigger_t('lostletter7',
                     "^(> )*信封上写着：(\\D*)\\((\\D*)\\)", '',
                     'lostName')
    -- create_trigger_t('lostletter8',"^[> ]*好象收信人曾在(\\D*)一带出现。$",'','get_lost_locate')
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
    print('开始填写失落信件人物ID')
    local m_cmd = w[2]
    local fni = GetInfo(56) .. "plugs\\" .. score.id .. "LLIN.ini"
    local fi = io.open(fni, "w")
    if fi then
        fi:write(m_cmd)
        fi:close()

        local fno = GetInfo(56) .. "plugs\\" .. score.id .. "LLOUT.ini"
        local fo = io.open(fno, "w")
        fo:write("")
        fo:close()
        return create_timer_s('llwait', 1.0, 'llwait')
    else
        OpenBrowser(m_cmd)
    end
    -- 插件结束

    return Markletter()
end

function llwait()
    local f = io.open(GetInfo(56) .. "plugs\\" .. score.id .. "LLOUT.ini", "r")
    local s = f:read()

    f:close() -- 关闭流

    if not isNil(s) then
        print(s)
        if s ~= "" then
            DeleteTimer('llwait')
            SetVariable("lostname", s)

            local fno = GetInfo(56) .. "plugs\\" .. score.id .. "LLOUT.ini"
            local fo = io.open(fno, "w")
            fo:write("")
            fo:close()
            return MarkName()
        end
    end
end

function Markletter()
    l_result = utils.inputbox(
                   "输入信件人物ID，放弃请输入discard， 需要手动查找请输入help。",
                   "lostname", GetVariable("lostname"), "宋体", "12")
    if not isNil(l_result) then SetVariable("lostname", l_result) end
    return MarkName()
end
function MarkName()
    local lost_cmd = GetVariable("lostname")
    if lost_cmd == 'discard' then
        return exe('discard letter')
    elseif lost_cmd == 'help' then
        print('Use mark xxx')
        return exe('who;a;a;')
    end
    return exe('mark ' .. lost_cmd)
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
    mousedown_lostletter() -- 马上刷新地点
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
    -- return checkPrepareOver()--送信后不检查状态。
end
function dolost_hitlog_open()
    local fn = GetInfo(67) .. "logs\\" .. score.id .. '_dolost打傻记录_' ..
                   os.time() .. ".log"
    OpenLog(fn, false)
    WriteLog(
        "<!-- Produced by MUSHclient v 4.84 - [url]www.mushclient.com[/url] -->")
    WriteLog("[table=800,Black]")
    WriteLog("[tr][td][font=新宋体]")
    ColourNote('Lime', 'black', '开始写入打傻记录到' .. fn .. '！')
end
function dolost_hitlog_close()
    ColourNote('Lime', 'black', '记录打傻完毕！(by 无法风)')
    WriteLog("[/font][/td][/tr][/table]")
    CloseLog()
end
