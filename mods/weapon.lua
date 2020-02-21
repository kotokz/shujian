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
    for p in pairs(weaponStore) do t[p] = p end
    for p in pairs(Bag) do if Bag[p].kind then t[p] = p end end
    for p, q in pairs(weaponFunc) do if loadstring(q)() then t[p] = p end end
    if GetVariable("weaponprepare") then
        tmp.weapon = utils.split(GetVariable("weaponprepare"), '_')
        tmp.pre = {}
        for _, p in pairs(tmp.weapon) do tmp.pre[p] = true end
    end
    local l_tmp = utils.multilistbox(
                      "你准备要使用的武器有(请按CTRL多选)?",
                      "武器选择", t, tmp.pre)
    local l_result = nil
    if type(l_tmp) == "table" then
        for p in pairs(l_tmp) do
            weaponPrepare[p] = true
            if l_result then
                l_result = l_result .. '_' .. p
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

    for p in pairs(t) do if not weaponPrepare[p] then t[p] = nil end end

    if countTab(t) > 1 then
        l_result = utils.listbox("你优先使用的武器：", "优先武器",
                                 t, GetVariable("weaponfirst"))
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
        tmp.weapon = utils.split(GetVariable("weaponprepare"), '_')
        for _, p in pairs(tmp.weapon) do weaponPrepare[p] = true end
    end
    if GetVariable("weaponfirst") then
        weapon.first = GetVariable("weaponfirst")
    else
        weapon.first = nil
    end
end
weaponInBag = function(p_kind)
    for p in pairs(Bag) do
        if Bag[p].kind and Bag[p].kind == p_kind then return true end
    end
    return false
end
weapon_wield = function()
    --[[       if hp.neili<hp.neili_max*0.5 and cbb_cur>0 then
          exe('eat '.. drug.neili)
	   end                     ]]
    if perform and perform.skill and skillEnable[perform.skill] and
        weaponKind[skillEnable[perform.skill]] then
        if weapon.first and Bag[weapon.first] then
            exe('wield ' .. Bag[weapon.first].fullid)
        else
            for p in pairs(Bag) do
                if Bag[p].kind and Bag[p].kind == skillEnable[perform.skill] and
                    perform.skill ~= "yuxiao-jian" then
                    if not weapon.first or weapon.first ~= p then
                        exe('wield ' .. Bag[p].fullid)
                    end
                end
                if Bag[p].kind and Bag[p].kind == "xiao" and perform.skill ==
                    "yuxiao-jian" then
                    if not weapon.first or weapon.first ~= p then
                        exe('wield ' .. Bag[p].fullid)
                    end
                end
            end
        end
    end
    checkWield()
end
function bqcheck()
    if perform and perform.skill and skillEnable[perform.skill] and
        weaponKind[skillEnable[perform.skill]] then
        if weapon.first and Bag[weapon.first] then
            exe('wield ' .. Bag[weapon.first].fullid)
        else
            exe('wield sanqing sword')
            messageShow('恢复武器不见了！', "red")
        end
    end
end
weaponWWalk = function()
    weapon_wield()
    return walk_wait()
end
weapon_unwield = function()
    for p in pairs(Bag) do
        if Bag[p].kind and (not itemWield or itemWield[p]) then
            local _, l_cnt = isInBags(Bag[p].fullid)
            for i = 1, l_cnt do
                exe('unwield ' .. Bag[p].fullid .. ' ' .. i)
            end
        end
    end
    -- ungeta()
    checkWield()
end
weaponUnWalk = function()
    weapon_unwield()
    return walk_wait()
end
weaponWieldCut = function()
    weapon_unwield()
    local first = weapon.first
    if first and Bag[first] and Bag[first].kind and weaponKind[Bag[first].kind] and
        weaponKind[Bag[first].kind] == "cut" then
        exe('wield ' .. Bag[first].fullid)
    else
        for p in pairs(Bag) do
            if Bag[p].kind and weaponKind[Bag[p].kind] and
                weaponKind[Bag[p].kind] == "cut" then
                exe('wield ' .. Bag[p].fullid)
            end
        end
    end
    checkWield()
end

