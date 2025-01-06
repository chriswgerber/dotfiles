--- Util
table.unpack = table.unpack or unpack -- 5.1 compatibility


Util = {}


function Util:dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. self.dump(Util, v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
end
