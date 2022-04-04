RegisterNetEvent("fd_anchor:toggleAnchor", function(vehicle)
    server:toggleAnchor(vehicle)
end)

RegisterNetEvent("fd_anchor:passAnchor", function(vehicle)
    server:passAnchor(vehicle)
end)
