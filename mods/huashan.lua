-------��ɽ
hstongji_1 = 0
hstongji_2 = 0
hstongji_zh = 0 -- ����ʱ���ܺ�
hstongji_lq = 0 -- hs��ȡ����
hstongji_finish = 0 -- hs����ɹ�����
hstongji_fangqi = 0 -- hsʧ�ܴ���
hstongji_pingjun = 0 -- ƽ��ʱ�� 
hstongji_thistime = 0 -- hs ����ս��ʱ�� 
hstongjilasttime_l = 0 -- �ۼ�hs2ս��ʱ��
hstongjilasttime_l_2 = 0 -- ����hsս��ʱ��
hstongjilasttime_l_1 = 0 -- �ۼ�hs1ս��ʱ��
tosld = 0
tocaidi = 0
tomr = 0
toyzw = 0
tomtl = 0
hstoszgf = 0
hstohssd = 0
hstoxct = 0
hs2job = 0
local huashanArea1 = {
    ["�˵�"] = "��ɽ��",
    ["�ӻ���"] = "��ɽ��",
    ["��"] = "��ɽ��",
    ["����"] = "��ɽ��",
    ["������"] = "��ɽ��",
    ["�����"] = "��ɽ��",
    ["��ʯ·"] = "��ɽ��",
    ["��̳��"] = "��ɽ��",
    ["������"] = "��ɽ",
    ["����"] = "��ɽ",
    ["�ٲ�"] = "��ɽ",
    ["������"] = "��ɽ",
    ["������"] = "��ɽ",
    ["�����"] = "��ɽ",
    ["ɯ��ƺ"] = "��ɽ",
    ["ǧ�ߴ�"] = "��ɽ",
    ["�ٳ�Ͽ"] = "��ɽ",
    ["���ƺ"] = "��ɽ",
    ["������"] = "��ɽ",
    ["������"] = "��ɽ",
    ["��Ů��"] = "��ɽ",
    ["��ȪԺ"] = "��ɽ",
    ["˼����"] = "��ɽ",
    ["ҩ��"] = "��ɽ",
    ["����"] = "��ɽ",
    ["ɽ��"] = "��ɽ",
    ["СϪ"] = "��ɽ",
    ["��̳"] = "��ɽ",
    ["˼���¶���"] = "��ɽ",
    ["ɽ·"] = "��ɽ",
    ["ʯ��"] = "��ɽ",
    ["����"] = "��ɽ",
    ["��ɽ����"] = "��ɽ",
    ["ɽ���ٲ�"] = "��ɽ",
    ["���䳡"] = "��ɽ",
    ["����"] = "��ɽ",
    ["�鷿"] = "��ɽ",
    ["����"] = "��ɽ",
    ["����"] = "��ɽ",
    ["ǰ��"] = "��ɽ",
    ["̨��"] = "��ɽ",
    ["������"] = "��ɽ",
    ["����"] = "��ɽ",
    ["��Ϣ��"] = "��ɽ",
    ["�Ͼ���"] = "��ɽ",
    ["Сɽ·"] = "��ɽ"
}
job.list["huashan"] = "��ɽ�Ͷ�����"
function huashan()
    hsjob2 = 0
    dis_all()
    huashan_trigger()
    job.name = 'huashan'
    job.target = '����Ŀ��'
    return huashan_start()
end
jobFindAgain = jobFindAgain or {}
jobFindAgain["huashan"] = "huashanFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["huashan"] = "huashanFindFail"
faintFunc = faintFunc or {}
faintFunc["huashan"] = "huashanFindAgain"
function huashanFindAgain()
    EnableTriggerGroup("huashan_find", true)
    if flag.times == 3 and dest.area == '��ɽ��' then
        return go(huashanFindAct, '��ɽ��', '�˵�')
    end
    if flag.times == 3 and dest.area == '������' and dest.room ==
        'ɽ��յ�' then
        return go(huashanFindAct, '��������', '�ٲ�')
    end
    if flag.times == 2 and job.area == '����' and
        (job.room == "��ɼ��" or string.find(job.room, "����")) then
        return go(huashanFindAct, '����', '���䳡')
    end
    if flag.times == 3 and job.area == '���ݳ�' and job.room == '����' then
        return go(huashanFindAct, '���ݳ�', '�����ϰ�')
    end
    if flag.times == 3 and job.area == '���ݳ�' and job.room == '������' then
        return go(huashanFindAct, '���ݳ�', '����')
    end

    if flag.times == 3 and job.area == '��ɽ����' and job.room ==
        "�޺���" then
        return go(huashanFindAct, '��ɽ����', '�޺����岿')
    end
    if flag.times == 3 and job.area == '��ɽ����' and job.room ==
        "������" then
        return go(huashanFindAct, '��ɽ����', '�������岿')
    end
    return go(huashanFindAct, dest.area, dest.room)
