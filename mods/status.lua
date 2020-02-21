hp = {
    jingxue = 0,
    jingxue_max = 0,
    jingxue_per = 0,
    jingli = 0,
    jingli_max = 0,
    jingli_lim = 0,
    qixue = 0,
    qixue_max = 0,
    qixue_per = 0,
    neili = 0,
    neili_max = 0,
    neili_lim = 0,
    food = 100,
    water = 100,
    pot = 0,
    pot_max = 0,
    exp = 0,
    heqi = 0,
    dazuo = 10,
    tuna = 10,
    shen = 0
}

score = {}
score.id = 'id'
score.name = 'name'
score.dex = 20
score.dex_t = 20
score.int = 20
score.int_t = 20
score.str = 20
score.str_t = 20
score.con = 20
score.con_t = 20
score.age = 14
score.gold = 0
score.tb = 0
score.yb = 0
score.jjb = 0
score.sww = 0
score.sw = 0
score.dj = 0
score.dz = 0
score.zt = ''

check_skills = function(n, l, w)

    local l_skills = " "
    if w[3] then l_skills = l_skills .. w[3] end
    if w[4] then l_skills = l_skills .. w[4] end
    if w[5] then l_skills = l_skills .. w[5] end
    l_skills = Trim(l_skills)
    skills[l_skills] = skills[l_skills] or {}
    skills[l_skills].lvl = tonumber(w[6])
    skills[l_skills].pot = tonumber(w[7])
    skills[l_skills].name = Trim(w[2])
    if skills[l_skills].lvl >= 450 then skills[l_skills].mstlvl = 450 end
    if l_skill == "force" and skills[l_skills].mstlvl < 450 and
        skills[l_skills].mstlvl == hp.pot_max - 101 then
        skills[l_skills].mstlvl = nil
    end

end

hp_jingxue_check = function(n, l, w)
    hp.jingxue = tonumber(w[1])
    hp.jingxue_max = tonumber(w[2])
    hp.jingxue_per = tonumber(w[3])
    hp.jingli = tonumber(w[4])
    hp.jingli_max = tonumber(w[5])
    hp.jingli_lim = tonumber(w[6])
end
hp_qixue_check = function(n, l, w)
    hp.qixue = tonumber(w[1])
    hp.qixue_max = tonumber(w[2])
    hp.qixue_per = tonumber(w[3])
    hp.neili = tonumber(w[4])
    hp.neili_max = tonumber(w[5])
end
hp_shen_check = function(n, l, w)
    local l_type = tostring(w[1])
    hp.shen = tonumber(del_string(tostring(w[2]), ','))
    hp.neili_lim = tonumber(w[3])
    if l_type == '��' then hp.shen = hp.shen * -1 end
end
hp_pot_check = function(n, l, w)
    hp.food = tonumber(w[1])
    hp.pot = tonumber(w[2])
    hp.pot_max = tonumber(w[3])

    for p in pairs(skillEnable) do
        -- ain 200level->160
        q = skillEnable[p]
        if skills[p] and skills[q] then
            skills[p].full = 0

            if q == 'force' and (hp.pot < 50 or skills[p].lvl < 150) then
                skills[p].full = 1
            end
            -- if (skills[p].lvl==skills[q].lvl and skills[p].pot==(skills[p].lvl+1)*(skills[p].lvl+1)) or skills[p].lvl>skills[q].lvl then
            if skills[p].lvl >= skills[q].lvl then skills[p].full = 1 end
            if skills[p].fullever then skills[p].full = 1 end
            if skills[p].lvl >= hp.pot_max - 100 then
                skills[p].full = 1
            end
            if p == "wuxiang-zhi" then
                if not skills[p].olvl then
                    skills[p].olvl = skills[p].lvl
                end
                if skills[p].lvl > skills[p].olvl then
                    flag.wxjz = 0
                    skills[p].olvl = skills[p].lvl
                end
            end
            if p == "wuxiang-zhi" and (skills[p].lvl < 200 or flag.wxjz == 0) then
                skills[p].full = 1
            end
        end
    end
    if perform.force then
        if not skills[perform.force] then perform.force = nil end
    end
    if not perform.force then
        tmp.lvl = 0
        for p in pairs(skills) do
            q = skillEnable[p]
            if q == "force" then
                if skills[p].lvl > tmp.lvl then
                    tmp.lvl = skills[p].lvl
                    perform.force = p
                end
            end
        end
    end
    if skills["parry"] and skills["parry"].lvl < hp.pot_max - 100 and
        skills["parry"].lvl < 450 then flag.xuexi = 1 end
end
hp_exp_check = function(n, l, w)
    hp.water = tonumber(w[1])
    hp.exp = tonumber(del_string(tostring(w[2]), ','))
end
hp_dazuo_check = function(n, l, w)
    hp.dazuo = trans(w[1])
    exe('dazuo ' .. hp.dazuo)
end
score_tb_check = function(n, l, w)
    score.tb = tonumber(w[1])
    score.yb = tonumber(w[2])
    score.jjb = tonumber(w[3])
end
score_ebook_check = function(n, l, w) ebooktimes = trans(w[1]) end
score_name_check = function(n, l, w)
    if score.name == 'name' then score.name = tostring(w[1]) end
    if score.id == 'id' then score.id = string.lower(tostring(w[2])) end
    score.dex_t = tonumber(w[3])
    score.dex = tonumber(w[4])
    score.int_t = tonumber(w[5])
    score.int = tonumber(w[6])
end
score_title_check = function(n, l, w)
    score.title = Trim(tostring(w[1]))
    score.str_t = tonumber(w[2])
    score.str = tonumber(w[3])
    score.con_t = tonumber(w[4])
    score.con = tonumber(w[5])
end
score_age_check = function(n, l, w) score.age = trans(w[1]) end
score_gold_check = function(n, l, w)
    score.gold = trans(w[2])
    if score.gold == nil then score.gold = 0 end
end
score_party_check = function(n, l, w)
    score.party = w[3]
    score.master = w[4]
    if score.party == "��ͨ����" then score.master = "��ͨ����" end
end
score_check_xy = function(n, l, w)
    score.xiangyun = Trim(w[1]) -- ����״̬�����������ܡ�ƽ��˥����
    score.xiangyunvalue = tonumber(w[2])
    if not score.xiangyunvalue then score.xiangyunvalue = 0 end
    if scorexy == false then scorexy = smyteam * 1 end
    if SMY_ID[score.id] then
        if score.xiangyun == '��' then
            smyteam = scorexy - 2
        elseif score.xiangyun == '˥' and score.xiangyunvalue > 10 then
            smyteam = scorexy - 2
        elseif score.xiangyun == '˥' and score.xiangyunvalue <= 10 then
            smyteam = scorexy - 1
        elseif smyteam < scorexy then
            smyteam = scorexy
        end
    else
        if score.xiangyun == '˥' or score.xiangyun == '��' then
            if job.zuhe["songmoya"] then job.zuhe["songmoya"] = nil end
        else
            if smyteam < scorexy then smyteam = scorexy * 1 end
            if go_on_smy ~= 0 and job.zuhe["songmoya"] == nil then
                job.zuhe["songmoya"] = true
            end
        end
    end
end
score_busy_check = function(n, l, w)
    local l_char = del_string(w[2], ' ')
    l_char = del_string(l_char, '??')
    local l_cnt = trans(l_char)
    if w[3] == '��' then
        if w[1] == "ѩɽǿ����Ů" then
            condition.xueshan = l_cnt * 60
        end
        if w[1] == "˫������" then condition.ebook = l_cnt * 60 end
        if w[1] == "����" then condition.mingwu = l_cnt * 60 end
        if w[1] == "��ʵ��Ұ" then condition.vpearl = l_cnt end
        if w[1] == "����" then
            vippoison = 1
            condition.poison = l_cnt * 60
        end
        if w[1] == "�����ܻ���" then vippoison = 1 end
        if w[1] == "�����ƶ�" then
            vippoison = 1
            condition.poison = l_cnt * 60
        end
        if w[1] == "��צ��������" then
            condition.poison = l_cnt * 60
        end
        if w[1] == "����æ״̬" then condition.busy = l_cnt * 60 end
        if w[1] == "�����ھֻ��ڵ���ʱ" then
            condition.hubiao = l_cnt * 60
        end
        -- print(condition.poison,condition.busy)
    else
        if w[1] == "ѩɽǿ����Ů" then condition.xueshan = l_cnt end
        if w[1] == "˫������" then condition.ebook = l_cnt end
        if w[1] == "����" then condition.mingwu = l_cnt end
        if w[1] == "��ʵ��Ұ" then condition.vpearl = l_cnt end
        if w[1] == "����" then
            vippoison = 1
            condition.poison = l_cnt
        end
        if w[1] == "�����ܻ���" then vippoison = 1 end
        if w[1] == "�����ƶ�" then
            vippoison = 1
            condition.poison = l_cnt
        end
        if w[1] == "��צ��������" then condition.poison = l_cnt end
        if w[1] == "����æ״̬" then condition.busy = l_cnt end
        if w[1] == "�����ھֻ��ڵ���ʱ" then
            condition.hubiao = l_cnt
        end
        -- print(condition.poison,condition.busy)
    end
end
score_gender_check = function(n, l, w)
    if string.len(w[1]) == 2 then score.gender = w[1] end
    if string.len(w[2]) == 8 then score.level = w[2] end
end
hpheqi = function()
    DeleteTriggerGroup("hpheqi")
    create_trigger_t('hpheqi1', "^�������ȡ�\\s*\\-?\\s*(\\d*)", '',
                     'hp_heqi_check')
    SetTriggerOption("hpheqi1", "group", "hpheqi")
    EnableTriggerGroup("hpheqi", false)
end

hp_dazuo_count = function()
    DeleteTriggerGroup("dz_count")
    create_trigger_t('dz_count1',
                     '^>*\\s*���Ҳ��ܴ�������Ӱ�������Ϣ��', '',
                     'hp_dz_where')
    create_trigger_t('dz_count2', '^>*\\s*���޷���������������', '',
                     'hp_dz_where')
    create_trigger_t('dz_count3',
                     '^>*\\s*(���ﲻ׼ս����Ҳ��׼������|����ɲ���������������ĵط���)',
                     '', 'hp_dz_where')
    create_trigger_t('dz_count4',
                     "^(> )*�������ֽŴ�����������������ȷ������������",
                     '', 'hp_dz_liaokao')
    create_trigger_t('dz_count5',
                     "^(> )*(����Ҫ��������|���޷�������������|�㻹��ר�Ĺ����)",
                     '', 'hp_dz_where')
    create_trigger_t('dz_count6',
                     "^(> )*�����ھ��������޷�������Ϣ��������",
                     '', 'loginerror')
    SetTriggerOption("dz_count1", "group", "dz_count")
    SetTriggerOption("dz_count2", "group", "dz_count")
    SetTriggerOption("dz_count3", "group", "dz_count")
    SetTriggerOption("dz_count4", "group", "dz_count")
    SetTriggerOption("dz_count5", "group", "dz_count")
    SetTriggerOption("dz_count6", "group", "dz_count")
    if perform.force and skills[perform.force] then
        exe('jifa force ' .. perform.force)
    else
        for p in pairs(skills) do
            if skillEnable[p] == "force" then
                exe('jifa force ' .. p)
                exe('cha')
            end
        end
    end
    if skills["linji-zhuang"] and skills["linji-zhuang"].lvl > 149 then
        exe('yun yinyang')
    end
    if skills["force"] and skills["force"].lvl < 450 and skills["force"].lvl <
        hp.pot_max - 100 then flag.xuexi = 1 end
    exe('yun qi;hp')
    hp.dazuo = 10
    return check_bei(hp_dazuo_act)
end
loginerror = function()
    DeleteTriggerGroup("dz_count")
    DeleteTimer("dazuo_count")
    return checkWait(check_heal, 0.5)
end
hp_dazuo_act = function()
    tmp.qixue = hp.qixue
    exe('yun jing;dazuo ' .. hp.qixue)
    tmp.i = 0
    return create_timer_s('dazuo_count', 1.5, 'hp_dazuo_timer')
end
hp_dazuo_timer = function()
    if tmp.i == nil then tmp.i = 0 end
    tmp.i = tmp.i + 1
    if tmp.i > 30 then return main() end
    exe('hp;yun jing;yun qi;dazuo ' .. hp.qixue)
    return checkWait(hp_dz_count, 0.5)