function weaponWieldLearn()
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    checkWield()
end
weaponUcheck = function()
    weaponUcannt = weaponUcannt or {}
    tmp.uweapon = nil
    wait.make(function()
        for p in pairs(weaponUsave) do
            if Bag[p] and Bag[p].kind and weaponKind[Bag[p].kind] and
                not weaponUcannt[p] then
                local l, w
                repeat
                    exe('l ' .. Bag[p].fullid)
                    l, w = wait.regexp(
                               '^(> )*看起来(需要修理|已经使用过一段时间|马上就要坏|没有什么损坏)',
                               1)
                until l ~= nil
                if string.find(l, '没有什么损坏') then
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
                DiscardQueue()
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
    end)
end

weaponRepairQu = function()
    await_go("扬州城", "杂货铺")
    exe('qu tiechui')
    checkBags()
    wait_busy()
    if Bag["铁锤"] then
        return weaponRepairDo()
    else
        messageShow('开始寻找铁匠师傅买铁锤')
        return weaponRepairFind()
    end
end
weaponRepairFind = function()
    DeleteTriggerGroup("weaponFind")
    create_trigger_t('weaponFind1',
                     '^(> )*\\s*采矿师傅\\(Caikuang shifu\\)', '',
                     'weaponRepairFollow')
    create_trigger_t('weaponFind2', '^(> )*这里没有 caikuang shifu', '',
                     'weaponRepairGoon')
    create_trigger_t('weaponFind3', '^(> )*你决定跟随\\D*一起行动。',
                     '', 'weaponRepairBuy')
    create_trigger_t('weaponFind4', '^(> )*你已经这样做了。', '',
                     'weaponRepairBuy')
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
    exe('look')
    return find()
end
weaponRepairFollow = function()
    flag.find = 1
    exe('follow caikuang shifu')
end
weaponRepairGoon = function()
    flag.wait = 0
    flag.find = 0
    return walk_wait()
end
weaponRepairBuy = function()
    EnableTriggerGroup("weaponFind", false)
    exe('buy tie chui')
    locate()
    checkBags()
    return checkWait(weaponRepairItem, 0.5)
end
weaponRepairItem = function()
    if cntr1() > 0 and not Bag["铁锤"] then return weaponRepairBuy() end
    -- if not Bag["铁锤"] then return weaponRepairGoCun() end
    if not Bag["铁锤"] then
        messageShow('没有找到铁匠师傅,结束武器维修')
        return weaponRepairOver()
    end
    return weaponRepairDo()
end
-- weaponRepairGo =
--     function() return go(weaponRepairDo, "扬州城", "兵器铺") end

function ungeta()
    local w_cmd = GetVariable("myweapon")
    local u_cmd = GetVariable("muweapon")
    local leweapon = GetVariable("learnweapon")
    if leweapon ~= nil then exe('unwield ' .. leweapon) end
    if w_cmd ~= nil then exe('unwield ' .. w_cmd) end
    if u_cmd ~= nil then exe('unwield ' .. u_cmd) end
end
weaponRepairDo = function()
    wait.make(function()
        await_go("扬州城", "兵器铺")
        weapon_unwield()
        bqxl = bqxl + 1
        exe('wield tie chui')
        checkWield()
        local cannotRepair = false
        local l, w = nil
        if tmp.uweapon and Bag[tmp.uweapon] then
            while true do
                exe('uweapon shape ' .. Bag[tmp.uweapon].kind .. ' ' ..
                        Bag[tmp.uweapon].kind)
                exe('repair ' .. Bag[tmp.uweapon].fullid)
                l, w = wait.regexp(
                           '^(> )*.*(总算大致恢复了它的原貌|无需修理|您了解不多，无法修理|你带的零钱不够了|你的精神状态不佳|你的铁锤坏掉了！|你必须装备铁锤才能来维修兵器)',
                           2)
                if l and l:find("必须装备铁锤才能来维修") then
                    checkBags(weapon_unwield)
                    exe('wield tie chui')
                    wait_busy()
                elseif l then
                    break
                end
            end
            if l:find('恢复了它的原貌') or l:find('无需修理') then
                weaponUsave[tmp.uweapon] = true
                tmp.uweapon = nil
            else
                cannotRepair = true
            end
        else
            messageShow('武器修理出错，找不到需要修的武器' ..
                            tmp.uweapon)
        end

        if cannotRepair then
            if l:find('无需修理') then
                return weaponRepairBuy()
            elseif l:find('你带的零钱不够了') then
                return weaponRepairGold()
            else
                return weaponRepairCannt()
            end
        end
        messageShow('武器修理完毕，继续下一步')
        weaponRepairGoCun()
    end)

end
function weaponRepairCannt()
    weaponUcannt = weaponUcannt or {}
    return weaponRepairGoCun()