end
function huashanFindFail() return go(huashan_shibai, '��ɽ', '������') end
function huashan_start()
    DeleteTriggerGroup("all_fight")
    DeleteTriggerGroup("huashan_fight")
    DeleteTriggerGroup("huashan_over")
    DeleteTriggerGroup("huashan_find")
    flag.idle = nil
    flag.times = 1
    wait.make(function()
        await_go('��ɽ', '������')
        return hsaskjob()
    end)
    -- return go(hsaskjob, '��ɽ', '������')
end
function hsaskjob()
    if newbie == 1 then
        return zhunbeineili(job_huashan)
    else
        return job_huashan()
    end
end
function job_huashan()
    wait.make(function()
        wait_busy()
        local l, w
        dis_all()
        EnableTriggerGroup("huashan_accept", true)
        repeat
            exe('ask yue buqun about job')
            l, w = wait.regexp(
                       '^(> )*(��������Ⱥ����|����û�������)', 1)
            if l and l:find("����û�������") then
                await_go('��ɽ', '������')
            end
        until l and l:find("��������Ⱥ����")
    end)
end
function huashan_trigger()
    DeleteTriggerGroup("huashan_find")
    DeleteTriggerGroup("huashan_accept")
    create_trigger_t('huashan_accept1',
                     "^(> )*����Ⱥ˵�������㲻�ܹ�˵ѽ������������ɼ����ҿ�����",
                     '', 'huashan_shibai')
    create_trigger_t('huashan_accept2',
                     "^(> )*����Ⱥ˵��������������æ�������������أ�",
                     '', 'huashan_busy')
    create_trigger_t('huashan_accept3',
                     "^(> )*����Ⱥ˵����������û����˵�ж���Ϊ������",
                     '', 'huashan_fangqi')
    create_trigger_t('huashan_accept4',
                     "^(> )*����Ⱥ������һ�����ơ�$", '',
                     'huashan_npc')
    create_trigger_t('huashan_accept5',
                     "^(> )*����Ⱥ����˵�����㻹����ȥ˼�������˼��ȥ�ɡ�",
                     '', 'huashanjjQuest')
    create_trigger_t('huashan_accept6',
                     "^(> )*����Ⱥ˵����������û����˵�ж���Ϊ�����գ����Լ�ȥ��ϰ�书ȥ�ɣ���",
                     '', 'huashan_fangqi')
    SetTriggerOption("huashan_accept1", "group", "huashan_accept")
    SetTriggerOption("huashan_accept2", "group", "huashan_accept")
    SetTriggerOption("huashan_accept3", "group", "huashan_accept")
    SetTriggerOption("huashan_accept4", "group", "huashan_accept")
    SetTriggerOption("huashan_accept5", "group", "huashan_accept")
    SetTriggerOption("huashan_accept6", "group", "huashan_accept")
    EnableTriggerGroup("huashan_accept", false)
    DeleteTriggerGroup("huashan_npc")
    create_trigger_t('huashan_npc1',
                     "^(> )*(�䲻��|ͻȻ|�͵�|��Ȼ|�䲻��)������\\D*������ƣ���(\\D*)(��|����)\\D*��ȥ��$",
                     '', 'huashan_where')
    create_trigger_t('huashan_npc2',
                     "^(> )*��һ��ץ����������ͼ�������ƣ��������������ݵö��˹�ȥ����˳�ֳ��������˵����֣�����ԭ�����������𽭺���(\\D*)��",
                     '', 'huashan_find')
    create_trigger_t('huashan_npc3',
                     '^(> )*��� "hsjob" �趨Ϊ "�й���" �ɹ���ɡ�',
                     '', 'huashan_npc_goon')
    SetTriggerOption("huashan_npc1", "group", "huashan_npc")
    SetTriggerOption("huashan_npc2", "group", "huashan_npc")
    SetTriggerOption("huashan_npc3", "group", "huashan_npc")
    EnableTriggerGroup("huashan_npc", false)
    DeleteTriggerGroup("huashanQuest")
    create_trigger_t('huashanQuest1',
                     "^(> )*����Ⱥ˵������" .. score.name ..
                         "��ɱ�˲��ٶ��ˣ�δ��ɱ�����ز�����˼���������ڰ�",
                     '', 'huashanDgjj')
    SetTriggerOption("huashanQuest1", "group", "huashanQuest")
    EnableTriggerGroup("huashanQuest", false)