end
hp_dz_count = function()
    EnableTriggerGroup("dz_count", false)

    local l_times = 1
    if hp.qixue < tmp.qixue then
        if hp.qixue_max > 1000 then
            l_times = math.modf(math.modf(hp.qixue_max / 5) /
                                    (tmp.qixue - hp.qixue)) + 1
        end
        hp.dazuo = l_times * (tmp.qixue - hp.qixue) + 150
        if hp.dazuo < 10 then hp.dazuo = 10 end
        -- if hp.dazuo>10 and hp.dazuo <100 then
        --   l_times=math.modf(100/hp.dazuo)+1
        --   hp.dazuo=l_times*hp.dazuo
        -- end
        Note('��Ѵ���ֵΪ��' .. hp.dazuo)
        DeleteTriggerGroup("dz_count")
        DeleteTimer("dazuo_count")
        exe('halt')
        if kdummy == 1 and hp.exp > 2000000 then opendummy() end
        return check_bei(vcheck)
    end
end
function vcheck()
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        job.name = 'ptbx'
        exe('cond')
        return go(VIPask, '���ݳ�', '����')
    else
        return Gstart()
    end
end
function Gstart() return check_bei(check_food) end
hp_dz_where = function()
    EnableTriggerGroup("dz_count", false)
    DeleteTimer("dazuo_count")
    locate()
    check_bei(hp_dz_go)
end
hp_dz_go = function()
    EnableTriggerGroup("dz_count", true)
    exe(locl.dir)
    hp_dazuo_act()
end
function hp_dz_liaokao()
    dis_all()
    return tiaoshui()
end
function hp_trigger()
    DeleteTriggerGroup("hp")
    create_trigger_t('hp1',
                     "^����Ѫ��\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*��������\\s*(\\d*)\\s*\\/\\s*(\\d*)\\((\\d*)\\)$",
                     '', 'hp_jingxue_check')
    create_trigger_t('hp2',
                     "^����Ѫ��\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*��������\\s*(\\d*)\\s*\\/\\s*(\\s*\\d*)\\(\\+\\d*\\)$",
                     '', 'hp_qixue_check')
    create_trigger_t('hp3',
                     "^��ʳ�\\s*(\\d*)\\.\\d*\\%\\s*��Ǳ�ܡ�\\s*(\\d*)\\s*\\/\\s*(\\d*)$",
                     '', 'hp_pot_check')
    create_trigger_t('hp4',
                     "^����ˮ��\\s*(\\d*)\\.\\d*\\%\\s*�����顤\\s*(.*)\\s*\\(",
                     '', 'hp_exp_check')
    create_trigger_t('hp5',
                     "^��(��|��)����\\s*(.*)\\s*���������ޡ�\\s*(\\d*)\\s*\\/",
                     '', 'hp_shen_check')
    create_trigger_t('hp7',
                     "^(��)*\\s*(\\D*)\\s*\\((\\D*)(\\-)*(\\D*)\\)\\s*\\-\\s*\\D*\\s*(\\d*)\\/\\s*(\\d*)$",
                     '', 'check_skills')
    create_trigger_t('hp8', "^>*\\s*��������Ҫ(\\D*)�������������",
                     '', 'hp_dazuo_check')
    create_trigger_t('hp9', "^��(\\D*)����\\s*��\\s*(\\d*) ��\\s*�� ", '',
                     'checkJobtimes')
    create_trigger_t('hp10', "^��(\\D*)\\(\\D*\\)$", '', 'checkWieldCatch')
    create_trigger_t('hp11', "^(> )*������������(\\D*)����$", '',
                     'checkJoblast')
    create_triggerex_lvl('hp12', "^(> )*(\\D*)", '', 'resetWait', 200)
    create_trigger_t('hp13',
                     "^(> )*�㻹��Ѳ���أ���ϸ����������ɡ�",
                     '', 'checkQuit')
    create_trigger_t('hp14', "^\\D*��һ�������ˡ�$", '',
                     'checkRefresh')
    create_trigger_t('hp15', "^(> )*һ�����ֹ�ȥ", '', 'checkMonth')
    create_trigger_t('hp16',
                     "^(> )*�������ʧ���ż�����(\\N*)�Σ��������ʧ���ż�����(\\N*)/(\\N*)�Ρ�",
                     '', 'checkLLlost')
    create_trigger_t('hp17',
                     "^(> )*��(�ʵ���ð���ǣ�ȫ������|����ͷ���ۻ���ֱð�亹)|�����ɳ����е�����ð�̣��ɿ��Ѱ���",
                     '', 'checkQuit')
    create_trigger_t('hp18',
                     "^(> )*(����������ѵ��촽�������Ǻܾ�û�к�ˮ��|ͻȻһ�󡰹�������������ԭ������Ķ����ڽ���)",
                     '', 'checkfood')
    create_trigger_t('hp19',
                     "^(> )*(��Ȼһ��̹ǵ��溮Ϯ�������е������ƶ�������|��Ȼһ�ɺ������Ʊ�����ѭ���ֱۣ�Ѹ�����׵��������ţ����еĺ���������)",
                     '', 'checkDebug')
    create_trigger_t('hp20',
                     "^(> )*��(����һ�Ż�Ѫ�ƾ�������ʱ�о���Ѫ������ʧ|����һ����Ϣ�裬��ʱ�������������˲���|����һ�Ŵ�����Ϣ�裬��ʱ�о���������|����һ�Ż�����Ϣ������ʱ�о�����ĵ����ӯ�˲���|����һ�����ɽ�ҩ����ʱ�о����ƺ��˲���|����һ�Ŵ󻹵���ʱ����Ȭ����Ѫ��ӯ)��",
                     '', 'hpeatOver')
    create_trigger_t('hp21',
                     "^(> )*��������� enable ѡ����Ҫ�õ������ڹ���",
                     '', 'jifaOver')
    create_trigger_t('hp22', "^(> )*(\\D*)Ŀǰѧ��(\\D*)�ּ��ܣ�", '',
                     'show_skills')
    create_trigger_t('hp23', "^(> )*��ı������У�", '', 'show_beinang')
    create_trigger_t('hp24',
                     '^(> )*������һ������\\D*����ߵ���һ(��|��|˫|Ϯ|��|��|��|��)(\\D*)(����|ѥ|����|����|����|����|ͷ��)��',
                     '', 'fqyyArmorGet')
    create_trigger_t('hp25',
                     '^(> )*�����һ(��|��|˫|Ϯ|��|��|��|��)(\\D*)(����|ѥ|����|����|����|����|ͷ��)��',
                     '', 'fqyyArmorCheck')
    create_trigger_t('hp26', '^(> )*\\D*�����㣺����(\\D*)', '',
                     'yiliCheck')
    create_trigger_t('hp27',
                     '^(> )*�͹��Ѿ��������ӣ���(ô|��)��ס��������أ����˻���ΪС���ź����أ�',
                     '', 'kedian_sleep')
    create_trigger_t('hp28', '^.*��⵰��һ�ߴ���ȥ', '',
                     'newbie_qu_gold')
    create_trigger_t('hp29',
                     '^.*���ɵؿ����㣺��������ô�䵽������ϣ���',
                     '', 'dolost_hitlog_open')
    create_trigger_t('hp30', '^.*��˵' .. score.name .. '��.*��ɵ��!', '',
                     'dolost_hitlog_close')
    create_trigger_t('hp31',
                     "^\\D*���Ǯ�������ң�������������һ��С��",
                     '', 'job_lianstart')
    SetTriggerOption("hp24", "group", "hp")
    SetTriggerOption("hp25", "group", "hp")
    SetTriggerOption("hp26", "group", "hp")
    SetTriggerOption("hp27", "group", "hp")
    SetTriggerOption("hp1", "group", "hp")
    SetTriggerOption("hp2", "group", "hp")
    SetTriggerOption("hp3", "group", "hp")
    SetTriggerOption("hp4", "group", "hp")
    SetTriggerOption("hp5", "group", "hp")
    SetTriggerOption("hp7", "group", "hp")
    SetTriggerOption("hp8", "group", "hp")
    SetTriggerOption("hp9", "group", "hp")
    SetTriggerOption("hp10", "group", "hp")
    SetTriggerOption("hp11", "group", "hp")
    SetTriggerOption("hp12", "group", "hp")
    SetTriggerOption("hp13", "group", "hp")
    SetTriggerOption("hp14", "group", "hp")
    SetTriggerOption("hp15", "group", "hp")
    SetTriggerOption("hp16", "group", "hp")
    SetTriggerOption("hp17", "group", "hp")
    SetTriggerOption("hp18", "group", "hp")
    SetTriggerOption("hp19", "group", "hp")
    SetTriggerOption("hp20", "group", "hp")
    SetTriggerOption("hp21", "group", "hp")
    SetTriggerOption("hp22", "group", "hp")
    SetTriggerOption("hp23", "group", "hp")
    SetTriggerOption("hp28", "group", "hp")
    SetTriggerOption("hp29", "group", "hp")
    SetTriggerOption("hp30", "group", "hp")
    SetTriggerOption("hp31", "group", "hp")
    DeleteTriggerGroup("score")
    create_trigger_t('score1',
                     "^����    ����(\\D*)\\((\\D*)\\)\\s*����  ������(\\d*)/(\\d*)��\\s*��  �ԣ���(\\d*)/(\\d*)��",
                     '', 'score_name_check')
    create_trigger_t('score2',
                     "^��ͷ    �Σ�(\\D*)\\s*����  ������(\\d*)/(\\d*)��\\s*��  �ǣ���(\\d*)/(\\d*)��",
                     '', 'score_title_check')
    create_trigger_t('score3',
                     "^����    �䣺(\\D*)��\\D*\\s*��    ����", '',
                     'score_age_check')
    create_trigger_t('score4',
                     "^��(����æ״̬|ѩɽǿ����Ů|˫������|����|����|�����ƶ�|�����ܻ���|��צ��������|�����ھֻ��ڵ���ʱ|��ʵ��Ұ)\\s*(\\D*)(��|��)\\s*",
                     '', 'score_busy_check')
    create_trigger_t('score5',
                     "^��(��    ��|��    ��|��    ��)��(\\D*)\\s*ʦ\\s*�У���(\\D*)����(\\D*)��",
                     '', 'score_party_check')
    create_trigger_t('score6',
                     "^����    ��(\\D*)��\\s*����(\\D*)\\s* �㣺",
                     '', 'score_gender_check')
    create_trigger_t('score7',
                     "^��(��    ��|��    ��|��    ��)��(\\D*)\\s*ʦ\\s*�У���(��ͨ����)��(\\D*)",
                     '', 'score_party_check')
    create_trigger_t('score9',
                     "^��ע    �᣺(\\D*)\\s*Ǯׯ��(\\D*)", '',
                     'score_gold_check')
    create_trigger_t('score8', "^��Ŀǰ�Ĵ�������ǣ�(\\D*)���ƽ�",
                     '', 'checkGoldLmt')
    create_trigger_t('score10',
                     '^���������ԣ�\\d*.*���ࣺ(\\D*)\\((\\d*)\\)\\s*��',
                     '', 'score_check_xy')
    create_trigger_t('score11',
                     '^���齣ͨ����(\\N*)\\s*�齣Ԫ����(\\N*)\\s*�����ң�(\\N*)\\s*��',
                     '', 'score_tb_check')
    create_trigger_t('score12',
                     "^�������Ѿ�ʹ�þ�Ӣ֮��(\\D*)�Ρ�", '',
                     'score_ebook_check')
    create_trigger_t('score13', '^������������(\\d*)', '',
                     'score_sw_check')

    create_trigger_t('score14',
                     '^����ǰ�ȼ���(\\N*)\\s*������(\\N*)\\s*������᣺(\\N*)\\s*��',
                     '', 'score_dz_check')
    SetTriggerOption("score1", "group", "score")
    SetTriggerOption("score2", "group", "score")
    SetTriggerOption("score3", "group", "score")
    SetTriggerOption("score4", "group", "score")
    SetTriggerOption("score5", "group", "score")
    SetTriggerOption("score6", "group", "score")
    SetTriggerOption("score7", "group", "score")
    SetTriggerOption("score8", "group", "score")
    SetTriggerOption("score9", "group", "score")
    SetTriggerOption("score10", "group", "score")
    SetTriggerOption("score11", "group", "score")
    SetTriggerOption("score12", "group", "score")
end
score_dz_check = function(n, l, w)
    score.dj = tonumber(w[1])
    score.sww = tonumber(w[2])
    score.dz = tonumber(w[3])
