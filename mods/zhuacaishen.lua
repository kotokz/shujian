--------���Զ�ץ���������------

--[[ʹ��˵����
��1�����롰csgo��������rumor��ʾֱ�����������ֵĵص㣬�����˾ͻ��Զ�����Ŀ�ĵ�չ��������
��2�������ͬ�������뾡�����������ĵ��������磺���˵ء��С���ɽ��˵ء��͡���ɽ�˵ء��������������ص㡣
��3�������˲�ƣ����������ץ���ʣ��뾡����rumor���ֲ���λ��ʱ����һʱ��Ϲ�ȥ��
��4��һ������û���ҵ��Ļ����������롰stop����Ȼ�����롰csgo����������һ�Ρ�
��5������������û�У�������ʱ�����񣬵ȴ���һ����ʾ��ǰȥ��
��6�������Ƿ�ץ�����񣬻����˶����Զ���ʼ������
��7��ÿ��һ������ץһ�β�������8��һ�Σ�9��һ�Σ��Դ����ơ�
     ����ڵ�ǰʱ������Ѿ�ץ�������޷�����ץ������ȵ���һ�����㡣

���ף���˷���ƣ������ƽ����֣�����]]

--------by �һ����޷��磨2019.1.1��---------

--[[function zhuacaishen_auto()
	create_trigger_t('zhacaishen1','^(> )*(\\D*)��˵���˿���������(\\D*)���֣�$','','caishen_location')
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
	create_trigger_t('zhuacaishen_find1','^(> )*\\s*���� ����ү �Թ���\\(Zhao gongming\\)','','caishenTarget')
    create_trigger_t('zhuacaishen_find_success',"^(> )*����үΪ��������(\\D*)�V�ƽ���",'','zhuacaishen_finish')
	create_trigger_t('zhuacaishen_find2','^(> )*(����û�� zhao gongming|����û�� zhao)','','zhuacaishen_goon')
    SetTriggerOption("zhuacaishen_find1","group","zhuacaishen_find")
    SetTriggerOption("zhuacaishen_find2","group","zhuacaishen_find")
	EnableTrigger("zhuacaishen_find2",false)
    l_result=utils.inputbox ("��Ҫץ�Ĳ���λ�ڣ�", "����λ��", GetVariable("caishen_location"), "����" , "12")
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
      return ColourNote ("red","blue","�Ҳ������޷������(�ص�|����)��"..where)
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
    messageShow('ץ��������������ʧ������ͬ־�����Σ���ȴ�rumor��ʾ������ץ��ף����ˣ�','white','black')
	return go(check_heal,'�����','ҩ��')
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
    messageShow('ץ�����ѵ�������ص㡾'..GetVariable("caishen_location")..'������ʼѰ�ҡ�����','lime','black')
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
	messageShow('ץ����������ɣ���á�'..w[2]..'�����ƽ�','red','black')
	dis_all()
	EnableTriggerGroup("zhuacaishen_find",false)
	EnableTrigger("zhuacaishen_find_success",false)
    return check_halt(check_food)
end