end
function huashan_triggerDel()
    DeleteTriggerGroup("all_fight")
    DeleteTriggerGroup("huashan_find")
    DeleteTriggerGroup("huashan_accept")
    DeleteTriggerGroup("huashan_npc")
    DeleteTriggerGroup("huashan_fight")
    DeleteTriggerGroup("huashan_over")
    DeleteTriggerGroup("huashanQuest")
end
function huashan_nobody() return huashan_start() end
function huashan_shibai()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_accept", false)
    kezhiwugongclose()
    return check_busy(huashan_shibai_b)
end
function huashan_shibai_b()

    wait.make(function()
        EnableTimer('walkWait4', false)
        flag.idle = nil
        DeleteTriggerGroup("all_fight")
        kezhiwugongclose()
        huashan_triggerDel()
        local l, w
        repeat
            exe('ask yue buqun about ʧ��')
            l, w = wait.regexp(
                       '^(> )*(��������Ⱥ����|����û�������)', 1)
            if l and l:find("����û�������") then
                await_go('��ɽ', '������')
            end
        until l and l:find("��������Ⱥ����")
        if job.where ~= nil and string.find(job.where, "���͵�") then
            mjlujingLog("���͵�")
        end
        hstongji_fangqi = hstongji_fangqi + 1
        messageShow('��ɽ��������ʧ��!��ɽʧ��[' ..
                        hstongji_fangqi .. ']�Ρ�', "Plum")
        jobfailLog()
        return check_halt(check_food)
    end)
end
function huashan_fangqi()
    EnableTimer('walkWait4', false)
    DeleteTriggerGroup("all_fight")
    kezhiwugongclose()
    huashan_triggerDel()
    job.last = "huashan"
    hsjob2 = 0

    weapon_wield()
    return check_halt(check_food)
end
function huashan_busy()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_accept", false)
    locate_finish = 'huashan_busy_dazuo'
    return check_busy(locate)
end
function huashan_busy_dazuo()
    locate_finish = 0
    exe('#3s')
    return prepare_lianxi(check_food)
end
function huashan_npc()
    EnableTimer('walkWait4', false)
    job.time.b = os.time()
    EnableTriggerGroup("huashan_accept", false)
    job.last = "huashan"
    if hsjob2 < 1 then
        hstongji_lq = hstongji_lq + 1
        messageShow('��ɽ���񣺿�ʼ����')
        return check_busy(huashan_npc_go)
    else
        return check_busy(huashan_npc_go2)
    end

end
function huashan_npc_go()
    locate_finish = 0
    go(huashan_npc_get, '��ɽ', 'ɽ����', 'huashan/zhengqi')
end
function huashan_npc_go2()
    locate_finish = 0
    go(huashan_npc_get, '��ɽ', 'ɽ����', 'huashan/jitan')
end
function huashan_npc_get()
    EnableTriggerGroup("huashan_npc", true)
    exe('unset wimpy;set wimpycmd pfmpfm\\hp')
    exe('set no_kill_ap')
    exe('s')
    return check_bei(huashan_npc_goon)
end
function huashan_npc_goon()
    DeleteTimer('walkWait4')
    exe('n;e;e')
    locate()
    return check_busy(huashan_ssl, 1)
end
function huashan_ssl()
    if locl.room == "ʯ��" or locl.room == "��ȪԺ" then
        return check_bei(huashan_npc_ssl)
    else
        return check_bei(huashan_npc_goon)
    end
end
function huashan_npc_ssl()
    create_timer_s('walkWait4', 2.0, 'hs_wander')
    return exe('w;s;s;alias hsjob �й���')
    -- exe('w;s;s')
    -- huashan_npc_goon()     
