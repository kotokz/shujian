weaponPrepare = {}
weaponUsave = {}
itemWield = {}
bqxl = 0
hujuxl = 0
weaponStore = {
    ["��"] = "city/yueqidian",
    ["ľ��"] = "xiangyang/mujiangpu",
    ["����"] = "zhiye/bingqipu1",
    ["����"] = "zhiye/bingqipu1",
    ["�ֵ�"] = "zhiye/bingqipu1",
    ["���Ǵ�"] = "zhiye/bingqipu1",
    ["����"] = "zhiye/bingqipu1",
    ["����"] = "zhiye/bingqipu1",
    ["����"] = "zhiye/bingqipu1",
    ["���"] = "zhiye/bingqipu1",
    ["�ָ�"] = "zhiye/bingqipu1",
    ["ذ��"] = "zhiye/bingqipu1",
    ["����"] = "zhiye/bingqipu1",
    ["ʯ��"] = "zhiye/bingqipu1",
    ["����"] = "zhiye/bingqipu1",
    ["÷����"] = "zhiye/bingqipu1",
    ["������"] = "zhiye/bingqipu1"
}

weaponStoreId = {
    ["��"] = "xiao",
    ["ľ��"] = "mu jian",
    ["����"] = "changjian",
    ["����"] = "tie bi",
    ["�ֵ�"] = "blade",
    ["���Ǵ�"] = "liuxing chui",
    ["����"] = "tiegun",
    ["����"] = "gangzhang",
    ["����"] = "changbian",
    ["���"] = "zhubang",
    ["�ָ�"] = "gang fu",
    ["ذ��"] = "bishou",
    ["����"] = "hook",
    ["ʯ��"] = "shizi",
    ["����"] = "dart",
    ["÷����"] = "meihua zhen",
    ["������"] = "shuriken",
    ["��"] = "staff",
    ["ͭǮ"] = "coin"
}

weaponFunc = {
    ["���ƹŽ�"] = "if score.master and score.master=='������' then return true else return false end"
}
weaponFuncName = {["���ƹŽ�"] = "weaponGetSwj"}

weaponThrowing = {
    ["÷����"] = true,
    ["������"] = true,
    ["����"] = true,
    ["ͭǮ"] = true,
    ["ʯ��"] = true,
    ["˦��"] = true,
    ["������"] = true,
    ["�ɻ�ʯ"] = true
}

armorKind = {
    ["armor"] = true,
    ["coat"] = true,
    ["mantle"] = true,
    ["cap"] = true,
    ["glove"] = true,
    ["boot"] = true
}

weaponKind = {
    ["jian"] = "cut",
    ["ren"] = "cut",
    ["blade"] = "cut",
    ["sword"] = "cut",
    ["stick"] = true,
    ["club"] = true,
    ["hammer"] = true,
    ["whip"] = true,
    ["axe"] = "cut",
    ["staff"] = true,
    ["brush"] = true,
    ["dagger"] = "cut",
    ["hook"] = "cut",
    ["spear"] = true,
    ["gangzhang"] = true,
    ["throwing"] = true,
    ["xiao"] = true,
    ["fork"] = true,
    ["dart"] = true
}

unarmedKind = {
    ["cuff"] = true,
    ["strike"] = true,
    ["finger"] = true,
    ["claw"] = true,
    ["hand"] = true,
    ["leg"] = true
}

function weaponSet()
    weaponPrepare = {}
    local t = {}
    for p in pairs(weaponStore) do
        t[p] = p
    end
    for p in pairs(Bag) do
        if Bag[p].kind then
            t[p] = p
        end
    end
    for p, q in pairs(weaponFunc) do
        if loadstring(q)() then
            t[p] = p
        end
    end
    if GetVariable("weaponprepare") then
        tmp.weapon = utils.split(GetVariable("weaponprepare"), "_")
        tmp.pre = {}
        for _, p in pairs(tmp.weapon) do
            tmp.pre[p] = true
        end
    end
    local l_tmp = utils.multilistbox("��׼��Ҫʹ�õ�������(�밴CTRL��ѡ)?", "����ѡ��", t, tmp.pre)
    local l_result = nil
    if type(l_tmp) == "table" then
        for p in pairs(l_tmp) do
            weaponPrepare[p] = true
            if l_result then
                l_result = l_result .. "_" .. p
            else
                l_result = p
            end
        end
    end
    if l_result then
        SetVariable("weaponprepare", l_result)
    else
        DeleteVariable("weaponprepare")
    end

    for p in pairs(t) do
        if not weaponPrepare[p] then
            t[p] = nil
        end
    end

    if countTab(t) > 1 then
        l_result = utils.listbox("������ʹ�õ�������", "��������", t, GetVariable("weaponfirst"))
        if l_result ~= nil then
            SetVariable("weaponfirst", l_result)
            weapon.first = l_result
        else
            weapon.first = nil
            DeleteVariable("weaponfirst")
        end
    end