end
function weaponRepairGold()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    exe('n;#3w;#3n;w;qu 400 gold;e;#3s;#3e;s')
    return weaponRepairDo()
end
weaponRepairOver = function()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    DeleteTimer("repair")
    DeleteTriggerGroup("repair")
    return armorUcheck()
    --	return check_halt(check_jobx)
end
weaponRepairGoCun = function()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    cntr2 = countR(3)
    exe('unwield tie chui')
    return go(weaponRepairCun, "扬州城", "杂货铺")
end
weaponRepairCun = function()
    if not Bag["铁锤"] then return checkPrepare() end
    if cntr2() > 0 and Bag["铁锤"] then
        weapon_unwield()
        exe('cun tie chui')
        checkBags()
        return check_busy(weaponRepairCun, 1)
    end
    return weaponRepairOver()
end
weaponGetSwj = function() return go(swjAsk, "武当山", "后山小院") end
function swjAsk()
    if locl.room ~= "后山小院" or not locl.id["张三丰"] then
        return weaponGetSwj()
    end
    exe('ask zhang sanfeng about 下山')
    wait.make(function()
        wait.time(3)
        exe('ask zhang sanfeng about 教诲')
        checkBags()
        return check_bei(swjOver)
    end)
end
function swjOver() return checkPrepare() end
armorUdone = function()
    DeleteTimer("walkWait4")
    for p in pairs(weaponUsave) do
        if weaponUsave[p] and type(weaponUsave[p]) == "string" and
            weaponUsave[p] == "repair" then
            dis_all()
            return armorRepair(p)
        end
    end
    return check_bei(armorRepairOver)
end
armorUtmp = function(n, l, w)
    if weaponUsave[w[3]] and Bag[w[3]] then tmp.uarmor = w[3] end
end
armorUwell = function()
    if tmp.uarmor and weaponUsave[tmp.uarmor] then
        weaponUsave[tmp.uarmor] = true
    end
end
armorUcheck = function()
    DeleteTriggerGroup("armor")
    create_trigger_t('armor1',
                     '^(> )*你把 "action" 设定为 "checkUarmor" 成功完成。',
                     '', 'armorUdone')
    create_trigger_t('armor2',
                     '^(> )*这是由\\D*(棉花|亚麻|大麻|苎麻|蚕丝|木棉花|玉蚕丝|冰蚕丝|天蚕丝|龙茧蚕丝)制成，重\\D*的(\\D*)。$',
                     '', 'armorUtmp')
    create_trigger_t('armor3',
                     '^(> )*看起来(需要修理|已经使用过一段时间|马上就要坏)了。',
                     '', 'armorUneed')
    create_trigger_t('armor4', '^(> )*看起来没有什么损坏。', '',
                     'armorUwell')
    SetTriggerOption("armor1", "group", "armor")
    SetTriggerOption("armor2", "group", "armor")
    SetTriggerOption("armor3", "group", "armor")
    SetTriggerOption("armor4", "group", "armor")
    armorUcannt = armorUcannt or {}
    tmp.uarmor = nil
    for p in pairs(weaponUsave) do
        if Bag[p] and Bag[p].kind and armorKind[Bag[p].kind] and
            not armorUcannt[p] then exe('l ' .. Bag[p].fullid) end
    end
    exe('alias action checkUarmor')
    create_timer_s('walkWait4', 1.0, 'armorUcheck1')
end
function armorUcheck1() exe('alias action checkUarmor') end
armorUneed = function()
    if tmp.uarmor and weaponUsave[tmp.uarmor] then
        weaponUsave[tmp.uarmor] = "repair"
    end
end
function armorRepairGold()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    exe('e;#3s;w;qu 50 gold;e;#3n;w')
    return checkWait(armorRepairDo, 2)