end

score_sw_check = function(n, l, w) score.sw = trans(w[1]) end

function check_pot(p_cmd)
    if hp.exp < 5000000 then
        l_pot = hp.pot_max - 100
    else
        l_pot = hp.pot_max - 200
    end
    flag.lingwu = 0

    job_exp_tongji()

    if flag.autoxuexi == nil then flag.autoxuexi = 0 end

    if hp.pot < l_pot then
        print("Ǳ�ܲ�������������")
        return check_job()
    elseif flag.autoxuexi == 0 then
        print("flag.autoxuexi Ϊ0����������")
        return check_job()
    end

    local max_skill = hp.pot_max - 100
    if score.party == "��ͨ����" then
        if score.gold and skills["literate"] and score.gold > 3000 and
            skills["literate"].lvl < max_skill then return literate() end
        if skills["parry"].lvl < max_skill and skills["parry"].lvl >= 101 then
            return checklingwu()
        end
        if skills["force"].lvl > 50 and skills["force"].lvl < 101 then
            if skills["force"].lvl == 101 then
                exe('fangqi force 1;y;y;y')
            end
            return huxi()
        end
        if skills["shenzhao-jing"] and skills["shenzhao-jing"].lvl < 200 then
            return learnSzj()
        end
    else
        if score.gold and skills["literate"] and score.gold > 3000 and
            skills["literate"].lvl < max_skill then return literate() end

        -- flag.xuexi = 1 when parry < 450
        if flag.type and flag.type ~= 'lingwu' and flag.xuexi == 1 then
            return checkxue()
        end

        -- find special force, if level < 100 then xuexi.
        for p in pairs(skills) do
            local q = qrySkillEnable(p)
            if q and q['force'] and perform.force and p == perform.force and
                skills[p].lvl < 100 then
                if skills[p].mstlvl and skills[p].mstlvl > skills[p].lvl then
                    return checkxue()
                end
            end
        end

        -- check perform skill, if less than 450 go xuexi.  This clause might need to remove.
        if perform.skill and skills[perform.skill] and skills[perform.skill].lvl <
            450 then return checkxue() end

        -- if parry > 450, always lingwu.
        if skills["parry"] and skills["parry"].lvl >= 450 then
            if skills["parry"].lvl < max_skill then
                flag.lingwu = 1
            else
                local skillsLingwu = {}
                skillsLingwu = utils.split(GetVariable("lingwuskills"), '|')
                for i, p in pairs(skillsLingwu) do
                    if skillEnable[p] == nil and skills[p] and skills[p].lvl <
                        max_skill then
                        flag.lingwu = 1
                        break
                    end
                end
            end
        end

        if flag.lingwu == 1 then return checklingwu() end

        if not flag.wxjz then flag.wxjz = 0 end
        if skills["wuxiang-zhi"] and flag.wxjz == 0 then
            if skills["finger"].lvl > skills["wuxiang-zhi"].lvl and
                skills["wuxiang-zhi"].lvl < max_skill then
                return wxjzFofa()
            end
        end
    end
    return check_job()
end

function lingwu_trigger()
    DeleteTriggerGroup("lingwu")
    create_trigger_t('lingwu1',
                     "^.*(��ֻ�ܴ����⼼��������|�㲻�����ּ��ܡ�|��Ҫ����ʲô��)",
                     '', 'lingwu_next')
    create_trigger_t('lingwu2',
                     "^.*���\\D*�������޷��������һ��Ļ���",
                     '', 'lingwu_next')
    create_trigger_t('lingwu3',
                     "^.*�������ڵĻ����ڹ���Ϊ�����޷���������ڹ���",
                     '', 'lingwu_next')
    create_trigger_t('lingwu4',
                     "^.*����ʵս���鲻�㣬�谭����ġ�\\D*������",
                     '', 'lingwu_next')
    SetTriggerOption("lingwu1", "group", "lingwu")
    SetTriggerOption("lingwu2", "group", "lingwu")
    SetTriggerOption("lingwu3", "group", "lingwu")
    SetTriggerOption("lingwu4", "group", "lingwu")
    EnableTriggerGroup("lingwu", false)
end

function checklingwu()
    if lingwudie == 0 then return lingwu() end
    if xxpot < hp.pot_max then return lingwu() end
    messageShow('����Ҫ����')
    return check_job()
end
function lingwu()
    DeleteTemporaryTriggers()
    skillsLingwu = {}
    skillsLingwu = utils.split(GetVariable("lingwuskills"), '|')
    road.temp = 0
    tmp.lingwu = 1
    tmp.stop = false
    lingwudie = 0
    return check_busy(lingwu_go)
end
function lingwu_go()
    messageShow('ȥ��������')
    jifaAll()
    go(lingwu_unwield, '��ɽ����', '��ĦԺ')
end
function lingwu_unwield()
    exe('hp')
    weaponWieldLearn()
    wait.make(function()
        wait_busy()
        if newbie == 1 then
            return lingwuzb()
        else
            return lingwuzbok()
        end
    end)
    -- return check_busy(lingwuzb) -- ��׼��������ֱ������
end
function lingwuzb() zhunbeineili(lingwuzbok) end
function lingwuzbok()
    lingwu_trigger()
    go(lingwu_goon, '��ɽ����', '��ĦԺ���')
end
function lingwuSleep()
    if score.gender == '��' then
        return go(lingwuSleepOver, "songshan/nan-room", "")
    else
        return go(lingwuSleepOver, "songshan/nv-room", "")
    end
end
function lingwuSleepOver()
    exe('sleep')
    checkWait(lingwu_eat, 3)
end

function lingwu_goon()
    if locl.room ~= "��ĦԺ���" then return lingwu_finish() end
    EnableTriggerGroup("lingwu", true)
    tmp.lingwustart = true
    if hp.neili < 1000 then
        if hp.exp > 20000000 or score.gender == '��' then
            exe('eat ' .. drug.neili)
            -- return go(lingwu_eat, '�䵱ɽ', '��ͤ')
        else
            return lingwuSleep()
        end
    end
    flag.idle = nil
    local skill_max = hp.pot_max - 100
    wait.make(function()
        SetSpeedWalkDelay(math.floor(1000 / 30))
        for i, skill in pairs(skillsLingwu) do
            if not skills[skill] or skills[skill].lvl == 0 or skills[skill].lvl >=
                skill_max then
                print("����Ҫѧϰ:" .. skill)
            else
                tmp.lingwunext = false
                local l, w
                while true do
                    exe('#9(lingwu ' .. skill .. ');yun jing')
                    l, w = wait.regexp(
                               '.*(�����������|���������˼����������������ö���|�����ھ�����|Ǳ���Ѿ�������)',
                               1)
                    if l == nil then
                        -- ���ܻ����˻���flood����ʱ����,

                    elseif l:find('��������') then
                        exe('eat ' .. drug.neili)
                        exe('eat ' .. drug.neili2 .. ';yun jing')
                    elseif l:find('Ǳ���Ѿ�������') then
                        return lingwu_finish()
                    elseif tmp.lingwunext then
                        tmp.lingwunext = false
                        break
                    end
                end
            end
        end
        flag.lingwu = 0
        lingwudie = 1
        xxpot = hp.pot_max
        -- return check_bei(lingwu_finish)
        wait_busy()
        -- SetSpeedWalkDelay(0)  --no need to set it back just set the flag and let queue auto determinate
        return lingwu_finish()
    end)
end
function lingwu_eat()
    if locl.room == "��ͤ" then
        flag.food = 0
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#4(drink cha);drop cha;drop tao;fill jiudai')
        check_bei(lingwu_go)
    else
        return go(lingwu_eat, '�䵱ɽ', '��ͤ')
    end
end

function lingwu_next() tmp.lingwunext = true end

function lingwu_finish()
    tmp.stop = true
    tmp.lingwustart = false
    messageShow('�����������')
    local skill = skillsLingwu[tmp.lingwu]
    EnableTriggerGroup("lingwu", false)
    DeleteTriggerGroup("lingwu")
    exe('cha')
    flag.lingwu = 0
    if tmp.lingwu ~= nil and tmp.lingwu > 1 and tmp.lingwu <=
        table.getn(skillsLingwu) then
        table.remove(skillsLingwu, tmp.lingwu)
        table.insert(skillsLingwu, 1, skill)
    end
    return check_jobx()
end

function xuexiTrigger()
    DeleteTriggerGroup("xuexi")
    DeleteTriggerGroup("litxuexi")
    create_trigger_t('xuexi1',
                     "^(> )*��(\\D*)" .. score.master .. "(\\D*)ָ��", '',
                     'xuexiAction')
    create_trigger_t('xuexi2', "^(> )*��������æ���ء�", '',
                     'xuexiAction')
    create_trigger_t('xuexi3',
                     "^(> )*�����̫���ˣ����ʲôҲû��ѧ����",
                     '', 'xuexiSleep')
    create_trigger_t('xuexi4',
                     "^(> )*(������|�㲻����ѧϰ��ϲ����|����ѧ|�㲻����ѧϰ|��Ļ��������δ��|�㲻�������|���̫��ȭ���̫ǳ|������Ѩ���˻Ƶ����Ҵ���ѧ|������Ѩ���˶�������ʦ������ѧ|������ԣ��޷�|���\\D*(����|����|��)����|��ɽ������ô�ݵ�|��һ������ү��|���Ѿ��޷����|��Ļ�������̫��|���а��̫��|�����һ���|��ת����ֻ��ͨ�����������|ѧ��ֻ��ѧ��������|����������ʿ|ֻ�д����֮��|�㲻������������|�㲻����ѧϰ����ѧ|����ѧֻ�ܿ��ж�|��Ķ���д��|��������ֻ��ͨ����ϰҽѧ|��Ļ��������δ��|���ŷ�ɮ������|�������ֻ��ͨ������ѧϰ��ʵս|��������Ѿ��޷�ͨ��ѧϰ|���������±����ұ���ѧ��|�����ȥѧ��ѧϰ����д��|Ҳ����ȱ��ʵս����|���(��˷�|�����ķ�)��Ϊ����|�������ĳ̶��Ѿ�������ʦ��)",
                     '', 'xuexiNext')
    create_trigger_t('xuexi5', "^(> )*��û����ô��Ǳ����ѧϰ", '',
                     'xuexiFinish')
    create_trigger_t('xuexi6', "^(> )*��Ҫ��˭��̣�", '', 'xuexiFinish')
    create_trigger_t('xuexi7', "^(> )*��ġ�(\\D*)�������ˣ�", '',
                     'xuexiLvlUp')
    create_trigger_t('xuexi8', "^(> )*����ö�̫��ȭ���������",
                     '', 'xueAskzhang')
    create_trigger_t('xuexi9',
                     "^(> )*Ǭ����Ų��ֻ��ͨ����ϰ��Ǭ����Ų���ķ��������������",
                     '', 'taoJiaozhang')
    create_trigger_t('xuexi10',
                     "^(> )*(�������б���|�����ֲ�����|���ַ�����ϰ|���������|����ʱ�޷���|��ʹ�õ���������|��\\D*����|ѧ\\D*����|\\D*���ﲻ����������)",
                     '', 'xueWeapon')
    SetTriggerOption("xuexi1", "group", "xuexi")
    SetTriggerOption("xuexi2", "group", "xuexi")
    SetTriggerOption("xuexi3", "group", "xuexi")
    SetTriggerOption("xuexi4", "group", "xuexi")
    SetTriggerOption("xuexi5", "group", "xuexi")
    SetTriggerOption("xuexi6", "group", "xuexi")
    SetTriggerOption("xuexi7", "group", "xuexi")
    SetTriggerOption("xuexi8", "group", "xuexi")
    SetTriggerOption("xuexi9", "group", "xuexi")
    SetTriggerOption("xuexi10", "group", "xuexi")
    EnableTriggerGroup("xuexi", false)
end
function checkxue()
    if xuefull == 0 then return xuexi() end
    if xxpot < hp.pot_max then return xuexi() end
    return check_job()
end

function xuexi()
    messageShow('������ѧϰ')
    master = {}

    if hp.exp < 150000 then
        master.times = 10
    else
        -- ain usepot
        master.times = math.modf(hp.jingxue / 60)
        if master.times > 50 then
            master.times = 50
        elseif master.times < 10 then
            master.times = 10
        end
    end

    master.skills = {}
    master.skills = utils.split(GetVariable("xuexiskill"), '|')

    flag.times = 1

    return check_halt(xuexiParty)
