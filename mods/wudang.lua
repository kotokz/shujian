-- wudang
wdtongji_total = 0
wdtongji_cs = 0 -- ��ȡjob����ͳ��
wdtongji_lasttime_total = 0
wdtongji_zdcs = 0 -- ս������
wdtongji_lasttime_lj = 0 -- �ۼ�ս��ʱ��
wdtongji_thistime = 0 -- ��������ս��ʱ��
wdtongji_pingjun = 0 -- ƽ��ʱ��
wdtongji_fangqi = 0 -- ʧ�ܴ���
wdtongji_finish = 0 -- ��ɴ���
wdtongji_cgl = 0 -- �ɹ���
wdtosld = 0
wdtomr = 0
wdtoyzw = 0
wdtomtl = 0
wdtoszgf = 0
wdtohssd = 0
wdtoxct = 0
wudang_cs = 0

-- ������ɡ�'..wdtongji_cs'����,ƽ��ս��ʱ�䡾����,�ɹ������Σ�ʧ�ܡ����Σ�����ʡ���
wdgostart = 0
function wudangTrigger()
    DeleteTriggerGroup("wudangAsk")
    create_trigger_t('wudangAsk1', "^(> )*������Զ�Ŵ����й�", '',
                     'wudangAsk')
    create_trigger_t('wudangAsk2', "^(> )*����û������ˡ�$", '',
                     'wudangNobody')
    SetTriggerOption("wudangAsk1", "group", "wudangAsk")
    SetTriggerOption("wudangAsk2", "group", "wudangAsk")
    EnableTriggerGroup("wudangAsk", false)
    DeleteTriggerGroup("wudangAccept")
    create_trigger_t('wudangAccept1',
                     "^(> )*��Զ������Ķ�������˵������˵(\\D*)����(\\D*)����",
                     '', 'wudangConsider')
    create_trigger_t('wudangAccept2',
                     "^(> )*��Զ��˵�������Ҳ��Ǹ���������������",
                     '', 'wudangFangqi')
    create_trigger_t('wudangAccept3',
                     "^(> )*��Զ������Ķ�������˵��(\\D*)��Ϊ�ó�(\\D*)�Ĺ���",
                     '', 'wudangNpc')
    create_trigger_t('wudangAccept4',
                     "^(> )*��Զ��˵����������æ�ű��������",
                     '', 'wudangFail')
    create_trigger_t('wudangAccept5',
                     "^(> )*��Զ��˵�������������(�䵱����|�Ͷ�����|��������|������Ħ��|�ٸ�����|���ݻ���)����",
                     '', 'wudangFail')
    create_trigger_t('wudangAccept6',
                     "^(> )*��Զ��˵������������ʱû���ʺ���Ĺ���",
                     '', 'wudangFail')
    create_trigger_t('wudangAccept7',
                     "^(> )*��Զ��˵��������ʱû��������Ҫ�������һ���������",
                     '', 'wudangFail')
    create_trigger_t('wudangAccept8',
                     "^(> )*��Զ��˵������\\D*����̫����ʧ���ˣ���Ȼ��ô���ɲ��ã������°�",
                     '', 'wudangFail')
    create_trigger_t('wudangAccept9',
                     "^(> )*��Զ��˵������\\D*������û��������������Ϲ����ʲôѽ",
                     '', 'wudangFail')
    create_trigger_t('wudangAccept10',
                     "^(> )*��Զ��˵������\\D*���������ȷʵ�Ƚ�����ɣ��´θ���򵥵ģ������°ɣ�",
                     '', 'wudangFail')
    create_trigger_t('wudangAccepta',
                     "^(> )*��Զ������Ķ�������˵�������˵��书(\\D*)��",
                     '', 'wudanglevel')
    create_trigger_t('wudangAcceptb',
                     "^(> )*��Զ��\\D*���ȥ��أ�һ��С�İ���",
                     '', 'wudangFindGo')
    create_trigger_t('wudangAccept31',
                     "^(> )*��Զ������Ķ�������˵������ͷ����׷�鵽(\\D*)�����䵱������Ϊ�ó�(\\D*)�Ĺ���",
                     '', 'wudangNpc')
    SetTriggerOption("wudangAccept31", "group", "wudangAccept")
    SetTriggerOption("wudangAccept1", "group", "wudangAccept")
    SetTriggerOption("wudangAccept2", "group", "wudangAccept")
    SetTriggerOption("wudangAccept3", "group", "wudangAccept")
    SetTriggerOption("wudangAccept4", "group", "wudangAccept")
    SetTriggerOption("wudangAccept5", "group", "wudangAccept")
    SetTriggerOption("wudangAccept6", "group", "wudangAccept")
    SetTriggerOption("wudangAccept7", "group", "wudangAccept")
    SetTriggerOption("wudangAccept8", "group", "wudangAccept")
    SetTriggerOption("wudangAccept9", "group", "wudangAccept")
    SetTriggerOption("wudangAccept10", "group", "wudangAccept")
    SetTriggerOption("wudangAccepta", "group", "wudangAccept")
    SetTriggerOption("wudangAcceptb", "group", "wudangAccept")
    EnableTriggerGroup("wudangAccept", false)
    DeleteTriggerGroup("wudangFight")
    create_trigger_t('wudangFight1',
                     '^(> )*(\\D*)��ž����һ�����ڵ���', '',
                     'wudangBack')
    create_trigger_t('wudangFight2',
                     '^(> )*(\\D*)��һ�������ã���ת��������Ͳ�����',
                     '', 'wudangBack')
    create_trigger_t('wudangFight3', "^(> )*����û��(\\D*)��", '',
                     'wudangLost')
    create_trigger_t('wudangFight4',
                     "^(> )*(\\D*)�����㷢��һ����Ц��˵��", '',
                     'wudangKillAct')
    create_trigger_t('wudangFight5',
                     "^(> )*(\\D*)��һ�������Ӳ������ˣ�ת��������Ͳ�����",
                     '', 'wudangBack')
    create_trigger_t('wudangFight6',
                     '^>*\\s*һ��ů�����Ե�������ȫ�����������ָֻ���֪������',
                     '', 'wudangFangqiGo')
    create_trigger_t('wudangFight7', "^(��|��)װ���ţ�$", '', 'npcWeapon')
    SetTriggerOption("wudangFight1", "group", "wudangFight")
    SetTriggerOption("wudangFight2", "group", "wudangFight")
    SetTriggerOption("wudangFight3", "group", "wudangFight")
    SetTriggerOption("wudangFight4", "group", "wudangFight")
    SetTriggerOption("wudangFight5", "group", "wudangFight")
    SetTriggerOption("wudangFight6", "group", "wudangFight")
    SetTriggerOption("wudangFight7", "group", "wudangFight")
    EnableTriggerGroup("wudangFight", false)
    DeleteTriggerGroup("wudangFinish")
    create_trigger_t('wudangFinish1',
                     '^(> )*��Զ�Ŷ��������������ִ�Ĵָ�������ġ�',
                     '', 'wudangFinishT')
    create_trigger_t('wudangFinish2',
                     "^(> )*��Զ�ű������û��˹�ȥ��", '',
                     'wudangFinish')
    create_trigger_t('wudangFinish3', "^(> )*��Զ��˵������" ..
                         score.name .. "����ô���", '', 'wudangFinish')
    SetTriggerOption("wudangFinish1", "group", "wudangFinish")
    SetTriggerOption("wudangFinish2", "group", "wudangFinish")
    SetTriggerOption("wudangFinish3", "group", "wudangFinish")
    EnableTriggerGroup("wudangFinish", false)
    DeleteTriggerGroup("wudangdebug")
    create_trigger_t('wudangdebug1', '^(> )*�������һ���������', '',
                     'wudangdebugFind')
    SetTriggerOption("wudangdebug1", "group", "wudangdebug")
    EnableTriggerGroup("wudangdebug", true)
