sour={area='������',room='����'}
dest={area='������',room='����'}
locl={}
locl.area='������'
locl.room='����'
locl.where='�����ǵ���'
locl.time='��'
locl.id={}
locl.exit={}
road={}
road.sour='����_������'
road.city='������_������'
road.dest='������_����'
road.where='�����ǵ���'
road.test={}
road.detail={}
road.act=nil
road.i=0
road.temp=0
road.find=0
road.wipe_id=nil
road.wipe_who=nil
road.wipe_con=nil
road.resume=nil
road.wait=0.2
road.steps=100
road.cmd=nil
road.cmd_save=nil
road.maze=nil
wait_cd=nil
exit={}
exit.locl={}
exit.reverse={}
AddrIgnores = {}
WhereIgnores = {}
caidiout=0
locate_finish=0

local WipeNoPerform = {
     ["guan bing"] = true,
	 ["zhiqin bing"] = true,
	 ["wu jiang"] = true,
	 ["guan jia"] = true,
	 ["ya yi"] = true,
	 ["da yayi"] = true,
	 ["huanggong shiwei"] = true,
	 ["dali guanbing"] = true,
	 ["dali wujiang"] = true,
	 ["yu guangbiao"] = true,
	 ["wu guangsheng"] = true,
	 ["jia ding"] = true,
	 ["ya huan"] = true,
	 ["wu seng"] = true,
	 ["daoyi chanshi"] = true,
	 ["zhuang ding"] = true,
	 ["heiyi bangzhong"] = true,
	 ["huiyi bangzhong"] = true,
	 ["xingxiu dizi"] = true,
	 ["hufa lama"] = true,
	 ["zayi lama"] = true,
	 ["caihua zi"] = true,
	 ["wudujiao dizi"] = true,
	 ["wei shi"] = true,
	 --["jiao zhong"] = true,
}

local ItemGet = {
    ["�ƽ�"] = true,
--  ["����"] = true,
    ["ҼǪ����Ʊ"] = true,
    ["ҼǪ����Ʊ"] = true,
    ["��Ӣ֮��"] = true,
    ["����������ƪ"] = true,
    ["���콳����ƪ"] = true,
}


-- function exe(cmd)
-- 	cmdck=0
-- 	cmd_check()
--     if GetConnectDuration() == 0 then
--        return Connect()
--     end
--     if cmd==nil then
--         if locl.room=='��ϼ��' or locl.room=='�ͻ�Ӫ' or locl.room=='������' or locl.room_relation=='�ֵ����ͻ�Ӫ-----�ֵ�-----�вƴ󳵵����ϼ�Žֵ�' then
-- 			return walk_wait()
--         end 
--         cmd='look' 
--     end
-- --	   if locl.area and locl.area~="����ɽ" then
-- --       Execute('halt')
-- --   end
--         Execute(cmd)
-- 		--print(cmd..' '..check_step_num..' '..check_steptest)
--         check_steptest=1
-- 	    if string.find(cmd,';') then
-- 	        _check_step_num=utils.split(cmd,';')
-- 			check_steptest=table.getn(_check_step_num)
-- 	    end
-- 		check_step_num=check_step_num+check_steptest
-- 		if check_step_num>71 then
-- 			need_waittime=1
--            	    step_docheck()
-- 	            wait.make(function() 
--                     wait.time(road.wait)
--                     --Execute(cmd) 
-- 				    step_docheckdo()
--                 end)
--         else
-- 			need_waittime=0
-- 			road.wait=0.2
-- 			--Execute(cmd)
-- 		end
		
-- end
function exe(cmd)
	cmdck=0
	cmd_check()
    if GetConnectDuration() == 0 then
       return Connect()
    end
    if cmd==nil then
        if locl.room=='��ϼ��' or locl.room=='�ͻ�Ӫ' or locl.room=='������' or locl.room_relation=='�ֵ����ͻ�Ӫ-----�ֵ�-----�вƴ󳵵����ϼ�Žֵ�' then
			return walk_wait()
        end 
        cmd='look' 
    end
--	   if locl.area and locl.area~="����ɽ" then
--       Execute('halt')
--   end
    run(cmd)		
end

cmd_limit=30
walkecho=true

function run(str)
	if ((str=="")or(str==nil)) then return end
	SetSpeedWalkDelay(math.floor(1000/cmd_limit))
	_cmds={}
    if string.find(str,';') then
        _cmds=utils.split(str,';')
        for i, cmd in pairs(_cmds) do
            add_cmd_to_queue(cmd)
            if walkecho==true then Note(cmd) end
        end
    else
        add_cmd_to_queue(str)
        if walkecho==true then Note(str) end
    end
end

function add_cmd_to_queue(cmd) 
    if cmd ~=nil and cmd:sub(1, 1)=='#' then
        cmd = cmd:sub(2)
        Queue(EvaluateSpeedwalk(cmd),false)
    else
        Queue(cmd,false)
    end
end

function cmd_check()
    cmdck=1
	create_timer_s('cmdckk',90,'cmd_ckset')
end
function cmd_ckset()
    if cmdck==1 then
		return walk_wait()
	end
end
function step_docheck()
	if need_waittime==1 then
		    if os.clock()-check_step_time<3 then
		        road.wait=3.01-os.clock()+check_step_time
				--common_walk=string.format("%0.2f",common_walk)
			    --print(common_walk..' '..check_step_num)
		    else
			    road.wait=0.2
		        --print(common_walk..' '..check_step_num)
		    end
	end
end
function step_docheckdo()
	    check_step_time=os.clock()
		check_step_num=0
		need_waittime=0
		road.wait=0.2
end
function exe_road(cmd)
    if GetConnectDuration() == 0 then
       return Connect()
    end
    if cmd==nil then cmd='look' end
    road.cmd=cmd
    Execute(cmd)

end
function lujing_trigger()
    walk_trigger()
end
function locate_trigger()
    DeleteTriggerGroup("locate")
    DeleteTriggerGroup("locate_unknown")
    create_trigger_t('locate_unknown1','^(> )*�趨����������look\\s*\\=\\s*\\"YES\\"\\n>\\s*(\\D*)\\s*\\ -\\s*','','local_unknown_room')
    create_trigger_t('locate2','^(> )*��������������(\\D*)��\\n(\\D*)\\s*\\-\\s*','','local_area')
    create_trigger_t('locate3',"^( )*����(�������|���Ե�|Ψһ��|���ü���Ψһ)������(\\D*)��$",'','local_exit')
    create_trigger_t('locate4',"^(\\D*) = (\\D*)$",'','local_id')
    create_trigger_t('locate5','^(> )*��� "action" �趨Ϊ "���ڶ�λ" �ɹ���ɡ�$','','local_start')
    create_trigger_t('locate6',"^(> )*������\\D*��\\D*��\\D*��(\\D*)ʱ",'','local_time')
    create_trigger_t('server_time','^��������Ϸ����������ʱ����\\s*����(\\D*)\\s*\\d*-\\D*-\\s*\\d*\\s*(\\d*):(\\d*):','','local_time_cal')
    create_trigger_t('locate7',"^\\D*����û���κ����Եĳ�·",'','local_exitt')
    SetTriggerOption("locate_unknown1","multi_line","y")
    SetTriggerOption("locate_unknown1","lines_to_match","7")
    EnableTrigger("locate_unknown1",true)
    SetTriggerOption("locate2","multi_line","y")
    SetTriggerOption("locate2","lines_to_match","7")
    EnableTrigger("locate2",true)
    --SetTriggerOption("locate_unknown1","group","locate_unknown")
    --SetTriggerOption("locate2","group","locate")
    SetTriggerOption("locate3","group","locate")
    SetTriggerOption("locate4","group","locate")
    SetTriggerOption("locate5","group","locate")
    SetTriggerOption("locate6","group","locate")
	SetTriggerOption("locate7","group","locate")
    EnableTriggerGroup("locate",false)    
    EnableTriggerGroup("locate_unknown",false)  
end
local_start=function()
    EnableTriggerGroup("locate",true)
    EnableTriggerGroup("locate_unknown",true)
    locl.area='��֪������'
    exit.locl={}
    locl.id={}
	locl.item = {}
    locl.exit={}
    locl.dir="east"
end
local_unknown_room=function(n,l,w)
    local s=w[2]
	if s=='÷��' then 
	   locl.room='÷��'
	   return
	end
    unknown_room_relation=(string.gsub(s,' ',''))
    r_r=string.reverse(unknown_room_relation)
       _, i = string.find(r_r,'[\n]')
    locl.room = (string.sub(unknown_room_relation, 1-i))
    exe('unset look')
	locl.where=locl.area..locl.room
    print(locl.where,locl.area,locl.room)
    locl.room_relation = (string.gsub(unknown_room_relation,'[\n]',''))
end
local_room=function(n,l,w)
    EnableTrigger("locate1",false)    
    locl.room=Trim(w[2])
    exe('unset look')
    locl.where=locl.area..locl.room
	print(locl.where,locl.area,locl.room)
end
local_area=function(n,l,w)
    locl.area=w[2]
    local s=w[3]
    room_relation=(string.gsub(s,' ',''))
    r_r=string.reverse(room_relation)
    _, i = string.find(r_r,'[\n]')
    locl.room = (string.sub(room_relation, 1-i))
    exe('unset look')
    locl.where=locl.area..locl.room
    locl.room_relation = (string.gsub(room_relation,'[\n]',''))
	print(locl.room_relation)
end
function room_relative(n,l,w)
    local s=w[3]
    room_relation=(string.gsub(s,' ',''))
    r_r=string.reverse(room_relation)
    _, i = string.find(r_r,'[\n]')
    print (string.sub(room_relation, 1-i))
    print ((string.gsub(room_relation,'[\n]','')))
    local filename = GetInfo (67) .. "logs\\" .. score.id ..'�����ϵͼ'.. ".log"
    local file = io.open(filename,"a+")
    local s = '�������򣺡�'..w[2] ..'�� ����������'..'�� �����ϵ����'..room_relation..'��\n'
	--print(s)
    file:write(s)
    file:close()
end
local_exit=function(n,l,w)
    EnableTimer('loclWait',false)
    local cnt
	localget=1
	exit.locl={}
	locl.exit={}
    --exit.locl=exit_set(w[3])
    local l_exit=Trim(w[3])
    for w in string.gmatch(l_exit, "(%a+)") do
        table.insert(exit.locl, w)
    end
	
    local l_set=exit.locl
    if roomNodir[locl.where] then
       l_set=del_element(l_set,roomNodir[locl.where])
    end
    cnt=table.getn(l_set)
    if cnt==0 or cnt==nil then
       cnt=1
    end
    cnt=math.random(1,cnt)
    locl.dir=l_set[cnt]
    if locl.dir==nil then
       locl.dir='east'
    end
	for i=1,table.getn(exit.locl) do
		locl.exit[exit.locl[i]]=true
	end
    if locate_finish~=0 then
       return _G[locate_finish]()
    end
end
local_exitt=function()
    EnableTimer('loclWait',false)
    if locate_finish~=0 then
            return _G[locate_finish]()
        end
end
local_time=function(n,l,w)
    EnableTriggerGroup("locate",false)
    DeleteTriggerGroup("locate")
    locl.time=w[2]
end
local_time_cal=function(n,l,w)
	locl.weekday=Trim(tostring(w[1]))
	locl.hour=tonumber(w[2])
	locl.min=tonumber(w[3])
	if locl.weekday == '��' and ((locl.hour ==6 and locl.min>=45) or locl.hour==7) and go_on_smy==1 then --20161117���ӱ���go_on_smy���ؿ��� ��ֹϵͳ�������Զ�����Ħ��
		Note('�������������ˣ�')
		if job.zuhe["songmoya"]~=nil then
			job.zuhe["songmoya"]=nil
			Note('��Ħ�������ѹرգ�')
		end
	end
	if locl.weekday=='��' and locl.hour==8 and locl.min>=15 and go_on_smy==1 then
		if job.zuhe["songmoya"]==nil and tonumber(smydie)<2 then
			job.zuhe["songmoya"]=true --����֮�����������Ħ��
		end
	end
	if locl.hour==8 and locl.min<10 then
       smydie=0
	end		
end
local_id=function(n,l,w)
    local l_name=w[1]
    local l_id=w[2]
    local l_set={}
    if string.find(l_id,",") then
       l_set=utils.split(l_id,',')
       l_id=l_set[1]
    else
       if not string.find(l_id," ") and not string.find(l_id,'beauty') and string.len(l_name)<9 then
          MudUser[l_name]=l_id
       end
    end
    locl.id[l_name]=Trim(l_id)
    if ItemGet[l_name] then
       exe('get '.. l_id)
    end
    if weaponPrepare[l_name] and (not weaponStore[l_name] or not Bag[l_name])then
       exe('get '.. l_id)
    end
	
	l_set=utils.split(w[2],',')
	locl.item[l_name] = {}
	for p,q in pairs(l_set) do
	    locl.item[l_name][Trim(q)] = true  
	end
end
exit_set=function(exit)
    local l_set={}
    local l_exit=Trim(exit)
    for w in string.gmatch(l_exit, "(%a+)") do
        table.insert(l_set, w)
    end
	
    return l_set    
end
locate=function()
        locatee()
        create_timer_s('loclWait',1,'locatecheck')
end
locatecheck=function()
    locatee()
end
locatee=function()
    locate_trigger()
    EnableTrigger("locate5",true)
	localget=0
    exe('alias action ���ڶ�λ')
    exe('id here')
    exe('set look;l;time')
end
fastLocate=function()
	fastLocatee()
	create_timer_s('loclWait',0.3,'fastlocatecheck')
end
fastlocatecheck=function()
    fastLocatee()
end
function fastLocatee()
	locate_trigger()
    EnableTrigger("locate5",true)
    exe('alias action ���ڶ�λ')
    exe('set look;l')
end
function walk_trigger()
    DeleteTriggerGroup("walk")
    create_trigger_t('walk1','^(> )*��� "action" �趨Ϊ "���ڸ�·��" �ɹ���ɡ�$','','walk_goon')
    SetTriggerOption("walk1","group","walk")
    EnableTriggerGroup("walk",false)
end
function walk_wait()
    flag.walkwait=true
    EnableTriggerGroup("walk",true)
    EnableTrigger("hp12",true)
	   if tmp.find then
	         create_timer_s('walkWait',0.4,'walkTimer')
		  if cntr1() > 0 then
                     exe('alias action ���ڸ�·��')
		  else
		     cntr1 = countR(15)
		  end
	   else
             create_timer_s('walkWait',0.1,'walk_goon')
	   end
end
function walkTimer()
    if flag.walkwait then
        exe('alias action ���ڸ�·��')
    end
end
function walk_goon()
    flag.walkwait=false
    EnableTriggerGroup("walk",false)
    EnableTimer('walkwait',false)
	EnableTrigger("hp12",false)
	if tmp.find then
	   return searchFunc()
	end
	EnableTrigger("hp12",true)
    create_timer_s('roadWait',road.wait,'path_start')
end
function goto(where)
   dis_all()
   local l_dest={}
   sour.id = nil
   dest.id = nil
   tmp.goto = true
   where = Trim(where)
   
   l_dest.area,l_dest.room = locateroom(where)
   
   if l_dest.area then
      return go(test,l_dest.area,l_dest.room)
   else
      return ColourNote ("red","blue","�Ҳ������޷������(�ص�|����)��"..where)
   end

end

function go(job,area,room,sId)
	--map.rooms["sld/lgxroom"].ways["#outSld"]="huanghe/huanghe8"
	flag.search=0
    tmp.goto = nil
    sour.id=sId
    dest.id = nil
    if area~=nil then
       dest.area=area
    end
    if room~=nil then
       dest.room=room
    end
    if string.find(dest.area,"/") then
       dest.id = dest.area
       --Note(dest.id)
       dest.room = map.rooms[dest.id].name
       --Note(dest.room)
    end
    if job==nil then
       job=test
    end 
    flag.find=0
    flag.wait=0
    road.act=job
    road.i=0
    flag.dw=1
    tmp.find = nil
    --if sour.id ~= nil then
    --   return check_busy(path_consider)
    --else
       -- ain
       return check_halt(go_locate)
    --end
end
go_locate=function()
	EnableTriggerGroup("gpstest",true)
	EnableTrigger("hp12",true)
	locate()
	if locl.where=="��ѩɽ���Ŀ�" or locl.where=="��ɽ������" then
		path_consider()
	else
    checkWait(path_consider,0.5)
	end
end
function goContinue()
    return go(road.act)
end
function path_consider()
    local l_sour,l_dest,l_path,l_way
    local l_where=locl.area .. locl.room
    sour.rooms={}
    dest.rooms={}
	if sour.id and map.rooms[sour.id].name ~= locl.room then
	   sour.id = nil
	end

    if not sour.id and road.id and map.rooms[road.id] and map.rooms[road.id].name == locl.room then
       sour.id = road.id
    end
    if sour.id == nil then
       sour.room=locl.room
       sour.area=locl.area
       sour.rooms=getRooms(sour.room,sour.area)
    end
    if dest.id == nil then
       dest.rooms=getRooms(dest.room,dest.area)
    end
    if sour.id ~= nil then
       chats_locate('��λϵͳ���ӡ�'.. sour.id ..'������!')
    else
       chats_locate('��λϵͳ���ӡ�'.. sour.area .. sour.room ..'������!')
       if sour.room=="����̨" then
        exe('jump down')
       end
       if table.getn(sour.rooms)==0 then
         if locl.room=='Сľ��' then
          return toSldHua()
		 elseif locl.room=='Ȫˮ��' then
		    exe('tiao out;tiao out')
		    --quick_locate=0
            return checkWait(goContinue,0.3)
		 elseif locl.room=='ˮ̶' then
		    exe('pa up')
		    --quick_locate=0
            return checkWait(goContinue,0.3)
         else
			if locl.room_relation=='���϶����϶�' or locl.room_relation=="��֪��������϶� ��֪������ ���϶�" then
         	exe('drop fire;leave;leave;leave;leave;leave;leave;out;ne;ed;ne;ed')	
			--quick_locate=0
            return checkWait(goContinue,0.3)
           end
	       if locl.room_relation=='�����ߨL���׵�������ݺ������' then
	          exe('sw')	
	          --quick_locate=0
              return checkWait(goContinue,0.3)
	       end
	       if locl.room=='÷��' then
		     quick_locate=0
		     exe('n;n;n')
	         return checkWait(goContinue,0.2)
	       end
	       if locl.room=='�洬' then	
         	   exe('out;w;s;out;w;s;out;w;s')	
			   --quick_locate=0
               return checkWait(goContinue,0.3)
           end
          if locl.room_relation~='' then
              chats_locate('��λϵͳ��û�й����صķ��������room_relative�������Գ��Զ�λû�й����صķ��䡿','LimeGreen')
              --������Գ��Զ�λû�й����صķ���
          end
          chats_locate('��λϵͳ����ͼϵͳ�޴˵ص㡾'..locl.area .. locl.room ..'�����ϣ�����ƶ�Ѱ��ȷ�ж�λ�㣡','red')
          exe('stand;leave')
          exe(locl.dir)
          return checkWait(goContinue,0.2)
        end
       end	
	   if table.getn(sour.rooms)>1 and sour.id~='city/jiangbei' then                                                        ---------------------------------------------------------------------------------------------------
            chats_locate('��λϵͳ�������һ��ͬ�������жϡ�'..sour.room..'����!','LimeGreen')
             if locl.room_relation~='' then
              chats_locate('��λϵͳ�������ϵΪ��'..locl.room_relation..'��','LimeGreen')
            end
            for i=1,table.getn(sour.rooms) do
                    if ( locl.room_relation~='' and map.rooms[sour.rooms[i]].room_relative == locl.room_relation) then
                       chats_locate('��λϵͳ�����Ծ�ȷ��λ��','LimeGreen')    
                       sour.id=sour.rooms[i]
                       return check_halt(path_consider) 
                       --return go(road.act,dest.area,dest.room,sour.rooms[i])
                    end
            end               
	      for p in pairs(locl.id) do
	          local l_cnt = 0
	          local l_id
	          for k,v in pairs(sour.rooms) do
			      local l_corpse
			      if string.find(p,"��ʬ��") then
	   	             l_corpse = del_string(p,"��ʬ��")
				  else
				     l_corpse = p
				  end
	   	          if map.rooms[v] and map.rooms[v].objs and (map.rooms[v].objs[p] or map.rooms[v].objs[l_corpse]) then
	   		         l_cnt = l_cnt + 1
	   	             l_id = v
	   		      end
	   	      end  
	   	      if l_cnt == 1 then
	             return go(road.act,dest.area,dest.room,l_id)
	          end
	      end
		  if not roomMaze[l_where] then
             for p in pairs(locl.exit) do
                local l_cnt = 0
	            local l_id
                for i=1,table.getn(sour.rooms) do
                    if map.rooms[sour.rooms[i]] and map.rooms[sour.rooms[i]].ways and map.rooms[sour.rooms[i]].ways[p] then
                       l_cnt = l_cnt + 1
	   	               l_id = sour.rooms[i]
	                end
                end
                if l_cnt == 1 then
	               return go(road.act,dest.area,dest.room,l_id)
	            end
             end
		  end
	   end
	   if roomMaze[l_where] then
	      if type(roomMaze[l_where])=='function' then
		     l_way = roomMaze[l_where]()
		  else
		     l_way = roomMaze[l_where]
		  end
	   end
       if l_way then
          exe(l_way)
	      exe("yun jingli")
          chats_locate('��λϵͳ����ͼϵͳ�˵ص㡾'..locl.area .. locl.room ..'���޼�·�����ƶ�Ѱ��ȷ�ж�λ�㣡','red')
          return checkWait(goContinue,0.5)
       end
       if table.getn(sour.rooms)>1 and sour.id~='city/jiangbei' then                                                              -------------------------------------------------------------------------
          if locl.room_relation~='' then   --��������ȡ��������Թ�ϵ�ַ���
            for i=1,table.getn(sour.rooms) do
                    if (locl.room_relation~='' and map.rooms[sour.rooms[i]].room_relative == locl.room_relation) then
                       chats_locate('��λϵͳ����ȷ��λ����idΪ����'..sour.rooms[i]..'��','LimeGreen')
                       sour.id=sour.rooms[i]
                       return check_halt(path_consider)               
                       --return go(road.act,dest.area,dest.room,sour.rooms[i])
                     else
                        chats_locate('��λϵͳ����ͼϵͳ�˵ص㡾'..locl.area .. locl.room ..'���޷���ȷ��λ������ƶ���','red')
                        exe('stand;leave')
                        exe(locl.dir)
                        return checkWait(goContinue,0.5)
                    end
            end
          else
            chats_locate('��λϵͳ����ͼϵͳ�˵ص㡾'..locl.area .. locl.room ..'�����ڲ�ֹһ��������ƶ�Ѱ��ȷ�ж�λ�㣡','red')
            exe('stand;leave')
            exe(locl.dir)
            return checkWait(goContinue,0.5)
         end
       end
    end

    if dest.id == nil and table.getn(dest.rooms)==0 then
       Note('Path Consider GetRooms Error!')
       return false
    end
    path_create()
    return check_halt(path_start)
end
function path_cal()
    local l_sour,l_dest,l_path,l_distance
    sour.rooms={}
    dest.rooms={}

    if sour.id == nil then
       sour.room=locl.room
       sour.area=locl.area
       sour.rooms=getRooms(sour.room,sour.area)
       if table.getn(sour.rooms)==0 then
          Note('Path Cal GetSourRooms 0 Error!')
          return false
       end
       l_sour=sour.rooms[1]
    else
       l_sour=sour.id
    end
    if dest.id == nil then
       dest.rooms=getRooms(dest.room,dest.area)

       --if WhereIgnores[dest.area..dest.room] then
       --   return false
       --end
       if table.getn(dest.rooms)==0 then
          Note('Path Cal GetDestRooms 0 Error!')
          return false
       end
	   
          l_dest,l_distance=getNearRoom(l_sour,dest.rooms)
	      if not l_dest then
		     Note("�޷�����".. dest.area .. dest.room)
			 return false
	      end
    end

    if dest.id ~= nil then l_dest = dest.id end
    if sour.id ~= nil then l_sour = sour.id end
    road.id = l_dest
    l_path=map:getPath(l_sour,l_dest)
    if not l_path then
       Note('GetPath Error!')
       return false
    end

    return l_path
end

