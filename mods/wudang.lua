-- wudang
wdtongji_total = 0
wdtongji_cs = 0 -- 领取job次数统计
wdtongji_lasttime_total = 0
wdtongji_zdcs = 0 -- 战斗次数
wdtongji_lasttime_lj = 0 -- 累计战斗时间
wdtongji_thistime = 0 -- 本次任务战斗时间
wdtongji_pingjun = 0 -- 平均时间
wdtongji_fangqi = 0 -- 失败次数
wdtongji_finish = 0 -- 完成次数
wdtongji_cgl = 0 -- 成功率
wdtosld = 0
wdtomr = 0
wdtoyzw = 0
wdtomtl = 0
wdtoszgf = 0
wdtohssd = 0
wdtoxct = 0
wudang_cs = 0

-- 共计完成【'..wdtongji_cs'】次,平均战斗时间【】次,成功【】次，失败【】次，完成率【】
wdgostart = 0
function wudangTrigger()
    DeleteTriggerGroup("wudangAccept")
    create_trigger_t("wudangAccept1",
                     "^(> )*宋远桥在你的耳边悄声说道：据说(\\D*)正在(\\D*)捣乱",
                     "", "wudangConsider")
    create_trigger_t("wudangAccept2",
                     "^(> )*宋远桥说道：「我不是告诉你了吗，有人在",
                     "", "wudangFangqi")
    create_trigger_t("wudangAccept3",
                     "^(> )*宋远桥在你的耳边悄声说道(\\D*)尤为擅长(\\D*)的功夫。",
                     "", "wudangNpc")
    create_trigger_t("wudangAccept4",
                     "^(> )*宋远桥说道：「你正忙着别的事情呢",
                     "", "wudangFail")
    create_trigger_t("wudangAccept5",
                     "^(> )*宋远桥说道：「你刚做完(武当锄奸|惩恶扬善|大理送信|抗敌颂摩崖|官府捕快|福州护镖)任务",
                     "", "wudangFail")
    create_trigger_t("wudangAccept6",
                     "^(> )*宋远桥说道：「现在暂时没有适合你的工作",
                     "", "wudangFail")
    create_trigger_t("wudangAccept7",
                     "^(> )*宋远桥说道：「暂时没有任务需要做，你过一会儿再来吧",
                     "", "wudangFail")
    create_trigger_t("wudangAccept8",
                     "^(> )*宋远桥说道：「\\D*，你太让我失望了，居然这么点活都干不好，先退下吧",
                     "", "wudangFail")
    create_trigger_t("wudangAccept9",
                     "^(> )*宋远桥说道：「\\D*，你又没在我这里领任务，瞎放弃什么呀",
                     "", "wudangFail")
    create_trigger_t("wudangAccept10",
                     "^(> )*宋远桥说道：「\\D*，这个任务确实比较难完成，下次给你简单的，先退下吧！",
                     "", "wudangFail")
    create_trigger_t("wudangAccepta",
                     "^(> )*宋远桥在你的耳边悄声说道：此人的武功(\\D*)，",
                     "", "wudanglevel")
    create_trigger_t("wudangAcceptb",
                     "^(> )*宋远桥\\D*你快去快回，一切小心啊。",
                     "", "wudangFindGo")
    create_trigger_t("wudangAccept31",
                     "^(> )*宋远桥在你的耳边悄声说道：老头子已追查到(\\D*)是我武当出身，尤为擅长(\\D*)的功夫。",
                     "", "wudangNpc")
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
    create_trigger_t("wudangFight1",
                     "^(> )*(\\D*)「啪」的一声倒在地上", "",
                     "wudangBack")
    create_trigger_t("wudangFight2",
                     "^(> )*(\\D*)大喊一声：不好！！转身几个起落就不见了",
                     "", "wudangBack")
    create_trigger_t("wudangFight3", "^(> )*这里没有(\\D*)。", "",
                     "wudangLost")
    -- create_trigger_t('wudangFight4',
    --                  "^(> )*(\\D*)对着你发出一阵阴笑，说道", '',
    --                  'wudangKillAct')
    create_trigger_t("wudangFight5",
                     "^(> )*(\\D*)大喊一声：老子不奉陪了！转身几个起落就不见了",
                     "", "wudangBack")
    create_trigger_t("wudangFight6",
                     "^>*\\s*一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……",
                     "", "wudangFangqiGo")
    create_trigger_t("wudangFight7", "^(他|她)装备着：$", "", "npcWeapon")
    SetTriggerOption("wudangFight1", "group", "wudangFight")
    SetTriggerOption("wudangFight2", "group", "wudangFight")
    SetTriggerOption("wudangFight3", "group", "wudangFight")
    -- SetTriggerOption("wudangFight4", "group", "wudangFight")
    SetTriggerOption("wudangFight5", "group", "wudangFight")
    SetTriggerOption("wudangFight6", "group", "wudangFight")
    SetTriggerOption("wudangFight7", "group", "wudangFight")
    EnableTriggerGroup("wudangFight", false)
    DeleteTriggerGroup("wudangFinish")
    create_trigger_t("wudangFinish1",
                     "^(> )*宋远桥对着你竖起了右手大拇指，好样的。",
                     "", "wudangFinishT")
    create_trigger_t("wudangFinish2",
                     "^(> )*宋远桥被你气得昏了过去。", "",
                     "wudangFinish")
    create_trigger_t("wudangFinish3", "^(> )*宋远桥说道：「" ..
                         score.name .. "你怎么搞的", "", "wudangFinish")
    SetTriggerOption("wudangFinish1", "group", "wudangFinish")
    SetTriggerOption("wudangFinish2", "group", "wudangFinish")
    SetTriggerOption("wudangFinish3", "group", "wudangFinish")
    EnableTriggerGroup("wudangFinish", false)
    DeleteTriggerGroup("wudangdebug")
    create_trigger_t("wudangdebug1", "^(> )*看来该找机会逃跑了", "",
                     "wudangdebugFind")
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
    if flag.times == 3 and dest.area == "华山村" then
        return go(wudangFindAct, "华山村", "菜地")
    end
    if flag.times == 3 and dest.area == "襄阳城" and dest.room ==
        "山间空地" then
        return go(wudangFindAct, "襄阳郊外", "瀑布")
    end
    if flag.times == 2 and dest.area == "明教" and
        (dest.room == "紫杉林" or string.find(dest.room, "字门")) then
        return go(wudangFindAct, "明教", "练武场")
    end
    if flag.times == 3 and job.area == "扬州城" and job.room == "南门" then
        return go(wudangFindAct, "扬州城", "长江南岸")
    end
    if flag.times == 3 and job.area == "兰州城" and job.room == "西城门" then
        return go(wudangFindAct, "兰州城", "永登")
    end
    --[[if flag.times==3 and job.area=='兰州城' and job.room=='永登' then
		return go(wudangFindAct,'兰州城','西城门')
	end]]
    if flag.times == 3 and job.area == "嵩山少林" and job.room ==
        "罗汉堂" then
        return go(wudangFindAct, "嵩山少林", "罗汉堂五部")
    end
    if flag.times == 3 and job.area == "嵩山少林" and job.room ==
        "般若堂" then
        return go(wudangFindAct, "嵩山少林", "般若堂五部")
    end
    return go(wudangFindAct, job.area, job.room)
