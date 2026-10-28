-- AutoFFA for WoW 3.3.5a / AzerothCore
local frame = CreateFrame("Frame")
local wasGrouped = false
local wasLeader = false
local pending = false
local DELAY = 2

local function InGroup()
    return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end

local function IsGroupLeader()
    if GetNumRaidMembers() > 0 then
        return IsRaidLeader()
    end
    return IsPartyLeader()
end

local function SetFreeForAll()
    if not InGroup() or not IsGroupLeader() then
        return
    end

    -- Dungeon Finder groups can have locked loot rules.
    if HasLFGRestrictions and HasLFGRestrictions() then
        return
    end

    if GetLootMethod() ~= "freeforall" then
        SetLootMethod("freeforall")
    end
end

local function ScheduleUpdate()
    if pending then
        return
    end

    pending = true
    local elapsed = 0
    frame:SetScript("OnUpdate", function(self, seconds)
        elapsed = elapsed + seconds
        if elapsed >= DELAY then
            self:SetScript("OnUpdate", nil)
            pending = false
            SetFreeForAll()
        end
    end)
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PARTY_MEMBERS_CHANGED")
frame:RegisterEvent("PARTY_LEADER_CHANGED")
frame:RegisterEvent("RAID_ROSTER_UPDATE")

frame:SetScript("OnEvent", function(self)
    local grouped = InGroup()

    if not grouped then
        wasGrouped = false
        wasLeader = false
        pending = false
        self:SetScript("OnUpdate", nil)
        return
    end

    local leader = not not IsGroupLeader()
    if not wasGrouped or (leader and not wasLeader) then
        ScheduleUpdate()
    end

    wasGrouped = true
    wasLeader = leader
end)
