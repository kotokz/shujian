--[[说明:
1.在shujian.lua 的sLetterlost() “EnableTriggerGroup("lostletter",true)‘ 之前插入llgo()
2.在sendOk() 的return 之前加一句sendOk_fix()
3.在shujian.lua require 语句中加入 require "dolost"
-]] require 'wait'
require 'tprint'
addali_reg = function(aliname, alimatch, aligroup, aliscript)
    alireturnvalue = AddAlias(aliname, alimatch, "", alias_flag.Enabled +
                                  alias_flag.Replace +
                                  alias_flag.RegularExpression, aliscript)
    SetAliasOption(aliname, "group", aligroup)
    return alireturnvalue
end
function llgo()
    create_trigger_t('lostletter8',
                     "^[> ]*这是一封大理国镇南王府送出的书信。$",
                     '', 'lostp_look')
    SetTriggerOption("lostletter8", "group", "lostletter")
    -- create_alias_s('llgo','^llgo$','lost_goto')
    addali_reg('llgo', '^llgo$', '', 'lost_goto')
end
function lostp_look()
    job.name = 'dolost'
    DeleteTriggerGroup("lostplace")
    create_trigger_t('lostplace1',
                     "^[> ]*好象收信人曾在(\\D*)一带出现。$", '',
                     'lostp_get')
    SetTriggerOption("lostplace1", "group", "lostplace")
    EnableTriggerGroup("lostplace", true)
end
function lostp_get(n, l, w)
    -- exe('look lose letter')
    ll_place = w[1]
    job.where = ll_place
    if string.find(ll_place, '姑苏慕容') or
        string.find(ll_place, '燕子坞') or
        string.find(ll_place, '曼佗罗山庄') or
        string.find(ll_place, '神龙岛') or string.find(ll_place, '绝情谷') or
        string.find(ll_place, '明教') or string.find(ll_place, '桃源县') then
        messageShow('失落的信笺任务：【' .. ll_place ..
                        '】太远继续任务！', "red")
        EnableTimer('walkWait4', false)
        locate_finish = 'check_ll'
        return locate()
    end
    if string.find(ll_place, '长江南岸') or
        string.find(ll_place, '宁波城') or string.find(ll_place, '丐帮') or
        string.find(ll_place, '莆田少林') or
        string.find(ll_place, '福州城') or string.find(ll_place, '苏州城') or
        string.find(ll_place, '杭州城') or string.find(ll_place, '嘉兴城') or
        string.find(ll_place, '佛山镇') then
        ll_place = '扬州城长江北岸'
    end
    if string.find(ll_place, '黄河流域大渡口') then
        ll_place = '黄河流域大渡口'
    end
    if string.find(ll_place, '伊犁城南城门') then
        ll_place = '伊犁城南城门'
    end
    if string.find(ll_place, '澜沧江边') then
        ll_place = 'dali/dalisouth/jiangnan'
    end
    if string.find(ll_place, '兰州城大渡口') then
        ll_place = '兰州城大渡口'
    end
    if string.find(ll_place, '恒山') or string.find(ll_place, '黑木崖') then
        ll_place = '长安城陕晋渡口'
    end
    if string.find(ll_place, '嘉峪关') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '大草原') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '星宿海') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '回疆') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '伊犁城') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '昆仑') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '沧州城') then ll_place = '兰州大渡口' end
    if string.find(ll_place, '塘沽城') then ll_place = '兰州大渡口' end
    if string.find(ll_place, '平定州') then
        ll_place = '长安城陕晋渡口'
    end
    if string.find(ll_place, '兰州城西夏渡口') then
        ll_place = '兰州城西夏渡口'
    end
    if string.find(ll_place, '长安城陕晋渡口') then
        ll_place = '长安城陕晋渡口'
    end
    if score.party == '姑苏慕容' then ll_place = ll_place end
    -- messageShow('失落的信笺任务：开始前往【'..ll_place..'】寻找玩家！')
    DoAfterSpecial(0.2, 'llgo', 10)
end

---------------------测试goto----------------
function gogo(where)
    local l_dest = {}
    sour.id = nil
    dest.id = nil
    tmp.go_to = true
    where = Trim(where)

    l_dest.area, l_dest.room = locateroom(where)

    if l_dest.area then
        return go(test, l_dest.area, l_dest.room)
    else
        return ColourNote("red", "blue",
                          "找不到或无法到达此(地点|人物)：" ..
                              where)
    end

