weaponPrepare = {}
weaponUsave = {}
itemWield = {}
bqxl = 0
hujuxl = 0
weaponStore = {
    ["箫"] = "city/yueqidian",
    ["木剑"] = "xiangyang/mujiangpu",
    ["长剑"] = "zhiye/bingqipu1",
    ["铁笔"] = "zhiye/bingqipu1",
    ["钢刀"] = "zhiye/bingqipu1",
    ["流星锤"] = "zhiye/bingqipu1",
    ["铁棍"] = "zhiye/bingqipu1",
    ["钢杖"] = "zhiye/bingqipu1",
    ["长鞭"] = "zhiye/bingqipu1",
    ["竹棒"] = "zhiye/bingqipu1",
    ["钢斧"] = "zhiye/bingqipu1",
    ["匕首"] = "zhiye/bingqipu1",
    ["单钩"] = "zhiye/bingqipu1",
    ["石子"] = "zhiye/bingqipu1",
    ["飞镖"] = "zhiye/bingqipu1",
    ["梅花针"] = "zhiye/bingqipu1",
    ["手裏剑"] = "zhiye/bingqipu1"
}

weaponStoreId = {
    ["箫"] = "xiao",
    ["木剑"] = "mu jian",
    ["长剑"] = "changjian",
    ["铁笔"] = "tie bi",
    ["钢刀"] = "blade",
    ["流星锤"] = "liuxing chui",
    ["铁棍"] = "tiegun",
    ["钢杖"] = "gangzhang",
    ["长鞭"] = "changbian",
    ["竹棒"] = "zhubang",
    ["钢斧"] = "gang fu",
    ["匕首"] = "bishou",
    ["单钩"] = "hook",
    ["石子"] = "shizi",
    ["飞镖"] = "dart",
    ["梅花针"] = "meihua zhen",
    ["手裏剑"] = "shuriken",
    ["杖"] = "staff",
    ["铜钱"] = "coin"
}

weaponFunc = {
    ["松纹古剑"] = "if score.master and score.master=='张三丰' then return true else return false end"
}
weaponFuncName = {["松纹古剑"] = "weaponGetSwj"}

weaponThrowing = {
    ["梅花针"] = true,
    ["手裏剑"] = true,
    ["飞镖"] = true,
    ["铜钱"] = true,
    ["石子"] = true,
    ["甩箭"] = true,
    ["神龙镖"] = true,
    ["飞蝗石"] = true
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
    local l_tmp = utils.multilistbox("你准备要使用的武器有(请按CTRL多选)?", "武器选择", t, tmp.pre)
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
        l_result = utils.listbox("你优先使用的武器：", "优先武器", t, GetVariable("weaponfirst"))
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
        print("包裹空的？？")
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
                        l, w = wait.regexp("^(> )*看起来(需要修理|已经使用过一段时间|马上就要坏|没有什么损坏)", 1)
                    until l ~= nil
                    if string.find(l, "没有什么损坏") or l:find("已经使用过一段时间") then
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
                if not Bag["铁锤"] then
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
    await_go("扬州城", "杂货铺")
    exe("qu tiechui")
    await_check_bags()
    wait_busy()
    if Bag["铁锤"] then
        return weaponRepairDo()
    else
        messageShow("开始寻找铁匠师傅买铁锤")
        return weaponRepairFind()
    end
end
weaponRepairFind = function()
    DeleteTriggerGroup("weaponFind")
    create_trigger_t("weaponFind1", "^(> )*\\s*采矿师傅\\(Caikuang shifu\\)", "", "weaponRepairFollow")
    create_trigger_t("weaponFind2", "^(> )*这里没有 caikuang shifu", "", "weaponRepairGoon")
    create_trigger_t("weaponFind3", "^(> )*你决定跟随\\D*一起行动。", "", "weaponRepairBuy")
    create_trigger_t("weaponFind4", "^(> )*你已经这样做了。", "", "weaponRepairBuy")
    SetTriggerOption("weaponFind1", "group", "weaponFind")
    SetTriggerOption("weaponFind2", "group", "weaponFind")
    SetTriggerOption("weaponFind3", "group", "weaponFind")
    SetTriggerOption("weaponFind4", "group", "weaponFind")
    EnableTriggerGroup("weaponFind", false)
    cntr1 = countR(20)
    job.name = "买铁锤"
    return go(weaponRepairFact, "扬州城", "打铁铺")
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
    if cntr1() > 0 and not Bag["铁锤"] then
        return weaponRepairBuy()
    end
    -- if not Bag["铁锤"] then return weaponRepairGoCun() end
    if not Bag["铁锤"] then
        messageShow("没有找到铁匠师傅,结束武器维修")
        return weaponRepairOver()
    end
    exe("follow none")
    return weaponRepairDo()
end
-- weaponRepairGo =
--     function() return go(weaponRepairDo, "扬州城", "兵器铺") end

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
            await_go("扬州城", "兵器铺")
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
                        "^(> )*.*(总算大致恢复了它的原貌|无需修理|您了解不多，无法修理|你带的零钱不够了|你的精神状态不佳|你的铁锤坏掉了！|你必须装备铁锤才能来维修兵器)",
                        2
                    )
                    if l and l:find("必须装备铁锤才能来维修") then
                        await_check_bags()
                        weapon_unwield()
                        exe("wield tie chui")
                        wait_busy()
                    elseif l then
                        break
                    end
                end
                if l:find("恢复了它的原貌") or l:find("无需修理") then
                    weaponUsave[tmp.uweapon] = true
                    tmp.uweapon = nil
                else
                    cannotRepair = true
                end
            else
                messageShow("武器修理出错，找不到需要修的武器" .. tmp.uweapon)
            end

            if cannotRepair then
                if l:find("无需修理") then
                    return weaponRepairBuy()
                elseif l:find("你带的零钱不够了") then
                    return weaponRepairGold()
                else
                    return weaponRepairCannt()
                end
            end
            messageShow("武器修理完毕，继续下一步")
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
    return go(weaponRepairCun, "扬州城", "杂货铺")
