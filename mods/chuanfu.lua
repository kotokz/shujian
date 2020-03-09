-- 船夫系列
Chuanfu = {
    enable = false,
    -- 陕晋渡口 黄河流域大渡口
    -- 西夏渡口 兰州渡口
    -- 长江渡口 澜沧江
    sanjin = {
        enable = false,
        arriveTime = 0,
        departTime = 0
    },
    huanghe = {
        enable = false,
        arriveTime = 0,
        departTime = 0
    },
    xixia = {
        enable = false,
        arriveTime = 0,
        departTime = 0
    },
    lanzhou = {
        enable = false,
        arriveTime = 0,
        departTime = 0
    },
    changjiang = {
        enable = false,
        arriveTime = 0,
        departTime = 0
    },
    lancangjiang = {
        enable = false,
        arriveTime = 0,
        departTime = 0
    }
}

function Chuanfu:addtrigger()
    DeleteTriggerGroup("chuanfu")
    create_trigger_t('chuanfu1', "^(> )*\\D*告诉你：长江渡船出发时间",
                     '', 'changjiangOpen')
    create_trigger_t('chuanfu2',
                     "^(> )*\\D*告诉你：澜沧江渡船出发时间", '',
                     'lancangjiangOpen')
    create_trigger_t('chuanfu3',
                     "^(> )*\\D*告诉你：澜沧江渡船到达时间", '',
                     'lancangjiangClose')
    create_trigger_t('chuanfu4', "^(> )*\\D*告诉你：长江渡船到达时间",
                     '', 'changjiangClose')
    create_trigger_t('chuanfu5',
                     "^(> )*\\D*告诉你：黄河流域大渡口出发时间",
                     '', 'huangheOpen')
    create_trigger_t('chuanfu6',
                     "^(> )*\\D*告诉你：黄河流域大渡口到达时间",
                     '', 'huangheClose')
    create_trigger_t('chuanfu7', "^(> )*\\D*告诉你：陕晋渡口出发时间",
                     '', 'sanjinOpen')
    create_trigger_t('chuanfu8', "^(> )*\\D*告诉你：陕晋渡口到达时间",
                     '', 'sanjinClose')
    create_trigger_t('chuanfu9', "^(> )*\\D*告诉你：西夏渡口出发时间",
                     '', 'xixiaOpen')
    create_trigger_t('chuanfu10', "^(> )*\\D*告诉你：西夏渡口到达时间",
                     '', 'xixiaClose')
    create_trigger_t('chuanfu11', "^(> )*\\D*告诉你：兰州渡口出发时间",
                     '', 'lanzhouOpen')
    create_trigger_t('chuanfu12', "^(> )*\\D*告诉你：兰州渡口到达时间",
                     '', 'lanzhouClose')
    SetTriggerOption("chuanfu1", "group", "chuanfu")
    SetTriggerOption("chuanfu2", "group", "chuanfu")
    SetTriggerOption("chuanfu3", "group", "chuanfu")
    SetTriggerOption("chuanfu4", "group", "chuanfu")
    SetTriggerOption("chuanfu5", "group", "chuanfu")
    SetTriggerOption("chuanfu6", "group", "chuanfu")
    SetTriggerOption("chuanfu7", "group", "chuanfu")
    SetTriggerOption("chuanfu8", "group", "chuanfu")
    SetTriggerOption("chuanfu9", "group", "chuanfu")
    SetTriggerOption("chuanfu10", "group", "chuanfu")
    SetTriggerOption("chuanfu11", "group", "chuanfu")
    SetTriggerOption("chuanfu12", "group", "chuanfu")
    EnableTriggerGroup("chuanfu", true)
end
function sanjinOpen()
    -- 陕晋渡口开启->对应关系：黄河流域大渡口
    Chuanfu.ck_hhdk1 = 0
    Chuanfu.dkopen1 = os.clock()

    Chuanfu.sanjin.enable = true
    Chuanfu.sanjin.departTime = os.clock()
end
function sanjinClose()
    -- 陕晋渡口关闭->对应关系：黄河流域大渡口
    Chuanfu.sanjin.enable = false
    Chuanfu.sanjin.arriveTime = os.clock()
end
function huangheOpen()
    -- 黄河流域大渡口开启->对应关系：陕晋渡口
    Chuanfu.huanghe.enable = true
    Chuanfu.huanghe.departTime = os.clock()
end
function huangheClose()
    -- 黄河流域大渡口关闭->对应关系：陕晋渡口
    Chuanfu.huanghe.enable = false
    Chuanfu.huanghe.arriveTime = os.clock()
end
function xixiaOpen()
    -- 西夏渡口开启->对应关系：兰州渡口
    Chuanfu.xixia.enable = true
    Chuanfu.xixia.departTime = os.clock()
    Chuanfu.ck_hhdk3 = 0
    Chuanfu.dkopen3 = os.clock()
