function checkLLlost(n, l, w)
    LLlost = tonumber(w[4])
    if (condition.vpearl == 0 or not condition.vpearl) and needdolost == 1 and
        needvpearl == 1 then return Govpearl() end
    if LLlost * 1 >= lostno * 1 and needdolost == 1 then return dolostAg() end
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

function letterLost()
    job.name = 'dolost'
    sLetterlost()
    -- go(letterLostBegin, "������", "����")
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
    -- �������

    return Markletter()
end

function llwait()
    local f = io.open(GetInfo(56) .. "plugs\\" .. score.id .. "LLOUT.ini", "r")
    local s = f:read()

    f:close() -- �ر���

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
                   "�����ż�����ID������������discard�� ��Ҫ�ֶ�����������help��",
                   "lostname", GetVariable("lostname"), "����", "12")
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
