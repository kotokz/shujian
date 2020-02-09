function egg_go()
    DeleteTriggerGroup("egg")
    create_trigger_t('egg1',
                     "^(> )*你只见眼前金光一闪，增加了(\\D+)点江湖声望。$",
                     '', 'egg_over')
    SetTriggerOption("egg1", "group", "egg")
    for p in pairs(egg_loc) do
        if p then
            egg_loc[p] = nil
            return go(egg_za, p)
        end
    end
end
function egg_za()
    wait.make(function()
        local l_tmp = ''
        repeat
            wield_recover()
            exe('za egg')
            _, w = wait.regexp(
                       "^(> )*(你正忙着呢。|什么?\\D*|你挥起\\D+狠狠地对着金蛋砸下，结果金蛋却纹丝不动。|你挥起\\D+狠狠地对着金蛋砸下。)$",
                       1)
            if w then l_tmp = w[2] end
            if l_tmp then
                if string.find(l_tmp, '什么') then
                    return egg_finish()
                elseif string.find(l_tmp, '纹丝不动') then
                    egg_loc = nil
                    DeleteTrigger('hp711')
                    return egg_finish()
                end
            end
        until 1 == 0
    end)
end
function egg_over(n, l, w)
    local l_shengwang = trans(w[2])
    messageShow("---------------------------砸金蛋成功，获得声望" ..
                    l_shengwang .. "点！--------------------------", "blue",
                "yellow")
end
function egg_finish()
    DeleteTriggerGroup("egg")
    return checkPrepare()
end

function egg_huodong()
    egg_loc = {}
    DeleteTrigger('hp711')
    create_trigger_t('hp711', "^  金蛋\\(Gold egg\\)$", '', 'egg_location')
    SetTriggerOption("hp711", "group", "hp")
end
function egg_location() if road.id then egg_loc[road.id] = true end end