end
armorRepairDo = function()
    DeleteTriggerGroup("repair")
    create_trigger_t('repair1',
                     '^(> )*你开始仔细的修补(\\D*)，不时用剪刀来回裁剪缝纫着',
                     '', '')
    create_trigger_t('repair2',
                     '^(> )*你仔细的修补(\\D*)，总算大致恢复了它的原貌。$',
                     '', 'armorRepairGoCun')
    create_trigger_t('repair3',
                     '^(> )*这件防具完好无损，无需修补。$', '',
                     'armorRepairGoCun')
    create_trigger_t('repair4',
                     '^(> )*对于这种防具，您了解不多，无法修补！$',
                     '', 'armorRepairCannt')
    create_trigger_t('repair5', '^(> )*你带的零钱不够了！你需要',
                     '', 'armorRepairGold')
    create_trigger_t('repair6',
                     '^(> )*你现在精神状态不佳，还是等会再修补吧。$',
                     '', 'armorRepairCannt')
    SetTriggerOption("repair1", "group", "repair")
    SetTriggerOption("repair2", "group", "repair")
    SetTriggerOption("repair3", "group", "repair")
    SetTriggerOption("repair4", "group", "repair")
    SetTriggerOption("repair5", "group", "repair")
    SetTriggerOption("repair6", "group", "repair")
    hujuxl = hujuxl + 1
    weapon_unwield()
    ungeta()
    exe(
        'unwield zhanlu;unwield mu jian;unwield taiji sword;unwield qiankun sword;unwield qiankun xiao')
    exe('wield jian dao')
    exe('repair ' .. Bag[tmp.uarmor].fullid)
    create_timer_m('repair', 3, 'armorRepairGoCun')
end
armorRepairQu = function()
    exe('qu jian dao')
    checkBags()
    return check_bei(armorRepairQuCheck, 1)
end
armorRepairQuCheck = function()
    if cntr1() > 0 and not Bag["剪刀"] then return armorRepairQu() end
    if Bag["剪刀"] then
        return armorRepairGo()
    else
        return armorRepairFind()
    end
end
armorRepairFollow = function()
    flag.find = 1
    exe('follow yangcan popo')
end
armorRepairFind = function()
    DeleteTriggerGroup("armorFind")
    create_trigger_t('armorFind1', '^(> )*\\s*养蚕婆婆\\(Yangcan popo\\)',
                     '', 'armorRepairFollow')
    create_trigger_t('armorFind2', '^(> )*这里没有 yangcan popo', '',
                     'armorRepairGoon')
    create_trigger_t('armorFind3', '^(> )*你决定跟随\\D*一起行动。',
                     '', 'armorRepairBuy')
    create_trigger_t('armorFind4', '^(> )*你已经这样做了。', '',
                     'armorRepairBuy')
    SetTriggerOption("armorFind1", "group", "armorFind")
    SetTriggerOption("armorFind2", "group", "armorFind")
    SetTriggerOption("armorFind3", "group", "armorFind")
    SetTriggerOption("armorFind4", "group", "armorFind")
    EnableTriggerGroup("armorFind", false)
    cntr1 = countR(20)
    job.name = "买剪刀"
    return go(armorRepairFact, "changan/northjie2")
end
armorRepairFact = function()
    EnableTriggerGroup("armorFind", true)
    exe('look')
    return find()
end
armorRepairBuy = function()
    EnableTriggerGroup("armorFind", false)
    exe('buy jian dao')
    locate()
    checkBags()
    return checkWait(armorRepairItem, 0.5)
end
armorRepairItem = function()
    if cntr1() > 0 and not Bag["剪刀"] then return armorRepairBuy() end
    if not Bag["剪刀"] then return armorRepairGoCun() end
    return armorRepairGo()
end
armorRepairGo =
    function() return go(armorRepairDo, "长安城", "裁缝铺") end
armorRepairGoon = function()
    flag.wait = 0
    flag.find = 0
    return walk_wait()
end
armorRepair = function(p_armor)
    tmp.uarmor = p_armor
    if not Bag["剪刀"] then
        cntr1 = countR(3)
        return go(armorRepairQu, "扬州城", "杂货铺")
    end
    return armorRepairGo()
end
function armorRepairCannt()
    armorUcannt = armorUcannt or {}
    return armorRepairGoCun()
end
armorRepairGoCun = function()
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    cntr2 = countR(3)
    exe('unwield jian dao')
    return go(armorRepairCun, "扬州城", "杂货铺")
end
armorRepairCun = function()
    exe('unwield jian dao')
    if not Bag["剪刀"] then return check_heal() end
    if cntr2() > 0 and Bag["剪刀"] then
        exe('cun jian dao')
        checkBags()
        return check_busy(armorRepairCun, 1)
    end
    return armorRepairOver()
end
armorRepairOver = function()
    DeleteTriggerGroup("armor")
    EnableTriggerGroup("repair", false)
    EnableTimer("repair", false)
    DeleteTimer("repair")
    DeleteTriggerGroup("repair")
    return check_halt(check_jobx)
end