end
function wudangFindFail()
    EnableTriggerGroup("wudangFight", false)
    return go(wudangFangqi, "武当山", "三清殿")
end
faintFunc = faintFunc or {}
faintFunc["wudang"] = "wudangFindAgain"
function wudangFaint() return wudangFindFail() end
-- function wdFindFail()
--     locate_finish = 0
--     fastLocate()
--     go(wudangFangqi, "武当山", "三清殿")
-- end
function wudanglevel(n, l, w)
    job.level = w[2]
    -- messageShow('WD job level:【'..job.level..'】')
end
function wudangTriggerDel()
    DeleteTriggerGroup("wudangdebug")
    DeleteTriggerGroup("wudangAccept")
    DeleteTriggerGroup("wudangFight")
    DeleteTriggerGroup("wudangFinish")
    DeleteTriggerGroup("wudangFind")
end
job.list["wudang"] = "武当杀恶贼"
function wudang()
    if hp.shen < 0 then return turnShen("+") end
    wudangTrigger()
    job.level = nil
    job.lost = 0
    job.name = "wudang"
    wait.make(function()
        wait_busy()
        wudangBegin()
    end)
end
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
    flag.idle = nil
    wait.make(function()
        local l, w
        await_go("武当山", "三清殿")
        dis_all()
        wdsearch_get = 0
        flag.wipe = 1
        wudang_canagain = 0
        EnableTriggerGroup("wudangAccept", true)
        repeat
            exe("ask song yuanqiao about job")
            l, w = wait.regexp(
                       "^(> )*(你向宋远桥打听有关|这里没有这个人)",
                       1)
            if l and l:find("这里没有这个人") then
                await_go("武当山", "三清殿")
            end
        until l and l:find("你向宋远桥打听有关")
    end)
