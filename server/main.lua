function server.toggleAnchor(self, vehicle)
    vehicle = NetworkGetEntityFromNetworkId(vehicle)

    local owner = NetworkGetEntityOwner(vehicle)
    TriggerClientEvent("fd_anchor:applyAnchor", owner, NetworkGetNetworkIdFromEntity(vehicle))
end

function server.passAnchor(self, vehicle)
    vehicle = NetworkGetEntityFromNetworkId(vehicle)

    local owner = NetworkGetEntityOwner(vehicle)
    TriggerClientEvent("fd_anchor:setAnchor", owner, NetworkGetNetworkIdFromEntity(vehicle))
end