function path_create()
    local l_set
    local l_num=0
    local l_cnt=1
    local l_cntt=1
    road.detail={}
    l_sett=0
        l_settt=0
    l_path=path_cal()
    --Note(l_path)
    if type(l_path)~='string' then
       if math.random(1,4)==1 then
          l_path='stand;out;northeast;northwest;southeast;southwest;south;south;south;south;south'
       elseif math.random(1,4)==2 then
          l_path='stand;out;northeast;northwest;southeast;southwest;east;east;east;east;east;east'
       elseif math.random(1,4)==3 then
          l_path='stand;out;northeast;northwest;southeast;southwest;west;west;west;west;west;west'
       else
          l_path='stand;out;northeast;northwest;southeast;southwest;north;north;north;north;north'
       end
    end
    l_set=utils.split(l_path,';')  --һ��alias���м�������
        l_settt=table.getn(l_set)
        --print(l_path)
   if wdgostart==1 then
    if l_settt<= wd_distance then l_settt=wd_distance end
      for i=1,table.getn(l_set) do
        if i<l_settt-wd_distance-3 then
            if string.find(l_set[i],'#') then
                if l_num>0 then
                   l_cnt=l_cnt+1
                end
                road.detail[l_cnt]=l_set[i]
                l_cnt=l_cnt+1
                l_num=0
            else
                if l_num==0 then
                   road.detail[l_cnt]=l_set[i]
                else
                   road.detail[l_cnt]=road.detail[l_cnt]..';'..l_set[i]
                end
                l_num=l_num+1
                if l_num>road.steps then
                   l_cnt=l_cnt+1
                   l_num=0
                end
            end
        else
            if string.find(l_set[i],'#') then
                if l_num>0 then
                   l_cnt=l_cnt+1
                end
                road.detail[l_cnt]=l_set[i]
                l_cnt=l_cnt+1
                l_num=0
            else
                if l_num==0 then
                   road.detail[l_cnt]=l_set[i]
                else
                   road.detail[l_cnt]=road.detail[l_cnt]..';'..l_set[i]
                end
                l_num=l_num+1
                if l_num>0 then
                   l_cnt=l_cnt+1
                   l_num=0
                end
            end
        end
      end
   else
      for i=1,table.getn(l_set) do
          if string.find(l_set[i],'#') then
                if l_num>0 then
                  l_cnt=l_cnt+1
                end
                road.detail[l_cnt]=l_set[i]
                l_cnt=l_cnt+1
                l_num=0
          else
                if l_num==0 then
                  road.detail[l_cnt]=l_set[i]
                else
                  road.detail[l_cnt]=road.detail[l_cnt]..';'..l_set[i]
                end
                l_num=l_num+1
                if l_num>road.steps then
                   l_cnt=l_cnt+1
                   l_num=0
                end
          end
       end
   end
end
function path_start()
    EnableTrigger("hp12",false)
    EnableTimer("roadWait",false)
	DeleteTimer("roadWait",false)
    local l_road
    road.i=road.i + 1
    if flag.find==1 then return end 
    if road.i>table.getn(road.detail) then
	   locate_finish='go_confirm'
       return locate()
    end
    l_road=road.detail[road.i]
    if l_road and string.find(l_road,'ta corpse') then
	   DeleteTriggerGroup('eyu')
	   create_trigger_t('eyu1','^>*\\s*����\\(E yu\\)$','','jqgeyu')
	   create_trigger_t('eyu2','^>*\\s*����\\(E yu\\) <���Բ���>$','','jqgeyu')
	   create_trigger_t('eyu3','^>*\\s*�����ʬ��\\(Corpse\\)$','','jqgeyu')
	   create_trigger_t('eyu4','^>*\\s*������־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��$','','jqgeyu')
	   create_trigger_t('eyu5','^>*\\s*����һ�����ˮ�и��������ſ�Ѫ���ڣ��������˹�����$','','jqgeyu')
	   create_trigger_t('eyu6','^>*\\s*����̶ - $','','jqgeyu')
	   for i = 1,6 do SetTriggerOption("eyu" .. i,"group","eyu") end
	   create_timer_s('jqgeyu',30,'jqgeyuwait')
	end	        
    if string.find(l_road,'#') then
       local _,_,func,params = string.find(l_road,"^#(%a%w*)%s*(.-)$")
       if func then
		return _G[func](params)
		end 
    else
		exe(l_road)
        return walk_wait()
    end
end

function go_confirm()
	locate_finish=0
    checkWield()
    sour.id = nil
    if flag.go==nil then flag.go=0 end
    flag.go = flag.go + 1
	if string.find(locl.room,'����') or string.find(locl.room,'�ɿ�') or string.find(locl.room,'���׽���') then
	   flag.go=1
	end
    if flag.go>10 then flag.go=0 end    
    if locl.room == dest.room  and locl.room == "����" and locl.area ~= dest.area then
	   local sgate = 0
		     sgate = sgate + 1
	   if sgate>0 and sour.id~="���ݳǳ�������" then	
          exe('n')
       else 
          exe('s')
       end		  
	   return path_consider()
	end
    if locl.room == dest.room or flag.go == 0 then
	   if locl.room == dest.room and locl.area == dest.area then
          chats_locate('��λϵͳ���ӡ�'.. sour.area .. sour.room ..'������������Ŀ�ĵء�'..dest.area .. dest.room ..'����','seagreen')
       else
          chats_locate('��λϵͳ���ӡ�'.. sour.area .. sour.room ..'��������δ��Ŀ�ĵء�'..dest.area .. dest.room ..'�����յ�Ϊ��'.. locl.area .. locl.room ..'����','cyan')
       end
       flag.go=0
       if road.act ~= nil then          
          return road.act()
       end
    else
       return go(road.act)
    end
end

function find(l_area,l_room)
	if job.room~=nil and (job.room=='��ɼ��' or string.find(job.room,"����")) then create_timer_st('zsl_timer',30,'zsl_stop') end
    do return search() end
end
function zsl_stop()
	EnableTimer('zsl_timer',false)
	DeleteTimer("zsl_timer")
	if dest.room=='�㳡' then return end
	if (job.room=='��ɼ��' or string.find(job.room,"����")) and tmp.find and (flag.find==0 or flag.wait==0) and flag.times==1 then
       disAll()
       flag.times=2
	   if job.name=='wudang' then return wudangFindAgain() end
	   if job.name=='huashan' then return huashanFindAgain() end
	   if job.name=='xueshan' then return xueshanFindAgain() end
    end        
end
find_nobody=function()
    if string.find(job.name,'songxin') then
       chats_log('��λϵͳ��δ���ڡ�'..job.area ..'���ҵ���'..job.target..'����','songxinFindFail')
    end
    if job.name=='wudang' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','wudangFindFail')
       --if flag.times>2 then return wudangFindFail() end
    end
	  if job.name=='clb' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','clbFindFail')
    end   
	  if job.name=='husong' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','husongFindFail')
    end
    if job.name=='xueshan' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target..'����','xueshanFindFail')
    end
    if job.name=='tdh' then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ�����ͬ־��','tdhFindFail')
    end
    if job.name=='huashan' then
       chats_log('��λϵͳ��δ���ڡ�'..dest.area .. dest.room ..'���ҵ�����ͬ־��','huashanFindFail')
    end
    if job.name=="Dummyjob" then
       chats_log('��λϵͳ��δ���ڡ�'..job.area .. job.room ..'���ҵ���'..job.target4..'����')
       return dummyover()
    end
	if job.name=='zhuacaishen' then
       chats_log('��λϵͳ��δ���ڡ�'..dest.area .. dest.room ..'���ҵ�����ͬ־��','caishenFindFail')
    end
	if job.name=='guanfu' then
       chats_log('��λϵͳ��δ���ڡ�'..dest.area .. dest.room ..'���ҵ���'..job.target..'����','guanfuFindFail')
    end
    
    flag.times=flag.times + 1
	if flag.times>4 then
	   jobFindFail = jobFindFail or {}
	   if job.name and jobFindFail[job.name] then
		  jobfailLog()
	      local p = jobFindFail[job.name]
		  return _G[p]()
	   end
	else
	   jobFindAgain = jobFindAgain or {}
	   if job.name and jobFindAgain[job.name] then
	      local p = jobFindAgain[job.name]
		  return _G[p]()
	   end
	end
	if job.name=='dolost' then return lookXin() end
    return go(check_heal,'������','ҩ��')
end
List = {}
--��������
function List.new(val)
        return {pnext = nil, index=val}
end
--����һ���ڵ�
function List.addNode(nodeParent, nodeChild)
    nodeChild.pnext = nodeParent.pnext
    nodeParent.pnext = nodeChild
    return nodeChild
end
function searchPre()
	road.rooms={}
	--print(road.id)
    local p_room = map.rooms[road.id].name
	local p_dest = getLookCity(road.id)
	local l_distance = 8
  --[[if job.name and (job.name=="clb" or job.name=='tdh' or job.name=='tmonk') and flag.times==1 then
	   l_distance = 2
	end]]
	if flag.times==1 then
		if job.name=='wudang' and wd_distance>2 then
			l_distance = wd_distance
		else
			l_distance = 2
		end   
   end
   if flag.times==2 then
	  	if job.name=='wudang' and wd_distance>4 then
			l_distance = wd_distance
		else
			l_distance = 4
		end    
   end
   if flag.times==3 then
       l_distance = 6
   end
   if job.name=='zhuacaishen' or job.name=='dolost' then
	  l_distance = 6
   end

	if p_dest==nil then
	   p_dest=map.rooms[road.id].outdoor
	end
    local rooms = getAroundRooms(p_room,p_dest,l_distance,'all')
	roomsnum=countTab(rooms)
	--�����ڽӱ������ڵݹ�����
	--������ʼroad.id 
	starttime=os.clock() --���Լ���ʱ��
	newrooms = {}
	for id in pairs(rooms) do
			table.insert(newrooms,id)
	end

	myrt={}
	
	for _,roomid in pairs(newrooms) do --���뷿������
			roomV = List.new(roomid)
			local node = roomV
			for k,v in pairs(newrooms) do --���еķ���id
				for route,link_way in pairs(map.rooms[roomid].ways) do  --��ǰid�ĳ���
					local routeLength = map.rooms[roomid]:length(route) --��ȡ·�������Ƿ�ɴ����false��ʾ��·��ͨ����ô��������·�Ͳ������������
					--print("k="..k.."|link_way="..link_way.."|v="..v)
					if routeLength then
						---by fqyy 20170429 ����room.lengths����ֵ�ж�
						if routeLength ==1 or routeLength >1 and flag.times>1 then
							if v==link_way then 
								node = List.addNode(node,List.new(k)) --����ڵ����ɵ�һ������ĳ�������
							end
						end
					end
				end
			end
			table.insert(myrt,roomV)
	end
	visited={}

	for i=1 ,countTab(newrooms) do
		visited[i]=false --��ʼ�����нڵ�δ������
	end
	
	if not visited[1] then
		FastDFS(myrt,1) --����������ͨͼ
	end
	for i=1 ,countTab(newrooms) do
		if visited[i]==false then--δ�����ʵĽڵ����һ�¸���һ��������ͨ�ԣ��������ͨ����ݹ�����ڵ�
			local path, len = map:getPath(myrt[1].index,myrt[i].index)
			if path then
				FastDFS(myrt,i) --��������ָ����myrt[i]����ڵ�
				--messageShow("����ͨ·��������һ���ڵ㣡ͨ·����="..len,"red")
			end
		end
	end
	--messageShow("��"..job.name.."��������ȼ��������������"..roomsnum.."�������䣬��ʱ��"..os.clock()-starttime.."����","SandyBrown")
end
function FastDFS(myrt,i)
	visited[i] = true          --�����±�ΪI�Ķ���Ϊ�ѷ���  
    --Note("myrt["..i.."]="..myrt[i].index)  --���������Ϣ
    table.insert(road.rooms,myrt[i].index)
	local p = myrt[i].pnext --��һ���߱����  
	if p==nil then return end
    while p~=nil do   
      
        if(not visited[p.index]) then--�����δ���ʵ���ݹ� 
			visited[p.index]=true 
            FastDFS(myrt,p.index)
		end
        p = p.pnext
		
    end  
end
function dfs(from)
    for i=1,countTab(tmp.to) do
		if not tmp.to then
			break
		end
		local l_dest,l_p=getNearRoom(from,tmp.to)
		if l_dest then
			local l_check = true
			for v in pairs(road.rooms) do
				if v==l_dest then
					l_check = false
				end
			end
			if l_check then
				local path, len = map:getPath(from,l_dest)
				if path then
				   table.insert(road.rooms,l_dest)
				   table.remove(tmp.to,l_p)
				   dfs(l_dest)
				end
			end
		end
	end
end
function search()
	--Note("run search")
    tmp.find = true
    if flag.find==1 then return end
    searchPre()
	cntr1 = countR(15)
    exe('look;halt')
	tmpsearch=3
    return check_halt(searchStart,1)
end
function searchStart()
	flag.search=1
	--Note("run searchStart")
    if flag.find==1 then return end
    if flag.wait==1 then return end
    if table.getn(road.rooms)==0 then
       return find_nobody()
    end
    local path, length = map:getPath(road.id, road.rooms[1])
    road.id = road.rooms[1]
    table.remove(road.rooms,1)
	
	if type(path)~="string" then
	   --Note(road.id)
	   --Note(path)
	   return searchStart()
	end
	if string.find(path,'#') or job.name~='huashan' then
	       return searchFunc(path)
    else
		exe(string.sub(string.gsub(path, "halt;", ""),1,-2))
		_,tmpnum=string.gsub(path, ";", " ")
		tmpsearch=tmpsearch+tmpnum
		--print("n="..tmpsearch)
		if tmpsearch>20 then
			tmpsearch=3
			--print("apath:"..path)
			wait.make(function()
				wait.time(road.wait)
				searchStart()
			end)
			--return walk_wait()
		else
			tmpsearch=tmpsearch+1
            searchStart()
		end
    end

end
function searchFunc(path)
	--Note("run searchFunc")
    if flag.find==1 then return end
    if flag.wait==1 then return end
    road.pathset = road.pathset or {}
    if path then
       road.pathset=utils.split(path,";")
	   for i=1,table.getn(road.pathset) do
	       for p=1, table.getn(road.pathset) do
		       if isNil(road.pathset[p]) or road.pathset[p]=="halt" then
			      table.remove(road.pathset,p)
				  break
			   end
		   end
	   end
	end
	if table.getn(road.pathset)==0 then
	   return searchStart()
	end
        if string.find(road.pathset[1],'#') then
	       local _,_,func,params = string.find(road.pathset[1],"^#(%a%w*)%s*(.-)$")
	       if func then
	          table.remove(road.pathset,1)
	          return _G[func](params)
	       else
	          exe(road.pathset[1])
	          table.remove(road.pathset,1)
			  return walk_wait()
	       end
	   else
	      exe(road.pathset[1])
	      table.remove(road.pathset,1)
		  return walk_wait()
	   end
end

function searchWait()
    EnableTriggerGroup("find",true)
    exe('alias action ������Ѱ��')
end
delElement=function(set,dir)
    local l_cnt=0
    for i=1,table.getn(set) do
        if set[i]==dir then
           l_cnt=i
           break
        end
    end
    table.remove(set,l_cnt)
    return set
end

wipe_trigger=function()
    DeleteTriggerGroup("wipe")
    create_trigger_t('wipe1',"^>*\\s*(\\D*)��\\D*��Ķ����ˡ�$",'','wipe_goon')
    create_trigger_t('wipe2',"^>*\\s*(\\D*)��ž����һ�����ڵ��ϣ������ų鶯�˼��¾�����",'','wipe_goon')
    create_trigger_t('wipe3',"^>*\\s*(\\D*)��־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ",'','wipe_faint')
    create_trigger_t('wipe7',"^>*\\s*(\\D*)���Ӷ��˶������������˼��������ѹ���",'','wipe_wake')
    create_trigger_t('wipe4',"^>*\\s*�����(\\D*)(�ͺ�|���|���|�ȵ�|����һ��)",'','wipe_who')
    create_trigger_t('wipe5',"^>*\\s*����û������ˡ�",'','wipe_over')
    create_trigger_t('wipe6',"^>*\\s*��Ҫ��˭�����������",'','wipe_over')
    SetTriggerOption("wipe1","group","wipe")
    SetTriggerOption("wipe2","group","wipe")
    SetTriggerOption("wipe3","group","wipe")
    SetTriggerOption("wipe4","group","wipe")
    SetTriggerOption("wipe5","group","wipe")
    SetTriggerOption("wipe6","group","wipe")
    SetTriggerOption("wipe7","group","wipe")
    EnableTriggerGroup("wipe",false)    
end
wipe=function(wipe_str,wipe_con)
    wipe_trigger()
    EnableTriggerGroup("wipe",true)
    road.wipe_id=wipe_str
    road.wipe_con=wipe_con
    tmp.faint=0
    weapon_wield()
	beiUnarmed()  
    if WipeNoPerform[road.wipe_id] or tmp.gold then
       exe('kill '..road.wipe_id)
       if score.party and score.party=="�䵱��" then
          exe("jiali max")
       else
          exe("jiali max")
       end
	   exe('unset wimpy')
    else
       killPfm(road.wipe_id)
    end
    create_timer_s('wipe',2,'wipe_set')
end
wipe_set=function()
    exe('kill '..road.wipe_id)
end
wipe_who=function(n,l,w)
    road.wipe_who=Trim(w[1])
    job.killer=job.killer or {}
    if not WipeNoPerform[road.wipe_id] then
       job.killer[road.wipe_who]=road.wipe_id
    end
end
wipe_faint=function(n,l,w)
    if tmp.faint then
       tmp.faint=tmp.faint + 1
    end
    if road.wipe_who==Trim(w[1]) then
       exe('kill '..road.wipe_id)
       job.killer[road.wipe_who]="faint"
    end
end
wipe_wake=function(n,l,w)
    if tmp.faint then
       tmp.faint=0
    end
    if road.wipe_who==Trim(w[1]) then
       exe('kill '..road.wipe_id)
    end
end
wipe_goon=function(n,l,w)
    if job.name=="gblu" and road.wipe_who=="�о�����" then
       chats_log('��Ч���ң��㶨��'..locl.room..'�����о�������')
    end
    if tmp.faint and tmp.faint>0 then
       tmp.faint=tmp.faint - 1
    end
    if road.wipe_who==Trim(w[1]) then
       exe('kill '..road.wipe_id)
    end
end
wipe_over=function()
    wait_cd=os.time()
    DeleteTimer('wipe')
    DeleteTimer('perform')
    --exe('set wimpy 100')
	EnableTriggerGroup("wipe",false)
    road.wipe_id="wipe_id"
    if road.wipe_con~=nil then
       return check_halt(road.wipe_con)
    else
       return check_halt(walk_wait)
    end   
end

function thread_resume(thread)
    if type(thread)=='thread' then
       coroutine.resume(thread)
    end
end
function walkBusy()
    return check_halt(walk_wait)
end
--------------------------------��ɽ������-------------------------------------
hssslgo=function()
    road.temp=0
	locate_finish=0
	DeleteTriggerGroup("sslcheck")
	create_trigger_t('sslcheck1','^(> )*ʯ�� -','','hsssl_out') 
	SetTriggerOption("sslcheck1","group","sslcheck") 
	EnableTriggerGroup("sslcheck",true)
	if flag.find==1 then return end
	return sslgogo()
end
ssllook=function()
    exe('look')
end
sslgogo=function()
   road.temp = road.temp + 1
   if road.temp > 50 then
      return hsssl_out()
   end
   if flag.find==1 then return end
    exe('n;e;e;n;e;e')
	wait.make(function() 
	    wait.time(0.2)
		return sslgogo()
	end)
end
function hsssl()	
	if flag.find==1 then return end
	exe('n')
	exe('e')
	exe('e')
	exe('n')
	exe('e')
	exe('e')
	exe('n')
	exe('e')
	exe('e')
	locate_finish='hsssl_goon'
    return fastLocate()
end
hsssl_goon=function()
	locate_finish=0
	quick_locate=1
	wait.make(function() 
	    wait.time(0.15)
	if flag.find==1 then return end
	if locl.room=='ʯ��' then
		return hsssl_out()
	elseif locl.room_relation=='�յأ�������----������----ʯ�ݣ�ɽ����������' then
		exe('e')
		return hsssl_out()
	elseif locl.room=='�յ�' or locl.room=='������' then
        return hsssl()
	else
        return go_locate()	
	end
	end)
end
hsssl_out=function()
	EnableTriggerGroup("sslcheck",false)
	DeleteTriggerGroup("sslcheck")
    if flag.find==1 then return end
    return walk_wait()
end
------------
hscaidi=function()
    DeleteTriggerGroup("hscaidi")    
    create_trigger_t('hscaidi2','^>*\\s*������\\s*\\-','','hscaidi_out1')
    SetTriggerOption("hscaidi2","group","hscaidi")
    flag.find=0
    road.temp=0
    exe('n;n;n;n')
        wait.make(function()
            wait.time(0.2)
        if flag.find==1 then return end
            return hscaidi_goon1()
        end)
end
hscaidi_out1=function()
   caidiout=1
end
hscaidi_goon1=function()
    if caidiout==1 then
       EnableTriggerGroup("hscaidi",false)
       return hscaidi_out()
    else
       return hscaidi()
    end
end
hscaidi_out=function()
    caidiout=0
    EnableTriggerGroup("hscaidi",false)
    return walk_wait()
end
eaea=function()
    locate()
    return check_bei(eaea_start,0.5)
end
eaea_start=function()
    if string.find(locl.room,'�¹Ȼ��ٹ��') then
          exe('east')
          return eaea_over()
       else
          return go(road.act)
       end
end
eaea_over=function()
    return walk_wait()
end
---------------------------------------------�ɻƺ�------------------------------------------------	
duhe_trigger=function()
    EnableTriggerGroup("prepare_neili",false)
    DeleteTriggerGroup("prepare_neili")
	DeleteTriggerGroup("dujiang")
    DeleteTriggerGroup("duhe")
    create_trigger_t('duhe1','^>*\\s*�����ǰ�̤�Ű�������','','duhe_duhe')
    create_trigger_t('duhe2','^>*\\s*˵�Ž�һ��̤�Ű���ϵ̰����γ�һ����ȥ','','duhe_out')
    create_trigger_t('duhe3','^>*\\s*(��|��)��̫���ˣ����û����;�����ĵط�����û����Խ��ȥ��','','duhe_wait')
    create_trigger_t('duhe4','^>*\\s*��ľ���������','','duhe_jingli')
    create_trigger_t('duhe5','^>*\\s*���\\D*��Ϊ����','','duhe_cannt')
    create_trigger_t('duhe6','^>*\\s*������������ˣ�','','duhe_go_enter')
    create_trigger_t('duhe7','^>*\\s*��������������ȴ�������ϴ���Ǯ�����ˡ�','','duhe_silver')
    create_trigger_t('duhe8','^>*\\s*��һ����Ϣ����׼��(��|��)�жɴ�λ�ã�ʹ��','','duhe_fly')
    create_trigger_t('duhe9','^>*\\s*�����ǰ�̤�Ű���������������һ��','','duhe_duhe')
    create_trigger_t('duhe10','^>*\\s*һ�Ҷɴ�������ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿�����','','duhe_enter')
    create_trigger_t('duhe11','^>*\\s*�д������������Cool����','','duhe_waitb')
    create_trigger_t('duhe12','^>*\\s*���ڽ��жɴ�������һ�㣬��������','','duhe_fly')
    create_trigger_t('duhe13',"^(> )*(����Ƭ�̣���о��Լ��Ѿ��������޼���|�㽫��������������֮�ư�����һ��|��ֻ��������ת˳����������������|�㽫������ͨ���������|��ֻ����Ԫ��һ��ȫ����������|�㽫��Ϣ���˸�һ������|�㽫��Ϣ����ȫ��������ȫ���泩|�㽫�����������ڣ���ȫ���ۼ�����ɫ��Ϣ|�㽫����������������һ������|���˹���ϣ�վ������|��һ�������н������������ӵ�վ������|��ֿ�˫�֣�������������|�㽫��Ϣ����һ�����죬ֻ�е�ȫ��̩ͨ|������������������һ�����죬�����������ڵ���|������������������һ�����죬���������ڵ���|��˫��΢�գ���������ؾ���֮����������|���������������뵤������۾�|�㽫��Ϣ������һ��С���죬�������뵤��|��о�����ԽתԽ�죬�Ϳ�Ҫ������Ŀ����ˣ�|�㽫������Ϣ��ͨ���������������۾���վ������|������������һ��Ԫ����������˫��|�������뵤�������ת�����������չ�|�㽫����������������������һȦ���������뵤��|�㽫��Ϣ����������ʮ�����죬���ص���|�㽫��Ϣ���˸�С���죬���ص���չ�վ������|����Ƭ�̣������������Ȼ�ں���һ�𣬾����ӵ�վ����|��е��Լ��������Ϊһ�壬ȫ����ˬ��ԡ���磬�̲�ס�泩��������һ���������������۾�)",'','duhe_jump')
    create_trigger_t('duhe14','^>*\\s*����Ϣ���ȣ���ʱ����ʩ���ڹ���','','duhe_jump')
	create_trigger_t('duhe15',"^(> )*(�����������޼��񹦣����۵���|�����󽣾�������������|����ϥ����������˻�|����������ͨ����Ƭ��֮��|�����������ϥ��������������|����ϥ���£�Ĭ����ħ��|������������������|���������£�˫��ƽ����˫ϥ��Ĭ��ھ�|�������廨�룬��ϥ���£�Ĭ�˿�����|�������������ù���һ����Ϣ��ʼ����������|��������ϥ������˫�ְ�����ǰ|���������죬�ų�һ�������Ϣ˳������������|����ϥ���£�˫�ֺ�ʮ����ͷ����Ǳ������|����Ϣ�������������������ִ�������֮��|����ϥ���£���Ŀ��ʲ��Ĭ�˿�������|����ϥ���£���Ŀ��ʲ������Ǭ��һ����|����ϥ���£�������������ͼ��ȡ���֮����|���������һ�����������۾���������Ů�ľ�|���������£�˫Ŀ΢�գ�˫���������������̫��|�����˵�������ڶ��������Ƴ����������������㻺��Ʈ��|����ϥ������˫�ִ�����ǰ�ɻ���״����������|����ϥ��������ʹ�����������³�|���������£�˫��ƽ����˫ϥ��Ĭ��ھ�|������һվ��˫�ֻ���̧������һ����|����ϥ������˫Ŀ���գ�������һ�������뵤��|��ϯ�ض������������죬���Ϻ��ʱ��ʱ��|�㰵���ټ�ʮ��ׯ�����۵���|�����������Ŀ�������ִ����������Ⱥ������������֮���䣬��Ȼ֮�������������Ҿ���)",'','dazuo_wait')
    SetTriggerOption("duhe1","group","duhe")
    SetTriggerOption("duhe2","group","duhe")
    SetTriggerOption("duhe3","group","duhe")
    SetTriggerOption("duhe4","group","duhe")
    SetTriggerOption("duhe5","group","duhe")
    SetTriggerOption("duhe6","group","duhe")
    SetTriggerOption("duhe7","group","duhe")
    SetTriggerOption("duhe8","group","duhe")
    SetTriggerOption("duhe9","group","duhe")
    SetTriggerOption("duhe10","group","duhe")
    SetTriggerOption("duhe11","group","duhe")
    SetTriggerOption("duhe12","group","duhe")
    SetTriggerOption("duhe13","group","duhe")
    SetTriggerOption("duhe14","group","duhe")
	SetTriggerOption("duhe15","group","duhe")
    EnableTriggerGroup("duhe",true)
