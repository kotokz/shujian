function qrySkillEnable(sk)
    local ske = skillEnable[sk]
    -- ain debug
    if not ske then return false end
    local skl = {}
    if type(ske) == "function" then
        if ske() then
            skl = utils.split(ske(), ",")
        else
            return false
        end
    else
        skl = utils.split(ske, ",")
    end
    local skr = {}
    for _, p in pairs(skl) do skr[p] = true end
    if countTab(skr) > 0 then
        return skr
    else
        return false
    end
end

skillEnable = {
    ["anying-fuxiang"] = "dodge",
    ["anran-zhang"] = "strike",
    ["bahuang-gong"] = "force",
    ["baihua-cuoquan"] = "cuff",
    ["banruo-zhang"] = "strike",
    ["beiming-shengong"] = "force",
    ["bihai-chaosheng"] = "force",
    ["canglang-goufa"] = "hook",
    ["canhe-zhi"] = "finger",
    ["caoshang-fei"] = "dodge",
    ["chongling-jian"] = "sword",
    ["chousui-zhang"] = "strike",
    ["chuanyun-tui"] = "leg",
    ["cihang-bian"] = "whip",
    ["cibei-dao"] = "blade",
    ["cuixin-zhang"] = "strike",
    ["cuogu-shou"] = "hand",
    ["dafumo-quan"] = "cuff",
    ["dagou-bang"] = "stick",
    ["damo-jian"] = "sword",
    ["qianzhu-wandushou"] = "hand",
    ["dashou-yin"] = "hand",
    ["ding-dodge"] = "dodge",
    ["duanjia-jianfa"] = "sword",
    ["duanjia-quan"] = "cuff",
    ["dugu-jiujian"] = "sword",
    ["dulong-dafa"] = "force",
    ["duoming-jinhua"] = "throwing",
    ["fanliangyi-dao"] = "blade",
    ["fengmo-zhang"] = "staff",
    ["fengyun-shou"] = "hand",
    ["fuhu-quan"] = "cuff",
    ["fumo-jian"] = "sword",
    ["fuqin-shi"] = "whip",
    ["furong-jinzhen"] = "throwing",
    ["guiyuan-tunafa"] = "force",
    ["hamabu"] = "dodge",
    ["hamagong"] = "force",
    ["hanbing-mianzhang"] = "strike",
    ["hanbing-shenzhang"] = "strike",
    ["hanbing-zhenqi"] = "force",
    ["haotian-zhang"] = "strike",
    ["hansha-sheying"] = "throwing",
    ["hengshan-jian"] = "sword",
    ["hengshan-jianfa"] = "sword",
    ["henshan-jianfa"] = "sword",
    ["huagong-dafa"] = "force",
    ["huagu-mianzhang"] = "strike",
    ["huanmo-wubu"] = "dodge",
    ["huanmo-longtianwu"] = "dodge",
    ["huanyin-zhi"] = "finger",
    ["huashan-jianfa"] = "sword",
    ["huashan-qigong"] = "force",
    ["huashan-shenfa"] = "dodge",
    ["huifeng-bian"] = "whip",
    ["huifeng-jian"] = "sword",
    ["hujia-daofa"] = "blade",
    ["huntian-qigong"] = "force",
    ["hunyuan-zhang"] = "strike",
    ["huoyan-dao"] = "strike",
    ["huyan-qiang"] = "spear",
    ["jieshou-jiushi"] = "hand",
    ["jimie-zhua"] = "claw",
    ["jindao-heijian"] = "sword",
    ["jingang-quan"] = "cuff",
    ["jinshe-jianfa"] = "sword",
    ["jinshe-zhangfa"] = "strike",
    ["jinshe-zhuifa"] = "throwing",
    ["jinwu-daofa"] = "blade",
    ["jinyan-gong"] = "dodge",
    ["jiuyang-shengong"] = "force",
    ["jiuyin-baiguzhua"] = "claw",
    ["jiuyin-shenfa"] = "dodge",
    ["jiuyin-shenzhang"] = "strike",
    ["jiuyin-shenzhua"] = "claw",
    ["jiuyin-zhengong"] = "force",
    ["juehu-shou"] = "hand",
    ["kaishan-fu"] = "axe",
    ["kaishan-zhang"] = "strike",
    ["kongming-quan"] = "cuff",
    ["kuaihuo-zhang"] = "strike",
    ["kuihua-feiying"] = "dodge",
    ["kuihua-mogong"] = "force",
    ["kuihua-shengong"] = "force",
    ["kunlun-zhang"] = "strike",
    ["kurong-changong"] = "force",
    ["lanhua-shou"] = "hand",
    ["lengquan-shengong"] = "force",
    ["liangyi-jian"] = "sword",
    ["lianhua-zhang"] = "strike",
    ["lietian-fu"] = "axe",
    ["liehuo-jian"] = "sword",
    ["lieyan-dao"] = "blade",
    ["lingbo-weibu"] = "dodge",
    ["lingshe-bianfa"] = "whip",
    ["lingshe-quanfa"] = "cuff",
    ["lingxu-bu"] = "dodge",
    ["linji-zhuang"] = "force",
    ["liuhe-daofa"] = "blade",
    ["liuyang-zhang"] = "strike",
    ["liuye-daofa"] = "blade",
    ["longxiang-boruo"] = "force",
    ["longzhua-gong"] = "claw",
    ["luohan-quan"] = "cuff",
    ["luoying-zhang"] = "strike",
    ["mantian-huayu"] = "throwing",
    ["meinu-quanfa"] = "cuff",
    ["miaojia-jianfa"] = "sword",
    ["murong-daofa"] = "blade",
    ["murong-jianfa"] = "sword",
    ["nianhua-zhi"] = "finger",
    ["ningxue-shenzhao"] = "claw",
    ["ningxue-shenzhua"] = "claw",
    ["pangen-fu"] = "axe",
    ["pixie-jian"] = "sword",
    ["piaomiao-shenfa"] = "dodge",
    ["piaoyi-bu"] = "dodge",
    ["piaoyi-shenfa"] = "dodge",
    ["pinxu-lingfeng"] = "dodge",
    ["pomopima-jian"] = "sword",
    ["poyu-quan"] = "cuff",
    ["qiantian-yiyang"] = "force",
    ["qianye-shou"] = "hand",
    ["qianzhu-wandushou"] = "hand",
    ["qingyan-zhang"] = "strike",
    ["qishang-quan"] = "cuff",
    ["qixian-wuxingjian"] = "sword",
    ["quanzhen-jianfa"] = "sword",
    ["ranmu-daofa"] = "blade",
    ["riyue-bian"] = "whip",
    ["ruyi-dao"] = "blade",
    ["ruying-suixingtui"] = "leg",
    ["sanhua-zhang"] = "strike",
    ["sanyin-zhua"] = "claw",
    ["shaolin-shenfa"] = "dodge",
    ["shaolin-tantui"] = "leg",
    ["shenghuo-lingfa"] = "dagger",
    ["shenghuo-shengong"] = "force",
    ["shenlong-tuifa"] = "leg",
    ["shenxing-baibian"] = "dodge",
    ["shenyuan-gong"] = "force",
    ["shenzhao-jing"] = "force",
    ["shexing-diaoshou"] = "hand",
    ["shuishangpiao"] = "dodge",
    ["sixiang-zhang"] = "strike",
    ["songshan-jian"] = "sword",
    ["songshan-qigong"] = "force",
    ["songyang-bian"] = "whip",
    ["songyang-shou"] = "hand",
    ["songyang-zhang"] = "strike",
    ["suibo-zhuliu"] = "dodge",
    ["suohou-shou"] = "hand",
    ["taiji-jian"] = "sword",
    ["taiji-quan"] = "cuff",
    ["taiji-shengong"] = "force",
    ["taishan-jianfa"] = "sword",
    ["taixuan-gong"] = "strike",
    ["taizu-quan"] = "cuff",
    ["tangshi-jianfa"] = "sword",
    ["tanzhi-shentong"] = "finger",
    -- ["tanzhi-shentong"] = "throwing",
    ["taxue-wuhen"] = "dodge",
    ["tenglong-bifa"] = "dagger",
    ["tianmo-dao"] = "blade",
    ["tianmo-gong"] = "force",
    ["tianmo-jian"] = "sword",
    ["tianmo-shou"] = "hand",
    ["tianmo-zhang"] = "strike",
    ["tiangang-zhang"] = "strike",
    ["tianlong-xiang"] = "dodge",
    ["tianluo-diwang"] = "hand",
    ["tianshan-zhang"] = "staff",
    ["tianwang-zhua"] = "claw",
    ["tianyu-qijian"] = "sword",
    ["tiezhang-zhangfa"] = "strike",
    ["tiyunzong"] = "dodge",
    ["weituo-chu"] = "club",
    ["wudang-mianzhang"] = "strike",
    ["wudang-quan"] = "cuff",
    ["wudu-yanluobu"] = "dodge",
    ["wuhu-duanmendao"] = "blade",
    ["wushang-dali"] = "staff",
    ["wuxiang-zhi"] = "finger",
    ["wuyue-jianfa"] = "sword",
    ["xiangfu-lun"] = "hammer",
    ["xianglong-zhang"] = "strike",
    ["xiangmo-chu"] = "hammer",
    ["xiantian-gong"] = "force",
    ["xiaohun-zhang"] = "strike",
    ["xiaoyaoyou"] = "dodge",
    ["xiaoyao-jian"] = "sword",
    ["xingyi-zhang"] = "strike",
    ["xiuluo-dao"] = "blade",
    ["xixing-dafa"] = "force",
    ["xuanfeng-tui"] = "leg",
    ["xuangong-quan"] = "cuff",
    ["xuanming-shenzhang"] = "strike",
    ["xuantian-wuji"] = "force",
    ["xuantian-zhi"] = "finger",
    ["xuantie-jianfa"] = "sword",
    ["xuanxu-daofa"] = "blade",
    ["xuanyin-jian"] = "sword",
    ["xuedao-jing"] = "blade",
    ["xunlei-jian"] = "sword",
    ["yangjia-qiang"] = "spear",
    ["yanling-shenfa"] = "dodge",
    ["yanxing-daofa"] = "blade",
    ["yijin-jing"] = "force",
    -- ["yingou-bifa"] = "brush",
    ["yinlong-bian"] = "whip",
    ["yingshe-shengsibo"] = "claw",
    ["yinsuo-jinling"] = "whip",
    ["yitian-tulong"] = "sword",
    ["yiyang-zhi"] = "finger",
    ["yizhi-chan"] = "finger",
    ["yinyun-ziqi"] = "force",
    ["youlong-bian"] = "whip",
    ["youlong-shenfa"] = "dodge",
    ["youming-zhao"] = "claw",
    ["yuenu-jian"] = "sword",
    ["yueying-wubu"] = "dodge",
    ["yunu-jianfa"] = "sword",
    ["yunu-xinjing"] = "force",
    ["yunu-shenfa"] = "dodge",
    ["yuxiao-jian"] = "sword",
    ["yuxue-dunxing"] = "dodge",
    ["zhaixingshu"] = "dodge",
    ["zhemei-shou"] = "hand",
    ["zhenshan-mianzhang"] = "strike",
    ["zhentian-quan"] = "cuff",
    ["zhong-qiang"] = "spear",
    ["zhongyuefeng"] = "dodge",
    ["zhuihun-gou"] = "hook",
    ["zhusha-zhang"] = "strike",
    ["zixia-gong"] = "force",
    ["zuibaxian"] = "dodge",
    ["zui-gun"] = "club",
    ["tianmo-gun"] = "club",
    ["qixian-wuxingjian"] = "sword"
}