end
function hs_wander() exe('alias hsjob �й���') end
huashan_where = function(n, l, w)
    job.where = tostring(w[3])
    -- print("1"..job.where)
    if string.find(job.where, "��ɽʯ��") and not Bag['����'] then
        job.where = "��ɽɽ��"
    end
    if string.find(job.where, "��ɽ���ֲ˵�") then
        job.where = '��ɽ������ǰ�㳡'
        messageShow('�ص�����ɽ���ֲ˵ظ�Ϊ��ɽ������ǰ�㳡',
                    'violet')
    end
    if string.find(job.where, "������") then
        job.where = "��ɽ��������ƺ"
    end
    if string.find(job.where, "��������") or
        string.find(job.where, "�����鷿") or
        string.find(job.where, "��������") or
        string.find(job.where, "������Ժ") then
        job.where = "������������"
    end
    if string.find(job.where, "���ݳǹ뷿") and not Bag["ͭԿ��"] then
        job.where = "���ݳǺ��ָ�Ժ"
    end
    if (string.find(job.where, "�������ƹ�") or
        string.find(job.where, "��������¥") or
        string.find(job.where, "�鱦��")) then
        job.where = "���ݳ������"
    end

    -- if string.find(job.where, "�䵱") and
    --     (string.find(job.where, "Ժ��") or
    --         string.find(job.where, "��ɽСԺ")) then
    --     job.where = "�䵱ɽС��"
    -- end
end
huashan_find = function(n, l, w)
    dis_all()
    job.target = tostring(w[2])
    job.killer = {}
    job.killer[job.target] = true
    DeleteTriggerGroup("huashan_find")
    create_trigger_t('huashan_find1', '^( )*' .. job.target .. '\\((\\D*)\\)',
                     '', 'huashan_fight')
    create_trigger_t('huashan_find2', '^(> )*������(\\D*)��ɱ���㣡',
                     '', 'huashan_debug_fight')
    create_trigger_t('huashan_find3',
                     '^(> )*�ɻ�����������㿴����֪����Щʲô���⡣',
                     '', 'huashan_dadao')
    create_trigger_t('huashan_find4', '^( )*�ⲻ�����������Ƶ���', '',
                     'huashan_find_again')
    SetTriggerOption("huashan_find1", "group", "huashan_find")
    SetTriggerOption("huashan_find2", "group", "huashan_find")
    SetTriggerOption("huashan_find3", "group", "huashan_find")
    SetTriggerOption("huashan_find4", "group", "huashan_find")
    SetTriggerOption("huashan_find1", "keep_evaluating", "y")
    SetTriggerOption("huashan_find2", "keep_evaluating", "y")
    if string.find(job.where, '������') then tosld = tosld + 1 end
    if string.find(job.where, '�˵�') then tocaidi = tocaidi + 1 end
    if string.find(job.where, '����Ľ��') then tomr = tomr + 1 end
    if string.find(job.where, '������') then toyzw = toyzw + 1 end
    if string.find(job.where, '��٢��ɽׯ') then tomtl = tomtl + 1 end
    if string.find(job.where, '���ݳǹ뷿') then hstoszgf = hstoszgf + 1 end
    if string.find(job.where, '��ɽʯ��') then hstohssd = hstohssd + 1 end
    if string.find(job.where, '��ɽ����������') then
        hstoxct = hstoxct + 1
    end
    if string.find(job.where, "ϴ���") or
        string.find(job.where, "���º�ȭ��") or
        -- string.find(job.where, '�����ʯ��') or
        string.find(job.where, '��٢��ɽׯ') then
        messageShow('��ɽ����ڣ�����ص㡾' .. job.where ..
                        '�����ɵ�����������')
        return check_halt(huashanFindFail)
    end

    if Yiliaddr[job.where] and MidNight[locl.time] then
        messageShow('��ɽ����ڣ�����ص㡾' .. job.where ..
                        '��ʱ�䲻�ԣ����������', 'blue')
        return check_halt(huashanFindFail)
    end

    if string.find(job.where, "÷��") then job.where = '÷ׯ������' end
    -- print("2"..job.where)
    if huashanArea1[job.where] then
        job.room = job.where
        job.area = huashanArea1[job.where]
    else
        job.room, job.area = getAddr(job.where)
    end
    dest.room = job.room
    dest.area = job.area
    if not job.room or not path_cal() then
        messageShow('��ɽ��������ص㡾' .. job.where ..
                        '�����ɵ�����������', "Plum")
        return check_halt(huashanFindFail)
    end
    print(dest.room, dest.area, job.room, job.area)
    messageShow(
        '��ɽ����׷ɱ���ܵ���' .. job.where .. '���ġ�' ..
            job.target .. '����')
    locl.area = '��ɽ'
    locl.room = '����'
    if job.room == '����' then flag.times = 2 end
    if job.area == '����' and
        (job.room == "��ɼ��" or string.find(job.room, "����")) then
        job.room = "��ɼ��"
    end
    if string.find(job.where, '������') then return hudiegu() end
    return go(huashanFindAct, job.area, job.room, "huashan/shulin")