end
duHhe=function()
    if hp.neili_max > 3000 and skills['dodge'].lvl >= 200 then
	   flag.duhe=1
    else
       flag.duhe=0
    end
	if flag.search==1 and flag.times==3 then flag.duhe=0 end
    duhe_trigger()
    locate()
    return check_bei(duHhe_start)
end
duHhe_start=function()
    if string.find(locl.room,'��') then
	if ll_place and ll_place=='���ݴ�ɿ�' then return end
       EnableTriggerGroup("duhe",true)
       if flag.duhe==1 then
          exe('yell boat;duhe')
		  create_timer_st('walkWait4',2,'duhe_wait2')
          return 
       else
          return duhe_enter()
       end
    else
       if math.random(1,10)>1 then
          return go(road.act)
       else
          return duhe_over()
       end
    end
    --create_timer_s('walkWait4',1,'duhe_wait2')
end
function duhe_wait2()
    exe('yell boat;duhe')
end
duhe_duhe=function()
    if flag.duhe==1 then
	     prepare_neili_stop()
       return check_bei(duhe_jump)
    end
end
duhe_jump=function()
    return exe('yun qi;yell boat;duhe')
end
duhe_go_enter=function()
	DeleteTimer('walkwait4')
    if flag.duhe==1 then
    prepare_neili_stop()
    --exe('set ����')
    exe('yun qi;dazuo '..hp.dazuo)
	create_timer_st('walkWait4',2,'dazuo_check')
    end
end
duhe_enter=function()
    if flag.duhe==0 then
       prepare_neili_stop()
       return check_bei(duhe_enter_in)
    end
end
duhe_enter_in=function()
    prepare_neili_stop()
    exe('yell boat;enter')
    locate()
    return check_busy(duhe_enter_check)
end
duhe_enter_check=function()
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
       prepare_neili_stop()
    else
       exe('sxlian')
       return exe('yun qi;dazuo '..hp.dazuo)
    end
	create_timer_st('walkWait4',2,'dazuo_check')
end
duhe_out=function()
    exe('out')
    return duhe_over()
end
duhe_over=function()
    EnableTriggerGroup("duhe",false)
    DeleteTriggerGroup("duhe")
	weapon_unwield()
    weapon_wield()
	djdh_open()
	if road.i==0 then road.i=2 end
    return walk_wait()
end
duhe_wait=function()
    DeleteTimer('walkwait4')          
    exe('yun jing;yun qi;yun jingli;sxlian;dazuo '..hp.dazuo)
    create_timer_st('walkWait4',2,'dazuo_check')         
    --[[EnableTriggerGroup("duhe",false)
    DeleteTriggerGroup("duhe")    
    djdh_open()        
    djdh_close()        
    return path_consider()]]
end
duhe_waitb=function()
    DeleteTimer('walkwait4')          
   exe('yun jing;yun qi;yun jingli;sxlian;dazuo '..hp.dazuo)
    create_timer_st('walkWait4',2,'dazuo_check')   
    --[[djdh_open()        
    djdh_close()        
    return checkWait(path_consider,4)]]
end
duhe_jingli=function()
	DeleteTimer('walkwait4')
    return exe('yun jingli;duhe')
end
duhe_cannt=function()
    flag.duhe=0
	jifaDodge()
    return checkWait(duHhe_start,0.5)
end
duhe_silver=function()
    EnableTriggerGroup("duhe",false)
    exe('dig')
    return check_bei(duHhe)
end
duhe_fly=function()
	EnableTriggerGroup("duhe",false)
    DeleteTriggerGroup("duhe")
	DeleteTimer('walkwait4')
	    wait.make(function() 
        wait.time(5)
        exe('jifa all')  
        return check_busy(duhe_over)
        end)
   --return check_bei(duhe_over)
end
------------------------------------------�ɳ���-------------------------------------------------------------
dujiang_trigger=function()
    EnableTriggerGroup("prepare_neili",false)
    DeleteTriggerGroup("prepare_neili")
	DeleteTriggerGroup("duhe")
    DeleteTriggerGroup("dujiang")
    --create_trigger_t('dujiang1','^(> )*�����ˮ̫��̫������ɲ���ȥ��','','')
    create_trigger_t('dujiang2','^(> )*(�ɴ��͵�һ���Ѿ�����|����˵���������ϰ��ɡ�)','','dujiang_out')
    create_trigger_t('dujiang3','^(> )*(��|��)��̫���ˣ����û����;�����ĵط�����û����Խ��ȥ��','','dujiang_wait')
    create_trigger_t('dujiang4','^(> )*��ľ��������ˣ�','','dujiang_jingli')
    create_trigger_t('dujiang5','^(> )*���\\D*��Ϊ����','','dujiang_cannt')
    create_trigger_t('dujiang6','^(> )*������������ˣ�','','dujiang_go_enter')
    create_trigger_t('dujiang7','^(> )*�����ˮ̫��̫������ɲ���ȥ��','','dujiang_move')
    create_trigger_t('dujiang8','^(> )*��һ����Ϣ����׼��(��|��)�жɴ�λ�ã�ʹ��','','dujiang_fly')
    create_trigger_t('dujiang9','^(> )*����(��|)��̤�Ű���','','dujiang_dujiang')
    create_trigger_t('dujiang10','^(> )*һ�Ҷɴ�������ʻ�˹�����������һ��̤�Ű���ϵ̰����Ա�˿�����','','dujiang_enter')
    create_trigger_t('dujiang11','^(> )*�д������������Cool����','','dujiang_waitb')
    create_trigger_t('dujiang12','^(> )*���ڽ��жɴ�������һ�㣬��������','','dujiang_fly')
    create_trigger_t('dujiang13',"^(> )*(����Ƭ�̣���о��Լ��Ѿ��������޼���|�㽫��������������֮�ư�����һ��|��ֻ��������ת˳����������������|�㽫������ͨ���������|��ֻ����Ԫ��һ��ȫ����������|�㽫��Ϣ���˸�һ������|�㽫��Ϣ����ȫ��������ȫ���泩|�㽫�����������ڣ���ȫ���ۼ�����ɫ��Ϣ|�㽫����������������һ������|���˹���ϣ�վ������|��һ�������н������������ӵ�վ������|��ֿ�˫�֣�������������|�㽫��Ϣ����һ�����죬ֻ�е�ȫ��̩ͨ|������������������һ�����죬�����������ڵ���|������������������һ�����죬���������ڵ���|��˫��΢�գ���������ؾ���֮����������|���������������뵤������۾�|�㽫��Ϣ������һ��С���죬�������뵤��|��о�����ԽתԽ�죬�Ϳ�Ҫ������Ŀ����ˣ�|�㽫������Ϣ��ͨ���������������۾���վ������|������������һ��Ԫ����������˫��|�������뵤�������ת�����������չ�|�㽫����������������������һȦ���������뵤��|�㽫��Ϣ����������ʮ�����죬���ص���|�㽫��Ϣ���˸�С���죬���ص���չ�վ������|����Ƭ�̣������������Ȼ�ں���һ�𣬾����ӵ�վ����|��е��Լ��������Ϊһ�壬ȫ����ˬ��ԡ���磬�̲�ס�泩��������һ���������������۾�)",'','dujiang_jump')
    create_trigger_t('dujiang14','^>*\\s*����Ϣ���ȣ���ʱ����ʩ���ڹ���','','dujiang_jump')
	create_trigger_t('dujiang15',"^(> )*(�����������޼��񹦣����۵���|�����󽣾�������������|����ϥ����������˻�|����������ͨ����Ƭ��֮��|�����������ϥ��������������|����ϥ���£�Ĭ����ħ��|������������������|���������£�˫��ƽ����˫ϥ��Ĭ��ھ�|�������廨�룬��ϥ���£�Ĭ�˿�����|�������������ù���һ����Ϣ��ʼ����������|��������ϥ������˫�ְ�����ǰ|���������죬�ų�һ�������Ϣ˳������������|����ϥ���£�˫�ֺ�ʮ����ͷ����Ǳ������|����Ϣ�������������������ִ�������֮��|����ϥ���£���Ŀ��ʲ��Ĭ�˿�������|����ϥ���£���Ŀ��ʲ������Ǭ��һ����|����ϥ���£�������������ͼ��ȡ���֮����|���������һ�����������۾���������Ů�ľ�|���������£�˫Ŀ΢�գ�˫���������������̫��|�����˵�������ڶ��������Ƴ����������������㻺��Ʈ��|����ϥ������˫�ִ�����ǰ�ɻ���״����������|����ϥ��������ʹ�����������³�|���������£�˫��ƽ����˫ϥ��Ĭ��ھ�|������һվ��˫�ֻ���̧������һ����|����ϥ������˫Ŀ���գ�������һ�������뵤��|��ϯ�ض������������죬���Ϻ��ʱ��ʱ��|�㰵���ټ�ʮ��ׯ�����۵���|�����������Ŀ�������ִ����������Ⱥ������������֮���䣬��Ȼ֮�������������Ҿ���)",'','dazuo_wait')
    --SetTriggerOption("dujiang1","group","dujiang")
    SetTriggerOption("dujiang2","group","dujiang")
    SetTriggerOption("dujiang3","group","dujiang")
    SetTriggerOption("dujiang4","group","dujiang")
    SetTriggerOption("dujiang5","group","dujiang")
    SetTriggerOption("dujiang6","group","dujiang")
    SetTriggerOption("dujiang7","group","dujiang")
    SetTriggerOption("dujiang8","group","dujiang")
    SetTriggerOption("dujiang9","group","dujiang")
    SetTriggerOption("dujiang10","group","dujiang")
    SetTriggerOption("dujiang11","group","dujiang")
    SetTriggerOption("dujiang12","group","dujiang")
    SetTriggerOption("dujiang13","group","dujiang")
    SetTriggerOption("dujiang14","group","dujiang")
	SetTriggerOption("dujiang15","group","dujiang")
    EnableTriggerGroup("dujiang",true)
end
duCjiang=function()
    if hp.neili_max > 3500 and skills['dodge'].lvl >= 200 then
	   flag.dujiang=1
    else
       flag.dujiang=0
	end
	if flag.search==1 and flag.times==3 then flag.dujiang=0 end
    dujiang_trigger()
    locate()
    return check_bei(duCjiang_check)
end
duCjiang_check=function()
    if string.find(locl.room,'���Ϲٵ�') then
       exe('halt;n')
       return duCjiang_start()
    else
       return duCjiang_start()
    end
end
duCjiang_start=function()
    if string.find(locl.room,'��') then
	if ll_place and ll_place == '���ݳǳ�������' then return end
       EnableTriggerGroup("dujiang",true)
       if flag.dujiang==1 then
		create_timer_st('walkWait4',2,'dujiang_wait2')
          return exe('yell boat;dujiang')
       else
          return dujiang_enter()
       end
    else
       if math.random(1,10)>1 then
          return go(road.act)
       else
          return dujiang_over()
       end
    end
	--create_timer_s('walkWait4',1,'dujiang_wait2')
end
function dujiang_wait2()
    exe('dujiang')
end
dujiang_dujiang=function()
    if flag.dujiang==1 then
	     prepare_neili_stop()
       return check_bei(dujiang_jump)
    end
end
dujiang_jump=function()
    exe('yun qi;yell boat;dujiang')
end
dujiang_go_enter=function()
	DeleteTimer('walkwait4')
    if flag.dujiang==1 then
    --exe('set ����')
    exe('yun qi;dazuo '..hp.dazuo)
    end
	create_timer_st('walkWait4',2,'dazuo_check')
end
dujiang_enter=function()
    if flag.dujiang==0 then
       prepare_neili_stop()
       return check_bei(dujiang_enter_in)
    end
end
dujiang_enter_in=function()
    prepare_neili_stop()
    exe('yell boat;enter')
    locate()
    return check_busy(dujiang_enter_check)
end
dujiang_enter_check=function()
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
       return prepare_neili_stop()
    else
       exe('sxlian')
       return exe('yun qi;dazuo '..hp.dazuo)
    end
	create_timer_st('walkWait4',2,'dazuo_check')
end
function dazuo_check()
	exe('dazuo '..hp.dazuo)
end
function dazuo_wait()
	DeleteTimer('walkWait4')
end
dujiang_out=function()
    exe('out')
    return dujiang_over()
end
dujiang_over=function()
    EnableTriggerGroup("dujiang",false)
    DeleteTriggerGroup("dujiang")
	weapon_unwield()
    weapon_wield()
	djdh_open()
    return walk_wait()
end
dujiang_wait=function()
   DeleteTimer('walkwait4') 
    exe('yun jing;yun qi;yun jingli;sxlian;dazuo '..hp.dazuo)
   create_timer_s('walkWait4',1,'dazuo_check')
end
dujiang_waitb=function()
   DeleteTimer('walkwait4') 
    exe('yun jing;yun qi;yun jingli;sxlian;dazuo '..hp.dazuo)        
    create_timer_s('walkWait4',1,'dazuo_check')
end
dujiang_jingli=function()
	DeleteTimer('walkwait4')
    return exe('yun jingli;dujiang')
end
dujiang_cannt=function()
    flag.dujiang=0
	jifaDodge()
    return checkWait(duCjiang_start,0.5)
end
dujiang_fly=function()
   -- ain
   EnableTriggerGroup("dujiang",false)
   DeleteTriggerGroup("dujiang")
   DeleteTimer('walkwait4')
        wait.make(function() 
            wait.time(5) 
        exe('jifa all')  
        return check_busy(dujiang_over)
        end)
   --return check_bei(dujiang_over)
end
dujiang_move=function()
   exe('e;e;w')
   return dujiang_dujiang()
end
jqgin=function()
	locate()
	return check_bei(jqgin_start,0.5)
end
function jqgin_start()
	if locl.where ~= '�����СϪ��' then
       return go(road.act)
	else
	   return jqgin1()
    end
end   
function jqgin1()
   DeleteTriggerGroup("jqgin")
   create_trigger_t('jqgin1','^>*\\s*��Ҫ��ʲô��','','jqgin_look')
   create_trigger_t('jqgin2','^>*\\s*һҶС�ۣ�ƮƮ����������Ϫ����������ȥ��','','jqgin_jump')
   create_trigger_t('jqgin3','^>*\\s*�ֻ��������Ϫ�ĺ��оſ��ʯӭ����������������һ�㣬��ס������ȥ·��','','jqgin_out') 
   SetTriggerOption("jqgin1","group","jqgin")
   SetTriggerOption("jqgin2","group","jqgin")
   SetTriggerOption("jqgin3","group","jqgin")
   road.temp=0
   if locl.where == '�����СϪ��' then
      exe('look boat')
	  create_timer_st('walkWait4',3.0,'jqgin_look')
   end
end
jqgin_look=function()
	DeleteTimer("walkWait4")
   road.temp = road.temp + 1
   if road.temp > 30 then
      dis_all()
      check_heal()
      return
   end
   wait.make(function() 
      wait.time(2)
      exe('look boat')
   end)
end
jqgin_jump=function()
	DeleteTimer("walkWait4")
   exe('jump boat')
end
jqgin_out=function()
   EnableTriggerGroup("jqgin",false)
   exe('out')
   --thread_resume(walk)
   walk_wait()
end
jqgout=function()
   DeleteTriggerGroup("jqgout")
   create_trigger_t('jqgout1','^>*\\s*�����ű�����ô�ƶ�С�ۣ�','','jqgout_weapon')
   create_trigger_t('jqgout2','^>*\\s*�ֻ��������Ϫ�����ۣ�С�۾������˼�������ֻص�Ϫ�ߡ�','','jqgout_out')
   create_trigger_t('jqgout3','^>*\\s*��Ҫ��˭�����������','','jqgout_out')

   SetTriggerOption("jqgout1","group","jqgout")
   SetTriggerOption("jqgout2","group","jqgout")
   SetTriggerOption("jqgout3","group","jqgout")
   jqgout_weapon()
end
jqgout_weapon=function()
   weapon_unwield()
   exe('tui boat')
   check_halt(jgqout_jump)
end
jgqout_jump=function()
   exe('jump boat')
end
jqgout_out=function()
   EnableTriggerGroup("jqgout",false)
	DeleteTriggerGroup("jqgout")
   exe('out')
   --thread_resume(walk)
   walk_wait()
end
jqgzlin=function()
   DeleteTriggerGroup("jqgzlin")
   create_trigger_t('jqgzlin1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','jqgzlin_goon')
   SetTriggerOption("jqgzlin1","group","jqgzlin")
   exe('nd')
   locate()
   check_halt(jqgzlin_con)
end
function jqgzlin_con()
   exe('alias action �뿪��������')
end
jqgzlin_goon=function()
   if locl.room~="����" then
      return jqgzlin_over()
   end
   local l_set={'east','west','south','north'}
   local l_cnt=math.random(1,table.getn(l_set))
   exe(l_set[l_cnt])
   exe('su;nd;wd')
   locate()
   checkWait(jqgzlin_con,2)
end
jqgzlin_over=function()
   EnableTriggerGroup("jqgzlin",false)
   DeleteTriggerGroup("jqgzlin")
   walk_wait()
end
jqgzlout=function()
   DeleteTriggerGroup("jqgzlout")
   create_trigger_t('jqgzlout1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','jqgzlout_goon')
   SetTriggerOption("jqgzlout1","group","jqgzlout")
   exe('eu')
   locate()
   check_halt(jqgzlout_con)
end
function jqgzlout_con()
   --exe('alias action �뿪��������')
   jqgzlout_goon()
end
jqgzlout_goon=function()
   if locl.room~="����" then
      return jqgzlout_over()
   end
   local l_set={'east','west','south','north'}
   local l_cnt=math.random(1,table.getn(l_set))
   exe(l_set[l_cnt])
   exe('wd;eu;su')
   locate()
   checkWait(jqgzlout_con,2)
end
jqgzlout_over=function()
   EnableTriggerGroup("jqgzlout",false)
   DeleteTriggerGroup("jqgzlout")
   walk_wait()
end

function outJjl()
   locate()
   check_halt(outJjl_check)
end
function outJjl_check()
   if locl.room~='������' and locl.room~='ɽ·' then
      return outJjl_over()
   else
      exe('yun jingli;yun qi;s')
      return outJjl()
   end
end
function outJjl_over()
   walk_wait()
end

function goHt()
	exe("ask gongsun zhi about �����")
	check_halt(goHt_act)
end
function goHt_act()
	exe("xian hua;zuan dao")
	walk_wait()
end

function outGb()
        locate()
	check_halt(outGb_check)
end
function outGb_check()
	if locl.room~="����" then
           return outGb_over()
	else
	   wait.make(function()
	      exe("#12s")
	      wait.time(1.5)
              return outGb()
           end)
	end
end
function outGb_over()
        exe('north')
        walk_wait()
end

function toQc()
        locate()
	check_halt(toQc_check)
end
function toQc_check()
	if locl.room~="ɳĮ" then
           return toQc_over()
	else
	   --wait.make(function()
	      exe("#5s;#5n")
	    --  wait.time(1.5)
              return toQc()
         --  end)
	end
end
function toQc_over()
        walk_wait()
end

---------------
-- ain ��Ĺ����
gmmsout=function()
   DeleteTriggerGroup("gmmsout")
   create_trigger_t('gmmsout1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','gmmsout_goon')
   SetTriggerOption("gmmsout1","group","gmmsout")
   locate()
   exe('e;e;e;e;e;enter;s;s;s;s;s;enter;w;w;w;w;w;enter;n;n;n;n;n;enter')
   check_halt(gmmsout_con)
end
function gmmsout_con()
   locate()
   exe('alias action �뿪��������')
end
gmmsout_goon=function()
   if locl.room~="ʯ��" then
      exe('say �����߳�����')
      return gmmsout_over()
   end
   local l_set={'east','west','south','north'}
   local l_cnt=math.random(1,table.getn(l_set))
   exe(l_set[l_cnt])
   print(l_set[l_cnt])
   exe('get fire;enter;say �߲���ȥ...')
   locate()
   checkWait(gmmsout_con,2)
end
gmmsout_over=function()
   EnableTriggerGroup("gmmsout",false)
   DeleteTriggerGroup("gmmsout")
   walk_wait()
end

---------------
--------------by fqyy 20170502 ��ɼ�������㷨---------------
local ZslOutArea = {
	["��ɼ�֣���ˮ��----��ɼ��----��ɼ�֣���ɼ����ɼ��"] = {"w"},
	["��ɼ�֣������----��ɼ��----��ɼ�֣���ɼ����ɼ��"] = {"w;s;s;s"},
	["��ɼ�֣���ɼ��----��ɼ��----���������ɼ����ɼ��"] = {"e;s;s;s;e;e;e;e"},
	["��ɼ�֣���ɼ��----��ɼ��----�һ������ɼ����ɼ��"] = {"e;e;e;e;e"},
}
local ZslInArea = {
	["�����ţ�������----��ɼ��----�����ţ���������ɼ��"] = {"s","w","n","e"},
	["�����ţ�������----��ɼ��----�����ţ���������ɼ��"] = {"e","s","w","n"},
	["�����ţ�������----��ɼ��----�����ţ���������ɼ��"] = {"n","e","s","w"},
	["�����ţ�������----��ɼ��----�����ţ���������ɼ��"] = {"w","n","e","s"},
}
-------------by fqyy ���㷨 20170502
local ZslMen = 0
local ZslMenRun = false
function outzsl()
    fastLocate()
	return checkWait(outzsl_check,0.5)
end
function outzsl_check()
	ZslMenRun=false
	if locl.room=="��ɼ��" then 
		tmpr={}
		tmpr=ZslOutArea[locl.room_relation]
		if tmpr~=nil then
			exe(tmpr[1])
			print("��ɼ�ֳ���·��"..tmpr[1])
			walk_wait()
		else
			exe("ne;w")
			return outzsl()
		end
	else
		walk_wait()
	end
end
function tianMen()
	mjMenF(1)
end
function diMen()
	mjMenF(2)
end
function fengMen()
	mjMenF(3)
end
function leiMen()
	mjMenF(4)
end
function mjMenF(namen)
	ZslMen=namen
	--ZslMenRun=false
	mjMen()
end
function mjMen()
	print("mjmen")
	fastLocate()
	ZslMenRun=true
	wait.make(function()
	   wait.time(0.5)
		return mjMen_checkF()
	end)
end
function mjMen_checkF()
	print("mencheckf")
	ZslMenRun=false
	mjMen_check()