end

function wudangBusy()
    EnableTriggerGroup("wudangAccept", false)
    job.last = "wudang"
    return check_bei(wudangBusyDazuo)
end
function wudangBusyDazuo()
    exe("n")
    return prepare_lianxi(wudang)
end
function wudangFail()
    wdgostart = 0
    EnableTriggerGroup("wudangAccept", false)
    if job.level == "已入化境" then
        job.level = "未知"
        messageShow(
            "武当任务：当前接到【已入化境】任务，现在开始化任务等级为【" ..
                job.level .. "】！", "red")
        return check_busy(wudangHuajing_GoAgain)
    end
    wudangTriggerDel()
    job.lost = 0
    -- job.last='wudang'
    setLocateRoomID = "wudang/sanqing"
    if score.party == "华山派" and hp.shen < 0 then return clb() end
    if job.last == "songxin" or job.last == "songmoya" then
        return huashan()
    else
        if wudang_checkfood == 1 then
            wudang_checkfood = 0
            -- for p in pairs(weaponUsave) do
            --     if Bag and not Bag[p] then return songxin() end
            -- end
            if vippoison == 1 then return songxin() end
            if locl.weekday == "四" and (locl.hour == 6 or locl.hour == 7) and
                locl.min <= 55 then return songxin() end
            if mytime <= os.time() and SMYID[score.id] and score.xingyun and
                score.xiangyun ~= "衰" and score.xiangyun ~= "死" then
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
    job.last = "wudang"
    job.target = Trim(w[2])
    job.killer = {}
    job.killer[job.target] = true
    job.where = Trim(w[3])
    jobtarget1 = string.sub(job.target, 1, 8)
    jobtarget2 = string.gsub(job.target, jobtarget1, "")
    job.target = jobtarget2
    -- Note(job.where)
    if string.find(job.where, "周围") then
        local l_cnt = string.find(job.where, "周围")
        job.where = string.sub(job.where, 1, l_cnt - 1)
    end
    if string.find(Trim(w[3]), "里之内") then
        x = string.find(Trim(w[3]), "里之内")
        wd_distance = trans(string.sub(Trim(w[3]), x - 2, x - 1))
    else
        wd_distance = 4
    end
    if string.find(job.where, "神龙岛") then wdtosld = wdtosld + 1 end
    if string.find(job.where, "姑苏慕容") then wdtomr = wdtomr + 1 end
    if string.find(job.where, "燕子坞") then wdtoyzw = wdtoyzw + 1 end
    if string.find(job.where, "曼佗罗山庄") then wdtomtl = wdtomtl + 1 end
    if string.find(job.where, "苏州城闺房") then wdtoszgf = wdtoszgf + 1 end
    if string.find(job.where, "华山石洞") and not Bag["绳子"] then
        job.where = "华山山涧"
        wdtohssd = wdtohssd + 1
    end
    if string.find(job.where, "嵩山少林菜地") then
        job.where = "嵩山少林寺前广场"
        messageShow("地点由嵩山少林菜地改为嵩山少林寺前广场",
                    "violet")
    end
    if string.find(job.where, "心禅堂") then
        wdtoxct = wdtoxct + 1
        job.where = "嵩山少林心禅坪"
    end
    if string.find(job.where, "萧府大厅") or
        string.find(job.where, "萧府书房") or
        string.find(job.where, "萧府厨房") or
        string.find(job.where, "萧府后院") then
        job.where = "萧府萧府大门"
    end
    if string.find(job.where, "苏州城闺房") and not Bag["铜钥匙"] then
        job.where = "苏州城翰林府院"
    end
    if (string.find(job.where, "瘦西湖酒馆") or
        string.find(job.where, "瘦西湖雅楼") or
        string.find(job.where, "珠宝店")) then
        job.where = "扬州城西大街"
    end
    messageShow("武当地点统计：神龙岛【" .. wdtosld ..
                    "】次 ！慕容【" .. wdtomr .. "】次 ！燕子坞【" ..
                    wdtoyzw .. "】次 ！曼佗罗山庄【" .. wdtomtl ..
                    "】次 ！", "cyan")
    messageShow(
        "武当不可到达地点统计：华山石洞【" .. wdtohssd ..
            "】次 ！苏州闺房【" .. wdtoszgf .. "】次 ！心禅堂【" ..
            wdtoxct .. "】次 ！", "cyan")
    job.room, job.area = getAddr(job.where)