end
jobFindAgain = jobFindAgain or {}
jobFindAgain["wudang"] = "wudangFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["wudang"] = "wudangFindFail"
function wudangFindAgain()
    wdgostart = 1
    EnableTriggerGroup("wudangFind", true)
    if flag.times == 3 and job.area == '��ɽ��' then
        return go(wudangFindAct, '��ɽ��', '�˵�')
    end
    if flag.times == 2 and dest.area == '������' and dest.room ==
        'ɽ��յ�' then
        return go(wudangFindAct, '��������', '�ٲ�')
    end
    if flag.times == 2 and dest.area == '����' and
        (dest.room == "��ɼ��" or string.find(dest.room, "����")) then
        return go(wudangFindAct, '����', '���䳡')
    end
    if flag.times == 3 and job.area == '���ݳ�' and
        (job.room == '����' or job.room == '�ϴ��' or job.room ==
            '��������') then
        return go(wudangFindAct, '���ݳ�', '�����ϰ�')
    end
    if flag.times == 3 and job.area == '���ݳ�' and job.room == '������' then
        return go(wudangFindAct, '���ݳ�', '����')
    end
    --[[if flag.times==3 and job.area=='���ݳ�' and job.room=='����' then
		return go(wudangFindAct,'���ݳ�','������')
	end]]
    if flag.times == 3 and job.area == '��ɽ����' and job.room ==
        "�޺���" then
        return go(wudangFindAct, '��ɽ����', '�޺����岿')
    end
    if flag.times == 3 and job.area == '��ɽ����' and job.room ==
        "������" then
        return go(wudangFindAct, '��ɽ����', '�������岿')
    end
    return go(wudangFindAct, job.area, job.room)
