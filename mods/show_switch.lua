require "movewindow" -- load the movewindow.lua module
misc_skills = {
    ['buddhism'] = true,
    ['taoism'] = true,
    ['qimen-bagua'] = true,
    ['literate'] = true,
    ['trade'] = true,
    ['medicine'] = true,
    ['liumai-shenjian'] = true,
    ['poison'] = true,
    ['beauty'] = true,
    ['zhengqi-jue'] = true,
    ['flute'] = true,
    ['art'] = true,
    ['begging'] = true,
    ['checking'] = true,
    ['stealing'] = true,
    ['duanzao'] = true,
    ['bangjue'] = true,
    ['huanxi-chan'] = true,
    ['betting'] = true,
    ['dacheng-fofa'] = true,
    ['daode-jing'] = true,
    ['murong-xinfa'] = true,
    ['shenlong-yaoli'] = true,
    ['zhengqi-jue'] = true
}
basic_skills = {
    ['force'] = true,
    ['finger'] = true,
    ['parry'] = true,
    ['dodge'] = true,
    ['strike'] = true,
    ['blade'] = true,
    ['cuff'] = true,
    ['claw'] = true,
    ['hand'] = true,
    ['leg'] = true,
    ['whip'] = true,
    ['club'] = true,
    ['sword'] = true,
    ['hammer'] = true,
    ['dagger'] = true,
    ['brush'] = true,
    ['throwing'] = true,
    ['staff'] = true,
    ['hook'] = true,
    ['axe'] = true,
    ['spear'] = true,
    ['stick'] = true,
    ['unarmed'] = true
}

