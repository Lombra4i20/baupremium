local mysql = exports["oxmysql"]
local VORPcore = {}

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local bausPermissoes = {}
if Config.bausPermissoes then
    bausPermissoes = Config.bausPermissoes
end

local baus = {}
if Config.baus then
    baus = Config.baus
end

for _, bau in pairs(baus) do
    VorpInv.registerInventory(bau.id, bau.label, bau.size, true, true, true, false, false, false)
end

local coordenadas = {}
if Config.coordenadas then
    coordenadas = Config.coordenadas
end

-- Configuração de um raio de 2 metros
local radius = 2

RegisterNetEvent('bauPrivado')
AddEventHandler('bauPrivado', function(args)
    local source = source
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local User = VORPcore.getUser(source)
    local Character = User.getUsedCharacter

    local bauIndex = getBauIndex(playerCoords)
    if bauIndex > 0 then
        local bauName = "Bau" .. bauIndex
        local bauPermissoes = bausPermissoes[bauName]
        if hasPermission(Character.group, bauPermissoes) then
            VorpInv.OpenInv(source, bauName)
        else
            TriggerClientEvent("vorp:TipRight", source, "Você não tem permissão", 5000)
        end
    end
end)

function hasPermission(group, bausPermissoes)
    for i = 1, #bausPermissoes do
        if group == bausPermissoes[i] then
            return true
        end
    end
    return false
end

function getBauIndex(coords)
    for i = 1, #coordenadas do
        local centerPoint = coordenadas[i]
        if coords.x >= centerPoint.x - radius and coords.x <= centerPoint.x + radius
            and coords.y >= centerPoint.y - radius and coords.y <= centerPoint.y + radius
            and coords.z >= centerPoint.z - radius and coords.z <= centerPoint.z + radius then
            return i
        end
    end
    return 0
end