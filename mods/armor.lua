-- by fqyy 2018-6-4
fqyytmp = {}
fqyytmp.attValue = {
    ['伤害力'] = 10,
    ['防御力'] = 6,
    ['悟性'] = 500,
    ['力量'] = 500,
    ['身法'] = 500,
    ['根骨'] = 500,
    ['招架率'] = 37,
    ['躲避率'] = 40,
    ['命中率'] = 40,
    ['致命率'] = 100,
    ['气血'] = 1,
    ['幸运'] = 500,
    ['速度'] = 500
}
fqyytmp.armorClass = {
    ['手套'] = 'glove',
    ['甲胄'] = 'armor',
    ['靴'] = 'boot',
    ['腰带'] = 'belt',
    ['披风'] = 'mantle',
    ['彩衣'] = 'coat',
    ['头盔'] = 'cap'
}
fqyytmp.goArmorD = 0
fqyytmp.goCunArmor = 0
fqyytmp.tmpArmorName = nil
fqyytmp.tmpArmorClass = nil
------------------------
function fqyyArmorCheckValue(msg)
    local tmpitem = 0
    local tmptotal = 0
    for v in pairs(fqyytmp.attValue) do
        _, _, tmpitem = string.find(msg, v .. "＋(%d+)")
        if tmpitem ~= nil then
            --			print(v..":"..tmpitem)
            tmptotal = tmptotal + tmpitem * fqyytmp.attValue[v]
        end
    end
    print(tmptotal)
    if tmptotal > 500 or tmptotal == 0 then
        fqyytmp.goCunArmor = 1
    else
        fqyytmp.goCunArmor = 0
    end
    -- 防御力＋22】
    -- 伤害力＋510，悟性＋3，身法＋3，根骨＋6，力量＋5
end
function fqyyArmorGoCheck()
    fqyytmp.goArmorD = 0
    if Bag[fqyytmp.tmpArmorName] then
        create_trigger_t('fqyyWeaponLog1',
                         '^(> )*D\\*已经被绑定，请先使用uweapon unlock命令解除绑定。',
                         '', 'fqyyArmorGoOver')
        create_trigger_t('fqyyWeaponLog3',
                         '^(> )*(你只能拆解你自己的防具。|\\D*不可以被保存。)',
                         '', 'fqyyArmorDrop')
        create_trigger_t('fqyyWeaponLog4',
                         '^(> )*(\\D*)被拆解为一堆(\\D*)落在桌上,被你拣起收进背囊。',
                         '', 'fqyyArmorDisShow')
        create_trigger_t('fqyyWeaponLog5',
                         '^(> )*你丢下一(件|副|双|袭|顶|个|条|对)(\\D*)(手套|靴|甲胄|腰带|披风|彩衣|头盔)。',
                         '', 'fqyyArmorDropShow')
        SetTriggerOption("fqyyWeaponLog1", "group", "fqyylog")
        SetTriggerOption("fqyyWeaponLog3", "group", "fqyylog")
        SetTriggerOption("fqyyWeaponLog4", "group", "fqyylog")
        SetTriggerOption("fqyyWeaponLog5", "group", "fqyylog")
        if fqyytmp.goCunArmor == 1 then
            fqyytmp.goCunArmor = 0
            fqyyArmorSave()
        else
            fqyyArmorDis()
        end
    else
        check_jobx()
    end
end
function fqyyArmorSave()
    if not Bag[fqyytmp.tmpArmorName] then return check_jobx() end
    go(fqyyArmorSave2, 'city/zahuopu')
end
function fqyyArmorSave2()
    if Bag[fqyytmp.tmpArmorName] then
        exe('remove all;cun ' .. Bag[fqyytmp.tmpArmorName].fullid)
        checkBags()
        return check_busy(fqyyArmorSave2, 1)
    end
    fqyyArmorMessage('保存了' .. fqyytmp.tmpArmorName)
    return fqyyArmorGoOver()
end
function fqyyArmorDis()
    if not Bag[fqyytmp.tmpArmorName] then return check_jobx() end
    go(fqyyArmorDis2, 'zhiye/caifengpu1')
end
function fqyyArmorDis2()
    if Bag[fqyytmp.tmpArmorName] then
        exe('remove all;dismantle ' .. Bag[fqyytmp.tmpArmorName].fullid)
        exe('y')
        exe('alias dofqyydrop drop ' .. Bag[fqyytmp.tmpArmorName].fullid)
        create_timer_st('walkWait4', 3.0, 'fqyyArmorDis3')
    else
        checkWait(fqyyArmorGoOver, 1)
    end
end
function fqyyArmorDis3()
    exe('remove all;dismantle ' .. Bag[fqyytmp.tmpArmorName].fullid)
    exe('y')
    exe('alias dofqyydrop drop ' .. Bag[fqyytmp.tmpArmorName].fullid)
