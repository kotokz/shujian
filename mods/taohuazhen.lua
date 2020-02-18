n_cnt = 0
s_cnt = 0
w_cnt = 0
e_cnt = 0
_bagua_con = 0
sw_cur = 0
zhou_visited = 0
hb_ok = 1
_dir = ''
_bagua_des = ''
quest_name = ''
quest_learned = ''
function thz_triggers()
    DeleteTriggerGroup('thzdazuo')
    create_trigger_t('thzdazuo1',
                     '^(> )*(过了片刻，你感觉自己已经将玄天无极神功|你将寒冰真气按周天之势搬运了一周|你只觉真力运转顺畅，周身气力充沛|你将纯阳神通功运行完毕|你只觉神元归一，全身精力弥漫|你将内息走了个一个周天|你将内息游走全身，但觉全身舒畅|你将真气逼入体内，将全身聚集的蓝色气息|你将紫气在体内运行了一个周天|你运功完毕，站了起来|你一个周天行将下来，精神抖擞的站了起来|你分开双手，黑气慢慢沉下|你将内息走满一个周天，只感到全身通泰|你真气在体内运行了一个周天，冷热真气收于丹田|你真气在体内运行了一个周天，缓缓收气于丹田|你双眼微闭，缓缓将天地精华之气吸入体内|你慢慢收气，归入丹田，睁开眼睛|你将内息又运了一个小周天，缓缓导入丹田|你感觉毒素越转越快，就快要脱离你的控制了！|你将周身内息贯通经脉，缓缓睁开眼睛，站了起来|你呼翕九阳，抱一含元，缓缓睁开双眼|你吸气入丹田，真气运转渐缓，慢慢收功|你将真气在体内沿脉络运行了一圈，缓缓纳入丹田|你将内息在体内运行十二周天，返回丹田|你将内息走了个小周天，流回丹田，收功站了起来|过了片刻，你已与这大自然融合在一起，精神抖擞的站了起|你感到自己和天地融为一体，全身清爽如浴春风，忍不住舒畅的呻吟了一声，缓缓睁开了眼睛)',
                     '', 'thz_thd')
    create_trigger_t('thzdazuo2',
                     '^(> )*一股暖流发自丹田流向全身，慢慢地你又恢复了知觉……',
                     '', 'thz_error')
    SetTriggerOption('thzdazuo1', 'group', 'thzdazuo')
    SetTriggerOption('thzdazuo2', 'group', 'thzdazuo')
    DeleteTriggerGroup('shizi')
    create_trigger_t('shizi1', '^(> )*\\s*(\\D*)颗石子\\(Shizi\\)', '',
                     'thz_szcnt')
    SetTriggerOption('shizi1', 'group', 'shizi')
    EnableTriggerGroup('shizi', false)
    DeleteTriggerGroup('thzthd')
    create_trigger_t('thzthd',
                     '^(> )*船「咣」的一声撞到了岸边，你急忙纵身跳上了岸。',
                     '', 'thz_thd')
    SetTriggerOption('thzthd', 'group', 'thzthd')
    DeleteTriggerGroup('thzcal')
    create_trigger_t('thzcal1', '^(> )*\\s*(\\D*)颗石子\\(Shizi\\)', '',
                     'thz_cal1')
    SetTriggerOption('thzcal1', 'group', 'thzcal')
    EnableTriggerGroup('thzcal', false)
    DeleteTriggerGroup('thzact')
    create_trigger_t('thzact1', '^(> )*桃花阵\\s*-', '', 'thz_act1')
    create_trigger_t('thzact2', '^(> )*你丢下一些石子。', '',
                     'thz_north')
    create_trigger_t('thzact3', '^(> )*桃花阵\\s*-', '', 'thz_steps')
    SetTriggerOption('thzact1', 'group', 'thzact')
    SetTriggerOption('thzact2', 'group', 'thzact')
    SetTriggerOption('thzact3', 'group', 'thzact')
    EnableTriggerGroup('thzact', false)
    DeleteTriggerGroup('thzout')
    create_trigger_t('thzout1', '^(> )*小院\\s*-', '', 'thz_out')
    SetTriggerOption('thzout1', 'group', 'thzout')
    DeleteTriggerGroup('thzpath')
    create_trigger_t('thzpath1',
                     '^(> )*一个奇怪的铁八卦，上面按顺时针顺序排列着：(\\D*)。',
                     '', 'thz_path')
    SetTriggerOption('thzpath1', 'group', 'thzpath')
    DeleteTriggerGroup('thzzhou')
    create_trigger_t('thzzhou1', '^(> )*你要对谁做这个动作？', '',
                     'thz_wrong_path')
    create_trigger_t('thzzhou2',
                     '^(> )*你冲上前去，激动地紧紧握住周伯通的双手，哽咽着说不出话来。',
                     '', 'thz_correct_path')
    SetTriggerOption('thzzhou1', 'group', 'thzzhou')
    SetTriggerOption('thzzhou2', 'group', 'thzzhou')
    DeleteTriggerGroup('thzask')
    create_trigger_t('thzask1', '^(> )*周伯通说道：「(\\D*)」', '',
                     'thz_zhouask')
    create_trigger_t('thzask2', '^(> )*你给周伯通一个饭盒。', '',
                     'thz_jyzj1')
    create_trigger_t('thzask3',
                     '^(> )*周伯通拉着你说道：“乖乖的听我说故事吧。”',
                     '', 'thz_jyzj2')
    create_trigger_t('thzask4',
                     '^(> )*周伯通看你不问后来怎样，便赌气不说了。',
                     '', 'thz_jyzj3')
    create_trigger_t('thzask5',
                     '^(> )*周伯通说完故事，又无聊的问道：“兄弟，有什么好玩的武功么？”',
                     '', 'thz_jyzj4')
    create_trigger_t('thzask6',
                     '^(> )*你重新抄录了一份九阴真经的上卷。',
                     '', 'thz_jyzjx')
    create_trigger_t('thzask7',
                     '^(> )*你伸出两根食指在地上划画，但画出来的方块有点象圆圈，圆圈又有点象方块。',
                     '', 'thz_fangyuan')
    create_trigger_t('thzask8', '^(> )*周伯通露出迷惑的神情。', '',
                     'thz_jywait')
    SetTriggerOption('thzask1', 'group', 'thzask')
    SetTriggerOption('thzask2', 'group', 'thzask')
    SetTriggerOption('thzask3', 'group', 'thzask')
    SetTriggerOption('thzask4', 'group', 'thzask')
    SetTriggerOption('thzask5', 'group', 'thzask')
    SetTriggerOption('thzask6', 'group', 'thzask')
    SetTriggerOption('thzask7', 'group', 'thzask')
    SetTriggerOption('thzask8', 'group', 'thzask')
    DeleteTriggerGroup('thzqok')
    create_trigger_t('thzqok1', '^(> )*你学会了「左右互搏」。', '',
                     'thz_questdone1')
    create_trigger_t('thzqok2', '^(> )*你的「空明拳」进步了！', '',
                     'thz_questdone2')
    create_trigger_t('thzqok3',
                     '^(> )*你将九阴真经的上卷小心的抄录下来。',
                     '', 'thz_questdone3')
    SetTriggerOption('thzqok1', 'group', 'thzqok')
    SetTriggerOption('thzqok2', 'group', 'thzqok')
    SetTriggerOption('thzqok3', 'group', 'thzqok')
    DeleteTriggerGroup('thz_leave')
    create_trigger_t('thzleave1',
                     '^(> )*黄药师一招手，喊过一个艄公来：载这位壮士回陆地。',
                     '', 'thz_leave')
    SetTriggerOption('thzleave1', 'group', 'thzleave')
