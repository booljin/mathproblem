local l_min = 1
local l_max = 100
local r_max = 10
local r_max = 10
local question = {}
local question1= {}

for k = 11,90 do
    for k1 = 11,90 do
        local t = k + k1
        if t <= 99 then
            table.insert(question, k.." + "..k1.." =,")
        end
    end
end

for k = 11,99 do
    for k1 = 11,99 do
        local t = k - k1
        if t > 0 then
            table.insert(question, k.." - "..k1.." =,")
        end
    end
end

-- 乘除法
for k = 2,9 do
    for k1 = k, 9 do
        table.insert(question1, k.." × "..k1.." =,")
        table.insert(question1, k*k1.." ÷ "..k.." =,")
    end
end

--[[20以内进退位加减法
for k = 1,10 do
    for k1 = 1,10 do
        local t = k + k1
        if t <= 20 and t >= 10 then
            table.insert(question, k.." + "..k1.." =,")
        end
    end
end

for k = 2,20 do
    for k1 = 1,k-1 do
        local t = k - k1
        if (k >= 10 and t < 10) then
            table.insert(question, k.." - "..k1.." =,")
        end
    end
end
]]

--[[100以内进退位加减法
for k = 10,99 do
    for k1 = 1,99 do
        local t = k + k1
        if t < 100 and ((k1 < 10 and math.floor(t/10) > math.floor(k/10))--有进位的加法，加数是个位数
            or (k1 > 10 and (k %10 + k1 % 10 < 10)) --无进位的加法，两加数都是两  
            )  then
            table.insert(question, k.." + "..k1.." =,")
        end
    end
end

for k = 10,99 do
    for k1 = 1,k-1 do
        local t = k - k1
        if t > 10 and ((k1 < 10 and math.floor(t/10) < math.floor(k/10))--有退位的减法，减数是个位数
            or (k1 > 10 and (k %10 >= k1 % 10)) --无退位的减法，减数是两  
            ) then
            table.insert(question, k.." - "..k1.." =,")
        end
    end
end
--]]
--[[
for k = 1,19 do
    for k1 = k,19 do
        local t = k + k1
        if t < 21 then
            table.insert(question, k.." + "..k1.." = "..t..",")
        end
    end
end
]]

print(#question)
print(#question1)

local function question_idx()
    local t = {}
    for k,v in ipairs(question) do
        table.insert(t, k)
    end
    return t
end

local function question_idx1()
    local t = {}
    for k,v in ipairs(question1) do
        table.insert(t, k+100000)
    end
    return t
end


local reject = {}
local reject_num = 9


math.randomseed(os.time())
for k = 1, reject_num do
    table.insert(reject, math.random(1,#question))
end

local ques_per_line = 3

local _question = question_idx()
local _question1 = question_idx1()

for round = 1, 20 do

    local f = io.open ("t"..l_min.."-"..l_max.."_"..math.random(10000,99999)..".csv", "w")
    for k = 1, 100 do
        local q_type = math.random(1,3)
        local __question = _question
        local q = question
        if q_type <= 2 then
            q_type = 0
        else
            q_type = 1
            __question = _question1
            q = question1
        end
        while 1 do
            local t = math.random(1,#__question)
            local _repeat = false
            for _,v in ipairs(reject) do
                if v == __question[t] then
                    _repeat = true
                    break
                end
            end
            if not _repeat then
                f:write(q[__question[t]%100000])
                local rej_idx = k%reject_num
                if rej_idx == 0 then rej_idx = reject_num end
                reject[rej_idx] = __question[t]
                
                table.remove(__question, t)
                if #__question == 0 then
                    if q_type == 0 then _question = question_idx()
                    else _question1 = question_idx1() end
                end
                if k % ques_per_line == 0 then
                    f:write("\n")
                end
                break
            end
        end
    end

    f:close()
end
--[[
local base = {
}

for k = 2, 9 do
    for k1 = 1,k-1 do
        local t = k - k1
        table.insert(base, {k1, t, k})
    end
end


math.randomseed(os.time())

local done = {}
local f = io.open ("t"..math.random(10000,99999)..".csv", "w")

local out = {}
for k = 1, 60 do
    while 1 do
        local t1 = math.random(1,#base)
        local t2 = math.random(1,3)
        local t3 = t1*10 + t2
        if not done[t3] then
            if t2 == 1 then
                table.insert(out,string.format("%02d",k).."     □")
                table.insert(out,"       /    \\")
                table.insert(out,"      "..base[t1][1].."      "..base[t1][2])
            elseif t2 == 2 then
                table.insert(out,string.format("%02d",k).."     "..base[t1][3])
                table.insert(out,"      /    \\")
                table.insert(out,"    □      "..base[t1][1])
            else
                table.insert(out,string.format("%02d",k).."     "..base[t1][3])
                table.insert(out,"      /    \\")
                table.insert(out,"    "..base[t1][1].."      □")
            end
            break
        end
    end
end

local n = 4
local n1 = math.ceil(60/n)
for k = 1, n1 do
    local str1 = ""
    local str2 = ""
    local str3 = ""
    for k1 = 1, n do
        local idx = (k - 1)*n + k1
        if idx <= 60 then
            str1 = str1 .. out[(idx - 1)*3 + 1] .. ","
            str2 = str2 .. out[(idx - 1)*3 + 2] .. ","
            str3 = str3 .. out[(idx - 1)*3 + 3] .. ","
        end
    end
    f:write(str1.."\n")
    f:write(str2.."\n")
    f:write(str3.."\n")
    f:write("\n")
end

f:close()

]]