-------��ɽ
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
    DeleteTriggerGroup("huashan_cut")
    DeleteTriggerGroup("huashan_yls")
    DeleteTriggerGroup("huashan_yls_ask")
    DeleteTriggerGroup("huashan_over")
    DeleteTriggerGroup("huashan_find")
    flag.idle = nil
    return go(hsaskjob, '��ɽ', '������')
end
function hsaskjob()
    if newbie == 1 then
        return zhunbeineili(job_huashan)
    else
        return job_huashan()
    end
end
function job_huashan()
    EnableTriggerGroup("huashan_ask", true)
    exe('ask yue buqun about job')
    DeleteTimer("walkWait4")
    create_timer_s('walkWait4', 1.0, 'huashan_ask_test')
end
huashan_ask_test = function() exe('ask yue buqun about job') end
function huashan_trigger()
    DeleteTriggerGroup("huashan_find")
    DeleteTriggerGroup("huashan_ask")
    create_trigger_t('huashan_ask1',
                     "^(> )*��������Ⱥ�����йء�job������Ϣ��$",
                     '', 'huashan_ask')
    create_trigger_t('huashan_ask2', "^(> )*����û������ˡ�$", '',
                     'huashan_nobody')
    SetTriggerOption("huashan_ask1", "group", "huashan_ask")
    SetTriggerOption("huashan_ask2", "group", "huashan_ask")
    EnableTriggerGroup("huashan_ask", false)
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
    DeleteTriggerGroup("huashan_ask")
    DeleteTriggerGroup("huashan_accept")
    DeleteTriggerGroup("huashan_npc")
    DeleteTriggerGroup("huashan_fight")
    DeleteTriggerGroup("huashan_cut")
    DeleteTriggerGroup("huashan_yls")
    DeleteTriggerGroup("huashan_yls_ask")
    DeleteTriggerGroup("huashan_over")
    DeleteTriggerGroup("huashanQuest")
end
function huashan_ask()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_ask", false)
    EnableTriggerGroup("huashan_accept", true)
    quick_locate = 1
end
function huashan_nobody()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_ask", false)
    return huashan_start()
end
function huashan_shibai()
    EnableTriggerGroup("huashan_accept", false)
    kezhiwugongclose()
    return check_busy(huashan_shibai_b)
end
function huashan_shibai_b()
    flag.idle = nil
    DeleteTriggerGroup("all_fight")
    kezhiwugongclose()
    huashan_triggerDel()
    Execute('ask yue buqun about ʧ��')
    if job.where ~= nil and string.find(job.where, "���͵�") then
        mjlujingLog("���͵�")
    end
    messageShow('��ɽ��������ʧ�ܡ�', "Plum")
    jobfailLog()
    return check_halt(check_food)
end
function huashan_fangqi()
    DeleteTriggerGroup("all_fight")
    kezhiwugongclose()
    huashan_triggerDel()
    job.last = "huashan"
    hsjob2 = 0
    -- if job.zuhe["wudang"] then
    --   job.last='wudang'
    -- end
    return check_halt(check_food)
end
function huashan_busy()
    EnableTriggerGroup("huashan_accept", false)
    return check_bei(huashan_busy_dazuo)
end
function huashan_busy_dazuo()
    exe('#3s')
    return prepare_lianxi(check_food)
end
function huashan_npc()
    EnableTimer('walkWait4', false)
    exe('nick ��ɽ������')
    -- job.time.b=os.time()
    EnableTriggerGroup("huashan_accept", false)
    job.last = "huashan"
    if hsjob2 < 1 then
        job.time.b = os.time()
        messageShow('��ɽ���񣺿�ʼ����')
        return check_bei(huashan_npc_go)
    else
        return check_bei(huashan_npc_go2)
    end

end
function huashan_npc_go()
    go(huashan_npc_get, '��ɽ', 'ɽ����', 'huashan/zhengqi')
end
function huashan_npc_go2()
    go(huashan_npc_get, '��ɽ', 'ɽ����', 'huashan/jitan')
