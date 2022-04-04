local isServer = IsDuplicityVersion() and true or false

shared = {
    command = GetConvar('anchor:command_enabled', 'true'),
    useAce = GetConvar('anchor:use_ace_permissions', 'false'),
    maxSpeed = tonumber(GetConvar('anchor:max_speed', 3.0)),
    minDriftDistance = tonumber(GetConvar('anchor:min_drift_distance', 0.1)),
    breakingForce = tonumber(GetConvar('anchor:breaking_force', 600.0)),
}

if not isServer then
    DecorRegister('isAnchored', 2)

    client = setmetatable({
        vehicles = {},
        serverId = GetPlayerServerId(PlayerId())
    }, {})

    if shared.command == 'true' then
        RegisterCommand('anchor', function()
            client:toggleAnchor()
        end, (shared.useAce == 'true'))
    end
end

if isServer then
    server = setmetatable({}, {})
end
