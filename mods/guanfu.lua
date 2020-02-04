--------官府任务机器人------

--------by 桃花岛无法风（2019.1.1）---------

--[[function guanfu_main()
    create_alias_s('gfgo','gfgo','guanfu_find')    
end]]
GF_target={}
_GF_target1={}
_GF_target2={}

local guanfuLoc={
	["少林寺山路"]="嵩山少林初祖庵",
	["山径"]="天山山径",
	["青石大道"]="昆仑山青石大道",
	["归云庄九宫桃花阵"]="归云庄归云庄前",
	["兰州沙漠"]="兰州城青城",
	["武当山猢狲愁"]="武当山古神道",
}
function guanfu_start()
	GF_target={}
    _GF_target={}
	go(guanfu_choice,"扬州","广场")
end
function guanfu_choice()
	job.name='guanfu'
	dis_all()
	flag.find=0
	DeleteTriggerGroup("guanfu_Accept")
	create_trigger_t('guanfuAccept1',"^(> )*你分开行人来到近前，目光淡淡的扫视了几眼告示，嘴角微微一翘，神态自如的把通缉(\\D*)的文书揭了下来。",'','guanfuNpc')
	create_trigger_t('guanfuAccept2','^\\s*(就地格杀|缉拿归案)\\s*(\\D*)\\((\\D*)\\)\\s*武功：(\\D*)\\s*等级：\\s*(\\d*)\\s*赏金：(\\D*)','','guanfu_checklist')
    SetTriggerOption("guanfuAccept1","group","guanfu_Accept")
	SetTriggerOption("guanfuAccept2","group","guanfu_Accept")
	exe('l wanted list')
	print("官府任务准备完毕，等待揭榜！")
end
function guanfu_checklist(n,l,w)
	GF_target.Way = tostring(w[1])
	GF_target.Name = tostring(w[2])
	GF_target.Id = string.lower(w[3])
	GF_target.Power= tostring(w[4])
	GF_target.Lvl = tonumber(w[5])
	GF_target.Gold = Trim(w[6])
	if GF_target.Way=="缉拿归案" then
	   if GF_target.Lvl<hp.pot_max-300 or GF_target.Lvl>hp.pot_max-200 then return end
	   table.insert(_GF_target1,{way = GF_target.Way,name = GF_target.Name,id = GF_target.Id,power = GF_target.Power, lvl = GF_target.Lvl,gold = GF_target.Gold})
	else
	   if GF_target.Lvl<hp.pot_max-200 or GF_target.Lvl>hp.pot_max-100 then return end
	   table.insert(_GF_target2,{way = GF_target.Way,name = GF_target.Name,id = GF_target.Id,power = GF_target.Power, lvl = GF_target.Lvl,gold = GF_target.Gold})
	end	
end
function gftest()
	table.sort(_GF_target1, function(a, b)
	if a.lvl ~= b.lvl then
	   return a.lvl < b.lvl
	end
    end)
	for i=1,table.getn(_GF_target1) do
		print (_GF_target1[i].way,_GF_target1[i].name,_GF_target1[i].id,_GF_target1[i].power,_GF_target1[i].lvl,_GF_target1[i].gold)
	end
	table.sort(_GF_target2, function(a, b)
	if a.lvl ~= b.lvl then
	   return a.lvl < b.lvl
	end
    end)
	for i=1,table.getn(_GF_target2) do
		print (_GF_target2[i].way,_GF_target2[i].name,_GF_target2[i].id,_GF_target2[i].power,_GF_target2[i].lvl,_GF_target2[i].gold)
	end
end
function guanfuNpc()
	DeleteTriggerGroup("guanfu_npc")
	create_trigger_t('guanfuNpc2','\\s*\\D*最后一次出现在(\\D*)附近','','guanfuConsider')
    SetTriggerOption("guanfuNpc2","group","guanfu_npc")
	addxml.trigger{
     name="guanfuNpc1",
     group="guanfu_npc",
     enabled="y",
     multi_line="y",
     lines_to_match="3",
     keep_evaluating="y",
     match="\\D*上面有一个画像，底下有一行小字：\\s*\\n\\s*(\\D*)\\((\\D*)\\)",
	 --match="^(> )*上面有一个画像，底下有一行小字：",
     regexp="y",
     script="guanfuTarget",
     sequence="100",
     }
	return check_wenshu()
