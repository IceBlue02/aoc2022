local open = io.open

local function read_file_to_table(path)
    local file = open(path, "r") 
    if not file then return nil end

    lines = {}
    for line in file:lines() do
        table.insert(lines, line);
    end
    file:close()

    return lines
end

local function part1(data)
    local scoreMatrix= {
        A={X=4, Y=8, Z=3},
        B={X=1, Y=5, Z=9},
        C={X=7, Y=2, Z=6}
    }

    totalScore = 0
    for k, v in pairs(data) do
        local opp = string.sub(v, 1, 1);
        local me = string.sub(v, 3, 3);
        totalScore = totalScore + scoreMatrix[opp][me]
    end
    return totalScore
end

local function part2(data, scoreMatrix)
    local scoreMatrix= {
        A={X=3, Y=4, Z=8},
        B={X=1, Y=5, Z=9},
        C={X=2, Y=6, Z=7}
    }

    totalScore = 0
    for k, v in pairs(data) do
        local opp = string.sub(v, 1, 1);
        local me = string.sub(v, 3, 3);
        totalScore = totalScore + scoreMatrix[opp][me]
    end
    return totalScore
end


local fileContent = read_file_to_table("data.txt");

print(part1(fileContent));
print(part2(fileContent));