end
function wudangFindFail()
    EnableTriggerGroup("wudangFight", false)
    return check_busy(wdFindFail)
end
faintFunc = faintFunc or {}
faintFunc["wudang"] = "wudangFindAgain"
function wudangFaint() return wudangFindFail() end
function wdFindFail()
    locate_finish = 0
    fastLocate()
    go(wudangFangqi, "�䵱ɽ", "�����")
end
function wudanglevel(n, l, w)
    job.level = w[2]
    -- messageShow('WD job level:��'..job.level..'��')
end
function wudangTriggerDel()
    DeleteTriggerGroup("wudangdebug")
    DeleteTriggerGroup("wudangAsk")
    DeleteTriggerGroup("wudangAccept")
    DeleteTriggerGroup("wudangFight")
    DeleteTriggerGroup("wudangFinish")
    DeleteTriggerGroup("wudangFind")
end
function wudangNobody()
    EnableTriggerGroup("wudangAsk", false)
    wudang()
end
job.list["wudang"] = "�䵱ɱ����"
function wudang()
    wudangTrigger()
    job.level = nil
    job.lost = 0
    job.name = 'wudang'
    wait.make(function()
        wait_busy()
        return wudangGo()
    end)
    -- return check_busy(wudangGo)
end
function wudangGo() return go(wudangBegin, "�䵱ɽ", "�����") end
function wudangBegin()
    if newbie == 1 then
        return zhunbeineili(wdstart)
    else
        return wdstart()
    end
end
function wdstart()
    locate_finish = 0
    return prepare_lianxi(wudangStart)
end
function wudangStart()
    wdgostart = 1
    EnableTriggerGroup("wudangAsk", true)
    flag.idle = nil
    return wudangAsk11()
end
function wudangAsk11()
    wdsearch_get = 0
    flag.wipe = 1
    wudang_canagain = 0
    EnableTriggerGroup("wudangAsk", true)
    return check_busy(wudang_check_ask)
end
function wudang_check_ask()
    exe('ask song yuanqiao about job')
    create_timer_s('walkWait4', 3.0, 'wudang_ask_test')