end
function thz_triggers_remove()
    DeleteTriggerGroup('thzdazuo')
    DeleteTriggerGroup('shizi')
    DeleteTriggerGroup('thzthd')
    DeleteTriggerGroup('thzcal')
    DeleteTriggerGroup('thzact')
    DeleteTriggerGroup('thzout')
    DeleteTriggerGroup('thzpath')
    DeleteTriggerGroup('thzzhou')
    DeleteTriggerGroup('thzask')
    DeleteTriggerGroup('thzqok')
    DeleteTriggerGroup('thz_leave')
end
function thz_bfstart()
    create_alias_s('th_start', 'th_start', 'thz_start')
    print('玩家请阅读以下内容：')
    ColourNote('red', 'black',
               '①：解谜非桃花岛上的各种前置条件并未包括，请玩家先做好准备工作')
    ColourNote('red', 'black',
               '①：另外确保你的潜能足够进行解谜，本模块不另行检查')
    ColourNote('skyblue', 'black',
               '②：不论是否桃花岛弟子都可以使用')
    ColourNote('skyblue', 'black',
               '③：到达桃花岛后如时间是晚上将会打坐练功等待天亮再进阵。')
    ColourNote('skyblue', 'black',
               '④：到周伯通处模块会等待两分钟，届时会有说明')
    ColourNote('skyblue', 'black',
               '请玩家根据说明操作，超时将会自动返回大陆。')
    ColourNote('yellow', 'black',
               '⑤：偶尔过阵晕倒了，本模块会自动修正行为')
    ColourNote('yellow', 'black',
               '说明阅读完毕需要开始请输入： th_start')