function button_smyteam()
    win2 = "show_message_btn2"
    WindowCreate(win2, 0, 0, 140, 280, 6, 16, ColourNameToRGB("black"))
    -- movewindow.add_drag_handler (win2, 0, 0,140,20)
    local _mousedown_smy = mousedown_smy()
    _G["at_mousedown_smy"] = _mousedown_smy
    WindowAddHotspot(win2, "btn_smyteam", 0, 0, 140, 20, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_smy", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "������ӣ��Ҽ�����", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_smy2 = mousedown_smy2()
    _G["at_mousedown_smy2"] = _mousedown_smy2
    WindowAddHotspot(win2, "btn_smyteam2", 0, 20, 140, 40, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_smy2", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "������ӣ��Ҽ�����", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown = mousedown()
    _G["at_mousedown"] = _mousedown
    WindowAddHotspot(win2, "btn_wdj", 0, 40, 140, 60, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags

    local _mousedown_ll = mousedown_ll()
    _G["at_mousedown_ll"] = _mousedown_ll
    WindowAddHotspot(win2, "btn_ll", 0, 60, 140, 80, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_ll", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_kdummy = mousedown_kdummy()
    _G["at_mousedown_kdummy"] = _mousedown_kdummy
    WindowAddHotspot(win2, "btn_kdummy", 0, 80, 140, 100, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_kdummy", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_ypt_lian = mousedown_ypt_lian()
    _G["at_mousedown_ypt_lian"] = _mousedown_ypt_lian
    WindowAddHotspot(win2, "btn_ypt_lian", 0, 100, 140, 120, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_ypt_lian", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_taoyuan = mousedown_taoyuan()
    _G["at_mousedown_taoyuan"] = _mousedown_taoyuan
    WindowAddHotspot(win2, "btn_taoyuan", 0, 120, 140, 140, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_taoyuan", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_waitkill = mousedown_waitkill()
    _G["at_mousedown_waitkill"] = _mousedown_waitkill
    WindowAddHotspot(win2, "btn_waitkill", 0, 140, 140, 160, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_waitkill", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_dohs = mousedown_dohs()
    _G["at_mousedown_dohs"] = _mousedown_dohs
    WindowAddHotspot(win2, "btn_dohs", 0, 160, 140, 180, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_dohs", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_newbie = mousedown_newbie()
    _G["at_mousedown_newbie"] = _mousedown_newbie
    WindowAddHotspot(win2, "btn_newbie", 0, 180, 140, 200, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_newbie", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_go_on_smy = mousedown_go_on_smy()
    _G["at_mousedown_go_on_smy"] = _mousedown_go_on_smy
    WindowAddHotspot(win2, "btn_go_on_smy", 0, 200, 140, 220, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_go_on_smy", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags
    local _mousedown_ebook = mousedown_ebook()
    _G["at_mousedown_ebook"] = _mousedown_ebook
    WindowAddHotspot(win2, "btn_ebook", 0, 220, 140, 240, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_ebook", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags

    local _mousedown_pkheqi = mousedown_pkheqi()
    _G["at_mousedown_pkheqi"] = _mousedown_pkheqi
    WindowAddHotspot(win2, "btn_pkheqi", 0, 240, 140, 260, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_pkheqi", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "����������", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags

    local switch_name = ""

    switch_name = "��Ħ��ս��" .. smyteam .. "��"

    switch_name2 = "��Ħ�¿���" .. smyall .. "��"

    if inwdj == 1 then
        switch_name3 = "�嶾�̵�ͼ--��"
    else
        switch_name3 = "�嶾�̵�ͼ--��"
    end
    if needdolost == 1 then
        switch_name4 = "ʧ����ż�--��"
    else
        switch_name4 = "ʧ����ż�--��"
    end
    if kdummy == 1 then
        switch_name5 = "ɱ���׹���--��"
    else
        switch_name5 = "ɱ���׹���--��"
    end
    if needxuexi == 1 then
        switch_name6 = "������--��"
    else
        switch_name6 = "������--��"
    end
    if intaoyuan == 1 then
        switch_name7 = "��԰�ص�ͼ--��"
    else
        switch_name7 = "��԰�ص�ͼ--��"
    end
    if wait_kill == 'no' then
        switch_name8 = "���ŵ�ɱ��--��"
    else
        switch_name8 = "���ŵ�ɱ��--��"
    end
    if dohs2 == 0 then
        switch_name9 = "��ɽ�����--��"
    else
        switch_name9 = "��ɽ�����--��"
    end
    if newbie == 0 then
        switch_name10 = "����������-��"
    else
        switch_name10 = "����������-��"
    end
    if go_on_smy == 1 then
        switch_name11 = "��������Ħ��-��"
    else
        switch_name11 = "��������Ħ��-��"
    end
    if doubleexp == 1 then
        switch_name12 = "��Ħ��˫�����鿪��"
    else
        switch_name12 = "��Ħ��˫������ر�"
    end
    if pkheqi == 1 then
        switch_name13 = "PK�����-��"
    else
        switch_name13 = "PK�����-��"
    end

    WindowFont(win2, "f", "������", 10, true, false, false, false)

    WindowText(win2, "f", switch_name, 0, 0, 140, 20, ColourNameToRGB("gold"),
               false) -- not Unicode

    WindowText(win2, "f", switch_name2, 0, 20, 140, 40, ColourNameToRGB("gold"),
               false) -- not Unicode

    WindowText(win2, "f", switch_name3, 0, 40, 140, 60, ColourNameToRGB("gold"),
               false) -- not Unicode

    WindowText(win2, "f", switch_name4, 0, 60, 140, 80, ColourNameToRGB("gold"),
               false) -- not Unicode

    WindowText(win2, "f", switch_name5, 0, 80, 140, 100,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name6, 0, 100, 140, 120,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name7, 0, 120, 140, 140,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name8, 0, 140, 140, 160,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name9, 0, 160, 140, 180,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name10, 0, 180, 140, 200,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name11, 0, 200, 140, 220,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name12, 0, 220, 140, 240,
               ColourNameToRGB("gold"), false) -- not Unicode

    WindowText(win2, "f", switch_name13, 0, 240, 140, 260,
               ColourNameToRGB("red"), false) -- not Unicode

    WindowShow(win2, true) -- show it

end
function mousedown_smy2()
    return function(flags, hotspot_id)

        if hotspot_id == 'btn_smyteam2' then

            if flags == 16 then

                smyall = smyall + 1
                switch_name2 = "��Ħ�¿���" .. smyall .. "��"

            end
            if flags == 32 then
                if smyall >= 1 then smyall = smyall - 1 end
                switch_name2 = "��Ħ�¿���" .. smyall .. "��"
            end
            -- text add

            WindowRectOp(win2, miniwin.rect_fill, 0, 20, 140, 40,
                         ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
            WindowFont(win2, "f", "����", 10, true, false, false, false)
            WindowText(win2, "f", switch_name2, 0, 20, 140, 40,
                       ColourNameToRGB("gold"), false) -- not Unicode
            WindowShow(win2, true) -- show it
        end

    end
end

function mousedown_smy()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        -- ��Ħ��
        if hotspot_id == 'btn_smyteam' then

            if flags == 16 then

                smyteam = smyteam + 1
                switch_name = "��Ħ��ս��" .. smyteam .. "��"

            end
            if flags == 32 then
                if smyteam > 4 then smyteam = smyteam - 1 end
                switch_name = "��Ħ��ս��" .. smyteam .. "��"
            end
            -- text add

            -- WindowCircleOp (win, miniwin.circle_round_rectangle , 0, 0, 120, 20, 0x909090, 0, 1,0, 0, 9, 9)
            WindowRectOp(win2, miniwin.rect_fill, 0, 0, 140, 20,
                         ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
            WindowFont(win2, "f", "������", 10, true, false, false, false)
            WindowText(win2, "f", switch_name, 0, 0, 140, 20,
                       ColourNameToRGB("gold"), false) -- not Unicode
            WindowShow(win2, true) -- show it
        end
    end
end

function mousedown()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)
        -- �嶾��
        if hotspot_id == 'btn_wdj' then
            if inwdj == 1 then
                inwdj = 0
            else
                inwdj = 1
            end
            if flags == 16 then

                if inwdj == 1 then

                    switch_name3 = "�嶾�̵�ͼ--��"
                    Note('ȥ�嶾�̣�')
                else

                    switch_name3 = "�嶾�̵�ͼ--��"
                    Note('��ȥ�嶾�̣�')
                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 40, 140, 60,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name3, 0, 40, 140, 60,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_ll()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        if hotspot_id == 'btn_ll' then
            if needdolost == 1 then
                needdolost = 0
                print('�ر���LL')
            else
                exe('cond;jobtimes')
                dolostletter()
            end
            if flags == 16 then

                if needdolost == 1 then

                    switch_name4 = "ʧ����ż�--��"

                else

                    switch_name4 = "ʧ����ż�--��"

                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 60, 140, 80,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name4, 0, 60, 140, 80,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end

function mousedown_kdummy()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        if hotspot_id == 'btn_kdummy' then
            if kdummy == 1 then
                kdummy = 0
                closedummy()
            else
                kdummy = 1
                opendummy()
            end
            if flags == 16 then

                if kdummy == 1 then

                    switch_name5 = "ɱ���׹���--��"

                else

                    switch_name5 = "ɱ���׹���--��"

                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 80, 140, 100,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name5, 0, 80, 140, 100,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_waitkill()
    return function(flags, hotspot_id)

        if hotspot_id == 'btn_waitkill' then
            if wait_kill == 'no' then
                wait_kill = 'yes'
            else
                wait_kill = 'no'
            end
            if flags == 16 then

                if wait_kill == 'yes' then

                    switch_name8 = "���ŵ�ɱ��--��"

                else

                    switch_name8 = "���ŵ�ɱ��--��"

                end

                WindowRectOp(win2, miniwin.rect_fill, 0, 140, 140, 160,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name8, 0, 140, 140, 160,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_newbie()
    return function(flags, hotspot_id)

        if hotspot_id == 'btn_newbie' then
            if newbie == 0 then
                newbie = 1
            else
                newbie = 0
            end
            if flags == 16 then

                if newbie == 1 then

                    switch_name10 = "����������-��"
                    Note("I am a Newbie")

                else

                    switch_name10 = "����������-��"
                    Note("I Not Newbie")

                end

                WindowRectOp(win2, miniwin.rect_fill, 0, 180, 140, 200,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name10, 0, 180, 140, 200,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_dohs()
    return function(flags, hotspot_id)

        if hotspot_id == 'btn_dohs' then
            if dohs2 == 0 then
                dohs2 = 1
            else
                dohs2 = 0
            end
            if flags == 16 then

                if dohs2 == 1 then

                    switch_name9 = "��ɽ�����--��"

                else

                    switch_name9 = "��ɽ�����--��"

                end

                WindowRectOp(win2, miniwin.rect_fill, 0, 160, 140, 180,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name9, 0, 160, 140, 180,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_ypt_lian()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        if hotspot_id == 'btn_ypt_lian' then
            if needxuexi == 1 then
                needxuexi = 0
            else
                needxuexi = 1
            end
            if flags == 16 then

                if needxuexi == 1 then

                    switch_name6 = "������--��"

                else

                    switch_name6 = "������--��"

                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 100, 140, 120,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name6, 0, 100, 140, 120,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_taoyuan()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        if hotspot_id == 'btn_taoyuan' then
            if intaoyuan == 1 then
                intaoyuan = 0
                map.rooms["dali/yideng/pubu"].ways["#yuRen"] = nil -- ��԰�ص�ͼ���뿪��
            else
                intaoyuan = 1
                map.rooms["dali/yideng/pubu"].ways["#yuRen"] =
                    "dali/yideng/shandong" -- ��԰�ص�ͼ���뿪��
            end
            if flags == 16 then

                if intaoyuan == 1 then

                    switch_name7 = "��԰�ص�ͼ--��"

                else

                    switch_name7 = "��Դ�ص�ͼ--��"

                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 120, 140, 140,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name7, 0, 120, 140, 140,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_ebook()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        if hotspot_id == 'btn_ebook' then
            if doubleexp == 1 then
                doubleexp = 0
            else
                doubleexp = 1
            end
            if flags == 16 then

                if doubleexp == 1 then

                    switch_name12 = "��Ħ��˫�����鿪��"
                    Note("����˫������")

                else

                    switch_name12 = "��Ħ��˫������ر�"
                    Note("�ر�˫������")

                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 220, 140, 240,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name12, 0, 220, 140, 240,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_pkheqi() -- �޷���20181218���ӱ�����pkheqi���أ�����pk�Ƿ�������
    return function(flags, hotspot_id)
        if hotspot_id == 'btn_pkheqi' then
            if pkheqi == 0 then
                pkheqi = 1
            else
                pkheqi = 0
            end
            if flags == 16 then

                if pkheqi == 1 then
                    switch_name13 = "PK�����-��"
                    print("PK�����-��")
                    Note("����Ҫ�ô���ɱ���ˣ�")
                else
                    switch_name13 = "PK�����-��"
                    print("PK�����-��")
                    Note("����Ҫ��С��������Ѫ��")
                end

                WindowRectOp(win2, miniwin.rect_fill, 0, 240, 140, 260,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name13, 0, 240, 140, 260,
                           ColourNameToRGB("red"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end
function mousedown_go_on_smy() -- 20161117���ӱ���go_on_smy���ؿ��� ��ֹϵͳ�������Զ�����Ħ��
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        if hotspot_id == 'btn_go_on_smy' then
            if go_on_smy == 1 then
                go_on_smy = 0
            else
                go_on_smy = 1

            end
            if flags == 16 then

                if go_on_smy == 1 then

                    switch_name11 = "��������Ħ��-��"

                else

                    switch_name11 = "��������Ħ��-��"

                end
                -- text add

                WindowRectOp(win2, miniwin.rect_fill, 0, 200, 140, 220,
                             ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
                WindowFont(win2, "f", "������", 10, true, false, false, false)
                WindowText(win2, "f", switch_name11, 0, 200, 140, 220,
                           ColourNameToRGB("gold"), false) -- not Unicode
                WindowShow(win2, true) -- show it
            end
        end
    end
end

function button_lostletter()

    win3 = "show_message_btn3"
    WindowCreate(win3, 0, 0, 300, 20, 7, 16, ColourNameToRGB("black"))

    local _mousedown_lostletter = mousedown_lostletter()
    _G["at_mousedown_lostletter"] = _mousedown_lostletter
    WindowAddHotspot(win3, "btn_lostletter", 0, 0, 300, 20, -- rectangle
    "", -- MouseOver
    "", -- CancelMouseOver
    "at_mousedown_lostletter", -- MouseDown
    "", -- CancelMouseDown
    "", -- MouseUp
    "������ţ��Ҽ�ȥ�ص�", -- tooltip text
    cursor or 1, -- cursor
    0) -- flags

    local switch_name = ""

    switch_name = "ʧ����ż�ص㣺" .. lostletter_locate

    WindowFont(win3, "f", "������", 10, true, false, false, false)

    WindowText(win3, "f", switch_name, 0, 0, 300, 20, ColourNameToRGB("gold"),
               false) -- not Unicode

    WindowShow(win3, true) -- show it

end
function mousedown_lostletter()
    return function(flags, hotspot_id)
        -- print("hotspot_id="..hotspot_id)
        -- print("flags="..flags)

        -- ��Ħ��
        local wherell = ""
        if hotspot_id == 'btn_lostletter' then

            if flags == 16 then exe('look lose letter') end
            if flags == 32 then return goll() end
            if flags == 96 then return goll_always() end -- text add

            -- WindowCircleOp (win, miniwin.circle_round_rectangle , 0, 0, 120, 20, 0x909090, 0, 1,0, 0, 9, 9)
            WindowRectOp(win3, miniwin.rect_fill, 0, 0, 300, 20,
                         ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
            WindowFont(win3, "f", "������", 10, true, false, false, false)
            WindowText(win3, "f",
                       "ʧ����ż�ص㣺" .. lostletter_locate, 0, 0,
                       300, 20, ColourNameToRGB("gold"), false) -- not Unicode
            WindowShow(win3, true) -- show it
        end
    end
end
get_lost_locate = function(n, l, w)
    lostletter_locate = Trim(w[1])
    lostletter_locate = addrTrim(lostletter_locate)
    ll.room, ll.area = getAddr(lostletter_locate)

    -- ����ˢ�µص�
    WindowRectOp(win3, miniwin.rect_fill, 0, 0, 300, 20,
                 ColourNameToRGB("black")) -- raised, filled, softer, flat 0x909090
    WindowFont(win3, "f", "������", 10, true, false, false, false)
    WindowText(win3, "f", "ʧ����ż�ص㣺" .. lostletter_locate, 0, 0,
               300, 20, ColourNameToRGB("gold"), false) -- not Unicode
    WindowShow(win3, true) -- show it

end
function goll()
    if not getAddr(lostletter_locate) then
        ColourNote("gold", "black", "�����޷���������¿���!")
        return
    else
        messageShow('ʧ����ż�����ǰ����' .. lostletter_locate ..
                        '����ʼѰ����ң�')

        dest.rooms = getRooms(ll.room, ll.area) -- ��ȡ������ڵصķ���

        if table.getn(dest.rooms) == 0 then

            ColourNote("gold", "black", "�����޷���������¿���!")

            return -- ��ȡ������ڵط���������¿���

        end

        if string.find(jiangnan_area, ll.area) then
            return go_to('��������')
        end
        if string.find(cjn_area, ll.room) then
            return go_to('��������')
        end
        if string.find(ll.area, '������') then
            return go_to('�ƺ��뺣��')
        end
        if string.find(ll.area, '����') or string.find(ll.area, '�ؽ�') or
            string.find(ll.area, '��ɽ') or string.find(ll.area, '����') or
            string.find(ll.area, '���ԭ') or string.find(ll.area, '����') or
            string.find(ll.area, '����') then
            return go_to('���ݴ�ɿ�')
        end
        if string.find(ll.area, '����') or string.find(ll.area, '����') then
            return go_to('�ƺ������ɿ�')
        end
        if string.find(ll.area, '��ɽ') or string.find(ll.area, '��ľ��') or
            string.find(ll.area, 'ƽ����') then
            return go_to('�½��ɿ�')
        end
        if string.find(ll.area, '��Դ��') then
            return go_to('��Դ��é��')
        end
        if string.find(ll.area, '�����') then
            return go_to('�����СϪ��')
        end
        if string.find(ll.area, '���ݳ�') then
            return go_to(lostletter_locate)
        end
        if string.find(zhongyuan_area, ll.area) then
            return go_to(lostletter_locate)
        end
    end
end

function goll_always()
    if not getAddr(lostletter_locate) then
        ColourNote("gold", "black", "�����޷���������¿���!")
        return
    else
        messageShow('ʧ����ż����񣺿�ʼǰ����' ..
                        lostletter_locate .. '��Ѱ����ң�')

        dest.rooms = getRooms(ll.room, ll.area) -- ��ȡ������ڵصķ���

        if table.getn(dest.rooms) == 0 then

            ColourNote("gold", "black", "�����޷���������¿���!")

            return -- ��ȡ������ڵط���������¿���

        end

        return go_to(lostletter_locate)

    end
end

----------miniwindows ģ��------------
FONT_NAME1 = "����"
FONT_NAME2 = "Webdings"
FONT_NAME3 = "Lucida Console"
FONT_SIZE_11 = 11
FONT_SIZE_12 = 9
EDGE_WIDTH = 3
WINDOW_POSITION = 8
WINDOW_BACKGROUND_COLOUR = ColourNameToRGB("white")
BOX_COLOUR = ColourNameToRGB("royalblue") -- Box boarder's colour
WINDOW_TEXT_COLOUR = ColourNameToRGB("black")
TEXT_INSET = 5
win_skills = "skills" .. GetPluginID()
windowinfo_skills = movewindow.install(win_skills, miniwin.pos_top_cente, 0)
win_skills_show = 1
flag_win_skills = 1
win_bag = "bag" .. GetPluginID()
windowinfo_bag = movewindow.install(win_bag, miniwin.pos_top_cente, 0)
win_bag_show = 1
flag_win_bag = 1
win_beinang = "beinang" .. GetPluginID()
windowinfo_beinang =
    movewindow.install(win_beinang, miniwin.pos_bottom_right, 0)
win_beinang_show = 1
flag_win_beinang = 1
win_status = "status" .. GetPluginID()
windowinfo_status = movewindow.install(win_status, miniwin.pos_top_cente, 0)
win_status_show = 1
flag_win_status = 1
function mouseup(flags, hotspotid)
    --  print(hotspotid)
    if hotspotid and hotspotid == 'skills' then
        win_skills_show = 1 - win_skills_show
        draw_skillswindow()
    end
    if hotspotid and hotspotid == 'bag' then
        win_bag_show = 1 - win_bag_show
        draw_bagwindow()
    end
    if hotspotid and hotspotid == 'beinang' then
        win_beinang_show = 1 - win_beinang_show
        draw_beinangwindow()
    end
end
function show_skills(n, l, w)
    if w[2] ~= '��' then EnableTrigger("hp7", false) end
    wait.make(function()
        wait.time(2)
        EnableTrigger("hp7", true)
        draw_skillswindow()
    end)
end
function draw_statuswindow()

    if not flag_win_status or flag_win_status ~= 1 then
        if win_skills then WindowShow(win_status, false) end
        return
    end
    local _basic = {}
    local _status_ch = {}

    WINDOW_HEIGHT = 180 -- ÿ����һ�� ��15
    WINDOW_WIDTH = 430

    WindowCreate(win_status, windowinfo_status.window_left,
                 windowinfo_status.window_top, WINDOW_WIDTH, WINDOW_HEIGHT,
                 windowinfo_status.window_mode, windowinfo_status.window_flags,
                 0x000010)

    WindowFont(win_status, "f1", FONT_NAME1, FONT_SIZE_12)
    WindowFont(win_status, "f2", FONT_NAME2, FONT_SIZE_11)
    WindowFont(win_status, "f3", FONT_NAME1, FONT_SIZE_12, true)
    WindowFont(win_status, "f4", FONT_NAME3, FONT_SIZE_11, true)
    WindowFont(win_status, "f5", FONT_NAME1, FONT_SIZE_11)

    font_height = WindowFontInfo(win_status, "f1", 1)

    movewindow.save_state(win_status)

    WindowCircleOp(win_status, miniwin.circle_round_rectangle, 0, 2,
                   WINDOW_WIDTH - 2, WINDOW_HEIGHT, 0xc0c0c0, 0, 1, 0, 0, 9, 9)

    local head_width = (WINDOW_WIDTH -
                           WindowTextWidth(win_status, "f1", "״̬��Ϣ")) /
                           2

    if win_status_show == 0 then
        WindowAddHotspot(win_status, "status", 0, 0, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", -- mousedown
        "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_status, "f5", "״̬��Ϣ", -- text
        5, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode

    else
        WindowLine(win_status, 0, font_height + 15, WINDOW_WIDTH - 2,
                   font_height + 15, 0xc0c0c0, 0, 1)
        movewindow.add_drag_handler(win_status, 0, 0, 0, font_height + 15,
                                    miniwin.cursor_hand)
        WindowAddHotspot(win_status, "status", 0, font_height + 15, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", -- mousedown
        "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_status, "f5", "״̬��Ϣ", -- text
        head_width, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false)

    end

    local qi = "��Ѫ:"
    if hp.qixue_max ~= nil and hp.qixue ~= nil then
        local qixue = hp.qixue or 10
        local maxqi = hp.qixue_max or 10

        local hurtq = hp.qixue_per or 100

        local hurtqi = qixue * hurtq / maxqi

        local rq = math.floor(hurtqi / 10) or 5

        if hurtqi > 95 then
            qi = "��Ѫ:" .. string.rep("��", 10) .. qixue .. '/' .. maxqi
        elseif hurtqi > 49 then
            qi = "��Ѫ:" .. string.rep("��", rq) .. "" ..
                     string.rep("��", 10 - rq) .. qixue .. '/' .. maxqi
        elseif hurtqi > 9 then
            qi = "��Ѫ:" .. string.rep("��", rq) .. "" ..
                     string.rep("��", 10 - rq) .. qixue .. '/' .. maxqi
        else
            qi =
                "��Ѫ:" .. string.rep("��", 1) .. "" .. string.rep("��", 9) ..
                    qixue .. '/' .. maxqi
        end
    end

    local jing = "��Ѫ:"
    if hp.jingxue_max ~= nil and hp.jingxue ~= nil then
        local jingxue = hp.jingxue or 10
        local maxjing = hp.jingxue_max or 10
        local hurtj = hp.jingxue_per or 100

        local hurtjing = jingxue * hurtj / maxjing
        local rj = math.floor(hurtj / 10) or 5

        if hurtj > 95 then
            jing = "��Ѫ:" .. string.rep("��", 10) .. jingxue .. '/' ..
                       maxjing
        elseif hurtj > 49 then
            jing = "��Ѫ:" .. string.rep("��", rj) .. "" ..
                       string.rep("��", 10 - rj) .. jingxue .. '/' .. maxjing
        elseif hurtj > 9 then
            jing = "��Ѫ:" .. string.rep("��", rj) .. "" ..
                       string.rep("��", 10 - rj) .. jingxue .. '/' .. maxjing
        else
            jing = "��Ѫ:" .. string.rep("��", 1) .. "" ..
                       string.rep("��", 9) .. jingxue .. '/' .. maxjing
        end

    end
    local nl = "����:"
    if hp.neili_max ~= nil and hp.neili ~= nil then
        local neili = hp.neili or 100
        local maxneili = hp.neili_max or 100
        local hurtneili = neili * 100 / maxneili

        local rn = math.floor(hurtneili / 10) or 5

        if hurtneili > 95 then
            nl = "����:" .. string.rep("��", 10) .. neili .. '/' .. maxneili
        elseif hurtneili > 49 then
            nl = "����:" .. string.rep("��", rn) .. "" ..
                     string.rep("��", 10 - rn) .. neili .. '/' .. maxneili
        elseif hurtneili > 9 then
            nl = "����:" .. string.rep("��", rn) .. "" ..
                     string.rep("��", 10 - rn) .. neili .. '/' .. maxneili
        else
            nl =
                "����:" .. string.rep("��", 1) .. "" .. string.rep("��", 9) ..
                    neili .. '/' .. maxneili
        end

    end
    local jl = "����:"
    if hp.jingli_max ~= nil and hp.jingli ~= nil then

        local jingli = hp.jingli or 100
        local maxjingli = hp.jingli_max or 100
        local hurtjingli = jingli * 100 / maxjingli

        local rjl = math.floor(hurtjingli / 10) or 5

        if hurtjingli > 95 then
            jl = "����:" .. string.rep("��", 10) .. jingli .. '/' ..
                     maxjingli
        elseif hurtjingli > 49 then
            jl = "����:" .. string.rep("��", rjl) .. "" ..
                     string.rep("��", 10 - rjl) .. jingli .. '/' .. maxjingli
        elseif hurtjingli > 9 then
            jl = "����:" .. string.rep("��", rjl) .. "" ..
                     string.rep("��", 10 - rjl) .. jingli .. '/' .. maxjingli
        else
            jl =
                "����:" .. string.rep("��", 1) .. "" .. string.rep("��", 9) ..
                    jingli .. '/' .. maxjingli
        end
    end
    WindowText(win_status, "f1", qi, 5, 30, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)
    WindowText(win_status, "f1", jing, 5, 45, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)
    WindowText(win_status, "f1", nl, 220, 30, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    WindowText(win_status, "f1", jl, 220, 45, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local mygold = "���:"

    if score.gold ~= nil then mygold = "���:" .. score.gold end

    WindowText(win_status, "f1", mygold, 220, 60, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local shicheng = "ʦ��:"
    if score.party ~= nil then
        shicheng = "ʦ��:" .. score.party .. "" .. score.master
    end

    WindowText(win_status, "f1", shicheng, 5, 75, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)
    local lixiang = "����:"

    if score.xiangyun ~= nil then lixiang = "����:" .. score.xiangyun end

    WindowText(win_status, "f1", lixiang, 220, 75, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local xm = "����:"
    if score.name ~= nil then
        xm = "����:" .. score.name .. "(" .. score.id .. ")"
    end
    WindowText(win_status, "f1", xm, 5, 60, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local sw = "����:" .. score.sw
    if score.sw ~= nil then sw = "����:" .. score.sw end
    WindowText(win_status, "f1", sw, 5, 90, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local expp = "����:" .. hp.exp
    if hp.exp ~= nil then expp = "����:" .. hp.exp end

    WindowText(win_status, "f1", expp, 220, 90, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local tbb = "ͨ��:" .. score.tb
    if score.tb ~= nil then tbb = "ͨ��:" .. score.tb end
    WindowText(win_status, "f1", tbb, 5, 105, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local ybb = "Ԫ��:"
    if score.yb ~= nil then ybb = "Ԫ��:" .. score.yb end
    WindowText(win_status, "f1", ybb, 220, 105, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local jjbb = "������:"
    if score.jjb ~= nil then jjbb = "������:" .. score.jjb end
    WindowText(win_status, "f1", jjbb, 5, 120, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local vip = "��Ա:"
    if score.vip_level ~= nil then vip = "��Ա:" .. score.vip_level end
    WindowText(win_status, "f1", vip, 105, 120, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local djjj = "�ȼ�:" .. score.dj
    if score.dj ~= nil then djjj = "�ȼ�:" .. score.dj end
    WindowText(win_status, "f1", djjj, 220, 120, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local swww = "����:"
    if score.sww ~= nil then swww = "����:" .. score.sww end
    WindowText(win_status, "f1", swww, 5, 135, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local eff = "Ч��:"
    if job.expAvg ~= nil then eff = "Ч��:" .. job.expAvg end
    WindowText(win_status, "f1", eff, 105, 135, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local dzzz = "����:" .. score.dz
    if score.dj ~= nil then dzzz = "����:" .. score.dz end
    WindowText(win_status, "f1", dzzz, 220, 135, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    local zt = "״̬:"
    if score.zt ~= nil then zt = "״̬:" .. score.zt end
    WindowText(win_status, "f1", zt, 5, 150, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)
    local loc = "��λ:"
    if score.loc ~= nil then loc = "��λ:" .. score.loc end
    WindowText(win_status, "f1", loc, 5, 165, 0, 0, -- rectangle
    ColourNameToRGB("cyan"), -- colour
    false)

    if flag_win_status and flag_win_status == 1 then
        WindowShow(win_status, true)
    else
        WindowShow(win_status, false)
    end
end
function draw_skillswindow()
    if not flag_win_skills or flag_win_skills ~= 1 then
        if win_skills then WindowShow(win_skills, false) end
        return
    end
    if not skills then return end
    local _basic = {} -- local _basic ={}
    local _skills_ch = {}
    local _skills_lev = {}
    local _skills_pot = {}
    --[[	for k,v in pairs (skills) do--modman ԭ����skills�����ڷ������
		if misc_skills[k] then
			table.insert(_basic,k)
		end
	end
	for k,v in pairs (skills) do--modman ԭ����skills�����ڷ������
		if basic_skills[k] then
			table.insert(_basic,k)
		end
	end
	for k,v in pairs (skills) do--modman ԭ����skills�����ڷ������
		if not misc_skills[k] and not basic_skills[k] then
			table.insert(_basic,k)
		end
	end]]
    my_misc_skills = {} -- modman ��skills���������
    my_basic_skills = {}
    my_special_skills = {}
    for k, v in pairs(skills) do -- modman���ӷ���
        if not misc_skills[k] and not basic_skills[k] then
            table.insert(my_special_skills, v)
        elseif basic_skills[k] then
            table.insert(my_basic_skills, v)
        elseif misc_skills[k] then
            table.insert(my_misc_skills, v)
        end
    end
    for k, v in pairs(my_misc_skills) do -- modman ԭ����skills�����ڷ������
        table.insert(_basic, v)
    end
    for k, v in pairs(my_basic_skills) do table.insert(_basic, v) end
    for k, v in pairs(my_special_skills) do table.insert(_basic, v) end -- ]]
    for i = 1, #_basic do
        -- table.insert(_skills_ch,skills[_basic[i]]["name"])
        -- table.insert(_skills_lev,skills[_basic[i]]["lvl"])
        -- table.insert(_skills_pot,skills[_basic[i]]["pot"])
        table.insert(_skills_ch, _basic[i]["name"])
        table.insert(_skills_lev, _basic[i]["lvl"])
        table.insert(_skills_pot, _basic[i]["pot"])
    end
    WINDOW_WIDTH = 190
    if win_skills_show == 0 then
        WINDOW_HEIGHT = 30
        WINDOW_WIDTH = 70
    else
        WINDOW_HEIGHT = (#_basic + 1) * 15 + 40
        WINDOW_WIDTH = 200
    end
    -- Create the window
    --	WindowCreate (win_skills, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_POSITION, 4, 0x000010)  -- create window
    WindowCreate(win_skills, windowinfo_skills.window_left,
                 windowinfo_skills.window_top, WINDOW_WIDTH, WINDOW_HEIGHT,
                 windowinfo_skills.window_mode, windowinfo_skills.window_flags,
                 0x000010)
    -- define the fonts
    WindowFont(win_skills, "f1", FONT_NAME1, FONT_SIZE_12)
    WindowFont(win_skills, "f2", FONT_NAME2, FONT_SIZE_11)
    WindowFont(win_skills, "f3", FONT_NAME1, FONT_SIZE_12, true)
    WindowFont(win_skills, "f4", FONT_NAME3, FONT_SIZE_11, true)
    WindowFont(win_skills, "f5", FONT_NAME1, FONT_SIZE_11)

    -- work out how high the font is
    font_height = WindowFontInfo(win_skills, "f1", 1) -- height of the font  

    movewindow.save_state(win_skills)

    -- draw the border of the whole box
    WindowCircleOp(win_skills, miniwin.circle_round_rectangle, 0, 2,
                   WINDOW_WIDTH - 2, WINDOW_HEIGHT, 0xc0c0c0, 0, 1, 0, 0, 9, 9)
    -- ensure window visible
    local head_width = (WINDOW_WIDTH -
                           WindowTextWidth(win_skills, "f1", "�����б�")) /
                           2
    local head_width1 = (WindowTextWidth(win_skills, "f1", "��")) + 11
    local head_width2 = (WindowTextWidth(win_skills, "f1",
                                         "�����������Щ�")) + 11
    if win_skills_show == 0 then
        WindowAddHotspot(win_skills, "skills", 0, 0, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", -- mousedown
        "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_skills, "f5", "�����б�", -- text
        5, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode
    else
        WindowLine(win_skills, 0, font_height + 15, WINDOW_WIDTH - 2,
                   font_height + 15, 0xc0c0c0, 0, 1)
        movewindow.add_drag_handler(win_skills, 0, 0, 0, font_height + 15,
                                    miniwin.cursor_hand)
        WindowAddHotspot(win_skills, "skills", 0, font_height + 15, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", -- mousedown
        "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_skills, "f5", "�����б�", -- text
        head_width, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode

        WindowText(win_skills, "f1", "��" .. #_basic ..
                       "�ּ���  ��ǰ����ȼ���" .. hp.pot_max - 100, -- text
                   11, 30, 0, 0, -- rectangle
        ColourNameToRGB("white"), -- colour
        false) -- not Unicode
        --[[ WindowText (win_skills, "f1", 
               "��ɫ",   -- text
                head_width1, 30, 0, 0,        -- rectangle
                ColourNameToRGB ("red"), -- colour
                false)              -- not Unicode

   WindowText (win_skills, "f1", 
               "����",   -- text
                head_width2, 30, 0, 0,        -- rectangle
                ColourNameToRGB ("cyan"), -- colour
                false)              -- not Unicode
	]]
        require "gauge"
        for i = 1, #my_misc_skills do -- for i = 1,#_basic do
            if _skills_ch[i] == "" or _skills_ch[i] == nil then
                _skills_ch[i] = "���ݶ�ʧ"
            end
            if _basic[i] == "" or _basic[i] == nil then
                _basic[i] = "���ݶ�ʧ"
            end
            if _skills_lev[i] == "" or _skills_lev[i] == nil then
                _skills_lev[i] = "���ݶ�ʧ"
            end
            if _skills_pot[i] == "" or _skills_pot[i] == nil then
                _skills_pot[i] = "���ݶ�ʧ"
            end

            local txt2
            if string.len(_skills_ch[i]) == 10 then
                txt2 = " " .. _skills_ch[i] .. "  " .. _skills_lev[i] .. "  "
            elseif string.len(_skills_ch[i]) == 8 then
                txt2 = " " .. _skills_ch[i] .. "    " .. _skills_lev[i] .. "  "
            elseif string.len(_skills_ch[i]) == 6 then
                txt2 = " " .. _skills_ch[i] .. "      " .. _skills_lev[i] ..
                           "  "
            else
                txt2 = " " .. _skills_ch[i] .. "        " .. _skills_lev[i] ..
                           "  "
            end
            local _high = i * 15 + 30
            WindowText(win_skills, "f1", txt2, -- text
            5, _high, 0, 0, -- rectangle
            --  ColourNameToRGB (_colour), -- colour
            ColourNameToRGB("orange"), -- colour
            false) -- not Unicode
            if _skills_ch[i] ~= "���ݶ�ʧ" and _skills_pot[i] ~=
                "���ݶ�ʧ" and _skills_lev[i] ~= "���ݶ�ʧ" then
                gauge(win_skills, txt2, (_skills_pot[i]),
                      (_skills_lev[i] + 1) ^ 2, 110, _high, 80, 12,
                      ColourNameToRGB("orange"), 0x808080, 0, 0x000000,
                      0x000000, 0x000000)
            end

            --[[if _skills_ch[i] ~= "���ݶ�ʧ" then
			gauge (win_skills, txt2, GetVariable(Replace("skills_pot_".._basic[i], "-", "_", true)), (_skills_lev[i]+1)^2, 102, _high, 80, 12, ColourNameToRGB (_colour), 0x808080,  0, 0x000000, 0x000000, 0x000000)             
		end
	--]]
        end
        for i = #my_misc_skills + 1, #my_misc_skills + #my_basic_skills do
            if _skills_ch[i] == "" or _skills_ch[i] == nil then
                _skills_ch[i] = "���ݶ�ʧ"
            end
            if _basic[i] == "" or _basic[i] == nil then
                _basic[i] = "���ݶ�ʧ"
            end
            if _skills_lev[i] == "" or _skills_lev[i] == nil then
                _skills_lev[i] = "���ݶ�ʧ"
            end
            if _skills_pot[i] == "" or _skills_pot[i] == nil then
                _skills_pot[i] = "���ݶ�ʧ"
            end

            local txt2
            if string.len(_skills_ch[i]) == 10 then
                txt2 = " " .. _skills_ch[i] .. "  " .. _skills_lev[i] .. "  "
            elseif string.len(_skills_ch[i]) == 8 then
                txt2 = " " .. _skills_ch[i] .. "    " .. _skills_lev[i] .. "  "
            elseif string.len(_skills_ch[i]) == 6 then
                txt2 = " " .. _skills_ch[i] .. "      " .. _skills_lev[i] ..
                           "  "
            else
                txt2 = " " .. _skills_ch[i] .. "        " .. _skills_lev[i] ..
                           "  "
            end
            local _high = i * 15 + 30
            WindowText(win_skills, "f1", txt2, -- text
            5, _high, 0, 0, -- rectangle
            --  ColourNameToRGB (_colour), -- colour
            ColourNameToRGB("white"), -- colour
            false) -- not Unicode
            if _skills_ch[i] ~= "���ݶ�ʧ" and _skills_pot[i] ~=
                "���ݶ�ʧ" and _skills_lev[i] ~= "���ݶ�ʧ" then
                gauge(win_skills, txt2, (_skills_pot[i]),
                      (_skills_lev[i] + 1) ^ 2, 110, _high, 80, 12,
                      ColourNameToRGB("white"), 0x808080, 0, 0x000000, 0x000000,
                      0x000000)
            end

            --[[if _skills_ch[i] ~= "���ݶ�ʧ" then
			gauge (win_skills, txt2, GetVariable(Replace("skills_pot_".._basic[i], "-", "_", true)), (_skills_lev[i]+1)^2, 102, _high, 80, 12, ColourNameToRGB (_colour), 0x808080,  0, 0x000000, 0x000000, 0x000000)             
		end
	--]]
        end
        for i = #my_misc_skills + #my_basic_skills + 1, #_basic do
            if _skills_ch[i] == "" or _skills_ch[i] == nil then
                _skills_ch[i] = "���ݶ�ʧ"
            end
            if _basic[i] == "" or _basic[i] == nil then
                _basic[i] = "���ݶ�ʧ"
            end
            if _skills_lev[i] == "" or _skills_lev[i] == nil then
                _skills_lev[i] = "���ݶ�ʧ"
            end
            if _skills_pot[i] == "" or _skills_pot[i] == nil then
                _skills_pot[i] = "���ݶ�ʧ"
            end

            local txt2
            if string.len(_skills_ch[i]) == 10 then
                txt2 = " " .. _skills_ch[i] .. "  " .. _skills_lev[i] .. "  "
            elseif string.len(_skills_ch[i]) == 8 then
                txt2 = " " .. _skills_ch[i] .. "    " .. _skills_lev[i] .. "  "
            elseif string.len(_skills_ch[i]) == 6 then
                txt2 = " " .. _skills_ch[i] .. "      " .. _skills_lev[i] ..
                           "  "
            else
                txt2 = " " .. _skills_ch[i] .. "        " .. _skills_lev[i] ..
                           "  "
            end
            local _high = i * 15 + 30
            WindowText(win_skills, "f1", txt2, -- text
            5, _high, 0, 0, -- rectangle
            --  ColourNameToRGB (_colour), -- colour
            ColourNameToRGB("cyan"), -- colour
            false) -- not Unicode
            if _skills_ch[i] ~= "���ݶ�ʧ" and _skills_pot[i] ~=
                "���ݶ�ʧ" and _skills_lev[i] ~= "���ݶ�ʧ" then
                gauge(win_skills, txt2, (_skills_pot[i]),
                      (_skills_lev[i] + 1) ^ 2, 110, _high, 80, 12,
                      ColourNameToRGB("cyan"), 0x808080, 0, 0x000000, 0x000000,
                      0x000000)
            end

            --[[if _skills_ch[i] ~= "���ݶ�ʧ" then
			gauge (win_skills, txt2, GetVariable(Replace("skills_pot_".._basic[i], "-", "_", true)), (_skills_lev[i]+1)^2, 102, _high, 80, 12, ColourNameToRGB (_colour), 0x808080,  0, 0x000000, 0x000000, 0x000000)             
		end
	--]]
        end
    end
    if flag_win_skills and flag_win_skills == 1 then
        WindowShow(win_skills, true)
    else
        WindowShow(win_skills, false)
    end
end

function draw_bagwindow()
    if not flag_win_bag or flag_win_bag ~= 1 then
        if win_bag then WindowShow(win_bag, false) end
        return
    end
    if not Bag then return end
    local _bag_ch = {}
    local _bag_cn = {}
    for k, v in pairs(Bag) do
        if k ~= 'ENCB' then table.insert(_bag_ch, k) end
    end
    for i = 1, #_bag_ch do table.insert(_bag_cn, Bag[_bag_ch[i]]["cnt"]) end
    if win_bag_show == 0 then
        WINDOW_HEIGHT = 30
        WINDOW_WIDTH = 70
    else
        WINDOW_HEIGHT = (math.ceil(#_bag_ch / 2) + 1) * 15 + 40
        WINDOW_WIDTH = 190
    end
    -- Create the window
    --	WindowCreate (win_bag, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_POSITION, 4, 0x000010)  -- create window
    WindowCreate(win_bag, windowinfo_bag.window_left, windowinfo_bag.window_top,
                 WINDOW_WIDTH, WINDOW_HEIGHT, windowinfo_bag.window_mode,
                 windowinfo_bag.window_flags, 0x000010)

    movewindow.save_state(win_bag)
    -- define the fonts
    WindowFont(win_bag, "f1", FONT_NAME1, FONT_SIZE_12)
    WindowFont(win_bag, "f2", FONT_NAME2, FONT_SIZE_11)
    WindowFont(win_bag, "f3", FONT_NAME1, FONT_SIZE_12, true)
    WindowFont(win_bag, "f4", FONT_NAME3, FONT_SIZE_11, true)
    WindowFont(win_bag, "f5", FONT_NAME1, FONT_SIZE_11)

    -- work out how high the font is
    font_height = WindowFontInfo(win_bag, "f1", 1) -- height of the font  

    -- draw the border of the whole box
    WindowCircleOp(win_bag, miniwin.circle_round_rectangle, 0, 2,
                   WINDOW_WIDTH - 2, WINDOW_HEIGHT, 0xc0c0c0, 0, 1, 0, 0, 9, 9)

    -- ensure window visible
    local head_width = (WINDOW_WIDTH -
                           WindowTextWidth(win_bag, "f1", "��Ʒ�б�")) / 2
    if win_bag_show == 0 then
        WindowAddHotspot(win_bag, "bag", 0, 0, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_bag, "f5", "��Ʒ�б�", -- text
        5, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode
    else
        WindowLine(win_bag, 0, font_height + 15, WINDOW_WIDTH - 2,
                   font_height + 15, 0xc0c0c0, 0, 1)
        movewindow.add_drag_handler(win_bag, 0, 0, 0, font_height + 15)
        WindowAddHotspot(win_bag, "bag", 0, font_height + 15, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_bag, "f5", "��Ʒ�б�", -- text
        head_width, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode

        WindowText(win_bag, "f1", "��" .. #_bag_ch .. "����Ʒ", -- text
        5, 30, 0, 0, -- rectangle
        ColourNameToRGB("white"), -- colour
        false) -- not Unicode
        if Bag["ENCB"].value then
            WindowText(win_bag, "f1", "����" .. Bag["ENCB"].value .. "%", -- text
                       100, 30, 0, 0, -- rectangle
            ColourNameToRGB("white"), -- colour
            false) -- not Unicode

        end
        for i = 1, #_bag_ch do
            if _bag_ch[i] == "" or _bag_ch[i] == nil then
                _bag_ch[i] = "���ݶ�ʧ"
            end
            if _bag_ch[i] == "" or _bag_ch[i] == nil then
                _basic[i] = "���ݶ�ʧ"
            end

            local txt2 = _bag_ch[i] .. " *" .. _bag_cn[i]
            local _high = math.ceil(i / 2) * 15 + 30
            if i / 2 < math.ceil(i / 2) then
                WindowText(win_bag, "f1", txt2, -- text
                5, _high, 0, 0, -- rectangle
                --  ColourNameToRGB (_colour), -- colour
                ColourNameToRGB("green"), -- colour
                false) -- not Unicode
            else
                WindowText(win_bag, "f1", txt2, -- text
                95 + 5, _high, 0, 0, -- rectangle
                --  ColourNameToRGB (_colour), -- colour
                ColourNameToRGB("green"), -- colour
                false) -- not Unicode
            end
        end
    end
    if flag_win_bag and flag_win_bag == 1 then
        WindowShow(win_bag, true)
    else
        WindowShow(win_bag, false)
    end
end

function draw_beinangwindow()
    if not flag_win_beinang or flag_win_beinang ~= 1 then
        if win_beinang then WindowShow(win_beinang, false) end
        return
    end
    if not Beinang then return end

    if win_beinang_show == 0 then
        WINDOW_HEIGHT = 30
        WINDOW_WIDTH = 70
    else
        WINDOW_HEIGHT = (#Beinang + 1) * 15 + 40
        WINDOW_WIDTH = 190
    end
    -- Create the window
    --	WindowCreate (win_beinang, 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_POSITION, 4, 0x000010)  -- create window
    WindowCreate(win_beinang, windowinfo_beinang.window_left,
                 windowinfo_beinang.window_top, WINDOW_WIDTH, WINDOW_HEIGHT,
                 windowinfo_beinang.window_mode,
                 windowinfo_beinang.window_flags, 0x000010)

    movewindow.save_state(win_beinang)
    -- define the fonts
    WindowFont(win_beinang, "f1", FONT_NAME1, FONT_SIZE_12)
    WindowFont(win_beinang, "f2", FONT_NAME2, FONT_SIZE_11)
    WindowFont(win_beinang, "f3", FONT_NAME1, FONT_SIZE_12, true)
    WindowFont(win_beinang, "f4", FONT_NAME3, FONT_SIZE_11, true)
    WindowFont(win_beinang, "f5", FONT_NAME1, FONT_SIZE_11)

    -- work out how high the font is
    font_height = WindowFontInfo(win_beinang, "f1", 1) -- height of the font  

    -- draw the border of the whole box
    WindowCircleOp(win_beinang, miniwin.circle_round_rectangle, 0, 2,
                   WINDOW_WIDTH - 2, WINDOW_HEIGHT, 0xc0c0c0, 0, 1, 0, 0, 9, 9)

    -- ensure window visible
    local head_width = (WINDOW_WIDTH -
                           WindowTextWidth(win_beinang, "f1", "�����б�")) /
                           2
    if win_beinang_show == 0 then
        WindowAddHotspot(win_beinang, "beinang", 0, 0, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_beinang, "f5", "�����б�", -- text
        5, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode
    else
        WindowLine(win_beinang, 0, font_height + 15, WINDOW_WIDTH - 2,
                   font_height + 15, 0xc0c0c0, 0, 1)
        movewindow.add_drag_handler(win_beinang, 0, 0, 0, font_height + 15)
        WindowAddHotspot(win_beinang, "beinang", 0, font_height + 15, 0, 0, "", -- mouseover (do nothing)
                         "", -- cancelmouseover (do nothing)
        "", "", -- cancelmousedown (do nothing)
        "mouseup", -- mouseup (do nothing)
        "����رտ���", -- hint text if they hover over it              
        0, 0)

        WindowText(win_beinang, "f5", "�����б�", -- text
        head_width, 9, 0, 0, -- rectangle
        ColourNameToRGB("yellow"), -- colour
        false) -- not Unicode

        for i = 1, #Beinang do
            if Beinang[i] == "" or Beinang[i] == nil then
                Beinang[i] = "���ݶ�ʧ"
            end

            local txt2 = Beinang[i]
            local _high = i * 15 + 30
            WindowText(win_beinang, "f1", txt2, -- text
            12, _high, 0, 0, -- rectangle
            --  ColourNameToRGB (_colour), -- colour
            ColourNameToRGB("deeppink"), -- colour
            false) -- not Unicode
        end
    end
    if flag_win_beinang and flag_win_beinang == 1 then
        WindowShow(win_beinang, true)
    else
        WindowShow(win_beinang, false)
    end
end

