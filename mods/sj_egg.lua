function egg()
    DeleteTriggerGroup("egg")
    create_trigger_t('egg1', '金蛋\\(Gold', '', 'egg_find')
    create_trigger_t('egg2', '只听一声(\\D*)，金蛋', '', 'egg_continue')
    create_trigger_t('egg4', '你挥起\\D*对着金蛋砸下。$', '',
                     'egg_continue')
    create_trigger_t('egg3',
                     '你只见眼前金光一闪，增加了(\\D*)点江湖声望',
                     '', 'egg_finish')
    create_trigger_t('egg5',
                     '你挥起\\D*狠狠地对着金蛋砸下，结果金蛋却纹丝不动',
                     '', 'egg_day_finish')
    create_trigger_t('egg6', '^(> )*\\s*你要看什么？', '', 'egg_no_find')

    SetTriggerOption("egg1", "group", "egg")
    SetTriggerOption("egg2", "group", "egg")
    SetTriggerOption("egg3", "group", "egg")
    SetTriggerOption("egg4", "group", "egg")
    SetTriggerOption("egg5", "group", "egg")
    SetTriggerOption("egg6", "group", "egg")

    local l_result = utils.inputbox("金蛋的位置？", "金蛋位置",
                                    GetVariable("egg_location"), "宋体", "12")
    if not isNil(l_result) then SetVariable("egg_location", l_result) end
    egg_go(GetVariable("egg_location"))

end

function egg_go(where)
    EnableTriggerGroup("egg", true)
    local l_dest = {}
    sour.id = nil
    dest.id = nil
    tmp.go_to = true
    where = Trim(where)

    l_dest.area, l_dest.room = locateroom(where)
    if l_dest.area then
        exe('wield sword')
        return go(zaegg, l_dest.area, l_dest.room)
    else
        ColourNote("red", "blue",
                   "找不到或无法到达此(地点|人物)：" .. where)
        SetVariable('egg_location', 'no_find')
        return check_halt(check_food)
    end

end

function egg_finish(n, l, w)
    EnableTriggerGroup("egg", false)
    SetVariable('egg_location', 'no_find')
    messageShow('砸金蛋任务：完成！获得【' .. w[1] ..
                    '】点声望！', 'red')
    return check_halt(check_food)
end

function egg_no_find()
    EnableTriggerGroup("egg", false)
    SetVariable('egg_location', 'no_find')
    return check_halt(check_food)
end

function egg_day_finish()
    EnableTriggerGroup("egg", false)
    SetVariable('egg_location', 'no_find')
    messageShow('砸金蛋任务：今天已经完成砸10次金蛋!', 'red')
    return check_halt(check_food)
end

function zaegg() exe('look egg;za egg') end

function egg_find()
    messageShow('砸金蛋任务：开始砸金蛋!', 'red')
    check_halt(zaegg)
end

function egg_continue() check_halt(zaegg) end