end
function thz_start()
    n_cnt = 0
    s_cnt = 0
    w_cnt = 0
    e_cnt = 0
    _bagua_con = 0
    sw_cur = 0
    zhou_visited = 0
    hb_ok = 1
    _dir = ''
    _bagua_des = ''
    quest_name = ''
    quest_learned = ''
    thz_triggers_remove()
    -- exe('nick 去陪周伯通玩了')
    EnableTriggerGroup('fight', false)
    EnableTimer('idle', false)
    thz_triggers()
    EnableTriggerGroup('shizi', true)
    exe('hp;cha')
    if score.party == '桃花岛' then
        return thz_prework()
    else
        if hp.food < 60 or hp.water < 60 then
            return thz_eat()
        else
            checkBags()
            return checkWait(thz_check, 1)
        end
    end
end
function thz_eat()
    if locl.room == '茶亭' then
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#3(drink cha);drop cha;drop tao;hp')
        checkBags()
        return checkWait(thz_check, 1)
    else
        return go(thz_eat, '武当山', '茶亭')
    end
end
function thz_check()
    if not Bag['石子'] then
        return thz_shizi()
    else
        return exe('i')
    end
end
function thz_szcnt(n, l, w)
    if tonumber(trans(w[2])) < 80 then
        return thz_shizi()
    else
        return thz_go()
    end
end
function thz_shizi()
    if locl.room == '兵器铺' then
        exe('buy shizi')
        return check_bei(thz_go)
    else
        return go(thz_shizi, '扬州城', '兵器铺')
    end
end
function thz_go()
    if locl.room == '海滨' then
        exe('look rock;jump boat')
    else
        return go(thz_go, '桃花岛', '海滨')
    end
end
function thz_thd()
    exe('time')
    if MidNight[locl.time] then
        return check_bei(thz_dazuo)
    elseif not MidNight[locl.time] then
        return check_bei(thz_ready)
    end
end
function thz_dazuo() exe('time;yun qi;sxlian;yun jingli;dazuo ' .. hp.dazuo) end
function thz_ready()
    EnableTriggerGroup('shizi', false)
    EnableTriggerGroup('thzcal', true)
    EnableTriggerGroup('thzact', true)
    EnableTrigger('thzact3', false)
    exe('northup;northdown')
end
function thz_cal1(n, l, w)
    if _dir == 'north' then
        n_cnt = tonumber(trans(w[2]))
    elseif _dir == 'south' then
        s_cnt = tonumber(trans(w[2]))
    elseif _dir == 'west' then
        w_cnt = tonumber(trans(w[2]))
    elseif _dir == 'east' then
        e_cnt = tonumber(trans(w[2]))
    end