end
function weaponGetVar()
    weaponPrepare = {}
    if GetVariable("weaponprepare") then
        tmp.weapon = utils.split(GetVariable("weaponprepare"), "_")
        for _, p in pairs(tmp.weapon) do
            weaponPrepare[p] = true
        end
    end
    if GetVariable("weaponfirst") then
        weapon.first = GetVariable("weaponfirst")
    else
        weapon.first = nil
    end
end
weaponInBag = function(p_kind)
    for p in pairs(Bag) do
        if Bag[p].kind and Bag[p].kind == p_kind then
            return true
        end
    end
    return false
end
weapon_wield = function()
    --[[       if hp.neili<hp.neili_max*0.5 and cbb_cur>0 then
          exe('eat '.. drug.neili)
	   end                     ]]
    if weapon.first and Bag[weapon.first] then
        exe("wield " .. Bag[weapon.first].fullid)
    elseif perform and perform.skill and skillEnable[perform.skill] and weaponKind[skillEnable[perform.skill]] then
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == skillEnable[perform.skill] then
                if not weapon.first or weapon.first ~= p then
                    exe("wield " .. Bag[p].fullid)
                end
            end
        end
    end
    checkWield()
end
weaponWWalk = function()
    weapon_wield()
    return walk_wait()
end
weapon_unwield = function()
    for p in pairs(Bag) do
        if Bag[p].kind and weaponKind[Bag[p].kind] and (not itemWield or itemWield[p]) then
            local _, l_cnt = isInBags(Bag[p].fullid)
            for i = 1, l_cnt do
                exe("unwield " .. Bag[p].fullid .. " " .. i)
            end
        end
    end
    checkWield()
end
weaponUnWalk = function()
    weapon_unwield()
    return walk_wait()
end
weaponWieldCut = function()
    weapon_unwield()
    if coroutine.running() then
        wait_busy()
    end
    local found = false
    local first = weapon.first
    if first and Bag[first] and Bag[first].kind and weaponKind[Bag[first].kind] and weaponKind[Bag[first].kind] == "cut" then
        found = true
        exe("wield " .. Bag[first].fullid)

        weaponshape(first)
    else
        for p in pairs(Bag) do
            if Bag[p].kind and weaponKind[Bag[p].kind] and weaponKind[Bag[p].kind] == "cut" then
                found = true
                exe("wield " .. Bag[p].fullid)
            end
        end
    end
    if not found then
        local weapon = GetVariable("myweapon")
        print("�����յģ���")
        if weapon then
            exe("wield " .. weapon)
        end
    end
    checkWield()
end

function weaponshape(name)
    local shenqi_id = GetVariable("myshenqi_id")
    if shenqi_id then
        if shenqi_id:find(" ") then
            local ids = utils.split(shenqi_id, " ")
            shenqi_id = ids[-1]
        end
        exe("uweapon shape " .. shenqi_id .. " " .. Bag[name].kind)
    else
        exe("uweapon shape " .. Bag[name].kind .. " " .. Bag[name].kind)
    end
end

function weaponWieldLearn()
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe("wield " .. leweapon)
    checkWield()
end
weaponUcheck = function()
    weaponUcannt = weaponUcannt or {}
    tmp.uweapon = nil
    wait.make(
        function()
            for p in pairs(weaponUsave) do
                if Bag[p] and Bag[p].kind and weaponKind[Bag[p].kind] and not weaponUcannt[p] then
                    local l, w
                    repeat
                        exe("l " .. Bag[p].fullid)
                        l, w = wait.regexp("^(> )*������(��Ҫ����|�Ѿ�ʹ�ù�һ��ʱ��|���Ͼ�Ҫ��|û��ʲô��)", 1)
                    until l ~= nil
                    if string.find(l, "û��ʲô��") or l:find("�Ѿ�ʹ�ù�һ��ʱ��") then
                        weaponUsave[p] = true
                    else
                        weaponUsave[p] = false
                    end
                end
            end
            tprint(weaponUsave)
            for p in pairs(weaponUsave) do
                if weaponUsave[p] == false then
                    dis_all()
                    -- return weaponRepair(p)
                    tmp.uweapon = p
                    break
                end
            end
            if tmp.uweapon then
                if not Bag["����"] then
                    -- cntr1 = countR(3)
                    return weaponRepairQu()
                else
                    return weaponRepairDo()
                end
            end
            return weaponRepairOver()
        end
    )
