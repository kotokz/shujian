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


hp_dazuo_count=function()
    DeleteTriggerGroup("dz_count")
    create_trigger_t('dz_count1','^>*\\s*���Ҳ��ܴ�������Ӱ�������Ϣ��','','hp_dz_where')
    create_trigger_t('dz_count2','^>*\\s*���޷���������������','','hp_dz_where')
    create_trigger_t('dz_count3','^>*\\s*(���ﲻ׼ս����Ҳ��׼������|����ɲ���������������ĵط���)','','hp_dz_where')
	create_trigger_t('dz_count4',"^(> )*�������ֽŴ�����������������ȷ������������",'','hp_dz_liaokao')
	create_trigger_t('dz_count5',"^(> )*(����Ҫ��������|���޷�������������|�㻹��ר�Ĺ����)",'','hp_dz_where')
	create_trigger_t('dz_count6',"^(> )*�����ھ��������޷�������Ϣ��������",'','loginerror')
    SetTriggerOption("dz_count1","group","dz_count")
    SetTriggerOption("dz_count2","group","dz_count")
    SetTriggerOption("dz_count3","group","dz_count")
	SetTriggerOption("dz_count4","group","dz_count")
	SetTriggerOption("dz_count5","group","dz_count")
	SetTriggerOption("dz_count6","group","dz_count")
    if perform.force and skills[perform.force] then
	   exe('jifa force '.. perform.force)
	else
	   for p in pairs(skills) do
	      if skillEnable[p] == "force" then
		     exe('jifa force '.. p)
			 exe('cha')
		  end
	   end
	end
    if skills["linji-zhuang"] and skills["linji-zhuang"].lvl>149 then
       exe('yun yinyang')
    end
	if skills["force"] and skills["force"].lvl<450 and skills["force"].lvl<hp.pot_max-100 then
       flag.xuexi=1
    end
    exe('yun qi;hp')
    hp.dazuo=10
    return check_bei(hp_dazuo_act)
end
loginerror=function()
	  DeleteTriggerGroup("dz_count")
	  DeleteTimer("dazuo_count")
    return checkWait(check_heal,0.5)
end
hp_dazuo_act=function()
    tmp.qixue=hp.qixue
    exe('yun jing;dazuo '..hp.qixue)
    tmp.i=0
    return create_timer_s('dazuo_count',1.5,'hp_dazuo_timer')
end
hp_dazuo_timer=function()
    if tmp.i == nil then tmp.i = 0 end
    tmp.i = tmp.i + 1
    if tmp.i > 30 then
       return main()
    end
    exe('hp;yun jing;yun qi;dazuo '..hp.qixue)
    return checkWait(hp_dz_count,0.5)
end
hp_dz_count=function()
    EnableTriggerGroup("dz_count",false)

    local l_times=1
       if hp.qixue<tmp.qixue then
          if hp.qixue_max>1000 then
             l_times=math.modf(math.modf(hp.qixue_max/5)/(tmp.qixue-hp.qixue))+1
	  end
	  hp.dazuo=l_times*(tmp.qixue-hp.qixue)+150
	  if hp.dazuo<10 then
	     hp.dazuo=10
	  end
	  --if hp.dazuo>10 and hp.dazuo <100 then
	  --   l_times=math.modf(100/hp.dazuo)+1
	  --   hp.dazuo=l_times*hp.dazuo
	  --end
	  Note('��Ѵ���ֵΪ��'..hp.dazuo)
	  DeleteTriggerGroup("dz_count")
	  DeleteTimer("dazuo_count")
	  exe('halt')
	  if kdummy==1 and hp.exp>2000000 then opendummy() end
	  return check_bei(vcheck)
	 end
end
function vcheck()
if score.id and score.id=='ptbx' and ptbxvip==1 then
      job.name='ptbx'
      exe('cond')
      return go(VIPask,'���ݳ�','����')
   else
      return Gstart()
   end
