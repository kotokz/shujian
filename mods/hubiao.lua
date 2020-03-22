job.list["hubiao"] = "护镖"

Hubiao = {
    mianThread = nil,
    subThread = nil,
    leaderId = nil,
    teammates = nil,
    leader = false,
    role = nil,
    rooms = {},
    steps = {},
    step = 1,
    start_time = nil
}

function Hubiao:new()
    local hb = {}
    if GetVariable("hb_teammates") == nil or GetVariable("hb_leaderID") == nil then
        Hubiao:setting()
    end
    setmetatable(hb, {__index = hubiao})
    return hb
end

function Hubiao:start()
    dis_all()
    self.teammates = GetVariable("hb_teammates")
    self.leaderId = GetVariable("hb_leaderID")
    if score.id == self.leaderId then
        self.leader = true
    end

    wait.make(
        function()
            await_go("福州", "福威镖局")
            exe("team dismiss")

            self:waitTeammates()
        end
    )
end

function Hubiao:waitTeammates()
    wait.make(
        function()
            while true do
                if self.leader then
                end
            end
        end
    )
end
