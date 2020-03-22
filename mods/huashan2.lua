-------华山
HuaShanStats = {
    finishCount = 0,
    totalCount = 0,
    avgTime = 0,
    hs1CombatTime = 0,
    hs2CombatTime = 0,
    map = {
        sld = 0,
        caidi = 0,
        mr = 0,
        yzw = 0,
        mtl = 0
    }

}


function huashanFindAgain()
    EnableTriggerGroup("huashan_find", true)
    if flag.times == 3 and dest.area == '华山村' then
        return go(huashanFindAct, '华山村', '菜地')
    end
    if flag.times == 3 and dest.area == '襄阳城' and dest.room ==
        '山间空地' then
        return go(huashanFindAct, '襄阳郊外', '瀑布')
    end
    if flag.times == 2 and job.area == '明教' and
        (job.room == "紫杉林" or string.find(job.room, "字门")) then
        return go(huashanFindAct, '明教', '练武场')
    end
    if flag.times == 3 and job.area == '扬州城' and job.room == '南门' then
        return go(huashanFindAct, '扬州城', '长江南岸')
    end
    if flag.times == 3 and job.area == '兰州城' and job.room == '西城门' then
        return go(huashanFindAct, '兰州城', '永登')
    end

    if flag.times == 3 and job.area == '嵩山少林' and job.room ==
        "罗汉堂" then
        return go(huashanFindAct, '嵩山少林', '罗汉堂五部')
    end
    if flag.times == 3 and job.area == '嵩山少林' and job.room ==
        "般若堂" then
        return go(huashanFindAct, '嵩山少林', '般若堂五部')
    end
    return go(huashanFindAct, dest.area, dest.room)
end
function huashanFindFail() return go(huashan_shibai, '华山', '正气堂') end

function huashanFindAct()
    job.flag()
    exe('look')
    wipe_kill = 1
    find()
end

HuaShan={
    huashanArea1 = {
        ["菜地"] = "华山村",
        ["杂货铺"] = "华山村",
        ["民房"] = "华山村",
        ["酒肆"] = "华山村",
        ["铁匠铺"] = "华山村",
        ["东村口"] = "华山村",
        ["碎石路"] = "华山村",
        ["玄坛庙"] = "华山村",
        ["苍龙岭"] = "华山",
        ["侧廊"] = "华山",
        ["瀑布"] = "华山",
        ["朝阳峰"] = "华山",
        ["镇岳宫"] = "华山",
        ["猢狲愁"] = "华山",
        ["莎萝坪"] = "华山",
        ["千尺幢"] = "华山",
        ["百尺峡"] = "华山",
        ["青柯坪"] = "华山",
        ["舍身崖"] = "华山",
        ["松树林"] = "华山",
        ["玉女峰"] = "华山",
        ["玉泉院"] = "华山",
        ["思过崖"] = "华山",
        ["药房"] = "华山",
        ["后堂"] = "华山",
        ["山涧"] = "华山",
        ["小溪"] = "华山",
        ["祭坛"] = "华山",
        ["思过崖洞口"] = "华山",
        ["山路"] = "华山",
        ["石屋"] = "华山",
        ["树林"] = "华山",
        ["华山脚下"] = "华山",
        ["山洪瀑布"] = "华山",
        ["练武场"] = "华山",
        ["饭厅"] = "华山",
        ["书房"] = "华山",
        ["饭厅"] = "华山",
        ["剑房"] = "华山",
        ["前厅"] = "华山",
        ["台阶"] = "华山",
        ["正气堂"] = "华山",
        ["寝室"] = "华山",
        ["休息室"] = "华山",
        ["老君沟"] = "华山",
        ["小山路"] = "华山"
    },
    jobName = 'huashan',
    target = nil,
    startTime = nil,
}

function HuaShan:new()
    dis_all()
    local hs={}
    jobFindAgain = jobFindAgain or {}
    jobFindAgain["huashan"] = "huashanFindAgain"
    jobFindFail = jobFindFail or {}
    jobFindFail["huashan"] = "huashanFindFail"
    faintFunc = faintFunc or {}
    faintFunc["huashan"] = "huashanFindAgain"
    setmetatable(hs,huashan)
    return hs
end

function HuaShan:start()
    flag.idle = nil
    flag.times = 1
    wait.make(function()
        await_go('华山', '正气堂')
        wait_busy()
        local l,w
        dis_all()
        EnableTriggerGroup("huashan_accept", true)
        repeat
            exe('ask yue buqun about job')
            l, w = wait.regexp('^(> )*(你向岳不群打听|这里没有这个人)',1)
            if l and l:find("这里没有这个人") then
                await_go('华山', '正气堂')
            end
        until l and l:find("你向岳不群打听")
        self:jobDetails()
    end)
    
end

function HuaShan:jobDetails()
    wait.make(function()
        local l
        repeat
            l,_ =wait.regexp("^(> )*岳不群给了你一块令牌|^(> )*岳不群说道：「你不能光说呀，倒是做出点成绩给我看看！|^(> )*岳不群说道：「你现在正忙着做其他任务呢！|^(> )*岳不群说道：「现在没有听说有恶人为害百姓|^(> )*岳不群对你说道：你还是先去思过崖面壁思过去吧|",5)
        until l
        if l:find("岳不群给了你一块令牌") then
            self:findNpc()
            return
        elseif l:find("正忙着做") then
        elseif l:find("没有听说有恶人") then
        elseif l:find("你不能光说呀") then
            self:jobFail()
        elseif l:find("先去思过崖面壁") then

        end

    end)
end

function HuaShan:jobFail()
end

function HuaShan:findNpc()
    job.last = "huashan"
    if hsjob2 < 1 then
        HuaShanStats.totalCount = HuaShanStats.totalCount + 1
        messageShow('华山任务：开始任务。')
        return check_busy(huashan_npc_go)
    else
        -- locate_finish = 'huashan_npc_go2'
        return check_busy(huashan_npc_go2)
    end
end