end
function wudangNpc(n, l, w)
    EnableTriggerGroup("wudangAccept", false)
    EnableTrigger("wudangAccepta", true)
    EnableTrigger("wudangAcceptb", true)
    sxjob.skills = tostring(w[3])
    -- 开始统计
    wdtongji_cs = wdtongji_cs + 1
end
function wudangFindGo()
    EnableTriggerGroup("wudangAccept", false)
    dest.room = job.room
    dest.area = job.area
    job.wdtime = os.time() + 8 * 60
    exe("set no_kill_ap")
    pfmjineng()
    setLocateRoomID = "wudang/sanqing"
    if not job.room or not path_cal() or
        string.find(job.where, "绝情谷石窟") then
        messageShow("武当任务：任务地点【" .. job.where ..
                        "】不可到达，任务放弃。", "Plum")
        return check_busy(wudangFangqi)
    end
    if skillIgnores[sxjob.skills] then
        messageShow(
            "武当任务：" .. job.target .. "使用的武功是【" ..
                sxjob.skills .. "】不可力敌，任务放弃。")
        return check_busy(wudangFangqi)
    end
    if job.level == "已入化境" then
        return check_busy(wudangHuajing_Fangqi)
    end
    -- messageShow('武当任务概要：任务地点【'..job.where..'】，人物姓名【'..job.target..'】，使用技能【'..sxjob.skills..'】！')
    messageShow("武当任务：现在开始前往【" .. job.where .. "】！")
    return check_busy(wudangFind)
end
function wudangHuajing_Fangqi()
    EnableTriggerGroup("wudangAccept", false)
    messageShow("武当任务：假装放弃已入化境!", "greenyellow")
    return check_busy(wudangFangqiAsk)
end
function wudangHuajing_GoAgain()
    job.wdtime = os.time() + 5 * 60
    -- messageShow('武当任务概要：任务地点【'..job.where..'】，人物姓名【'..job.target..'】，使用技能【'..sxjob.skills..'】！','greenyellow')
    messageShow("武当任务：现在开始前往【" .. job.where .. "】！",
                "greenyellow")
    return check_busy(wudangFind)