skillHubei = {
    ["longzhua-gong"] = "yizhi-chan",
    ["yizhi-chan"] = "longzhua-gong",
    ["jingang-quan"] = "banruo-zhang",
    ["banruo-zhang"] = "jingan-quan",
    ["ruiying-suixingtui"] = "qianye-shou",
    ["qianye-shou"] = "ruying-suixingtui",
    ["sanhua-zhang"] = "nianhua-zhi",
    ["nianhua-zhi"] = "sanhua-zhang",
    ["xuanfeng-tui"] = "luoying-zhang",
    ["luoying-zhang"] = "xuanfeng-tui",
    ["wuxiang-zhi"] = "luohan-quan",
    ["luohan-quan"] = "wuxiang-zhi"
}

skillPfm = {}

masterRoom = {
    -- 少林派
    ["无名老僧"] = "嵩山少林里屋",
    ["渡难"] = "嵩山少林金刚伏魔圈",
    ["渡劫"] = "嵩山少林金刚伏魔圈",
    ["渡厄"] = "嵩山少林金刚伏魔圈",
    -- 桃花岛
    ["陆乘风"] = "归云庄书房",
    ["陆冠英"] = "归云庄前厅",
    ["黄药师"] = "桃花岛积翠亭",
    -- 华山派
    ["岳不群"] = "华山正气堂",
    ["宁中则"] = "华山正气堂",
    ["穆人清"] = "华山石屋",
    -- ["封不平"]   = "华山山涧",
    -- ["从不弃"]   = "华山山涧",
    -- ["成不忧"]   = "华山山涧",

    -- 武当派
    ["谷虚道长"] = "武当山复真观",
    ["俞岱岩"] = "武当山炼丹房",
    ["莫声谷"] = "武当山天乙真庆宫",
    ["宋远桥"] = "武当山三清殿",
    ["张三丰"] = "武当山后山小院",
    ["俞莲舟"] = "武当山小径"
}