end
function lost_goto()
    create_timer_s('walkWait4', 10.0, 'sx_look')
    if ll_place == nil then return Note('空地方你让我去个P!') end
    --[[if ll_place == '星宿海绝壁' then 
      return Execute('discard letter')
	end]]
    messageShow('失落的信笺任务：开始前往【' .. ll_place ..
                    '】寻找玩家' .. '【' .. lost_name .. '】')
    if ll_place == '长安城陕晋渡口' or ll_place ==
        '扬州城长江北岸' or ll_place == '兰州城大渡口' or ll_place ==
        '澜沧江边' or ll_place == '兰州城西夏渡口' or ll_place ==
        '黄河流域大渡口' then return gogo(ll_place) end
    dest.room, dest.area = getAddr(ll_place)
    if job.area and job.area == dest.area and job.room and job.room == dest.room then
        l_distance = 2
        return go(find_dolost, job.area, job.room)
    else
        job.area = dest.area
        job.room = dest.room
    end
    if dest.area == nil or not dest.room then
        exe('look lose letter')
    else
        return go(lookXin, dest.area, dest.room)
    end
end
function find_dolost()
    flag.times = 1
    job.flag()
    exe('look')
    return find()
end
sx_look = function() exe('look letter') end
function sendOk_fix()
    EnableTimer('walkWait4', false)
    ll_place = nil
    DeleteTriggerGroup("lostplace")
end
function sendXXin()
    wipe_kill = 1
    lookXin()
    return create_timer_s('sendTo', 0.4, 'sendTo')
end
function check_ll()
    locate_finish = 0
    EnableTimer('sendTo', false)
    EnableTimer('sx_look', false)
    dis_all()
    return checkJob()
end
-- =======================================测试存东西=========================================
--[[> 你把青布僧衣从个人储物箱中提取出来。
> 你把布履从个人储物箱中提取出来。
> 你从身上拿出一双布履，放入自己的个人储物箱。
> 你把布履从个人储物箱中提取出来。
> 你正忙着！
你穿戴着：
  □僧鞋(Seng xie)
  □护腕(Hu wan)
  □护腰(Hu yao)
  □黄金卡(VIP Card)
  □背囊(Bei Nang)
  □劲装(Cloth)
你装备着：
  □飞絮神通剑(Shentong sword)]]
local armor_list = {}
function cun_armor_list()
    wait.make(function()
        exe('i;say 装备检查完毕')
        repeat
            local l, w = wait.regexp(
                             '^[> ]*[□]\\S+\\((.+)\\)$|^[> ]*你说道：「装备检查完毕」$')
            table.insert(armor_list, string.lower(Trim(w[1])))
        until string.find(l, '装备检查完毕')
        tprint(armor_list)
    end)
    return armor_list
end
function cun_armor()
    i = cun_i
    wait.make(function()
        if i < #armor_list and armor_list[i] ~= '' and #armor_list > 1 and
            not string.find(armor_list[i], 'nang') and
            not string.find(armor_list[i], 'card') and
            not string.find(armor_list[i], 'sword') and
            not string.find(armor_list[i], 'axe') then
            Execute('cun ' .. armor_list[i])
            local l, w = wait.regexp(
                             '^[> ]*你从身上拿出.+，放入自己的个人储物箱。$|^[> ]*你正忙着！$|^[> ]*你身上没有这样东西。$|^[> ]*.+不可以被保存。$')
            if string.find(l, '放入自己的个人储物箱') or
                string.find(l, '你身上没有这样东西') or
                string.find(l, '可以被保存') then
                i = i + 1
                cun_i = i
                return cun_armor()
            elseif string.find(l, '你正忙着') then
                cun_i = i
                wait.time(0.5)
                return cun_armor()
            end
        elseif i >= #armor_list then
            print('存完了')
        end
    end)
end
function cun_cmd()
    armor_list = {}
    cun_armor_list()
    exe('remove all')
    cun_i = 1
    DoAfterSpecial(0.5, 'cun_armor()', 12)
end
function qu_cmd()
    armor_list = {}
    qu_armor_list()
    cun_i = 1
    DoAfterSpecial(0.5, 'qu_armor()', 12)
end
function qu_armor_list()
    wait.make(function()
        exe('dlist')
        repeat
            local l, w = wait.regexp(
                             '^[> *┃\\s+(.+)\\s+\\S+\\s+\\.+天\\s+┃$|^[> *┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛$')
            table.insert(armor_list, string.lower(Trim(w[1])))
        until string.find(l,
                          '┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛')
        tprint(armor_list)
    end)
    return armor_list
end
function qu_armor()
    i = cun_i
    wait.make(function()
        if i < #armor_list and armor_list[i] ~= '' then
            exe('qu ' .. armor_list[i])
            local l, w = wait.regexp(
                             '^[> ]*你把.+从个人储物箱中提取出来。$|^[> ]*你正忙着！$|^[> ]*你并没有保存该物品。$')
            if string.find(l, '个人储物箱中提取出来') or
                string.find(l, '你并没有保存该物品。') then
                i = i + 1
                cun_i = i
                return qu_armor()
            elseif string.find(l, '你正忙着') then
                cun_i = i
                wait.time(0.5)
                return qu_armor()
            end
        elseif i >= #armor_list then
            print('取完了')
            DoAfter(3, 'wear all;dlist')
        end
    end)
end