end
function wudangFangqiGo()
    DeleteTimer("wudang")
    messageShow("被武当任务NPC打晕了，任务放弃！")
    geta()
    go(wudangFangqi, "武当山", "三清殿")
end
function wudangFangqi()
    wdtongji_fangqi = wdtongji_fangqi + 1
    exe("unset no_kill_ap")
    dis_all()
    kezhiwugongclose()
    flag.idle = nil
    job.level = nil
    job.lost = 0
    nobusy = 0
    EnableTriggerGroup("wudangAccept", true)
    check_bei(wudangFangqiAsk)
end
function wudangFangqiAsk()
    wait.make(function()
        EnableTriggerGroup("wudangAccept", true)
        local l, w
        repeat
            exe("ask song yuanqiao about 放弃")
            l, w = wait.regexp(
                       "^(> )*(你向宋远桥打听有关|这里没有这个人)",
                       1)
            if l and l:find("这里没有这个人") then
                await_go("武当山", "三清殿")
            end
        until l and l:find("你向宋远桥打听有关")
        exe("unset no_kill_ap")
    end)
    setLocateRoomID = "wudang/sanqing"
end
function wudangFind()
    wdgostart = 1
    DeleteTriggerGroup("wudangFind")
    create_trigger_t("wudangFind1", "^\\s*" .. jobtarget1 .. "\\s*" ..
                         jobtarget2 .. "\\((\\D*)\\)", "", "wudangTarget")
    create_trigger_t("wudangFind2", "^(> )*" .. jobtarget2 ..
                         "(对着你发出一阵阴笑，说道：既然被你这个\\D*撞见了，那也就只能算你命短了！|对你说道：\\D*！穷追不舍，既然逃不掉，\\D*我跟你拼了！|对着你说道：嘿嘿！有胆敢跟过来，\\D*不客气了！|看见你走过来，神色有些异常，赶忙低下了头。)",
                     "", "wudangFindKill")
    create_trigger_t("wudangFind3", "^(> )*\\D*" .. jobtarget2 ..
                         "对着你发出一阵阴笑，说道：\\D*，这里地方太小，有种跟\\D*到外面比划比划！",
                     "", "wudangLost")
    -- create_trigger_t('wudangFind4',"^(> )*你对着"..jobtarget2.."一脚踢过去：\\D*，看你往哪里躲！"..jobtarget2.."见势不妙，奋力一挣，向外逃窜。",'','wudangLost')
    SetTriggerOption("wudangFind1", "group", "wudangFind")
    SetTriggerOption("wudangFind2", "group", "wudangFind")
    SetTriggerOption("wudangFind3", "group", "wudangFind")
    SetTriggerOption("wudangFind1", "keep_evaluating", "y")
    flag.times = 1
    flag.robber = false
    local tmppfm = GetVariable("pfmsanqing") -- 古墓派合气最高大招设置防止遇到kezhiwugong.lua识别不了的npc招式
    -- create_alias('kezhiwugongpfm','kezhiwugongpfm','alias pfmpfm '..tmppfm)
    -- exe('kezhiwugongpfm')
    -- if score.id == 'kkfromch' then exe('set 兰花手 蝶舞式') end
    exe("unset wimpy;set wimpycmd pfmpfm\\hp")
    -- if string.find(job.where, "蝴蝶谷") then
    --     return hudiegu()
    -- end
    go(wudangFindAct, job.area, job.room)
end
function wudangdebugFind()
    DeleteTriggerGroup("wudangFind")
    create_trigger_t("wudangFind1", "^\\s*" .. jobtarget1 .. "\\s*" ..
                         jobtarget2 .. "\\((\\D*)\\)", "", "wudangTarget")
    SetTriggerOption("wudangFind1", "group", "wudangFind")
    SetTriggerOption("wudangFind1", "keep_evaluating", "y")
    flag.times = 1
    flag.robber = false
    exe("unset wimpy;set wimpycmd pfmpfm\\hp")
    go(wudangFinddebug, job.area, job.room)
