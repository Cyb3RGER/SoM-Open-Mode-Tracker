-- https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- from https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
       local tabs = ('\t'):rep(depth)
       local tabs2 = ('\t'):rep(depth+1)
       local s = '{\n'
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. tabs2 .. '['..k..'] = ' .. dump_table(v, depth+1) .. ',\n'
       end
       return s .. tabs .. '}'
    else
       return tostring(o)
    end
 end