end
function huashan_find_again()
    EnableTriggerGroup("huashan_find", false)
    go("��ɽ", "������")
    flag.wait = 0
    wait.make(function()
        wait.time(0.5)
        dis_all()
        EnableTriggerGroup("huashan_find", true)
        if string.find(job.where, '������') then return hudiegu() end
        go(huashanFindAct, job.area, job.room)
    end)
end
function huashan_debug_fight()
    -- dis_all()
    EnableTrigger("huashan_find1", true)
    exe('look')
end
function huashanFindAct()
    EnableTriggerGroup("beinang", false)
    EnableTriggerGroup("huashan_find", true)
    job.flag()
    exe('look')
    wipe_kill = 1
    find()
end
function huashanFindKill()
    dis_all()
    EnableTrigger("huashan_find1", true)
    exe('look')
end
huashan_dadao = function()
    dis_all()
    exe('yes')
    return go(huashanFindAct, dest.area, dest.room)
end
huashan_fight = function(n, l, w)
    flag.wait = 1
    DiscardQueue()
    EnableTrigger("huashan_find2", false)
    job.id = string.lower(w[2])
    job.killer[job.target] = job.id

    -- exe('set wimpy 100')
    dis_all()
    wait.make(function()
        wait.time(2)
        exe('set wimpy 100')
    end)
    -- kezhiwugong(job.target,job.id,'pfmpfm')
    kezhiwugong()
    kezhiwugongAddTarget(job.target, job.id)
    fight.time.b = os.time()
    EnableTrigger("hpheqi1", true)
    DeleteTriggerGroup("huashan_fight")
    create_trigger_t('huashan_fight1', '^(> )*' .. job.target ..
                         '��ž����һ�����ڵ���', '', 'huashan_cut')
    create_trigger_t('huashan_fight2', '^(> )*' .. job.target ..
                         '��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��',
                     '', 'huashan_faint')
    create_trigger_t('huashan_fight3',
                     '^(> )*' .. job.target .. '�Ҵ��뿪��', '',
                     'huashanFindFail')
    create_trigger_t('huashan_fight4', '^(> )*����û�� ' .. job.id .. '��',
                     '', 'huashanFindAct')

    -- create_trigger_t('huashan_fight4','^(> )*����û�� '..job.id..'��','','huashanFindAgain')
    SetTriggerOption("huashan_fight1", "group", "huashan_fight")
    SetTriggerOption("huashan_fight2", "group", "huashan_fight")
    SetTriggerOption("huashan_fight3", "group", "huashan_fight")
    SetTriggerOption("huashan_fight4", "group", "huashan_fight")
    SetTriggerOption("huashan_fight5", "group", "huashan_fight")
    SetTriggerOption("huashan_fight6", "group", "huashan_fight")
    wait.make(function()
        repeat
            exe('unset no_kill_ap;yield no')
            exe('follow ' .. job.id)
            exe('kick ' .. job.id)
            exe('kill ' .. job.id)
            exe('set wimpycmd pfmpfm\\hp')
            exe('pfmwu')
            local l, _ = wait.regexp('^(> )*(�����' .. job.target ..
                                         '(���һ��|�ȵ�|�ͺ�һ��|���)|���ͣ�����|����û�������|�ⲻ�����������Ƶ���)',
                                     1)
            if l and l:find("�ⲻ�����������Ƶ���") then
                exe('kill ' .. job.id)
                exe('kill ' .. job.id .. " 2")
                l = nil
            end
        until l
    end)
end

huashan_faint = function()
    exe('unset wimpy;unset no_kill_ap;yield no')
    wait.make(function()
        repeat
            exe('kill ' .. job.id)
            local l, _ = wait.regexp(
                             '^(> )*(���ͣ�����|�㿴���Ѿ����Ե�|�ⲻ�����������Ƶ���)',
                             1)
            if l and l:find("�ⲻ�����������Ƶ���") then
                exe('kill ' .. job.id .. " 2")
                l = nil
            end
        until l
    end)