end
function wudangFinddebug()
    EnableTriggerGroup("wudangFind", true)
    DeleteTimer("wudang")
    job.flag()
    exe("look")
    find()
    messageShow(
        "武当任务：开始重新寻找【" .. dest.area .. dest.room ..
            "】的" .. "【" .. job.target .. "】！")
end
function wudangFindAct()
    wdgostart = 0
    DeleteTriggerGroup("wudangFind")
    create_trigger_t("wudangFind1", "^\\s*" .. jobtarget1 .. "\\s*" ..
                         jobtarget2 .. "\\((\\D*)\\)", "", "wudangTarget")
    create_trigger_t("wudangFind2", "^(> )*" .. jobtarget2 ..
                         "(对着你发出一阵阴笑，说道：既然被你这个\\D*撞见了，那也就只能算你命短了！|对你说道：\\D*！穷追不舍，既然逃不掉，\\D*我跟你拼了！|对着你说道：嘿嘿！有胆敢跟过来，\\D*不客气了！|看见你走过来，神色有些异常，赶忙低下了头。)",
                     "", "wudangFindKill")
    create_trigger_t("wudangFind3", "^(> )*\\D*" .. jobtarget2 ..
                         "对着你发出一阵阴笑，说道：\\D*，这里地方太小，有种跟\\D*到外面比划比划！",
                     "", "wudangLost")
    -- create_trigger_t('wudangFind4',"^(> )*你对着"..jobtarget2.."一脚踢过去：\\D*，看你往哪里躲！"..jobtarget2.."见势不妙，奋力一挣，向外逃窜。",'','wudangLost')
    SetTriggerOption("wudangFind1", "group", "wudangFind")
    SetTriggerOption("wudangFind2", "group", "wudangFind")
    SetTriggerOption("wudangFind3", "group", "wudangFind")
    SetTriggerOption("wudangFind1", "keep_evaluating", "y")
    EnableTriggerGroup("wudangFind", true)
    DeleteTimer("wudang")
    job.flag()
    exe("look")
    find()
    messageShow("武当任务：已到达任务地点【" .. job.where ..
                    "】，开始寻找【" .. dest.area .. dest.room ..
                    "】的" .. "【" .. jobtarget1 .. "】" .. "【" ..
                    job.target .. "】！")
end
function wudangFindKill()
    flag.wait = 1
    wdgostart = 0
    dis_all()
    flag.robber = true
    EnableTriggerGroup("wudangdebug", true)
    EnableTrigger("wudangFind1", true)
    exe("look")
    create_timer_s("walkWaitX", 1.0, "wd_look_again")
end
function wd_look_again() exe("look") end
function wudangTarget(n, l, w)
    EnableTriggerGroup("wudangFind", false)
    dis_all()
    EnableTrigger("wudangFind3", true)
    EnableTriggerGroup("wudangdebug", true)
    EnableTriggerGroup("wudangFight", true)
    EnableTrigger("hpheqi1", true)
    job.id = string.lower(w[1])
    job.killer[job.target] = job.id
    DiscardQueue()
    flag.wait = 1
    exe("follow " .. job.id)
    wudangKillAct()
end
function wudangLost(n, l, w)
    wdgostart = 0
    job.lost = job.lost + 1
    if job.lost > 3 then
        job.lost = 0
        jobfailLog()
        messageShow("武当任务：搜索丢失【" .. job.target ..
                        "】三次！回去放弃！", "Plum")
        return check_halt(wudangFindFail)
    end
    -- if job.id==Trim(w[2]) then
    dis_all()
    EnableTriggerGroup("wudangdebug", true)
    messageShow("武当任务：搜索丢失【" .. job.target ..
                    "】！回头再找！", "white")
    return wudangFindAct()
