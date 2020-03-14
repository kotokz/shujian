--------------检查锦盒-------------
jinheTrigger = function()
    DeleteTriggerGroup("jinheTrigger")
    create_trigger_t('jinheTrigger1',
                     "^>*\\s*你看了半天，也没有明白这盒子到底是怎么回事。",
                     '', 'jinhe_goon')
    create_trigger_t('jinheTrigger2',
                     "^>*\\s*盒子的夹层已经打开，你可以仔细看盒子（look jinhe）然后采取相应行动。",
                     '', 'jinhe_find')
    create_trigger_t('jinheTrigger3',
                     "^>*\\s*吾纵横江湖时曾在(\\D*)留下些许物事，待有缘人前去挖掘",
                     '', 'jinhe_get')
    SetTriggerOption("jinheTrigger1", "group", "jinheTrigger")
    SetTriggerOption("jinheTrigger2", "group", "jinheTrigger")
    SetTriggerOption("jinheTrigger3", "group", "jinheTrigger")
    EnableTriggerGroup("jinheTrigger", true)
    exe('jiancha jinhe')
end
jinhe_goon = function() exe('jiancha he') end
function jinhe_get(n, l, w)
    EnableTriggerGroup("jinheTrigger", false)
    DeleteTriggerGroup("jinheTrigger")
    wait.make(function()
        if w[1] == nil then
            Log:error('检查地点失败')
            return jinheOver()
        end
        local jinhe_location = tostring(w[1])
        local rooms = findAllRooms(jinhe_location)
        if #rooms < 1 then
            Log:error('锦盒房间不可到达或者找不到:' ..
                          jinhe_location)
            return jinheOver()
        end

        for _, room in pairs(rooms) do
            Log:info('前往' .. room .. '挖锦盒')
            await_go(room)
            local dig_count = 0
            while dig_count < 5 do
                exe('dig')
                local line, w = wait.regexp(
                                    '^>*\\s*你从铁盒子里拿出了(\\D*)。|^>*\\s*你挖了一阵，什么也没有找到',
                                    1)
                dig_count = dig_count + 1
                if line and line:find("你从铁盒子里") then
                    Log:info('锦盒：获得' .. w[1])
                    return jinheOver()
                end
            end
        end
        Log:error('遍历完全部房间,在' .. jinhe_location ..
                      '找到锦盒')
        return jinheOver()
    end)
end
jinhe_find = function() exe('look he') end

function jinheOver() Log:green('锦盒模块完成') end

