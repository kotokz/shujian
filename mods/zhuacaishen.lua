--------半自动抓财神机器人------

--[[使用说明：
（1）输入“csgo”，根据rumor提示直接输入财神出现的地点，机器人就会自动赶往目的地展开搜索。
（2）如果有同名区域，请尽量输入完整的地名，例如：“菜地”有“华山村菜地”和“佛山菜地”，以免赶往错误地点。
（3）财神会瞬移，如果想增大抓获几率，请尽量在rumor出现财神位置时，第一时间赶过去。
（4）一次搜索没有找到的话，可以输入“stop”，然后输入“csgo”，再搜索一次。
（5）三次搜索都没有，可以暂时做任务，等待下一次提示后前去。
（6）不论是否抓到财神，机器人都会自动开始做任务。
（7）每隔一个整点抓一次财神，例如8点一次，9点一次，以此类推。
     如果在当前时间段内已经抓过，则无法继续抓，必须等到下一个整点。

最后，祝人人发大财！！！黄金爆满仓！！！]]

--------by 桃花岛无法风（2019.1.1）---------

--[[function zhuacaishen_auto()
	create_trigger_t('zhacaishen1','^(> )*(\\D*)据说有人看到财神在(\\D*)出现！$','','caishen_location')
	SetTriggerOption("zhacaishen1","group","zhuacaishen")
    SetTriggerOption("zhacaishen1","keep_evaluating","y")
end
function caishen_location(n,l,w)
	print(w[3])
	SetVariable("caishen_location",	Trim(w[3]))
end]]
function zhuacaishen_find()
	job.name='zhuacaishen'
	flag.find=0
	DeleteTriggerGroup("zhuacaishen_find")
	DeleteTrigger("zhuacaishen_find_success")
	create_trigger_t('zhuacaishen_find1','^(> )*\\s*财神 邯郸爷 赵公明\\(Zhao gongming\\)','','caishenTarget')
    create_trigger_t('zhuacaishen_find_success',"^(> )*财神爷为你增加了(\\D*)錠黄金存款",'','zhuacaishen_finish')
	create_trigger_t('zhuacaishen_find2','^(> )*(这里没有 zhao gongming|这里没有 zhao)','','zhuacaishen_goon')
    SetTriggerOption("zhuacaishen_find1","group","zhuacaishen_find")
    SetTriggerOption("zhuacaishen_find2","group","zhuacaishen_find")
	EnableTrigger("zhuacaishen_find2",false)
    l_result=utils.inputbox ("你要抓的财神位于？", "财神位置", GetVariable("caishen_location"), "宋体" , "12")
   if not isNil(l_result) then
      SetVariable("caishen_location",l_result)
     end
	 zhuacaishen_go(GetVariable("caishen_location"))
end
function zhuacaishen_go(where)
   local l_dest={}
   sour.id = nil
   dest.id = nil
   tmp.goto = true
   where = Trim(where)
   
   l_dest.area,l_dest.room = locateroom(where)
   
   if l_dest.area then
	  wdgostart=1
      return go(zhuacaishen_FindAct,l_dest.area,l_dest.room)
   else
      return ColourNote ("red","blue","找不到或无法到达此(地点|人物)："..where)
   end
end
jobFindAgain = jobFindAgain or {}
jobFindAgain["zhuacaishen"] = "caishenFindAgain"
jobFindFail = jobFindFail or {}
jobFindFail["zhuacaishen"] = "caishenFindFail"
function caishenFindAgain()
    return go(zhuacaishen_FindAct,dest.area,dest.room)
end
function caishenFindFail()
	wdgostart=0
    messageShow('抓财神任务：搜索丢失【财神同志】三次！请等待rumor提示，再来抓，祝你好运！','white','black')
	return go(check_heal,'大理城','药铺')
end 
function zhuacaishen_start()
	exe('follow zhao gongming')
	exe('worship zhao')
end
function zhuacaishen_FindAct()
	wdgostart=0
	create_timer_s('walkWaitX',0.3,'zhuacaishen_start')
    job.flag()
    exe('look')
    find()
    messageShow('抓财神：已到达任务地点【'..GetVariable("caishen_location")..'】，开始寻找【财神】','lime','black')
end
function caishenTarget()
	flag.find=1
    EnableTriggerGroup("zhuacaishen_find",false)
	EnableTrigger("zhuacaishen_find2",true)
	EnableTimer("walkWaitX",false)
	exe('follow zhao')
	exe('worship zhao')
end
function zhuacaishen_goon()
	flag.find=0
	EnableTriggerGroup("zhuacaishen_find",true)
	EnableTrigger('zhuacaishen_find2',false)
	EnableTimer("walkWaitX",true)
	return walk_wait()
end
function zhuacaishen_finish(n,l,w)
	wdgostart=0
	job.name='idle'
	messageShow('抓财神任务：完成！获得【'..w[2]..'】锭黄金！','red','black')
	dis_all()
	EnableTriggerGroup("zhuacaishen_find",false)
	EnableTrigger("zhuacaishen_find_success",false)
    return check_halt(check_food)
end