end
function xuexiParty()
    xuexiTrigger()
    if score.master then
        master.area = locateroom(score.master)
        if master.area then
            return go(xuexiCheck, master.area, master.room)
        else
            ColourNote("white", "blue",
                       "δ�ҵ�ʦ��סַ������ϵPTBX���£�")
            return xuexiFinish()
        end
    else
        return xuexiFinish()
    end
end
function xuexiCheck()
    checkWield()
    if locl.id[score.master] then
        if score.party and score.party == "������" and score.master ==
            "������ɮ" and skills["buddhism"] and skills["buddhism"].lvl ==
            200 then exe('ask wuming about ��') end
        return check_bei(xuexiStart)
    else
        ColourNote("white", "blue",
                   "ʦ�����ڼң�������ֵ�ַ�д�����ϵPTBX���£�")
        return xuexiFinish()
    end
end
function xuexiStart()
    EnableTriggerGroup("xuexi", true)

    tmp.xuexi = 1

    if master.id and locl.item and locl.item[score.master] and
        not locl.item[score.master][master.id] then master.id = nil end
    if not master.id and locl.item and locl.item[score.master] then
        master.id = locl.item[score.master]
        for p in pairs(locl.item[score.master]) do
            if not string.find(p, " ") then master.id = p end
        end
    end
    exe('bai ' .. master.id)

    weapon_unwield()

    if l_skill and weaponKind[l_skill] then
        if master.skills[tmp.xuexi] == "yuxiao-jian" then
            l_skill = "xiao"
        end
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == l_skill then
                exe('wield ' .. Bag[p].fullid)
            end
        end
    end
    -- yunAddInt()
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    checkWield()
    return xuexiContinue()
end
function xuexiAction()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    if hp.exp > 2000000 and hp.neili < 300 then
        prepare_neili(xuexiContinue)
    else
        check_bei(xuexiContinue)
    end
end
function xuexiContinue()
    flag.idle = nil
    xuefull = 0
    if hp.neili < 1000 and hqd_cur > 0 then exe('eat huangqi dan') end
    if hp.neili < 600 and hqd_cur > 0 then exe('eat huangqi dan') end
    EnableTriggerGroup("xuexi", true)
    wait.make(function()
        wait.time(1)
        exe('yun jing;xue ' .. master.id .. ' ' .. master.skills[tmp.xuexi] ..
                ' ' .. master.times)
        DeleteTimer("walkWait4")
        create_timer_s('walkWait4', 1.0, 'xuexi_again')
    end)
    print('ѧϰ����:' .. master.times)
    exe('hp')
end
function xuexi_again()
    exe(
        'yun jing;xue ' .. master.id .. ' ' .. master.skills[tmp.xuexi] .. ' ' ..
            master.times)
end
function taoJiaozhang()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    print('��С��Ǭ����Ų��')
    wait.make(function()
        wait.time(1)
        exe('#5 taojiao qiankundanuoyi;yun jing')
    end)
    check_busy(xuexiContinue)
end
function xueAskzhang()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    print('������̫��ȭ��')
    wait.make(function()
        wait.time(1)
        exe('ask zhang about ̫��ȭ��')
    end)
    check_busy(xuexiContinue)
end
function xueWeapon()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    tmp.skill = master.skills[tmp.xuexi]
    if skills[tmp.skill] then
        if skills[tmp.skill].lvl >= 450 then
            skills[tmp.skill].mstlvl = 450
        else
            skills[tmp.skill].mstlvl = skills[tmp.skill].lvl
        end
    end
    local l_skill = skillEnable[master.skills[tmp.xuexi]]
    weapon_unwield()
    if l_skill and weaponKind[l_skill] then
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == l_skill then
                exe('wield ' .. Bag[p].fullid)
            end
        end
        checkWield()
    end
    return check_bei(xuexiContinue)
end
function xuexiNext()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    tmp.skill = master.skills[tmp.xuexi]
    if skills[tmp.skill] then
        if skills[tmp.skill].lvl >= 450 then
            skills[tmp.skill].mstlvl = 450
        else
            skills[tmp.skill].mstlvl = skills[tmp.skill].lvl
        end
    end
    tmp.xuexi = tmp.xuexi + 1
    if tmp.xuexi > table.getn(master.skills) then
        xxpot = hp.pot_max
        xuefull = 1
        return xuexiFinish()
    end
    local l_skill = skillEnable[master.skills[tmp.xuexi]]
    weapon_unwield()
    if l_skill and weaponKind[l_skill] then
        if master.skills[tmp.xuexi] == "yuxiao-jian" then
            l_skill = "xiao"
        end
        for p in pairs(Bag) do
            if Bag[p].kind and Bag[p].kind == l_skill then
                exe('wield ' .. Bag[p].fullid)
            end
        end
        -- checkWield()
    end
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    checkWield()
    return check_bei(xuexiContinue)
end
function xuexiLvlUp(n, l, w)
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    for p in pairs(skills) do
        if skills[p].name == w[2] then
            skills[p].mstlvl = nil
            break
        end
    end
end
function xuexiSleep()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("xuexi", false)
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "������", "����")
    end
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "shaolin/sengshe3", "")
    end
    if score.party and score.party == "�һ���" then
        if score.master and score.master == "��ҩʦ" then
            return go(xuexiSleepOver, "�һ���", "�ͷ�")
        else
            return go(xuexiSleepOver, "����ׯ", "�ͷ�")
        end
    end
    if score.master and score.master == "���" then
        return go(xuexiSleepOver, "gumu/jqg/wshi", "")
    end
    if score.master and score.master == "С��Ů" then
        return go(xuexiSleepOver, "gumu/jqg/wshi", "")
    end
    if score.party and score.party == "�䵱��" and score.gender == 'Ů' then
        return go(xuexiSleepOver, "�䵱ɽ", "Ů��Ϣ��")
    end
    if score.party and score.party == "�䵱��" and score.gender == '��' then
        return go(xuexiSleepOver, "�䵱ɽ", "����Ϣ��")
    end
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "dali/wangfu/woshi2", "")
    end
    if score.party and score.party == "����Ľ��" then
        return go(xuexiSleepOver, "����Ľ��", "�᷿")
    end
    if score.party and score.party == "������" then
        return go(xxSleepcheck, "���޺�", "��ң��")
    end
    if score.party and score.party == "������" then
        return go(xuexiSleepOver, "����ɽ", "��Ϣ��")
    end
    if score.party and score.party == "��ɽ��" and score.gender == '��' then
        return go(xuexiSleepOver, "��ɽ", "����Ϣ��")
    end
    if score.party and score.party == "��ɽ��" and score.gender == 'Ů' then
        return go(xuexiSleepOver, "��ɽ", "Ů��Ϣ��")
    end
    if score.party and score.party == "���ư�" and score.gender == '��' then
        return go(xuexiSleepOver, "����ɽ", "����Ϣ��")
    end
    if score.party and score.party == "���ư�" and score.gender == 'Ů' then
        return go(xuexiSleepOver, "����ɽ", "Ů��Ϣ��")
    end
    if score.party and score.party == "ؤ��" then
        -- return go(xuexiSleepOver, "chengdu/houyuan", "")
        wait.make(function()
            wait_busy()
            exe('sleep')
            wait_busy()
            return xuexiStart()
        end)
    else
        return xuexiFinish()
    end
end
function xxSleepcheck()
    exe('give caihua 1 coin')
    wait.make(function()
        wait.time(1)
        exe('enter;sleep')
        xuexiSleepOver()
    end)
end
function xuexiSleepOver()
    exe('sleep')
    checkWait(xuexiParty, 3)
end
function xuexiFinish()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    messageShow('ѧϰ��ϣ�')
    flag.xuexi = 0
    EnableTriggerGroup("xuexi", false)
    DeleteTriggerGroup("xuexi")
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('cha;unwield ' .. leweapon)
    checkWield()
    dis_all()
    return check_busy(check_food)
end

function check_xuexi()
    if MidHsDay[locl.time] and score.master == '������' then
        return check_job()
    end
    -- if needxuexi==0 then
    -- return check_job()
    -- end
    -- if needxuexi==1 then
    return check_pot()
    -- end
end
function literate()
    messageShow('ѧϰ����д�֣�')
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 10
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then
            master.times = 50
        elseif master.times < 10 then
            master.times = 10
        end
    end
    return check_busy(literateGo)
end
function literateGo()
    weapon_unwield()
    local leweapon = GetVariable("learnweapon")
    exe('wield ' .. leweapon)
    checkWield()
    go(literateCheck, '���ݳ�', '��Ժ')
end
function literateCheck()
    DeleteTriggerGroup("litxuexi")
    create_trigger_t('litxuexi1',
                     "^(> )*����������������һ�����������������ƣ���ʱ�޷��ٽ��޸������ѧ���ˡ���",
                     '', 'litxuexiover')
    create_trigger_t('litxuexi2',
                     "^(> )*�����̫���ˣ����ʲôҲû��ѧ��",
                     '', 'litxuexisleep')
    create_trigger_t('litxuexi3',
                     "^.*˵������̫�����ˣ�����ô�ҵ���", '',
                     'litxuexiover')
    SetTriggerOption("litxuexi1", "group", "litxuexi")
    SetTriggerOption("litxuexi2", "group", "litxuexi")
    SetTriggerOption("litxuexi3", "group", "litxuexi")
    EnableTriggerGroup("litxuexi", true)
    flag.idle = nil
    exe('hp')
    return checkWait(literateXue, 0.8)
end
function litxuexiover()
    DeleteTriggerGroup("litxuexi")
    dis_all()
    return check_halt(literateBack)
end
function literateXue()
    if not locl.id["������"] then return literateBack() end
    if hp.neili < 100 then
        if hqd_cur > 0 then
            exe('eat huangqi dan')
        elseif hp.exp < 800000 and needxuexi == 1 then
            return xuexi()
        else
            return literateBack()
        end
    end
    if hp.neili < 1000 then exe('eat ' .. drug.neili2) end
    if hp.pot > master.times - 1 then
        -- yunAddInt()
        exe('yun jing;xue gu literate ' .. master.times)
        return check_busy(literateCheck)
    elseif hp.pot < master.times then
        return literateBack()
    else
        return literateBack()
    end
end
function literateBack()
    messageShow('����д��ѧϰ��ϣ�')
    weapon_unwield()
    -- local leweapon = GetVariable("learnweapon")
    -- exe('unwield ' .. leweapon)
    exe('hp;score;cha;yun jing;yun qi;yun jingli')
    dis_all()
    checkWield()
    return check_busy(check_food)
end
function litxuexisleep()
    if score.gender == '��' then
        return go(litxuexiSleepOver, "songshan/nan-room", "")
    else
        return go(litxuexiSleepOver, "songshan/nv-room", "")
    end
end
function litxuexiSleepOver()
    exe('sleep')
    checkWait(checkPrepare, 3)
end
function duanzao()
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 3
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then master.times = 50 end
    end
    return check_busy(duanzaoGo)
end
function duanzaoGo() return go(duanzaoCheck, '���ݳ�', '������') end
function duanzaoCheck()
    flag.idle = nil
    exe('score;hp;cha')
    checkBags()
    return checkWait(duanzaoXue, 0.8)
end
function duanzaoXue()
    if not locl.id["����ʦ"] then return duanzaoBack() end
    if hp.neili < 100 then
        if hqd_cur > 0 then
            exe('eat huangqi dan')
        else
            return duanzaoBack()
        end
    end
    if hp.neili < 1000 then exe('eat ' .. drug.neili2) end
    if skills["duanzao"] and skills["duanzao"].lvl >= 221 then
        return duanzaoBack()
    end
    if Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt > 30 and
        hp.pot > master.times - 1 then
        -- yunAddInt()
        exe('yun jing;xue shi duanzao ' .. master.times)
        return duanzaoCheck()
    elseif hp.pot < master.times then
        return duanzaoBack()
    elseif score.gold > 300 then
        return check_bei(duanzaoQu, 1)
    else
        return duanzaoBack()
    end
end
function duanzaoQu()
    exe('n;#3w;#3n;w;qu 30 gold')
    exe('e;#3s;#3e;s')
    return check_busy(duanzaoCheck, 1)
end
function duanzaoBack()
    exe('hp')
    return check_busy(check_food)
end

function zhizao()
    DeleteTemporaryTriggers()
    if hp.exp < 151000 then
        master.times = 3
    else
        master.times = math.modf(hp.jingxue / 120)
        if master.times > 50 then master.times = 50 end
    end
    return check_busy(zhizaoGo)