end
function Gstart()
	  return check_bei(check_food)
end
hp_dz_where=function()
   EnableTriggerGroup("dz_count",false)
   DeleteTimer("dazuo_count")
   locate()
   check_bei(hp_dz_go)
end
hp_dz_go=function()
   EnableTriggerGroup("dz_count",true)
   exe(locl.dir)
   hp_dazuo_act()
end
function hp_dz_liaokao()
    dis_all()
	return tiaoshui()
end
function hp_trigger()
    DeleteTriggerGroup("hp")
    create_trigger_t('hp1',"^����Ѫ��\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*��������\\s*(\\d*)\\s*\\/\\s*(\\d*)\\((\\d*)\\)$",'','hp_jingxue_check')
    create_trigger_t('hp2',"^����Ѫ��\\s*(\\d*)\\s*\\/\\s*(\\d*)\\s*\\(\\s*(\\d*)\\%\\)\\s*��������\\s*(\\d*)\\s*\\/\\s*(\\s*\\d*)\\(\\+\\d*\\)$",'','hp_qixue_check')
    create_trigger_t('hp3',"^��ʳ�\\s*(\\d*)\\.\\d*\\%\\s*��Ǳ�ܡ�\\s*(\\d*)\\s*\\/\\s*(\\d*)$",'','hp_pot_check')
    create_trigger_t('hp4',"^����ˮ��\\s*(\\d*)\\.\\d*\\%\\s*�����顤\\s*(.*)\\s*\\(",'','hp_exp_check')
    create_trigger_t('hp5',"^��(��|��)����\\s*(.*)\\s*���������ޡ�\\s*(\\d*)\\s*\\/",'','hp_shen_check')
    create_trigger_t('hp7',"^(��)*\\s*(\\D*)\\s*\\((\\D*)(\\-)*(\\D*)\\)\\s*\\-\\s*\\D*\\s*(\\d*)\\/\\s*(\\d*)$",'','check_skills')
    create_trigger_t('hp8',"^>*\\s*��������Ҫ(\\D*)�������������",'','hp_dazuo_check')
    create_trigger_t('hp9',"^��(\\D*)����\\s*��\\s*(\\d*) ��\\s*�� ",'','checkJobtimes')
    create_trigger_t('hp10',"^��(\\D*)\\(\\D*\\)$",'','checkWieldCatch')
    create_trigger_t('hp11',"^(> )*������������(\\D*)����$",'','checkJoblast')
    create_triggerex_lvl('hp12',"^(> )*(\\D*)",'','resetWait',200)
    create_trigger_t('hp13',"^(> )*�㻹��Ѳ���أ���ϸ����������ɡ�",'','checkQuit')
    create_trigger_t('hp14',"^\\D*��һ�������ˡ�$",'','checkRefresh')
    create_trigger_t('hp15',"^(> )*һ�����ֹ�ȥ",'','checkMonth')
    create_trigger_t('hp16',"^(> )*�������ʧ���ż�����(\\N*)�Σ��������ʧ���ż�����(\\N*)/(\\N*)�Ρ�",'','checkLLlost')
    create_trigger_t('hp17',"^(> )*��(�ʵ���ð���ǣ�ȫ������|����ͷ���ۻ���ֱð�亹)|�����ɳ����е�����ð�̣��ɿ��Ѱ���",'','checkQuit')
    create_trigger_t('hp18',"^(> )*(����������ѵ��촽�������Ǻܾ�û�к�ˮ��|ͻȻһ�󡰹�������������ԭ������Ķ����ڽ���)",'','checkfood')
    create_trigger_t('hp19',"^(> )*(��Ȼһ��̹ǵ��溮Ϯ�������е������ƶ�������|��Ȼһ�ɺ������Ʊ�����ѭ���ֱۣ�Ѹ�����׵��������ţ����еĺ���������)",'','checkDebug')
    create_trigger_t('hp20',"^(> )*��(����һ�Ż�Ѫ�ƾ�������ʱ�о���Ѫ������ʧ|����һ����Ϣ�裬��ʱ�������������˲���|����һ�Ŵ�����Ϣ�裬��ʱ�о���������|����һ�Ż�����Ϣ������ʱ�о�����ĵ����ӯ�˲���|����һ�����ɽ�ҩ����ʱ�о����ƺ��˲���|����һ�Ŵ󻹵���ʱ����Ȭ����Ѫ��ӯ)��",'','hpeatOver')
    create_trigger_t('hp21',"^(> )*��������� enable ѡ����Ҫ�õ������ڹ���",'','jifaOver')
    create_trigger_t('hp22',"^(> )*(\\D*)Ŀǰѧ��(\\D*)�ּ��ܣ�",'','show_skills')
    create_trigger_t('hp23',"^(> )*��ı������У�",'','show_beinang')
    create_trigger_t('hp24','^(> )*������һ������\\D*����ߵ���һ(��|��|˫|Ϯ|��|��|��|��)(\\D*)(����|ѥ|����|����|����|����|ͷ��)��','','fqyyArmorGet')
    create_trigger_t('hp25','^(> )*�����һ(��|��|˫|Ϯ|��|��|��|��)(\\D*)(����|ѥ|����|����|����|����|ͷ��)��','','fqyyArmorCheck')
	create_trigger_t('hp26','^(> )*\\D*�����㣺����(\\D*)','','yiliCheck')
	create_trigger_t('hp27','^(> )*�͹��Ѿ��������ӣ���(ô|��)��ס��������أ����˻���ΪС���ź����أ�','','kedian_sleep')
	create_trigger_t('hp28','^.*��⵰��һ�ߴ���ȥ','','newbie_qu_gold')
	create_trigger_t('hp29','^.*���ɵؿ����㣺��������ô�䵽������ϣ���','','dolost_hitlog_open')
	create_trigger_t('hp30','^.*��˵'..score.name..'��.*��ɵ��!','','dolost_hitlog_close')
    SetTriggerOption("hp24","group","hp")
    SetTriggerOption("hp25","group","hp")
	SetTriggerOption("hp26","group","hp")
	SetTriggerOption("hp27","group","hp")
    SetTriggerOption("hp1","group","hp")
    SetTriggerOption("hp2","group","hp")
    SetTriggerOption("hp3","group","hp")
    SetTriggerOption("hp4","group","hp")
    SetTriggerOption("hp5","group","hp")
    SetTriggerOption("hp7","group","hp")
    SetTriggerOption("hp8","group","hp")
    SetTriggerOption("hp9","group","hp")
    SetTriggerOption("hp10","group","hp")
    SetTriggerOption("hp11","group","hp")
    SetTriggerOption("hp12","group","hp")
    SetTriggerOption("hp13","group","hp")
    SetTriggerOption("hp14","group","hp")
    SetTriggerOption("hp15","group","hp")
    SetTriggerOption("hp16","group","hp")
    SetTriggerOption("hp17","group","hp")
    SetTriggerOption("hp18","group","hp")
    SetTriggerOption("hp19","group","hp")
    SetTriggerOption("hp20","group","hp")
    SetTriggerOption("hp21","group","hp")
    SetTriggerOption("hp22","group","hp")
    SetTriggerOption("hp23","group","hp")
	SetTriggerOption("hp28","group","hp")
	SetTriggerOption("hp29","group","hp")
	SetTriggerOption("hp30","group","hp")
    DeleteTriggerGroup("score")
    create_trigger_t('score1',"^����    ����(\\D*)\\((\\D*)\\)\\s*����  ������(\\d*)\/(\\d*)��\\s*��  �ԣ���(\\d*)\/(\\d*)��",'','score_name_check')
    create_trigger_t('score2',"^��ͷ    �Σ�(\\D*)\\s*����  ������(\\d*)\/(\\d*)��\\s*��  �ǣ���(\\d*)\/(\\d*)��",'','score_title_check')
    create_trigger_t('score3',"^����    �䣺(\\D*)��\\D*\\s*��    ����",'','score_age_check')
    create_trigger_t('score4',"^��(����æ״̬|ѩɽǿ����Ů|˫������|����|����|�����ƶ�|�����ܻ���|��צ��������|�����ھֻ��ڵ���ʱ|��ʵ��Ұ)\\s*(\\D*)(��|��)\\s*",'','score_busy_check')
    create_trigger_t('score5',"^��(��    ��|��    ��|��    ��)��(\\D*)\\s*ʦ\\s*�У���(\\D*)����(\\D*)��",'','score_party_check')
    create_trigger_t('score6',"^����    ��(\\D*)��\\s*����(\\D*)\\s* �㣺",'','score_gender_check')
    create_trigger_t('score7',"^��(��    ��|��    ��|��    ��)��(\\D*)\\s*ʦ\\s*�У���(��ͨ����)��(\\D*)",'','score_party_check')
    create_trigger_t('score9',"^��ע    �᣺(\\D*)\\s*Ǯׯ��(\\D*)",'','score_gold_check')
    create_trigger_t('score8',"^��Ŀǰ�Ĵ�������ǣ�(\\D*)���ƽ�",'','checkGoldLmt')
    create_trigger_t('score10','^���������ԣ�\\d*.*���ࣺ(\\D*)\\((\\d*)\\)\\s*��','','score_check_xy')
    create_trigger_t('score11','^���齣ͨ����(\\N*)\\s*�齣Ԫ����(\\N*)\\s*�����ң�(\\N*)\\s*��','','score_tb_check')
    create_trigger_t('score12',"^�������Ѿ�ʹ�þ�Ӣ֮��(\\D*)�Ρ�",'','score_ebook_check')
    SetTriggerOption("score1","group","score")
    SetTriggerOption("score2","group","score")
    SetTriggerOption("score3","group","score")
    SetTriggerOption("score4","group","score")
    SetTriggerOption("score5","group","score")
    SetTriggerOption("score6","group","score")
    SetTriggerOption("score7","group","score")
    SetTriggerOption("score8","group","score")
    SetTriggerOption("score9","group","score")
    SetTriggerOption("score10","group","score")
    SetTriggerOption("score11","group","score")
    SetTriggerOption("score12","group","score")