end
function mjMen_check()
	if ZslMenRun then
		print("mencheck:"..locl.room.."|wait="..flag.wait.."|ZslMenRun=true")
	else
		print("mencheck:"..locl.room.."|wait="..flag.wait.."|ZslMenRun=false")		
	end
	if locl.room == "��ɼ��" then
		if flag.wait==0 then
			if not ZslMenRun then
				local tmpr={}
				tmpr=ZslInArea[locl.room_relation]
				if tmpr~=nil then
					exe(tmpr[ZslMen])
					print("�������·��"..tmpr[ZslMen])
				else
					exe("n")
				end
				return mjMen()
			end
		else
			ZslMenRun=false
		end
	else
		walk_wait()
	end
end
--------------------------------------------------------------
function outZyl()
   DeleteTriggerGroup("outzyl")
   create_trigger_t('outzyl1','^>*\\s*��� "action" �趨Ϊ "�뿪��Ҷ������" �ɹ���ɡ�','','outZylCheck')
   create_trigger_t('outzyl2','^>*\\s*���۵ð���������ҵ�����ȷ�ķ���','','outZyl_over')
   SetTriggerOption("outzyl1","group","outzyl")
   SetTriggerOption("outzyl2","group","outzyl")
   --exe('alias action �뿪��Ҷ������')
   cntr1 = countR(50)
   return outZylCheck()
end
function outZylCheck()
    wait.make(function() 
       wait.time(2)
        locate()
        return check_busy(outZyl_goon,1)
    end)
end
function outZyl_goon()
   if locl.room~="��Ҷ��" then
      return go(road.act)
   end
   road.zyl = road.zyl or {}
   if countTab(road.zyl)==0 then
      road.zyl["#15e"] = true
	  road.zyl["#15s"] = true
	  road.zyl["#15w"] = true
	  road.zyl["#15n"] = true
   end
   for p in pairs(road.zyl) do
       tmp.zyl = p
	   road.zyl[p] = nil
       exe('halt;ne')
       exe(p)
       return exe('alias action �뿪��Ҷ������')
   end
end
function outZyl_over()
   EnableTriggerGroup("outzyl",false)
   road.zyl = {}
   --road.zyl[tmp.zyl] = true
   walk_wait()
end

function dmd()
    if not tmp.dmd then
	   tmp.dmd = true
	   exe("s;w;n;nw;n")
	else
	   exe('nw;w;e;e;s;w;n;nw;n')
	end
	locate()
	check_halt(dmd_check)
end
function dmd_check()
	if locl.room ~= "����" then
	   return dmd_over()
	else
	   wait.make(function()
	      wait.time(1)
	      return dmd()
	   end)
	end
end
function dmd_over()
        walk_wait()
end

function toXcm()
	weapon_unwield()
	weaponWieldCut()
	exe("zhan tielian")
    return check_halt(toXcm_jump)
end
function toXcm_jump()
	exe("jump duimian")
	return check_halt(toXcm_over)
end
function toXcm_over()
    weapon_unwield()
    return walk_wait()
end

function outTlsSsl()
        exe("s;w;s;w")
	exe("#11 s")
	locate()
	return check_halt(outTlsSsl_check,1)
end
function outTlsSsl_check()
	if locl.room ~= "������" and locl.room ~= "ʯ��·" then
	   return outTlsSsl_over()
	else
	   return outTlsSsl()
	end
end
function outTlsSsl_over()
    return walk_wait()
end

function hmyUp()
    jifaDodge()
    exe('zong')
	return check_halt(hmyUpLocate)
end
function hmyUpWait()
    exe('yun qi;dazuo '..hp.dazuo)
    check_busy(hmyUp)
end
function hmyUpLocate()
        locate()
	return check_halt(hmyUpCheck,1)
end
function hmyUpCheck()
        if locl.room ~= "����ƺ" then
	   return hmyUpOver()
	else
	   return hmyUpWait()
	end
end
function hmyUpOver()
    return walk_wait()
end

function hmyDown()
    jifaDodge()
    exe('zong')
	check_halt(hmyDownLocate)
end
function hmyDownLocate()
        locate()
	return check_halt(hmyDownCheck,1)
end
function hmyDownCheck()
        if locl.room ~= "�¶�" then
	   return hmyDownOver()
	else
	   return hmyDownWait()
	end
end
function hmyDownWait()
    exe('yun qi;dazuo '..hp.dazuo)
    check_busy(hmyDown)
end
function hmyDownOver()
    return walk_wait()
end

function toRyp()
	exe("whisper bu �����ĳ���£�һͳ����")
	exe("whisper bu ����ǧ�����أ�һͳ����")
	exe("whisper bu ��������Ϊ������������")
	exe("whisper bu ������ּӢ���������Ų�")
	exe("whisper bu �����������£��츣����")
	exe("whisper bu ����ս�޲�ʤ�����޲���")
	exe("whisper bu ��������ĳ���¡�����Ӣ��")
	exe("whisper bu ��������ʥ�̣��󱻲���")
	exe("wu")
    return walk_wait()
end
---------by fqyy test ���Һ�ɽ��ľ��-------------
function emeishuitan()
	exe('pa up')
	check_busy(walk_wait)
end
function outemgmc()
   DeleteTriggerGroup("outemgmc")
   create_trigger_t('outemgmc1','^>*\\s*��� "action" �趨Ϊ "�뿪���ҹ�ľ������" �ɹ���ɡ�','','outemgmcCheck')
   create_trigger_t('outemgmc2','^>*\\s*�������߳��˹�ľ�ԡ�','','outemgmc_over')
   SetTriggerOption("outemgmc1","group","outemgmc")
   SetTriggerOption("outemgmc2","group","outemgmc")
   cntr1 = countR(50)
   return outemgmcCheck()
end
function outemgmcCheck()
    wait.make(function() 
       wait.time(2)
        locate()
        return check_busy(outemgmc_goon,1)
    end)
end
function outemgmc_goon()
   if locl.room~="��ľ��" then
      return go(road.act)
   end
   road.zyl = road.zyl or {}
   if countTab(road.zyl)==0 then
      road.zyl["yun jingli;ne;ne;ne;ne;ne;ne;ne;ne;ne;yue qiaobi"] = true
   end
   for p in pairs(road.zyl) do
       tmp.zyl = p
	   road.zyl[p] = nil
       exe('halt;ne')
	   if flag.wait==1 then return end
       exe(p)
	   if flag.wait==1 then return end
       return exe('alias action �뿪���ҹ�ľ������')
   end
end
function outemgmc_over()
   EnableTriggerGroup("outemgmc",false)
   road.zyl = {}
   walk_wait()
end
function Toghz()
	weapon_unwield()
    exe("get axe;wield axe;wield jian;wield dao;kan guanmu;drop axe")
	if score.party and score.party=='������' and score.master=='�º���' then
		exe("ed;yue qiaobi")
	end
    return walk_wait()
end
---------by fqyy test �䵱��ɽé��---------------
function Wdmw()
        DeleteTriggerGroup("inwdmw")
        create_trigger_t('inwdmw1','^(> )*����û������ˡ�','','Wdmw_error')
        create_trigger_t('inwdmw2','^(> )*�����ҩ���������йء�ҩ�䡻����Ϣ��','','Wdmw_find')
        SetTriggerOption("inwdmw1","group","inwdmw")
        SetTriggerOption("inwdmw2","group","inwdmw")
    exe("w;d;nd;nd;nd;nd;nw;ask caiyao about ҩ��")
    if flag.find==1 then return end
	if flag.wait==1 then return end

        --return check_bei(Wdmw1)
end
function Wdmw_error()
        DeleteTriggerGroup("inwdmw")
    exe("se;su;su;su;su;pa up")
    if flag.find==1 then return end
    if flag.wait==1 then return end
        return walk_wait()
end
function Wdmw_find()
    -- return check_bei(Wdmw1)
    wait.make(function()  --2019.1.13
            wait.time(0.6)
        return check_bei(Wdmw1)
    end)
end
function Wdmw1()
    if flag.find==1 then return end
	if flag.wait==1 then return end
        exe("ask caiyao about ֻ��")
    -- return check_bei(Wdmw2) 
    wait.make(function()  --2019.1.13
            wait.time(0.6)
        return check_bei(Wdmw2)
    end)
end
function Wdmw2()
    DeleteTriggerGroup("inwdmw")
    exe("w;nd;nd;nd;nd;n;n;nd;out;nd;nd;nd;ed;nd;nd;nu;nd;nd;ed;nd;ed;nd;nd;nd;nd;nd;e;se")
    if flag.find==1 then return end
	if flag.wait==1 then return end
        return Wdmw3()
    end
function Wdmw3()
        wait.make(function() 
                wait.time(1.2) --Wdmw2 exe����28��ָ��
        exe("ask tao hua about rumor")
        if flag.find == 1 then return end --���
        if flag.wait==1 then return end
        -- return Wdmw4()
        wait.make(function()  --2019.1.13
            wait.time(0.3)
            return check_bei(Wdmw4)
        end)

    end)
end
function Wdmw4()        
    exe("nw;w;su;su;su;su;su;wu;su;wu;su;su;sd;su;su;wu;su;su;su;enter;su;s;s")
    if flag.find == 1 then return end --���
	if flag.wait==1 then return end
    return Wdmw5()
end
function Wdmw5()
        wait.make(function() 
        wait.time(1) -- 2019.1.13 Wdmw4 23��ָ������1s
        exe("su;su;su;su;e;se;su;su;su;su")
        if flag.find == 1 then return end --���
		if flag.wait==1 then return end
                return Wdmw6()
        end)
end
function Wdmw6()
        wait.make(function()
        wait.time(0.4) -- 2019.1.13 Wdmw5 9��ָ������0.4s
		if flag.find == 1 then return end --���
		if flag.wait==1 then return end
        exe("pa up;e")
            return Wdmw7()
        end)
end
function Wdmw7()
        wait.make(function()
        wait.time(0.4) -- 2019.1.13 Wdmw5 1��ָ������0.4s zuan shulin���Դ�Խ��ע��
		if flag.find == 1 then return end --���
		if flag.wait==1 then return end
        exe("zuan shulin")
                return walk_wait()
        end)
end
--------------by fqyy�䵱��ɽ����----------------
function OutWdhs()
	wait.make(function() 
		wait.time(0.5)
		exe("halt;eu")
		return OutWdhs1()
    end)
end
function OutWdhs1()
	wait.make(function() 
		wait.time(0.5)
		exe("halt;su")
		return OutWdhs2()
    end)
end
function OutWdhs2()
	wait.make(function() 
		wait.time(0.5)
		exe("halt;nd;nd;")
		return OutWdhs3()
    end)
end
function OutWdhs3()
	wait.make(function() 
		wait.time(0.5)
		exe("halt;su;wd;wd")
		return walk_wait()
    end)
end
-----------------by fqyy �䵱��ɽ���ִ���------
function inWdcl()
	exe("hold teng;jump down")
	return walk_wait()
end
local wdclorder={
	["�һ����"]=1,
	["��Ҷ����"]=2,
	["��ѩ����"]=3,
	["��Ҷ����"]=4,
	["���ֱ�Ե"]=5,
}
local wdclOutDoorCmd={"nw","n","ne","w","look","e","sw","s","se"}
local wdclOutAreaNum={1,9,17,31,42,53,67,75,83}
local tt_step=1
local wdclCurrentRoom=""

function outWdcllh()
	wdclCurrentRoom="�һ����"
	flag.times=2
	tt_step=1
	outWdcl1()
end
function outWdclly()
	wdclCurrentRoom="��Ҷ����"
	tt_step=1
	outWdcl1()
end
function outWdcljx()
	wdclCurrentRoom="��ѩ����"
	tt_step=1
	outWdcl1()
end
function outWdclky()
	wdclCurrentRoom="��Ҷ����"
	tt_step=1
	outWdcl1()
end
function outWdcl1()
	fastLocate()
	return checkWait(outWdclCheck0,1)
end
function outWdclCheck0()
	return check_halt(outWdclCheck)
end
function outWdclCheck()
	if not wdclorder[locl.room] then
		return walk_wait()
	end
	local p,n,randomN,findRoomN
	local wdclOutDoor={
	}
	--print(dest.room)
	if dest.room~="�һ����" and dest.room~="��Ҷ����" and dest.room~="��ѩ����" and dest.room~="��Ҷ����" and dest.room~="���ֱ�Ե" then
		tt_step=6 
	end
	wdclOutDoor[1]={}
	wdclOutDoor[2]={}
	wdclOutDoor[3]={}
	wdclOutDoor[4]={}
	wdclOutDoor[5]={}
	--print(tt_step,locl.room,wdclCurrentRoom)
	if not (wdclorder[wdclCurrentRoom]<wdclorder[locl.room]) then
		if flag.wait==0 then
			for i=1,9 do
				if i~=5 then 
					p=string.sub(locl.room_relation,wdclOutAreaNum[i],wdclOutAreaNum[i]+7)
					--print(p)
					table.insert(wdclOutDoor[wdclorder[p]],wdclOutDoorCmd[i])
				end
			end
			if tt_step<6 then
				findRoomN=wdclorder[locl.room]
			else 
				findRoomN=wdclorder[locl.room]+1
			end
			randomN=table.getn(wdclOutDoor[findRoomN])
			tt_step=tt_step+1
			if randomN~=nil and randomN>0 then
				dn=math.random(randomN)
				print("�����䵱��ɽ���ֳ���Ϊ"..wdclOutDoor[findRoomN][dn].."���Ҵ���="..flag.times)
				exe(wdclOutDoor[findRoomN][dn])
			else
				findRoomN=findRoomN-1
				randomN=table.getn(wdclOutDoor[findRoomN])
				dn=math.random(randomN)
				print("�����䵱��ɽ����û�г���ԭ������ƶ�"..wdclOutDoor[findRoomN][dn].."���Ҵ���="..flag.times)
				exe(wdclOutDoor[findRoomN][dn])
			end
			return outWdcl1()
		end
	else
		return walk_wait()
	end
end
function wdclToHsda()
	exe("jump river")
	DeleteTriggerGroup("wdclToHsda")
    create_trigger_t('wdclToHsda1','^>*\\s*���沨���������ڷ����˰��ߣ�����ʪ�����������˺�ˮ������','','wdclToHsda2')
	SetTriggerOption("wdclToHsda1","group","wdclToHsda") 
    EnableTriggerGroup("wdclToHsda",true)
end
function wdclToHsda2()
	EnableTriggerGroup("wdclToHsda",false)
	DeleteTriggerGroup("wdclToHsda")
	return walk_wait()
end

--------------------------------------------
function Togudi()        
    exe('cuo shupi;cuo shupi;cuo shupi;cuo shupi;cuo shupi;cuo shupi;cuo shupi;cuo shupi;cuo shupi;bang song;pa down')
    fastLocate()
    return check_busy(Goyadi,1)
end
function Goyadi()
    if string.find(locl.room,'�ȵ�') then
                return walk_wait()
        elseif string.find(locl.room,'�±�') then                
               exe("pa down")
            fastLocate()
                return check_busy(Goyadi,1)
        end
end
function Toqiaobi()
    exe('pa yabi')
    fastLocate()
    return check_busy(Goqiaobi,1)
end
function Goqiaobi()
    if string.find(locl.room,'�ͱ�') then
                return walk_wait()
    elseif string.find(locl.room,'�±�') then
            exe("pa up")
            fastLocate()
                return check_busy(Goqiaobi,1)
        end
end
function Totanan()
    DeleteTriggerGroup("qqs")
    create_trigger_t('qqs1','^>*\\s*��Ҫ������Ǳ��$','','qQydok')
    create_trigger_t('qqs2','^>*\\s*�����������������޷�������Ǳ!$','','qQyderorr')
        create_trigger_t('qqs3','^>*\\s*��һ�����ԣ�Ǳ����ȥ��$','','jgq_qiandown')
    SetTriggerOption("qqs1","group","qqs") 
    SetTriggerOption("qqs2","group","qqs") 
        SetTriggerOption("qqs3","group","qqs") 
    EnableTriggerGroup("qqs",true)    
        exe('#10(jian shi)')
        checkBags()
        return checkWait(jqg_checktiaotan,1)
end
function jqg_checktiaotan()
	    if not Bag["ENCB"] then
	    Bag = Bag or {}
        Bag["ENCB"] = {}
        Bag["ENCB"].value = 81
	    end
        if Bag["ENCB"].value and Bag["ENCB"].value > 100 then
                exe('#5(drop stone)')
                checkBags()
                return checkWait(jqg_checktiaotan,1)
        elseif Bag["ENCB"].value > 80 then
                exe('tiao tan')
                return jgq_qiandown()
        else
                exe('#6(jian shi)')
                checkBags()
                return checkWait(jqg_checktiaotan,1)
        end
end
function jgq_qiandown()
        check_busy(function() exe('qian down') end,1)
end
function jqg_qianup()
        check_busy(function() exe('qian up') end,1)
end

function qQyderorr()
        EnableTriggerGroup("qqs",false)          
        check_halt(qQyderorrgetstone)
end
function qQyderorrgetstone()
        exe('pa up;#2(jian shi)')
        EnableTriggerGroup("qqs",true)  
        checkBags()
        return checkWait(jqg_checktiaotan,1)
end
function qQydok()
    DeleteTriggerGroup("qqs")            
        checkBags()
        checkWait(qQyd_dropstone,1)                
end

function qQyd_dropstone()
        if not Bag["ENCB"] or not Bag["ENCB"].value then
                exe('#25(drop stone)')
        else
                if Bag['��ʯ��'] and Bag['��ʯ��'].cnt then 
                        exe('#' .. Bag['��ʯ��'].cnt .. '(drop da shikuai)')                
                end
                if Bag['����ʯ'] and Bag['����ʯ'].cnt then 
                        exe('#' .. Bag['����ʯ'].cnt .. '(drop e luanshi)')                
                end
                if Bag['Сʯͷ'] and Bag['Сʯͷ'].cnt then 
                        exe('#' .. Bag['Сʯͷ'].cnt .. '(drop xiao shitou)')                
                end        
        end
        return checkBags(totanan_check_qqup)        
end
function totanan_check_qqup()        
        create_trigger_t('qqs1','^>*\\s*�����ӳ��أ��þ�ȫ��Ҳ�޷���������ȥ��$','','totanan_check_qqup')                
        create_trigger_t('qqs2','^>*\\s*����������һ�ţ������Ϸ���ȥ��$','','qQup')        
        create_trigger_t('qqs3','^>*\\s*��Ҫ������Ǳ��$','','Hyadi')        
        SetTriggerOption("qqs1","group","qqs") 
    SetTriggerOption("qqs2","group","qqs") 
        SetTriggerOption("qqs3","group","qqs") 
        exe('#5(drop stone);qian zuoshang')                        
end

function qQup()
        check_busy(function() exe('qian up') return check_busy(qQsover) end,1)
end

function qQsover()
        DeleteTriggerGroup("qqs")
    exe("pa up")
    exe("#5(drop stone)")
        return walk_wait()
end
function Hgudi()    
        DeleteTriggerGroup("qqs")
    create_trigger_t('qqs1','^>*\\s*��Ҫ������Ǳ��$','','Hyadi')
    create_trigger_t('qqs2','^>*\\s*�����������������޷�������Ǳ!$','','qQyderorr')
        create_trigger_t('qqs3','^>*\\s*��һ�����ԣ�Ǳ����ȥ��$','','jgq_qiandown')
    SetTriggerOption("qqs1","group","qqs") 
    SetTriggerOption("qqs2","group","qqs") 
        SetTriggerOption("qqs3","group","qqs") 
    EnableTriggerGroup("qqs",true)    
        exe('#10(jian shi)')
        checkBags()
        return checkWait(jqg_checktiaotan,1)
end

function Hyadi()
        DeleteTriggerGroup("qqs")
        checkBags()
        check_busy(hhq_dropstone,1)
end
function hhq_dropstone()
        if not Bag["ENCB"] or not Bag["ENCB"].value then
                exe('#25(drop stone)')
        else
                if Bag['��ʯ��'] and Bag['��ʯ��'].cnt then 
                        exe('#' .. Bag['��ʯ��'].cnt .. '(drop da shikuai)')                
                end
                if Bag['����ʯ'] and Bag['����ʯ'].cnt then 
                        exe('#' .. Bag['����ʯ'].cnt .. '(drop e luanshi)')                
                end
                if Bag['Сʯͷ'] and Bag['Сʯͷ'].cnt then 
                        exe('#' .. Bag['Сʯͷ'].cnt .. '(drop xiao shitou)')                
                end        
        end        
        return checkBags(Hyadiup)        
end
function Hyadiup()        
        DeleteTriggerGroup("qqs")
        create_trigger_t('qqs1','^>*\\s*(�����ӳ��أ��þ�ȫ��Ҳ�޷���������ȥ|�����ӳ��أ��þ�ȫ��Ҳ�޷�Ǳ������)','','Hyadiup')                
        create_trigger_t('qqs2','^>*\\s*��(��������һ�ţ������渡ȥ|�ֽ��뻮��˳��ˮ�������渡ȥ)','','jqg_qianup')        
        create_trigger_t('qqs3','^>*\\s*��Ҫ������Ǳ��$','','hhqover')        
        SetTriggerOption("qqs1","group","qqs") 
    SetTriggerOption("qqs2","group","qqs") 
        SetTriggerOption("qqs3","group","qqs")         
        exe('#20(drop stone);qian up')                        
end

function hhqover()
        exe('#5(drop stone);pa up')        
        DeleteTriggerGroup("qqs")
        return walk_wait()
end
----------����ȴ�����ֹ----------------
function Fqy()
    exe("enter")
return walk_wait()
end
function Inwdj()
    exe("northup")
return walk_wait()
end
---------by fqyy test �������߿�----------
function Insldsk()
	exe("#10(kan ɽ��);climb")
	return walk_wait()
end
function Outsldsk()
	exe("drop shenlong pi;drop shenlong pi;drop shenlong pi;drop shenlong pi;drop shenlong pi;wear all;go east;go east;go east;go east")
	return walk_wait()
end
------------------------------------------
function boatYell()
    exe("yell boat;;enter")
	locate()
	tmp.cnt = 0
	DeleteTimer('boat')
	create_timer_s('boat',3,'boatInCheck')
end
function boatInCheck()
    DeleteTimer('boat')
	exe('yell boat;enter')
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
	   return boatWait()
	elseif string.find(locl.room,'������') then
		exe('south;#3w;#2e;#3s;qu xiaozhu')
	   locate()
	   return create_timer_s('boat',3,'boatInCheck')
	elseif string.find(locl.room,'����') or string.find(locl.room,'С����') then
	   locate()
	   return create_timer_s('boat',3,'boatInCheck')
	else
	   return go(road.act)
        end
 end
function boatWait()
	DeleteTimer('boat')
	boatOutTrigger()
	create_timer_s('boat',20,'boatCheck')
end
function CboatWait()
	DeleteTimer('boat')
	create_timer_s('boat',10,'Checkloboat')
end
function Checkloboat()
	DeleteTimer('boat')
	locate()
	create_timer_s('boat',2,'Checkboat')
end
function Checkboat()
    if string.find(locl.room,'��') or string.find(locl.room,'��') then
	   return boatCheck()
	elseif string.find(locl.room,'����') then
	   exe('qu xiaozhu')
	   return create_timer_s('boat',3,'Checkloboat')
	else
	   return go(road.act)
        end
end
function boatCheck()
        DeleteTimer('boat')
	locate()
	return check_halt(boatOutCheck)
end
function boatReCheck()
        DeleteTimer('boat')
	boatOutTrigger()
	create_timer_s('boat',2,'boatCheck')
end
function boatOutCheck()
        DeleteTimer('boat')
        local cnt=table.getn(exit.locl)
	if cnt==0 then
	   check_halt(boatReCheck)
	else
	   return boatOut()
	end
end
function boatOutTrigger()
    DeleteTriggerGroup("boat")
    create_trigger_t('boat1','^(> )*(�����С�ۿ��ڰ��ߣ����´��ɡ�|����˵���������ϰ��ɡ����漴��һ��̤�Ű���ϵ̰���|���ڵ���С���ߣ������С�ۿ��ڰ��ߣ����´��ɡ�|���ڵ��˰��ߣ������С�ۿ��ڰ��ߣ����´��ɡ�)','','boatOut')
	SetTriggerOption("boat1","group","boat")  
end
function boatOut()
    EnableTimer('boat',false)
    DeleteTimer('boat')
        exe("out")
        walk_wait()
end

function outJgzW()
    return outJgz()
end
function outJgzE()
    return outJgz()