local pker = {}
local pker_name = "none"
local pker_id = "none"

-- create_triggerex_lvl('job_exp9',"^(> )*【队伍】(\\D*)\\((\\D*)\\)：gblu start",'','gbluTeamStart',95)

-- 如如果你要和%x~((%w)~)性命相搏，请你也对这个人下一次 kill 指令。
function Openfpk()
    flag.pk = 0
    EnableTriggerGroup("pk", false)
    DeleteTriggerGroup("pk")
    create_trigger_t("pk1",
                     "^(> )*如果你要和(\\D*)\\((\\D*)\\)性命相搏，",
                     "", "fpk")
    create_trigger_t("pk2", "^(> )*你无法马上向(\\D*)发动攻击。", "",
                     "fpk1")
    SetTriggerOption("pk1", "group", "pk")
    -- SetTriggerOption("pkjc","group","pk")
    -- EnableTriggerGroup("pk",true)
    print("fpk load finish")
    print("感谢无法风！无法风是最棒的！")
    return exe("wink")
end
function fpk1(n, l, w)
    delete_all_timers()
    job.name = "pk"
    flag.pk = 1
    pker_name = tostring(w[2])
    pker_id = GetVariable("pk_target")
    EnableTrigger("hpheqi1", true)
    EnableTriggerGroup("hp", true)
    EnableTriggerGroup("fight", true)
    create_alias("pkpfm_kezhi", "pkpfm_kezhi",
                 "alias pkpfm " .. GetVariable("pkpfm"))
    exe("pkpfm_kezhi")
    create_alias("mypfm_kezhi", "mypfm_kezhi",
                 "alias mypfm " .. GetVariable("mypfm"))
    exe("mypfm_kezhi")
    exe("set wimpy 100;yield no")
    exe("set wimpycmd pkpfm\\mypfm\\hp")
    kezhiwugong()
    kezhiwugongAddTarget(pker_name, pker_id)