end
function wudangKillAct()
    wdgostart = 0
    flag.robber = true
    kezhiwugong()
    kezhiwugongAddTarget(job.target, job.id)
    fight.time.b = os.time()
    wait.make(function()
        repeat
            exe("set wimpy 100")
            exe("unset no_kill_ap;yield no")
            exe("set wimpycmd pfmpfm\\hp")
            -- exe('set wimpycmd pppp1\\hp')
            exe("follow " .. job.id)
            exe("kick " .. job.id)
            exe("kill " .. job.id)
            local l, w = wait.regexp("^(> )*(你对着" .. job.target ..
                                         "(大喝一声|喝道|猛吼一声|吼道)|加油！加油|这里没有这个人)",
                                     1)
        until l ~= nil
    end)
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
        checkWield()
        -- fpk_prepare()--预防pk的设置，定义在skill.lua中
        check_busy(wudangBackGet)
        fight.time.e = os.time()
        fight.time.over = fight.time.e - fight.time.b
        wdtongji_thistime = fight.time.over
        -- 开始统计
        wdtongji_zdcs = wdtongji_zdcs + 1
        wdtongji_lasttime_lj = wdtongji_lasttime_lj + wdtongji_thistime
        wdtongji_pingjun = string.format("%0.2f",
                                         wdtongji_lasttime_lj / wdtongji_zdcs)
        local l_time = os.time() - tongji.time
        local wd_count = math.modf(wdtongji_zdcs * 3600 / l_time)
        messageShowT("武当任务：【" .. job.target .. "】【" .. job.id ..
                         "】。使用武功【" .. npc_skill ..
                         "】，武功属性【" .. npc_val .. "】。")
        messageShowT("武当任务：搞定" .. "【" .. job.target ..
                         "】！战斗用时:【" .. fight.time.over ..
                         "】秒.平均用时【" .. wdtongji_pingjun ..
                         "】秒。平均每小时成功【" .. wd_count ..
                         "】个任务。")
    end
end
function wudangBackGet()
    geta()
    wipe_kill = 0
    wudangCk = 0
    flag.wipe = 0
    dis_all()
    -- weapon_unwield()
    EnableTriggerGroup("wudangFinish", true)
    EnableTrigger("bags6", true) -- 启动检查失落信笺触发器。
    road.id = nil
    fightoverweapon()
    wait.make(function()
        if needdolost == 1 then await_check_bags() end
        return go(wudangFinishC, "武当山", "三清殿")
    end)
end
function wudangFinishT()
    wdtongji_finish = wdtongji_finish + 1
    wudang_cs = wudang_cs + 1
    print("老宋夸我干得好。")
    -- setLocateRoomID='wudang/sanqing'
end
function wudangFinishC()
    print("等待老宋发奖励。")
    if wudangjobok == 0 and wudangCk < 5 then
        wait.make(function()
            wait.time(1)
            wudangCk = wudangCk + 1
            exe("out;enter")
            return wudangFinishC()
        end)
    else
        return wudangFangqi()
    end
end
function wudangFinish()
    job.name = "idle"
    EnableTriggerGroup("wudangFinish", false)
    wudangTriggerDel()
    wudangjobok = 0
    job.wdtime = 0
    wudangCk = 0
    nobusy = 0
    locate_finish = 0
    job.lost = 0
    flag.times = 1
    wdgostart = 0
    job.last = "wudang"
    kezhiwugongclose()
    -- return check_food()--测试关闭武当任务后check。
    button_smyteam() -- check_heal()里的挪到这里来。
    button_lostletter() -- check_heal()里的挪到这里来。
    locl.room = "三清殿"
    room.id = "wudang/sanqing"
    if wudang_cs > 6 then
        wudang_cs = 0
        exe("score;ask song yuanqiao about 杂役")
    end
    if g_stop_flag == true then
        print("任务结束，游戏暂停")
        g_stop_flag = false
        return disAll()
    end
    return checkPrepare()
end