end 
function outJgz()
    DeleteTriggerGroup("jiugz")
    create_trigger_t('jiugz1','^>*\\s*����һƬï�ܵ��һ��ԣ���һ�߽�������ʧ�˷��򡣵�����(\\D*)���һ�\\(taohua\\)��$','','outJgzGet')
    create_trigger_t('jiugz2','^>*\\s*����һƬï�ܵ��һ��ԣ���һ�߽�������ʧ�˷��򡣵���һ���һ�\\(taohua\\)Ҳû�С�$','','outJgzGo')
    SetTriggerOption("jiugz1","group","jiugz") 
    SetTriggerOption("jiugz2","group","jiugz")
    EnableTriggerGroup("jiugz",false)
    exe('w;w;n;n')
    return outJgzTaohua(1)
end
function outJgzTaohua(p_cnt)
    if p_cnt then tmp.i=p_cnt else tmp.i=tmp.i+1 end
    if tmp.i==2 then exe('e') end
    if tmp.i==3 then exe('e') end
    if tmp.i==4 then exe('s') end
    if tmp.i==5 then exe('w') end
    if tmp.i==6 then exe('w') end
    if tmp.i==7 then exe('s') end
    if tmp.i==8 then exe('e') end
    if tmp.i==9 then exe('e') end
	if tmp.i==10 then
	   return outJgzDrop()
	end
	EnableTriggerGroup("jiugz",true)
    exe('look')
end
function outJgzGet(n,l,w)
    EnableTriggerGroup("jiugz",false)
    exe('get '.. trans(w[1]) .. ' taohua')
    return check_halt(outJgzTaohua)
end
function outJgzGo()
    EnableTriggerGroup("jiugz",false)
    return check_halt(outJgzTaohua)
end
function outJgzDrop()
    exe('w;w;n;n')
    exe('drop 2 taohua')
	exe('e')
	exe('drop 9 taohua')
	exe('e')
	exe('drop 4 taohua')
	exe('s')
	exe('drop 3 taohua')
	exe('w')
	exe('drop 5 taohua')
	exe('w')
	exe('drop 7 taohua')
	exe('s')
	exe('drop 6 taohua')
	exe('e')
	exe('drop 1 taohua')
	exe('e')
	exe('drop 8 taohua')
	locate()
	return check_halt(outJgzCheck)
end
function outJgzCheck()
    if locl.room=="�Ź��һ���" then
	   return outJgz()
	else
	   return outJgzOver()
	end
end
function outJgzOver()
    EnableTriggerGroup("jiugz",false)
	DeleteTriggerGroup("jiugz")
	return walk_wait()
end

function wdYm()
    DeleteTriggerGroup("wdxj")
    create_trigger_t('wdxj1','^>*\\s*��վ��С���ϣ����ܴ������·𿴼�(\\D*)����Щ���⡣$','','wdYmGo')
    SetTriggerOption("wdxj1","group","wdxj")
    exe('s')
    locate()
    check_halt(wdYmCheck)
    tmp.i=1
end
function wdYmCheck()
    DeleteTimer("wdxjTimer")
    if locl.room~="С��" then
       return wdYmOver()
    end
    create_timer_s('wdxjTimer',16,'wdYmRandom')
end
function wdYmRandom()
    tmp.i=tmp.i+1
    exe('n;n;n;n;n;n;n;n;n;s;s;s;s;s;s')
    fastLocate()
    wait.make(function() 
		wait.time(0.5)
		check_halt(wdYmCheck)
	end)    
end
function wdYmGo(n,l,w)
	if flag.wait==0 then
		local l_dir
		DeleteTimer("wdxjTimer")
		if w[1]=="��" then l_dir='e' end
		if w[1]=="��" then l_dir='w' end
		if w[1]=="��" then l_dir='s' end
		if w[1]=="��" then l_dir='n' end
		exe("halt;"..l_dir)
		fastLocate()
		wait.make(function() 
			wait.time(0.5)
			check_halt(wdYmCheck)
		end)    
	end
end
function wdYmOver()
    DeleteTimer("wdxjTimer")
    EnableTriggerGroup("wdxj",false)
    walk_wait()
end
----------by fqyy 20170504 ������������----------------
local mjslOutArea = {
	["���֣�����-----����-----���֣����������"] = "s",
	["���֣������-----����-----���֣���������"] = "w",
	["�����������-----����-----���֣���������"] = "n",
	["���֣�����-----����-----���������������"] = "e",
}
local mjslOutArea1 ={
	["���֣�����-----����-----��ľ�����������"] = true,
}
local mjslOutArea4 ={
	["���֣���ľ��-----����-----���֣����������"] = true,
}
local mjslOutAreaFlag=1;
function mjSlout1()
	mjslOutAreaFlag=1
	mjSlout()
end
function mjSlout4()
	mjslOutAreaFlag=4
	mjSlout()
end
function mjSlout()
    fastLocate()
    wait.make(function() 
		wait.time(0.5)
		check_halt(mjSloutCheck)
	end)
end
function mjSloutCheck()
	if flag.wait==0 then
		if locl.room=="����" then
			if mjslOutArea1[locl.room_relation] then
				if mjslOutAreaFlag==1 then
					exe("s")
				else
					exe("e;e;n")
				end
				return mjSlout()
			end
			if mjslOutArea4[locl.room_relation] then
				if mjslOutAreaFlag==4 then
					exe("n")
				else
					exe("w;w;s")
				end
				return mjSlout()
			end
			local tmpsl=mjslOutArea[locl.room_relation]
			if tmpsl~=nil then
				exe(tmpsl)
				print("�������ֳ���"..tmpsl)
			end
			return mjSlout()
		else
			walk_wait()
		end
	end
end

---------------------------------------------

function PoutShangguan()
    DeleteTriggerGroup("tiezhangsg")
    create_trigger_t('tiezhangsg1','^(> )*��������������������˿�������Ĺ�������������ƿ���','','ShangguanOk')
	create_trigger_t('tiezhangsg2','^(> )*���в�ѽ��û����Ĺ����ʲô����','','ShangguanAsk')
	create_trigger_t('tiezhangsg3','^(> )*��һЩ����˵�����������������ϵķ�Ĺ�У������������ٺ٣�һ����ʲô���������棡','','GoShangguan')
	create_trigger_t('tiezhangsg4','^(> )*����û������ˡ�','','GoShangguanQiuError')
	SetTriggerOption("tiezhangsg1","group","tiezhangsg")
    SetTriggerOption("tiezhangsg2","group","tiezhangsg")
    SetTriggerOption("tiezhangsg3","group","tiezhangsg")
    SetTriggerOption("tiezhangsg4","group","tiezhangsg")
    EnableTriggerGroup("tiezhangsg",true)
    --return check_busy(GoShangguan)
	exe("move bei")
end
function ShangguanAsk()
	exe("sd;se;sd;sd;se;sd;se;sd;sd;s;s;s;sd;e;ask qianzhang about �ֹ�")
end
function GoShangguan()
	return check_halt(GoShangguanOk)
end
function GoShangguanOk()
	exe("sd;sd;n;n;nw;w;w;e;nu;n;n;n;nu;nu;nw;nu;nw;nu;nu;nw;nu;move bei")
end
function GoShangguanQiuError()
	EnableTrigger("tiezhangsg4",false)
	exe("se;ask qianzhang about �ֹ�;nw;w;ask qianzhang about �ֹ�;w;ask qianzhang about �ֹ�;e;nu;ask qianzhang about �ֹ�;sd;s;ask qianzhang about �ֹ�;n;e")
end
function ShangguanOk()
	EnableTriggerGroup("tiezhangsg",false)
	DeleteTriggerGroup("tiezhangsg")
    exe('move bei;enter')
    return walk_wait()
end
function ptoSld()
    exe('yell ������鸣����')
    checkWait(ptoSldCheck,2)
end
function ptoSldCheck()
    locate()
    check_halt(ptosldDukou,2)
end
function ptosldDukou()
    if locl.room=="�ɿ�" then
       return toSldOver()
    elseif locl.room~="����" then
	return walk_wait()
    else
       return checkWait(ptoSldCheck,2)
    end
end
sld_unwield=function()
    for p in pairs(Bag) do
      if Bag[p].kind and (not itemWield or itemWield[p]) then
       local _,l_cnt = isInBags(Bag[p].fullid)
       for i = 1,l_cnt do
           exe('unwield '.. Bag[p].fullid ..' '..i)
       end
    end
  end
  exe('unwield wuji xiao')
end
sld_weaponWieldCut=function()
    for p in pairs(Bag) do
      if Bag[p].kind and weaponKind[Bag[p].kind] and weaponKind[Bag[p].kind]=="cut" then
       if not (Bag[p].kind == "xiao" and weaponUsave[p]) then
          for q in pairs(Bag) do
              if Bag[q].kind == "xiao" and weaponUsave[q] then
               exe('unwield '.. Bag[q].fullid )
            end
          end
          exe('wield '.. Bag[p].fullid )
       end
    end
  end
exe('wield lianyu sword;uweapon shape lianyu sword')
end
function toSld()
	if locl.where ~= '��������̲' then
       return toSldDkCheck()
    end
	sld_unwield()
    sld_weaponWieldCut()
	if not Bag["������"] then
       exe('buy cu shengzi')
       exe('drop cu shengzi 2')
	end
       exe('get cu shengzi')
       exe('drop cu shengzi 2')
    return check_halt(toSldTrigger,1.5)
end
function toSldTrigger()
	DeleteTriggerGroup("mufabusy")
    create_trigger_t('mufabusy1','^(> )*ľ����û����ʵ�����������ɡ�','','wait_mufa')
    create_trigger_t('mufabusy2','^(> )*ֻ��(\\D*)����һԾ��������ľ���ϡ�','','mufaok')
    create_trigger_t('mufabusy3','^(> )*�����û�����������ֿ���','','sld_need_weapon')
    create_trigger_t('mufabusy4','^(> )*��Ҫ��ʲô��','','wait_mufa')
	create_trigger_t('mufabusy5','^(> )*ʲô��','','wait_mufa')
	create_trigger_t('mufabusy6','^(> )*������ľ���ϵ�һ��ľͷ����ľ����ǰ��ȥ��','','toSldHua')
	SetTriggerOption("mufabusy1","group","mufabusy")
    SetTriggerOption("mufabusy2","group","mufabusy")
    SetTriggerOption("mufabusy3","group","mufabusy")
    SetTriggerOption("mufabusy4","group","mufabusy")
    SetTriggerOption("mufabusy5","group","mufabusy")
    SetTriggerOption("mufabusy6","group","mufabusy")
    EnableTriggerGroup("mufabusy",true)
if locl.where == '��������̲' then
   toSldChop()
end
end
function toSldChop()
    exe('chop tree;bang mu tou;zuo mufa')
	create_timer_s('walkWait4',1.0,'toSldChop1')
end
function toSldChop1()
	if tmp.cnt then
	   tmp.cnt = tmp.cnt + 1
	end
	if not tmp.cnt or tmp.cnt>2 then
	   EnableTimer('walkWait4',false)
	end
	exe('chop tree;bang mu tou;zuo mufa')
end
function toSldDelTrigger()
	DeleteTriggerGroup("mufabusy")
end
function sld_need_weapon()
  wait.make(function()
            wait.time(1)
            sld_unwield()
            sld_weaponWieldCut()
            return check_bei(toSldChop)
          end)
end
function wait_mufa()
	EnableTimer('walkWait4',false)
  wait.make(function()
            wait.time(0.2)
            return check_bei(toSldChop)
          end)
end
function mufaok(n,l,w)
	EnableTimer('walkWait4',false)
	print("mufaokw--"..w[2])
	if string.find(w[2],"��") then
		print("mufaokw--toslddk")
		EnableTriggerGroup("mufabusy",false)
		DeleteTriggerGroup("mufabusy")
		toSldDukou()
	else
		sld_need_weapon()
	end
end
function toSldCheck()
    print("toSldCheck")
	if locl.room=="Сľ��" or locl.room=="ľ��" then
       return toSldHua()
    else
       return check_halt(toSld)
    end
end
function toSldHua()
	print("toSldHua")
    sld_unwield()
    exe('hua mufa')
    wait.make(function()
            wait.time(3)
            return toSldDukou()
          end)
end
function toSldDukou()
    print("toSldDukou")
	fastLocate()
	wait.make(function()
            wait.time(2)
            return toSldDkCheck()
    end)
end
function toSldDkCheck()
     print("toSldDkCheck")
	toSldDelTrigger()
	if locl.room=="�ɿ�" then
       return toSldOver()
    elseif locl.room=="Сľ��" or locl.room=="ľ��" then
       return toSldHua()
    elseif locl.area and locl.area=='������' and locl.room=='��̲' then
       return toSld()
    elseif locl.area and locl.area~='������' then
       return walk_wait()
    end
end
function toSldOver()
    return walk_wait()
end

function outSld()
    if score.party and score.party=="������" then
       exe('ask lu gaoxuan about ling pai')
    else
       exe('steal lingpai')
    end
    check_busy(outSldGive)
end
function outSldGive()
    wait.make(function() 
       wait.time(2)
        if score.party == '������' and job.name == 'huashan' then
           exe('out;#3s;give ling pai to chuan fu;give ling pai 2 to chuan fu')
           check_busy(outSldWait,3)
        else
       exe('out;#3s;give ling pai to chuan fu')
       check_busy(outSldWait,3)
       end
    end)
end
function outSldWait()
    wait.make(function() 
       wait.time(6)
    locate()
    check_busy(outSldCheck)
    end)
end
function outSldCheck()
    if locl.room=="�ɿ�" then
       exe('#3n;enter')
       return outSld()
    else
	   --cntr1 = countR(20)
       return walk_wait()
    end
end
function outSldBoat()
    if cntr1() < 1 then
	   return go(road.act)
	end
    exe('order ����')
    locate()
    return check_halt(outSldBoatCheck)
end
function outSldBoatCheck()
    if locl.room=="��̲" then
       return outSldOver()
    else
       return checkWait(outSldBoat,3)
    end
end
function outSldOver()
    walk_wait()
end

function outHeiw()
    exe('repent')
    locate()
    check_bei(outHeiwCheck)
end
function outHeiwCheck()
    if locl.room~="����" then
       return outHeiwOver()
    end
    checkWait(outHeiw,15)
end
function outHeiwOver()
    walk_wait()
end

--[[function goXtj()
    DeleteTriggerGroup("goxtj")
    create_trigger_t('goxtj1',"^(> )*����\\s*\\-",'','goXtjShulin')
    create_trigger_t('goxtj2',"^(> )*ɽ·\\s*\\-",'','goXtjShanlu')
    SetTriggerOption("goxtj1","group","goxtj")
    SetTriggerOption("goxtj2","group","goxtj")
    EnableTriggerGroup("goxtj",false)

    exe('n')
    locate()
    check_halt(goXtjCheck)
end
function goXtjCheck()
    if locl.room~="����" then
       return goXtjOver11()
    end
    tmp.goxtj=0
    EnableTriggerGroup("goxtj",true)
    exe('l east;l south;l west;l north')
end
function goXtjShulin()
    if not tmp.goxtj then tmp.goxtj=0 end
    tmp.goxtj = tmp.goxtj + 1
    if tmp.goxtj>3 then
       EnableTriggerGroup("goxtj",false)
       checkWait(goXtjGo,1)
    end
end
function goXtjShanlu()
    EnableTriggerGroup("goxtj",false)
    if not tmp.goxtj then tmp.goxtj=0 end
    if tmp.goxtj==1 then
       exe('s')
    end
    exe('n')
    locate()
    checkWait(goXtjCheck,1)
end
function goXtjGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_halt(goXtjCheck)
end
function goXtjOver11()
	EnableTriggerGroup("goxtj",false)
    DeleteTriggerGroup("goxtj")
	if flag.find==1 then return end
    exe('n')
	checkWait(goXtjOver1,0.2)
end
function goXtjOver1()
	if flag.find==1 then return end
    exe('nu')
	checkWait(goXtjOver2,0.2)
end
function goXtjOver2()
	if flag.find==1 then return end
    exe('nu')
	checkWait(goXtjOver3,0.2)
end
function goXtjOver3()
	if flag.find==1 then return end
    exe('e')
	checkWait(goXtjOver4,0.2)
end
function goXtjOver4()
	if flag.find==1 then return end
    exe('w;nw')
	checkWait(goXtjOver,0.04)
end
function goXtjOver()
    EnableTriggerGroup("goxtj",false)
    DeleteTriggerGroup("goxtj")
    walk_wait()
end
function outXtj()
    DeleteTriggerGroup("outxtj")
    create_trigger_t('outxtj1',"^(> )*����\\s*\\-",'','outXtjShulin')
    create_trigger_t('outxtj2',"^(> )*ɽ·\\s*\\-",'','outXtjShanlu')
    SetTriggerOption("outxtj1","group","outxtj")
    SetTriggerOption("outxtj2","group","outxtj")
    EnableTriggerGroup("outxtj",false)

    exe('s')
    locate()
    check_halt(outXtjCheck)
end
function outXtjCheck()
    if locl.room~="����" then
       return outXtjOver()
    end
    
    tmp.outxtj=0
    EnableTriggerGroup("outxtj",true)
    exe('l east;l south;l west;l north')
end
function outXtjShulin()
    if not tmp.outxtj then tmp.outxtj=0 end
    tmp.outxtj = tmp.outxtj + 1
    if tmp.outxtj>3 then
       EnableTriggerGroup("outxtj",false)
       checkWait(outXtjGo,1.5)
    end
end
function outXtjShanlu()
    EnableTriggerGroup("outxtj",false)
    if not tmp.outxtj then tmp.outxtj=0 end
    if tmp.outxtj>1 then
       exe('n')	
    end
    exe('s')	
    locate()
    checkWait(outXtjCheck,1)
end
function outXtjGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_halt(outXtjCheck)
end
function outXtjOver()
    EnableTriggerGroup("outxtj",false)
    DeleteTriggerGroup("outxtj")
    walk_wait()
end]]
function goXtj()
   exe('n')
   if flag.find==1 then return end
   locate_finish='goxtjck'
   return fastLocate()
end
function goxtjck()
   locate_finish=0
   if flag.find==1 then return end
   wait.make(function() 
        wait.time(0.15)
   if locl.room_relation=='ɽ·������-----����-----���֣���������' or locl.room_relation=='ɽ·��ɽ·��ɽ·ɽ·' then
           return goXtjOver()
   end
   if locl.room_relation=='ɽ·��ɽ·�Kɽ��յ�ɽ·' then
       exe('n')
       return goXtj()
   end
   return goXtjGo()
   end)
end
function goXtjGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    --fastLocate()
    --check_halt(goXtjCheck)
        return goXtj()
end
function goXtjOver()
    EnableTriggerGroup("goxtj",false)
    DeleteTriggerGroup("goxtj")
    walk_wait()
end
function outXtj()
   exe('s')
   if flag.find==1 then return end
   locate_finish='outxtjck'
   return fastLocate()
end
function outxtjck()
   locate_finish=0
   if flag.find==1 then return end
   wait.make(function() 
        wait.time(0.1)
   if locl.room_relation=='ɽ·������-----����-----���֣���������' or locl.room_relation=='ɽ·��ɽ·��ɽ·ɽ·' then
           exe('s')
           return outXtj()
   end
   if locl.room_relation=='ɽ·��ɽ·�Kɽ��յ�ɽ·' or locl.room_relation=='���֣�����-----����-----���֣�ɽ·����' then
       exe('s')
       return outXtjOver()
   end
   return outXtjGo()
   end)
end
function outXtjGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
        return outXtj()
end
function outXtjOver()
    walk_wait()
end
-----------by fqyy 2017-05-24 ���޺�ɽ��
function xingxiushandong()
	DeleteTriggerGroup("xxsdAsk")
	create_trigger_t('xxsdAsk1',"^(> )*����ʨ���Ӵ����йء�fqyy������Ϣ",'','xxsdask')
    create_trigger_t('xxsdAsk2',"^(> )*����û������ˡ�$",'','xxsdover')
    create_trigger_t('xxsdAsk3',"^(> )*ʨ������־�Ժ�������һ�����ȣ����ڵ��ϻ��˹�ȥ��$",'','xxsdget')	
    create_trigger_t('xxsdAsk4',"^(> )*ʨ���ӡ�ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$",'','xxsdover') 
	create_trigger_t('xxsdAsk5',"^(> )*���빥��˭��$",'','xxsdover')
    create_trigger_t('xxsdAsk6',"^(> )*ʨ�����Ѿ��޷������ˣ�$",'','xxsdget')
	SetTriggerOption("xxsdAsk1","group","xxsdAsk")
    SetTriggerOption("xxsdAsk2","group","xxsdAsk")
	SetTriggerOption("xxsdAsk3","group","xxsdAsk")
	SetTriggerOption("xxsdAsk4","group","xxsdAsk")
	SetTriggerOption("xxsdAsk5","group","xxsdAsk")
	SetTriggerOption("xxsdAsk6","group","xxsdAsk")
	EnableTriggerGroup("xxsdAsk",true)
	exe("ask shihou zi about fqyy")
end
function xxsdask()
	exe("jiali max;hit shihou zi")
	create_timer_s('xxsdhit',3,'xxsdask1')
end
function xxsdask1()
	exe("jiali max;hit shihou zi")
end
function xxsdget()
	exe("get shihou zi;enter cave;drop shihou zi")
	inxxsd()
end
function xxsdover()
	exe("enter cave")
	inxxsd()
end
function inxxsd()
	DeleteTimer("xxsdhit")
	EnableTriggerGroup("xxsdAsk",false)
	DeleteTriggerGroup("xxsdAsk")
	return walk_wait()
end
--------------by fqyy 20170526�ƺ���������------------------
function inxiaofu()
	DeleteTriggerGroup("xiaofuask")
	create_trigger_t('xiaofuask1',"^(> )*�����η�������йء�fqyy������Ϣ",'','xiaofuask')
    create_trigger_t('xiaofuask2',"^(> )*����û������ˡ�$",'','xiaofuover')
    create_trigger_t('xiaofuask3',"^(> )*����һ�ְ���ץס��˵������һ����Ҳ��������$",'','xiaofugetchai')	
    create_trigger_t('xiaofuask4',"^(> )*�η��ࡸž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$",'','xiaofuover') 
	create_trigger_t('xiaofuask5',"^(> )*���빥��˭��$",'','xiaofuover')
    create_trigger_t('xiaofuask6',"^(> )*�η����Ѿ��޷������ˣ�$",'','xxsdget')
	SetTriggerOption("xiaofuask1","group","xiaofuask")
    SetTriggerOption("xiaofuask2","group","xiaofuask")
	SetTriggerOption("xiaofuask3","group","xiaofuask")
	SetTriggerOption("xiaofuask4","group","xiaofuask")
	SetTriggerOption("xiaofuask5","group","xiaofuask")
	SetTriggerOption("xiaofuask6","group","xiaofuask")
	EnableTriggerGroup("xiaofuask",true)
	exe("n")
	fastLocate()
	wait.make(function()
	   wait.time(1)
		return xiaofu_check()
	end)
end
function xiaofu_check()
	if locl.room == "��������" then
        DeleteTriggerGroup("xiaofuask")	
		check_busy(walk_wait)
	elseif locl.room == "��������" then	
		wait.make(function()
		   wait.time(1)
			return xiaofu_check()
		end)
	else
		go(road.act)
	end
end
function xiaofuask()
	check_busy(xiaofuask1)
end
function xiaofuask1()
	exe("jiali max;kill ren feiyan")
end
function xiaofuover()
	check_busy(xiaofuover1)
end
function xiaofuover1()
	exe("get chai from corpse;ne;nw;give zhang chai;n")
	DeleteTriggerGroup("xiaofuask")
	walk_wait()
end
function xiaofugetchai()
	exe("se;sw;ask ren feiyan about fqyy")
end
--------------by kkfromch 20190307���ָ�Ժ�뷿------------------
function inguifang()
	DeleteTriggerGroup("hanlinask")
	create_trigger_t('hanlinask1',"^(> )*��������˼�����йء��޷��硻����Ϣ",'','hanlinask')
    create_trigger_t('hanlinask2',"^(> )*����û������ˡ�$",'','hanlinover')
    --create_trigger_t('hanlinask3',"^(> )*����һ�ְ���ץס��˵������һ����Ҳ��������$",'','xiaofugetchai')	
    create_trigger_t('hanlinask4',"^(> )*����˼��ž����һ�����ڵ��ϣ������ų鶯�˼��¾����ˡ�$",'','hanlinover') 
	create_trigger_t('hanlinask5',"^(> )*���빥��˭��$",'','hanlinover')
    --create_trigger_t('hanlinask6',"^(> )*����˼�Ѿ��޷������ˣ�$",'','xxsdget')
	SetTriggerOption("hanlinask1","group","hanlinask")
    SetTriggerOption("hanlinask2","group","hanlinask")
	--SetTriggerOption("hanlinask3","group","hanlinask")
	SetTriggerOption("hanlinask4","group","hanlinask")
	SetTriggerOption("hanlinask5","group","hanlinask")
	--SetTriggerOption("hanlinask6","group","hanlinask")
	EnableTriggerGroup("hanlinask",true)
	fastLocate()
	wait.make(function()
	   wait.time(1)
		return hanlin_check()
	end)