end
function fpk(n, l, w)
    job.name = "pk"
    flag.pk = 1
    local tl = GetTriggerList()
    if tl then for k, v in ipairs(tl) do EnableTrigger(v, false) end end
    delete_all_timers()
    pker_name = "none"
    pker_id = "none"
    pker_name = w[2]
    pker_id = string.lower(w[3])
    locate()
    -- print(locl.area..' '..locl.room)
    EnableTriggerGroup("pka", false)
    -- DeleteTriggerGroup("pk2")
    -- EnableTriggerGroup("pk3",false)
    -- EnableTriggerGroup("pk4",false)
    -- DeleteTriggerGroup("pk2")
    -- DeleteTriggerGroup("pk3")
    DeleteTriggerGroup("pka")

    create_trigger_t("pkc",
                     "^(> )*你和(\\D*)一碰面，二话不说就打了起来",
                     "", "fpk2")
    --	create_triggerex_lvl('pk1',"^(> )*(你和(\\D*)一碰面，二话不说就打了起来|"..pker_name.."喝道：「你，我们的帐还没算完，看招！」|"..pker_name.."一眼瞥见你，「哼」的一声冲了过来！|"..pker_name.."一见到你，愣了一愣，大叫：「我宰了你！」|"..pker_name.."和你仇人相见分外眼红，立刻打了起来！|你喝道：「"..pker_name.."，看招！」|"..pker_name.."神志迷糊，脚下一个不稳，倒在地上昏了过去。|"..pker_name.."「啪」的一声倒在地上，挣扎着抽动了几下就死了。)",'','fpk2',95)
    create_trigger_t("pk2", "^(> )*" .. pker_name ..
                         "喝道：「你，我们的帐还没算完，看招！」",
                     "", "fpk2")
    create_trigger_t("pk3", "^(> )*" .. pker_name ..
                         "一眼瞥见你，「哼」的一声冲了过来！",
                     "", "fpk2")
    create_trigger_t("pk4", "^(> )*" .. pker_name ..
                         "一见到你，愣了一愣，大叫：「我宰了你！」",
                     "", "fpk2")
    create_trigger_t("pk5", "^(> )*" .. pker_name ..
                         "和你仇人相见分外眼红，立刻打了起来！",
                     "", "fpk2")
    create_trigger_t("pk6",
                     "^(> )*你喝道：「" .. pker_name .. "，看招！」",
                     "", "fpk2")
    create_trigger_t("pk7", "^(> )*" .. pker_name ..
                         "神志迷糊，脚下一个不稳，倒在地上昏了过去。",
                     "", "fpk3")
    create_trigger_t("pk8", "^(> )*" .. pker_name ..
                         "「啪」的一声倒在地上，挣扎着抽动了几下就死了。",
                     "", "fpk4")
    create_trigger_t("pkz",
                     "^(> )*你「啪」的一声倒在地上，挣扎着抽动了几下就死了。",
                     "", "fpk4")

    SetTriggerOption("pkc", "group", "pka")
    SetTriggerOption("pk2", "group", "pka")
    SetTriggerOption("pk3", "group", "pka")
    SetTriggerOption("pk4", "group", "pka")
    SetTriggerOption("pk5", "group", "pka")
    SetTriggerOption("pk6", "group", "pka")
    SetTriggerOption("pk7", "group", "pka")
    SetTriggerOption("pk8", "group", "pka")
    SetTriggerOption("pkz", "group", "pka")

    --[[   if GetVariable("pkpfm") then
       perform.pre=GetVariable("pkpfm")
    end
   
    local l_pfm=perform.pre

   l_pfm = perform.pre
  -- if perform and perform.skill and perform.pre then
   if perform.pre then
      create_alias('pkset','pkset','alias pkpfm '.. l_pfm)
      exe('pkset')
   end                   ]]
    EnableTrigger("hpheqi1", true)
    EnableTriggerGroup("hp", true)
    EnableTriggerGroup("fight", true)
    create_alias("pkpfm_kezhi", "pkpfm_kezhi",
                 "alias pkpfm " .. GetVariable("pkpfm"))
    exe("pkpfm_kezhi")
    create_alias("mypfm_kezhi", "mypfm_kezhi",
                 "alias mypfm " .. GetVariable("mypfm") .. " " .. pker_id)
    exe("mypfm_kezhi")
    exe("set wimpy 100;yield no")
    exe("set wimpycmd pkpfm\\mypfm\\hp")
    logfile = GetInfo(57) .. "log/pk_fpk_" .. score.id .. " VS " .. pker_id ..
                  "_" .. os.time() .. ".txt"
    OpenLog(logfile, false)
    print("开始记录log到", logfile)
    locate()
    exe(
        "chat 有人pk我，pker:" .. pker_name .. pker_id .. "在" .. locl.area ..
            " " .. locl.room)
    exe("pkpfm")
    exe("kill " .. pker_id)
    kezhiwugong()
    kezhiwugongAddTarget(pker_name, pker_id)
    print(pker_name .. pker_id)
    --  exe('pfmpfm')
    --	return exe('kill '..pker_id)