end
wudang_ask_test = function() exe('ask song yuanqiao about job') end
function wudangAsk()
    dis_all()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("wudangAsk", false)
    EnableTriggerGroup("wudangAccept", true)
end
function wudangBusy()
    EnableTriggerGroup("wudangAccept", false)
    job.last = 'wudang'
    return check_bei(wudangBusyDazuo)
end
function wudangBusyDazuo()
    exe('n')
    return prepare_lianxi(wudang)
end
function wudangFail()
    wdgostart = 0
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("wudangAccept", false)
    if job.level == '���뻯��' then
        job.level = 'δ֪'
        messageShow(
            '�䵱���񣺵�ǰ�ӵ������뻯�����������ڿ�ʼ������ȼ�Ϊ��' ..
                job.level .. '����', 'red')
        return check_busy(wudangHuajing_GoAgain)
    end
    wudangTriggerDel()
    job.lost = 0
    -- job.last='wudang'
    setLocateRoomID = 'wudang/sanqing'
    if score.party == '��ɽ��' and hp.shen < 0 then return clb() end
    if job.last == "songxin" or job.last == "songmoya" then
        return huashan()
    else
        if wudang_checkfood == 1 then
            wudang_checkfood = 0
            for p in pairs(weaponUsave) do
                if Bag and not Bag[p] then return songxin() end
            end
            if vippoison == 1 then return songxin() end
            if locl.weekday == '��' and (locl.hour == 6 or locl.hour == 7) and
                locl.min <= 55 then return songxin() end
            if mytime <= os.time() and SMYID[score.id] and score.xingyun and
                score.xiangyun ~= '˥' and score.xiangyun ~= '��' then
                return songmoya()
            else
                return songxin()
            end
        else
            wudang_checkfood = 1
            return check_food()
        end
    end
end
function wudangConsider(n, l, w)
    local x
    nobusy = 1
    job.time.b = os.time()
    job.last = 'wudang'
    job.target = Trim(w[2])
    job.killer = {}
    job.killer[job.target] = true
    job.where = Trim(w[3])
    jobtarget1 = string.sub(job.target, 1, 8)
    jobtarget2 = string.gsub(job.target, jobtarget1, "")
    job.target = jobtarget2
    -- Note(job.where)
    if string.find(job.where, "��Χ") then
        local l_cnt = string.find(job.where, "��Χ")
        job.where = string.sub(job.where, 1, l_cnt - 1)
    end
    if string.find(Trim(w[3]), "��֮��") then
        x = string.find(Trim(w[3]), "��֮��")
        wd_distance = trans(string.sub(Trim(w[3]), x - 2, x - 1))
    else
        wd_distance = 4
    end
    if string.find(job.where, '������') then wdtosld = wdtosld + 1 end
    if string.find(job.where, '����Ľ��') then wdtomr = wdtomr + 1 end
    if string.find(job.where, '������') then wdtoyzw = wdtoyzw + 1 end
    if string.find(job.where, '��٢��ɽׯ') then wdtomtl = wdtomtl + 1 end
    if string.find(job.where, '���ݳǹ뷿') then wdtoszgf = wdtoszgf + 1 end
    if string.find(job.where, '��ɽʯ��') and not Bag['����'] then
        job.where = "��ɽɽ��"
        wdtohssd = wdtohssd + 1
    end
    if string.find(job.where, "��ɽ���ֲ˵�") then
        job.where = '��ɽ������ǰ�㳡'
        messageShow('�ص�����ɽ���ֲ˵ظ�Ϊ��ɽ������ǰ�㳡',
                    'violet')
    end
    if string.find(job.where, "������") then
        wdtoxct = wdtoxct + 1
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
    if string.find(job.where, '���º�ȭ��') or
        string.find(job.where, '�䵱��ɽԺ��') or
        string.find(job.where, '�䵱ɽ��ɽСԺ') then
        messageShow('�䵱����ڣ�����ص㡾' .. job.where ..
                        '�����ɵ�����������')
        return check_halt(wudangFindFail)
    end
    if (string.find(job.where, "�������ƹ�") or
        string.find(job.where, "��������¥") or
        string.find(job.where, "�鱦��")) then
        job.where = "���ݳ������"
    end
    messageShow('�䵱�ص�ͳ�ƣ���������' .. wdtosld ..
                    '���� ��Ľ�ݡ�' .. wdtomr .. '���� �������롾' ..
                    wdtoyzw .. '���� ����٢��ɽׯ��' .. wdtomtl ..
                    '���� ��', "cyan")
    messageShow(
        '�䵱���ɵ���ص�ͳ�ƣ���ɽʯ����' .. wdtohssd ..
            '���� �����ݹ뷿��' .. wdtoszgf .. '���� �������á�' ..
            wdtoxct .. '���� ��', "cyan")
    job.room, job.area = getAddr(job.where)