end
function check_wenshu()
	exe('l wenshu')
end
function guanfuTarget(n,l,w)
	print(w[1])
	print(w[2])
    job.last='guanfu'
    job.target=Trim(w[1])
    job.killer={}
    job.killer[job.target]=true
    EnableTrigger("hpheqi1",true)
    job.id=string.lower(w[2])
    job.killer[job.target]=job.id
	print("job.target="..job.target.."job.id="..job.id)
end
function guanfuConsider(n,l,w)
	local x=Trim(w[1])
	print(w[1])
	if guanfuLoc[x] then
	   job.where=guanfuLoc[x]
	else
	   if string.find(x,'少林寺') then 
          job.where=string.gsub(x,'少林寺','嵩山少林') 
	   else
	      job.where=x
	   end
	end
	job.room,job.area=getAddr(job.where)
	dest.room=job.room
	dest.area=job.area
	if not job.room or not path_cal() then
		messageShow('官府任务：任务地点【'..job.where..'】不可到达，任务放弃。',"Plum")
		exe('drop wenshu')
		return checkPrepare()
	end
	return guanfu_go()
end
function guanfu_go()
    EnableTriggerGroup("guanfuAccept",false)
	EnableTriggerGroup("guanfu_npc",false)
	--job.wdtime=os.time() + 8*60
    exe('nick 官府任务'..job.where)
    exe('set no_kill_ap')
    DeleteTriggerGroup("guanfuFind")
    create_trigger_t('guanfuFind1','^(> )*\\D*'..job.target..'\\((\\D*)\\)','','guanfuFindKill')
    SetTriggerOption("guanfuFind1","group","guanfuFind")
    SetTriggerOption("guanfuFind2","group","guanfuFind")
	create_alias('pkpfm_kezhi','pkpfm_kezhi','alias pkpfm '..GetVariable("pkpfm"))
    exe('pkpfm_kezhi')
    create_alias('mypfm_kezhi','mypfm_kezhi','alias mypfm '..GetVariable("mypfm"))
    exe('mypfm_kezhi')
	--if string.find(job.where,'蝴蝶谷') then return hudiegu() end
    go(guanfu_FindAct,job.area,job.room)
end
function guanfu_FindAct()
    job.flag()
    exe('look')
    find()
    messageShow('官府任务：已到达任务地点【'..job.area..'】，开始寻找【'..job.target..'】','lime','black')
end
jobFindAgain = jobFindAgain or {}
jobFindAgain["guanfu"] = "guanfuFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["guanfu"] = "guanfuFindFail"
function guanfuFindAgain()
    return go(guanfu_FindAct,dest.area,dest.room)
end
function guanfuFindFail()
    messageShow('官府任务：搜索丢失【'.. job.target ..'】三次！回去放弃！','white','black')
	return go(check_heal,'大理城','药铺')
end 
function guanfuFindKill()
	flag.find=1
    EnableTriggerGroup("guanfuFind",false)
    dis_all()
    EnableTrigger("hpheqi1",true)
    exe('follow '..job.id)
    exe('set wimpy 100;yield no')
	exe('unset no_kill_ap')
    exe('set wimpycmd pkpfm\\mypfm\\hp')
    exe('kick '..job.id)
    exe('kill '..job.id)
	exe('hit '..job.id)
	kezhiwugong()
	kezhiwugongAddTarget(job.target,job.id)
end
function guanfu_goon()
	flag.find=0
	EnableTriggerGroup("zhuacaishen_find",true)
	EnableTrigger('zhuacaishen_find2',false)
	EnableTimer("walkWaitX",true)
	return walk_wait()
end
function guanfu_finish(n,l,w)
	job.name='idle'
	messageShow('官府任务：完成！获得【'..w[2]..'】锭黄金！','red','black')
	dis_all()
	EnableTriggerGroup("zhuacaishen_find",false)
	EnableTrigger("zhuacaishen_find_success",false)
    return check_halt(check_food)
end