end
function thz_steps()
    if _dir == 'north' then
        return checkWait(thz_south, 0.2)
    elseif _dir == 'south' then
        return checkWait(thz_west, 0.2)
    elseif _dir == 'west' then
        return checkWait(thz_east, 0.2)
    elseif _dir == 'east' then
        return checkWait(thz_act3, 0.5)
    end
end
function thz_cal2()
    if _dir == 'north' then
        n_cnt = 10000
    elseif _dir == 'south' then
        s_cnt = 10000
    elseif _dir == 'west' then
        w_cnt = 10000
    elseif _dir == 'east' then
        e_cnt = 10000
    end
end
function thz_act1()
    EnableTriggerGroup('thzact', true)
    EnableTrigger('thzact1', false)
    exe('drop 1 shizi')
end
function thz_north()
    _dir = 'north'
    n_cnt = 0
    exe('look north')
end
function thz_south()
    _dir = 'south'
    s_cnt = 0
    exe('look south')
end
function thz_west()
    _dir = 'west'
    w_cnt = 0
    exe('look west')
end
function thz_east()
    _dir = 'east'
    e_cnt = 0
    exe('look east')
end
function thz_act3()
    EnableTrigger('thzact1', true)
    EnableTrigger('thzact3', false)
    if n_cnt < s_cnt and n_cnt < w_cnt and n_cnt < e_cnt then
        exe('north')
    elseif s_cnt < n_cnt and s_cnt < w_cnt and s_cnt < e_cnt then
        exe('south')
    elseif w_cnt < n_cnt and w_cnt < s_cnt and w_cnt < e_cnt then
        exe('west')
    elseif e_cnt < n_cnt and e_cnt < s_cnt and e_cnt < w_cnt then
        exe('east')
    else
        print('无法判断正确方向，尝试随机移动!')
        return checkWait(thz_random, 0.2)
    end
end
function thz_random()
    if math.random(1, 4) == 1 then
        return exe('north')
    elseif math.random(1, 4) == 2 then
        return exe('south')
    elseif math.random(1, 4) == 3 then
        return exe('west')
    else
        return exe('east')
    end
end
function thz_error()
    if zhou_visited == 0 then
        return thz_start()
    else
        return thz_leave()
    end
end
function thz_out()
    EnableTriggerGroup('thzact', false)
    EnableTriggerGroup('thzcal', false)
    exe('north;north')
    score.party = '桃花岛'
    if zhou_visited == 0 then
        locate()
        return checkWait(thz_prework, 1.2)
    else
        return thz_fin()
    end
end
function thz_prework()
    if locl.room == '积翠亭' then
        exe('ask huang yaoshi about 周伯通')
        return check_bei(thz_prework2)
    else
        return go(thz_prework, '桃花岛', '积翠亭')
    end
end
function thz_prework2()
    score.party = '桃花岛'
    if locl.room == '内室' then
        exe('ask huang rong about 周伯通')
        score.party = ''
        exe('score')
        if score.party == '桃花岛' then
            return go(thz_correct_path, '桃花岛', '岩洞')
        else
            score.party = '桃花岛'
            return check_bei(thz_bagua)
        end
    else
        return go(thz_prework2, '桃花岛', '内室')
    end
end
function thz_bagua()
    score.party = '桃花岛'
    if locl.room == '方厅' then
        exe(
            'east;drop bagua;drop bagua;west;look bagua;east;get bagua;get bagua')
        return thz_bagua_ok()
    else
        return go(thz_bagua, '桃花岛', '方厅')
    end
end
function thz_bagua_ok()
    if locl.room == '山冈' then
        return checkWait(thz_zhou, 1)
    else
        return go(thz_bagua_ok, '桃花岛', '山冈')
    end