end
function wudangNpc(n, l, w)
    EnableTriggerGroup("wudangAccept", false)
    EnableTrigger("wudangAccepta", true)
    EnableTrigger("wudangAcceptb", true)
    sxjob.skills = tostring(w[3])
    -- ��ʼͳ��
    wdtongji_cs = wdtongji_cs + 1
end
function wudangFindGo()
    EnableTriggerGroup("wudangAccept", false)
    dest.room = job.room
    dest.area = job.area
    job.wdtime = os.time() + 8 * 60
    exe('nick �䵱����' .. job.where)
    exe('set no_kill_ap')
    -- pfmjineng()
    setLocateRoomID = 'wudang/sanqing'
    if not job.room or not path_cal() or
        string.find(job.where, '�����ʯ��') then
        messageShow('�䵱��������ص㡾' .. job.where ..
                        '�����ɵ�����������', "Plum")
        return check_busy(wudangFangqi)
    end
    if skillIgnores[sxjob.skills] then
        messageShow(
            '�䵱����' .. job.target .. 'ʹ�õ��书�ǡ�' ..
                sxjob.skills .. '���������У����������')
        return check_busy(wudangFangqi)
    end
    if job.level == '���뻯��' then
        return check_busy(wudangHuajing_Fangqi)
    end
    -- messageShow('�䵱�����Ҫ������ص㡾'..job.where..'��������������'..job.target..'����ʹ�ü��ܡ�'..sxjob.skills..'����')
    messageShow('�䵱�������ڿ�ʼǰ����' .. job.where .. '����')
    return check_busy(wudangFind)
end
function wudangHuajing_Fangqi()
    EnableTriggerGroup("wudangAccept", false)
    messageShow('�䵱���񣺼�װ�������뻯��!', 'greenyellow')
    return check_busy(wudangFangqiAsk)
end
function wudangHuajing_GoAgain()
    job.wdtime = os.time() + 5 * 60
    -- messageShow('�䵱�����Ҫ������ص㡾'..job.where..'��������������'..job.target..'����ʹ�ü��ܡ�'..sxjob.skills..'����','greenyellow')
    messageShow('�䵱�������ڿ�ʼǰ����' .. job.where .. '����',
                'greenyellow')
    return check_busy(wudangFind)
end
function wudangFangqiGo()
    locate_finish = 0
    fastLocate()
    DeleteTimer("wudang")
    messageShow('���䵱����NPC�����ˣ����������')
    geta()
    go(wudangFangqi, '�䵱ɽ', '�����')
end
function wudangFangqi()
    wdtongji_fangqi = wdtongji_fangqi + 1
    exe('nick �䵱�������')
    exe('unset no_kill_ap')
    locate_finish = 0
    fastLocate()
    dis_all()
    kezhiwugongclose()
    flag.idle = nil
    job.level = nil
    job.lost = 0
    nobusy = 0
    EnableTriggerGroup("wudangAccept", false)
    check_bei(wudangFangqiAsk)