end
function fqyyArmorDisShow(n, l, w)
    DeleteTimer("walkWait4")
    fqyyArmorMessage('分解了[' .. w[2] .. ']获得材料：' .. w[3])
    checkBags()
    return check_busy(fqyyArmorDis2, 1)
end
function fqyyArmorDrop()
    DeleteTimer("walkWait4")
    exe('dofqyydrop')
end
function fqyyArmorDropShow(n, l, w)
    local tmpw3 = w[3] or ""
    fqyyArmorMessage('丢弃了' .. tmpw3 .. w[4])
end
function fqyyArmorGoOver()
    DeleteTimer("walkWait4")
    fqyytmp.tmpArmorName = nil
    DeleteTriggerGroup("fqyylog")
    exe('wear all')
    check_jobx()
end
------------------------
function fqyyArmorCheck(n, l, w)
    print(w[3] .. "|" .. w[4])
    local tmpw3 = w[3] or ""
    fqyyArmorMessage("拾取" .. tmpw3 .. w[4])
    fqyytmp.tmpArmorName = tmpw3 .. w[4]
    -- fqyytmp.tmpArmorClass=w[4]
    exe("l " .. fqyytmp.armorClass[w[4]])
    DeleteTimer('fqyyArmorGetT')
    fqyytmp.goArmorD = 1
    checkBags()
end
function fqyyArmorGet(n, l, w)
    print(w[2] .. "|" .. w[3] .. "|" .. w[4])
    local tmpw4 = w[3] or ""

    if job.name ~= nil then
        messageShow(job.name .. '中获得' .. tmpw4 .. w[4] .. '。',
                    '#DC143C', '#EEEEEE')
    else
        messageShow('莫名其妙获得' .. tmpw4 .. w[4] .. '。', '#DC143C',
                    '#EEEEEE')
    end
    fqyytmp.tmpArmorClass = w[4]
    create_trigger_t('fqyyWeaponLog', '^(> )*它的功能有：【(\\N*)】$',
                     '', 'checkItemByfqyyA')
    create_trigger_t('fqyyWeaponLog2', '^(> )*它的功能有：【(\\N*)%】$',
                     '', 'checkItemByfqyyA')
    SetTriggerOption("fqyyWeaponLog", "group", "fqyylog")
    SetTriggerOption("fqyyWeaponLog2", "group", "fqyylog")
    fqyyArmorGetT()
    create_timer_s('fqyyArmorGetT', 0.2, 'fqyyArmorGetT')
end
function fqyyArmorGetT() exe('get ' .. fqyytmp.armorClass[fqyytmp.tmpArmorClass]) end

function checkItemByfqyyW(n, l, w)
    messageShow("武器属性：" .. w[2])
    DeleteTriggerGroup("fqyylog")
end
function checkItemByfqyyA(n, l, w)
    messageShow("装备属性：" .. w[2])
    fqyyArmorCheckValue(w[2])
    DeleteTriggerGroup("fqyylog")
end
function fqyyRepairMessage(msg)
    if msg ~= nil then messageShow(msg, '#FF1493', '#004444') end
end
function fqyyArmorMessage(msg)
    if msg ~= nil then messageShow(msg, '#1E90FF', '#FFFFFF') end
end

DaZao = {
    dazaoID = "",
    currnetCount = 0,
    totalCount = 0,
    expectValue = 2,
    mainThread = nil,
    findThread = nil,
    autoDis = false,
    jobName = 'dazaoArmor',
    result = {}
}

function DaZao:new()
    local o = {}
    local l_result
    l_result=utils.inputbox("你需要打造的护具ID是", "dazaoID", "", "宋体" , "12")
    if not isNil(l_result) then
        o.dazaoID = l_result
    end

    l_result=utils.inputbox ("你需要打造的次数", "dazaoTimes", 10, "宋体" , "12")
    if not isNil(l_result) then
        o.totalCount = tonumber(l_result)
    end

    l_result=utils.inputbox ("你需要保存的属性值（例如：2就是属性>=2的保存）。", "dazaoValue", 2, "宋体" , "12")
    if not isNil(l_result) then
        o.expectValue = tonumber(l_result)
    end

    l_result = utils.msgbox("是否自动分解不需要保存的装备", "dazaoDis",
        "yesno", "?", 1)
    if l_result and l_result == "yes" then
        o.autoDis = true
    else
        o.autoDis = false
    end
    setmetatable(o, {__index = DaZao})
    return o
end

function DaZao:start()
    wait.make(function()
        job.name=self.jobName
        DeleteTimer('idle')
        self.mainThread = coroutine.running()
        self:checkJianDao(self.mainThread)
        coroutine.yield()

        print("买到剪刀")
        weapon_unwield()
        exe('wield jian dao')
        -- now we have all we want, go crafting
        await_go('zhiye/caifengpu1')
        self:dazaoArmor()   
    end)