end
--[[
 乾：连 连 连
 坤：断 断 断
 巽：连 连 断 
 震：断 断 连
 离：连 断 连
 坎：断 连 断
 艮：连 断 断 
 兑：断 连 连
]]
function thz_path(n, l, w)
    _bagua_des = w[2]
    print('原始描述 =' .. _bagua_des)
    _bagua_des = string.gsub(_bagua_des, '乾', 'a;aa;aa;a')
    _bagua_des = string.gsub(_bagua_des, '坤', 'b;bb;bb;b')
    _bagua_des = string.gsub(_bagua_des, '巽', 'a;aa;ab;b')
    _bagua_des = string.gsub(_bagua_des, '震', 'b;bb;ba;a')
    _bagua_des = string.gsub(_bagua_des, '离', 'a;ab;ba;a')
    _bagua_des = string.gsub(_bagua_des, '坎', 'b;ba;ab;b')
    _bagua_des = string.gsub(_bagua_des, '艮', 'a;ab;bb;b')
    _bagua_des = string.gsub(_bagua_des, '兑', 'b;ba;aa;a')
    _bagua_des = string.gsub(_bagua_des, 'ab', 'w')
    _bagua_des = string.gsub(_bagua_des, 'aa', 'n')
    _bagua_des = string.gsub(_bagua_des, 'ba', 'w')
    _bagua_des = string.gsub(_bagua_des, 'bb', 'n')
    _bagua_des = string.gsub(_bagua_des, 'a;', 'w;')
    _bagua_des = string.gsub(_bagua_des, 'b;', 'w;')
    _bagua_des = string.gsub(_bagua_des, ';a', '')
    _bagua_des = string.gsub(_bagua_des, ';b', '')
    print('第一个可能的密码为： ' .. _bagua_des)
    print('第二个可能的密码为： ' .. string.gsub(_bagua_des, 'w', 'e'))
end
function thz_zhou()
    _bagua_con = _bagua_con + 1
    if _bagua_con == 1 then
        _bagua_des = string.gsub(_bagua_des, 'e', 'w')
        print('第一次尝试：从西面入阵')
        exe(_bagua_des .. ';enter;touch zhou botong')
    elseif _bagua_con == 2 then
        _bagua_des = string.gsub(_bagua_des, 'w', 'e')
        print('再次尝试：从东面入阵')
        exe(_bagua_des .. ';enter;touch zhou botong')
    else
        print('再次尝试失败，返回重新解密')
        _bagua_con = 0
        return thz_out()
    end
end
function thz_wrong_path()
    score.party = '桃花岛'
    return go(thz_bagua_ok, '桃花岛', '山冈')
end
function thz_correct_path()
    zhou_visited = 1
    exe('quest')
    DeleteTimer('idlecheck')
    create_timer_m('idlecheck', 2, 'thz_zhoudone')
    create_alias_s('jyzhenjing', 'jyzhenjing', 'thz_jyzj')
    create_alias_s('zyhubo', 'zyhubo', 'thz_hb')
    create_alias_s('kmquan', 'kmquan', 'thz_kmq')
    create_alias_s('kmquan1', 'kmquan1', 'thz_kmq1')
    create_alias_s('leaveth', 'leaveth', 'thz_zhoudone')
    print('已到达周伯通所在岩洞，请详细阅读以下说明：')
    ColourNote('skyblue', 'black', '①；解九阴上请输入：   jyzhenjing')
    ColourNote('skyblue', 'black', '②；解左右互搏请输入： zyhubo')
    ColourNote('skyblue', 'black', '③；解空明拳请输入：   kmquan')
    ColourNote('white', 'black',
               '④：如是为了继续学习空明拳请输入： kmquan1 后手动向周伯通学习！')
    ColourNote('white', 'black',
               '⑤：如是拿九阴真经秘籍请直接输入 ask zhou botong about 九阴真经！')
    ColourNote('red', 'black',
               '请在 2 分钟内输入以上指令，否则将会自动回大陆！')
    ColourNote('yellow', 'black', '如需提前返回请输入：    leaveth')
end
function thz_hb()
    DeleteTimer('idlecheck')
    exe('ask zhou botong about 左右互搏')
    return check_bei(thz_huafangyuan1)