end
function wudangFangqiAsk()
    EnableTriggerGroup("wudangAsk", true)
    exe('ask song yuanqiao about ����')
    setLocateRoomID = 'wudang/sanqing'
end

function wudangFind()
    wdgostart = 1
    DeleteTriggerGroup("wudangFind")
    create_trigger_t('wudangFind1', '^\\s*' .. jobtarget1 .. '\\s*' ..
                         jobtarget2 .. '\\((\\D*)\\)', '', 'wudangTarget')
    create_trigger_t('wudangFind2', "^(> )*" .. jobtarget2 ..
                         "(�����㷢��һ����Ц��˵������Ȼ�������\\D*ײ���ˣ���Ҳ��ֻ�����������ˣ�|����˵����\\D*����׷���ᣬ��Ȼ�Ӳ�����\\D*�Ҹ���ƴ�ˣ�|������˵�����ٺ٣��е��Ҹ�������\\D*�������ˣ�|�������߹�������ɫ��Щ�쳣����æ������ͷ��)",
                     '', 'wudangFindKill')
    create_trigger_t('wudangFind3', "^(> )*\\D*" .. jobtarget2 ..
                         "�����㷢��һ����Ц��˵����\\D*������ط�̫С�����ָ�\\D*������Ȼ��Ȼ���",
                     '', 'wudangLost')
    -- create_trigger_t('wudangFind4',"^(> )*�����"..jobtarget2.."һ���߹�ȥ��\\D*������������㣡"..jobtarget2.."���Ʋ������һ���������Ӵܡ�",'','wudangLost')
    SetTriggerOption("wudangFind1", "group", "wudangFind")
    SetTriggerOption("wudangFind2", "group", "wudangFind")
    SetTriggerOption("wudangFind3", "group", "wudangFind")
    SetTriggerOption("wudangFind1", "keep_evaluating", "y")
    flag.times = 1
    flag.robber = false
    local tmppfm = GetVariable("pfmsanqing") -- ��Ĺ�ɺ�����ߴ������÷�ֹ����kezhiwugong.luaʶ���˵�npc��ʽ
    -- create_alias('kezhiwugongpfm','kezhiwugongpfm','alias pfmpfm '..tmppfm)
    -- exe('kezhiwugongpfm')
    if score.id == 'kkfromch' then exe('set ������ ����ʽ') end
    exe('unset wimpy;set wimpycmd pfmpfm\\hp')
    -- if string.find(job.where, '������') then return hudiegu() end
    go(wudangFindAct, job.area, job.room)
end
function wudangdebugFind()
    DeleteTriggerGroup("wudangFind")
    create_trigger_t('wudangFind1', '^\\s*' .. jobtarget1 .. '\\s*' ..
                         jobtarget2 .. '\\((\\D*)\\)', '', 'wudangTarget')
    SetTriggerOption("wudangFind1", "group", "wudangFind")
    SetTriggerOption("wudangFind1", "keep_evaluating", "y")
    flag.times = 1
    flag.robber = false
    exe('unset wimpy;set wimpycmd pfmpfm\\hp')
    go(wudangFinddebug, job.area, job.room)
end
function wudangFinddebug()
    EnableTriggerGroup("wudangFind", true)
    DeleteTimer("wudang")
    job.flag()
    exe('look')
    find()
    messageShow(
        '�䵱���񣺿�ʼ����Ѱ�ҡ�' .. dest.area .. dest.room ..
            '����' .. '��' .. job.target .. '����')