end
function xixiaClose()
    -- 西夏渡口关闭->对应关系：兰州渡口
    Chuanfu.xixia.enable = false
    Chuanfu.xixia.arriveTime = os.clock()
    Chuanfu.ck_hhdk3 = 1
    Chuanfu.dkclose3 = os.clock()
end
function lanzhouOpen()
    -- 兰州渡口开启->对应关系：西夏渡口
    Chuanfu.lanzhou.enable = true
    Chuanfu.lanzhou.departTime = os.clock()
    Chuanfu.ck_hhdk4 = 0
    Chuanfu.dkopen4 = os.clock()
end
function lanzhouClose()
    -- 兰州渡口关闭->对应关系：西夏渡口
    Chuanfu.lanzhou.enable = false
    Chuanfu.lanzhou.arriveTime = os.clock()
    Chuanfu.ck_hhdk4 = 1
    Chuanfu.dkclose4 = os.clock()
end


function Chuanfu:closeSanjin()
    map.rooms["changan/road2"].ways["#duHhe"] = nil
    map.rooms["changan/road3"].ways["#duHhe"] = nil
end

function Chuanfu:closeHuanghe()
    map.rooms["huanghe/road2"].ways["#duHhe"] = nil
    map.rooms["huanghe/road3"].ways["#duHhe"] = nil
end


function Chuanfu:openHuangHeArea()
    map.rooms["lanzhou/road3"].ways["#duHhe"]='lanzhou/road2'
    map.rooms["lanzhou/road2"].ways["#duHhe"]='lanzhou/road3'
    map.rooms["lanzhou/dukou3"].ways["#duHhe"]='lanzhou/dukou2'
    map.rooms["lanzhou/dukou2"].ways["#duHhe"]='lanzhou/dukou3'
    map.rooms["changan/road3"].ways["#duHhe"]='changan/road2'
    map.rooms["changan/road2"].ways["#duHhe"]='changan/road3'
    map.rooms["huanghe/road3"].ways["#duHhe"]='huanghe/road2'
    map.rooms["huanghe/road2"].ways["#duHhe"]='huanghe/road3'
   end

function Chuanfu:check_hh()
    Chuanfu:openHuangHeArea()
    
-- 陕晋渡口 changan/road2  changan/road3
-- 黄河流域大渡口 huanghe/road2 huanghe/road3
    if Chuanfu.sanjin.enable and Chuanfu.huanghe.enable then
        if Chuanfu.sanjin.departTime > Chuanfu.huanghe.departTime then
            Chuanfu:closeHuanghe()
        else
            Chuanfu:closeSanjin()
        end
    elseif Chuanfu.huanghe.enable then
        Chuanfu:closeSanjin()
    elseif Chuanfu.sanjin.enable then
        Chuanfu:closeHuanghe()
    else
        if Chuanfu.sanjin.arriveTime > Chuanfu.huanghe.arriveTime then
            Chuanfu:closeSanjin()
        else
            Chuanfu:closeHuanghe()
        end
    end
    return Chuanfu:checkXixiaLanzhou()
end

function Chuanfu:closeLanzhou()
    map.rooms["lanzhou/road2"].ways["#duHhe"] = nil
    map.rooms["lanzhou/road3"].ways["#duHhe"] = nil
end

function Chuanfu:closeXixia()
    map.rooms["lanzhou/dukou2"].ways["#duHhe"] = nil
    map.rooms["lanzhou/dukou3"].ways["#duHhe"] = nil
end


function Chuanfu:checkXixiaLanzhou()
-- 西夏渡口 lanzhou/dukou2 lanzhou/dukou3
-- 兰州渡口 lanzhou/road2 lanzhou/road3
    if Chuanfu.xixia.enable and Chuanfu.lanzhou.enable then
        if Chuanfu.xixia.departTime > Chuanfu.lanzhou.departTime then
            Chuanfu:closeLanzhou()
        else
            Chuanfu:closeXixia()
        end
    elseif Chuanfu.xixia.enable then
        Chuanfu:closeLanzhou()
    elseif Chuanfu.lanzhou.enable then
        Chuanfu:closeXixia()
    else
        if Chuanfu.xixia.arriveTime > Chuanfu.lanzhou.arriveTime then
            Chuanfu:closeXixia()
        else
            Chuanfu:closeLanzhou()
        end
    end
end

function changjiangOpen()
    Chuanfu.enable = true
    -- print('长江渡口开启')
    Chuanfu.changjiang.enable = true
    Chuanfu.changjiang.departTime = os.clock()
end
function changjiangClose()
    Chuanfu.enable = true
    -- print('长江渡口关闭')
    Chuanfu.changjiang.enable = false
    Chuanfu.changjiang.arriveTime = os.clock()
end
function lancangjiangOpen()
    -- print('澜沧江渡口开启')
    Chuanfu.lancangjiang.enable = true
    Chuanfu.lancangjiang.departTime = os.clock()