end
function thz_fangyuan() hb_ok = 0 end
function thz_huafangyuan1()
    create_timer_s('huafy', 2, 'thz_huafangyuan2')
    exe('#20(hua fang yuan)')
end
function thz_huafangyuan2()
    DeleteTimer('huafy')
    if hb_ok == 0 then return check_bei(thz_huafangyuan1) end
end
function thz_kmq()
    DeleteTimer('idlecheck')
    exe('ask zhou botong about 空明拳')
end
function thz_kmq1()
    DeleteTimer('idlecheck')
    exe('cha;hp')
end
function thz_zhouask(n, l, w)
    if string.find(w[2],
                   '有种剑法，练了使人绝子绝孙。这个剑法的名字是什么？') then
        _answer = 'answer pixie-jian'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '一灯大师的拿手绝学是什么？') then
        _answer = 'answer yiyang-zhi'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '我全真教的内功心法是什么？') then
        _answer = 'answer xiantian-gong'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '我求杨过这小子教我的掌法叫做什么名称？') then
        _answer = 'answer anran-zhang'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '桃花的狂风绝技要以什么和旋风扫叶腿配合施展？') then
        _answer = 'answer luoying-zhang'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '少林和尚们的内功是什么？') then
        _answer = 'answer yijin-jing'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '黄老邪的那厉害指法是什么？') then
        _answer = 'answer tanzhi-shentong'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '华山剑宗的高级剑法是？') then
        _answer = 'answer dugu-jiujian'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '古墓派的内功心法是什么？') then
        _answer = 'answer yunu-xinjing'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '峨嵋的灭绝师太曾经以那种功夫将张无忌打的倒地不起？') then
        _answer = 'answer jieshou-jiushi'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '段家有门以指为剑的剑法，叫什么名字？') then
        _answer = 'answer liumai-shenjian'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '瑛姑的高明身法是什么？') then
        _answer = 'answer niqiugong'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '星宿派恶名昭彰的功夫是什么？') then
        _answer = 'answer huagong-dafa'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '武当张老头创出的软绵绵拳法叫什么名字') then
        _answer = 'answer taiji-quan'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '老叫化教黄蓉那小丫头的是什么拳法') then
        _answer = 'answer xiaoyaoyou'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '明教前教主阳顶天练什么功夫练到走火而死的？') then
        _answer = 'answer qiankun-danuoyi'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '明教张无忌那小子的内功是什么？') then
        _answer = 'answer jiuyang-shengong'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '黄老邪的箫乐是由他的内功而来。这个内功的名字是？') then
        _answer = 'answer bihai-chaosheng'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '我老顽童的自创拳招是什么啊') then
        _answer = 'answer kongming-quan'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '铁掌帮的著名轻功是？') then
        _answer = 'answer shuishangpiao'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '老毒物的奇怪内功是什么') then
        _answer = 'answer hamagong'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '峨嵋的剑法是什么') then
        _answer = 'answer huifeng-jian'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2],
                   '黄老邪除了教杨过弹指神通，还教了什么武') then
        _answer = 'answer yuxiao-jian'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '古墓一派的特殊拳法，叫什么名称') then
        _answer = 'answer meinu-quan'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '华山气宗的镇山之宝是什么') then
        _answer = 'answer zixia-gong'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '黄蓉的家传手法叫什么名字') then
        _answer = 'answer lanhua-shou'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '金蛇郎君夏雪宜的剑法叫什么名称？') then
        _answer = 'answer jinshe-jianfa'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '老叫化和郭兄弟都会的掌法是什么') then
        _answer = 'answer xianglong-zhang'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '慕容家的家传特殊招架技能是？') then
        _answer = 'answer douzhuan-xingyi'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '神龙洪老头的暗器是叫做什') then
        _answer = 'answer hansha-sheying'
        return checkWait(thz_answer, 0.2)
    end
    if string.find(w[2], '原来我们是同道中人啊。') then
        return checkWait(thz_jyzj5, 0.2)
    end
    if string.find(w[2], '这样吧，我教你点好玩的功夫！') then
        return checkWait(thz_jyzj5, 0.2)
    end
    if string.find(w[2],
                   '空明拳共七十二路，口诀是：空朦洞松、风通容梦、冲穷中弄、童庸弓虫。') then
        return check_bei(thz_kongmingquan1)
    end
    if string.find(w[2], '我现在可没空，我忙着玩呢。') then
        print('请检查你的解谜前置条件！')
        return thz_correct_path()
    end