end
function wudangFindAct()
    wdgostart = 0
    DeleteTriggerGroup("wudangFind")
    create_trigger_t('wudangFind1', '^\\s*' .. jobtarget1 .. '\\s*' ..
                         jobtarget2 .. '\\((\\D*)\\)', '', 'wudangTarget')
    create_trigger_t('wudangFind2', "^(> )*" .. jobtarget2 ..
                         "(�����㷢��һ����Ц��˵������Ȼ�������\\D*ײ���ˣ���Ҳ��ֻ�����������ˣ�|����˵����\\D*����׷���ᣬ��Ȼ�Ӳ�����\\D*�Ҹ���ƴ�ˣ�|������˵�����ٺ٣��е��Ҹ�������\\D*�������ˣ�|�������߹�������ɫ��Щ�쳣����æ������ͷ��)",
                     '', 'wudangFindKill')
    create_trigger_t('wudangFind3', "^(> )*\\D*" .. jobtarget2 ..
                         "�����㷢��һ����Ц��˵����\\D*������ط�̫С�����ָ�\\D*������Ȼ��Ȼ���",
                     '', 'wudangLost')
    -- create_trigger_t('wudangFind4',"^(> )*�����"..jobtarget2.."һ���߹�ȥ��\\D*������������㣡"..jobtarget2.."���Ʋ������һ���������Ӵܡ�",'','wudangLost')
    SetTriggerOption("wudangFind1", "group", "wudangFind")
    SetTriggerOption("wudangFind2", "group", "wudangFind")
    SetTriggerOption("wudangFind3", "group", "wudangFind")
    SetTriggerOption("wudangFind1", "keep_evaluating", "y")
    EnableTriggerGroup("wudangFind", true)
    DeleteTimer("wudang")
    job.flag()
    exe('look')
    find()
    messageShow('�䵱�����ѵ�������ص㡾' .. job.where ..
                    '������ʼѰ�ҡ�' .. dest.area .. dest.room ..
                    '����' .. '��' .. jobtarget1 .. '��' .. '��' ..
                    job.target .. '����')
end
function wudangFindKill()
    wdgostart = 0
    dis_all()
    flag.robber = true
    EnableTriggerGroup("wudangdebug", true)
    EnableTrigger("wudangFind1", true)
    exe('look')
    -- create_timer_s('walkWaitX', 1.0, 'wd_look_again')
end
-- function wd_look_again() exe('look') end
function wudangTarget(n, l, w)
    EnableTriggerGroup("wudangFind", false)
    dis_all()
    EnableTrigger("wudangFind3", true)
    EnableTriggerGroup("wudangdebug", true)
    EnableTriggerGroup("wudangFight", true)
    EnableTrigger("hpheqi1", true)
    job.id = string.lower(w[1])
    job.killer[job.target] = job.id
    exe('follow ' .. job.id)
    exe('unset no_kill_ap')
    wudangKillAct()
    create_timer_s('wudang', 5, 'wudangMove')
end
function wudangMove()
    if job.id then
        exe('kick ' .. job.id)
        exe('kill ' .. job.id)
    end
end
function wudangLost(n, l, w)
    wdgostart = 0
    locate_finish = 0
    fastLocate()
    job.lost = job.lost + 1
    if job.lost > 3 then
        job.lost = 0
        jobfailLog()
        messageShow('�䵱����������ʧ��' .. job.target ..
                        '�����Σ���ȥ������', "Plum")
        return check_halt(wudangFindFail)
    end
    -- if job.id==Trim(w[2]) then
    dis_all()
    EnableTriggerGroup("wudangdebug", true)
    messageShow('�䵱����������ʧ��' .. job.target ..
                    '������ͷ���ң�', "white")
    return wudangFindAct()
    -- return wudangFind()
    -- return wudangLostFind()
    -- end
end
function wudangKill()
    -- wait.make(function()
    --     wait.time(0.2)
    --     wudangKillAct()
    -- end)
    wudangKillAct()
end
function wudangKillAct()
    wdgostart = 0
    fight.time.b = os.time()
    flag.robber = true
    exe('set wimpy 100;yield no')
    exe('kill ' .. job.id)
    exe('set wimpycmd pfmpfm\\hp')
    -- exe('set wimpycmd pppp1\\hp')
    wait.make(function()
        wait.time(2)
        exe('set wimpy 100')
    end)
    kezhiwugong()
    kezhiwugongAddTarget(job.target, job.id)

