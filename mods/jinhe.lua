--------------������-------------
jinheTrigger = function()
    DeleteTriggerGroup("jinheTrigger")
    create_trigger_t('jinheTrigger1',
                     "^>*\\s*�㿴�˰��죬Ҳû����������ӵ�������ô���¡�",
                     '', 'jinhe_goon')
    create_trigger_t('jinheTrigger2',
                     "^>*\\s*���ӵļв��Ѿ��򿪣��������ϸ�����ӣ�look jinhe��Ȼ���ȡ��Ӧ�ж���",
                     '', 'jinhe_find')
    create_trigger_t('jinheTrigger3',
                     "^>*\\s*���ݺὭ��ʱ����(\\D*)����Щ�����£�����Ե��ǰȥ�ھ�",
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
            Log:error('���ص�ʧ��')
            return jinheOver()
        end
        local jinhe_location = tostring(w[1])
        local rooms = findAllRooms(jinhe_location)
        if #rooms < 1 then
            Log:error('���з��䲻�ɵ�������Ҳ���:' ..
                          jinhe_location)
            return jinheOver()
        end

        for _, room in pairs(rooms) do
            Log:info('ǰ��' .. room .. '�ڽ���')
            await_go(room)
            local dig_count = 0
            while dig_count < 5 do
                exe('dig')
                local line, w = wait.regexp(
                                    '^>*\\s*������������ó���(\\D*)��|^>*\\s*������һ��ʲôҲû���ҵ�',
                                    1)
                dig_count = dig_count + 1
                if line and line:find("�����������") then
                    Log:info('���У����' .. w[1])
                    return jinheOver()
                end
            end
        end
        Log:error('������ȫ������,��' .. jinhe_location ..
                      '�ҵ�����')
        return jinheOver()
    end)
end
jinhe_find = function() exe('look he') end

function jinheOver() Log:green('����ģ�����') end