end

function fpk2()
    -- 你和混世魔王一碰面，二话不说就打了起来！
    --	EnableTriggerGroup("pk3",false)
    --	EnableTriggerGroup("pk4",false)
    --	DeleteTriggerGroup("pk3")
    --	DeleteTriggerGroup("pk4")
    --	create_trigger_t('pk7',"^(> )*"..pker_name.."神志迷糊，脚下一个不稳，倒在地上昏了过去。",'','fpk3')
    --	create_trigger_t('pk8',"^(> )*"..pker_name.."「啪」的一声倒在地上，挣扎着抽动了几下就死了。",'','fpk4')
    --  SetTriggerOption("pk7","group","pk3")
    --  SetTriggerOption("pk8","group","pk4")
    exe("chat 注意有pker对我下手:" .. pker_name .. pker_id .. "在" ..
            locl.area .. " " .. locl.room)
    return exe("kill " .. pker_id)
end
function fpk3()
    -- 神志迷糊，脚下一个不稳，倒在地上昏了过去
    --	EnableTriggerGroup("pk3",false)
    --	EnableTriggerGroup("pk4",false)
    --	DeleteTriggerGroup("pk3")
    --	DeleteTriggerGroup("pk4")
    --	create_trigger_t('pk7',"^(> )*"..pker_name.."神志迷糊，脚下一个不稳，倒在地上昏了过去。",'','fpk3')
    --	create_trigger_t('pk8',"^(> )*"..pker_name.."「啪」的一声倒在地上，挣扎着抽动了几下就死了。",'','fpk4')
    --	create_trigger_t('pk9','^(> )*你手上这件兵器无锋无刃','','cut_corpse2')

    --  SetTriggerOption("pk7","group","pk3")
    --  SetTriggerOption("pk8","group","pk4")
    --  SetTriggerOption("pk9","group","pk4")
    exe("chat pker晕倒了:" .. pker_name .. pker_id)
    exe("kill " .. pker_id)
    kezhiwugongclose()