end
huashan_cut = function()
    EnableTriggerGroup("huashan_fight", false)
    EnableTriggerGroup("huashan_find", false)

    job.killer = {}
    fight.time.e = os.time()
    fight.time.over = fight.time.e - fight.time.b
    hstongji_thistime = fight.time.over
    weaponWieldCut()
    if hsjob2 == 1 then
        -- ��ʼͳ�ƴ���
        hstongjilasttime_l_2 = hstongji_thistime
        hstongjilasttime_l = hstongjilasttime_l + hstongjilasttime_l_2
        hstongji_2 = hstongji_2 + 1
        hstongji_pingjun = string.format("%0.2f",
                                         hstongjilasttime_l / hstongji_2)
        messageShowT('��ɽ���񣺡�' .. job.target .. '����' .. job.id ..
                         '����ʹ���书��' .. npc_skill ..
                         '�����书���ԡ�' .. npc_val .. '����')
        messageShowT('��ɽ����ս����ʱ:��' .. fight.time.over ..
                         '����,�㶨�����ˣ���' .. job.target ..
                         '��,��ɽ2���ơ�' .. hstongji_2 ..
                         '����.ƽ����ʱ��' .. hstongji_pingjun ..
                         '����', 'aqua')
    else
        -- ��ʼͳ�ƴ���
        hstongjilasttime_l_2 = hstongji_thistime
        hstongjilasttime_l_1 = hstongjilasttime_l_1 + hstongjilasttime_l_2
        hstongji_1 = hstongji_1 + 1
        hstongji_pingjun = string.format("%0.2f",
                                         hstongjilasttime_l_1 / hstongji_1)
        messageShowT('��ɽ����ս����ʱ:��' .. fight.time.over ..
                         '����,�㶨�����ˣ���' .. job.target ..
                         '��,��ɽ1���ơ�' .. hstongji_1 ..
                         '����.ƽ����ʱ��' .. hstongji_pingjun ..
                         '����', 'aqua')
    end
    local cut = false
    if job.area == '�����' then
        exe('drop corspe')
        cut = true
    end
    kezhiwugongclose()
    wait.make(function()
        local index = 1
        while index <= 5 and index > 0 do
            if cut then
                exe('halt')
                exe('get ling pai from corpse ' .. index)
                exe('qie corpse ' .. index)
            else
                exe('get corpse ' .. index)
            end
            local l, _ = wait.regexp(
                             '^(> )*(ֻ�����ǡ���һ�����㽫(\\D*)���׼�ն����������������|���컯�յ������ٰ�|���б���ɱ���˸��ﰡ|��������������޷�����|����ü����������߲���������ʬ���ͷ��|�㽫(\\D*)��ʬ������������ڱ��ϡ�|�㸽��û����������)',
                             1)
            if l then
                if l:find("�޷�����") or l:find("����������") then
                    weaponWieldCut()
                elseif l:find("û����������") then
                    index = index - 1
                else
                    index = index + 1
                    if l:find("�����������ڱ���") then
                        if l:find(job.target) then
                            checkBags()
                            for i = 1, 3 do
                                exe('get ling pai from corpse ' .. i)
                            end
                            road.id = nil
                            break
                        else
                            wait_busy()
                            exe("drop corpse")
                            cut = true
                        end
                    elseif l:find("�׼�ն������") then
                        wait.time(1)
                        wait_busy()
                        if not l:find(job.target) then
                            exe('drop head')
                        else
                            road.id = nil
                            break
                        end
                    end
                end
            end
        end
        fightoverweapon()
        await_go('��ɽ', '��̳')
        return huashan_yls_give()
    end)
end