end

weaponRepairQu = function()
    await_go("���ݳ�", "�ӻ���")
    exe("qu tiechui")
    await_check_bags()
    wait_busy()
    if Bag["����"] then
        return weaponRepairDo()
    else
        messageShow("��ʼѰ������ʦ��������")
        return weaponRepairFind()
    end
end
weaponRepairFind = function()
    DeleteTriggerGroup("weaponFind")
    create_trigger_t("weaponFind1", "^(> )*\\s*�ɿ�ʦ��\\(Caikuang shifu\\)", "", "weaponRepairFollow")
    create_trigger_t("weaponFind2", "^(> )*����û�� caikuang shifu", "", "weaponRepairGoon")
    create_trigger_t("weaponFind3", "^(> )*���������\\D*һ���ж���", "", "weaponRepairBuy")
    create_trigger_t("weaponFind4", "^(> )*���Ѿ��������ˡ�", "", "weaponRepairBuy")
    SetTriggerOption("weaponFind1", "group", "weaponFind")
    SetTriggerOption("weaponFind2", "group", "weaponFind")
    SetTriggerOption("weaponFind3", "group", "weaponFind")
    SetTriggerOption("weaponFind4", "group", "weaponFind")
    EnableTriggerGroup("weaponFind", false)
    cntr1 = countR(20)
    job.name = "������"
    return go(weaponRepairFact, "���ݳ�", "������")
end
weaponRepairFact = function()
    EnableTriggerGroup("weaponFind", true)
    exe("look")
    return find()
end
weaponRepairFollow = function()
    flag.find = 1
    exe("follow caikuang shifu")
end
weaponRepairGoon = function()
    flag.wait = 0
    flag.find = 0
    return walk_wait()
end
weaponRepairBuy = function()
    EnableTriggerGroup("weaponFind", false)
    exe("buy tie chui")
    locate()
    checkBags()
    return checkWait(weaponRepairItem, 0.5)
end
weaponRepairItem = function()
    if cntr1() > 0 and not Bag["����"] then
        return weaponRepairBuy()
    end
    -- if not Bag["����"] then return weaponRepairGoCun() end
    if not Bag["����"] then
        messageShow("û���ҵ�����ʦ��,��������ά��")
        return weaponRepairOver()
    end
    exe("follow none")
    return weaponRepairDo()
end
-- weaponRepairGo =
--     function() return go(weaponRepairDo, "���ݳ�", "������") end

function ungeta()
    local w_cmd = GetVariable("myweapon")
    local u_cmd = GetVariable("muweapon")
    local leweapon = GetVariable("learnweapon")
    if leweapon ~= nil then
        exe("unwield " .. leweapon)
    end
    if w_cmd ~= nil then
        exe("unwield " .. w_cmd)
    end
    if u_cmd ~= nil then
        exe("unwield " .. u_cmd)
    end
end
weaponRepairDo = function()
    wait.make(
        function()
            await_go("���ݳ�", "������")
            weapon_unwield()
            bqxl = bqxl + 1
            exe("wield tie chui")
            checkWield()
            local cannotRepair = false
            local l, w = nil
            local shenqi_id = GetVariable("myshenqi_id")
            if tmp.uweapon and Bag[tmp.uweapon] then
                while true do
                    weaponshape(tmp.uweapon)
                    exe("repair " .. Bag[tmp.uweapon].fullid)
                    l, w =
                        wait.regexp(
                        "^(> )*.*(������»ָ�������ԭò|��������|���˽ⲻ�࣬�޷�����|�������Ǯ������|��ľ���״̬����|������������ˣ�|�����װ������������ά�ޱ���)",
                        2
                    )
                    if l and l:find("����װ������������ά��") then
                        await_check_bags()
                        weapon_unwield()
                        exe("wield tie chui")
                        wait_busy()
                    elseif l then
                        break
                    end
                end
                if l:find("�ָ�������ԭò") or l:find("��������") then
                    weaponUsave[tmp.uweapon] = true
                    tmp.uweapon = nil
                else
                    cannotRepair = true
                end
            else
                messageShow("������������Ҳ�����Ҫ�޵�����" .. tmp.uweapon)
            end

            if cannotRepair then
                if l:find("��������") then
                    return weaponRepairBuy()
                elseif l:find("�������Ǯ������") then
                    return weaponRepairGold()
                else
                    return weaponRepairCannt()
                end
            end
            messageShow("����������ϣ�������һ��")
            weaponRepairGoCun()
        end
    )
