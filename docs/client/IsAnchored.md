
## IsAnchored

## Description

Returns if current boat can be anchored, vehicle need to passed.

## Parameters

* **vehicle**: current vehicle

## Examples

```lua
    local IsAnchored = exports.fd_anchor:IsAnchored(GetVehiclePedIsIn(PlayerPedId(), true))

    if IsAnchored then
        -- is anchored
        return
    end

    -- isn't anchored
    return false

```