end

function wudangBack(n, l, w)
    EnableTriggerGroup("wipe", false)
    wdgostart = 0
    flag.find = 0
    flag.wait = 0
    DeleteTimer("wudang")
    if w[2] == job.target then
        EnableTriggerGroup("wudangFight", false)
        EnableTriggerGroup("wudangFinish", true)
        tmp.number = 0
        DeleteTimer("perform")
        DeleteTimer("wudang")
        kezhiwugongclose()
        -- fpk_prepare()--Ԥ��pk�����ã�������skill.lua��
        check_busy(wudangBackGet)
        fight.time.e = os.time()
        fight.time.over = fight.time.e - fight.time.b
        wdtongji_thistime = fight.time.over
        -- ��ʼͳ��
        wdtongji_zdcs = wdtongji_zdcs + 1
        wdtongji_lasttime_lj = wdtongji_lasttime_lj + wdtongji_thistime
        wdtongji_pingjun = string.format("%0.2f",
                                         wdtongji_lasttime_lj / wdtongji_zdcs)
        messageShowT('�䵱���񣺡�' .. job.target .. '����' .. job.id ..
                         '����ʹ���书��' .. npc_skill ..
                         '�����书���ԡ�' .. npc_val .. '����')
        messageShowT('�䵱���񣺸㶨' .. '��' .. job.target ..
                         '����ս����ʱ:��' .. fight.time.over ..
                         '���롣')
    end
end
function wudangBackGet()
    geta()
    wipe_kill = 0
    wudangCk = 0
    flag.wipe = 0
    dis_all()
    weapon_unwield()
    bqcheck()
    EnableTriggerGroup("wudangFinish", true)
    -- return go(wudangFinishWait,'�䵱ɽ','�����')
    EnableTrigger("bags6", true) -- �������ʧ���ż㴥������
    road.id = nil
    fightoverweapon()
    if needdolost == 1 then checkBags() end
    return go(wudangFinishC, '�䵱ɽ', '�����')
end
function wudangFinishWait()
    if locl.id["��Զ��"] then
        return wudangFinishC()
    else
        return go(wudangFinishWait, '�䵱ɽ', '�����')
    end
end
function wudangFinishT()
    wdtongji_finish = wdtongji_finish + 1
    wudang_cs = wudang_cs + 1
    print('���ο��Ҹɵúá�')
    -- setLocateRoomID='wudang/sanqing'
end
function wudangFinishC()
    print('�ȴ����η�������')
    if wudangjobok == 0 and wudangCk < 5 then
        wait.make(function()
            wait.time(1)
            wudangCk = wudangCk + 1
            exe('out;enter')
            return wudangFinishC()
        end)
    else
        return wudangFangqi()
    end
end
function wudangFinish()
    job.name = 'idle'
    EnableTriggerGroup("wudangFinish", false)
    wudangTriggerDel()
    wudangjobok = 0
    wudangcss = 1
    wudangcs = wudangcss + 1
    job.wdtime = 0
    wudangCk = 0
    nobusy = 0
    locate_finish = 0
    job.lost = 0

    wdgostart = 0
    job.last = 'wudang'
    kezhiwugongclose()
    -- return check_food()--���Թر��䵱�����check��
    button_smyteam() -- check_heal()���Ų����������
    button_lostletter() -- check_heal()���Ų����������
    locl.room = '�����'
    room.id = 'wudang/sanqing'
    quick_locate = 1
    if wudang_cs > 6 then
        wudang_cs = 0
        exe('score;ask song yuanqiao about ����')
    end
    if g_stop_flag == true then
        print("�����������Ϸ��ͣ")
        g_stop_flag = false
        return disAll()
    end
    return checkPrepare()
end
