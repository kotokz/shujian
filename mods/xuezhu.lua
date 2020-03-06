-----------自动抓雪蛛by桃花岛无法风2019.3.16----------
function check_xuezhu_status()
    local xuezhu_status = GetVariable("xuezhu_status")
    if xuezhu_status == nil then
        messageShow(
            '未找到雪蛛变量：xuezhu_status，请尽快设置！',
            'white', 'black')
    elseif xuezhu_status == "0" then
        messageShow(
            '本周还未抓到雪蛛，启动自动抓雪蛛机器人，前往抓雪蛛！',
            'white', 'black')
        return xuezhu_status
    elseif xuezhu_status == "1" then
        messageShow('已问程灵素要了真丹，现在前往抓雪蛛！',
                    'white', 'black')
        return xuezhu_status
    elseif xuezhu_status == "-1" then
        messageShow(
            '程灵素给了假丹，小贱人！怒！！！现在前往抓雪蛛！',
            'white', 'black')
        return xuezhu_status
    end
end
function xuezhuTrigger()
    DeleteTriggerGroup("xuezhuAsk")
    create_trigger_t('xuezhuAsk1',
                     "^(> )*你向程灵素打听有关『五毒教』的消息",
                     '', 'xuezhuAsk')
    create_trigger_t('xuezhuAsk2', "^(> )*这里没有这个人。$", '',
                     'xuezhuNobody')
    SetTriggerOption("xuezhuAsk1", "group", "xuezhuAsk")
    SetTriggerOption("xuezhuAsk2", "group", "xuezhuAsk")
    EnableTriggerGroup("xuezhuAsk", false)
    DeleteTriggerGroup("xuezhuAccept")
    create_trigger_t('xuezhuAccept1',
                     "^(> )*程灵素说道：「五毒教的禁地种满了各种奇花异草，其中大部分具有巨毒\\D*",
                     '', 'xuezhuAccept')
    create_trigger_t('xuezhuAccept2',
                     "^(> )*你获得一颗九雪碧云丹。$", '', 'eatDan')
    create_trigger_t('xuezhuAccept3',
                     "^(> )*你把一颗九雪碧云丹，轻轻咬碎含进嘴里，顿觉神明意朗，脸色红润。$",
                     '', 'xuezhu_go')
    create_trigger_t('xuezhuAccept4',
                     "^(> )*程灵素说道：「你上次答应我的事情还没做\\D*",
                     '', 'fakeDan')
    SetTriggerOption("xuezhuAccept1", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept2", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept3", "group", "xuezhuAccept")
    SetTriggerOption("xuezhuAccept4", "group", "xuezhuAccept")
    EnableTriggerGroup("xuezhuAccept", false)
    DeleteTriggerGroup("xuezhuFight")
    create_trigger_t('xuezhuFight1',
                     '^(> )*你晃动了半天，发现什麽也没有。', '',
                     'xuezhuFail')
    create_trigger_t('xuezhuFight2',
                     '^(> )*你轻轻摇晃树藤，忽然掉下一只雪蛛。',
                     '', 'xuezhuFight')
    create_trigger_t('xuezhuFight3',
                     "^(> )*雪蛛神志迷糊，脚下一个不稳，倒在地上昏了过去。",
                     '', 'getxuezhu')
    create_trigger_t('xuezhuFight4',
                     "^(> )*你将雪蛛扶了起来背在背上。", '',
                     'givecheng')
    create_trigger_t('xuezhuFight5',
                     "^(> )*雪蛛「啪」的一声倒在地上，挣扎着抽动了几下就死了。",
                     '', 'xuezhuFail')
    create_trigger_t('xuezhuFight6',
                     "^(> )*(你附近没有这样东西。|雪蛛突然蹿到地上不见了。)",
                     '', 'xuezhuFail')
    -- create_trigger_t('xuezhuFight6',"^(> )*雪蛛突然蹿到地上不见了。",'','xuezhuFail')
    SetTriggerOption("xuezhuFight1", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight2", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight3", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight4", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight5", "group", "xuezhuFight")
    SetTriggerOption("xuezhuFight6", "group", "xuezhuFight")
    EnableTriggerGroup("xuezhuFight", false)
    DeleteTriggerGroup("xuezhuFinish")
    create_trigger_t('xuezhuFinish1',
                     '^(> )*程灵素说道：「你果然言而有信，下次你要再去五毒教来找我吧。」',
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
function getxuezhu0()
    xuezhuTrigger()
    if inwdj == 0 then
        messageShow('抓雪蛛：苗疆地图不可到达，任务放弃。',
                    "Plum")
        -- SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepare)
    end
    go(askcheng, '苗疆', '药王居')
end
function getxuezhu1()
    xuezhuTrigger()
    xuezhu_go()
end
function askcheng()
    EnableTriggerGroup("xuezhuAsk", true)
    EnableTriggerGroup("xuezhuAccept", true)
    exe('ask cheng about 五毒教')
    create_timer_s('walkWait4', 3.0, 'askcheng1')
end
function askcheng1() exe('ask cheng about 五毒教') end
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
    return xuezhu_go()
end
function xuezhu_go()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    if not Bag["火折"] and drugPrepare["火折"] then
        if locl.weekday == '四' and locl.hour == 8 then
            return checkPrepareOver()
        else
            return checkFire()
        end
    end
    if inwdj == 0 then
        messageShow('抓雪蛛：苗疆山洞不可到达，任务放弃。',
                    "Plum")
        -- SetVariable("xuezhu_status", "2")
        return check_halt(checkPrepare)
    end
    EnableTriggerGroup("xuezhuAccept", false)
    go(yaoshuteng, '苗疆', '山洞')
end
function yaoshuteng()
    EnableTriggerGroup("xuezhuFight", true)
    exe('fang dfly;dian fire;yao shuteng')
    create_timer_st('walkWait4', 3.0, 'yaoshuteng1')
end
function yaoshuteng1() exe('fang dfly;dian fire;yao shuteng') end
function xuezhuFail()
    xuezhuTriDel()
    messageShow('雪蛛不在，一会再来抓！', 'white', 'black')
    return checkPrepareOver()
end
--[[function xuezhuFail1()
	xuezhuTriDel()
	messageShow('雪蛛被你打死了，请查看log！','white','black')
	scrLog()
	return checkPrepareOver()
end
function xuezhuFail2()
	xuezhuTriDel()
	messageShow('雪蛛自己跑了或被人抓走了，请查看log！','white','black')
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
    go(givexuezhu, '苗疆', '药王居')
end
function givexuezhu()
    exe('give cheng xue zhu')
    create_timer_st('walkWait4', 1.0, 'givexuezhu1')
end
function givexuezhu1() exe('give cheng xue zhu') end
function xuezhuFinish()
    local x = GetVariable("xuezhu_status")
    if x == '-1' then SetVariable("xuezhu_status", "0") end
    if x == '1' then
        SetVariable("xuezhu_status", "2")
        messageShow('本周已成功抓到雪蛛，请安心游戏！：)',
                    'red', 'black')
    end
    xuezhuTriDel()
    return checkPrepareOver()
end
-----------自动抓雪蛛by桃花岛无法风2019.3.16----------
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