end
function hanlin_check()
	if locl.room == "��Ժ" then	
		wait.make(function()
		   wait.time(1)
			return check_ling()
		end)
	else
		go(road.act)
	end
end
function hanlinask()
	check_busy(hanlinask1)
end
function hanlinask1()
	exe("jiali max;kill ling tuisi")
end
function hanlinover()
	check_busy(hanlinover1)
end
function hanlinover1()
	exe("kai men;n")
	DeleteTriggerGroup("hanlinask")
	walk_wait()
end
function check_ling()
	exe("ask ling tuisi about �޷���")
end
-----------ѩɽ �вƴ󳵵�---------------
function xsdachedian()
	DeleteTriggerGroup("xsdcd")
	create_trigger_t('xsdcd1',"^(> )*�͹��Ѿ��������ӣ���ô��ס��������أ����˻���ΪС���ź����أ�",'','xsdachedian1')
    create_trigger_t('xsdcd2',"^(> )*��һ��������",'','xsdachedian2')
    SetTriggerOption("xsdcd1","group","xsdcd")
	SetTriggerOption("xsdcd2","group","xsdcd")
	EnableTriggerGroup("xsdcd",true)
	EnableTrigger("hp27",false)
	exe("w")
	fastLocate()
    create_timer_st('xsdcdtimer',1,'xsdcd_check')
end
function xsdcd_check()
	if locl.room == "�ֵ�" then	
		DeleteTriggerGroup("xsdcd")
		walk_wait()
	else
		xsdachedian()
	end
end
function xsdachedian1()
	DeleteTimer("xsdcdtimer")
	exe("enter;sleep")
end
function xsdachedian2()
	DeleteTimer("xsdcdtimer")
	DeleteTriggerGroup("xsdcd")
	exe("out;w")
	walk_wait()
end
------------------------------------------------------------
function toThd()
    DeleteTriggerGroup("toThd")
    create_trigger_t('toThd1',"^(> )*��ԶԶ��ȥ�����������дУ�һ���̡�һ�ź졢һ�Żơ�һ���ϣ��˵��Ƿ����ƽ���",'','toThdOver')
    create_trigger_t('toThd2',"^(> )*��Ҫ��˭�����������",'','toThdOver')
    SetTriggerOption("toThd1","group","toThd")
    SetTriggerOption("toThd2","group","toThd")
	EnableTriggerGroup("toThd",true)
	exe('l rock;jump boat')
end
function toThdOver()
	locate()
	wait.make(function()
	   wait.time(1)
		return toThdCheck()
	end)
end
function toThdCheck()
	EnableTriggerGroup("toThd",false)
	if locl.room=="����" then
		walk_wait()
	else
		toThd()
	end
end
--����
function songlinIn()
    DeleteTriggerGroup("songlin")
    create_trigger_t('songlin1',"^(> )*������\\s*\\-",'','songlinInSonglin')
    create_trigger_t('songlin2',"^(> )*���ٲ�\\s*\\-",'','songlinInPubu')
	create_trigger_t('songlin3',"^(> )*��Ժ\\s*\\-",'','songlinInSonglin')
    SetTriggerOption("songlin1","group","songlin")
    SetTriggerOption("songlin2","group","songlin")
	SetTriggerOption("songlin3","group","songlin")
    EnableTriggerGroup("songlin",false)
	exe('n')
	cntrl = countR(100)
    locate()
    check_halt(songlinInCheck)
end
function songlinInCheck()
    if locl.room=="���ٲ�" then
       return songlinInOver()
    end
	if locl.room=="��Ժ" then
       exe('n')
    end
    tmp.songlin=0
    EnableTriggerGroup("songlin",true)
    exe('l east;l south;l west;l north')
end
function songlinInSonglin()
    if not tmp.songlin then tmp.songlin=0 end
    tmp.songlin = tmp.songlin + 1
    if tmp.songlin>3 then
       EnableTriggerGroup("songlin",false)
       checkWait(songlinInGo,1)
    end
end
function songlinInPubu()
    EnableTriggerGroup("songlin",false)
    exe('e')
    locate()
    checkWait(songlinInCheck,1)
end
function songlinInGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_halt(songlinInCheck)
end
function songlinInOver()
    EnableTriggerGroup("songlin",false)
    --DeleteTriggerGroup("songlin")
    walk_wait()
end
function songlinOut()
    DeleteTriggerGroup("songlin")
    create_trigger_t('songlin1',"^(> )*������\\s*\\-",'','songlinOutSonglin')
    create_trigger_t('songlin2',"^(> )*���ٲ�\\s*\\-",'','songlinOutPubu')
	create_trigger_t('songlin3',"^(> )*��Ժ\\s*\\-",'','songlinOutHouyuan')
    SetTriggerOption("songlin1","group","songlin")
    SetTriggerOption("songlin2","group","songlin")
	SetTriggerOption("songlin3","group","songlin")
    EnableTriggerGroup("songlin",false)
	exe('n')
    locate()
    check_halt(songlinOutCheck)
end
function songlinOutCheck()
    if locl.room=="���ٲ�" then
	   exe('w;s')
       return songlinOutOver()
    end
	if locl.room=="��Ժ" then
       return songlinOutOver()
    end

    tmp.songlin=0
    EnableTriggerGroup("songlin",true)
    exe('l east;l south;l west;l north')
end
function songlinOutSonglin()
    if not tmp.songlin then tmp.songlin=0 end
    tmp.songlin = tmp.songlin + 1
    if tmp.songlin>2 then
       EnableTriggerGroup("songlin",false)
       checkWait(songlinOutGo,1)
    end
end
function songlinOutPubu()
    EnableTriggerGroup("songlin",false)
    exe('e')
    locate()
    checkWait(songlinOutCheck,1)
end
function songlinOutHouyuan()
    EnableTriggerGroup("songlin",false)
	exe('s')
    return songlinOutOver()
end
function songlinOutGo()
    local l_set={'e','s','w','n'}
    local l_cnt=math.random(1,table.getn(l_set))
    exe(l_set[l_cnt])
    locate()
    check_halt(songlinOutCheck)
end
function songlinOutOver()
    EnableTriggerGroup("songlin",false)
    DeleteTriggerGroup("songlin")
    walk_wait()
end

function xsMianbi()
    if hp.shen>0 then
	   return xsMianbiOver()
	else
	   exe('#20(mianbi);hp')
	   return check_halt(xsMianbiChk,1)
	end
end
function xsMianbiChk()
    if hp.shen>0 then
	   return xsMianbiOver()
	else
	   exe('#20(mianbi);hp')
	   return check_halt(xsMianbi,1)
	end
end
function xsMianbiOver()
    return walk_wait()
end

function mlIn()
    tmp.way = "south"
	tmp.ml = "in"
	locate()
	return checkWait(wayMl,0.1)
end
function mlOut()
    tmp.way = "north"
	tmp.ml = "out"
	locate()
	return checkWait(wayMl,0.1)
end
function wayMl()
    local ways = {
		["north"] = "east",
		["east"]  = "south",
		["south"] = "west",
		["west"]  = "north",
	}
	local wayt = {
		["north"] = "west",
		["east"]  = "north",
		["south"] = "east",
		["west"]  = "south",
	}
	if not tmp.way or not ways[tmp.way]then
	   tmp.way = 'south'
	end
	if locl.room=="��ʯ���·" then
	   if tmp.ml and tmp.ml=="in" then
	      return wayMlOver()
	   else
	      tmp.way = "north"
	      exe(tmp.way)
		  locate()
	      return checkWait(wayMl,0.1)
	   end 
    end
    if locl.room=="С·" then
	   if tmp.ml and tmp.ml=="out" then
	      return wayMlOver()
	   else
	      tmp.way = "south"
	      exe('south;south')
		  locate()
	      return checkWait(wayMl,0.1)
	   end 
    end
    if locl.room~="С·" and locl.room~="��ʯ���·" and locl.room~="÷��" then
       return wayMlOver()
    end	
	tmp.way = ways[tmp.way]
	while not locl.exit[tmp.way] do
	    Note(tmp.way)
	    tmp.way = wayt[tmp.way]
	end
	exe(tmp.way)
	locate()
	return checkWait(wayMl,0.2)
end
function wayMlOver()
    return walk_wait()
end

function mzDoor()
    create_trigger_f('xxdf',"^(> )*���˰��Σ����Ż����򿪣������߳���������װ��������",'','mzDoorHuida')
	wait.make(function()
         exe('qiao gate 4 times')
		 wait.time(3)
	     exe('qiao gate 2 times')
		 wait.time(3)
	     exe('qiao gate 5 times')
		 wait.time(3)
	     exe('qiao gate 3 times')
	end)
end
function mzDoorHuida()
    exe('huida �����������;show wuyue lingqi;s')
	return check_halt(mzDoorOver)
end
function mzDoorOver()
    return walk_wait()
end

---------
-- ain ������·��
---------------
ht2ss=function()
   DeleteTriggerGroup("gmout1")
 --  create_trigger_t('gmout1','^>*\\s*�����ű�����ô�ƶ�С�ۣ�','','jqgout_weapon')
   create_trigger_t('jqgout2','^>*\\s*�Ҷ�ʯ������������������','','gmss_outss')
   SetTriggerOption("gmout1","group","gmout")
   SetTriggerOption("jqgout2","group","gmout")
   ht2ssgo()
end
ht2ssgo=function()
   exe('tang bed;ban shiban;out')
end
gmss_outss=function()
   DeleteTriggerGroup("gmout")
   create_trigger_t('gmout1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','gmss_outssok')
   SetTriggerOption("gmout1","group","gmout")
   exe('e;e;e;e;e;s;s;s;s;s;w;w;w;w;w;n;n;n;n;n')
   --locate()
   --check_bei(jqgzlin_con)
end

gmss_outssok=function()
   DeleteTriggerGroup("gmout")
   create_trigger_t('gmout1','^>*\\s*��� "action" �趨Ϊ "�뿪��������" �ɹ���ɡ�','','gmss_outssok')
   SetTriggerOption("gmout1","group","gmout")
   exe('e;e;e;e;e;s;s;s;s;s;w;w;w;w;w;n;n;n;n;n')
   --locate()
   --check_bei(jqgzlin_con)
end
---------------


-----------

function yuRen()
	DeleteTriggerGroup("yrAsk")
    create_trigger_t('yrAsk1',"^(> )*�������˴����йء�һ�ƴ�ʦ������Ϣ",'','yuRenAsk')
    create_trigger_t('yrAsk2',"^(> )*����û������ˡ�$",'','yuRenOver')
    SetTriggerOption("yrAsk1","group","yrAsk")
    SetTriggerOption("yrAsk2","group","yrAsk")
	checkWield()
	return exe('ask yu ren about һ�ƴ�ʦ')
end
function yuRenAsk()
    EnableTriggerGroup("yrAsk",false)
	DeleteTriggerGroup("yren")
	create_trigger_t('yren1',"^(> )*����(����|)˵����(��|)�Ҳ����Ѿ���������ɽ�ķ�����ô��",'','yuRenBag')
	create_trigger_t('yren2','^(> )*����(����|)˵����(��|)������ȥ�ҵĽ������أ�','','yuRenWaa')
	create_trigger_t('yren3',"^(> )*����(����|)˵����(��|)Ҫ����ʦ����Ҳ���ѣ������Ҹն�ʧ������������",'','yuRenWaa')
	SetTriggerOption("yren1","group","yren")
    SetTriggerOption("yren2","group","yren")
	SetTriggerOption("yren3","group","yren")
end
function yuRenWaa()
    DeleteTimer("ydzy")
    EnableTriggerGroup("yren",false)
	EnableTriggerGroup("yrj",false)
	EnableTriggerGroup("yrz",false)
	cntr1 = countR(20)
	return check_halt(yuRenJump)
end
function yuRenJump()
        EnableTriggerGroup("yren",false)
	EnableTriggerGroup("yrz",false)
	DeleteTriggerGroup("yrj")
	create_trigger_t('yrj1',"^(> )*�ٲ����Ѿ������ˣ�������ȥ̫Σ���ˡ�",'','yuRenWait')
	create_trigger_t('yrj2','^(> )*�㵱��һ�ﲻ����Ҳ�����¿�Ь�࣬ӿ�������ٲ������䡣','','yuRenZhua')
	create_trigger_t('yrj3',"^(> )*����æ���ء�",'','yuRenWaa')
        create_trigger_t('yrj4','^(> )*���ٲ����ڶ�ȥ��ˮĭ�Ľ���ֻ��\\D*����վ��ˮ�ף�һ���ٲ�����ͻ������Ӿ�δҡ�Ρ�','','yuRenWait')
	SetTriggerOption("yrj1","group","yrj")
        SetTriggerOption("yrj2","group","yrj")
	SetTriggerOption("yrj3","group","yrj")
	SetTriggerOption("yrj4","group","yrj")
	weapon_unwield()
	exe('look pubu')
	exe('jump pubu')
end
function yuRenWait()
    EnableTriggerGroup("yrj",false)
    if cntr1() < 1 then
	   return yuRenOver()
	end
	return checkWait(yuRenJump,3)
end
function yuRenZhua()
	EnableTriggerGroup("yrj",false)
	DeleteTriggerGroup("yrj")
        DeleteTriggerGroup("yrz")
	create_trigger_t('yrz1',"^(> )*�㲻���Ѿ�ץ����������ô��",'','yuRenCheck')
	create_trigger_t('yrz2','^(> )*����\\D*��ץ������ô��','','yuRenUw')
	--create_trigger_t('yrz3',"^(> )*����æ���ء�",'','yuRenZhuaYu')
	--create_trigger_t('yrz4','^(> )*����������ȥ׽�ǶԽ����ޣ�һ��һ��','','yuRenZhuaYu')
	create_trigger_t('yrz5',"^(> )*�����ֵ����������Ǵ�ʯ��������һ̧",'','yuRenCheck')
	create_trigger_t('yrz6',"^(> )*��ʵ��֧�Ų���ȥ�ˣ������������ٲ����ߡ�",'','yuRenWaa')
	create_trigger_t('yrz7',"^(> )*���������Ź��㣬ֻ��һ�����ֱ�������ȥ��������ˮ����������������һ��",'','yuRenBag')
	
	SetTriggerOption("yrz1","group","yrz")
        SetTriggerOption("yrz2","group","yrz")
	--SetTriggerOption("yrz3","group","yrz")
	--SetTriggerOption("yrz4","group","yrz")
	SetTriggerOption("yrz5","group","yrz")
	SetTriggerOption("yrz6","group","yrz")
	SetTriggerOption("yrz7","group","yrz")
	return yuRenZhuaYu()
end
function yuRenUw()
    DeleteTimer("ydzy")
    weapon_unwield()
	return check_halt(yuRenZhuaYu)
end
function yuRenZhuaYu()
    EnableTriggerGroup("yrz",true)
    create_timer_s('ydzy',3,'yrzhuayu')
end
function yrzhuayu()
    exe('zhua yu')
end
function yuRenCheck()
    DeleteTimer("ydzy")
    checkBags()
	create_timer_s('ydzy',1,'jumpab')
end
function jumpab()
    exe('jump anbian')
end
function yuRenBag()
    DeleteTimer("ydzy")
	if not Bag["������"] then
	   return check_bei(yuRenAsk)
	end
	EnableTriggerGroup("yrz",false)
	exe('give jin wawa to yu ren')
	return checkWait(yuRenGive,4)
end
function yuRenGive()
	DeleteTriggerGroup("yrp")
	create_trigger_t('yrp1',"^(> )*�ٲ���ˮ�������ļ��������Ѿ����������ں����ˣ��㻹���ȵȻ�ɡ�",'','yuRenPao')
	create_trigger_t('yrp2','^(> )*��ת��ɽ�ǣ���һ�������𣡡����������ٲ�������','','yuRenHua')
	create_trigger_t('yrp3',"^(> )*����æ���ء�",'','yuRenPao')
	SetTriggerOption("yrp1","group","yrp")
    SetTriggerOption("yrp2","group","yrp")
	SetTriggerOption("yrp3","group","yrp")
	return yuRenPao()
end
function yuRenPao()
    wait.make(function() 
       wait.time(1)
	   exe('zhi boat')
	end)
end
function yuRenHua()
    EnableTriggerGroup("yrp",false)
	DeleteTriggerGroup("yrh")
	--create_trigger_t('yrh1',"^(> )*(�����У�|�����ڻ��أ�|������������æ�ӳ�)",'','yuRenBoat')
	create_trigger_t('yrh2','^(> )*���Ѿ��������ˣ���취�ϰ��ɣ�','','yuRenTiao')
	--create_trigger_t('yrh3',"^(> )*����æ���ء�",'','yuRenBoat')
	create_trigger_t('yrh4',"^(> )*ͻȻ��һ�ɴ����嵽",'','yuRenOver')
	--SetTriggerOption("yrh1","group","yrh")
        SetTriggerOption("yrh2","group","yrh")
	--SetTriggerOption("yrh3","group","yrh")
	SetTriggerOption("yrh4","group","yrh")
	return yuRenBoat()
end
function yuRenBoat()
    weapon_unwield()
    EnableTriggerGroup("yrh",true)
    create_timer_s('yrb',3,'huaboat')
end
function huaboat()
	   exe('wield tie jiang')
	   exe('hua boat')
end
function yuRenTiao()
    DeleteTimer("yrb")
    EnableTriggerGroup("yrh",false)
	exe('jump shandong')
	return check_busy(yuRenOver)
end
function yuRenOver()
    DeleteTimer("yrb")
	   exe('unwield tie jiang')
    EnableTriggerGroup("yrh",false)
	DeleteTriggerGroup("yrh")
	DeleteTriggerGroup("yrp")
	DeleteTriggerGroup("yrz")
	DeleteTriggerGroup("yrj")
	DeleteTriggerGroup("yren")
	DeleteTriggerGroup("yrAsk")
	return walk_wait()
end

function jiaoZi()
    locate()
	return checkNext(jiaoZiLoc)
end
function jiaoZiLoc()
    if locl.room ~= "����" then
	   return jiaoZiOver()
	end
    if not locl.id["����"] then
	   return jiaoZiWait()
	end
    wait.make(function() 
       wait.time(2)
	   return jiaoZiAnswer()
	end)
end
function jiaoZiWait()
    wait.make(function() 
       wait.time(2)
	   return jiaoZi()
	end)
end
function jiaoZiAnswer()
    EnableTriggerGroup("jiao",false)
	exe('answer ��ɽ����������మ���β��������۹��ƽ����һéի��Ұ����������˭���˷�˭�ɰܣ�ª�ﵥư�����ա�ƶ�������ģ��־���ģ�')
	exe('pa teng')
	return jiaoZiOver()
end
function jiaoZiOver()
    DeleteTriggerGroup("jiao")
    return walk_wait()
end 

function duZi()
    locate()
	return checkNext(duZiLoc)
end
function duZiLoc()
    if locl.room ~= "ʯ����ͷ" then
	   return duZiOver()
	end
    if not locl.id["����"] then
	   return duZiWait()
	end
	DeleteTriggerGroup("du")
	create_trigger_t('du1',"^(> )*����(����|)˵����(��|)�ҳ�������Ŀ�����㣬",'','duZiQuestion')
	create_trigger_t('du2',"^(> )*����(����|)˵����(��|)������һ��ʫ��˵�������³������������ĸ��ֶ�",'','duZiAnswer')
	create_trigger_t('du3',"^(> )*����(����|)˵����(��|)�úã���Ȼ��������һ�⣬����һ������",'','duZiAnswerTwo')
	create_trigger_t('du4',"^(> )*����(����|)˵����(��|)�һ���һ������",'','duZiAnswerThree')
        create_trigger_t('du5',"^(> )*����(����|)˵����(��|)��ɻش�ĳ��ҵ����⣿",'','duZiAnswerAll')
        create_trigger_t('du6',"^(> )*����(����|)˵����(��|)��λ\\D*����ʦ������ǰ�治Զ����ʯ���",'','duZiOver')
	SetTriggerOption("du1","group","du")
	SetTriggerOption("du2","group","du")
	SetTriggerOption("du3","group","du")
	SetTriggerOption("du4","group","du")
	SetTriggerOption("du5","group","du")
	SetTriggerOption("du6","group","du")
	return check_halt(duZiAsk)
end
function duZiAsk()
    exe('ask shu sheng about һ�ƴ�ʦ')
end
function duZiQuestion()
    wait.make(function() 
       wait.time(4)
	   exe('ask shu sheng about ��Ŀ')
	end)
end
function duZiWait()
    wait.make(function() 
       wait.time(2)
	   return duZi()
	end)
end
function duZiAnswerAll()


    wait.make(function()
 

       wait.time(3)


     exe('answer ��δ״Ԫ')


     exe('answer ˪���Ҷ�����Ź�����ң��')


     exe('answer �������ˣ���С�����Զǳ�')


     exe('north')


  end)


end
function duZiAnswer()
    wait.make(function() 
       wait.time(4)
	   exe('answer ��δ״Ԫ')
	end)
end
function duZiAnswerTwo()
    exe('answer ˪���Ҷ�����Ź�����ң��')
end
function duZiAnswerThree()
    exe('answer �������ˣ���С�����Զǳ�')
	exe('north')
	return duZiOver()
end
function duZiOver()
    EnableTriggerGroup("du",false)
    return walk_wait()
end 

function nongFu() 
    locate()
	return checkNext(nongFuLoc)
end
function nongFuLoc()
    if locl.room ~= "ɽ��" then
	   return nongFuOver()
	end
    if not locl.id["ũ��"] then
	   return nongFuWait()
	end
	DeleteTriggerGroup("nong")
	create_trigger_t('nong1',"^(> )*(�Ѿ����������ˡ�|ũ���ڣ���ô���ʯ����һ�����޷�����)",'','nongFuTuo')
	create_trigger_t('nong2','^(> )*���Ѿ���ũ������ʯ���ˣ��������뿪��','','nongFuLeave')
	create_trigger_t('nong3',"^(> )*����æ���ء�",'','nongFuTuo')
	create_trigger_t('nong4',"^(> )*ũ��˫����ס��ʯ�������˾���ͦ���ʯ������˵��",'','nongFuLeave')
	SetTriggerOption("nong1","group","nong")
    SetTriggerOption("nong2","group","nong")
	SetTriggerOption("nong3","group","nong")
	SetTriggerOption("nong4","group","nong")
	return nongFuTuo()
end
function nongFuTuo()
    EnableTriggerGroup("nong",true)
	wait.make(function() 
       wait.time(2)
	   exe('tuo shi')
	end)
end
function nongFuWait()
    wait.make(function() 
       wait.time(2)
	   return nongFu()
	end)
end
function nongFuLeave()
    EnableTriggerGroup("nong",false)
    wait.make(function() 
       wait.time(3)
	exe('east')
	return nongFuOver()
	end)
end
function nongFuOver()
    DeleteTriggerGroup("nong")
    return walk_wait()
end 

function liangFront()
    if hp.neili < 6000 then
	   return prepare_neili(liangFrontJump)
	end 
	return liangFrontJump()
end
function liangFrontJump()
    exe('jump front;hp')
	return check_halt(liangFrontOver,1)
end
function liangFrontOver()
    return walk_wait()
end 

function liangBack()
    if hp.neili < 2000 then
	   return prepare_neili(liangBackJump)
	end 
	return liangBackJump()
end
function liangBackJump()
    exe('jump back;hp')
	return check_halt(liangBackOver,1)
end
function liangBackOver()
    return walk_wait()
