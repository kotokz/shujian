-- by fqyy 2018-6-4
fqyytmp = {}
fqyytmp.attValue = {
    ['�˺���'] = 10,
    ['������'] = 6,
    ['����'] = 500,
    ['����'] = 500,
    ['��'] = 500,
    ['����'] = 500,
    ['�м���'] = 37,
    ['�����'] = 40,
    ['������'] = 40,
    ['������'] = 100,
    ['��Ѫ'] = 1,
    ['����'] = 500,
    ['�ٶ�'] = 500
}
fqyytmp.armorClass = {
    ['����'] = 'glove',
    ['����'] = 'armor',
    ['ѥ'] = 'boot',
    ['����'] = 'belt',
    ['����'] = 'mantle',
    ['����'] = 'coat',
    ['ͷ��'] = 'cap'
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
        _, _, tmpitem = string.find(msg, v .. "��(%d+)")
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
    -- ��������22��
    -- �˺�����510�����ԣ�3������3�����ǣ�6��������5
end
function fqyyArmorGoCheck()
    fqyytmp.goArmorD = 0
    if Bag[fqyytmp.tmpArmorName] then
        create_trigger_t('fqyyWeaponLog1',
                         '^(> )*D\\*�Ѿ����󶨣�����ʹ��uweapon unlock�������󶨡�',
                         '', 'fqyyArmorGoOver')
        create_trigger_t('fqyyWeaponLog3',
                         '^(> )*(��ֻ�ܲ�����Լ��ķ��ߡ�|\\D*�����Ա����档)',
                         '', 'fqyyArmorDrop')
        create_trigger_t('fqyyWeaponLog4',
                         '^(> )*(\\D*)�����Ϊһ��(\\D*)��������,��������ս����ҡ�',
                         '', 'fqyyArmorDisShow')
        create_trigger_t('fqyyWeaponLog5',
                         '^(> )*�㶪��һ(��|��|˫|Ϯ|��|��|��|��)(\\D*)(����|ѥ|����|����|����|����|ͷ��)��',
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
    fqyyArmorMessage('������' .. fqyytmp.tmpArmorName)
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
    fqyyArmorMessage('�ֽ���[' .. w[2] .. ']��ò��ϣ�' .. w[3])
    checkBags()
    return check_busy(fqyyArmorDis2, 1)
end
function fqyyArmorDrop()
    DeleteTimer("walkWait4")
    exe('dofqyydrop')
end
function fqyyArmorDropShow(n, l, w)
    local tmpw3 = w[3] or ""
    fqyyArmorMessage('������' .. tmpw3 .. w[4])
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
    fqyyArmorMessage("ʰȡ" .. tmpw3 .. w[4])
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
        messageShow(job.name .. '�л��' .. tmpw4 .. w[4] .. '��',
                    '#DC143C', '#EEEEEE')
    else
        messageShow('Ī��������' .. tmpw4 .. w[4] .. '��', '#DC143C',
                    '#EEEEEE')
    end
    fqyytmp.tmpArmorClass = w[4]
    create_trigger_t('fqyyWeaponLog', '^(> )*���Ĺ����У���(\\N*)��$',
                     '', 'checkItemByfqyyA')
    create_trigger_t('fqyyWeaponLog2', '^(> )*���Ĺ����У���(\\N*)%��$',
                     '', 'checkItemByfqyyA')
    SetTriggerOption("fqyyWeaponLog", "group", "fqyylog")
    SetTriggerOption("fqyyWeaponLog2", "group", "fqyylog")
    fqyyArmorGetT()
    create_timer_s('fqyyArmorGetT', 0.2, 'fqyyArmorGetT')
end
function fqyyArmorGetT() exe('get ' .. fqyytmp.armorClass[fqyytmp.tmpArmorClass]) end

function checkItemByfqyyW(n, l, w)
    messageShow("�������ԣ�" .. w[2])
    DeleteTriggerGroup("fqyylog")
end
function checkItemByfqyyA(n, l, w)
    messageShow("װ�����ԣ�" .. w[2])
    fqyyArmorCheckValue(w[2])
    DeleteTriggerGroup("fqyylog")
end
function fqyyRepairMessage(msg)
    if msg ~= nil then messageShow(msg, '#FF1493', '#004444') end
end
function fqyyArmorMessage(msg)
    if msg ~= nil then messageShow(msg, '#1E90FF', '#FFFFFF') end
end

Armor = {
    dazaoID = "",
    currnetCount = 0,
    totalCount = 0,
    expectValue = 2,
    mainThread = nil,
    findThread = nil,
    autoDis = false,
    maxFindTimes = 4,
    armorType = {
        ['����'] = 'glove',
        ['����'] = 'armor',
        ['ѥ'] = 'boot',
        ['����'] = 'belt',
        ['����'] = 'mantle',
        ['����'] = 'coat',
        ['ͷ��'] = 'cap'},
    armorKind = {
        ["armor"] = true,
        ["coat"] = true,
        ["mantle"] = true,
        ["cap"] = true,
        ["glove"] = true,
        ["boot"] = true
    },
    cannotRepair = {},
    jobName = 'armor',
    repairList = {}
}

function Armor:new()
    local o = {}
    job.name = Armor.jobName
    setmetatable(o, {__index = Armor})
    return o
end


function Armor:checkDamage()
    -- currently the check damage already done in weapon check, we just go thru the list to get armor 
    wait.make(function()
        local repairRequired = false
        for p in pairs(weaponUsave) do
            if Bag[p] and Bag[p].kind and self.armorKind[Bag[p].kind] and
                not self.cannotRepair[p] then
                local l, w
                repeat
                    exe('l ' .. Bag[p].fullid)
                    l, w = wait.regexp(
                               '^(> )*������(��Ҫ����|�Ѿ�ʹ�ù�һ��ʱ��|���Ͼ�Ҫ��|û��ʲô��)',
                               1)
                until l
                if not string.find(l, 'û��ʲô��') then                    
                    table.insert(self.repairList,Bag[p].fullid)
                    repairRequired = true
                end
            end
        end
        if repairRequired then
            tprint(self.repairList)
            self:goRepair()
        else 
            self:repairDone()
        end
    end)
end

function Armor:repairDone()
    print("ά�޽�������������")
    return check_halt(check_jobx)
end

function Armor:goRepair()
    wait.make(function() 
        dis_all()
        checkWield()
        local thread = coroutine.running()
        local status = self:checkJianDao(thread)
        coroutine.yield()
        if status and status == 'break' then
            return self:cunJianDao()
        end
        await_go("������", "�÷���")
        for _,item in ipairs(self.repairList) do
            local l
            while true do
                exe('repair ' .. item)
                l,_ = wait.regexp('^(> )*�㿪ʼ��ϸ���޲�|����ϸ���޲�|��������������|�������ַ��ߣ����˽ⲻ��|�������Ǯ������|�����ھ���״̬����|�����װ������',2)
                if l == nil then
                    print("��������")
                elseif l:find("�������Ǯ������") then
                    wait.time(0.5)
                    exe('e;#3s;w;qu 400 gold;e;#3n;w')
                elseif l:find('����') then
                    self:checkJianDao(thread)
                    coroutine.yield()                    
                    await_go("������", "�÷���")           
                else
                    break
                end
            end
            wait_busy()      
        end
        --  might need add fail repair hanlding, but not important now.
        self:cunJianDao(thread)
        coroutine.yield()
        self:repairDone()
    end)
end

function Armor:dzStart()
    local l_result
    l_result=utils.inputbox("����Ҫ����Ļ���ID��", "dazaoID", "", "����" , "12")
    if not isNil(l_result) then
        self.dazaoID = l_result
    end

    l_result=utils.inputbox ("����Ҫ����Ĵ���", "dazaoTimes", 10, "����" , "12")
    if not isNil(l_result) then
        self.totalCount = tonumber(l_result)
    end

    l_result=utils.inputbox ("����Ҫ���������ֵ�����磺2��������>=2�ı��棩��", "dazaoValue", 2, "����" , "12")
    if not isNil(l_result) then
        self.expectValue = tonumber(l_result)
    end

    l_result = utils.msgbox("�Ƿ��Զ��ֽⲻ��Ҫ�����װ��", "dazaoDis",
        "yesno", "?", 1)
    if l_result and l_result == "yes" then
        self.autoDis = true
    else
        self.autoDis = false
    end
    wait.make(function()
        job.name=self.jobName
        DeleteTimer('idle')
        local thread = coroutine.running()
        local status = self:checkJianDao(thread)
        coroutine.yield()
        if status and status == 'break' then
            return self:cunJianDao()
        end

        -- now we have all we want, go crafting
        await_go('zhiye/caifengpu1')
        self:dazaoArmor(thread)
        coroutine.yield()
        self:cunJianDao()        
        print('����ģ�����')
    end)
end

function Armor:cunJianDao(thread)
    wait.make(function() 
        await_go("���ݳ�","�ӻ���")
        wait_busy()
        exe('unwield jiandao;cun jian dao')
        wait_busy()
        checkWield()
        if g_stop_flag then        
            g_stop_flag = false
            dis_all()
            return
        end
        if thread then
            coroutine.resume(thread)
        end        
    end)
end

function Armor:checkJianDao(thread)
    wait.make(function()
        checkBags()  -- we should enhance this to be await like func
        wait_busy()
        while not Bag["����"] do
            await_go("���ݳ�","�ӻ���")
            local line, w
            repeat
                exe('qu jian dao')
                line, w = wait.regexp(
                                 '^(> )*(��Ѽ���|�㲢û�б���)',1)
            until line
            if line:find('�㲢û�б���') then
                local status = self:buyJianDao(coroutine.running())
                coroutine.yield()
                if status and status == 'break' then
                    coroutine.resume(thread,status)
                end
            
            end
            checkBags()  -- we should enhance this to be await like func
            wait_busy()         
        end
        
        print("�򵽼���")
        weapon_unwield()
        exe('wield jian dao')
        coroutine.resume(thread)
    end)
end
function Armor:dazaoArmor(thread)
    wait.make(function()
        local dazaoThread = coroutine.running()
        while self.currnetCount < self.totalCount do
            print('���δ����'..self.currnetCount..'�Σ�Ԥ�ƴ���'..self.totalCount..'�Ρ�')
            exe('weave '..self.dazaoID)
            local line,w = wait.regexp(
                '(> )*��ܵ���������֯��õ�(\\D*)��|(> )*�������ַ��ߣ����˽ⲻ�࣬������֯��|(> )*�����װ������������֯��|(> )*����Ҫ����һ����ԭ˿')
            if line and line:find("������֯��") then
                print("����ʧ�ܣ�")
                break
            elseif line and line:find('�����װ������') then
                local status = self:checkJianDao(dazaoThread)
                coroutine.yield()
                if status and status == 'break' then
                    break
                else
                    await_go('zhiye/caifengpu1')
                end                
            elseif line and line:find('����') then
                print('���ϲ�������ֹ')
                break
            else
                self.armorName = w[2]
                print("����ɹ�!".. self.armorName)
                
                self.currnetCount = self.currnetCount + 1
                self:checkProduct(dazaoThread)
                local status = coroutine.yield()
                if status == "abort" then
                    break
                end
            end
            if g_stop_flag then break end
        end
        if g_stop_flag then
            print("ֹͣ����")            
        else
            print("ȫ��������ϣ�һ��������"..self.currnetCount..'��')
        end
        coroutine.resume(thread)
    end)
end

function Armor:checkProduct(thread)
    wait.make(function()
        local line,w 
        repeat            
            exe('look '..self.dazaoID)
            line,w = wait.regexp(
                '^(> )*���Ĺ����У���(\\N*)��',1)
        until line
        local value = w[2]
        local wanttedAtr="��������������"
        local keep =false
        for c,v in value:gmatch('(['..wanttedAtr..']+)��(%d+)') do
            if wanttedAtr:find(c) then
                print(c,v)
                local number = tonumber(v)
                if number >= 5 then
                    print("��������������")
                    messageShow('�������ˣ����δ�����ֹ��','red','black')
                    keep = true
                    coroutine.resume(thread,"abort")
                elseif number >= self.expectValue then
                    print("���Ա���")
                    fqyyArmorMessage('װ�����ԣ�'..value)
                    keep = true
                end
            end
        end
        if keep then
            return self:cunArmor(thread)
        elseif self.autoDis then
            exe('dismantle '..self.dazaoID..';y')
        else 
            print("���������������ǲ��Զ��ֽ�")
        end
        wait_busy()
        coroutine.resume(thread)
    end)
end

function Armor:cunArmor(thread)
    wait.make(function()
        await_go('city/zahuopu')
        exe('cun '..self.dazaoID)
        checkBags()
        wait_busy()
        await_go('zhiye/caifengpu1')
        coroutine.resume(thread)
    end)
end

function Armor:buyJianDao(thread)
    wait.make(function()
        local stop = false
        while true do
            if g_stop_flag then
                print("ֹͣ����")
                stop = true
                break
            end
            if walk_hook_thread == nil then
                await_go("changan/northjie2")
                wait.time(1)
                exe('look')
                flag.times = 1
                find()
            end
            local line,_ = wait.regexp(
                '^(> )*\\s*��������\\(Yangcan popo\\)',5)
            if line then
                flag.wait = 1
                print('�ҵ�����')
                exe('follow yangcan popo;buy jian dao')
                local line2,_ = wait.regexp('^(> )*\\s*(����û�� yangcan popo|��.*��������������������һ�Ѽ���)',1)
                if line2 and line2:find('����û��') then
                    flag.find = 0
                    flag.wait = 0
                    walk_wait()
                elseif line2 and line2:find('������һ�Ѽ���') then
                    flag.find = 1
                    exe('follow none')
                    print("�򵽼�����")
                    checkBags()
                    break
                end
            else
                print("��ʱû���ҵ����ţ��ٳ���һ��")
            end
        end
        if stop then
            return coroutine.resume(thread,'break')
        else
            return coroutine.resume(thread)
        end
    end)
    
end


function dazaoArmor()
    local dz = Armor.new()
    tprint(dz)
    dz:dzStart()
end