end

function lingwu_trigger()
    DeleteTriggerGroup("lingwu")
    create_trigger_t('lingwu1',"^.*(��ֻ�ܴ����⼼��������|�㲻�����ּ��ܡ�|��Ҫ����ʲô��)",'','lingwu_next')
    create_trigger_t('lingwu2',"^.*���ʵս�еõ���Ǳ���Ѿ������ˡ�",'','lingwu_finish1')
    create_trigger_t('lingwu3',"^.*���\\D*�������޷��������һ��Ļ���",'','lingwu_next')
    create_trigger_t('lingwu9',"^.*�������ڵĻ����ڹ���Ϊ�����޷���������ڹ���",'','lingwu_next')
    create_trigger_t('lingwu5',"^.*����ʵս���鲻�㣬�谭����ġ�\\D*������",'','lingwu_next')
    create_trigger_t('lingwu6','^.*(���������˼����������������ö��ˡ�|�����ھ�������)','','lingwu_goon')
    create_trigger_t('lingwu7',"^.*�������������",'','lingwu_finish1') 
    SetTriggerOption("lingwu1","group","lingwu")
    SetTriggerOption("lingwu2","group","lingwu")
    SetTriggerOption("lingwu3","group","lingwu")
    SetTriggerOption("lingwu9","group","lingwu")
    SetTriggerOption("lingwu5","group","lingwu")
    SetTriggerOption("lingwu6","group","lingwu")
    SetTriggerOption("lingwu7","group","lingwu")
    EnableTriggerGroup("lingwu",false)
end