end
function zhizaoGo() return go(zhizaoCheck, '�����', '�÷��') end
function zhizaoCheck()
    flag.idle = nil
    exe('score;hp;cha')
    checkBags()
    return checkWait(zhizaoXue, 0.8)
end
function zhizaoXue()
    if not locl.id["�ϲ÷�"] then return zhizaoBack() end
    if hp.neili < 100 then
        if hqd_cur > 0 then
            exe('eat huangqi dan')
        else
            return zhizaoBack()
        end
    end
    if hp.neili < 1000 then exe('eat ' .. drug.neili2) end
    if skills["zhizao"] and skills["zhizao"].lvl >= 221 then
        return zhizaoBack()
    end
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt > 30 and hp.pot >
        master.times - 1 then
        -- yunAddInt()
        exe('yun jing;xue caifeng zhizao ' .. master.times)
        return zhizaoCheck()
    elseif hp.pot < master.times then
        return zhizaoBack()
    elseif score.gold > 300 then
        return check_bei(zhizaoQu, 1)
    else
        return zhizaoBack()
    end
end
function zhizaoQu()
    exe('e;n;#3e;n;qu 30 gold')
    exe('s;#3w;s;w')
    return check_busy(zhizaoCheck, 1)
end
function zhizaoBack()
    exe('hp')
    return check_busy(check_food)
end