end

function fpk4()
    job.name = "idle"
    kezhiwugongclose()
    exe("heng corpse")
    CloseLog()
    Openfpk()
    return check_bei(main)
end
function pk_cut_corpse1()
    exe("heng corpse")
    return exe("heng corpse")
end

function pk_cut_corpse2()
    weapon_unwield()
    weaponWieldCut()
    return exe("heng corpse")
end

function dazuo_lianxi_auto()
    tmp_lxskill = "bei none;"
    for p in pairs(Bag) do
        if Bag[p].kind and Bag[p].fullid ~= "coin_money" and
            weaponKind[Bag[p].kind] then
            local _, l_cnt = isInBags(Bag[p].fullid)
            for i = 1, l_cnt do
                tmp_lxskill =
                    tmp_lxskill .. "unwield " .. Bag[p].fullid .. " " .. i ..
                        ";"
            end
        end
    end
    lianxi_times = GetVariable("mycishu")
    local shenqi_id = weaponGetShenqiId()

    local noneed = GetVariable("noneedlian") or ""
    for p in pairs(skills) do
        if noneed:find(p, 1, true) == nil and skillEnable[p] and
            (skills[p].lvl < hp.pot_max - 100 or
                (skills[p].lvl == hp.pot_max - 100 and skills[p].pot <
                    (skills[p].lvl ^ 2))) then
            if skillEnable[p] == "force" then
                tmp_lxskill = tmp_lxskill .. "lian force " .. lianxi_times ..
                                  ";"
            end
            if skillEnable[p] == "dodge" then
                tmp_lxskill = tmp_lxskill .. "jifa dodge " .. p ..
                                  ";lian dodge " .. lianxi_times ..
                                  ";yun jingli;"
            end
            if skillEnable[p] == "finger" then
                tmp_lxskill = tmp_lxskill .. "jifa finger " .. p ..
                                  ";lian finger " .. lianxi_times ..
                                  ";yun jingli;"
            end
            if skillEnable[p] == "cuff" then
                tmp_lxskill =
                    tmp_lxskill .. "jifa cuff " .. p .. ";lian cuff " ..
                        lianxi_times .. ";yun jingli;"
            end
            if skillEnable[p] == "strike" then
                tmp_lxskill = tmp_lxskill .. "jifa strike " .. p ..
                                  ";lian strike " .. lianxi_times ..
                                  ";yun jingli;"
            end
            if skillEnable[p] == "hand" then
                tmp_lxskill =
                    tmp_lxskill .. "jifa hand " .. p .. ";lian hand " ..
                        lianxi_times .. ";yun jingli;"
            end
            if skillEnable[p] == "leg" then
                tmp_lxskill = tmp_lxskill .. "lian leg " .. lianxi_times ..
                                  ";yun jingli;"
            end
            if skillEnable[p] == "sword" then
                if shenqi_id then
                    tmp_lxskill =
                        tmp_lxskill .. "jifa sword " .. p .. ";wield " ..
                            shenqi_id .. ";uweapon shape " .. shenqi_id ..
                            " sword;lian sword " .. lianxi_times .. ";unwield " ..
                            shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill .. "jifa sword " .. p ..
                                      ";wield sword;uweapon shape sword sword;lian sword " ..
                                      lianxi_times ..
                                      ";unwield sword;yun jingli;"
                end
            end
            if skillEnable[p] == "whip" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield " .. shenqi_id ..
                                      ";uweapon shape " .. shenqi_id ..
                                      " whip;lian whip " .. lianxi_times ..
                                      ";unwield " .. shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill ..
                                      "wield whip;uweapon shape whip whip;lian whip " ..
                                      lianxi_times ..
                                      ";unwield whip;yun jingli;"
                end
            end
            if skillEnable[p] == "axe" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield axe;uweapon shape " ..
                                      shenqi_id .. " axe;lian axe " ..
                                      lianxi_times .. ";unwield " .. shenqi_id ..
                                      ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill ..
                                      "wield axe;uweapon shape axe axe;lian axe " ..
                                      lianxi_times .. ";unwield axe;yun jingli;"
                end
            end
            if skillEnable[p] == "claw" then
                tmp_lxskill =
                    tmp_lxskill .. "jifa claw " .. p .. ";lian claw " ..
                        lianxi_times .. ";yun jingli;"
            end
            if skillEnable[p] == "throwing" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield " .. shenqi_id ..
                                      ";uweapon shape " .. shenqi_id ..
                                      " coin;lian throwing " .. lianxi_times ..
                                      ";unwield " .. shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill .. "wield coin;lian throwing " ..
                                      lianxi_times ..
                                      ";unwield coin;yun jingli;"
                end
            end
            if skillEnable[p] == "blade" then
                if shenqi_id then
                    tmp_lxskill =
                        tmp_lxskill .. "jifa blade " .. p .. ";wield " ..
                            shenqi_id .. ";uweapon shape " .. shenqi_id ..
                            " blade;lian blade " .. lianxi_times .. ";unwield " ..
                            shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill .. "jifa blade " .. p ..
                                      ";wield blade;uweapon shape blade blade;lian blade " ..
                                      lianxi_times ..
                                      ";unwield blade;yun jingli;"
                end
            end
            if skillEnable[p] == "stick" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield " .. shenqi_id ..
                                      ";uweapon shape " .. shenqi_id ..
                                      " stick;lian stick " .. lianxi_times ..
                                      ";unwield " .. shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill ..
                                      "wield stick;uweapon shape stick stick;lian stick " ..
                                      lianxi_times ..
                                      ";unwield stick;yun jingli;"
                end
            end
            if skillEnable[p] == "staff" then
                if shenqi_id then
                    tmp_lxskill =
                        tmp_lxskill .. "jifa staff " .. p .. ";wield " ..
                            shenqi_id .. ";uweapon shape " .. shenqi_id ..
                            " staff;lian staff " .. lianxi_times .. ";unwield " ..
                            shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill .. "jifa staff " .. p ..
                                      ";wield staff;uweapon shape staff staff;lian staff " ..
                                      lianxi_times ..
                                      ";unwield staff;yun jingli;"
                end
            end
            if skillEnable[p] == "club" then
                if shenqi_id then
                    tmp_lxskill =
                        tmp_lxskill .. "jifa club " .. p .. ";wield " ..
                            shenqi_id .. ";uweapon shape " .. shenqi_id ..
                            " club;lian club " .. lianxi_times .. ";unwield " ..
                            shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill .. "jifa club " .. p ..
                                      ";wield club;uweapon shape club club;lian club " ..
                                      lianxi_times ..
                                      ";unwield club;yun jingli;"
                end
            end
            if skillEnable[p] == "hammer" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield " .. shenqi_id ..
                                      ";uweapon shape " .. shenqi_id ..
                                      " hammer;lian hammer " .. lianxi_times ..
                                      ";unwield " .. shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill ..
                                      "wield hammer;uweapon shape hammer hammer;lian hammer " ..
                                      lianxi_times ..
                                      ";unwield hammer;yun jingli;"
                end
            end
            if skillEnable[p] == "hook" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield " .. shenqi_id ..
                                      ";uweapon shape " .. shenqi_id ..
                                      " hook;lian hook " .. lianxi_times ..
                                      ";unwield " .. shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill ..
                                      "wield hook;uweapon shape hook hook;lian hook " ..
                                      lianxi_times ..
                                      ";unwield hook;yun jingli;"
                end
            end
            if skillEnable[p] == "dagger" then
                if shenqi_id then
                    tmp_lxskill = tmp_lxskill .. "wield " .. shenqi_id ..
                                      ";uweapon shape " .. shenqi_id ..
                                      " dagger;lian dagger " .. lianxi_times ..
                                      ";unwield " .. shenqi_id .. ";yun jingli;"
                else
                    tmp_lxskill = tmp_lxskill ..
                                      "wield dagger;uweapon shape dagger dagger;lian dagger " ..
                                      lianxi_times ..
                                      ";unwield dagger;yun jingli;"
                end
            end
        end
    end
    if weapon.first and Bag[weapon.first] then
        tmp_lxskill = tmp_lxskill .. "wield " .. Bag[weapon.first].fullid .. ";"
    end
    tmp_lxskill = tmp_lxskill .. "hp;unset 积蓄;i"
end
function set_sxlian()
    dazuo_lianxi_auto()
    create_alias("sx1lian", "sx1lian", "alias sxlian " .. tmp_lxskill)
    Execute("sx1lian")
end