end 



 
room={}
roomMaze={
['���ԭ�ݺ�']=function() return locl.dir end,
['����ɽ��ʮ����']='ne;nd',
['����ɽ���϶�']=function() if locl.exit["enter"] then return 'enter' else return 'drop fire;leave;leave;leave;leave' end end,
['����ɽ��ɼ��']='sw;se',
['����ɽʮ����']='ne;ed;ne;ed',
['����ɽ������']='ed;ed',
['����ɽ�����']='out;w;e;w;e;w;e;w;e',
['����ɽ��ɼ��']=function()
 wait.make(function()
       wait.time(1)
                  local r=math.random(6)
                    if r==1 then
                    exe("e;n;w;nw;ne")
                    elseif r==2 then
                    exe("n;w;nw;ne")
                    elseif r==3 then
                    exe("w;nw;ne")
                    elseif r==4 then
                    exe("nw;ne")
                    elseif r==5 then
                    exe("e;ne")
                    elseif r==6 then
                    exe("ne")
                    end
    end)
end,
['��ɽ���ּ��']='#2e;nw;ne;se;n',
['���ݳ�����']='#3n',
['�ؽ���Ҷ��']=function() if math.random(1,4)==1 then return 'ne;#15e' elseif math.random(1,4)==2 then return 'ne;#15w' elseif math.random(1,4)==3 then return 'ne;#15s' else return 'ne;#15n' end end,
['��ɽ������']='n;e;e',
['�ƺ�����ƺӰ���']='nu;#2(sw);#2w',
['�ƺ���������']='e;ne;#2n',
['�ƺ�����ݵ�']='e;s',
['�ƺ��������']='#2e;ne;n',
['ؤ��������']='e;n;w;n',
['����ׯ�����']='s;se;w;#2s;w;s',
['����ׯ����']='#2e;w;#2s',
['����ׯ�ݵ�']='#2e;w;s',
['����Ľ��������']='e;n;w;n;yue tree',
['������С��']='s;e;e;e;e;e;e;e;e',
['�����볤��']='s;s;e;e;e;e;e;e;e;e;e;e;n;e;s',
['����Сɳ��']='#4e',
['����ջ��']='#2(sw);#2(se);s',
['����ɽ·']='ed;wd;sd;nd',
['���������']=function() if locl.id["�ϻ�"] then return 'halt;n;w;nu' elseif locl.id["С��֦"] then return 'halt;w;nw;n;w;nu' elseif locl.id["����ʬ��"] then return 'halt;nw;n;w;nu' elseif locl.id["������"] then return 'halt;w;n;w;nu' else return locl.dir end end,
['��������']=function() if locl.id["��ʯͷ"] then return 'halt;e;nu' elseif locl.id["������"] then return 'halt;w;nu' else return locl.dir end end,
['������Сľ��'] = function() return toSldHua() end,
['������ɳ̲']='sw;se',
['����������']='sw;se;s',
['����������']='#2e;n',
['������ɽ��']='d;wd;su;sd;wd',
['������ɽ·']='s;sd;d;wd;su',
['��ɽ��������']=function()
 wait.make(function()
       wait.time(1)
                  local r=math.random(14)
                    if r==1 then
                    exe("sd;s")
                    elseif r==2 then
                    exe("sw;n;s;w;e;w;e;e;s;w;n;nw;n")
                    elseif r==3 then
                    exe("n;s;w;e;w;e;e;s;w;n;nw;n")
                    elseif r==4 then
                    exe("s;w;e;w;e;e;s;w;n;nw;n")
                    elseif r==5 then
                    exe("w;e;w;e;e;s;w;n;nw;n")
                    elseif r==6 then
                    exe("e;w;e;e;s;w;n;nw;n")
                    elseif r==7 then
                    exe("w;e;e;s;w;n;nw;n")
                    elseif r==8 then
                    exe("e;e;s;w;n;nw;n")
                    elseif r==9 then
                    exe("e;s;w;n;nw;n")
                    elseif r==10 then
                    exe("s;w;n;nw;n")
                    elseif r==11 then
                    exe("w;n;nw;n")
                    elseif r==12 then
                    exe("n;nw;n")
                    elseif r==13 then
                    exe("nw;n")
                    elseif r==14 then
                    exe("n")
                    end
    end)
end,
['��ɽ��������']='n;n;s;e',
['��ɽ���ֲ�԰��']='s;w;n;n;n;nw;n;n;w;w;w',
['��ɽ���ֻ���']='n;w;n',
['��ɽ�������䳡']='s;s;n;e',
['��ɽ������ɮ��']='n;n;n;e',
['��ɽ����ʯ��']='sd;sd;sd;ed;sd;e',
-- ain
['��ɽ��������']=function()
 wait.make(function()
       wait.time(1)
                  local r=math.random(11)
                    if r==1 then
                    exe("ne;se;n;e;sw;e;ne;se;s;se;open door;e")
                    elseif r==2 then
                    exe("se;n;e;sw;e;ne;se;s;se;open door;e")
                    elseif r==3 then
                    exe("n;e;sw;e;ne;se;s;se;open door;e")
                    elseif r==4 then
                    exe("e;sw;e;ne;se;s;se;open door;e")
                    elseif r==5 then
                    exe("sw;e;ne;se;s;se;open door;e")
                    elseif r==6 then
                    exe("e;ne;se;s;se;open door;e")
                    elseif r==7 then
                    exe("ne;se;s;se;open door;e")
                    elseif r==8 then
                    exe("se;s;se;open door;e")
                    elseif r==9 then
                    exe("s;se;open door;e")
                    elseif r==10 then
                    exe("se;open door;e")
                    elseif r==11 then
                    exe("open door;e")
                    end
    end)
end,
['��ɽ����������']='w;n;nw',
['��ɽ����ɮ��']=function() if locl.id["�ۺ�����"] then return 'w;s;e' elseif locl.id["��������"] then return 'e;s;w' else return locl.dir end end,
['������������']='s;w;s;w;#8s',
['�䵱ɽ����·']='e;e',
['�䵱ɽС��']='#5n',
['����ɽ������']='n;e;n;w;n',
['������ɽ��С·']='ne;nd;se;se;#2s;n;e',
['��Դ��ʯ��']='jump front',
['���޺����޺�']='se;#7n',
['���޺���ɳĮ']='#8w',
['���ݳǳ�������']='w;w;e;n',
['���ݳǳ����ϰ�']='w;w;e;s;se;s',
['��٢��ɽׯ������']='south;#3w;#2e;#3s',
['������������']=function() return outXtj() end,
}

roomNodir={
['�����ʹ�����']={'north'},
['���ݳ����']={'northeast'},
['��������·']={'east','west'},
['���ݳ�ɽ·']={'east','west'},
['���ݳ�С��']={'southwest'},
['�ƺ���������']={'southwest'},
['��ɽ�������']={'northwest','northeast'},
['��ɽ�յ�']={'southdown'},
['��ɽɽ����']={'south'},
['�����ɽ��ƽ��']={'northdown'},
['���ݳ����ׯ�ſ�']={'west'},
['����ɽ���پ�']={'west'},
['����ɽ������']={'southwest'},
['����ɽ��Ժ��']={'east'},
['����ɽ��Ժ']={'south'},
['÷ׯС·']={'south'},
['���̻���ƺ']={'south','east'},
['���̾�ľ��']={'west','east'},
['�����һ���']={'west'},
['���̺�ˮ��']={'east'},
['���������']={'east'},
['���̺�����']={'east','west'},
['���̾�����']={'west'},
['�置ɽ��']={'northup','northwest'},
['�������ֽ��Ժ']={'south'},

['��ɽ����������']={'west'},
['��ɽ��������Ժ']={'west'},
['��ɽ����ɽ·']={'east','northwest'},

['��ɽ�޵�']={'north'},
['���ݳǺ�Ժ']={'north'},
['�䵱ɽС��']={'south','west','east'},
['����ɽ������']={'north','west'},
['����ɽ��Ժ']={'north'},

['���޺��¹Ȼ��ٹ��']={'south'},
['���޺���ɽ����']={'southwest'},
['���޺����޺�']={'south','north','east'},
['���޺����¶���']={'west','east'},
['���޺����¶�']={'north'},
['���޺�С·']={'south','west'},
['���޺����߻�·']={'south','north','east'},

}

MidNight={
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['��']=false,
['î']=false,
['��']=false,
['��']=false,
['��']=false,
['δ']=false,
['��']=true,
}

MidDay={
['��']=false,
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['î']=false,
['��']=false,
['��']=false,
['��']=false,
['δ']=false,
['��']=false,
}

MidHsDay={
['��']=false,
['��']=false,
['��']=false,
['��']=true,
['��']=true,
['��']=true,
['��']=true,
['î']=true,
['��']=false,
['��']=false,
['��']=false,
['δ']=false,
}

function del_element(set,element)
    for i=1,table.getn(element) do
        set=delElement(set,element[i])
    end
    return set
end

function del_string(string,sub)
    local l_s,l_e
    for i=1,string.len(string) do
        l_s,l_e=string.find(string,sub)
	if l_s==nil then break end
	string=string.sub(string,1,l_s-1)..string.sub(string,l_e+1,string.len(string))
    end
    return string
end

function addrTrim(addr)
    addr=del_string(addr,'����')
    addr=string.gsub(addr,'С��','��ɽ��',1)
    addr=string.gsub(addr,'����������','������',1)
    addr=string.gsub(addr,'Ľ��','����Ľ��',1)
	--addr=string.gsub(addr,'����Ϫ��','������Ϫ��',1)
    return addr
end

goto_set={}
goto_set.lzdk=function()
    return goto('���ݳǴ�ɿ�')
end
goto_set.xy=function()
    return goto('�����ǵ���')
end
goto_set.sl=function()
    return goto('��ɽ���ִ��۱���')
end
goto_set.xs=function()
    return goto('��ѩɽ���Ŀ�')
end
goto_set.hs=function()
    return goto('��ɽ������')
end
goto_set.yz=function()
    return goto('���ݳǵ���')
end
goto_set.wd=function()
    return goto('�䵱ɽ�����')
end
goto_set.thd=function()
    return goto('�һ�������ͤ')
end
goto_set.dl=function()
    return goto('������ҩ��')
end

wxbGo=function()
    dis_all()
    return go(wxbAsk,"���ݳ�","����Ժ")
end
wxbAsk=function()
    create_trigger_f('wxbask',"^Τ����˵��������λ׳ʿ��������˵�����ǹԶ�������(\\D*)�������ء���",'','wxbGoto')
    Execute('ask wei chunfang about wei xiaobao')
end
wxbGoto=function(n,l,w)
    DeleteTemporaryTriggers()
    return goto(w[1])
end

function thdJiaohui()
    road.id=nil
	dis_all()
	return go(thdJiaohuiAsk,"�һ���","����ͤ")
end
function thdJiaohuiAsk()
    exe('ask huang yaoshi about �̻�')
	return check_heal()
end

function searchNpc(city,npc)
    if city then
       tmp.rooms = getCityRooms(city)
	end
	if npc then
	   tmp.npc = npc
	end
	tmp.rooms = tmp.rooms or {}
	tmp.sour = tmp.sour or "city/dangpu"
	while countTab(tmp.rooms) > 0 do
	      local l_sour = "city/dangpu"
	      if tmp.sour ~= "city/dangpu" then
		     l_sour = tmp.sour
		  end
	      local l_dest,l_distance=getNearRoom(l_sour,tmp.rooms)
		  if l_dest then
		     tmp.rooms = delElement(tmp.rooms,l_dest)
			 local l_path=map:getPath(l_sour,l_dest)
			 if l_path then
			    tmp.sour = l_dest
		        return go(searchNpcLocate,l_dest,'',l_sour)
		     end
		  else
		     tmp.rooms = {}
		  end
    end	
	ColourNote ("white","blue","Object������ϣ�")
	printTab(tmp.objs)
end
function searchNpcLocate()
    locate()
	return check_halt(searchNpcAdd,1)
end
function searchNpcAdd()
    tmp.objs = tmp.objs or {}
    for p,q in pairs(locl.id) do
	    Note(p .." = "..q)
		if tmp.npc and p == tmp.npc then
		   exe('follow '.. q)
		   return disAll()
		end
	    if ItemGet[p] or weaponStore[p] or weaponThrowing[p] or drugBuy[p] or drugPoison[p] or itemSave[p] then
		   locl.id[p] = nil
		end
		if string.find(p,"�ڳ�") or string.find(p,"����") or string.find(p,"��ƪ") or string.find(p,"��Ҫ") or string.find(p,"�佫") or string.find(p,"�ٱ�") or string.find(p,"���ϵ�") or string.find(p,"����") or string.find(p,"��ʦ") or string.find(p,"����") or string.find(p,"����") or string.find(p,"�趨��������") or string.find(p,"��ʬ") or string.find(p,"Ůʬ") or string.find(p,"ʬ��") or string.find(p,"�ϵ���") or string.find(p,"�����") or string.find(p,"�׼�") or string.find(p,"����") or string.find(p,"����") then
		   locl.id[p] = nil
		end
		if p == score.name or MudUser[p] then
		   locl.id[p] = nil
		end
		if locl.item[p]["cloth"] or locl.item[p]["shoes"] or locl.item[p]["shoe"] or locl.item[p]["blade"] or locl.item[p]["sword"] then
		   locl.id[p] = nil
		end
		if map.rooms[tmp.sour] and map.rooms[tmp.sour].objs and type(map.rooms[tmp.sour].objs)=="table" then
		   for k in pairs(map.rooms[tmp.sour].objs) do
		       if p == k then
			      locl.id[p] = nil
			   end
		   end
		end
	end
    if countTab(locl.id) > 0 then
	   for p,q in pairs(locl.id) do
		   tmp.objs[tmp.sour] = tmp.objs[tmp.sour] or {}
		   tmp.objs[tmp.sour].objs = tmp.objs[tmp.sour].objs or {}
		   ColourNote ("white","blue",p.." = "..q)
		   tmp.objs[tmp.sour].objs[p] = q
	   end
	end
    return searchNpc()
end

function locateroom(where)
   local l_dest={}
   where = Trim(where)
   if string.find(where,"/") then
      local l_path=map:getPath("xiangyang/dangpu",where)
      if l_path then
         return where
	  end
   else
      l_dest.room,l_dest.area=getAddr(Trim(where))
   end
   if l_dest.area then
      local l_rooms=getRooms(l_dest.room,l_dest.area)
	  for k,v in pairs(l_rooms) do
	      local l_path=map:getPath("xiangyang/dangpu",v)
          if l_path then
             return l_dest.area,l_dest.room
		  end
	  end
   end
   
   for p in pairs(map.rooms) do
       if map.rooms[p].objs then
	      for k in pairs(map.rooms[p].objs) do
		      if k == where then
			     local l_path=map:getPath("xiangyang/dangpu",p)
                 if l_path then
			        return p
			     end
			  end
		  end
	   end
   end
   return false
end

dirReverse = {
   ["up"] = "down",
   ["down"] = "up",
   ["east"] = "west",
   ["west"] = "east",
   ["eastup"] = "westdown",
   ["westup"] = "eastdown",
   ["eastdown"] = "westup",
   ["westdown"] = "eastup",
   ["south"] = "north",
   ["north"] = "south",
   ["southup"] = "northdown",
   ["northup"] = "southdown",
   ["southdown"] = "northup",
   ["northdown"] = "southup",
   ["southeast"] = "northwest",
   ["southwest"] = "northeast",
   ["northeast"] = "southwest",
   ["northwest"] = "southeast",
   ["enter"] = "out",
   ["out"] = "enter",
}
function mjlujingLog(jname)
    local filename = GetInfo (67) .. "lujing\\" .. score.id .. '����'..jname..'·��'..os.date("%Y%m%d_%Hʱ%M��%S��") .. ".log"
   
    local file = io.open(filename,"w")
   
    local t = {}
   
    for i = 1,GetLinesInBufferCount() do
        table.insert(t,GetLineInfo(i,1))
    end
   
    local s = table.concat(t,"\n") .. "\n"
	
	file:write(s)
   
    file:close()
end
function djdh_open()                                                                             --���´򿪱���յĶɽ��ɺ�·��
	map.rooms["dali/dalisouth/jiangnan"].ways["#duCjiang"]='dali/dalisouth/jiangbei'
	map.rooms["dali/dalisouth/jiangbei"].ways["#duCjiang"]='dali/dalisouth/jiangnan'
	map.rooms["city/jiangbei"].ways["#duCjiang"]='city/jiangnan'		
	map.rooms["city/jiangnan"].ways["#duCjiang"]='city/jiangbei'
	map.rooms["lanzhou/road3"].ways["#duHhe"]='lanzhou/road2'
	map.rooms["lanzhou/road2"].ways["#duHhe"]='lanzhou/road3'
	map.rooms["lanzhou/dukou3"].ways["#duHhe"]='lanzhou/dukou2'		
	map.rooms["lanzhou/dukou2"].ways["#duHhe"]='lanzhou/dukou3'
	map.rooms["changan/road3"].ways["#duHhe"]='changan/road2'
	map.rooms["changan/road2"].ways["#duHhe"]='changan/road3'
	map.rooms["huanghe/road3"].ways["#duHhe"]='huanghe/road2'		
	map.rooms["huanghe/road2"].ways["#duHhe"]='huanghe/road3'
end
function djdh_close()                                                                            --��նɽ��ɺ�·��
    if locl.room_relation=='��˫����---���׽������׽���' or locl.room_relation=='�ɴ�����˫����---���׽������׽���' then					
		   map.rooms["dali/dalisouth/jiangnan"].ways["#duCjiang"]=nil	
	elseif locl.room_relation=='���׽���---�ּ�����׽���' or locl.room_relation=='�ɴ������׽���---�ּ�����׽���' then					
		   map.rooms["dali/dalisouth/jiangbei"].ways["#duCjiang"]=nil	
	elseif locl.room=='��������' then				
		   map.rooms["city/jiangbei"].ways["#duCjiang"]=nil	
           map.rooms["city/jiangbei"].ways["enter"]=nil	
           map.rooms["city/jiangbei"].ways["west"]=nil
           map.rooms["city/jiangbei"].ways["east"]=nil			   
	elseif locl.room=='�����ϰ�' then			                          	
		   map.rooms["city/jiangnan"].ways["#duCjiang"]=nil			      
    elseif locl.room_relation=='����I��ɿڴ�ɿ�' or locl.room_relation=='����ƺӶɴ��I�Ĵ�ɿڴ�ɿ�' then					
			map.rooms["lanzhou/road3"].ways["#duHhe"]=nil	
	elseif locl.room_relation=='��ɿ�----�����ɿ�' or locl.room_relation=='�ƺӶɴ��Ĵ�ɿ�----�����ɿ�' then					
			map.rooms["lanzhou/road2"].ways["#duHhe"]=nil	
	elseif locl.room_relation=='�ƺӨI���Ķɿ����Ķɿ�' or locl.room_relation=='�ƺӻƺӶɴ��I�����Ķɿ����Ķɿ�' then					
			map.rooms["lanzhou/dukou3"].ways["#duHhe"]=nil		
	elseif locl.room_relation=='���ĶɿڨKɽ�������Ķɿ�' or locl.room_relation=='�ƺӶɴ������ĶɿڨKɽ�������Ķɿ�' then					
			map.rooms["lanzhou/dukou2"].ways["#duHhe"]=nil	
	elseif locl.room_relation=='������½��ɿ��½��ɿ�' then					
			map.rooms["changan/road3"].ways["#duHhe"]=nil	
	elseif locl.room_relation=='�½��ɿڣ��K��·������ԭ�½��ɿ�' or locl.room_relation=='�ɴ����½��ɿڣ��K��·������ԭ�½��ɿ�' then					
			map.rooms["changan/road2"].ways["#duHhe"]=nil
    elseif locl.room_relation=='�ٵ�����ɿڴ�ɿ�'	then	
			map.rooms["huanghe/road3"].ways["#duHhe"]=nil				
	elseif locl.room_relation=='��ɿڣ��ƺ��뺣�ڴ�ɿ�' or locl.room_relation=='�ɴ��Ĵ�ɿڣ��ƺ��뺣�ڴ�ɿ�' then					
			map.rooms["huanghe/road2"].ways["#duHhe"]=nil		
	end
end	
--------������---------
function hudieguTriggers()
    DeleteTriggerGroup('hudiegu')
	create_trigger_t('hudiegugo1',"^(> )*������һ������Ȼ��ǰһ��������һ���ݾ���$",'','hudieguOk')
	create_trigger_t('hudiegugo2',"^(> )*һ��΢�紵�������Զ�����������ס��С·��$",'','hudiegu')
	SetTriggerOption('hudiegugo1','group','hudiegu')
	SetTriggerOption('hudiegugo2','group','hudiegu')
end
function go_hudiegu()
	hudieguTriggers()
	exe('tell mentonga ����;tell mentongb ����')
	exe('whisper startd ����')
	return checkWait(goHudiegu,1)
end
function goHudiegu()
	return go(hudieguStart,'������','ţ��')
end
function hudieguWalk()
    exe('nd;n;n;w;n;n;nd;n;w;n;yun jing;look')
end
function hudieguStart()
    create_timer_s('hudieguWalk',0.4,'hudieguWalk')
end
function hudiegu()  
    return go(go_hudiegu,'������','ɽ��')
end
function hudieguOk()
    DeleteTimer('hudieguWalk')
	DeleteTriggerGroup('hudiegu')
	return checkWait(hudieguPassed,0.5)
end
function hudieguPassed()
    locate()
	return checkWait(hudieguFind,1)
end
function hudieguFind()
    if locl.room == '�ݾ�' then
	   exe('n;n;n')
	   locl.area = '������'
	   locl.room = '����'
	end
	return go(hudieguFindAct,job.area,job.room)
end
function hudieguFindAct()
    if job.name == 'huashan' then

	   return huashanFindAct()
	elseif job.name == 'wudang' then

	   return wudangFindAct()
	
	elseif job.name == 'xueshan' then
		
		return xueshan_find_act()
		
	elseif job.name == 'songxin' or job.name == 'songxin2' then
	   flag.find = 0
       flag.wait = 0
	   flag.times = 1
	   return songxin_find_go()
    end
end
--------�����ˮ̶--------
function jqgeyuwait()
	if locl.room == '����̶' then
	   DeleteTimer('idle')
	   print('���㲻�ڣ��ȴ�������!')
	   messageShow('���㲻�ڣ����������̶�ȴ������У�','fuchsia')
	   exe('look')
	else
	  DeleteTimer('jqgeyu')
    end	  
end
function jqgeyu()
    DeleteTimer('jqgeyu')
	DeleteTriggerGroup('eyu')
	exe('kill eyu;drop corpse;ta corpse')
	locate()
    return check_halt(go_confirm)
end
function outJqg()
	DeleteTimer('jqgeyu')
	DeleteTriggerGroup("outjqg")
	create_trigger_t('outjqg1','^>*\\s*������һ��������֦�ɣ���Լһ����ߡ�','','outjqgshuganok')			
	create_trigger_t('outjqg2','^>*\\s*�㲻���Ѿ���������ô��','','outjqgshupi')
	create_trigger_t('outjqg3','^>*\\s*�����Ƥ����������㹻��������������ȥ��','','outjqgshuganok')
	create_trigger_t('outjqg4','^>*\\s*�����Ƥ��ʳ������Ѿ����������Ű���Ƥ���һ�����������ӡ�','','outjqgsuo')
	create_trigger_t('outjqg5','^>*\\s*���Ѿ�������һ�˸��������м䣬������Ҫ��Ƥ�ˡ�','','outjqgfuok')
	create_trigger_t('outjqg6','^>*\\s*�㽫����һ�˸��������м䡣','','outjqgfuok')
	for i=1,6 do SetTriggerOption("outjqg" .. i,"group","outjqg") end
	exe('zhe shugan')
end
function outjqgshuganok()
    check_bei(outjqgshupi)
end
function outjqgshupi()
    exe('#10(bo shupi)')
	check_bei(outjqgneedsuo)
end
function outjqgneedsuo()
    check_bei(outjqgsuo)
end
function outjqgsuo()
    exe('cuo shupi')
	check_bei(outjqgfu)
end
function outjqgfu()
    exe('fu shugan')
end
function outjqgfuok()
	DeleteTriggerGroup("outjqg")
    create_trigger_t('outjqg1','^>*\\s*����ס����������ʯ�ڣ�һ·������Ԯ��','','outjqgshibi')
	create_trigger_t('outjqg2','^>*\\s*��һ�¾���ʹ��ǡ���ô�����������ʱ���ú���ڶ�Ѩ���ϡ�','','outjqgOut')
	for i=1,6 do SetTriggerOption("outjqg" .. i,"group","outjqg") end
    check_bei(outjqgpa)
end
function outjqgpa()
    exe('pa shibi')
end
function outjqg()
    check_bei(outjqgpa)
end
function outjqgshibi()
    check_bei(outjqgout)
end
function outjqgout()
    exe('shuai shugan')
end
function outjqgOut()
    check_bei(outjqgok)
end
function outjqgok()
    DeleteTriggerGroup("outjqg")
    exe('pa up')
    locate()
    return check_halt(go_confirm)
end
-----------------------�¹Ȼ��ٹ��------------------
eaea=function()
    locate_finish=0   
    fastLocate()
    return checkWait(eaea_start,0.5)
end
eaea_start=function()
    if string.find(locl.room,'�¹Ȼ��ٹ��') then
          exe('east')
                  --check_step_num1=check_step_num1+1
          return eaea_over()
       else
          return go(road.act)
       end
end
eaea_over=function()
    return walk_wait()
end

eaeab=function()
    locate_finish=0   
    fastLocate()
    return checkWait(eaea_startb,0.5)
end
eaea_startb=function()
    if string.find(locl.room,'�¹Ȼ��ٹ��') then
          exe('west')
                  --check_step_num1=check_step_num1+1
          return eaea_overb()
       else
          return go(road.act)
       end
end
eaea_overb=function()
    return walk_wait()
end

eaeac=function()
    locate_finish=0   
    fastLocate()
    return checkWait(eaea_startc,0.5)