function lianxi(times, xskill)
    local weapontype
    flag.lianxi = 1
    local lianxi_times = 5
    if times ~= nil then lianxi_times = times end
    tmp.xskill = xskill
    if perform.force then
        if not skills[perform.force] then perform.force = nil end
    end
    if not perform.force then
        tmp.lvl = 0
        for p in pairs(skills) do
            q = skillEnable[p]
            if q == "force" then
                if skills[p].lvl > tmp.lvl then
                    tmp.lvl = skills[p].lvl
                    perform.force = p
                end
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if (not tmp.xskill or tmp.xskill == p) and q == "force" and
                skills[p].full == 0 and perform.force and perform.force == p then
                lianxi_times = lianxi_times * 0.5
                exe('lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                exe('hp')
                break
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if (not tmp.xskill or tmp.xskill == p) and q == "dodge" and
                skills[p].full == 0 then
                exe('bei none;jifa ' .. q .. ' ' .. p)
                exe('lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                break
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if p == "yuxiao-jian" then
                weapontype = "xiao"
            else
                weapontype = q
            end
            if (not tmp.xskill or tmp.xskill == p) and q and p == perform.skill and
                skills[p].full == 0 and
                ((weaponKind[weapontype] and weaponInBag(weapontype)) or
                    unarmedKind[q]) then
                exe('bei none;jifa ' .. q .. ' ' .. p)
                weapon_unwield()
                if weaponKind[q] then
                    exe('wield ' .. q)
                    for k, v in pairs(Bag) do
                        if Bag[k].kind == weapontype then
                            exe('wield ' .. Bag[k].fullid)
                        end
                    end
                end
                exe('i;lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                break
            end
        end
    end
    if flag.lianxi == 1 then
        for p in pairs(skills) do
            q = skillEnable[p]
            if p == "yuxiao-jian" then
                weapontype = "xiao"
            else
                weapontype = q
            end
            if (not tmp.xskill or tmp.xskill == p) and q and q ~= "force" and
                skills[p].full == 0 and
                ((weaponKind[weapontype] and weaponInBag(weapontype)) or
                    unarmedKind[q]) then
                exe('bei none;jifa ' .. q .. ' ' .. p)
                weapon_unwield()
                if weaponKind[q] then
                    exe('wield ' .. q)
                    for k, v in pairs(Bag) do
                        if Bag[k].kind == weapontype then
                            exe('wield ' .. Bag[k].fullid)
                        end
                    end
                end
                exe('i;lian ' .. q .. ' ' .. lianxi_times)
                flag.lianxi = 0
                tmp.pskill = p
                break
            end
        end
    end
    beiUnarmed()
end
function beiUnarmed()
    local l_skill = beiUnarmedSkill()
    if l_skill and type(l_skill) == "string" and skillEnable[l_skill] then
        exe('bei none')
        exe('jifa ' .. skillEnable[l_skill] .. ' ' .. l_skill)
        exe('bei ' .. skillEnable[l_skill])
    end
    if skillHubei[l_skill] and skills[skillHubei[l_skill]] then
        l_skill = skillHubei[l_skill]
        exe('jifa ' .. skillEnable[l_skill] .. ' ' .. l_skill)
        exe('bei ' .. skillEnable[l_skill])
    end
end
function beiUnarmedSkill()
    local l_lvl = 0
    local l_skill
    if perform and perform.skill and skillEnable[perform.skill] and
        unarmedKind[skillEnable[perform.skill]] then
        -- exe('bei '.. skillEnable[perform.skill])
        return perform.skill
    end
    for p in pairs(flagFull) do
        if skills[p] and skillEnable[p] and unarmedKind[skillEnable[p]] then
            q = skillEnable[p]
            -- exe('bei none;jifa '..q..' '..p..';bei '..q)
            return p
        end
    end
    if score.party then
        if score.party == "������" and skills["hand"] and
            skills["jieshou-jiushi"] then
            -- exe('bei none;jifa hand jieshou-jiushi;bei hand')
            return "jieshou-jiushi"
        end
        if score.party == "ؤ��" and skills["strike"] and
            skills["xianglong-zhang"] then
            -- exe('bei none;jifa strike xianglong-zhang;bei strike')
            return "xianglong-zhang"
        end
    end
    for p in pairs(skills) do
        if skillEnable[p] then
            q = skillEnable[p]
            if unarmedKind[q] then
                if skills[p].lvl > l_lvl then
                    l_lvl = skills[p].lvl
                    l_skill = p
                    -- exe('bei none;jifa '..q..' '..p..';bei '..q)
                end
            end
        end
    end
    return l_skill
end

function checkWield()
    itemWield = {}
    exe('i')
end
function checkWieldCatch(n, l, w)
    itemWield = itemWield or {}
    local l_item = w[1]
    for p in pairs(weaponThrowing) do
        if string.find(l_item, p) then l_item = p end
    end
    itemWield[l_item] = true
end
function show_beinang()
    DeleteTriggerGroup("beinang")
    create_trigger_t('beinang1', '^(> )*(\\D*)\\(', '', 'checkbeinang')
    SetTriggerOption("beinang1", "group", "beinang")
    EnableTriggerGroup("beinang", true)
    Beinang = {}
end
function checkbeinang(n, l, w) table.insert(Beinang, Trim(w[2])) end
function checkYaoBags(func)
    DeleteTriggerGroup("Yaobags")
    create_trigger_t('Yaobags1',
                     '^(> )*(\\D*)(��|��|��)(����|�ƽ�|ҼǪ����Ʊ)\\(',
                     '', 'checkBagsMoney')
    create_trigger_t('Yaobags2',
                     '^(> )*��� "action" �趨Ϊ "���ҩƷ" �ɹ���ɡ�$',
                     '', 'checkYaoBagsOver')
    create_trigger_t('Yaobags3', '^(> )*(\\D*)��ʧ����ż�', '',
                     'checkBagsletter')
    SetTriggerOption("Yaobags1", "group", "Yaobags")
    SetTriggerOption("Yaobags2", "group", "Yaobags")
    SetTriggerOption("Yaobags3", "group", "Yaobags")
    EnableTriggerGroup("Yaobags", true)
    cty_cur = 0
    nxw_cur = 0
    cbw_cur = 0
    hqd_cur = 0
    hxd_cur = 0
    -- print(cty_cur,nxw_cur,hxd_cur)
    Bag["�ƽ�"].cnt = 0
    Bag["����"].cnt = 0
    tmp.yaobags = func
    exe('i;look bei nang')
    exe('alias action ���ҩƷ')
end
function checkYaoBagsOver()
    checkBY()
    draw_beinangwindow()
    EnableTriggerGroup("Yaobags", false)
    DeleteTriggerGroup("Yaobags")
    EnableTriggerGroup("beinang", false)
    DeleteTriggerGroup("beinang")
    -- print(cty_cur,nxw_cur,hxd_cur)
    if tmp.yaobags ~= nil then return tmp.yaobags() end
end

function checkBY()
    if not Beinang then Beinang = {"��"} end
    for i = 1, #Beinang do
        if Beinang[i] == "" or Beinang[i] == nil then
            Beinang[i] = "���ݶ�ʧ"
        end
        local l_name = Beinang[i]
        if string.find(l_name, "���ɽ�ҩ") then
            cty_cur = trans(Beinang[i])
        end
        if string.find(l_name, "����Ϣ��") then
            nxw_cur = trans(Beinang[i])
        end
        if string.find(l_name, "������Ϣ��") then
            cbw_cur = trans(Beinang[i])
        end
        if string.find(l_name, "������Ϣ��") then
            hqd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "��Ѫ�ƾ���") then
            hxd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "�󻹵�") then
            dhd_cur = trans(Beinang[i])
        end
        if string.find(l_name, "����ʯ") then
            kuang_cur = trans(Beinang[i])
        elseif l_name:find("���ʯ") then
            kuang_cur1 = trans(Beinang[i])
        end
        -- print(cty_cur,nxw_cur,hxd_cur,dhd_cur)
    end
end

function checkBags(func)
    DeleteTriggerGroup("bags")
    create_trigger_t('bags1', "^(> )*������Я����Ʒ�ı������", '',
                     'checkBagsStart')
    create_trigger_t('bags2', "^\\d*:(\\D*) = (\\D*)$", '', 'checkBagsId')
    create_trigger_t('bags3',
                     '^(> )*��Ŀǰ�Ѿ�ӵ����(\\D*)��˽��װ����(\\D*)��$',
                     '', 'checkBagsU')
    create_trigger_t('bags4',
                     '^(> )*(\\D*)(��|��|��)(����|�ƽ�|ҼǪ����Ʊ)\\(',
                     '', 'checkBagsMoney')
    create_trigger_t('bags5',
                     '^(> )*��� "action" �趨Ϊ "������" �ɹ���ɡ�$',
                     '', 'checkBagsOver')
    create_trigger_t('bags6', '^(> )*(\\D*)��ʧ����ż�', '',
                     'checkBagsletter')
    create_trigger_t('bags7', '^(> )*(\\D*)ö����\\(', '', 'checkBagsDart')
    create_trigger_t('bags8',
                     '^(> )*�����ϴ���(\\D*)������\\(����\\s*(\\d*)\\.\\d*\\%\\)��',
                     '', 'checkBagsW')
    SetTriggerOption("bags1", "group", "bags")
    SetTriggerOption("bags2", "group", "bags")
    SetTriggerOption("bags3", "group", "bags")
    SetTriggerOption("bags4", "group", "bags")
    SetTriggerOption("bags5", "group", "bags")
    SetTriggerOption("bags6", "group", "bags")
    SetTriggerOption("bags7", "group", "bags")
    SetTriggerOption("bags8", "group", "bags")
    EnableTriggerGroup("bags", false)
    EnableTrigger("bags1", true)
    cty_cur = 0
    nxw_cur = 0
    cbw_cur = 0
    hqd_cur = 0
    hxd_cur = 0
    -- print(cty_cur,nxw_cur,hxd_cur)
    bags = {}
    Bag = {}
    Bag["�ƽ�"] = {}
    Bag["�ƽ�"].id = {}
    Bag["�ƽ�"].cnt = 0
    Bag["����"] = {}
    Bag["����"].id = {}
    Bag["����"].cnt = 0
    Bag["ö����"] = {}
    Bag["ö����"].id = {}
    Bag["ö����"].cnt = 0
    tmp.bags = func
    weaponUsave = {}
    exe('id')
    checkWield()
    exe('look bei nang')
    exe('uweapon;alias action ������')
end
function checkBagsletter() lostletter = 1 end
function checkBagsStart() EnableTriggerGroup("bags", true) end
function checkBagsId(n, l, w)
    local l_name = Trim(w[1])
    local l_id = w[2]
    local l_set = {}
    local l_cnt = 0
    if not Bag[l_name] then Bag[l_name] = {} end
    Bag[l_name].id = {}
    if string.find(l_id, ",") then
        l_set = utils.split(l_id, ',')
        l_id = l_set[1]
        for k, v in ipairs(l_set) do
            -- table.insert(Bag[l_name].id,1,Trim(v))
            Bag[l_name].id[Trim(v)] = true
            if string.len(Trim(v)) > l_cnt then
                Bag[l_name].fullid = Trim(v)
                l_cnt = string.len(Trim(v))
            end
        end
    else
        Bag[l_name].id[Trim(l_id)] = true
        -- table.insert(Bag[l_name].id,1,Trim(l_id))
        Bag[l_name].fullid = Trim(l_id)
    end
    if Bag[l_name].id["armor"] then Bag[l_name].kind = "armor" end
    if Bag[l_name].id["glove"] then Bag[l_name].kind = "glove" end
    if Bag[l_name].id["boot"] then Bag[l_name].kind = "boot" end
    if Bag[l_name].id["mantle"] then Bag[l_name].kind = "mantle" end
    if Bag[l_name].id["coat"] then Bag[l_name].kind = "coat" end
    if Bag[l_name].id["cap"] then Bag[l_name].kind = "cap" end
    if Bag[l_name].id["belt"] then Bag[l_name].kind = "belt" end
    if Bag[l_name].id["dao"] or Bag[l_name].id["blade"] then
        Bag[l_name].kind = "blade"
    end
    if Bag[l_name].id["jian"] or Bag[l_name].id["sword"] then
        Bag[l_name].kind = "sword"
    end
    if Bag[l_name].id["xiao"] then Bag[l_name].kind = "xiao" end
    if Bag[l_name].id["gun"] or Bag[l_name].id["club"] then
        Bag[l_name].kind = "club"
    end
    if Bag[l_name].id["stick"] or Bag[l_name].id["zhubang"] or
        Bag[l_name].id["bang"] then Bag[l_name].kind = "stick" end
    if Bag[l_name].id["bi"] or Bag[l_name].id["brush"] then
        Bag[l_name].kind = "brush"
    end
    if Bag[l_name].id["qiang"] or Bag[l_name].id["spear"] then
        Bag[l_name].kind = "spear"
    end
    if Bag[l_name].id["chui"] or Bag[l_name].id["hammer"] then
        Bag[l_name].kind = "hammer"
    end
    if Bag[l_name].id["gangzhang"] or Bag[l_name].id["staff"] or
        Bag[l_name].id["zhang"] or Bag[l_name].id["jiang"] then
        Bag[l_name].kind = "staff"
    end
    if Bag[l_name].id["bian"] or Bag[l_name].id["whip"] then
        Bag[l_name].kind = "whip"
    end
    if Bag[l_name].id["hook"] then Bag[l_name].kind = "hook" end
    if Bag[l_name].id["fu"] or Bag[l_name].id["axe"] then
        Bag[l_name].kind = "axe"
    end
    if Bag[l_name].id["bishou"] or Bag[l_name].id["dagger"] then
        Bag[l_name].kind = "dagger"
    end
    if weaponThrowing[l_name] then Bag[l_name].kind = "throwing" end
    if (string.find(l_name, "��ƪ") or string.find(l_name, "��Ҫ")) and
        not itemSave[l_name] then
        exe('read book')
        exe('drop ' .. Bag[l_name].fullid)
    end
    if string.len(l_name) == 6 and
        (string.sub(l_name, 5, 6) == "ҩ" or string.sub(l_name, 5, 6) == "��" or
            string.sub(l_name, 5, 6) == "��") and
        (not drugPoison[l_name] and not drugBuy[l_name]) then
        exe('eat ' .. Bag[l_name].fullid)
    end
    bags[l_name] = Trim(l_id)
    if Bag[l_name].cnt then
        Bag[l_name].cnt = Bag[l_name].cnt + 1
    else
        Bag[l_name].cnt = 1
    end
end
function checkBagsU(n, l, w)
    local t = Trim(w[3])
    local s = utils.split(t, ',')
    for p, q in pairs(s) do
        if string.find(q, '��') then q = string.sub(q, 3) end
        weaponUsave[q] = true
    end
end
function checkBagsMoney(n, l, w)
    local l_cnt = trans(Trim(w[2]))
    local l_name = Trim(w[4])
    if Bag[l_name] then Bag[l_name].cnt = l_cnt end
end
function checkBagsW(n, l, w)
    local t = tonumber(w[3])
    Bag = Bag or {}
    Bag["ENCB"] = {}
    Bag["ENCB"].value = t
end
function checkBagsDart(n, l, w)
    local l_cnt = trans(Trim(w[2]))
    local l_name = 'ö����'
    if Bag[l_name] then Bag[l_name].cnt = l_cnt end
end
--[[function checkBagsYao(n,l,w)
   local l_cnt=trans(Trim(w[2]))
   local l_name=Trim(w[3])
  if string.find(l_name,"���ɽ�ҩ") then
	   cty_cur = l_cnt
	end
	if string.find(l_name,"������Ϣ��") then
	   nxw_cur = l_cnt
	end
	if string.find(l_name,"��Ѫ�ƾ���") then
	   hxd_cur = l_cnt
	end
	if string.find(l_name,"�󻹵�") then
	   dhd_cur = l_cnt
	end
end]]
function checkBagsOver()
    draw_bagwindow()
    checkBY()
    draw_beinangwindow()
    EnableTriggerGroup("bags", false)
    DeleteTriggerGroup("bags")
    EnableTriggerGroup("beinang", false)
    DeleteTriggerGroup("beinang")
    if Bag["�����"] then exe("drop cha") end
    if Bag["�޻�����"] then exe('drop ' .. Bag["�޻�����"].fullid) end
    if Bag["�޻�"] then exe('drop ' .. Bag["�޻�"].fullid) end
    if Bag["��ͭ"] then exe('drop ' .. Bag["��ͭ"].fullid) end
    if Bag["����"] then exe('drop ' .. Bag["����"].fullid) end
    if Bag["������"] and Bag["������"].cnt > 2 then
        exe('drop cu shengzi 2')
    end
    -- print(cty_cur,nxw_cur,hxd_cur)
    if tmp.bags ~= nil then return tmp.bags() end
end

function isInBags(p_item)
    if p_item == nil then return false end
    local l_cnt = 0
    local l_item
    if Bag[p_item] then
        l_item = p_item
        l_cnt = l_cnt + Bag[p_item].cnt
        -- return p_item,Bag[p_item].cnt
    end
    for k, v in pairs(Bag) do
        if type(v.id) == "table" then
            if v.id[p_item] then
                l_item = k
                l_cnt = l_cnt + Bag[k].cnt
            end
        end
    end
    if l_cnt > 0 then return l_item, l_cnt end
    return false
end

function check_item()
    if score.party and score.party == "������" and not Bag["����"] then
        return check_item_go()
    elseif score.party == "������" and not Bag["����"] and
        not Bag["����"] then
        return go(checkSengxie, '��ɽ����', '���߿�')
    else
        return check_item_over()
    end
end
function checkSengxie()
    exe('ask chanshi about ɮЬ')
    return check_bei(checkHuyao)
end
function checkHuyao()
    exe('ask chanshi about ����')
    return check_bei(checkHuwan)
end
function checkHuwan()
    exe('ask chanshi about ����')
    return check_bei(check_item_over)
end
function check_item_go() go(check_item_belt, '����ɽ', '�����') end
function check_item_belt()
    exe('ask shitai about Ƥ����')
    check_bei(check_item_over)
end
function check_item_over()
    exe('drop shoes 2')
    exe('remove all')
    exe('wear all')

    flag.item = true

    return checkPrepare()
end
function VIPask()
    exe('ask laoban about ��Ա�ɳ�')
    check_bei(VIPask2)
end
function VIPask2()
    exe('ask laoban about ��Ա����')
    check_bei(Ebookcheck)
end
function Ebookcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Ebookcheck
    create_trigger_t('vipchk1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipEbookck')
    create_trigger_t('vipchk2', "^(> )*���������޷�ʹ�þ�Ӣ֮�顣",
                     '', 'Yjwcheck')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        return exe('duihuan ebook')
    else
        return Gstart()
    end
end
function vipEbookck() check_halt(vipEbook) end
function vipEbook() exe('duihuan ebook') end
function Yjwcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Yjwcheck
    create_trigger_t('vipchk1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipYjwck')
    create_trigger_t('vipchk2', "^(> )*���������޷�ʹ�����衣",
                     '', 'Ygcheck')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        return check_halt(vipYjw)
    else
        return Gstart()
    end
end
function vipYjwck() check_halt(vipYjw) end
function vipYjw() exe('duihuan yuji wan') end
function Ygcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id Yjwcheck
    create_trigger_t('vipchk1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipYggo')
    create_trigger_t('vipchk2', "^(> )*���������޷�ʹ��ԧ�������",
                     '', 'Gstart')
    create_trigger_t('vipchk3', "^(> )*�������һ��ԧ�����", '',
                     'vipYgok')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    SetTriggerOption("vipchk3", "group", "vipchk")
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        return check_halt(vipYg)
    else
        return Gstart()
    end
end
function vipYggo() return go(vipGhyg, '�����', '���') end
function vipGhyg() exe('guihuan ying gu') end
function vipYgok() return go(vipYg, '���ݳ�', '����') end
function vipYg() exe('duihuan jinpa') end
function Vipcheck()
    DeleteTriggerGroup("vipchk")
    -- ain dls nv id vipcheck
    create_trigger_t('vipchk1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipxidu')
    create_trigger_t('vipchk2', "^(> )*����쾦����Ѿ������ˡ�",
                     '', 'vipxidu_over')
    create_trigger_t('vipchk3', "^(> )*���������޷�ʹ��", '', 'vipover')
    create_trigger_t('vipchk4',
                     "^(> )*����Ҫ�������е���Ʒ�����ٴζһ���",
                     '', 'vipxidu')
    SetTriggerOption("vipchk1", "group", "vipchk")
    SetTriggerOption("vipchk2", "group", "vipchk")
    SetTriggerOption("vipchk3", "group", "vipchk")
    SetTriggerOption("vipchk4", "group", "vipchk")
    -- if vippoison==1 and ptbxvip==1 then
    -- return exe('duihuan bingchan')
    -- else
    return check_xue()
    -- end
end
function vipxidu() return check_busy(xidu) end
function xidu() exe('xidu') end
function vipxidu_over()
    EnableTriggerGroup("vipchk", false)
    DeleteTriggerGroup("vipchk")
    vippoison = 0
    return check_halt(vipdhd)
end
function vipdhd()
    DeleteTriggerGroup("vipdhd")
    -- ain dls nv id vipcheck
    create_trigger_t('vipdhd1',
                     "^(> )*���Ǳ�վ�����Ա�����ι�����ѡ�",
                     '', 'vipeatdhd')
    create_trigger_t('vipdhd2', "^(> )*��Ĵ󻹵��Ѿ������ˡ�", '',
                     'vipdhd_over')
    create_trigger_t('vipdhd3', "^(> )*���������޷�ʹ��", '', 'vipover')
    create_trigger_t('vipdhd4',
                     "^(> )*����Ҫ�������е���Ʒ�����ٴζһ���",
                     '', 'vipeatdhd')
    create_trigger_t('vipdhd5', "^(> )*������㣬�ⶫ���ܳ���",
                     '', 'vipdhd_over')
    SetTriggerOption("vipdhd1", "group", "vipdhd")
    SetTriggerOption("vipdhd2", "group", "vipdhd")
    SetTriggerOption("vipdhd3", "group", "vipdhd")
    SetTriggerOption("vipdhd4", "group", "vipdhd")
    SetTriggerOption("vipdhd5", "group", "vipdhd")
    exe('duihuan dahuan dan')
end
function vipeatdhd() return check_busy(eatdhd) end
function eatdhd() exe('eat dan') end
function vipdhd_over()
    EnableTriggerGroup("vipdhd", false)
    DeleteTriggerGroup("vipdhd")
    return check_halt(checkPrepare)
end
function vipover()
    EnableTriggerGroup("vipchk", false)
    DeleteTriggerGroup("vipchk")
    EnableTriggerGroup("vipdhd", false)
    DeleteTriggerGroup("vipdhd")
    ptbxvip = 0
    inwdj = 0
    return check_xue()
end
function checkvip()
    if score.id and score.id == 'ptbx' and ptbxvip == 1 then
        exe('cond')
        return go(Vipcheck, '���ݳ�', '����')
    else
        return check_xue()
    end
end
function check_heal()
    collectgarbage("collect")
    dis_all()
    tmp = {}
    jobTriggerDel()
    job.name = 'heal'
    if score.party and score.party == "������" then
        exe('yun shougong ' .. score.id)
    end
    if perform.force and skills[perform.force] then
        exe('jifa force ' .. perform.force)
    end
    button_smyteam()
    button_lostletter()
    check_halt(check_jingxue_count)
end
function check_jingxue_count()
    checkBags()
    if hp.exp < 150000 then
        return checkWait(check_heal_over, 1)
    elseif (hp.exp > 150000 and hp.exp < 800000) then
        -- return checkWait(check_heal_newbie,1)
        return go(check_heal_newbie, "���ݳ�", "ҩ��")
    elseif hp.jingxue_per < 96 or hp.qixue_per < 88 then
        return checkWait(checkvip, 1)
    else
        return checkWait(check_jingxue, 1)
    end
end
function check_jingxue()
    if (hp.qixue_per < 98 and hp.qixue_per > 88) and cty_cur > 0 then
        exe('eat chantui yao;hp')
        return check_busy(check_jingxue, 1)
    else
        if cty_cur == 0 then return checkHxd() end
        -- ain
        if score.party == "������" and hp.neili > 2000 then
            exe('yun juxue')
        end
        return check_halt(check_heal_over, 1)
    end
end
function check_heal_newbie()
    if hp.qixue_per < 100 then
        exe('buy jinchuang yao;eat jinchuang yao;hp')
        return check_busy(check_heal_newbie, 3)
    else
        if hp.jingxue_per < 100 then
            exe('buy yangjing dan;eat yangjing dan')
        end
        return check_halt(check_heal_over, 1)
    end
end
function check_heal_over()
    DeleteTriggerGroup("ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    DeleteTriggerGroup("ck_xue_teach")
    return check_halt(checkPrepare)
end
function check_xue()
    EnableTrigger("hp19", false)
    tmp.xueSkills = {}
    tmp.xueCount = 1
    tmp.xueTimes = 0
    for p in pairs(skills) do
        if skills[p].lvl > 100 then table.insert(tmp.xueSkills, p) end
    end
    if hp.exp > 500000 then
        return go(check_xue_ask, '������', '����')
    else
        return check_xue_fail()
    end
end
function check_xue_ask()
    DeleteTriggerGroup("ck_xue_ask")
    create_trigger_t('ck_xue_ask1',
                     '^(> )*����ѦĽ�������йء����ˡ�����Ϣ��$',
                     '', 'check_xue_accept')
    create_trigger_t('ck_xue_ask2', '^(> )*����û�������', '',
                     'check_xue_fail')
    SetTriggerOption("ck_xue_ask1", "group", "ck_xue_ask")
    SetTriggerOption("ck_xue_ask2", "group", "ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    create_trigger_t('ck_xue_accept1',
                     '^(> )*ѦĽ�����ٺٺ١���Ц�˼�����$', '',
                     'check_xue_teach')
    create_trigger_t('ck_xue_accept2',
                     '^(> )*һ����Ĺ����ȥ�ˣ�����������Ѿ�����Ȭ���ˡ�',
                     '', 'check_xue_heal')
    create_trigger_t('ck_xue_accept3',
                     '^(> )*Ѧ��ҽ�ó�һ�������������������˲�λ������Ѩ��',
                     '', 'check_xue_wait')
    create_trigger_t('ck_xue_accept4',
                     '^(> )*ѦĽ���ƺ����������˼��$', '',
                     'check_xue_heal')
    create_trigger_t('ck_xue_accept5',
                     '^(> )*ѦĽ����ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����',
                     '', 'check_xue_fail')
    SetTriggerOption("ck_xue_accept1", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept2", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept3", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept4", "group", "ck_xue_accept")
    SetTriggerOption("ck_xue_accept5", "group", "ck_xue_accept")
    EnableTriggerGroup("ck_xue_accept", false)
    DeleteTriggerGroup("ck_xue_teach")
    create_trigger_t('ck_xue_teach1',
                     '^(> )*Ѧ��ҽ����������Ѿ������ٽ����ˡ�$',
                     '', 'check_xue_next')
    SetTriggerOption("ck_xue_teach1", "group", "ck_xue_teach")
    EnableTriggerGroup("ck_xue_teach", false)
    DeleteTriggerGroup("ck_xue_busy")
    create_trigger_t('ck_xue_busy1', '^(> )*����Ъ������˵���ɡ�$',
                     '', 'check_xue_busy')
    SetTriggerOption("ck_xue_busy1", "group", "ck_xue_busy")
    EnableTriggerGroup("ck_xue_busy", true)
    exe('ask xue muhua about ����')
    create_timer_s('walkWait4', 3.0, 'check_xue_ask1')
end
function check_xue_ask1() exe('ask xue muhua about ����') end
function check_xue_busy() return check_busy(check_xue_ok, 2) end
function check_xue_ok()
    EnableTriggerGroup("ck_xue_accept", true)
    exe('ask xue muhua about ����')
end
function check_xue_fail()
    EnableTriggerGroup("ck_xue_ask", false)
    EnableTriggerGroup("ck_xue_accept", false)
    EnableTriggerGroup("ck_xue_teach", false)
    return check_jingxue()
end
function check_xue_accept()
    EnableTimer('walkWait4', false)
    DeleteTimer("walkWait4")
    EnableTriggerGroup("ck_xue_ask", false)
    EnableTriggerGroup("ck_xue_accept", true)
end
function check_xue_wait()
    EnableTrigger("ck_xue_accept1", false)
    EnableTrigger("ck_xue_accept3", false)
    EnableTrigger("ck_xue_accept4", false)
end
function check_xue_teach()
    EnableTrigger("ck_xue_accept1", false)
    EnableTriggerGroup("ck_xue_accept", false)
    EnableTriggerGroup("ck_xue_teach", true)
    if tmpxueskill then
        for i = 1, 10 do exe('teach xue ' .. tmpxueskill) end
    else
        for i = 1, 10 do exe('teach xue ' .. tmp.xueSkills[tmp.xueCount]) end
    end
    wait.make(function()
        wait.time(0.5)
        return check_busy(check_xue_ok)
    end)
end
function check_xue_next()
    EnableTriggerGroup("ck_xue_teach", false)
    if tmpxueskill then
        tmpxueskill = nil
        tmp.xueCount = 0
    end
    tmp.xueCount = tmp.xueCount + 1
    if tmp.xueCount > table.getn(tmp.xueSkills) then
        return check_jingxue()
    else
        return checkWait(check_xue_teach, 0.2)
    end
end
function check_xue_heal()
    EnableTriggerGroup("ck_xue_accept", false)
    DeleteTriggerGroup("ck_xue_ask")
    DeleteTriggerGroup("ck_xue_accept")
    DeleteTriggerGroup("ck_xue_teach")
    DeleteTriggerGroup("ck_xue_busy")
    return check_bei(check_poison)
end
function check_poison()
    prepare_neili_stop()
    poison_dazuo()
    condition = {}
    exe('cond')
    return check_busy(preparePoison)
end
function preparePoison()
    EnableTrigger("hp19", true)
    if (not condition.poison or condition.poison == 0) then
        return check_halt(check_heal_over)
    end
    return dazuoPoison()
end
function dazuoPoison()
    condition.poison = 0
    exe('set ����;hp;yun qi;yun jing;yun jingli;cond')
    exe('dazuo ' .. hp.dazuo)
end
function poison_dazuo()
    DeleteTriggerGroup("poison")
    create_trigger_t('poison1',
                     "^(> )*(����Ƭ�̣���о��Լ��Ѿ��������޼���|�㽫��������������֮�ư�����һ��|��ֻ��������ת˳����������������|�㽫������ͨ���������|��ֻ����Ԫ��һ��ȫ��������|�㽫��Ϣ���˸�һ������|�㽫��Ϣ����ȫ������ȫ���泩|�㽫�����������ڣ���ȫ��ۼ�����ɫ��Ϣ|�㽫����������������һ������|���˹���ϣ�վ������|��һ�������н������������ӵ�վ������|��ֿ�˫�֣�������������|�㽫��Ϣ����һ�����죬ֻ�е�ȫ��̩ͨ|������������������һ�����죬�����������ڵ���|������������������һ�����죬���������ڵ���|��˫��΢�գ���������ؾ���֮����������|���������������뵤������۾�|�㽫��Ϣ������һ��С���죬�������뵤��|��о�����ԽתԽ�죬�Ϳ�Ҫ������Ŀ����ˣ�|�㽫������Ϣ��ͨ���������������۾���վ������|������������һ��Ԫ����������˫��|�������뵤�������ת�����������չ�|�㽫����������������������һȦ���������뵤��|�㽫��Ϣ����������ʮ�����죬���ص���|�㽫��Ϣ���˸�С���죬���ص���չ�վ������|����Ƭ�̣������������Ȼ�ں���һ�𣬾����ӵ�վ����|��е��Լ��������Ϊһ�壬ȫ����ˬ��ԡ���磬�̲�ס�泩��������һ���������������۾�)",
                     '', 'poisondazuo_desc')
    create_trigger_t('poison2',
                     "^(> )*�����ھ��������޷�������Ϣ��������",
                     '', 'checkDebug')
    SetTriggerOption("poison1", "group", "poison")
    SetTriggerOption("poison2", "group", "poison")
    EnableTriggerGroup("poison", true)
end
function poisondazuo_desc()
    if condition.poison and condition.poison == 0 then
        EnableTriggerGroup("poison", false)
        DeleteTriggerGroup("poison")
        exe('yun jing;yun qi;yun jingli')
        return check_bei(check_food)
    end
    return poisonLianxi()
end
function poisonLianxi()
    exe('sxlian')
    wait.make(function()
        wait.time(2)
        return check_busy(preparePoison)
    end)
end

function Ronglian()
    dis_all()
    job.name = "refine"
    return go(Brefine, '���ݳ�', '������')
end
function Brefine()
    if kuang_cur and kuang_cur > 2000 then
        kuang_cur = math.modf(kuang_cur / 1000) * 1000
    else
        kuang_cur = 1000
    end
    kuangshi = "tiekuang shi"
    DeleteTriggerGroup("refine")
    create_trigger_t('refine1', "^(> )*��û���㹻������ʯ��", '',
                     'refineGold')
    create_trigger_t('refine2', "^(> )*��û���㹻�Ľ��ʯ��", '',
                     'refineOK')
    create_trigger_t('refine3',
                     "^(> )*��Ŭ���ش߶�¯��ʼ��������ʯ", '',
                     'refinecheck')
    create_trigger_t('refine4', "^(> )*��Ҫ������ʯ������������ǧ",
                     '', 'refinenumber')
    SetTriggerOption("refine1", "group", "refine")
    SetTriggerOption("refine2", "group", "refine")
    SetTriggerOption("refine3", "group", "refine")
    SetTriggerOption("refine4", "group", "refine")
    EnableTriggerGroup("refine", true)
    create_timer_s('refine', 2, 'refine')
end
function refinecheck() exe('cond') end
function refinenumber() kuang_cur = 1000 end
function refine()
    exe('refine ' .. kuang_cur .. ' ' .. kuangshi)
    exe('l bei nang')
end
function refineGold()
    kuang_cur = 0
    if kuang_cur1 and kuang_cur1 > 2000 then
        kuang_cur1 = math.modf(kuang_cur1 / 1000) * 1000
    else
        kuang_cur1 = 1000
    end
    kuang_cur = kuang_cur1
    kuangshi = "jinkuang shi"
end
function refineOK()
    kuang_cur = 0
    kuang_cur1 = 0
    DeleteTriggerGroup("refine")
    checkBags()
    wait.make(function()
        wait.time(3)
        dis_all()
        fqyyArmorMessage('������ʯ��ϣ�')
        job.name = nil
        return checkWait(checkPrepare)
    end)
end

function check_food()
    exe('cha') -- �Զ������������趨��
    set_sxlian()
    if score.gender == '��1' then -- ����ר�ã���շ���
        map.rooms["city/mingyufang"].ways["north"] = nil
        map.rooms["changan/eastjie1"].ways["north"] = nil
    end
    map.rooms["sld/lgxroom"].ways["#outSld"] = "huanghe/huanghe8"
    if score.party == '��ɽ��' and hp.shen < 0 then
        map.rooms["huashan/houtang"].ways["north"] = nil
        map.rooms["huashan/qianting"].ways["south"] = nil
    end
    if score.party == '����Ľ��' then
        map.rooms["mtl/anbian1"].ways["qu xiaozhu;#CboatWait"] = nil
        map.rooms["mtl/anbian1"].ways["qu yanziwu;#CboatWait"] = nil
        map.rooms["mr/testmatou1"].ways["qu yanziwu;#boatWait"] = nil
        map.rooms["mr/testmatou1"].ways["qu mr;#boatWait"] = nil
        map.rooms["mr/tingyuju"].ways["tan qin;#boatWait"] = nil
        map.rooms["mr/xiaodao"].ways["#boatYell"] = nil
        map.rooms["yanziwu/anbian3"].ways["#boatYell"] = nil
        map.rooms["yanziwu/anbian4"].ways["#boatYell"] = nil
        if skills["douzhuan-xingyi"] ~= nil then
            if not skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl >
                130 and skills["douzhuan-xingyi"].lvl < 170 then
                dzxy_level = 1
            end
            if not skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl >
                170 and skills["douzhuan-xingyi"].lvl < 200 then
                dzxy_level = 2
            end
            if not skills["douzhuan-xingyi"] and skills["douzhuan-xingyi"].lvl >
                200 and skills["douzhuan-xingyi"].lvl < hp.pot_max - 100 then
                dzxy_level = 3
            end
        end
    end
    beiUnarmed()
    dis_all()
    hpheqi()
    if mydummy == true then return dummyfind() end
    -- if job.zuhe["wudang"] then wait_kill='yes' end

    if flag.xuncheng_start then return xunCheng() end
    exe('remove all;wear all')
    exe('hp;unset no_kill_ap;yield no')
    score.zt = 'ȥ�䵱�Ժ�'
    wait.make(function()
        wait_busy()
        if (hp.food < 60 or hp.water < 60) and hp.exp < 500000 then
            return go(dali_eat, '�����', '���')
        elseif hp.food < 60 or hp.water < 60 then
            return go(wudang_eat, '�䵱ɽ', '��ͤ')
        else
            check_bei(check_food_over)
        end
    end)
end
function wudang_eat()
    if locl.room == "��ͤ" then
        flag.food = 0
        DeleteTimer("food")
        exe(
            'sit chair;knock table;get tao;#3(eat tao);get cha;#4(drink cha);drop cha;drop tao;fill jiudai')
        check_bei(check_food_over)
    else
        return go(wudang_eat, '�䵱ɽ', '��ͤ')
    end
end
function check_food_over()
    if (kuang_cur and kuang_cur > 2000) or (kuang_cur1 and kuang_cur1 > 2000) then
        return Ronglian()
    end
    return check_heal()
end

function dali_eat()
    if locl.room == "���" then
        flag.food = 0
        DeleteTimer("food")
        exe('#5(drink);e;e;s;buy baozi;#2(eat baozi)')
        check_bei(check_food_over)
    else
        return go(dali_eat, '�����', '���')
    end
end

function checkHammer() return go(checkHmGive, "���ݳ�", "������") end
function checkHmGive()
    if Bag["Τ��֮��"] then
        exe('give ' .. Bag["Τ��֮��"].fullid .. ' to zhujian shi')
    end
    Bag["Τ��֮��"] = nil
    return checkPrepare()
end

function check_gold()
    tmp.cnt = 0
    return go(check_gold_dali, "�����", "����Ǯׯ")
end
function check_gold_dali()
    if not locl.id["���ƹ�"] then
        return go(check_gold_xy, "������", "����ի")
    else
        return check_gold_count()
    end
end
function check_gold_xy()
    if not locl.id["Ǯ����"] then
        return go(check_gold_cd, "�ɶ���", "ī��ի")
    else
        return check_gold_count()
    end
end
-- function check_gold_cd()
--    if not locl.id["���ƹ�"] then
--	   return go(check_gold_yz,"���ݳ�","���ի")
--	else
--	   return check_gold_count()
--	end
-- end
-- ain
function newbie_qu_gold() return go(check_gold_qu, "�����", "����Ǯׯ") end
function check_gold_cd()
    if not locl.id["Ǯ��"] then
        return go(check_gold_dali, "�����", "����Ǯׯ")
    else
        return check_gold_count()
    end
end
function check_gold_count()
    if Bag['ҼǪ����Ʊ'] and Bag['ҼǪ����Ʊ'].cnt > 10 then
        exe('score;chazhang')
        if score.goldlmt and score.gold and (score.goldlmt - score.gold) > 50 then
            return check_cash_cun()
        end
    end
    if Bag and Bag["����"] and Bag["����"].cnt and
        (Bag["����"].cnt > 100 or Bag["����"].cnt < 50) then
        return check_silver_qu()
    end
    if (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt <
        count.gold_max and score.gold > count.gold_max) or
        (Bag and Bag["�ƽ�"] and Bag["�ƽ�"].cnt and Bag["�ƽ�"].cnt >
            count.gold_max * 4) then return check_gold_qu() end

    return check_gold_over()
end
function check_cash_cun()
    if Bag['ҼǪ����Ʊ'] then
        local l_cnt
        if score.goldlmt and score.gold and (score.goldlmt - score.gold) <
            Bag['ҼǪ����Ʊ'].cnt * 10 then
            l_cnt = math.modf((score.goldlmt - score.gold) / 10) - 1
        else
            l_cnt = Bag['ҼǪ����Ʊ'].cnt
        end
        if l_cnt > 0 then exe('cun ' .. l_cnt .. ' cash') end
    end
    checkBags()
    return checkWait(check_gold_check)
end
function check_silver_qu()
    local l_cnt = Bag["����"].cnt - 50
    exe('cun ' .. l_cnt .. ' silver')
    exe('qu 50 silver')
    -- checkBags()
    -- return checkWait(check_gold_check,3)
    return checkPrepareOver()
end
function check_gold_qu()
    local l_cnt = Bag["�ƽ�"].cnt - count.gold_max * 2
    exe('cun ' .. l_cnt .. ' gold')
    if Bag["�ƽ�"].cnt < count.gold_max then
        exe('qu ' .. count.gold_max .. ' gold')
    end
    -- checkBags()
    -- return checkWait(check_gold_check,3)
    return checkPrepareOver()
end
function check_gold_check()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then return check_heal() end
    return check_gold_count()
end
function check_gold_over() return checkPrepare() end

function checkZqd()
    tmp.cnt = 0
    return go(checkZqdBuy, randomElement(drugBuy["������"]))
end
function checkZqdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkZqdOver()
    else
        exe('buy zhengqi dan')
        checkBags()
        return check_bei(checkZqdi)
    end
end
function checkZqdi()
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 and
        (not Bag["������"] or Bag["������"].cnt < 4) then
        return checkWait(checkZqdBuy, 1)
    else
        return checkZqdOver()
    end
end
function checkZqdOver()
    checkBags()
    return check_bei(checkPrepare, 1)
end

function checkXqw()
    tmp.cnt = 0
    return go(checkXqwBuy, randomElement(drugBuy["а����"]))
end
function checkXqwBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkXqwOver()
    else
        exe('buy xieqi wan')
        checkBags()
        return check_bei(checkXqwi)
    end
end
function checkXqwi()
    if Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 and
        (not Bag["а����"] or Bag["а����"].cnt < 4) then
        return checkWait(checkXqwBuy, 1)
    else
        return checkXqwOver()
    end
end
function checkXqwOver()
    checkBags()
    return check_bei(checkPrepare, 1)
end

function checkNxw()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and
        (nxw_cur < count.nxw_max or cbw_cur < count.cbw_max or hqd_cur <
            count.hqd_max) then
        return go(checkNxwBuy, randomElement(drugBuy["��Ϣ��"]))
    else
        return checkNxwOver()
    end
end
function checkNxwBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkNxwOver()
    else
        if hqd_cur < count.hqd_max then exe('buy ' .. drug.neili3) end
        if cbw_cur < count.cbw_max then exe('buy ' .. drug.neili2) end
        if nxw_cur < count.nxw_max then exe('buy ' .. drug.neili) end
        checkYaoBags()
        return check_bei(checkNxwi)
    end
end
function checkNxwi()
    if (nxw_cur < count.nxw_max or cbw_cur < count.cbw_max or hqd_cur <
        count.hqd_max) and Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 then
        return checkWait(checkNxwBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkNxwOver() return check_bei(checkPrepare, 1) end

function checkHxd()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and cty_cur < count.cty_max then
        return go(checkHxdBuy, randomElement(drugBuy["���ɽ�ҩ"]))
    else
        return checkNxwOver()
    end
end
function checkHxdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 25 then
        return checkNxwOver()
    else
        exe('buy ' .. drug.heal)
        checkYaoBags()
        return check_bei(checkHxdBag)
    end
end
function checkHxdBag()
    if cty_cur < count.cty_max and Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 then
        return checkWait(checkHxdBuy, 1)
    else
        return checkNxwOver()
    end
end

function checkLjd()
    tmp.cnt = 0
    if score.gold and score.gold > 100 and hxd_cur < count.hxd_max then
        return go(checkLjdBuy, randomElement(drugBuy["��Ѫ�ƾ���"]))
    else
        return checkNxwOver()
    end
end
function checkLjdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkNxwOver()
    else
        exe('buy ' .. drug.jingxue)
        checkYaoBags()
        return check_bei(checkLjdBag)
    end
end
function checkLjdBag()
    if hxd_cur < count.hxd_max and Bag["�ƽ�"] and Bag["�ƽ�"].cnt > 4 then
        return checkWait(checkLjdBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkdhd()
    tmp.cnt = 0
    if score.tb and score.tb > 100 and dhd_cur < count.dhd_max then
        return go(checkdhdBuy, randomElement(drugBuy["�󻹵�"]))
    else
        return checkNxwOver()
    end
end
function checkdhdBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 30 then
        return checkNxwOver()
    else
        exe('duihuan dahuan dan;score')
        checkYaoBags()
        return check_halt(checkdhdBag)
    end
end
function checkdhdBag()
    if dhd_cur < count.dhd_max and score.tb and score.tb > 100 then
        return checkWait(checkdhdBuy, 1)
    else
        return checkNxwOver()
    end
end
function checkFire()
    if not Bag["����"] then
        return go(checkFireBuy, randomElement(drugBuy["����"]))
    else
        return checkFireOver()
    end
end
function checkFireBuy()
    exe('buy fire')
    checkBags()
    return checkFireOver()
end
function checkFireOver()
    exe('drop fire 2')
    return check_busy(checkPrepare, 1)
end

function checkJiudai()
    if not Bag["ţƤ�ƴ�"] then
        return go(checkJiudaiBuy, randomElement(drugBuy["ţƤ�ƴ�"]))
    else
        return checkJiudaiOver()
    end
end
function checkJiudaiBuy()
    exe('buy jiudai;buy jiudai;buy jiudai')
    checkBags()
    return checkJiudaiOver()
end
function checkJiudaiOver() return check_busy(checkPrepare, 1) end

function checkYu(p_yu)
    tmp.yu = p_yu
    return go(checkYuCun, "���ݳ�", "�ӻ���")
end
function checkYuCun()
    exe('cun ' .. Bag[tmp.yu].fullid)
    return check_bei(checkYuOver)
end
function checkYuOver()
    exe('cun yu;drop yu')
    checkBags()
    return check_busy(checkPrepare, 1)
end

function checkSell(p_sell)
    tmp.sell = p_sell
    return go(checkSellDo, "���ݳ�", "����")
end
function checkSellDo()
    if Bag[tmp.sell] then exe('sell ' .. Bag[tmp.sell].fullid) end
    return check_bei(checkSellOver)
end
function checkSellOver()
    if Bag[tmp.sell] then
        exe('sell ' .. Bag[tmp.sell].fullid)
        exe('drop ' .. Bag[tmp.sell].fullid)
    end
    checkBags()
    return check_busy(checkPrepare, 1)
end

function checkWeapon(p_weapon)
    tmp.cnt = 0
    tmp.weapon = p_weapon
    return go(checkWeaponBuy, weaponStore[p_weapon], '')
end
function checkWeaponBuy()
    tmp.cnt = tmp.cnt + 1
    if tmp.cnt > 10 then
        checkBags()
        return check_heal()
    else
        if tmp.weapon and weaponStoreId[tmp.weapon] then
            exe('list;buy ' .. weaponStoreId[tmp.weapon])
            checkBags()
            return checkWait(checkWeaponI)
        else
            return check_heal()
        end
    end
end
function checkWeaponI()
    if not Bag[tmp.weapon] then
        return checkWeaponBuy()
    else
        return checkWeaponOver()
    end
end
function checkWeaponOver() return checkPrepare() end

function checkCodeError() return dis_all() end

function checkRefresh() job.time["refresh"] = os.time() % 900 end
