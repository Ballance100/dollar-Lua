script = [[
objects = $ + 1
 objects = $ + 1
 Obj = $ + 1
 ob = 5
 print(Obj[#$])
 print(Obj.file[#$])
 $]]

transpiledScript = ""

local lastVar = ""

local main = {} --contains all funcs

 main.transpile = function(script)
    local function findLastVariable(variableEndingPoint,fullScript)
        lastVar = ""
        local ready = false
        for i=variableEndingPoint,1, -1 do--Var can be max of 999999 chars long

            c = fullScript:sub(i,i)

            if not c:find("%a") and c ~= "." and ready then lastVar = lastVar break end

            if c:find("%a") or c == "." then  ready = true lastVar = lastVar .. c end
            --c:find checks if it's a var
        end
        lastVar = string.reverse(lastVar)
    end

    for i = 1, #script do
        local c = script:sub(i,i)
        if c == "$" then
            if lastVar == "" then error "$ in wrong position" end
            transpiledScript = transpiledScript .. lastVar
            lastVar = ""

        elseif c == "=" or "[" then
            transpiledScript = transpiledScript .. c
            findLastVariable(i,script)
        else

            transpiledScript = transpiledScript .. c
        end
    end

    print("\n Old Script:"..script.."\n\nNew Script: "..transpiledScript)
    return transpiledScript
end

main.transpileAndSave = function(script,dir)
    local file = io.open(dir,"w+")
    io.output(file)
    io.write(main.transpile(script))
    file:close()
end

main.transpileAndSave(script,"file.lua")