end
weaponRepairCun = function()
    if not Bag["铁锤"] then
        return checkPrepare()
    end
    wait.make(
        function()
            repeat
                exe("unwield tiechui;cun tiechui")
                local l, w = wait.regexp("^(> )*(你从身上拿出一柄铁锤|你身上没有这样东西)", 1)
            until l
            await_check_bags()
            checkWield()
            wait_busy()
            return weaponRepairOver()
        end
    )
end
weaponGetSwj = function()
    return go(swjAsk, "武当山", "后山小院")
end
function swjAsk()
    if locl.room ~= "后山小院" or not locl.id["张三丰"] then
        return weaponGetSwj()
    end
    exe("ask zhang sanfeng about 下山")
    wait.make(
        function()
            wait.time(3)
            exe("ask zhang sanfeng about 教诲")
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
    l_result = utils.inputbox("你需要打造的次数是", "dazaoNUM", GetVariable("dazaoNUM"), "宋体", "12")
    if not isNil(l_result) then
        l_dazuo = tonumber(l_result)
    end
    l_result = utils.inputbox("你需要打造的类型", "dazuoType", GetVariable("dazuoType"), "宋体", "12")
    if not isNil(l_result) then
        l_dazuotype = l_result
    end
    wait.make(
        function()
            local count = 0
            while count < l_dazuo do
                while true do
                    exe("ask shi about weilan;da " .. l_dazuotype)
                    local l, w = wait.regexp("^(> )*.*(韦兰铁匠给了你一把|我正忙着呢)")
                    if l ~= nil and l:find("韦兰铁匠给了你一把") then
                        break
                    else
                        time.wait(0.4)
                    end
                end
                wait_busy()
                count = count + 1
                print("打造完第" .. count .. "把，总共需要打造:" .. l_dazuo .. "把")
            end
            print("打造完毕")
        end
    )
end

function weapon_lost()
    DeleteTriggerGroup("weapon_lose")
    create_trigger_t("weapon_lose1", "^>*\\s*哈士奇一转眼就跑没影儿了，一会给你叼来了一柄(\\D*)，然后不知道跑哪去了。", "", "weapon_found")
    create_trigger_t("weapon_lose2", "^>*\\s*哈士奇呆呆地瞪着你，好象很不高兴的样子。", "", "weapon_no_found")
    create_trigger_t("weapon_lose3", "^>*\\s*你的状态不稳定，请稍候。", "", "weapon_no_found")
    SetTriggerOption("weapon_lose1", "group", "weapon_lose")
    SetTriggerOption("weapon_lose2", "group", "weapon_lose")
    SetTriggerOption("weapon_lose3", "group", "weapon_lose")
    EnableTriggerGroup("weapon_lose", true)
    return go(weapon_lost_get, "扬州城", "当铺")
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
    messageShow("武器丢失，兑换哈士奇找回！", "red")
    return check_busy(weapon_found_get)
end
function weapon_found_get()
    exe("get all")
    checkBags()
    return check_halt(check_food)
end
