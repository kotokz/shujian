-----------�Զ�ץѩ��by�һ����޷���2019.3.16----------
function check_xuezhu_status()
    local xuezhu_status = GetVariable("xuezhu_status")
    if xuezhu_status == nil then
        messageShow(
            'δ�ҵ�ѩ�������xuezhu_status���뾡�����ã���δץ��ѩ��������-1������ץ��������0',
            'white', 'black')
    else
        xuezhu_status = tonumber(xuezhu_status)
        if xuezhu_status < 2 then
            flag.xuezhu = false
        else
            flag.xuezhu = true
        end
    end

    return xuezhu_status
end
function xuezhuTrigger()
    DeleteTriggerGroup("xuezhuAsk")
    create_trigger_t('xuezhuAsk1',
                     "^(> )*��������ش����йء��嶾�̡�����Ϣ",
                     '', 'xuezhuAsk')
    create_trigger_t('xuezhuAsk2', "^(> )*����û������ˡ�$", '',
                     'xuezhuNobody')
    SetTriggerOption("xuezhuAsk1", "group", "xuezhuAsk")
    SetTriggerOption("xuezhuAsk2", "group", "xuezhuAsk")
    EnableTriggerGroup("xuezhuAsk", false)
    DeleteTriggerGroup("xuezhuAccept")
    create_trigger_t('xuezhuAccept1',
                     "^(> )*������˵�������嶾�̵Ľ��������˸����滨��ݣ����д󲿷־��о޶�\\D*",
                     '', 'xuezhuAccept')
    create_trigger_t('xuezhuAccept2',
                     "^(> )*����һ�ž�ѩ���Ƶ���$", '', 'eatDan')
    create_trigger_t('xuezhuAccept3',
                     "^(> )*���һ�ž�ѩ���Ƶ�������ҧ�麬������پ��������ʣ���ɫ����$",
                     '', 'realDan')
    create_trigger_t('xuezhuAccept4',
                     "^(> )*������˵���������ϴδ�Ӧ�ҵ����黹û��\\D*",
                     '', 'fakeDan')
    SetTriggerOption("xuezhuAccept1", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept2", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept3", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept4", "group", "xuezhuAccept")
    EnableTriggerGroup("xuezhuAccept", false)
    DeleteTriggerGroup("xuezhuFight")
    create_trigger_t('xuezhuFight1',
                     '^(> )*��ζ��˰��죬����ʲ��Ҳû�С�', '',
                     'xuezhuFail')
    create_trigger_t('xuezhuFight2',
                     '^(> )*������ҡ�����٣���Ȼ����һֻѩ�롣',
                     '', 'xuezhuFight')
    create_trigger_t('xuezhuFight3',
                     "^(> )*ѩ����־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��",
                     '', 'getxuezhu')
    create_trigger_t('xuezhuFight4',
                     "^(> )*�㽫ѩ������������ڱ��ϡ�", '',
                     'givecheng')
    create_trigger_t('xuezhuFight5',
                     "^(> )*ѩ�롸ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�",
                     '', 'xuezhuFail')
    create_trigger_t('xuezhuFight6',
                     "^(> )*(�㸽��û������������|ѩ��ͻȻ�ڵ����ϲ����ˡ�)",
                     '', 'xuezhuFail')
    -- create_trigger_t('xuezhuFight6',"^(> )*ѩ��ͻȻ�ڵ����ϲ����ˡ�",'','xuezhuFail')
    SetTriggerOption("xuezhuFight1", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight2", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight3", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight4", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight5", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight6", "group", "xuezhuFight")
    EnableTriggerGroup("xuezhuFight", false)
    DeleteTriggerGroup("xuezhuFinish")
    create_trigger_t('xuezhuFinish1',
                     '^(> )*������˵���������Ȼ�Զ����ţ��´���Ҫ��ȥ�嶾�������Ұɡ���',
                     '', 'xuezhuFinish')
    SetTriggerOption("xuezhuFinish1", "group", "xuezhuFinish")
    EnableTriggerGroup("xuezhuFinish", false)
end
function xuezhuTriDel()
    dis_all()
    DeleteTriggerGroup("xuezhuAsk")
    DeleteTriggerGroup("xuezhuAccept")
    DeleteTriggerGroup("xuezhuFight")
    DeleteTriggerGroup("xuezhuFinish")
end
function xuezhuGetDan()
    xuezhuTrigger()
    if inwdj == 0 then
        messageShow(
            'ץѩ�룺�置��ͼ���ɵ�������ʳ�����Ҫ����',
            "Plum")
        -- SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepareOver)
    end
    go(askcheng, '�置', 'ҩ����')
end
function xuezhuGoCatch()
    xuezhuTrigger()
    xuezhu_go()
end
function askcheng()
    EnableTriggerGroup("xuezhuAsk", true)
    EnableTriggerGroup("xuezhuAccept", true)
    exe('ask cheng about �嶾��')
    create_timer_s('walkWait4', 3.0, 'askcheng1')
end
function askcheng1() exe('ask cheng about �嶾��') end
function xuezhuAsk()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuezhuAsk", false)
end
function xuezhuAccept()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    wait.make(function()
        wait.time(2)
        exe('yes')
    end)
    SetVariable("xuezhu_status", "1")
end
function eatDan()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    exe('fu dan')
    create_timer_s('walkWait4', 1.0, 'eatDan1')
end
function eatDan1() exe('fu dan') end
function fakeDan()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    SetVariable("xuezhu_status", "-1")
    messageShow(
        '�����ظ��˼ٵ���С���ˣ�ŭ���������������ȥץѩ�룡',
        'white', 'black')
    -- return xuezhu_go()
    return check_halt(checkPrepareOver)
end

function realDan()
    messageShow('���ʳ�����Ҫ���浤�����������ȥץѩ�룡',
                'white', 'black')
    return check_halt(checkPrepareOver)
end

function xuezhu_go()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    if not Bag["����"] and drugPrepare["����"] then
        if locl.weekday == '��' and locl.hour == 8 then
            return check_xuexi()
        else
            return checkFire()
        end
    end
    if inwdj == 0 then
        EnableTriggerGroup("xuezhuAccept", false)
        messageShow('ץѩ�룺�置ɽ�����ɵ�����������',
                    "Plum")
        -- SetVariable("xuezhu_status", "2")
        return check_halt(check_xuexi)
    end
    EnableTriggerGroup("xuezhuAccept", false)
    go(yaoshuteng, '�置', 'ɽ��')
end
function yaoshuteng()
    EnableTriggerGroup("xuezhuFight", true)
    exe('fang dfly;dian fire;yao shuteng')
    create_timer_st('walkWait4', 3.0, 'yaoshuteng1')
end
function yaoshuteng1() exe('fang dfly;dian fire;yao shuteng') end
function xuezhuFail()
    xuezhuTriDel()
    messageShow('ѩ�벻�ڣ�һ������ץ��', 'white', 'black')
    return check_xuexi()
end
--[[function xuezhuFail1()
	xuezhuTriDel()
	messageShow('ѩ�뱻������ˣ���鿴log��','white','black')
	scrLog()
	return checkPrepareOver()
end
function xuezhuFail2()
	xuezhuTriDel()
	messageShow('ѩ���Լ����˻���ץ���ˣ���鿴log��','white','black')
	scrLog()
	return checkPrepareOver()
end]]
function xuezhuFight()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    wait.make(function()
        wait.time(3)
        weapon_unwield()
        exe('unset wimpy;jiali 100;hit xue zhu')
    end)
end
function getxuezhu() exe('get xue zhu') end
function givecheng()
    EnableTriggerGroup("xuezhuFinish", true)
    go(givexuezhu, '�置', 'ҩ����')
end
function givexuezhu()
    exe('give cheng xue zhu')
    create_timer_st('walkWait4', 1.0, 'givexuezhu1')
end
function givexuezhu1() exe('give cheng xue zhu') end
function xuezhuFinish()
    local x = GetVariable("xuezhu_status")
    if x == '-1' then
        SetVariable("xuezhu_status", "0")
        flag.xuezhu = false
    end
    if x == '1' then
        SetVariable("xuezhu_status", "2")
        flag.xuezhu = true
        messageShow('�����ѳɹ�ץ��ѩ�룬�밲����Ϸ����)',
                    'red', 'black')
    end
    xuezhuTriDel()
    return checkPrepareOver()
end
-----------�Զ�ץѩ��by�һ����޷���2019.3.16----------
function reboot_before_cun()
    flag.cun = true
    wait.make(function()
        wait.time(3)
        cun_shengzi()
    end)
end
function cun_shengzi()
    exe('cun sheng zi')
    return check_busy(cun_shengzi1, 3)
end
function cun_shengzi1()
    exe('cun cu shengzi')
    return check_busy(cun_fire, 3)
end
function cun_fire()
    exe('cun fire')
    return check_busy(cun_save, 3)
end
function cun_save()
    exe('save;n;n;n')
    return prepare_lianxi()
end