end
eaea_startc=function()
    if string.find(locl.room,'�¹Ȼ��ٹ��') then
          exe('northwest')
                  --check_step_num1=check_step_num1+1
          return eaea_overc()
       else
          return go(road.act)
       end
end
eaea_overc=function()
    return walk_wait()
end

eaead=function()
        locate_finish=0   
    fastLocate()
    return checkWait(eaea_startd,0.5)
end
eaea_startd=function()
    if string.find(locl.room,'�¹Ȼ��ٹ��') then
          exe('north')
                  --check_step_num1=check_step_num1+1
          return eaea_overd()
       else
          return go(road.act)
       end
end
eaea_overd=function()
    return walk_wait()
end
----------------------------------�������------------------------------------
check_yilitriger=function()
        DeleteTriggerGroup("yilidoorr")
        --create_trigger_t('yilidoorr1','^>*\\s*Ҫ��ʲô','','yilidoor_close')
        --create_trigger_t('yilidoorr2','^>*\\s*������','','yilidoor_open')
        create_trigger_t('yilidoorr3',"^(> )*(����Ƭ�̣���о��Լ��Ѿ��������޼���|�㽫��������������֮�ư�����һ��|��ֻ��������ת˳����������������|�㽫������ͨ���������|��ֻ����Ԫ��һ��ȫ����������|�㽫��Ϣ���˸�һ������|�㽫��Ϣ����ȫ��������ȫ���泩|�㽫�����������ڣ���ȫ���ۼ�����ɫ��Ϣ|�㽫����������������һ������|���˹���ϣ�վ������|��һ�������н������������ӵ�վ������|��ֿ�˫�֣�������������|�㽫��Ϣ����һ�����죬ֻ�е�ȫ��̩ͨ|������������������һ�����죬�����������ڵ���|������������������һ�����죬���������ڵ���|��˫��΢�գ���������ؾ���֮����������|���������������뵤������۾�|�㽫��Ϣ������һ��С���죬�������뵤��|��о�����ԽתԽ�죬�Ϳ�Ҫ������Ŀ����ˣ�|�㽫������Ϣ��ͨ���������������۾���վ������|������������һ��Ԫ����������˫��|�������뵤�������ת�����������չ�|�㽫����������������������һȦ���������뵤��|�㽫��Ϣ����������ʮ�����죬���ص���|�㽫��Ϣ���˸�С���죬���ص���չ�վ������|����Ƭ�̣������������Ȼ�ں���һ�𣬾����ӵ�վ����|��е��Լ��������Ϊһ�壬ȫ����ˬ��ԡ���磬�̲�ס�泩��������һ���������������۾�)",'','yilicheckwd')
        --SetTriggerOption("yilidoorr1","group","yilidoorr")
        --SetTriggerOption("yilidoorr2","group","yilidoorr")
        SetTriggerOption("yilidoorr3","group","yilidoorr")
        EnableTriggerGroup("yilidoorr",false)
end
yilicheckwd=function()
        check_yilitriger()
        EnableTriggerGroup("yilidoorr",true)
        --exe('look north')
        fastLocate()
        if flag.find==1 then return end
        wait.make(function()
            wait.time(2)
            return yilidoor_checkk()
        end)
end
yilidoor_close=function()
        exe('yun qi;dazuo '..hp.dazuo)
end
yilidoor_open=function()
        wdyilidz=0
        
end
yilidoor_checkk=function()
    if locl.room_relation=='�ϳ��ţ�������ϳ���' then
           wait.make(function()
              wait.time(1)
			return yilidoor_close()
          --return yilicheckwd()
           end)
        elseif locl.room_relation=='�����ģ��ϳ��ţ�������ϳ���' then
           EnableTriggerGroup("yilidoorr",false)
           return check_halt(yilidoor_over)
        else
           return go_locate()
        end
end
yilidoor_over=function()
       exe('n')
           if flag.find==1 then return end
           return walk_wait()
end
yilicheckwds=function()
        fastLocate()
        if flag.find==1 then return end
        wait.make(function()
            wait.time(2)
            return yilidoor_checkks()
        end)
end
yilidoor_checkks=function()
        if locl.room=='�ϳ���' then
           return check_halt(yilidoor_overs)
        else
           return go_locate()
        end
end
yilidoor_overs=function()
       exe('s')
           if flag.find==1 then return end
           return walk_wait()
end
-------------���϶�--------------
jldin=function()
   DeleteTriggerGroup("jldin")
   create_trigger_t('jldin1','^>*\\s*������û�л��ۣ���ô�ܽ�����ɽ����','','jldfalse')
   SetTriggerOption("jldin1","group","jldin")
   EnableTriggerGroup("jldin",true)
	wait.make(function() 
          wait.time(1.5)
    exe('get fire;use fire')
	if flag.wait==1 then return end	
	exe('e')
	if flag.wait==1 then return end	
	exe('n')
	if flag.wait==1 then return end	
	exe('ne')
	if flag.wait==1 then return end	
	exe('nw')
	if flag.wait==1 then return end	
	exe('s')
	if flag.wait==1 then return end	
	exe('se')
	if flag.wait==1 then return end	
	exe('sw')
	if flag.wait==1 then return end	
	exe('w')
	if flag.wait==1 then return end	
	exe('out')
	if flag.wait==1 then return end	
	return jldinover()
	end)
end
jldfalse=function()
	EnableTriggerGroup("jldin",false)
	return check_food()
end
function jldinover()
	EnableTriggerGroup("jldin",false)
    walk_wait()
end
jldout=function()
   exe('drop fire;leave;leave;leave;leave;out;ne;ed;ne;ed;ne')
   locate_finish='jldout1'
   return locate()
end
jldout1=function()
   wait.make(function() 
	   wait.time(1) 
       if locl.room_relation=='���϶����϶�' then
	      return jldout()
       else
	      return walk_wait()
       end
   end)
end
-------�͵�˯������-------
--[[function kedian_sleep()
	if flag.sleep then return end
	exe('enter;sleep')
	flag.sleep=true
	checkWait(walk_wait,3)
end]]
--------�������ź���-------
function fznm()
   if flag.find==1 then return end
   return check_halt(fznmcheck)
end
function fznmcheck()
           wait.make(function()
               wait.time(3)
               exe('n;n;w;w;w;w;nw;sw;sw;w;sw;sw;sw;sw;w;s;sd;sd;s;s;s;s;e;e;e;e;e;e')
               return fznmcheckdo1()
           end)
end
function fznmcheckdo1()
        if flag.find==1 then return end
    exe('e')
        return checkWait(fznmcheckdo2,0.1)
end
function fznmcheckdo2()
        if flag.find==1 then return end
    exe('ne')
        return checkWait(fznmcheckdo3,0.1)
end
function fznmcheckdo3()
        if flag.find==1 then return end
    exe('ne')
        return checkWait(fznmcheckdo4,0.1)
end
function fznmcheckdo4()
        if flag.find==1 then return end
    exe('ne')
        return checkWait(fznmcheckdo5,0.1)
end
function fznmcheckdo5()
        if flag.find==1 then return end
    exe('n')
        return walk_wait()
end
function fznmdq()
        return fznmdqcheck()
end
function fznmdqcheck()
           wait.make(function()
               wait.time(3)
                   if flag.find==1 then return end
               exe('s;sw;sw;sw;w;w;w;w;w;w;w;n;n;n;n;nu;nu;n;e;ne;ne;ne;ne;e;ne;ne;se;e')
               return fznmdqcheckdo1()
           end)
end
function fznmdqcheckdo1()
        if flag.find==1 then return end
    exe('e')
        return checkWait(fznmdqcheckdo2,0.1)
end
function fznmdqcheckdo2()
        if flag.find==1 then return end
    exe('e')
        return checkWait(fznmdqcheckdo3,0.1)
end
function fznmdqcheckdo3()
        if flag.find==1 then return end
    exe('e')
        return checkWait(fznmdqcheckdo4,0.1)
end
function fznmdqcheckdo4()
        if flag.find==1 then return end
    exe('s')
        return checkWait(fznmdqcheckdo5,0.1)
end
function fznmdqcheckdo5()
        if flag.find==1 then return end
    exe('s')
        return walk_wait()
end
------------------------------���ݿ�ջ----------------------------------------
lanzhoukedian=function()
	exe('give xiao 5 silver;up')
	return checkWait(lanzhoukedian1,0.4)
end
lanzhoukedian1=function()
   if flag.find==1 then return end
   exe('enter')
   return checkWait(lanzhoukedian2,0.4)
end
lanzhoukedian2=function()
   if flag.find==1 then return end
   exe('out')
   return walk_wait()
end
lzkdoutgo=function()
	EnableTriggerGroup("lzkedianout",false)
	DeleteTriggerGroup("lzkedianout")
	exe('out;down;e')
	return walk_wait()
end

lzkedianoutgosleep=function()
	exe('east')
	fastLocate()
	wait.make(function() 
        wait.time(1)
		if flag.find==1 then return end
		return lzkedianoutgosleepdo()
	end)
end
lzkedianoutgosleepdo=function()
	locate_finish=0
	DeleteTriggerGroup("lzkedianout")
	create_trigger_t('lzkedianout1','^>*\\s*��һ�����������þ������棬�ûһ���ˡ�$','','lzkdoutgo') 
	create_trigger_t('lzkedianout2','^>*\\s*��С��һ�µ���¥��ǰ������һ���������ţ����ס����$','','lzkzgogo')
    create_trigger_t('lzkedianout3','^>*\\s*���ﲻ������˯�ĵط���$','','lzkzgogogo')  
	SetTriggerOption("lzkedianout1","group","lzkedianout")
	SetTriggerOption("lzkedianout2","group","lzkedianout")
	SetTriggerOption("lzkedianout3","group","lzkedianout")
	if locl.room_relation=='�͵��¥���͵�-----���ǿ͵�' then
	   exe('up;enter;sleep')
	else
	   return lzkzgogogo()
	end
end
lzkzgogo=function()
	EnableTriggerGroup("lzkedianout",false)
	DeleteTriggerGroup("lzkedianout")
	exe('east')
	return walk_wait()
end
lzkzgogogo=function()
	EnableTriggerGroup("lzkedianout",false)
	DeleteTriggerGroup("lzkedianout")
	return walk_wait()
end
------------------------------�ۺ���ջ----------------------------------------
jhkz=function()
	exe('give xiao 5 silver;up')
	return checkWait(jhkz1,0.4)
end
jhkz1=function()
   if flag.find==1 then return end
   exe('north')
   return checkWait(jhkz2,0.4)
end
jhkz2=function()
   if flag.find==1 then return end
   exe('south')
   return walk_wait()
end
jhkzout=function()
	exe('east')
	fastLocate()
	return checkWait(jhkzcheck,1)
end
jhkzcheck=function()
	DeleteTriggerGroup("jhkz")
	create_trigger_t('jhkz1','^>*\\s*��һ�����������þ������棬�ûһ���ˡ�$','','jhkzoutgo') 
	create_trigger_t('jhkz2','^>*\\s*��ô�ţ����ס����$','','jhkzoutgogogo')
    create_trigger_t('jhkz3','^>*\\s*���ﲻ������˯�ĵط���$','','jhkzoutgogo') 
	SetTriggerOption("jhkz1","group","jhkz")
	SetTriggerOption("jhkz2","group","jhkz")
	SetTriggerOption("jhkz3","group","jhkz")
    if locl.room_relation=='���ȡ��ۺ���ջ---����־ۺ���ջ' then
		exe('up;n;sleep')
	else 
		return jhkzoutgogo()
    end
end
jhkzoutgo=function()
	EnableTriggerGroup("jhkz",false)
	DeleteTriggerGroup("jhkz")
    exe('s;d;e')
	return walk_wait()
end
jhkzoutgogogo=function()
	EnableTriggerGroup("jhkz",false)
	DeleteTriggerGroup("jhkz")
    exe('e')
	return walk_wait()
end
jhkzoutgogo=function()
	EnableTriggerGroup("jhkz",false)
	DeleteTriggerGroup("jhkz")
	return walk_wait()
end
-----------------------------������ջ---------------------------------------
bckz=function()
	exe('give xiao 5 silver;up')
	return checkWait(bckz1,0.4)
end
bckz1=function()
   if flag.find==1 then return end
   exe('enter')
   return checkWait(bckz2,0.4)
end
bckz2=function()
   if flag.find==1 then return end
   exe('out')
   return walk_wait()
end
bckzout=function()
	exe('west')
	fastLocate()
	wait.make(function() 
        wait.time(1)
	    return bckzcheck()
	end)
end
bckzcheck=function()
	if flag.find==1 then return end
	DeleteTriggerGroup("bckz")
	create_trigger_t('bckz1','^>*\\s*��һ�����������þ������棬�ûһ���ˡ�$','','bckzoutgo') 
	create_trigger_t('bckz2','^>*\\s*��ô�ţ����ס���Ǳ�����ջ����$','','bckzoutgogogo')
    create_trigger_t('bckz3','^>*\\s*���ﲻ������˯�ĵط���$','','bckzoutgogo') 
	SetTriggerOption("bckz1","group","bckz")
	SetTriggerOption("bckz2","group","bckz")
	SetTriggerOption("bckz3","group","bckz")
    if locl.room_relation=='�͵��¥�������---������ջ---ƫ��������ջ' then
		exe('up;enter;sleep')
	else
		return bckzoutgogo()
    end
end
bckzoutgo=function()
	EnableTriggerGroup("bckz",false)
	DeleteTriggerGroup("bckz")
    exe('out;d;w')
	return walk_wait()
end
bckzoutgogogo=function()
	EnableTriggerGroup("bckz",false)
	DeleteTriggerGroup("bckz")
	exe('w')
	return walk_wait()
end
bckzoutgogo=function()
	EnableTriggerGroup("bckz",false)
	DeleteTriggerGroup("bckz")
	return walk_wait()
end
--------------------------����ϲ����ջ-----------------------------------------------
xfkz=function()
	exe('give xiao 5 silver;up')
	return checkWait(xfkz1,0.4)
end
xfkz1=function()
	if flag.find==1 then return end
    exe('enter')
	return checkWait(xfkz2,0.4)
end
xfkz2=function()
	if flag.find==1 then return end
    exe('out')
	return walk_wait()
end
xfkzoutgo=function()
	EnableTriggerGroup("xfkz",false)
	DeleteTriggerGroup("xfkz")
	exe('out;down;n')
	return walk_wait()
end
xfkzoutgosleep=function()
	  exe('north')
	  fastLocate()
	  return checkWait(xfkzout1,1)
end
xfkzout1=function()
	DeleteTriggerGroup("xfkz")
	create_trigger_t('xfkz1','^>*\\s*��һ�����������þ������棬�ûһ���ˡ�$','','xfkzoutgo') 
	create_trigger_t('xfkz2','^>*\\s*��С��һ�µ���¥��ǰ������һ���������ţ����ס����$','','xfkzsleepgogo') 
	create_trigger_t('xfkz3','^>*\\s*���ﲻ������˯�ĵط���$','','xfkzsleepgo') 
	SetTriggerOption("xfkz1","group","xfkz")
	SetTriggerOption("xfkz2","group","xfkz")
	SetTriggerOption("xfkz3","group","xfkz")
	if locl.room_relation=='���֣�ϲ����ջϲ����ջ' then
		exe('up;enter;sleep')
	else
		return xfkzsleepgo()
	end
end
xfkzsleepgogo=function()
    EnableTriggerGroup("xfkz",false)
	DeleteTriggerGroup("xfkz")
	exe('n')
	return walk_wait()
end
xfkzsleepgo=function()
    EnableTriggerGroup("xfkz",false)
	DeleteTriggerGroup("xfkz")
	return walk_wait()
end
-----------------------------------���ݿ͵�---------------------------------
szkedian=function()
	exe('give xiao 5 silver;up')
	return checkWait(szkedian1,0.4)
end
szkedian1=function()
   if flag.find==1 then return end
   exe('enter')
   return checkWait(szkedian2,0.4)
end
szkedian2=function()
   if flag.find==1 then return end
   exe('out')
   return walk_wait()
end
szkdout=function()
	exe('up;enter;out;down;w')
	return walk_wait()
end
------------------------------���ݴ��ջ----------------------------------------
cangzhoukedian=function()
	exe('give xiao 5 silver;up')
	return checkWait(cangzhoukedian1,0.4)
end
cangzhoukedian1=function()
   if flag.find==1 then return end
   exe('enter')
   return checkWait(cangzhoukedian2,0.4)
end
cangzhoukedian2=function()
   if flag.find==1 then return end
   exe('out')
   return walk_wait()
end
czkdoutgo=function()
	EnableTriggerGroup("czkedianout",false)
	DeleteTriggerGroup("czkedianout")
	exe('out;down;s')
	return walk_wait()
end

czkedianoutgosleep=function()
	exe('south')
	fastLocate()
	wait.make(function() 
        wait.time(1)
		if flag.find==1 then return end
		return czkedianoutgosleepdo()
	end)
end
czkedianoutgosleep1=function()
	exe('north')
	fastLocate()
	wait.make(function() 
        wait.time(0.3)
		if flag.find==1 then return end
		return czkedianoutgosleepdo()
	end)
end
czkedianoutgosleepdo=function()
	locate_finish=0
	DeleteTriggerGroup("czkedianout")
	create_trigger_t('czkedianout1','^>*\\s*��һ�����������þ������棬�ûһ���ˡ�$','','czkdoutgo') 
	create_trigger_t('czkedianout2','^>*\\s*��С��һ�µ���¥��ǰ������һ���������ţ����ס����$','','czkzgogo')
    create_trigger_t('czkedianout3','^>*\\s*���ﲻ������˯�ĵط���$','','czkzgogogo')  
	SetTriggerOption("czkedianout1","group","czkedianout")
	SetTriggerOption("czkedianout2","group","czkedianout")
	SetTriggerOption("czkedianout3","group","czkedianout")
	if locl.room_relation=='���֣����ջ���Ͻִ��ջ' then
	   exe('up;enter;sleep')
	else
	   return czkzgogogo()
	end
end
czkzgogo=function()
	EnableTriggerGroup("czkedianout",false)
	DeleteTriggerGroup("czkedianout")
	exe('south')
	return walk_wait()
end
czkzgogogo=function()
	EnableTriggerGroup("czkedianout",false)
	DeleteTriggerGroup("czkedianout")
	return walk_wait()
end
------------------------------Ӣ�ۿ�ջ----------------------------------------
yingxiongkedian=function()
	exe('give xiao 5 silver;up')
	return checkWait(yingxiongkedian1,0.4)
end
yingxiongkedian1=function()
   if flag.find==1 then return end
   exe('enter')
   return checkWait(yingxiongkedian2,0.4)
end
yingxiongkedian2=function()
   if flag.find==1 then return end
   exe('out')
   return walk_wait()
end
yxkdoutgo=function()
	EnableTriggerGroup("yxkedianout",false)
	DeleteTriggerGroup("yxkedianout")
	exe('out;down;e')
	return walk_wait()
end

yxkedianoutgosleep=function()
	exe('east')
	fastLocate()
	wait.make(function() 
        wait.time(0.3)
		if flag.find==1 then return end
		return yxkedianoutgosleepdo()
	end)
end
yxkedianoutgosleepdo=function()
	locate_finish=0
	DeleteTriggerGroup("yxkedianout")
	create_trigger_t('yxkedianout1','^>*\\s*��һ�����������þ������棬�ûһ���ˡ�$','','yxkdoutgo') 
	create_trigger_t('yxkedianout2','^>*\\s*��С��һ�µ���¥��ǰ������һ���������ţ����ס����$','','yxkzgogo') 
	create_trigger_t('yxkedianout3','^>*\\s*���ﲻ������˯�ĵط���$','','yxkzgogogo') 
	SetTriggerOption("yxkedianout1","group","yxkedianout")
	SetTriggerOption("yxkedianout2","group","yxkedianout")
	SetTriggerOption("yxkedianout3","group","yxkedianout")
	if locl.room_relation=='��ջ��¥��Ӣ�ۿ�ջ---��ɽ�Ͻ�Ӣ�ۿ�ջ' then
	   exe('up;enter;sleep')
	else
	   return yxkzgogogo()
	end
end
yxkzgogo=function()
	EnableTriggerGroup("yxkedianout",false)
	DeleteTriggerGroup("yxkedianout")
	exe('east')
	return walk_wait()
end
yxkzgogogo=function()
	EnableTriggerGroup("yxkedianout",false)
	DeleteTriggerGroup("yxkedianout")
	return walk_wait()
end
-------------------��÷ׯ------------------------------
function inmz()
   wait.make(function() 
	    wait.time(3)
		if flag.find==1 then return end
        exe('s')	
        return walk_wait()
   end)
end
function inmzcheck()
    if locl.room_relation=='С·��С·��÷��С·' then
		exe('s')
		if flag.find==1 then return end	
		return walk_wait()
	else
		if flag.find==1 then return end	
		return go_locate()
	end
end
-----------------------------------------------��÷��-------------------------------------
function mlOutt()
	tmp.cnt=0
	exe('look')
	wait.make(function() 
        wait.time(2.5)
        if flag.find==1 then return end	 
		exe('n')
        return mloutdo()
    end) 
end
function mloutdo()
	fastLocate()
	wait.make(function() 
        wait.time(1)
        if flag.find==1 then return end	 
        if locl.room~='÷��' then
			return path_consider()
	    else
			return mlOut()
		end
	end)
end
function mlOut()
    tmp.way = "north"
	tmp.ml = "out"
	exe('w;e;n')
	fastLocate()
	return checkWait(wayMl,0.5)
end
function wait_seconds()
	wait.make(function()
         wait.time(5)
	return wayMl()
    end)
end
function wayMl()
	tmp.cnt=tmp.cnt+1
	if tmp.cnt>50 then
	   tmp.cnt=0
	   return wait_seconds()
	end
    local ways = {
		["north"] = "east",
		["east"]  = "south",
		["south"] = "west",
		["west"]  = "north",
	}
	local wayt = {
		["north"] = "west",
		["east"]  = "north",
		["south"] = "east",
		["west"]  = "south",
	}
	if not tmp.way or not ways[tmp.way] then
	   tmp.way = 'south'
	end
	if locl.room=="��ʯ���·" then
	   if tmp.ml and tmp.ml=="in" then
	      return wayMlOver()
	   else
	      tmp.way = "north"
	      exe(tmp.way)
		  fastLocate()
		  return checkWait(wayMl,0.5)
	   end 
    end
    if locl.room=="С·" then
	   if tmp.ml and tmp.ml=="out" then
		  print('������')
		  exe('n')
	      return wayMlOver()
	   else
	      tmp.way = "south"
	      exe('south;south')
		  locate()
		  return checkWait(wayMl,0.5)
	   end 
    end
    if locl.room~="С·" and locl.room~="��ʯ���·" and locl.room~="÷��" then
       return wayMlOver()
    end	
	tmp.way = ways[tmp.way]
	repeat 
       if not locl.exit[tmp.way] then
	      Note(tmp.way)
	      tmp.way = wayt[tmp.way]
       end
	until(locl.exit[tmp.way])
	exe(tmp.way)
	fastLocate()
	return checkWait(wayMl,0.5)
end
function wayMlOver()
	return path_consider()
end
-------------------------------------------------------------------------------------------
klffsclimb=function()
    exe('open door;out')
    return walk_wait()
end--EOF
--�䵱��ɽclimb֮ǰ��room�����ȴ�<<EOF
wdxlclimb=function()
    wait.make(function()
    wait.time(0.4)
    if flag.find == 1 or flag.wait==1 then return end
       exe("pa up")
       return walk_wait()
    end)
end--EOF
-------����̲--------
function dutan()
    wait.make(function()
    wait.time(0.4)
    if flag.find == 1 or flag.wait==1 then return end
       exe("dutan")
       return walk_wait()
    end)
end
--���ȥ�������������鱦��ĺ�������--
function gosxh()
    locate_finish=0   
    fastLocate()
    return checkWait(gosxh_consider,1)
end
function gosxh_consider()
    if locl.room_relation=='�������ƹݣ�����----�����----����֣��鱦�������' then
	   return checkWait(gosxh_go,1)
	else
	   return walk_wait()
	end
end
function gosxh_go()
    exe('n')
    wait.make(function()
    wait.time(0.4)
    if flag.find == 1 or flag.wait==1 then return end
       return walk_wait()
    end)
end
function gozbd()
    locate_finish=0   
    fastLocate()
    return checkWait(gozbd_consider,1)
end
function gozbd_consider()
    if locl.room_relation=='�������ƹݣ�����----�����----����֣��鱦�������' then
	   return checkWait(gozbd_go,1)
	else
	   return walk_wait()
	end
end
function gozbd_go()
    exe('s')
    wait.make(function()
    wait.time(0.4)
    if flag.find == 1 or flag.wait==1 then return end
       return walk_wait()
    end)
end