end
function lancangjiangClose()
    -- print('澜沧江渡口关闭')
    Chuanfu.lancangjiang.enable = false
    Chuanfu.lancangjiang.arriveTime = os.clock()
end

function Chuanfu:openAllareas()
    Chuanfu:openChangJiangArea()
    Chuanfu:openHuangHeArea()
end

function Chuanfu:openChangJiangArea()
    map.rooms["city/jiangbei"].ways["#duCjiang"] = 'city/jiangnan'
    map.rooms["city/jiangnan"].ways["#duCjiang"] = 'city/jiangbei'
    map.rooms["dali/dalisouth/jiangnan"].ways["#duCjiang"] =
        'dali/dalisouth/jiangbei'
    map.rooms["dali/dalisouth/jiangbei"].ways["#duCjiang"] =
        'dali/dalisouth/jiangnan'
end

function Chuanfu:closeChangJiang()
    map.rooms["city/jiangbei"].ways["#duCjiang"] = nil
    map.rooms["city/jiangnan"].ways["#duCjiang"] = nil
end

function Chuanfu:closeLanCangJiang()
    map.rooms["dali/dalisouth/jiangnan"].ways["#duCjiang"] = nil
    map.rooms["dali/dalisouth/jiangbei"].ways["#duCjiang"] = nil
end

function Chuanfu:check_cjn()
    Chuanfu:openChangJiangArea()
    if Chuanfu.changjiang.enable and Chuanfu.lancangjiang.enable then
        if Chuanfu.changjiang.departTime > Chuanfu.lancangjiang.departTime then
            Chuanfu:closeLanCangJiang()
        else
            Chuanfu:closeChangJiang()
        end
    elseif Chuanfu.changjiang.enable then
        Chuanfu:closeLanCangJiang()
    elseif Chuanfu.lancangjiang.enable then
        Chuanfu:closeChangJiang()
    else
        if Chuanfu.changjiang.arriveTime < Chuanfu.lancangjiang.arriveTime then
            Chuanfu:closeLanCangJiang()
        else
            Chuanfu:closeChangJiang()
        end
    end
end

function Chuanfu:closeLoclroom() -- 封闭渡江渡河路径
    if locl.room_relation == '西双版纳---澜沧江边澜沧江边' or
        locl.room_relation == '渡船∧西双版纳---澜沧江边澜沧江边' then
        map.rooms["dali/dalisouth/jiangnan"].ways["#duCjiang"] = nil
    elseif locl.room_relation == '澜沧江边---林间道澜沧江边' or
        locl.room_relation == '渡船∧澜沧江边---林间道澜沧江边' then
        map.rooms["dali/dalisouth/jiangbei"].ways["#duCjiang"] = nil
    elseif locl.room == '长江北岸' then
        map.rooms["city/jiangbei"].ways["#duCjiang"] = nil
        map.rooms["city/jiangbei"].ways["enter"] = nil
        map.rooms["city/jiangbei"].ways["west"] = nil
        map.rooms["city/jiangbei"].ways["east"] = nil
    elseif locl.room == '长江南岸' then
        map.rooms["city/jiangnan"].ways["#duCjiang"] = nil
    elseif locl.room_relation == '大道↖大渡口大渡口' or
        locl.room_relation == '大道黄河渡船↖∧大渡口大渡口' then
        map.rooms["lanzhou/road3"].ways["#duHhe"] = nil
    elseif locl.room_relation == '大渡口----大道大渡口' or
        locl.room_relation == '黄河渡船∧大渡口----大道大渡口' then
        map.rooms["lanzhou/road2"].ways["#duHhe"] = nil
    elseif locl.room_relation == '黄河↖西夏渡口西夏渡口' or
        locl.room_relation == '黄河黄河渡船↖∧西夏渡口西夏渡口' then
        map.rooms["lanzhou/dukou3"].ways["#duHhe"] = nil
    elseif locl.room_relation == '西夏渡口↘山脚下西夏渡口' or
        locl.room_relation ==
        '黄河渡船∧西夏渡口↘山脚下西夏渡口' then
        map.rooms["lanzhou/dukou2"].ways["#duHhe"] = nil
    elseif locl.room_relation == '大道｜陕晋渡口陕晋渡口' then
        map.rooms["changan/road3"].ways["#duHhe"] = nil
    elseif locl.room_relation ==
        '陕晋渡口｜↘土路黄土高原陕晋渡口' or locl.room_relation ==
        '渡船∧陕晋渡口｜↘土路黄土高原陕晋渡口' then
        map.rooms["changan/road2"].ways["#duHhe"] = nil
    elseif locl.room_relation == '官道｜大渡口大渡口' then
        map.rooms["huanghe/road3"].ways["#duHhe"] = nil
    elseif locl.room_relation == '大渡口｜黄河入海口大渡口' or
        locl.room_relation == '渡船∧大渡口｜黄河入海口大渡口' then
        map.rooms["huanghe/road2"].ways["#duHhe"] = nil
    end
end