end
function huashan_npc_get()
    EnableTriggerGroup("huashan_npc", true)
    if score.id == 'kkfromch' then exe('set ������ ����ʽ') end
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
end
huashan_find = function(n, l, w)
    local flag_huashan = 0
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
    if string.find(job.where, "ϴ���") or
        string.find(job.where, "���º�ȭ��") or
        string.find(job.where, '�����ʯ��') then
        messageShow('��ɽ����ڣ�����ص㡾' .. job.where ..
                        '�����ɵ�����������')
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
    if not job.room or not path_cal() or
        string.find(job.where, '�����ʯ��') then
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
    quick_locate = 1
    if job.room == '����' then flag.times = 2 end
    if job.area == '����' and
        (job.room == "��ɼ��" or string.find(job.room, "����")) then
        job.room = "��ɼ��"
    end
    if string.find(job.where, '������') then return hudiegu() end
    return go(huashanFindAct, job.area, job.room, "huashan/shulin")
end
function huashan_find_again()
    EnableTimer('hskill', false)
    DeleteTimer('hskill')
    EnableTriggerGroup("huashan_find", false)
    go("��ɽ", "������")
    flag.wait = 0
    wait.make(function()
        wait.time(3.0)
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
    DeleteTimer('hskill')
    EnableTriggerGroup("beinang", false)
    EnableTriggerGroup("huashan_find", true)
    job.flag()
    exe('look')
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
    EnableTrigger("huashan_find2", false)
    job.id = string.lower(w[2])
    exe('unset no_kill_ap;yield no')
    exe('follow ' .. job.id)
    job.killer[job.target] = job.id
    exe('kick ' .. job.id)
    exe('kill ' .. job.id)
    exe('set wimpycmd pfmpfm\\hp')
    exe('pfmwu')
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

    -- hs flood��kill�����������workaround by joyce@tj
    addxml.trigger {
        custom_colour = "2",
        enabled = "y",
        group = "huashan_fight",
        match = "^(> )*�����" .. job.target ..
            "(���һ����|�ȵ���|�ͺ�һ����|�����)",
        name = "huashan_fight_hskill",
        regexp = "y",
        script = "hskill_timer_stop",
        sequence = "100"
    }
    create_timer_s('hskill', 0.4, 'hskill')
end
function hskill() -- hs flood��kill�����������workaround by joyce@tj
    exe('unset no_kill_ap;yield no')
    exe('set wimpycmd pfmpfm\\hp')
    exe('follow ' .. job.id)
    exe('kick ' .. job.id)
    exe('kill ' .. job.id)
    -- exe('set wimpy 100')
end
function hskill_timer_stop() -- hs flood��kill�����������workaround by joyce@tj
    DeleteTimer('hskill')
    EnableTrigger("huashan_fight_hskill", false)
    quick_locate = 1
end
huashan_faint = function()
    exe('unset wimpy;unset no_kill_ap;yield no')
    exe('kill ' .. job.id)
end
huashan_cut = function()
    EnableTriggerGroup("huashan_fight", false)
    EnableTriggerGroup("huashan_find", false)
    DeleteTriggerGroup("huashan_cut")
    create_trigger_t('huashan_cut1',
                     '^(> )*ֻ�����ǡ���һ�����㽫(\\D*)���׼�ն���������������С�',
                     '', 'huashan_cut_con')
    create_trigger_t('huashan_cut2',
                     '^(> )*(���컯�յ������ٰ�|���б���ɱ���˸��ﰡ|��������������޷�����|����ü����������߲���������ʬ���ͷ��)',
                     '', 'huashan_cut_weapon')
    create_trigger_t('huashan_cut3',
                     '^(> )*�㽫(\\D*)��ʬ������������ڱ��ϡ�',
                     '', 'huashan_get_con')
    create_trigger_t('huashan_cut4',
                     '^(> )*����һ��������û����ɣ�', '',
                     'huashan_get_con1')
    SetTriggerOption("huashan_cut1", "group", "huashan_cut")
    SetTriggerOption("huashan_cut2", "group", "huashan_cut")
    SetTriggerOption("huashan_cut3", "group", "huashan_cut")
    SetTriggerOption("huashan_cut4", "group", "huashan_cut")
    SetTriggerOption("huashan_cut4", "keep_evaluating", "y")
    job.killer = {}
    fight.time.e = os.time()
    fight.time.over = fight.time.e - fight.time.b
    messageShowT('��ɽ����ս����ʱ:��' .. fight.time.over ..
                     '����,�㶨�����ˣ���' .. job.target .. '����')
    -- return check_halt(huashan_cut_act)
    tmp.cnt = 0
    if job.area == '�����' then
        exe('drop corspe')
        for i = 1, 5 do
            exe('halt;get ling pai from corpse ' .. i)
            exe('qie corpse ' .. i)
        end
        create_timer_st('walkWait2', 1.0, 'huashan_cut_act1')
    else
        -- for i=1,5 do
        -- exe('get ling pai from corpse '..i)
        -- end
        exe('get corpse')
        create_timer_st('walkWait2', 1.0, 'huashan_cut_act1')
    end
end
huashan_get_con1 = function()
    EnableTimer('walkWait2', false)
    EnableTriggerGroup("huashan_fight", false)
    EnableTriggerGroup("huashan_find", false)
    checkWait(huashan_cut, 3)
end
huashan_cut1 = function()
    exe('get corpse')
    for i = 1, 5 do exe('get ling pai from corpse ' .. i) end
end
--[[huashan_cut_act=function()
    DeleteTimer('perform')
    weapon_unwield()
    weaponWieldCut()
    for i=1,5 do
       exe('halt;get ling pai from corpse '..i)
       exe('qie corpse '..i)
    end
	if fqyytmp.goArmorD==1 then
       return	
    end
	checkBags()
end]]
huashan_cut_act = function()
    tmp.cnt = 0
    weapon_unwield()
    weaponWieldCut()
    -- wipe_kill=0
    wait.make(function()
        wait.time(1.5)
        exe('drop corpse')
        for i = 1, 3 do
            exe('get ling pai from corpse ' .. i)
            exe('qie corpse ' .. i)
        end
        create_timer_s('walkWait2', 1.0, 'huashan_cut_act1')
    end)
end
function huashan_cut_act1()
    if tmp.cnt then tmp.cnt = tmp.cnt + 1 end
    if not tmp.cnt or tmp.cnt > 10 then
        dis_all()
        return huashanFindFail()
    end
    exe('drop corpse')
    for i = 1, 3 do
        exe('get ling pai from corpse ' .. i)
        exe('qie corpse ' .. i)
    end
end
huashan_cut_weapon = function()
    DeleteTimer('walkWait2')
    return check_halt(huashan_cut_act, 1)
end
huashan_get_con = function(n, l, w)
    DeleteTimer('walkWait2')
    DeleteTriggerGroup("all_fight")
    EnableTriggerGroup("huashan_npc", false)
    kezhiwugongclose()
    if fqyytmp.goArmorD ~= 1 then checkBags() end
    if job.target == tostring(w[2]) then
        EnableTriggerGroup("huashan_npc", false)
        EnableTriggerGroup("huashan_cut", false)
        -- fpk_prepare()--Ԥ��pk�����ã�������skill.lua��
        for i = 1, 3 do exe('get ling pai from corpse ' .. i) end
        road.id = nil
        fightoverweapon()
        return go(huashan_yls_give, '��ɽ', '��̳')
    else
        return check_halt(huashan_cut_act)
    end
end
huashan_cut_con = function(n, l, w)
    EnableTimer('walkWait2', false)
    DeleteTriggerGroup("all_fight")
    EnableTriggerGroup("huashan_npc", false)
    kezhiwugongclose()
    flag.find = 0
    if job.target ~= tostring(w[2]) then
        exe('drop head')
        return check_halt(huashan_cut_act)
    else
        EnableTriggerGroup("huashan_cut", false)
        road.id = nil
        wait.make(function()
            wait.time(1)
            fightoverweapon()
            return go(huashan_yls_give, '��ɽ', '��̳')
        end)
    end
end
huashan_yls = function()
    huashan_yls_trigger()
    EnableTriggerGroup("ylshead", true)
    exe('alias action ��ɽ�������')
    create_timer_s('walkWait4', 0.6, 'huashan_yls_timer')
end

huashan_yls_trigger = function()
    DeleteTriggerGroup("ylshead")
    create_trigger_t('ylshead1',
                     '^(> )*��� "action" �趨Ϊ "��ɽ�������" �ɹ���ɡ�$',
                     '', 'huashan_yls_give')
    SetTriggerOption("ylshead1", "group", "ylshead")
    EnableTriggerGroup("ylshead", false)
end

huashan_yls_timer = function()
    exe('get ling pai from corpse;give head to yue lingshan')
    exe('give corpse to yue lingshan')
end

huashan_yls_give = function()
    EnableTriggerGroup("ylshead", false)
    DeleteTriggerGroup("huashan_yls")
    -- create_trigger_t('huashan_yls1','^(> )*(����û������ˡ�|������û������������|���˺�������ɱ�İɣ�|���������|�㻹û��ȥ�Ҷ�������ô������̳�ˣ�)','','huashan_yls_fail')
    -- create_trigger_t('huashan_yls1','^(> )*(���˺�������ɱ�İɣ�|���������|�㻹û��ȥ�Ҷ�������ô������̳�ˣ�)','','huashan_yls_fail')
    create_trigger_t('huashan_yls1',
                     '^(> )*(���������|�㻹û��ȥ�Ҷ�������ô������̳�ˣ�)',
                     '', 'huashan_yls_fail')
    create_trigger_t('huashan_yls2',
                     '^(> )*����ɺ�����������д����һ�� (һ|��) �֡�',
                     '', 'huashan_yls_ask')
    create_trigger_t('huashan_yls3',
                     '^(> )*���������������ưɣ�', '',
                     'huashan_yls_lingpai')
    SetTriggerOption("huashan_yls1", "group", "huashan_yls")
    SetTriggerOption("huashan_yls2", "group", "huashan_yls")
    SetTriggerOption("huashan_yls3", "group", "huashan_yls")
    EnableTriggerGroup("huashan_yls", true)
    exe('get ling pai from corpse;give head to yue lingshan')
    exe('give corpse to yue lingshan')
    create_timer_s('walkWait4', 2.0, 'huashan_yls_timer')
end
--[[huashan_head_return=function()
    exe('give head to yue lingshan;hp')        
end]]
huashan_yls_fail = function()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls", false)
    if locl.room ~= "��̳" then return go(huashan_yls, '��ɽ', '��̳') end
    exe('out;w;s;se;su;su;s')
    return check_halt(huashan_shibai_b)
end
huashan_yls_lingpai = function()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls", false)
    exe('drop ling pai')
    return check_halt(huashan_yls)
end
huashan_yls_ask = function(n, l, w)
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls", false)
    DeleteTriggerGroup("huashan_yls_ask")
    create_trigger_t('huashan_yls_ask1',
                     '^(> )*��������ɺ�����йء��������ġ�����Ϣ��',
                     '', 'huashan_yls_back')
    SetTriggerOption("huashan_yls_ask1", "group", "huashan_yls_ask")
    EnableTriggerGroup("huashan_yls_ask", false)
    quick_locate = 1
    if w[2] == '��' then return huashan_yls_back() end
    if w[2] == 'һ' and (dohs2 == 0 or (lostletter == 1 and needdolost == 1)) then
        wait.make(function()
            wait.time(2.0)
            return check_bei(huashan_yls_lbcx)
        end)
        -- return check_bei(huashan_yls_lbcx)
    else
        wait.make(function()
            wait.time(2.0)
            return check_bei(huashan_heal)
        end)
        -- return check_bei(huashan_heal)
    end
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
huashan_yls_lbcx = function()
    EnableTriggerGroup("huashan_yls_ask", true)
    weapon_unwield()
    return exe('drop head;askk yue lingshan about ��������')
end
huashan_yls_back = function()
    EnableTimer('walkWait4', false)
    EnableTriggerGroup("huashan_yls_ask", false)
    EnableTriggerGroup("huashanQuest", true)
    DeleteTriggerGroup("huashan_over")
    create_trigger_t('huashan_over1', '^(> )*�������Ⱥһ�����ơ�',
                     '', 'huashan_finish')
    create_trigger_t('huashan_over2', '^(> )*����û������ˡ�', '', '')
    SetTriggerOption("huashan_over1", "group", "huashan_over")
    SetTriggerOption("huashan_over2", "group", "huashan_over")
    quick_locate = 1
    return go(huashan_over, '��ɽ', '������', 'huashan/jitan')
end
huashan_over = function()
    -- weapon_unwield()
    EnableTriggerGroup("huashanQuest", true)
    job.time.e = os.time()
    job.time.over = job.time.e - job.time.b
    messageShowT('��ɽ�������������ʱ:��' .. job.time.over ..
                     '���롣')
    exe('give ling pai to yue buqun')
    DeleteTimer("walkWait4")
    create_timer_s('walkWait4', 1.0, 'job_huashan_over1')
end
function job_huashan_over1() exe('give ling pai to yue buqun') end
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
    quick_locate = 1
    locl.area = '��ɽ'
    locl.room = '������'
    hsjob2 = 0
    exe('drop ling pai;drop head;drop corpse')
    -- jobExpTongji()
    huashan_triggerDel()
    -- if job.zuhe["wudang"] then
    --     job.last='wudang'
    -- end
    setLocateRoomID = 'huashan/zhengqi'
    -- return check_halt(check_food)ԭ����check_foodע������
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