function huashan_yls_give()
    wait.make(function()
        local line
        repeat
            exe('get ling pai from corpse;give head to yue lingshan')
            exe('give corpse to yue lingshan')
            line, _ = wait.regexp(
                          '^(> )*(���������|�㻹û��ȥ�Ҷ�������ô������̳�ˣ�|����ɺ�����������д����һ�� (һ|��) �֡�|���������������ưɣ�|���˺�������ɱ�İ�)',
                          1)
            if line and line:find('����������������') then
                exe('drop ling pai')
                line = nil
            elseif line and line:find('���˺�������ɱ�İ�') then
                exe('drop corpse')
            end
        until line
        wait_busy()
        if line:find('���������') or line:find('�㻹û��ȥ�Ҷ���') then
            return huashan_yls_fail()
        elseif line:find('д����һ�� һ') then
            if dohs2 == 0 or (lostletter == 1 and needdolost == 1) then
                repeat
                    exe('drop head;ask yue lingshan about ��������')
                    local line, _ = wait.regexp(
                                        '^(> )*��������ɺ�����йء��������ġ�����Ϣ��',
                                        1)
                until line
                return huashan_yls_back()
            else
                return huashan_heal()
            end
        elseif line:find('д����һ�� ��') then
            return huashan_yls_back()
        end
    end)

end

huashan_yls_fail = function()
    EnableTimer('walkWait4', false)
    if locl.room ~= "��̳" then return go(huashan_yls, '��ɽ', '��̳') end
    exe('out;w;s;se;su;su;s')
    return check_halt(huashan_shibai_b)
end
huashan_heal = function()
    exe('set no_kill_ap')
    exe('drop head;drop corpse')
    return check_bei(huashan_neili)
end
huashan_neili = function()
    hsjob2 = 1
    if newbie == 1 then
        return zhunbeineili(huashan_npc)
    else
        print("�������ֲ�������")
        return check_bei(huashan_npc)
    end
end

function huashan_yls_back()
    locate_finish = 0
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashanQuest", true)
    wait.make(function()
        await_go('��ɽ', '������', 'huashan/jitan')
        job.time.e = os.time()
        job.time.over = job.time.e - job.time.b
        messageShowT(
            '��ɽ�������������ʱ:��' .. job.time.over ..
                '���롣')
        repeat
            exe('give ling pai to yue buqun')
            local line, _ = wait.regexp(
                                '^(> )*�������Ⱥһ������|^(> )*����û�������',
                                1)
            if line and line:find('û�������') then
                await_go('��ɽ', '������')
                line = nil
            end
        until line
        return huashan_finish()
    end)
end

huashan_finish = function()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    job.name = 'idle'
    wudang_checkfood = 0 -- �������¼��ʳ����䵱�����顣
    map.rooms["village/zhongxin"].ways["northwest"] = "village/caidi"
    map.rooms["village/zhongxin"].ways["northeast"] = "village/caidi"
    EnableTriggerGroup("huashan_over", false)
    EnableTriggerGroup("huashanQuest", true)
    flag.times = 1
    locl.area = '��ɽ'
    locl.room = '������'
    hsjob2 = 0
    exe('drop ling pai;drop head;drop corpse')
    huashan_triggerDel()
    setLocateRoomID = 'huashan/zhengqi'
    messageShow('��ɽ����ص�ͳ�ƣ���������' .. tosld ..
                    '���� ���˵ء�' .. tocaidi .. '���� ��Ľ�ݡ�' ..
                    tomr .. '���� �������롾' .. toyzw .. '���� ��',
                "cyan")
    messageShow(
        '��ɽ2���ɵ���ص�ͳ�ƣ���ɽʯ����' .. hstohssd ..
            '���� �����ݹ뷿��' .. hstoszgf .. '���� �������á�' ..
            hstoxct .. '���� ����٢��ɽׯ��' .. tomtl .. '���� ��',
        "cyan")

    if g_stop_flag == true then
        print("�����������Ϸ��ͣ")
        g_stop_flag = false
        return disAll()
    end
    if Bag and Bag["����"] and Bag["����"].cnt and Bag["����"].cnt > 500 then
        return check_gold()
    end
    if (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt >
            count.gold_max * 4) then return check_gold() end

    hsruntime = hsruntime + 1
    if hsruntime > 9 then
        hsruntime = 0
        return check_food()
    else
        return checkPrepare()
    end
end
function huashanDgjj()
    if score.party and score.party == "��ɽ��" then
        messageShow('��ɽ���񣺳��������ʾ�ˣ�')
    end
    return huashan_finish()
end
function huashanjjQuest()
    EnableTriggerGroup("huashan_accept", false)
    if score.party and score.party == "��ɽ��" then
        messageShow(
            '��ɽ������ʾҪ�����˼����ֹͣ����ɽ����')
        job.zuhe["huashan"] = nil
        return check_heal()
    else
        return huashan_finish()
    end
end