end
function thz_answer() exe(_answer) end
function thz_jywait() return checkWait(thz_jyzj50) end
function thz_kongmingquan1()
    weapon_unwield()
    exe('ask zhou botong about 结拜')
    check_bei(thz_kongmingquan2)
end
function thz_kongmingquan2() exe('xue zhou kongming-quan') end
function thz_questdone1(n, l, w)
    hb_ok = 1
    ColourNote('lime', 'black', '【左右互搏】解谜已完成！')
    ColourNote('skyblue', 'black',
               '如需进行周伯通其他解谜请输入对应指令：')
    ColourNote('skyblue', 'black', '①；解九阴上请输入   jyzhenjing')
    ColourNote('skyblue', 'black', '②；解空明拳请输入   kmquan')
    ColourNote('yellow', 'black', '如需提前返回请输入：  leaveth')
end
function thz_questdone2()
    EnableTrigger('thzqok2', false)
    ColourNote('lime', 'black', '【空明拳】解谜已完成！')
    ColourNote('lime', 'black', '接下来请玩家自行手动学习')
    ColourNote('skyblue', 'black',
               '如需进行周伯通其他解谜请输入对应指令：')
    ColourNote('skyblue', 'black', '①；解九阴上请输入   jyzhenjing')
    ColourNote('skyblue', 'black', '②；解左右互搏请输入 zyhubo')
    ColourNote('yellow', 'black', '如需提前返回请输入：  leaveth')
end
function thz_questdone3()
    ColourNote('lime', 'black', '【九阴真经】解谜已完成！')
    ColourNote('skyblue', 'black',
               '如需进行周伯通其他解谜请输入对应指令：')
    ColourNote('skyblue', 'black', '①；解空明拳请输入   kmquan')
    ColourNote('skyblue', 'black', '②；解左右互搏请输入 zyhubo')
    ColourNote('yellow', 'black', '如需提前返回请输入：  leaveth')
end
function thz_jyzjx()
    exe('read jiuyin-zhenjing;y')
    return thz_questdone3()
end
function thz_jyzj() return check_bei(thz_jyzj10) end
function thz_jyzj10() exe('give zhou fan he') end
function thz_jyzj1() return check_bei(thz_jyzj11) end
function thz_jyzj11() exe('ask zhou botong about 九阴真经') end
function thz_jyzj2() return check_bei(thz_jyzj20) end
function thz_jyzj20() exe('ask zhou botong about 故事') end
function thz_jyzj3() return check_bei(thz_jyzj30) end
function thz_jyzj30() exe('ask zhou botong about 后来怎样') end
function thz_jyzj4() return check_bei(thz_jyzj40) end
function thz_jyzj4() return exe('answer n') end
function thz_jyzj5() return check_bei(thz_jyzj50) end
function thz_jyzj50() exe('ask zhou botong about 功夫') end
function thz_zhoudone()
    EnableTriggerGroup('thzcal', true)
    EnableTriggerGroup('thzact', true)
    EnableTrigger('thzact3', false)
    return exe('out;north')
end
function thz_fin()
    if locl.room == '积翠亭' then
        score.party = ''
        exe('score')
        return exe('ask huang yaoshi about 离开')
    else
        return go(thz_fin, '桃花岛', '积翠亭')
    end
end
function thz_leave()
    zhou_visited = 0
    hb_ok = 1
    EnableTriggerGroup('fight', true)
    thz_triggers_remove()
    return check_food()
end
