
"""
    -9    | Refusal
    -8    | Don't know
    -1    | Item not applicable
    1     | Under £5,000
    2     | £5,000-£9,999
    3     | £10,000-£14,999
    4     | £15,000-£19,999
    5     | £20,000-£29,999
    6     | £30,000-£49,999
    7     | £50,000-£74,999
    8     | £75,000 or more
    9     | No income
"""
function toincome( s :: Union{Missing,AbstractString,Int} ) :: Union{Real,Missing}
    v = -1.0
    if ismissing(s) || (s in [" ", ""])
        return missing
    end
    if typeof(s) <: Integer
        i = s
    else
        i = tryparse(Int,s)
    end
    if i in [9, -9, -8, -1]
        return missing
    end
    if i == 1
        v = 2_500
    elseif i == 2
        v = 7_500
    elseif i == 3
        v = 12_500
    elseif i == 4
        v = 17_500
    elseif i == 5
        v = 25_000
    elseif i == 6
        v = 40_000
    elseif i == 7
        v = 62_500
    elseif i == 8
        v = 80_000
    end
    @assert v > 0 "non-mapped |$s|"
    return v
end

"""
|2014 | 1     | 16-25
 2014 | 2     | 26-34
 2014 | 3     | 35-49
 2014 | 4     | 50-64
 2014 | 5     | 65-74
 2014 | 6     | 75+
 2014 | -1    | Item not applicable

"""
function toage( s :: Union{AbstractString,Missing} ) :: Union{Int,Missing}
    v = -1
    if ismissing(s) || (s in [" ", "-1"]) 
        return missing
    elseif s == "1"
        v = 20
    elseif s == "2"
        v = 30
    elseif s == "3"
        v = 40
    elseif s == "4"
        v = 57
    elseif s == "5"
        v = 70
    elseif s == "6"
        v = 80
    end 
    @assert v > 0 "|$s| not mapped"
    v
end