end
function weaponRepairCannt()
    weaponUcannt = weaponUcannt or {}
    return weaponRepairGoCun()
end
function weaponRepairGold()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    exe("n;#3w;#3n;w;qu 400 gold;e;#3s;#3e;s")
    return weaponRepairDo()
end
weaponRepairOver = function()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    DeleteTimer("repair")
    DeleteTriggerGroup("repair")
    -- return armorUcheck()
    local armor = Armor:new()
    armor:checkDamage()
    --	return check_halt(check_jobx)
end
weaponRepairGoCun = function()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    cntr2 = countR(3)
    -- exe('unwield tie chui')
    return go(weaponRepairCun, "���ݳ�", "�ӻ���")
end
weaponRepairCun = function()
    if not Bag["����"] then
        return checkPrepare()
    end
    wait.make(
        function()
            repeat
                exe("unwield tiechui;cun tiechui")
                local l, w = wait.regexp("^(> )*(��������ó�һ������|������û����������)", 1)
            until l
            await_check_bags()
            checkWield()
            wait_busy()
            return weaponRepairOver()
        end
    )
end
weaponGetSwj = function()
    return go(swjAsk, "�䵱ɽ", "��ɽСԺ")
end
function swjAsk()
    if locl.room ~= "��ɽСԺ" or not locl.id["������"] then
        return weaponGetSwj()
    end
    exe("ask zhang sanfeng about ��ɽ")
    wait.make(
        function()
            wait.time(3)
            exe("ask zhang sanfeng about �̻�")
            await_check_bags()
            return check_bei(swjOver)
        end
    )
end
function swjOver()
    return checkPrepare()
end

function dazaoWeapon()
    tmp.dazuo = 0
    local l_dazuo = 0
    local l_dazuotype = ""
    l_result = utils.inputbox("����Ҫ����Ĵ�����", "dazaoNUM", GetVariable("dazaoNUM"), "����", "12")
    if not isNil(l_result) then
        l_dazuo = tonumber(l_result)
    end
    l_result = utils.inputbox("����Ҫ���������", "dazuoType", GetVariable("dazuoType"), "����", "12")
    if not isNil(l_result) then
        l_dazuotype = l_result
    end
    wait.make(
        function()
            local count = 0
            while count < l_dazuo do
                while true do
                    exe("ask shi about weilan;da " .. l_dazuotype)
                    local l, w = wait.regexp("^(> )*.*(Τ������������һ��|����æ����)")
                    if l ~= nil and l:find("Τ������������һ��") then
                        break
                    else
                        time.wait(0.4)
                    end
                end
                wait_busy()
                count = count + 1
                print("�������" .. count .. "�ѣ��ܹ���Ҫ����:" .. l_dazuo .. "��")
            end
            print("�������")
        end
    )
end

function weapon_lost()
    DeleteTriggerGroup("weapon_lose")
    create_trigger_t("weapon_lose1", "^>*\\s*��ʿ��һת�۾���ûӰ���ˣ�һ����������һ��(\\D*)��Ȼ��֪������ȥ�ˡ�", "", "weapon_found")
    create_trigger_t("weapon_lose2", "^>*\\s*��ʿ������ص����㣬����ܲ����˵����ӡ�", "", "weapon_no_found")
    create_trigger_t("weapon_lose3", "^>*\\s*���״̬���ȶ������Ժ�", "", "weapon_no_found")
    SetTriggerOption("weapon_lose1", "group", "weapon_lose")
    SetTriggerOption("weapon_lose2", "group", "weapon_lose")
    SetTriggerOption("weapon_lose3", "group", "weapon_lose")
    EnableTriggerGroup("weapon_lose", true)
    return go(weapon_lost_get, "���ݳ�", "����")
end

function weapon_lost_get()
    exe("duihuan husky")
    exe("save")
end
function weapon_no_found()
    check_halt(BQuit)
    exe("drink jiudai")
end
function weapon_found()
    EnableTriggerGroup("weapon_lose", false)
    scrLog()
    messageShow("������ʧ���һ���ʿ���һأ�", "red")
    return check_busy(weapon_found_get)
end
function weapon_found_get()
    exe("get all")
    checkBags()
    return check_halt(check_food)
end
