function client.toggleAnchor()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true)
    local isDriver = GetPedInVehicleSeat(vehicle, -1) == ped

    if not vehicle or not isDriver then
        return false
    end

    if DecorGetBool(vehicle, 'isAnchored') then
        onUnanchored(vehicle)
        DecorSetBool(vehicle, "isAnchored", false)

        return
    end

    if not canAnchor(vehicle) then
        return
    end

    TriggerServerEvent("fd_anchor:toggleAnchor", VehToNet(vehicle))
end

function client.applyAnchor(self, vehicle)
    vehicle = NetToVeh(vehicle)

    local done = onAnchoring(vehicle)

    client.vehicles[vehicle] = {
        anchorPos = GetEntityCoords(vehicle),
        magnitude = 0.0
    }

    DecorSetBool(vehicle, "isAnchored", true)
end

function client.setAnchor(self, vehicle)
    vehicle = NetToVeh(vehicle)

    client.vehicles[vehicle] = {
        anchorPos = GetEntityCoords(vehicle),
        magnitude = 0.0
    }
end

CreateThread(function()
    while true do
        for vehicle, data in pairs(client.vehicles) do
            if not DecorGetBool(vehicle, 'isAnchored') then
                client.vehicles[vehicle] = nil

                goto continue
            end

            if not isOwner(vehicle) then
                TriggerServerEvent("fd_anchor:passAnchor", VehToNet(vehicle))
                client.vehicles[vehicle] = nil

                goto continue
            end

            local distanceVector = data.anchorPos - GetEntityCoords(vehicle)

            if #(distanceVector) > shared.minDriftDistance then
                local forceVector = forceCalculation(vehicle, distanceVector, #(distanceVector))

                ApplyForceToEntityCenterOfMass(vehicle, 1, forceVector.x, forceVector.y, 0.0, false, false, false)

                if #(distanceVector) > 20.0 or (data.magnitude > shared.breakingForce and #forceVector < data.magnitude) then
                    client.vehicles[vehicle] = nil
                    DecorSetBool(vehicle, "isAnchored", false)
                    onAnchorBroke(vehicle)
                end

                data.magnitude = #forceVector
            end

            ::continue::
        end

        Wait(0)
    end
end)

exports('ToggleAnchor', function()
    client.toggleAnchor()
end)

exports('CanAnchor', function(vehicle)
    return client.canAnchor(vehicle)
end)

exports('IsAnchored', function(vehicle)
    return (client.vehicles[vehicle] and DecorGetBool(vehicle, 'isAnchored'))
end)