end

function DaZao:checkJianDao(thread)
    wait.make(function()
        checkBags()  -- we should enhance this to be await like func
        wait_busy()
        while not Bag["剪刀"] do
            await_go("扬州城","杂货铺")
            local line, w
            repeat
                exe('qu jian dao')
                line, w = wait.regexp(
                                 '^(> )*(你把剪刀|你并没有保存)',1)
            until line
            if line:find('你并没有保存') then
                self:buyJianDao(coroutine.running())
                coroutine.yield()
            end
            checkBags()  -- we should enhance this to be await like func
            wait_busy()
        end
        coroutine.resume(thread)
    end)
end
function DaZao:dazaoArmor()
    wait.make(function()
        local dazaoThread = coroutine.running()
        while self.currnetCount < self.totalCount or g_stop_flag do
            print('本次打造第'..self.currnetCount..'次，预计打造'..self.totalCount..'次。')
            exe('weave '..self.dazaoID)
            local line,w = wait.regexp(
                '(> )*你很得意的拿起刚织造好的(\\D*)左|(> )*对于这种防具，您了解不多，还不会织造|(> )*你必须装备剪刀才能来织造')
            if line and line:find("还不会织造") then
                print("打造失败！")
                break
            elseif line and line:find('你必须装备剪刀') then
                self:checkJianDao(dazaoThread)
                coroutine.yield()
                await_go('zhiye/caifengpu1')
            else
                self.armorName = w[2]
                print("打造成功!".. self.armorName)
                
                self.currnetCount = self.currnetCount + 1
                self:checkProduct(dazaoThread)
                local status = coroutine.yield()
                if status == "abort" then
                    break
                end
            end
        end
        if g_stop_flag then
            print("停止打造")            
        else
            print("全部打造完毕，一共打造了"..self.currnetCount..'次')
        end
        return
    end)
end

function DaZao:checkProduct(thread)
    wait.make(function()
        local line,w 
        repeat            
            exe('look '..self.dazaoID)
            line,w = wait.regexp(
                '^(> )*它的功能有：【(\\N*)】',1)
        until line
        local value = w[2]
        local wanttedAtr="身法根骨悟性力量"
        local keep =false
        for c,v in value:gmatch('(['..wanttedAtr..']+)＋(%d+)') do
            if wanttedAtr:find(c) then
                print(c,v)
                local number = tonumber(v)
                if number >= 5 then
                    print("发现神器！！！")
                    messageShow('出神器了，本次打造终止！','red','black')
                    keep = true
                    coroutine.resume(thread,"abort")
                elseif number >= self.expectValue then
                    print("可以保存")
                    fqyyArmorMessage('装备属性：'..value)
                    keep = true
                end
            end
        end
        if keep then
            return self:cunArmor(thread)
        elseif self.autoDis then
            exe('dismantle '..self.dazaoID..';y')
        else 
            print("不符合条件，但是不自动分解")
        end
        wait_busy()
        coroutine.resume(thread)
    end)
end

function DaZao:cunArmor(thread)
    wait.make(function()
        await_go('city/zahuopu')
        exe('cun '..self.dazaoID)
        checkBags()
        wait_busy()
        await_go('zhiye/caifengpu1')
        coroutine.resume(thread)
    end)
end

function DaZao:buyJianDao(thread)
    wait.make(function()
        await_go("changan/northjie2")
        wait.time(2)
        exe('look')
        flag.times = 1
        self.findThread = coroutine.running()
        jobFindAgain[self.jobName] = function (...)
            coroutine.resume(self.findThread)
        end
        find()
        local status = coroutine.yield()
        if status then
            return
        else
            print('找不到婆婆')
        end
    end)
    wait.make(function() 
        while true do
            local line,_ = wait.regexp(
                '^(> )*\\s*(养蚕婆婆\\(Yangcan popo\\)|这里没有 yangcan popo|你决定跟随养蚕婆婆|你.*从养蚕婆婆那里买下了一把剪刀|老裁缝说道：「你想买的东西我这里没有)')
            if line and line:find('Yangcan popo') then
                flag.wait = 1
                exe('follow yangcan popo')
            elseif line and line:find('这里没有') then
                flag.wait = 0
                walk_wait()
            elseif line and line:find('你决定跟随') then
                flag.find = 1
                exe('buy jian dao')
            elseif line and line:find('没有') then
                exe('follow yangcan popo')
                exe('buy jian dao')
            elseif line and line:find('一把剪刀') then
                exe('follow none')
                break
            end
        end        
        coroutine.resume(thread)
    end)
    
end


function dazaoArmor()
    local dz = DaZao.new()
    tprint(dz)
    dz:start()
end