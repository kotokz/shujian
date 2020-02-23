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

    setShenQi()

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
        Execute('pfmset')
    end
    l_result = utils.inputbox("��Ŀ���PFM(��ʹ��������PFM)��?",
                              "pfmks", GetVariable("pfmks"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmks", l_result)
        l_pfm = l_result
        create_alias('pfmks', 'pfmks', 'alias pfmpfm ' .. l_pfm)
        Note("����PFM")
        Execute('pfmks')
    end
    l_result = utils.inputbox(
                   "����Ľ�ݽ����õ�PFM(ʹ�ò��ý����Կ���Ľ�ݵ�skills,Ľ�ݽ���������Ϊ����)��?",
                   "pfmmrjf", GetVariable("pfmmrjf"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmmrjf", l_result)
        l_pfm = l_result
        create_alias('pfmmrjf', 'pfmmrjf', 'alias pfmpfm ' .. l_pfm)
        Note("���ý���PFM")
        Execute('pfmmrjf')
    end
    l_result = utils.inputbox(
                   "��������ʥ���PFM(ʹ���������������̵�skills��ʥ���������Ϊ����)��?",
                   "pfmshlf", GetVariable("pfmshlf"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmshlf", l_result)
        l_pfm = l_result
        create_alias('pfmshlf', 'pfmshlf', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmshlf')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(ʹ�������Ե�skills�����������Ĺ���Ϊ��)��?",
                   "pfmwu", GetVariable("pfmwu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmwu", l_result)
        l_pfm = l_result
        create_alias('pfmwu', 'pfmwu', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmwu')
    end
    l_result = utils.inputbox("��д��Ŀ���������PFM��?", "pwu",
                              GetVariable("pwu"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pwu", l_result)
        l_pfm = l_result
        create_alias('pwu', 'pwu', 'alias pfmpfm ' .. l_pfm)
        Note("����������PFM")
        Execute('pwu')
    end
    l_result = utils.inputbox(
                   "��д��Ŀ�����PFM(ʹ�ÿ����Ե�skills)��?",
                   "pkong", GetVariable("pkong"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pkong", l_result)
        l_pfm = l_result
        create_alias('pkong', 'pkong', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pkong')
    end
    l_result = utils.inputbox(
                   "��д���������PFM(�����书����)��?",
                   "pfmsanqing", GetVariable("pfmsanqing"), "����", "12")
    if not isNil(l_result) then
        SetVariable("pfmsanqing", l_result)
        l_pfm = l_result
        create_alias('pfmsanqing', 'pfmsanqing', 'alias pfmpfm ' .. l_pfm)
        Note("������PFM")
        Execute('pfmsanqing')
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
        Execute('pfmzhen')
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
        Execute('pfmqi')
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
        Execute('pfmgang')
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
        Execute('pfmrou')
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
        Execute('pfmkuai')
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
        Execute('pfmman')
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
        Execute('pfmmiao')
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
        Execute('pfmxian')
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
    Execute('pfmset')
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
            hqgzcjl = 0
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

function g_stop()
    if job.name == nil or job.name == 'idle' then
        print("��Ϸֹͣ")
        disAll()
    else
        g_stop_flag = true
        print("��ǰ���������У�" .. job.name ..
                  ". ���������������ֹͣ")
    end
end
function setAlias()
    create_alias_s('dazao', 'dazao', 'dazaoWeapon')
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
    create_alias_s('gstop', 'gstop', 'g_stop')
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
    create_alias_s('setautoxue', 'setautoxue', 'set_autoxue')
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
    create_alias('sz', '^sz(.*)$', 'go_to("%1")')
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

function setShenQi()
    l_result = utils.inputbox("�������id�ǣ�", "myshenqi_id",
                              GetVariable("myshenqi_id"), "����", "12")
    if not isNil(l_result) then SetVariable("myshenqi_id", l_result) end
end
function set_autoxue()
    l_result = utils.msgbox("�Ƿ��Զ�ѧϰ������", "XuexiLingwu",
                            "yesno", "?", 1)
    if l_result and l_result == "yes" then
        flag.autoxuexi = 1
    else
        flag.autoxuexi = 0
    end
    SetVariable("flagautoxuexi", flag.autoxuexi)
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
