
## CanAnchor

## Description

Returns if current boat can be anchored, vehicle need to passed.

## Parameters

* **vehicle**: current vehicle

## Examples

```lua
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, true)
    local isDriver = GetPedInVehicleSeat(vehicle, -1) == ped


    local canAnchor = exports.fd_anchor:CanAnchor(vehicle)

    if canAnchor and isDriver then
        -- can anchor
        return
    end

    -- cannot anchor
    return false

```
