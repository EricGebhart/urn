#!/usr/bin/env lua
if not table.pack then table.pack = function(...) return { n = select("#", ...), ... } end end
if not table.unpack then table.unpack = unpack end
local load = load if _VERSION:find("5.1") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then error(e, 2) end if env then setfenv(f, env) end return f end end
local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error
local _libs = {}
local _temp = (function()
	return {
		['slice'] = function(xs, start, finish)
			if not finish then finish = xs.n end
			if not finish then finish = #xs end
			return { tag = "list", n = finish - start + 1, table.unpack(xs, start, finish) }
		end,
	}
end)()
for k, v in pairs(_temp) do _libs["lua/basic-0/".. k] = v end
local _temp = (function()
	-- A horrible hacky script to ensure that package.path is correct
	local directory = arg[0]:gsub("\\", "/"):gsub("urn/cli%.lisp", ""):gsub("urn/cli$", ""):gsub("tacky/cli%.lua$", "")
	if directory ~= "" and directory:sub(-1, -1) ~= "/" then
		directory = directory .. "/"
	end
	package.path = package.path .. package.config:sub(3, 3) .. directory .. "?.lua"
	return {}
end)()
for k, v in pairs(_temp) do _libs["urn/cli-16/".. k] = v end
local _ENV = setmetatable({}, {__index=ENV or (getfenv and getfenv()) or _G}) if setfenv then setfenv(0, _ENV) end
_3d_1 = function(v1, v2) return (v1 == v2) end
_2f3d_1 = function(v1, v2) return (v1 ~= v2) end
_3c_1 = function(v1, v2) return (v1 < v2) end
_3c3d_1 = function(v1, v2) return (v1 <= v2) end
_3e_1 = function(v1, v2) return (v1 > v2) end
_3e3d_1 = function(v1, v2) return (v1 >= v2) end
_2b_1 = function(v1, v2, ...) local t = (v1 + v2) for i = 1, _select('#', ...) do t = (t + _select(i, ...)) end return t end
_2d_1 = function(v1, v2, ...) local t = (v1 - v2) for i = 1, _select('#', ...) do t = (t - _select(i, ...)) end return t end
_2a_1 = function(v1, v2, ...) local t = (v1 * v2) for i = 1, _select('#', ...) do t = (t * _select(i, ...)) end return t end
_2f_1 = function(v1, v2, ...) local t = (v1 / v2) for i = 1, _select('#', ...) do t = (t / _select(i, ...)) end return t end
_25_1 = function(v1, v2, ...) local t = (v1 % v2) for i = 1, _select('#', ...) do t = (t % _select(i, ...)) end return t end
_2e2e_1 = function(v1, v2, ...) local t = (v1 .. v2) for i = _select('#', ...), 1, -1 do t = (_select(i, ...) .. t) end return t end
_5f_G1 = _G
arg_23_1 = arg
len_23_1 = function(v1) return #(v1) end
slice1 = _libs["lua/basic-0/slice"]
error1 = error
getmetatable1 = getmetatable
load1 = load
pcall1 = pcall
print1 = print
getIdx1 = function(v1, v2) return v1[v2] end
setIdx_21_1 = function(v1, v2, v3) v1[v2] = v3 end
require1 = require
setmetatable1 = setmetatable
tonumber1 = tonumber
tostring1 = tostring
type_23_1 = type
xpcall1 = xpcall
n1 = (function(x1)
	if (type_23_1(x1) == "table") then
		return x1["n"]
	else
		return #(x1)
	end
end)
byte1 = string.byte
char1 = string.char
find1 = string.find
format1 = string.format
gsub1 = string.gsub
lower1 = string.lower
match1 = string.match
rep1 = string.rep
sub1 = string.sub
upper1 = string.upper
concat1 = table.concat
remove1 = table.remove
sort1 = table.sort
unpack1 = table.unpack
iterPairs1 = function(x, f) for k, v in pairs(x) do f(k, v) end end
list1 = (function(...)
	local xs1 = _pack(...) xs1.tag = "list"
	return xs1
end)
cons1 = (function(x2, xs2)
	local _offset, _result, _temp = 0, {tag="list",n=0}
	_result[1 + _offset] = x2
	_temp = xs2
	for _c = 1, _temp.n do _result[1 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_result.n = _offset + 1
	return _result
end)
local counter1 = 0
gensym1 = (function(name1)
	if ((type_23_1(name1) == "table") and (name1["tag"] == "symbol")) then
		name1 = ("_" .. name1["contents"])
	elseif name1 then
		name1 = ("_" .. name1)
	else
		name1 = ""
	end
	counter1 = (counter1 + 1)
	return ({["tag"]="symbol",["contents"]=format1("r_%d%s", counter1, name1)})
end)
_2d_or1 = (function(a1, b1)
	return (a1 or b1)
end)
pretty1 = (function(value1)
	local ty1 = type_23_1(value1)
	if (ty1 == "table") then
		local tag1 = value1["tag"]
		if (tag1 == "list") then
			local out1 = ({tag = "list", n = 0})
			local r_51 = n1(value1)
			local r_31 = nil
			r_31 = (function(r_41)
				if (r_41 <= r_51) then
					out1[r_41] = pretty1(value1[r_41])
					return r_31((r_41 + 1))
				else
					return nil
				end
			end)
			r_31(1)
			return ("(" .. (concat1(out1, " ") .. ")"))
		elseif ((type_23_1(getmetatable1(value1)) == "table") and (type_23_1(getmetatable1(value1)["--pretty-print"]) == "function")) then
			return getmetatable1(value1)["--pretty-print"](value1)
		elseif (tag1 == "list") then
			return value1["contents"]
		elseif (tag1 == "symbol") then
			return value1["contents"]
		elseif (tag1 == "key") then
			return (":" .. value1["value"])
		elseif (tag1 == "string") then
			return format1("%q", value1["value"])
		elseif (tag1 == "number") then
			return tostring1(value1["value"])
		else
			local out2 = ({tag = "list", n = 0})
			iterPairs1(value1, (function(k1, v1)
				out2 = cons1((pretty1(k1) .. (" " .. pretty1(v1))), out2)
				return nil
			end))
			return ("{" .. (concat1(out2, " ") .. "}"))
		end
	elseif (ty1 == "string") then
		return format1("%q", value1)
	else
		return tostring1(value1)
	end
end)
if (nil == arg_23_1) then
	arg1 = ({tag = "list", n = 0})
else
	arg_23_1["tag"] = "list"
	if arg_23_1["n"] then
	else
		arg_23_1["n"] = #(arg_23_1)
	end
	arg1 = arg_23_1
end
constVal1 = (function(val1)
	if (type_23_1(val1) == "table") then
		local tag2 = val1["tag"]
		if (tag2 == "number") then
			return val1["value"]
		elseif (tag2 == "string") then
			return val1["value"]
		else
			return val1
		end
	else
		return val1
	end
end)
empty_3f_1 = (function(x3)
	local xt1 = type1(x3)
	if (xt1 == "list") then
		return (n1(x3) == 0)
	elseif (xt1 == "string") then
		return (#(x3) == 0)
	else
		return false
	end
end)
string_3f_1 = (function(x4)
	return ((type_23_1(x4) == "string") or ((type_23_1(x4) == "table") and (x4["tag"] == "string")))
end)
number_3f_1 = (function(x5)
	return ((type_23_1(x5) == "number") or ((type_23_1(x5) == "table") and (x5["tag"] == "number")))
end)
atom_3f_1 = (function(x6)
	return ((type_23_1(x6) ~= "table") or ((type_23_1(x6) == "table") and ((x6["tag"] == "symbol") or (x6["tag"] == "key"))))
end)
between_3f_1 = (function(val2, min1, max1)
	return ((val2 >= min1) and (val2 <= max1))
end)
type1 = (function(val3)
	local ty2 = type_23_1(val3)
	if (ty2 == "table") then
		return (val3["tag"] or "table")
	else
		return ty2
	end
end)
eq_3f_1 = (function(x7, y1)
	if (x7 == y1) then
		return true
	else
		local typeX1 = type1(x7)
		local typeY1 = type1(y1)
		if ((typeX1 == "list") and ((typeY1 == "list") and (n1(x7) == n1(y1)))) then
			local equal1 = true
			local r_291 = n1(x7)
			local r_271 = nil
			r_271 = (function(r_281)
				if (r_281 <= r_291) then
					if not eq_3f_1(x7[r_281], (y1[r_281])) then
						equal1 = false
					end
					return r_271((r_281 + 1))
				else
					return nil
				end
			end)
			r_271(1)
			return equal1
		elseif (("table" == type_23_1(x7)) and getmetatable1(x7)) then
			return getmetatable1(x7)["compare"](x7, y1)
		elseif (("table" == typeX1) and ("table" == typeY1)) then
			local equal2 = true
			iterPairs1(x7, (function(k2, v2)
				if not eq_3f_1(v2, (y1[k2])) then
					equal2 = false
					return nil
				else
					return nil
				end
			end))
			return equal2
		elseif (("symbol" == typeX1) and ("symbol" == typeY1)) then
			return (x7["contents"] == y1["contents"])
		elseif (("key" == typeX1) and ("key" == typeY1)) then
			return (x7["value"] == y1["value"])
		elseif (("symbol" == typeX1) and ("string" == typeY1)) then
			return (x7["contents"] == y1)
		elseif (("string" == typeX1) and ("symbol" == typeY1)) then
			return (x7 == y1["contents"])
		elseif (("key" == typeX1) and ("string" == typeY1)) then
			return (x7["value"] == y1)
		elseif (("string" == typeX1) and ("key" == typeY1)) then
			return (x7 == y1["value"])
		else
			return false
		end
	end
end)
abs1 = math.abs
huge1 = math.huge
max2 = math.max
min2 = math.min
modf1 = math.modf
car1 = (function(x8)
	local r_601 = type1(x8)
	if (r_601 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", r_601), 2)
	end
	return x8[1]
end)
cdr1 = (function(x9)
	local r_611 = type1(x9)
	if (r_611 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "x", "list", r_611), 2)
	end
	if empty_3f_1(x9) then
		return ({tag = "list", n = 0})
	else
		return slice1(x9, 2)
	end
end)
foldl1 = (function(f1, z1, xs3)
	local r_621 = type1(f1)
	if (r_621 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "f", "function", r_621), 2)
	end
	local r_631 = type1(xs3)
	if (r_631 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_631), 2)
	end
	local accum1 = z1
	local r_661 = n1(xs3)
	local r_641 = nil
	r_641 = (function(r_651)
		if (r_651 <= r_661) then
			accum1 = f1(accum1, xs3[r_651])
			return r_641((r_651 + 1))
		else
			return nil
		end
	end)
	r_641(1)
	return accum1
end)
map1 = (function(fn1, ...)
	local xss1 = _pack(...) xss1.tag = "list"
	local ns1
	local out3 = ({tag = "list", n = 0})
	local r_701 = n1(xss1)
	local r_681 = nil
	r_681 = (function(r_691)
		if (r_691 <= r_701) then
			if not (type1((xss1[r_691])) == "list") then
				error1(("not a list: " .. (pretty1(xss1[r_691]) .. (" (it's a " .. (type1(xss1[r_691]) .. ")")))))
			else
			end
			pushCdr_21_1(out3, n1(xss1[r_691]))
			return r_681((r_691 + 1))
		else
			return nil
		end
	end)
	r_681(1)
	ns1 = out3
	local out4 = ({tag = "list", n = 0})
	local r_421 = min2(unpack1(ns1, 1, n1(ns1)))
	local r_401 = nil
	r_401 = (function(r_411)
		if (r_411 <= r_421) then
			pushCdr_21_1(out4, (function(xs4)
				return fn1(unpack1(xs4, 1, n1(xs4)))
			end)(nths1(xss1, r_411)))
			return r_401((r_411 + 1))
		else
			return nil
		end
	end)
	r_401(1)
	return out4
end)
any1 = (function(p1, xs5)
	local r_821 = type1(p1)
	if (r_821 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "p", "function", r_821), 2)
	end
	local r_831 = type1(xs5)
	if (r_831 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_831), 2)
	end
	return accumulateWith1(p1, _2d_or1, false, xs5)
end)
elem_3f_1 = (function(x10, xs6)
	local r_861 = type1(xs6)
	if (r_861 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_861), 2)
	end
	return any1((function(y2)
		return eq_3f_1(x10, y2)
	end), xs6)
end)
last1 = (function(xs7)
	local r_891 = type1(xs7)
	if (r_891 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_891), 2)
	end
	return xs7[n1(xs7)]
end)
nths1 = (function(xss2, idx1)
	local out5 = ({tag = "list", n = 0})
	local r_501 = n1(xss2)
	local r_481 = nil
	r_481 = (function(r_491)
		if (r_491 <= r_501) then
			pushCdr_21_1(out5, xss2[r_491][idx1])
			return r_481((r_491 + 1))
		else
			return nil
		end
	end)
	r_481(1)
	return out5
end)
pushCdr_21_1 = (function(xs8, val4)
	local r_911 = type1(xs8)
	if (r_911 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_911), 2)
	end
	local len1 = (n1(xs8) + 1)
	xs8["n"] = len1
	xs8[len1] = val4
	return xs8
end)
popLast_21_1 = (function(xs9)
	local r_921 = type1(xs9)
	if (r_921 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "xs", "list", r_921), 2)
	end
	local x11 = xs9[n1(xs9)]
	xs9[n1(xs9)] = nil
	xs9["n"] = (n1(xs9) - 1)
	return x11
end)
removeNth_21_1 = (function(li1, idx2)
	local r_931 = type1(li1)
	if (r_931 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "li", "list", r_931), 2)
	end
	li1["n"] = (li1["n"] - 1)
	return remove1(li1, idx2)
end)
append1 = (function(xs10, ys1)
	local _offset, _result, _temp = 0, {tag="list",n=0}
	_temp = xs10
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_temp = ys1
	for _c = 1, _temp.n do _result[0 + _c + _offset] = _temp[_c] end
	_offset = _offset + _temp.n
	_result.n = _offset + 0
	return _result
end)
accumulateWith1 = (function(f2, ac1, z2, xs11)
	local r_951 = type1(f2)
	if (r_951 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "f", "function", r_951), 2)
	end
	local r_961 = type1(ac1)
	if (r_961 ~= "function") then
		error1(format1("bad argument %s (expected %s, got %s)", "ac", "function", r_961), 2)
	end
	return foldl1(ac1, z2, map1(f2, xs11))
end)
_2e2e_2 = (function(...)
	local args1 = _pack(...) args1.tag = "list"
	return concat1(args1)
end)
split1 = (function(text1, pattern1, limit1)
	local out6 = ({tag = "list", n = 0})
	local loop1 = true
	local start1 = 1
	local r_1071 = nil
	r_1071 = (function()
		if loop1 then
			local pos1 = list1(find1(text1, pattern1, start1))
			local nstart1 = car1(pos1)
			local nend1 = car1(cdr1(pos1))
			if ((nstart1 == nil) or (limit1 and (n1(out6) >= limit1))) then
				loop1 = false
				pushCdr_21_1(out6, sub1(text1, start1, n1(text1)))
				start1 = (n1(text1) + 1)
			elseif (nstart1 > n1(text1)) then
				if (start1 <= n1(text1)) then
					pushCdr_21_1(out6, sub1(text1, start1, n1(text1)))
				end
				loop1 = false
			elseif (nend1 < nstart1) then
				pushCdr_21_1(out6, sub1(text1, start1, nstart1))
				start1 = (nstart1 + 1)
			else
				pushCdr_21_1(out6, sub1(text1, start1, (nstart1 - 1)))
				start1 = (nend1 + 1)
			end
			return r_1071()
		else
			return nil
		end
	end)
	r_1071()
	return out6
end)
trim1 = (function(str1)
	return (gsub1(gsub1(str1, "^%s+", ""), "%s+$", ""))
end)
local escapes1 = ({})
local r_1031 = nil
r_1031 = (function(r_1041)
	if (r_1041 <= 31) then
		escapes1[char1(r_1041)] = _2e2e_2("\\", tostring1(r_1041))
		return r_1031((r_1041 + 1))
	else
		return nil
	end
end)
r_1031(0)
escapes1["\n"] = "n"
quoted1 = (function(str2)
	return (gsub1(format1("%q", str2), ".", escapes1))
end)
clock1 = os.clock
execute1 = os.execute
exit1 = os.exit
getenv1 = os.getenv
assoc1 = (function(list2, key1, orVal1)
	while true do
		if (not (type1(list2) == "list") or empty_3f_1(list2)) then
			return orVal1
		elseif eq_3f_1(car1(car1(list2)), key1) then
			return car1(cdr1(car1(list2)))
		else
			list2 = cdr1(list2)
		end
	end
end)
assoc_3f_1 = (function(list3, key2)
	while true do
		if (not (type1(list3) == "list") or empty_3f_1(list3)) then
			return false
		elseif eq_3f_1(car1(car1(list3)), key2) then
			return true
		else
			list3 = cdr1(list3)
		end
	end
end)
struct1 = (function(...)
	local entries1 = _pack(...) entries1.tag = "list"
	if ((n1(entries1) % 2) == 1) then
		error1("Expected an even number of arguments to struct", 2)
	end
	local out7 = ({})
	local r_1241 = n1(entries1)
	local r_1221 = nil
	r_1221 = (function(r_1231)
		if (r_1231 <= r_1241) then
			local key3 = entries1[r_1231]
			local val5 = entries1[(1 + r_1231)]
			out7[(function()
				if (type1(key3) == "key") then
					return key3["value"]
				else
					return key3
				end
			end)()
			] = val5
			return r_1221((r_1231 + 2))
		else
			return nil
		end
	end)
	r_1221(1)
	return out7
end)
values1 = (function(st1)
	local out8 = ({tag = "list", n = 0})
	iterPairs1(st1, (function(_5f_1, v3)
		return pushCdr_21_1(out8, v3)
	end))
	return out8
end)
createLookup1 = (function(values2)
	local res1 = ({})
	local r_1381 = n1(values2)
	local r_1361 = nil
	r_1361 = (function(r_1371)
		if (r_1371 <= r_1381) then
			res1[values2[r_1371]] = r_1371
			return r_1361((r_1371 + 1))
		else
			return nil
		end
	end)
	r_1361(1)
	return res1
end)
invokable_3f_1 = (function(x12)
	return ((type1(x12) == "function") or ((type_23_1(x12) == "table") and ((type_23_1((getmetatable1(x12))) == "table") and invokable_3f_1(getmetatable1(x12)["__call"]))))
end)
flush1 = io.flush
open1 = io.open
read1 = io.read
write1 = io.write
symbol_2d3e_string1 = (function(x13)
	if (type1(x13) == "symbol") then
		return x13["contents"]
	else
		return nil
	end
end)
fail_21_1 = (function(x14)
	return error1(x14, 0)
end)
exit_21_1 = (function(reason1, code1)
	local code2
	if string_3f_1(reason1) then
		code2 = code1
	else
		code2 = reason1
	end
	if string_3f_1(reason1) then
		print1(reason1)
	end
	return exit1(code2)
end)
id1 = (function(x15)
	return x15
end)
self1 = (function(x16, key4, ...)
	local args2 = _pack(...) args2.tag = "list"
	return x16[key4](x16, unpack1(args2, 1, n1(args2)))
end)
create1 = (function(description1)
	return ({["desc"]=description1,["flag-map"]=({}),["opt-map"]=({}),["opt"]=({tag = "list", n = 0}),["pos"]=({tag = "list", n = 0})})
end)
setAction1 = (function(arg2, data1, value2)
	data1[arg2["name"]] = value2
	return nil
end)
addAction1 = (function(arg3, data2, value3)
	local lst1 = data2[arg3["name"]]
	if lst1 then
	else
		lst1 = ({tag = "list", n = 0})
		data2[arg3["name"]] = lst1
	end
	return pushCdr_21_1(lst1, value3)
end)
setNumAction1 = (function(aspec1, data3, value4, usage_21_1)
	local val6 = tonumber1(value4)
	if val6 then
		data3[aspec1["name"]] = val6
		return nil
	else
		return usage_21_1(_2e2e_2("Expected number for ", car1(arg1["names"]), ", got ", value4))
	end
end)
addArgument_21_1 = (function(spec1, names1, ...)
	local options1 = _pack(...) options1.tag = "list"
	local r_2551 = type1(names1)
	if (r_2551 ~= "list") then
		error1(format1("bad argument %s (expected %s, got %s)", "names", "list", r_2551), 2)
	end
	if empty_3f_1(names1) then
		error1("Names list is empty")
	end
	if ((n1(options1) % 2) == 0) then
	else
		error1("Options list should be a multiple of two")
	end
	local result1 = ({["names"]=names1,["action"]=nil,["narg"]=0,["default"]=false,["help"]="",["value"]=true})
	local first1 = car1(names1)
	if (sub1(first1, 1, 2) == "--") then
		pushCdr_21_1(spec1["opt"], result1)
		result1["name"] = sub1(first1, 3)
	elseif (sub1(first1, 1, 1) == "-") then
		pushCdr_21_1(spec1["opt"], result1)
		result1["name"] = sub1(first1, 2)
	else
		result1["name"] = first1
		result1["narg"] = "*"
		result1["default"] = ({tag = "list", n = 0})
		pushCdr_21_1(spec1["pos"], result1)
	end
	local r_2601 = n1(names1)
	local r_2581 = nil
	r_2581 = (function(r_2591)
		if (r_2591 <= r_2601) then
			local name2 = names1[r_2591]
			if (sub1(name2, 1, 2) == "--") then
				spec1["opt-map"][sub1(name2, 3)] = result1
			elseif (sub1(name2, 1, 1) == "-") then
				spec1["flag-map"][sub1(name2, 2)] = result1
			end
			return r_2581((r_2591 + 1))
		else
			return nil
		end
	end)
	r_2581(1)
	local r_2641 = n1(options1)
	local r_2621 = nil
	r_2621 = (function(r_2631)
		if (r_2631 <= r_2641) then
			local key5 = options1[r_2631]
			result1[key5] = (options1[((r_2631 + 1))])
			return r_2621((r_2631 + 2))
		else
			return nil
		end
	end)
	r_2621(1)
	if result1["var"] then
	else
		result1["var"] = upper1(result1["name"])
	end
	if result1["action"] then
	else
		result1["action"] = (function()
			local temp1
			if number_3f_1(result1["narg"]) then
				temp1 = (result1["narg"] <= 1)
			else
				temp1 = (result1["narg"] == "?")
			end
			if temp1 then
				return setAction1
			else
				return addAction1
			end
		end)()
	end
	return result1
end)
addHelp_21_1 = (function(spec2)
	return addArgument_21_1(spec2, ({tag = "list", n = 2, "--help", "-h"}), "help", "Show this help message", "default", nil, "value", nil, "action", (function(arg4, result2, value5)
		help_21_1(spec2)
		return exit_21_1(0)
	end))
end)
helpNarg_21_1 = (function(buffer1, arg5)
	local r_3071 = arg5["narg"]
	if (r_3071 == "?") then
		return pushCdr_21_1(buffer1, _2e2e_2(" [", arg5["var"], "]"))
	elseif (r_3071 == "*") then
		return pushCdr_21_1(buffer1, _2e2e_2(" [", arg5["var"], "...]"))
	elseif (r_3071 == "+") then
		return pushCdr_21_1(buffer1, _2e2e_2(" ", arg5["var"], " [", arg5["var"], "...]"))
	else
		local r_3081 = nil
		r_3081 = (function(r_3091)
			if (r_3091 <= r_3071) then
				pushCdr_21_1(buffer1, _2e2e_2(" ", arg5["var"]))
				return r_3081((r_3091 + 1))
			else
				return nil
			end
		end)
		return r_3081(1)
	end
end)
usage_21_2 = (function(spec3, name3)
	if name3 then
	else
		name3 = (arg1[0] or (arg1[-1] or "?"))
	end
	local usage1 = list1("usage: ", name3)
	local r_2691 = spec3["opt"]
	local r_2721 = n1(r_2691)
	local r_2701 = nil
	r_2701 = (function(r_2711)
		if (r_2711 <= r_2721) then
			local arg6 = r_2691[r_2711]
			pushCdr_21_1(usage1, _2e2e_2(" [", car1(arg6["names"])))
			helpNarg_21_1(usage1, arg6)
			pushCdr_21_1(usage1, "]")
			return r_2701((r_2711 + 1))
		else
			return nil
		end
	end)
	r_2701(1)
	local r_2751 = spec3["pos"]
	local r_2781 = n1(r_2751)
	local r_2761 = nil
	r_2761 = (function(r_2771)
		if (r_2771 <= r_2781) then
			helpNarg_21_1(usage1, (r_2751[r_2771]))
			return r_2761((r_2771 + 1))
		else
			return nil
		end
	end)
	r_2761(1)
	return print1(concat1(usage1))
end)
help_21_1 = (function(spec4, name4)
	if name4 then
	else
		name4 = (arg1[0] or (arg1[-1] or "?"))
	end
	usage_21_2(spec4, name4)
	if spec4["desc"] then
		print1()
		print1(spec4["desc"])
	end
	local max3 = 0
	local r_2831 = spec4["pos"]
	local r_2861 = n1(r_2831)
	local r_2841 = nil
	r_2841 = (function(r_2851)
		if (r_2851 <= r_2861) then
			local arg7 = r_2831[r_2851]
			local len2 = n1(arg7["var"])
			if (len2 > max3) then
				max3 = len2
			end
			return r_2841((r_2851 + 1))
		else
			return nil
		end
	end)
	r_2841(1)
	local r_2891 = spec4["opt"]
	local r_2921 = n1(r_2891)
	local r_2901 = nil
	r_2901 = (function(r_2911)
		if (r_2911 <= r_2921) then
			local arg8 = r_2891[r_2911]
			local len3 = n1(concat1(arg8["names"], ", "))
			if (len3 > max3) then
				max3 = len3
			end
			return r_2901((r_2911 + 1))
		else
			return nil
		end
	end)
	r_2901(1)
	local fmt1 = _2e2e_2(" %-", tostring1((max3 + 1)), "s %s")
	if empty_3f_1(spec4["pos"]) then
	else
		print1()
		print1("Positional arguments")
		local r_2951 = spec4["pos"]
		local r_2981 = n1(r_2951)
		local r_2961 = nil
		r_2961 = (function(r_2971)
			if (r_2971 <= r_2981) then
				local arg9 = r_2951[r_2971]
				print1(format1(fmt1, arg9["var"], arg9["help"]))
				return r_2961((r_2971 + 1))
			else
				return nil
			end
		end)
		r_2961(1)
	end
	if empty_3f_1(spec4["opt"]) then
		return nil
	else
		print1()
		print1("Optional arguments")
		local r_3011 = spec4["opt"]
		local r_3041 = n1(r_3011)
		local r_3021 = nil
		r_3021 = (function(r_3031)
			if (r_3031 <= r_3041) then
				local arg10 = r_3011[r_3031]
				print1(format1(fmt1, concat1(arg10["names"], ", "), arg10["help"]))
				return r_3021((r_3031 + 1))
			else
				return nil
			end
		end)
		return r_3021(1)
	end
end)
matcher1 = (function(pattern2)
	return (function(x17)
		local res2 = list1(match1(x17, pattern2))
		if (car1(res2) == nil) then
			return nil
		else
			return res2
		end
	end)
end)
parse_21_1 = (function(spec5, args3)
	if args3 then
	else
		args3 = arg1
	end
	local result3 = ({})
	local pos2 = spec5["pos"]
	local idx3 = 1
	local len4 = n1(args3)
	local usage_21_3 = (function(msg1)
		usage_21_2(spec5, (args3[0]))
		print1(msg1)
		return exit_21_1(1)
	end)
	local readArgs1 = (function(key6, arg11)
		local r_3431 = arg11["narg"]
		if (r_3431 == "+") then
			idx3 = (idx3 + 1)
			local elem1 = args3[idx3]
			if (elem1 == nil) then
				local msg2 = _2e2e_2("Expected ", arg11["var"], " after --", key6, ", got nothing")
				usage_21_2(spec5, (args3[0]))
				print1(msg2)
				exit_21_1(1)
			elseif (not arg11["all"] and find1(elem1, "^%-")) then
				local msg3 = _2e2e_2("Expected ", arg11["var"], " after --", key6, ", got ", args3[idx3])
				usage_21_2(spec5, (args3[0]))
				print1(msg3)
				exit_21_1(1)
			else
				arg11["action"](arg11, result3, elem1, usage_21_3)
			end
			local running1 = true
			local r_3451 = nil
			r_3451 = (function()
				if running1 then
					idx3 = (idx3 + 1)
					local elem2 = args3[idx3]
					if (elem2 == nil) then
						running1 = false
					elseif (not arg11["all"] and find1(elem2, "^%-")) then
						running1 = false
					else
						arg11["action"](arg11, result3, elem2, usage_21_3)
					end
					return r_3451()
				else
					return nil
				end
			end)
			return r_3451()
		elseif (r_3431 == "*") then
			local running2 = true
			local r_3471 = nil
			r_3471 = (function()
				if running2 then
					idx3 = (idx3 + 1)
					local elem3 = args3[idx3]
					if (elem3 == nil) then
						running2 = false
					elseif (not arg11["all"] and find1(elem3, "^%-")) then
						running2 = false
					else
						arg11["action"](arg11, result3, elem3, usage_21_3)
					end
					return r_3471()
				else
					return nil
				end
			end)
			return r_3471()
		elseif (r_3431 == "?") then
			idx3 = (idx3 + 1)
			local elem4 = args3[idx3]
			if ((elem4 == nil) or (not arg11["all"] and find1(elem4, "^%-"))) then
				return arg11["action"](arg11, result3, arg11["value"])
			else
				idx3 = (idx3 + 1)
				return arg11["action"](arg11, result3, elem4, usage_21_3)
			end
		elseif (r_3431 == 0) then
			idx3 = (idx3 + 1)
			local value6 = arg11["value"]
			return arg11["action"](arg11, result3, value6, usage_21_3)
		else
			local r_3511 = nil
			r_3511 = (function(r_3521)
				if (r_3521 <= r_3431) then
					idx3 = (idx3 + 1)
					local elem5 = args3[idx3]
					if (elem5 == nil) then
						local msg4 = _2e2e_2("Expected ", r_3431, " args for ", key6, ", got ", (r_3521 - 1))
						usage_21_2(spec5, (args3[0]))
						print1(msg4)
						exit_21_1(1)
					elseif (not arg11["all"] and find1(elem5, "^%-")) then
						local msg5 = _2e2e_2("Expected ", r_3431, " for ", key6, ", got ", (r_3521 - 1))
						usage_21_2(spec5, (args3[0]))
						print1(msg5)
						exit_21_1(1)
					else
						arg11["action"](arg11, result3, elem5, usage_21_3)
					end
					return r_3511((r_3521 + 1))
				else
					return nil
				end
			end)
			r_3511(1)
			idx3 = (idx3 + 1)
			return nil
		end
	end)
	local r_3061 = nil
	r_3061 = (function()
		if (idx3 <= len4) then
			local r_3121 = args3[idx3]
			local temp2
			local r_3131 = matcher1("^%-%-([^=]+)=(.+)$")(r_3121)
			temp2 = ((type1(r_3131) == "list") and ((n1(r_3131) >= 2) and ((n1(r_3131) <= 2) and true)))
			if temp2 then
				local key7 = matcher1("^%-%-([^=]+)=(.+)$")(r_3121)[1]
				local val7 = matcher1("^%-%-([^=]+)=(.+)$")(r_3121)[2]
				local arg12 = spec5["opt-map"][key7]
				if (arg12 == nil) then
					local msg6 = _2e2e_2("Unknown argument ", key7, " in ", args3[idx3])
					usage_21_2(spec5, (args3[0]))
					print1(msg6)
					exit_21_1(1)
				elseif (not arg12["many"] and (nil ~= result3[arg12["name"]])) then
					local msg7 = _2e2e_2("Too may values for ", key7, " in ", args3[idx3])
					usage_21_2(spec5, (args3[0]))
					print1(msg7)
					exit_21_1(1)
				else
					local narg1 = arg12["narg"]
					if (number_3f_1(narg1) and (narg1 ~= 1)) then
						local msg8 = _2e2e_2("Expected ", tostring1(narg1), " values, got 1 in ", args3[idx3])
						usage_21_2(spec5, (args3[0]))
						print1(msg8)
						exit_21_1(1)
					end
					arg12["action"](arg12, result3, val7, usage_21_3)
				end
				idx3 = (idx3 + 1)
			else
				local temp3
				local r_3141 = matcher1("^%-%-(.*)$")(r_3121)
				temp3 = ((type1(r_3141) == "list") and ((n1(r_3141) >= 1) and ((n1(r_3141) <= 1) and true)))
				if temp3 then
					local key8 = matcher1("^%-%-(.*)$")(r_3121)[1]
					local arg13 = spec5["opt-map"][key8]
					if (arg13 == nil) then
						local msg9 = _2e2e_2("Unknown argument ", key8, " in ", args3[idx3])
						usage_21_2(spec5, (args3[0]))
						print1(msg9)
						exit_21_1(1)
					elseif (not arg13["many"] and (nil ~= result3[arg13["name"]])) then
						local msg10 = _2e2e_2("Too may values for ", key8, " in ", args3[idx3])
						usage_21_2(spec5, (args3[0]))
						print1(msg10)
						exit_21_1(1)
					else
						readArgs1(key8, arg13)
					end
				else
					local temp4
					local r_3151 = matcher1("^%-(.+)$")(r_3121)
					temp4 = ((type1(r_3151) == "list") and ((n1(r_3151) >= 1) and ((n1(r_3151) <= 1) and true)))
					if temp4 then
						local flags1 = matcher1("^%-(.+)$")(r_3121)[1]
						local i1 = 1
						local s1 = n1(flags1)
						local r_3291 = nil
						r_3291 = (function()
							if (i1 <= s1) then
								local key9
								local x18 = i1
								key9 = sub1(flags1, x18, x18)
								local arg14 = spec5["flag-map"][key9]
								if (arg14 == nil) then
									local msg11 = _2e2e_2("Unknown flag ", key9, " in ", args3[idx3])
									usage_21_2(spec5, (args3[0]))
									print1(msg11)
									exit_21_1(1)
								elseif (not arg14["many"] and (nil ~= result3[arg14["name"]])) then
									local msg12 = _2e2e_2("Too many occurances of ", key9, " in ", args3[idx3])
									usage_21_2(spec5, (args3[0]))
									print1(msg12)
									exit_21_1(1)
								else
									local narg2 = arg14["narg"]
									if (i1 == s1) then
										readArgs1(key9, arg14)
									elseif (narg2 == 0) then
										local value7 = arg14["value"]
										arg14["action"](arg14, result3, value7, usage_21_3)
									else
										local value8 = sub1(flags1, (i1 + 1))
										arg14["action"](arg14, result3, value8, usage_21_3)
										i1 = (s1 + 1)
										idx3 = (idx3 + 1)
									end
								end
								i1 = (i1 + 1)
								return r_3291()
							else
								return nil
							end
						end)
						r_3291()
					else
						local arg15 = car1(spec5["pos"])
						if arg15 then
							arg15["action"](arg15, result3, r_3121, usage_21_3)
						else
							local msg13 = _2e2e_2("Unknown argument ", arg15)
							usage_21_2(spec5, (args3[0]))
							print1(msg13)
							exit_21_1(1)
						end
						idx3 = (idx3 + 1)
					end
				end
			end
			return r_3061()
		else
			return nil
		end
	end)
	r_3061()
	local r_3321 = spec5["opt"]
	local r_3351 = n1(r_3321)
	local r_3331 = nil
	r_3331 = (function(r_3341)
		if (r_3341 <= r_3351) then
			local arg16 = r_3321[r_3341]
			if (result3[arg16["name"]] == nil) then
				result3[arg16["name"]] = arg16["default"]
			end
			return r_3331((r_3341 + 1))
		else
			return nil
		end
	end)
	r_3331(1)
	local r_3381 = spec5["pos"]
	local r_3411 = n1(r_3381)
	local r_3391 = nil
	r_3391 = (function(r_3401)
		if (r_3401 <= r_3411) then
			local arg17 = r_3381[r_3401]
			if (result3[arg17["name"]] == nil) then
				result3[arg17["name"]] = arg17["default"]
			end
			return r_3391((r_3401 + 1))
		else
			return nil
		end
	end)
	r_3391(1)
	return result3
end)
builtins1 = require1("tacky.analysis.resolve")["builtins"]
builtinVars1 = require1("tacky.analysis.resolve")["declaredVars"]
builtin_3f_1 = (function(node1, name5)
	return ((type1(node1) == "symbol") and (node1["var"] == builtins1[name5]))
end)
sideEffect_3f_1 = (function(node2)
	local tag3 = type1(node2)
	if ((tag3 == "number") or ((tag3 == "string") or ((tag3 == "key") or (tag3 == "symbol")))) then
		return false
	elseif (tag3 == "list") then
		local fst1 = car1(node2)
		if (type1(fst1) == "symbol") then
			local var1 = fst1["var"]
			return ((var1 ~= builtins1["lambda"]) and (var1 ~= builtins1["quote"]))
		else
			return true
		end
	else
		_error("unmatched item")
	end
end)
constant_3f_1 = (function(node3)
	return (string_3f_1(node3) or (number_3f_1(node3) or (type1(node3) == "key")))
end)
urn_2d3e_val1 = (function(node4)
	if string_3f_1(node4) then
		return node4["value"]
	elseif number_3f_1(node4) then
		return node4["value"]
	elseif (type1(node4) == "key") then
		return node4["value"]
	else
		_error("unmatched item")
	end
end)
val_2d3e_urn1 = (function(val8)
	if (type_23_1(val8) == "string") then
		return ({["tag"]="string",["value"]=val8})
	elseif (type_23_1(val8) == "number") then
		return ({["tag"]="number",["value"]=val8})
	elseif (type_23_1(val8) == "nil") then
		return ({["tag"]="symbol",["contents"]="nil",["var"]=builtins1["nil"]})
	elseif (type_23_1(val8) == "boolean") then
		return ({["tag"]="symbol",["contents"]=tostring1(val8),["var"]=builtins1[tostring1(val8)]})
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(type_23_1(val8)), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"nil\"`\n  Tried: `\"boolean\"`"))
	end
end)
urn_2d3e_bool1 = (function(node5)
	if (string_3f_1(node5) or ((type1(node5) == "key") or number_3f_1(node5))) then
		return true
	elseif (type1(node5) == "symbol") then
		if (builtins1["true"] == node5["var"]) then
			return true
		elseif (builtins1["false"] == node5["var"]) then
			return false
		elseif (builtins1["nil"] == node5["var"]) then
			return false
		else
			return nil
		end
	else
		return nil
	end
end)
makeProgn1 = (function(body1)
	return ({tag = "list", n = 1, (function()
		local _offset, _result, _temp = 0, {tag="list",n=0}
		_result[1 + _offset] = (function(var2)
			return ({["tag"]="symbol",["contents"]=var2["name"],["var"]=var2})
		end)(builtins1["lambda"])
		_result[2 + _offset] = ({tag = "list", n = 0})
		_temp = body1
		for _c = 1, _temp.n do _result[2 + _c + _offset] = _temp[_c] end
		_offset = _offset + _temp.n
		_result.n = _offset + 2
		return _result
	end)()
	})
end)
makeSymbol1 = (function(var3)
	return ({["tag"]="symbol",["contents"]=var3["name"],["var"]=var3})
end)
symbol_2d3e_var1 = (function(state1, symb1)
	local var4 = symb1["var"]
	if string_3f_1(var4) then
		return state1["variables"][var4]
	else
		return var4
	end
end)
local r_3771 = builtins1["nil"]
makeNil1 = (function()
	return ({["tag"]="symbol",["contents"]=r_3771["name"],["var"]=r_3771})
end)
fastAll1 = (function(fn2, li2, i2)
	while true do
		if (i2 > n1(li2)) then
			return true
		elseif fn2(li2[i2]) then
			i2 = (i2 + 1)
		else
			return false
		end
	end
end)
startTimer_21_1 = (function(timer1, name6, level1)
	local instance1 = timer1["timers"][name6]
	if instance1 then
	else
		instance1 = ({["name"]=name6,["level"]=(level1 or 1),["running"]=false,["total"]=0})
		timer1["timers"][name6] = instance1
	end
	if instance1["running"] then
		error1(_2e2e_2("Timer ", name6, " is already running"))
	end
	instance1["running"] = true
	instance1["start"] = clock1()
	return nil
end)
pauseTimer_21_1 = (function(timer2, name7)
	local instance2 = timer2["timers"][name7]
	if instance2 then
	else
		error1(_2e2e_2("Timer ", name7, " does not exist"))
	end
	if instance2["running"] then
	else
		error1(_2e2e_2("Timer ", name7, " is not running"))
	end
	instance2["running"] = false
	instance2["total"] = ((clock1() - instance2["start"]) + instance2["total"])
	return nil
end)
stopTimer_21_1 = (function(timer3, name8)
	local instance3 = timer3["timers"][name8]
	if instance3 then
	else
		error1(_2e2e_2("Timer ", name8, " does not exist"))
	end
	if instance3["running"] then
	else
		error1(_2e2e_2("Timer ", name8, " is not running"))
	end
	timer3["timers"][name8] = nil
	instance3["total"] = ((clock1() - instance3["start"]) + instance3["total"])
	return timer3["callback"](instance3["name"], instance3["total"], instance3["level"])
end)
void1 = ({["callback"]=(function()
	return nil
end),["timers"]=({})})
config1 = package.config
loaded1 = package.loaded
coloredAnsi1 = (function(col1, msg14)
	return _2e2e_2("\27[", col1, "m", msg14, "\27[0m")
end)
if (config1 and (sub1(config1, 1, 1) ~= "\\")) then
	colored_3f_1 = true
elseif (getenv1 and (getenv1("ANSICON") ~= nil)) then
	colored_3f_1 = true
else
	local temp5
	if getenv1 then
		local term1 = getenv1("TERM")
		if term1 then
			temp5 = find1(term1, "xterm")
		else
			temp5 = nil
		end
	else
		temp5 = false
	end
	if temp5 then
		colored_3f_1 = true
	else
		colored_3f_1 = false
	end
end
if colored_3f_1 then
	colored1 = coloredAnsi1
else
	colored1 = (function(col2, msg15)
		return msg15
	end)
end
putError_21_1 = (function(logger1, msg16)
	return self1(logger1, "put-error!", msg16)
end)
putWarning_21_1 = (function(logger2, msg17)
	return self1(logger2, "put-warning!", msg17)
end)
putVerbose_21_1 = (function(logger3, msg18)
	return self1(logger3, "put-verbose!", msg18)
end)
putDebug_21_1 = (function(logger4, msg19)
	return self1(logger4, "put-debug!", msg19)
end)
putNodeError_21_1 = (function(logger5, msg20, node6, explain1, ...)
	local lines1 = _pack(...) lines1.tag = "list"
	return self1(logger5, "put-node-error!", msg20, node6, explain1, lines1)
end)
putNodeWarning_21_1 = (function(logger6, msg21, node7, explain2, ...)
	local lines2 = _pack(...) lines2.tag = "list"
	return self1(logger6, "put-node-warning!", msg21, node7, explain2, lines2)
end)
doNodeError_21_1 = (function(logger7, msg22, node8, explain3, ...)
	local lines3 = _pack(...) lines3.tag = "list"
	self1(logger7, "put-node-error!", msg22, node8, explain3, lines3)
	return error1((match1(msg22, "^([^\n]+)\n") or msg22), 0)
end)
loaded1["tacky.logger.init"] = ({["startTimer"]=startTimer_21_1,["pauseTimer"]=pauseTimer_21_1,["stopTimer"]=stopTimer_21_1,["putError"]=putError_21_1,["putWarning"]=putWarning_21_1,["putVerbose"]=putVerbose_21_1,["putDebug"]=putDebug_21_1,["putNodeError"]=putNodeError_21_1,["putNodeWarning"]=putNodeWarning_21_1,["doNodeError"]=doNodeError_21_1,["colored"]=colored1})
passEnabled_3f_1 = (function(pass1, options2)
	local override1 = options2["override"]
	if (override1[pass1["name"]] == true) then
		return true
	elseif (override1[pass1["name"]] == false) then
		return false
	elseif any1((function(cat1)
		return (override1[cat1] == true)
	end), pass1["cat"]) then
		return true
	elseif any1((function(cat2)
		return (override1[cat2] == false)
	end), pass1["cat"]) then
		return false
	else
		return ((pass1["on"] ~= false) and (options2["level"] >= (pass1["level"] or 1)))
	end
end)
runPass1 = (function(pass2, options3, tracker1, ...)
	local args4 = _pack(...) args4.tag = "list"
	if passEnabled_3f_1(pass2, options3) then
		local ptracker1 = ({["changed"]=false})
		local name9 = _2e2e_2("[", concat1(pass2["cat"], " "), "] ", pass2["name"])
		startTimer_21_1(options3["timer"], name9, 2)
		pass2["run"](ptracker1, options3, unpack1(args4, 1, n1(args4)))
		stopTimer_21_1(options3["timer"], name9)
		if ptracker1["changed"] then
			if options3["track"] then
				self1(options3["logger"], "put-verbose!", (_2e2e_2(name9, " did something.")))
			end
			if tracker1 then
				tracker1["changed"] = true
			end
		end
		return ptracker1["changed"]
	else
		return nil
	end
end)
builtins2 = require1("tacky.analysis.resolve")["builtins"]
traverseQuote1 = (function(node9, visitor1, level2)
	if (level2 == 0) then
		return traverseNode1(node9, visitor1)
	else
		local tag4 = node9["tag"]
		if ((tag4 == "string") or ((tag4 == "number") or ((tag4 == "key") or (tag4 == "symbol")))) then
			return node9
		elseif (tag4 == "list") then
			local first2 = node9[1]
			if (first2 and (first2["tag"] == "symbol")) then
				if ((first2["contents"] == "unquote") or (first2["contents"] == "unquote-splice")) then
					node9[2] = traverseQuote1(node9[2], visitor1, (level2 - 1))
					return node9
				elseif (first2["contents"] == "syntax-quote") then
					node9[2] = traverseQuote1(node9[2], visitor1, (level2 + 1))
					return node9
				else
					local r_4051 = n1(node9)
					local r_4031 = nil
					r_4031 = (function(r_4041)
						if (r_4041 <= r_4051) then
							node9[r_4041] = traverseQuote1(node9[r_4041], visitor1, level2)
							return r_4031((r_4041 + 1))
						else
							return nil
						end
					end)
					r_4031(1)
					return node9
				end
			else
				local r_4091 = n1(node9)
				local r_4071 = nil
				r_4071 = (function(r_4081)
					if (r_4081 <= r_4091) then
						node9[r_4081] = traverseQuote1(node9[r_4081], visitor1, level2)
						return r_4071((r_4081 + 1))
					else
						return nil
					end
				end)
				r_4071(1)
				return node9
			end
		elseif error1 then
			return _2e2e_2("Unknown tag ", tag4)
		else
			_error("unmatched item")
		end
	end
end)
traverseNode1 = (function(node10, visitor2)
	local tag5 = node10["tag"]
	if ((tag5 == "string") or ((tag5 == "number") or ((tag5 == "key") or (tag5 == "symbol")))) then
		return visitor2(node10, visitor2)
	elseif (tag5 == "list") then
		local first3 = car1(node10)
		first3 = visitor2(first3, visitor2)
		node10[1] = first3
		if (first3["tag"] == "symbol") then
			local func1 = first3["var"]
			local funct1 = func1["tag"]
			if (func1 == builtins2["lambda"]) then
				traverseBlock1(node10, 3, visitor2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["cond"]) then
				local r_4131 = n1(node10)
				local r_4111 = nil
				r_4111 = (function(r_4121)
					if (r_4121 <= r_4131) then
						local case1 = node10[r_4121]
						case1[1] = traverseNode1(case1[1], visitor2)
						traverseBlock1(case1, 2, visitor2)
						return r_4111((r_4121 + 1))
					else
						return nil
					end
				end)
				r_4111(2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["set!"]) then
				node10[3] = traverseNode1(node10[3], visitor2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["quote"]) then
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["syntax-quote"]) then
				node10[2] = traverseQuote1(node10[2], visitor2, 1)
				return visitor2(node10, visitor2)
			elseif ((func1 == builtins2["unquote"]) or (func1 == builtins2["unquote-splice"])) then
				return error1("unquote/unquote-splice should never appear head", 0)
			elseif ((func1 == builtins2["define"]) or (func1 == builtins2["define-macro"])) then
				node10[n1(node10)] = traverseNode1(node10[(n1(node10))], visitor2)
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["define-native"]) then
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["import"]) then
				return visitor2(node10, visitor2)
			elseif (func1 == builtins2["struct-literal"]) then
				traverseList1(node10, 2, visitor2)
				return visitor2(node10, visitor2)
			elseif ((funct1 == "defined") or ((funct1 == "arg") or ((funct1 == "native") or (funct1 == "macro")))) then
				traverseList1(node10, 1, visitor2)
				return visitor2(node10, visitor2)
			else
				return error1(_2e2e_2("Unknown kind ", funct1, " for variable ", func1["name"]), 0)
			end
		else
			traverseList1(node10, 1, visitor2)
			return visitor2(node10, visitor2)
		end
	else
		return error1(_2e2e_2("Unknown tag ", tag5))
	end
end)
traverseBlock1 = (function(node11, start2, visitor3)
	local r_3921 = n1(node11)
	local r_3901 = nil
	r_3901 = (function(r_3911)
		if (r_3911 <= r_3921) then
			node11[r_3911] = (traverseNode1(node11[((r_3911 + 0))], visitor3))
			return r_3901((r_3911 + 1))
		else
			return nil
		end
	end)
	r_3901(start2)
	return node11
end)
traverseList1 = (function(node12, start3, visitor4)
	local r_3961 = n1(node12)
	local r_3941 = nil
	r_3941 = (function(r_3951)
		if (r_3951 <= r_3961) then
			node12[r_3951] = traverseNode1(node12[r_3951], visitor4)
			return r_3941((r_3951 + 1))
		else
			return nil
		end
	end)
	r_3941(start3)
	return node12
end)
builtins3 = require1("tacky.analysis.resolve")["builtins"]
visitQuote1 = (function(node13, visitor5, level3)
	while true do
		if (level3 == 0) then
			return visitNode1(node13, visitor5)
		else
			local tag6 = node13["tag"]
			if ((tag6 == "string") or ((tag6 == "number") or ((tag6 == "key") or (tag6 == "symbol")))) then
				return nil
			elseif (tag6 == "list") then
				local first4 = node13[1]
				if (first4 and (first4["tag"] == "symbol")) then
					if ((first4["contents"] == "unquote") or (first4["contents"] == "unquote-splice")) then
						node13, level3 = node13[2], (level3 - 1)
					elseif (first4["contents"] == "syntax-quote") then
						node13, level3 = node13[2], (level3 + 1)
					else
						local r_4441 = n1(node13)
						local r_4421 = nil
						r_4421 = (function(r_4431)
							if (r_4431 <= r_4441) then
								visitQuote1(node13[r_4431], visitor5, level3)
								return r_4421((r_4431 + 1))
							else
								return nil
							end
						end)
						return r_4421(1)
					end
				else
					local r_4501 = n1(node13)
					local r_4481 = nil
					r_4481 = (function(r_4491)
						if (r_4491 <= r_4501) then
							visitQuote1(node13[r_4491], visitor5, level3)
							return r_4481((r_4491 + 1))
						else
							return nil
						end
					end)
					return r_4481(1)
				end
			elseif error1 then
				return _2e2e_2("Unknown tag ", tag6)
			else
				_error("unmatched item")
			end
		end
	end
end)
visitNode1 = (function(node14, visitor6)
	while true do
		if (visitor6(node14, visitor6) == false) then
			return nil
		else
			local tag7 = node14["tag"]
			if ((tag7 == "string") or ((tag7 == "number") or ((tag7 == "key") or (tag7 == "symbol")))) then
				return nil
			elseif (tag7 == "list") then
				local first5 = node14[1]
				if (first5["tag"] == "symbol") then
					local func2 = first5["var"]
					local funct2 = func2["tag"]
					if (func2 == builtins3["lambda"]) then
						return visitBlock1(node14, 3, visitor6)
					elseif (func2 == builtins3["cond"]) then
						local r_4541 = n1(node14)
						local r_4521 = nil
						r_4521 = (function(r_4531)
							if (r_4531 <= r_4541) then
								local case2 = node14[r_4531]
								visitNode1(case2[1], visitor6)
								visitBlock1(case2, 2, visitor6)
								return r_4521((r_4531 + 1))
							else
								return nil
							end
						end)
						return r_4521(2)
					elseif (func2 == builtins3["set!"]) then
						node14 = node14[3]
					elseif (func2 == builtins3["quote"]) then
						return nil
					elseif (func2 == builtins3["syntax-quote"]) then
						return visitQuote1(node14[2], visitor6, 1)
					elseif ((func2 == builtins3["unquote"]) or (func2 == builtins3["unquote-splice"])) then
						return error1("unquote/unquote-splice should never appear here", 0)
					elseif ((func2 == builtins3["define"]) or (func2 == builtins3["define-macro"])) then
						node14 = node14[(n1(node14))]
					elseif (func2 == builtins3["define-native"]) then
						return nil
					elseif (func2 == builtins3["import"]) then
						return nil
					elseif (func2 == builtins3["struct-literal"]) then
						return visitBlock1(node14, 2, visitor6)
					elseif ((funct2 == "defined") or ((funct2 == "arg") or ((funct2 == "native") or (funct2 == "macro")))) then
						return visitBlock1(node14, 1, visitor6)
					else
						return error1(_2e2e_2("Unknown kind ", funct2, " for variable ", func2["name"]), 0)
					end
				else
					return visitBlock1(node14, 1, visitor6)
				end
			else
				return error1(_2e2e_2("Unknown tag ", tag7))
			end
		end
	end
end)
visitBlock1 = (function(node15, start4, visitor7)
	local r_4331 = n1(node15)
	local r_4311 = nil
	r_4311 = (function(r_4321)
		if (r_4321 <= r_4331) then
			visitNode1(node15[r_4321], visitor7)
			return r_4311((r_4321 + 1))
		else
			return nil
		end
	end)
	return r_4311(start4)
end)
getVar1 = (function(state2, var5)
	local entry1 = state2["vars"][var5]
	if entry1 then
	else
		entry1 = ({["var"]=var5,["usages"]=({tag = "list", n = 0}),["defs"]=({tag = "list", n = 0}),["active"]=false})
		state2["vars"][var5] = entry1
	end
	return entry1
end)
addUsage_21_1 = (function(state3, var6, node16)
	local varMeta1 = getVar1(state3, var6)
	pushCdr_21_1(varMeta1["usages"], node16)
	varMeta1["active"] = true
	return nil
end)
addDefinition_21_1 = (function(state4, var7, node17, kind1, value9)
	return pushCdr_21_1(getVar1(state4, var7)["defs"], ({["tag"]=kind1,["node"]=node17,["value"]=value9}))
end)
definitionsVisitor1 = (function(state5, node18, visitor8)
	if ((type1(node18) == "list") and (type1((car1(node18))) == "symbol")) then
		local func3 = car1(node18)["var"]
		if (func3 == builtins1["lambda"]) then
			local r_4621 = node18[2]
			local r_4651 = n1(r_4621)
			local r_4631 = nil
			r_4631 = (function(r_4641)
				if (r_4641 <= r_4651) then
					local arg18 = r_4621[r_4641]
					addDefinition_21_1(state5, arg18["var"], arg18, "var", arg18["var"])
					return r_4631((r_4641 + 1))
				else
					return nil
				end
			end)
			return r_4631(1)
		elseif (func3 == builtins1["set!"]) then
			return addDefinition_21_1(state5, node18[2]["var"], node18, "val", node18[3])
		elseif ((func3 == builtins1["define"]) or (func3 == builtins1["define-macro"])) then
			return addDefinition_21_1(state5, node18["defVar"], node18, "val", node18[(n1(node18))])
		elseif (func3 == builtins1["define-native"]) then
			return addDefinition_21_1(state5, node18["defVar"], node18, "var", node18["defVar"])
		else
			return nil
		end
	elseif ((type1(node18) == "list") and ((type1((car1(node18))) == "list") and ((type1((car1(car1(node18)))) == "symbol") and (car1(car1(node18))["var"] == builtins1["lambda"])))) then
		local lam1 = car1(node18)
		local args5 = lam1[2]
		local offset1 = 1
		local i3 = 1
		local argLen1 = n1(args5)
		local r_4711 = nil
		r_4711 = (function()
			if (i3 <= argLen1) then
				local arg19 = args5[i3]
				local val9 = node18[((i3 + offset1))]
				if arg19["var"]["isVariadic"] then
					local count1 = (n1(node18) - n1(args5))
					if (count1 < 0) then
						count1 = 0
					end
					offset1 = count1
					addDefinition_21_1(state5, arg19["var"], arg19, "var", arg19["var"])
				elseif (((i3 + offset1) == n1(node18)) and ((i3 < argLen1) and (type1(val9) == "list"))) then
					local r_4741 = nil
					r_4741 = (function(r_4751)
						if (r_4751 <= argLen1) then
							local arg20 = args5[r_4751]
							addDefinition_21_1(state5, arg20["var"], arg20, "var", arg20)
							return r_4741((r_4751 + 1))
						else
							return nil
						end
					end)
					r_4741(i3)
					i3 = argLen1
				else
					addDefinition_21_1(state5, arg19["var"], arg19, "val", (val9 or ({["tag"]="symbol",["contents"]="nil",["var"]=builtins1["nil"]})))
				end
				i3 = (i3 + 1)
				return r_4711()
			else
				return nil
			end
		end)
		r_4711()
		visitBlock1(node18, 2, visitor8)
		visitBlock1(lam1, 3, visitor8)
		return false
	else
		return nil
	end
end)
definitionsVisit1 = (function(state6, nodes1)
	return visitBlock1(nodes1, 1, (function(r_4901, r_4911)
		return definitionsVisitor1(state6, r_4901, r_4911)
	end))
end)
usagesVisit1 = (function(state7, nodes2, pred1)
	if pred1 then
	else
		pred1 = (function()
			return true
		end)
	end
	local queue1 = ({tag = "list", n = 0})
	local visited1 = ({})
	local addUsage1 = (function(var8, user1)
		local varMeta2 = getVar1(state7, var8)
		if varMeta2["active"] then
		else
			local r_4841 = varMeta2["defs"]
			local r_4871 = n1(r_4841)
			local r_4851 = nil
			r_4851 = (function(r_4861)
				if (r_4861 <= r_4871) then
					local def1 = r_4841[r_4861]
					local val10 = def1["value"]
					if ((def1["tag"] == "val") and not visited1[val10]) then
						pushCdr_21_1(queue1, val10)
					end
					return r_4851((r_4861 + 1))
				else
					return nil
				end
			end)
			r_4851(1)
		end
		return addUsage_21_1(state7, var8, user1)
	end)
	local visit1 = (function(node19)
		if visited1[node19] then
			return false
		else
			visited1[node19] = true
			if (type1(node19) == "symbol") then
				addUsage1(node19["var"], node19)
				return true
			elseif ((type1(node19) == "list") and ((n1(node19) > 0) and (type1((car1(node19))) == "symbol"))) then
				local func4 = car1(node19)["var"]
				if ((func4 == builtins1["set!"]) or ((func4 == builtins1["define"]) or (func4 == builtins1["define-macro"]))) then
					if pred1(node19[3]) then
						return true
					else
						return false
					end
				else
					return true
				end
			else
				return true
			end
		end
	end)
	local r_4251 = n1(nodes2)
	local r_4231 = nil
	r_4231 = (function(r_4241)
		if (r_4241 <= r_4251) then
			pushCdr_21_1(queue1, (nodes2[r_4241]))
			return r_4231((r_4241 + 1))
		else
			return nil
		end
	end)
	r_4231(1)
	local r_4271 = nil
	r_4271 = (function()
		if (n1(queue1) > 0) then
			visitNode1(popLast_21_1(queue1), visit1)
			return r_4271()
		else
			return nil
		end
	end)
	return r_4271()
end)
tagUsage1 = ({["name"]="tag-usage",["help"]="Gathers usage and definition data for all expressions in NODES, storing it in LOOKUP.",["cat"]=({tag = "list", n = 2, "tag", "usage"}),["run"]=(function(r_4921, state8, nodes3, lookup1)
	definitionsVisit1(lookup1, nodes3)
	return usagesVisit1(lookup1, nodes3, sideEffect_3f_1)
end)})
fusionPatterns1 = ({tag = "list", n = 0})
metavar_3f_1 = (function(x19)
	return ((x19["var"] == nil) and (sub1(symbol_2d3e_string1(x19), 1, 1) == "?"))
end)
genvar_3f_1 = (function(x20)
	return ((x20["var"] == nil) and (sub1(symbol_2d3e_string1(x20), 1, 1) == "%"))
end)
peq_3f_1 = (function(x21, y3, out9)
	if (x21 == y3) then
		return true
	else
		local tyX1 = type1(x21)
		local tyY1 = type1(y3)
		if ((tyX1 == "symbol") and metavar_3f_1(x21)) then
			out9[symbol_2d3e_string1(x21)] = y3
			return true
		elseif (tyX1 ~= tyY1) then
			return false
		elseif (tyX1 == "symbol") then
			return (x21["var"] == y3["var"])
		elseif (tyX1 == "string") then
			return (constVal1(x21) == constVal1(y3))
		elseif (tyX1 == "number") then
			return (constVal1(x21) == constVal1(y3))
		elseif (tyX1 == "key") then
			return (constVal1(x21) == constVal1(y3))
		elseif (tyX1 == "list") then
			if (n1(x21) == n1(y3)) then
				local ok1 = true
				local r_4981 = n1(x21)
				local r_4961 = nil
				r_4961 = (function(r_4971)
					if (r_4971 <= r_4981) then
						if (ok1 and not peq_3f_1(x21[r_4971], y3[r_4971], out9)) then
							ok1 = false
						end
						return r_4961((r_4971 + 1))
					else
						return nil
					end
				end)
				r_4961(1)
				return ok1
			else
				return false
			end
		else
			_error("unmatched item")
		end
	end
end)
substitute1 = (function(x22, subs1, syms1)
	local r_5011 = type1(x22)
	if (r_5011 == "string") then
		return x22
	elseif (r_5011 == "number") then
		return x22
	elseif (r_5011 == "key") then
		return x22
	elseif (r_5011 == "symbol") then
		if metavar_3f_1(x22) then
			local res3 = subs1[symbol_2d3e_string1(x22)]
			if (res3 == nil) then
				error1(_2e2e_2("Unknown capture ", pretty1(x22)), 0)
			end
			return res3
		elseif genvar_3f_1(x22) then
			local name10 = symbol_2d3e_string1(x22)
			local sym1 = syms1[name10]
			if sym1 then
			else
				sym1 = gensym1()
				sym1["var"] = ({["tag"]="arg",["name"]=symbol_2d3e_string1(sym1)})
				syms1[name10] = sym1
			end
			return sym1
		else
			local var9 = x22["var"]
			return ({["tag"]="symbol",["contents"]=var9["name"],["var"]=var9})
		end
	elseif (r_5011 == "list") then
		return map1((function(r_5051)
			return substitute1(r_5051, subs1, syms1)
		end), x22)
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5011), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
end)
fixPattern_21_1 = (function(state9, ptrn1)
	local r_5031 = type1(ptrn1)
	if (r_5031 == "string") then
		return ptrn1
	elseif (r_5031 == "number") then
		return ptrn1
	elseif (r_5031 == "symbol") then
		if ptrn1["var"] then
			local var10 = symbol_2d3e_var1(state9, ptrn1)
			return ({["tag"]="symbol",["contents"]=var10["name"],["var"]=var10})
		else
			return ptrn1
		end
	elseif (r_5031 == "list") then
		return map1((function(r_5061)
			return fixPattern_21_1(state9, r_5061)
		end), ptrn1)
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5031), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
end)
fixRule_21_1 = (function(state10, rule1)
	return ({["from"]=fixPattern_21_1(state10, rule1["from"]),["to"]=fixPattern_21_1(state10, rule1["to"])})
end)
fusion1 = ({["name"]="fusion",["help"]="Merges various loops together as specified by a pattern.",["cat"]=({tag = "list", n = 1, "opt"}),["on"]=false,["run"]=(function(r_4922, state11, nodes4)
	local patterns1 = map1((function(r_5131)
		return fixRule_21_1(state11["compiler"], r_5131)
	end), fusionPatterns1)
	return traverseBlock1(nodes4, 1, (function(node20)
		if (type1(node20) == "list") then
			local r_5111 = n1(patterns1)
			local r_5091 = nil
			r_5091 = (function(r_5101)
				if (r_5101 <= r_5111) then
					local ptrn2 = patterns1[r_5101]
					local subs2 = ({})
					if peq_3f_1(ptrn2["from"], node20, subs2) then
						r_4922["changed"] = true
						node20 = substitute1(ptrn2["to"], subs2, ({}))
					end
					return r_5091((r_5101 + 1))
				else
					return nil
				end
			end)
			r_5091(1)
		end
		return node20
	end))
end)})
addRule_21_1 = (function(rule2)
	local r_5041 = type1(rule2)
	if (r_5041 ~= "table") then
		error1(format1("bad argument %s (expected %s, got %s)", "rule", "table", r_5041), 2)
	end
	pushCdr_21_1(fusionPatterns1, rule2)
	return nil
end)
formatPosition1 = (function(pos3)
	return _2e2e_2(pos3["line"], ":", pos3["column"])
end)
formatRange1 = (function(range1)
	if range1["finish"] then
		return format1("%s:[%s .. %s]", range1["name"], (function(pos4)
			return _2e2e_2(pos4["line"], ":", pos4["column"])
		end)(range1["start"]), (function(pos5)
			return _2e2e_2(pos5["line"], ":", pos5["column"])
		end)(range1["finish"]))
	else
		return format1("%s:[%s]", range1["name"], (function(pos6)
			return _2e2e_2(pos6["line"], ":", pos6["column"])
		end)(range1["start"]))
	end
end)
formatNode1 = (function(node21)
	if (node21["range"] and node21["contents"]) then
		return format1("%s (%s)", formatRange1(node21["range"]), quoted1(node21["contents"]))
	elseif node21["range"] then
		return formatRange1(node21["range"])
	elseif node21["owner"] then
		local owner1 = node21["owner"]
		if owner1["var"] then
			return format1("macro expansion of %s (%s)", owner1["var"]["name"], formatNode1(owner1["node"]))
		else
			return format1("unquote expansion (%s)", formatNode1(owner1["node"]))
		end
	elseif (node21["start"] and node21["finish"]) then
		return formatRange1(node21)
	else
		return "?"
	end
end)
getSource1 = (function(node22)
	local result4 = nil
	local r_5161 = nil
	r_5161 = (function()
		if (node22 and not result4) then
			result4 = node22["range"]
			node22 = node22["parent"]
			return r_5161()
		else
			return nil
		end
	end)
	r_5161()
	return result4
end)
loaded1["tacky.range"] = ({["formatPosition"]=formatPosition1,["formatRange"]=formatRange1,["formatNode"]=formatNode1,["getSource"]=getSource1})
stripImport1 = ({["name"]="strip-import",["help"]="Strip all import expressions in NODES",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4923, state12, nodes5)
	local r_5181 = nil
	r_5181 = (function(r_5191)
		if (r_5191 >= 1) then
			local node23 = nodes5[r_5191]
			if ((type1(node23) == "list") and ((n1(node23) > 0) and ((type1((car1(node23))) == "symbol") and (car1(node23)["var"] == builtins1["import"])))) then
				if (r_5191 == n1(nodes5)) then
					nodes5[r_5191] = makeNil1()
				else
					removeNth_21_1(nodes5, r_5191)
				end
				r_4923["changed"] = true
			end
			return r_5181((r_5191 + -1))
		else
			return nil
		end
	end)
	return r_5181(n1(nodes5))
end)})
stripPure1 = ({["name"]="strip-pure",["help"]="Strip all pure expressions in NODES (apart from the last one).",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4924, state13, nodes6)
	local r_5251 = nil
	r_5251 = (function(r_5261)
		if (r_5261 >= 1) then
			if sideEffect_3f_1((nodes6[r_5261])) then
			else
				removeNth_21_1(nodes6, r_5261)
				r_4924["changed"] = true
			end
			return r_5251((r_5261 + -1))
		else
			return nil
		end
	end)
	return r_5251((n1(nodes6) - 1))
end)})
constantFold1 = ({["name"]="constant-fold",["help"]="A primitive constant folder\n\nThis simply finds function calls with constant functions and looks up the function.\nIf the function is native and pure then we'll execute it and replace the node with the\nresult. There are a couple of caveats:\n\n - If the function call errors then we will flag a warning and continue.\n - If this returns a decimal (or infinity or NaN) then we'll continue: we cannot correctly\n   accurately handle this.\n - If this doesn't return exactly one value then we will stop. This might be a future enhancement.",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4925, state14, nodes7)
	return traverseList1(nodes7, 1, (function(node24)
		if ((type1(node24) == "list") and fastAll1(constant_3f_1, node24, 2)) then
			local head1 = car1(node24)
			local meta1 = ((type1(head1) == "symbol") and (not head1["folded"] and ((head1["var"]["tag"] == "native") and state14["meta"][head1["var"]["fullName"]])))
			if (meta1 and (meta1["pure"] and meta1["value"])) then
				local res4 = list1(pcall1(meta1["value"], unpack1(map1(urn_2d3e_val1, cdr1(node24)), 1, (n1(node24) - 1))))
				if car1(res4) then
					local val11 = res4[2]
					if ((n1(res4) ~= 2) or (number_3f_1(val11) and ((car1(cdr1((list1(modf1(val11))))) ~= 0) or (abs1(val11) == huge1)))) then
						head1["folded"] = true
						return node24
					else
						r_4925["changed"] = true
						return val_2d3e_urn1(val11)
					end
				else
					head1["folded"] = true
					putNodeWarning_21_1(state14["logger"], _2e2e_2("Cannot execute constant expression"), node24, nil, getSource1(node24), _2e2e_2("Executed ", pretty1(node24), ", failed with: ", res4[2]))
					return node24
				end
			else
				return node24
			end
		else
			return node24
		end
	end))
end)})
condFold1 = ({["name"]="cond-fold",["help"]="Simplify all `cond` nodes, removing `false` branches and killing\nall branches after a `true` one.",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4926, state15, nodes8)
	return traverseList1(nodes8, 1, (function(node25)
		if ((type1(node25) == "list") and ((type1((car1(node25))) == "symbol") and (car1(node25)["var"] == builtins1["cond"]))) then
			local final1 = false
			local i4 = 2
			local r_5401 = nil
			r_5401 = (function()
				if (i4 <= n1(node25)) then
					local elem6 = node25[i4]
					if final1 then
						r_4926["changed"] = true
						removeNth_21_1(node25, i4)
					else
						local r_5411 = urn_2d3e_bool1(car1(elem6))
						if eq_3f_1(r_5411, false) then
							r_4926["changed"] = true
							removeNth_21_1(node25, i4)
						elseif eq_3f_1(r_5411, true) then
							final1 = true
							i4 = (i4 + 1)
						elseif eq_3f_1(r_5411, nil) then
							i4 = (i4 + 1)
						else
							error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_5411), ", but none matched.\n", "  Tried: `false`\n  Tried: `true`\n  Tried: `nil`"))
						end
					end
					return r_5401()
				else
					return nil
				end
			end)
			r_5401()
			if ((n1(node25) == 2) and (urn_2d3e_bool1(car1(node25[2])) == true)) then
				r_4926["changed"] = true
				local body2 = cdr1(node25[2])
				if (n1(body2) == 1) then
					return car1(body2)
				else
					return makeProgn1(cdr1(node25[2]))
				end
			else
				return node25
			end
		else
			return node25
		end
	end))
end)})
lambdaFold1 = ({["name"]="lambda-fold",["help"]="Simplify all directly called lambdas, inlining them were appropriate.",["cat"]=({tag = "list", n = 1, "opt"}),["run"]=(function(r_4927, state16, nodes9)
	return traverseList1(nodes9, 1, (function(node26)
		if ((type1(node26) == "list") and ((n1(node26) == 1) and ((type1((car1(node26))) == "list") and (builtin_3f_1(car1(car1(node26)), "lambda") and ((n1(car1(node26)) == 3) and empty_3f_1(car1(node26)[2])))))) then
			r_4927["changed"] = true
			return car1(node26)[3]
		else
			return node26
		end
	end))
end)})
getConstantVal1 = (function(lookup2, sym2)
	local var11 = sym2["var"]
	local def2 = getVar1(lookup2, sym2["var"])
	if (var11 == builtins1["true"]) then
		return sym2
	elseif (var11 == builtins1["false"]) then
		return sym2
	elseif (var11 == builtins1["nil"]) then
		return sym2
	elseif (n1(def2["defs"]) == 1) then
		local ent1 = car1(def2["defs"])
		local val12 = ent1["value"]
		local ty3 = ent1["tag"]
		if (string_3f_1(val12) or (number_3f_1(val12) or (type1(val12) == "key"))) then
			return val12
		elseif ((type1(val12) == "symbol") and (ty3 == "val")) then
			return (getConstantVal1(lookup2, val12) or sym2)
		else
			return sym2
		end
	else
		return nil
	end
end)
stripDefs1 = ({["name"]="strip-defs",["help"]="Strip all unused top level definitions.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_4928, state17, nodes10, lookup3)
	local r_5521 = nil
	r_5521 = (function(r_5531)
		if (r_5531 >= 1) then
			local node27 = nodes10[r_5531]
			if (node27["defVar"] and not getVar1(lookup3, node27["defVar"])["active"]) then
				if (r_5531 == n1(nodes10)) then
					nodes10[r_5531] = makeNil1()
				else
					removeNth_21_1(nodes10, r_5531)
				end
				r_4928["changed"] = true
			end
			return r_5521((r_5531 + -1))
		else
			return nil
		end
	end)
	return r_5521(n1(nodes10))
end)})
stripArgs1 = ({["name"]="strip-args",["help"]="Strip all unused, pure arguments in directly called lambdas.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_4929, state18, nodes11, lookup4)
	return visitBlock1(nodes11, 1, (function(node28)
		if ((type1(node28) == "list") and ((type1((car1(node28))) == "list") and ((type1((car1(car1(node28)))) == "symbol") and (car1(car1(node28))["var"] == builtins1["lambda"])))) then
			local lam2 = car1(node28)
			local args6 = lam2[2]
			local offset2 = 1
			local remOffset1 = 0
			local removed1 = ({})
			local r_5621 = n1(args6)
			local r_5601 = nil
			r_5601 = (function(r_5611)
				if (r_5611 <= r_5621) then
					local arg21 = args6[((r_5611 - remOffset1))]
					local val13 = node28[(((r_5611 + offset2) - remOffset1))]
					if arg21["var"]["isVariadic"] then
						local count2 = (n1(node28) - n1(args6))
						if (count2 < 0) then
							count2 = 0
						end
						offset2 = count2
					elseif (nil == val13) then
					elseif sideEffect_3f_1(val13) then
					elseif (n1(getVar1(lookup4, arg21["var"])["usages"]) > 0) then
					else
						r_4929["changed"] = true
						removed1[args6[((r_5611 - remOffset1))]["var"]] = true
						removeNth_21_1(args6, (r_5611 - remOffset1))
						removeNth_21_1(node28, ((r_5611 + offset2) - remOffset1))
						remOffset1 = (remOffset1 + 1)
					end
					return r_5601((r_5611 + 1))
				else
					return nil
				end
			end)
			r_5601(1)
			if (remOffset1 > 0) then
				return traverseList1(lam2, 3, (function(node29)
					if ((type1(node29) == "list") and (builtin_3f_1(car1(node29), "set!") and removed1[node29[2]["var"]])) then
						local val14 = node29[3]
						if sideEffect_3f_1(val14) then
							return makeProgn1(list1(val14, makeNil1()))
						else
							return makeNil1()
						end
					else
						return node29
					end
				end))
			else
				return nil
			end
		else
			return nil
		end
	end))
end)})
variableFold1 = ({["name"]="variable-fold",["help"]="Folds constant variable accesses",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_49210, state19, nodes12, lookup5)
	return traverseList1(nodes12, 1, (function(node30)
		if (type1(node30) == "symbol") then
			local var12 = getConstantVal1(lookup5, node30)
			if (var12 and (var12 ~= node30)) then
				r_49210["changed"] = true
				return var12
			else
				return node30
			end
		else
			return node30
		end
	end))
end)})
expressionFold1 = ({["name"]="expression-fold",["help"]="Folds basic variable accesses where execution order will not change.\n\nFor instance, converts ((lambda (x) (+ x 1)) (Y)) to (+ Y 1) in the case\nwhere Y is an arbitrary expression.\n\nThere are a couple of complexities in the implementation here. Firstly, we\nwant to ensure that the arguments are executed in the correct order and only\nonce.\n\nIn order to achieve this, we find the lambda forms and visit the body, stopping\nif we visit arguments in the wrong order or non-constant terms such as mutable\nvariables or other function calls. For simplicities sake, we fail if we hit\nother lambdas or conds as that makes analysing control flow significantly more\ncomplex.\n\nAnother source of added complexity is the case where where Y could return multiple\nvalues: namely in the last argument to function calls. Here it is an invalid optimisation\nto just place Y, as that could result in additional values being passed to the function.\n\nIn order to avoid this, Y will get converted to the form ((lambda (<tmp>) <tmp>) Y).\nThis is understood by the codegen and so is not as inefficient as it looks. However, we do\nhave to take additional steps to avoid trying to fold the above again and again.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_49211, state20, nodes13, lookup6)
	return visitBlock1(nodes13, 1, (function(root1)
		if ((type1(root1) == "list") and ((type1((car1(root1))) == "list") and ((type1((car1(car1(root1)))) == "symbol") and (car1(car1(root1))["var"] == builtins1["lambda"])))) then
			local lam3
			local args7
			local len5
			local validate1
			lam3 = car1(root1)
			args7 = lam3[2]
			len5 = n1(args7)
			validate1 = (function(i5)
				if (i5 > len5) then
					return true
				else
					local arg22 = args7[i5]
					local var13 = arg22["var"]
					local entry2 = getVar1(lookup6, var13)
					if var13["isVariadic"] then
						return false
					elseif (n1(entry2["defs"]) ~= 1) then
						return false
					elseif (car1(entry2["defs"])["tag"] == "var") then
						return false
					elseif (n1(entry2["usages"]) ~= 1) then
						return false
					else
						return validate1((i5 + 1))
					end
				end
			end)
			if ((len5 > 0) and (((n1(root1) ~= 2) or ((len5 ~= 1) or ((n1(lam3) ~= 3) or (atom_3f_1(root1[2]) or (not (type1((lam3[3])) == "symbol") or (lam3[3]["var"] ~= car1(args7)["var"])))))) and validate1(1))) then
				local currentIdx1 = 1
				local argMap1 = ({})
				local wrapMap1 = ({})
				local ok2 = true
				local finished1 = false
				local r_6091 = n1(args7)
				local r_6071 = nil
				r_6071 = (function(r_6081)
					if (r_6081 <= r_6091) then
						argMap1[args7[r_6081]["var"]] = r_6081
						return r_6071((r_6081 + 1))
					else
						return nil
					end
				end)
				r_6071(1)
				visitBlock1(lam3, 3, (function(node31, visitor9)
					if ok2 then
						local r_6111 = type1(node31)
						if (r_6111 == "string") then
							return nil
						elseif (r_6111 == "number") then
							return nil
						elseif (r_6111 == "key") then
							return nil
						elseif (r_6111 == "symbol") then
							local idx4 = argMap1[node31["var"]]
							if (idx4 == nil) then
								if (n1(getVar1(lookup6, node31["var"])["defs"]) > 1) then
									ok2 = false
									return false
								else
									return nil
								end
							elseif (idx4 == currentIdx1) then
								currentIdx1 = (currentIdx1 + 1)
								if (currentIdx1 > len5) then
									finished1 = true
									return nil
								else
									return nil
								end
							else
								ok2 = false
								return false
							end
						elseif (r_6111 == "list") then
							local head2 = car1(node31)
							if (type1(head2) == "symbol") then
								local var14 = head2["var"]
								if (var14 == builtins1["set!"]) then
									visitNode1(node31[3], visitor9)
								elseif (var14 == builtins1["define"]) then
									visitNode1(last1(node31), visitor9)
								elseif (var14 == builtins1["define-macro"]) then
									visitNode1(last1(node31), visitor9)
								elseif (var14 == builtins1["define-native"]) then
								elseif (var14 == builtins1["cond"]) then
									visitNode1(car1(node31[2]), visitor9)
								elseif (var14 == builtins1["lambda"]) then
								elseif (var14 == builtins1["quote"]) then
								elseif (var14 == builtins1["import"]) then
								elseif (var14 == builtins1["syntax-quote"]) then
									visitQuote1(node31[2], visitor9, 1)
								elseif (var14 == builtins1["struct-literal"]) then
									visitBlock1(node31, 2, visitor9)
								else
									visitBlock1(node31, 1, visitor9)
								end
								if (n1(node31) > 1) then
									local last2 = node31[(n1(node31))]
									if (type1(last2) == "symbol") then
										local idx5 = argMap1[last2["var"]]
										if idx5 then
											if (type1(((root1[(idx5 + 1)]))) == "list") then
												wrapMap1[idx5] = true
											end
										end
									end
								end
								if finished1 then
								elseif (var14 == builtins1["set!"]) then
									ok2 = false
								elseif (var14 == builtins1["cond"]) then
									ok2 = false
								elseif (var14 == builtins1["lambda"]) then
									ok2 = false
								else
									ok2 = false
								end
								return false
							else
								ok2 = false
								return false
							end
						else
							return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_6111), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
						end
					else
						return false
					end
				end))
				if (ok2 and finished1) then
					r_49211["changed"] = true
					traverseList1(root1, 1, (function(child1)
						if (type1(child1) == "symbol") then
							local var15 = child1["var"]
							local i6 = argMap1[var15]
							if i6 then
								if wrapMap1[i6] then
									return ({tag = "list", n = 2, ({tag = "list", n = 3, (function(var16)
										return ({["tag"]="symbol",["contents"]=var16["name"],["var"]=var16})
									end)(builtins1["lambda"]), ({tag = "list", n = 1, ({["tag"]="symbol",["contents"]=var15["name"],["var"]=var15})}), ({["tag"]="symbol",["contents"]=var15["name"],["var"]=var15})}), root1[((i6 + 1))]})
								else
									return (root1[((i6 + 1))] or makeNil1())
								end
							else
								return child1
							end
						else
							return child1
						end
					end))
					local r_6141 = nil
					r_6141 = (function(r_6151)
						if (r_6151 >= 2) then
							removeNth_21_1(root1, r_6151)
							return r_6141((r_6151 + -1))
						else
							return nil
						end
					end)
					r_6141(n1(root1))
					local r_6181 = nil
					r_6181 = (function(r_6191)
						if (r_6191 >= 1) then
							removeNth_21_1(args7, r_6191)
							return r_6181((r_6191 + -1))
						else
							return nil
						end
					end)
					return r_6181(n1(args7))
				else
					return nil
				end
			else
				return nil
			end
		else
			return nil
		end
	end))
end)})
condEliminate1 = ({["name"]="cond-eliminate",["help"]="Replace variables with known truthy/falsey values with `true` or `false` when used in branches.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["run"]=(function(r_49212, state21, nodes14, varLookup1)
	local lookup7 = ({})
	return visitBlock1(nodes14, 1, (function(node32, visitor10, isCond1)
		local r_5701 = type1(node32)
		if (r_5701 == "symbol") then
			if isCond1 then
				local r_5711 = lookup7[node32["var"]]
				if eq_3f_1(r_5711, false) then
					local var17 = builtins1["false"]
					return ({["tag"]="symbol",["contents"]=var17["name"],["var"]=var17})
				elseif eq_3f_1(r_5711, true) then
					local var18 = builtins1["true"]
					return ({["tag"]="symbol",["contents"]=var18["name"],["var"]=var18})
				else
					return nil
				end
			else
				return nil
			end
		elseif (r_5701 == "list") then
			local head3 = car1(node32)
			local r_5721 = type1(head3)
			if (r_5721 == "symbol") then
				if builtin_3f_1(head3, "cond") then
					local vars1 = ({tag = "list", n = 0})
					local r_5751 = n1(node32)
					local r_5731 = nil
					r_5731 = (function(r_5741)
						if (r_5741 <= r_5751) then
							local entry3 = node32[r_5741]
							local test1 = car1(entry3)
							local len6 = n1(entry3)
							local var19 = ((type1(test1) == "symbol") and test1["var"])
							if var19 then
								if (lookup7[var19] ~= nil) then
									var19 = nil
								elseif (n1(getVar1(varLookup1, var19)["defs"]) > 1) then
									var19 = nil
								end
							end
							local r_5771 = visitor10(test1, visitor10, true)
							if eq_3f_1(r_5771, nil) then
								visitNode1(test1, visitor10)
							elseif eq_3f_1(r_5771, false) then
							else
								r_49212["changed"] = true
								entry3[1] = r_5771
							end
							if var19 then
								pushCdr_21_1(vars1, var19)
								lookup7[var19] = true
							end
							local r_5801 = (len6 - 1)
							local r_5781 = nil
							r_5781 = (function(r_5791)
								if (r_5791 <= r_5801) then
									visitNode1(entry3[r_5791], visitor10)
									return r_5781((r_5791 + 1))
								else
									return nil
								end
							end)
							r_5781(2)
							if (len6 > 1) then
								local last3 = entry3[len6]
								local r_5821 = visitor10(last3, visitor10, isCond1)
								if eq_3f_1(r_5821, nil) then
									visitNode1(last3, visitor10)
								elseif eq_3f_1(r_5821, false) then
								else
									r_49212["changed"] = true
									entry3[len6] = r_5821
								end
							end
							if var19 then
								lookup7[var19] = false
							end
							return r_5731((r_5741 + 1))
						else
							return nil
						end
					end)
					r_5731(2)
					local r_5881 = n1(vars1)
					local r_5861 = nil
					r_5861 = (function(r_5871)
						if (r_5871 <= r_5881) then
							lookup7[vars1[r_5871]] = nil
							return r_5861((r_5871 + 1))
						else
							return nil
						end
					end)
					r_5861(1)
					return false
				else
					return nil
				end
			elseif (r_5721 == "list") then
				if (isCond1 and builtin_3f_1(car1(head3), "lambda")) then
					local r_5931 = n1(node32)
					local r_5911 = nil
					r_5911 = (function(r_5921)
						if (r_5921 <= r_5931) then
							visitNode1(node32[r_5921], visitor10)
							return r_5911((r_5921 + 1))
						else
							return nil
						end
					end)
					r_5911(2)
					local len7 = n1(head3)
					local r_5971 = (len7 - 1)
					local r_5951 = nil
					r_5951 = (function(r_5961)
						if (r_5961 <= r_5971) then
							visitNode1(head3[r_5961], visitor10)
							return r_5951((r_5961 + 1))
						else
							return nil
						end
					end)
					r_5951(3)
					if (len7 > 2) then
						local last4 = head3[len7]
						local r_5991 = visitor10(last4, visitor10, isCond1)
						if eq_3f_1(r_5991, nil) then
							visitNode1(last4, visitor10)
						elseif eq_3f_1(r_5991, false) then
						else
							r_49212["changed"] = true
							node32[head3] = r_5991
						end
					end
					return false
				else
					return nil
				end
			else
				return nil
			end
		else
			return nil
		end
	end))
end)})
scope_2f_child1 = require1("tacky.analysis.scope")["child"]
scope_2f_add_21_1 = require1("tacky.analysis.scope")["add"]
copyOf1 = (function(x23)
	local res5 = ({})
	iterPairs1(x23, (function(k3, v4)
		res5[k3] = v4
		return nil
	end))
	return res5
end)
getScope1 = (function(scope1, lookup8, n2)
	local newScope1 = lookup8["scopes"][scope1]
	if newScope1 then
		return newScope1
	else
		local newScope2 = scope_2f_child1()
		lookup8["scopes"][scope1] = newScope2
		return newScope2
	end
end)
getVar2 = (function(var20, lookup9)
	return (lookup9["vars"][var20] or var20)
end)
copyNode1 = (function(node33, lookup10)
	local r_6231 = type1(node33)
	if (r_6231 == "string") then
		return copyOf1(node33)
	elseif (r_6231 == "key") then
		return copyOf1(node33)
	elseif (r_6231 == "number") then
		return copyOf1(node33)
	elseif (r_6231 == "symbol") then
		local copy1 = copyOf1(node33)
		local oldVar1 = node33["var"]
		local newVar1 = getVar2(oldVar1, lookup10)
		if ((oldVar1 ~= newVar1) and (oldVar1["node"] == node33)) then
			newVar1["node"] = copy1
		end
		copy1["var"] = newVar1
		return copy1
	elseif (r_6231 == "list") then
		if builtin_3f_1(car1(node33), "lambda") then
			local args8 = car1(cdr1(node33))
			if empty_3f_1(args8) then
			else
				local newScope3 = scope_2f_child1(getScope1(car1(args8)["var"]["scope"], lookup10, node33))
				local r_6371 = n1(args8)
				local r_6351 = nil
				r_6351 = (function(r_6361)
					if (r_6361 <= r_6371) then
						local arg23 = args8[r_6361]
						local var21 = arg23["var"]
						local newVar2 = scope_2f_add_21_1(newScope3, var21["name"], var21["tag"], nil)
						newVar2["isVariadic"] = var21["isVariadic"]
						lookup10["vars"][var21] = newVar2
						return r_6351((r_6361 + 1))
					else
						return nil
					end
				end)
				r_6351(1)
			end
		end
		local res6 = copyOf1(node33)
		local r_6411 = n1(res6)
		local r_6391 = nil
		r_6391 = (function(r_6401)
			if (r_6401 <= r_6411) then
				res6[r_6401] = copyNode1(res6[r_6401], lookup10)
				return r_6391((r_6401 + 1))
			else
				return nil
			end
		end)
		r_6391(1)
		return res6
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_6231), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"key\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
end)
scoreNode1 = (function(node34)
	local r_6251 = type1(node34)
	if (r_6251 == "string") then
		return 0
	elseif (r_6251 == "key") then
		return 0
	elseif (r_6251 == "number") then
		return 0
	elseif (r_6251 == "symbol") then
		return 1
	elseif (r_6251 == "list") then
		if (type1(car1(node34)) == "symbol") then
			local func5 = car1(node34)["var"]
			if (func5 == builtins1["lambda"]) then
				return scoreNodes1(node34, 3, 10)
			elseif (func5 == builtins1["cond"]) then
				return scoreNodes1(node34, 2, 10)
			elseif (func5 == builtins1["set!"]) then
				return scoreNodes1(node34, 2, 5)
			elseif (func5 == builtins1["quote"]) then
				return scoreNodes1(node34, 2, 2)
			elseif (func5 == builtins1["quasi-quote"]) then
				return scoreNodes1(node34, 2, 3)
			elseif (func5 == builtins1["unquote-splice"]) then
				return scoreNodes1(node34, 2, 10)
			else
				return scoreNodes1(node34, 1, (n1(node34) + 1))
			end
		else
			return scoreNodes1(node34, 1, (n1(node34) + 1))
		end
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_6251), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"key\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
end)
getScore1 = (function(lookup11, node35)
	local score1 = lookup11[node35]
	if (score1 == nil) then
		score1 = 0
		local r_6281 = node35[2]
		local r_6311 = n1(r_6281)
		local r_6291 = nil
		r_6291 = (function(r_6301)
			if (r_6301 <= r_6311) then
				if r_6281[r_6301]["var"]["isVariadic"] then
					score1 = false
				end
				return r_6291((r_6301 + 1))
			else
				return nil
			end
		end)
		r_6291(1)
		if score1 then
			score1 = scoreNodes1(node35, 3, score1)
		end
		lookup11[node35] = score1
	end
	return (score1 or huge1)
end)
scoreNodes1 = (function(nodes15, start5, sum1)
	if (start5 > n1(nodes15)) then
		return sum1
	else
		local score2 = scoreNode1(nodes15[start5])
		if score2 then
			if (score2 > 20) then
				return score2
			else
				return scoreNodes1(nodes15, (start5 + 1), (sum1 + score2))
			end
		else
			return false
		end
	end
end)
inline1 = ({["name"]="inline",["help"]="Inline simple functions.",["cat"]=({tag = "list", n = 2, "opt", "usage"}),["level"]=2,["run"]=(function(r_49213, state22, nodes16, usage2)
	local scoreLookup1 = ({})
	return visitBlock1(nodes16, 1, (function(node36)
		if ((type1(node36) == "list") and (type1((car1(node36))) == "symbol")) then
			local func6 = car1(node36)["var"]
			local def3 = getVar1(usage2, func6)
			if (n1(def3["defs"]) == 1) then
				local ent2 = car1(def3["defs"])
				local val15 = ent2["value"]
				if ((type1(val15) == "list") and (builtin_3f_1(car1(val15), "lambda") and (getScore1(scoreLookup1, val15) <= 20))) then
					local copy2 = copyNode1(val15, ({["scopes"]=({}),["vars"]=({}),["root"]=func6["scope"]}))
					node36[1] = copy2
					r_49213["changed"] = true
					return nil
				else
					return nil
				end
			else
				return nil
			end
		else
			return nil
		end
	end))
end)})
optimiseOnce1 = (function(nodes17, state23)
	local tracker2 = ({["changed"]=false})
	local r_3571 = state23["pass"]["normal"]
	local r_3601 = n1(r_3571)
	local r_3581 = nil
	r_3581 = (function(r_3591)
		if (r_3591 <= r_3601) then
			runPass1(r_3571[r_3591], state23, tracker2, nodes17)
			return r_3581((r_3591 + 1))
		else
			return nil
		end
	end)
	r_3581(1)
	local lookup12 = ({["vars"]=({}),["nodes"]=({})})
	runPass1(tagUsage1, state23, tracker2, nodes17, lookup12)
	local r_6471 = state23["pass"]["usage"]
	local r_6501 = n1(r_6471)
	local r_6481 = nil
	r_6481 = (function(r_6491)
		if (r_6491 <= r_6501) then
			runPass1(r_6471[r_6491], state23, tracker2, nodes17, lookup12)
			return r_6481((r_6491 + 1))
		else
			return nil
		end
	end)
	r_6481(1)
	return tracker2["changed"]
end)
optimise1 = (function(nodes18, state24)
	local maxN1 = state24["max-n"]
	local maxT1 = state24["max-time"]
	local iteration1 = 0
	local finish1 = (clock1() + maxT1)
	local changed1 = true
	local r_3621 = nil
	r_3621 = (function()
		if (changed1 and (((maxN1 < 0) or (iteration1 < maxN1)) and ((maxT1 < 0) or (clock1() < finish1)))) then
			changed1 = optimiseOnce1(nodes18, state24)
			iteration1 = (iteration1 + 1)
			return r_3621()
		else
			return nil
		end
	end)
	return r_3621()
end)
default1 = (function()
	return ({["normal"]=list1(stripImport1, stripPure1, constantFold1, condFold1, lambdaFold1, fusion1),["usage"]=list1(stripDefs1, stripArgs1, variableFold1, condEliminate1, expressionFold1, inline1)})
end)
builtins4 = require1("tacky.analysis.resolve")["builtins"]
tokens1 = ({tag = "list", n = 7, ({tag = "list", n = 2, "arg", "(%f[%a]%u+%f[%A])"}), ({tag = "list", n = 2, "mono", "```[a-z]*\n([^`]*)\n```"}), ({tag = "list", n = 2, "mono", "`([^`]*)`"}), ({tag = "list", n = 2, "bolic", "(%*%*%*%w.-%w%*%*%*)"}), ({tag = "list", n = 2, "bold", "(%*%*%w.-%w%*%*)"}), ({tag = "list", n = 2, "italic", "(%*%w.-%w%*)"}), ({tag = "list", n = 2, "link", "%[%[(.-)%]%]"})})
extractSignature1 = (function(var22)
	local ty4 = type1(var22)
	if ((ty4 == "macro") or (ty4 == "defined")) then
		local root2 = var22["node"]
		local node37 = root2[(n1(root2))]
		if ((type1(node37) == "list") and ((type1((car1(node37))) == "symbol") and (car1(node37)["var"] == builtins4["lambda"]))) then
			return node37[2]
		else
			return nil
		end
	else
		return nil
	end
end)
parseDocstring1 = (function(str3)
	local out10 = ({tag = "list", n = 0})
	local pos7 = 1
	local len8 = n1(str3)
	local r_6621 = nil
	r_6621 = (function()
		if (pos7 <= len8) then
			local spos1 = len8
			local epos1 = nil
			local name11 = nil
			local ptrn3 = nil
			local r_6671 = n1(tokens1)
			local r_6651 = nil
			r_6651 = (function(r_6661)
				if (r_6661 <= r_6671) then
					local tok1 = tokens1[r_6661]
					local npos1 = list1(find1(str3, tok1[2], pos7))
					if (car1(npos1) and (car1(npos1) < spos1)) then
						spos1 = car1(npos1)
						epos1 = npos1[2]
						name11 = car1(tok1)
						ptrn3 = tok1[2]
					end
					return r_6651((r_6661 + 1))
				else
					return nil
				end
			end)
			r_6651(1)
			if name11 then
				if (pos7 < spos1) then
					pushCdr_21_1(out10, ({["tag"]="text",["contents"]=sub1(str3, pos7, (spos1 - 1))}))
				end
				pushCdr_21_1(out10, ({["tag"]=name11,["whole"]=sub1(str3, spos1, epos1),["contents"]=match1(sub1(str3, spos1, epos1), ptrn3)}))
				pos7 = (epos1 + 1)
			else
				pushCdr_21_1(out10, ({["tag"]="text",["contents"]=sub1(str3, pos7, len8)}))
				pos7 = (len8 + 1)
			end
			return r_6621()
		else
			return nil
		end
	end)
	r_6621()
	return out10
end)
Scope1 = require1("tacky.analysis.scope")
checkArity1 = ({["name"]="check-arity",["help"]="Produce a warning if any NODE in NODES calls a function with too many arguments.\n\nLOOKUP is the variable usage lookup table.",["cat"]=({tag = "list", n = 2, "warn", "usage"}),["run"]=(function(r_49214, state25, nodes19, lookup13)
	local arity1
	local getArity1
	arity1 = ({})
	getArity1 = (function(symbol1)
		local var23 = getVar1(lookup13, symbol1["var"])
		local ari1 = arity1[var23]
		if (ari1 ~= nil) then
			return ari1
		elseif (n1(var23["defs"]) ~= 1) then
			return false
		else
			arity1[var23] = false
			local defData1 = car1(var23["defs"])
			local def4 = defData1["value"]
			if (defData1["tag"] == "var") then
				ari1 = false
			else
				if (type1(def4) == "symbol") then
					ari1 = getArity1(def4)
				elseif ((type1(def4) == "list") and ((type1((car1(def4))) == "symbol") and (car1(def4)["var"] == builtins1["lambda"]))) then
					local args9 = def4[2]
					if any1((function(x24)
						return x24["var"]["isVariadic"]
					end), args9) then
						ari1 = false
					else
						ari1 = n1(args9)
					end
				else
					ari1 = false
				end
			end
			arity1[var23] = ari1
			return ari1
		end
	end)
	return visitBlock1(nodes19, 1, (function(node38)
		if ((type1(node38) == "list") and (type1((car1(node38))) == "symbol")) then
			local arity2 = getArity1(car1(node38))
			if (arity2 and (arity2 < (n1(node38) - 1))) then
				return putNodeWarning_21_1(state25["logger"], _2e2e_2("Calling ", symbol_2d3e_string1(car1(node38)), " with ", tonumber1((n1(node38) - 1)), " arguments, expected ", tonumber1(arity2)), node38, nil, getSource1(node38), "Called here")
			else
				return nil
			end
		else
			return nil
		end
	end))
end)})
deprecated1 = ({["name"]="deprecated",["help"]="Produce a warning whenever a deprecated variable is used.",["cat"]=({tag = "list", n = 2, "warn", "usage"}),["run"]=(function(r_49215, state26, nodes20, lookup14)
	local r_6781 = n1(nodes20)
	local r_6761 = nil
	r_6761 = (function(r_6771)
		if (r_6771 <= r_6781) then
			local node39 = nodes20[r_6771]
			local defVar1 = node39["defVar"]
			visitNode1(node39, (function(node40)
				if (type1(node40) == "symbol") then
					local var24 = node40["var"]
					if ((var24 ~= defVar1) and var24["deprecated"]) then
						return putNodeWarning_21_1(state26["logger"], (function()
							if string_3f_1(var24["deprecated"]) then
								return format1("%s is deprecated: %s", node40["contents"], var24["deprecated"])
							else
								return format1("%s is deprecated.", node40["contents"])
							end
						end)()
						, node40, nil, getSource1(node40), "")
					else
						return nil
					end
				else
					return nil
				end
			end))
			return r_6761((r_6771 + 1))
		else
			return nil
		end
	end)
	return r_6761(1)
end)})
documentation1 = ({["name"]="documentation",["help"]="Ensure doc comments are valid.",["cat"]=({tag = "list", n = 1, "warn"}),["run"]=(function(r_49216, state27, nodes21)
	local r_6851 = n1(nodes21)
	local r_6831 = nil
	r_6831 = (function(r_6841)
		if (r_6841 <= r_6851) then
			local node41 = nodes21[r_6841]
			local var25 = node41["defVar"]
			if var25 then
				local doc1 = var25["doc"]
				if doc1 then
					local r_6941 = parseDocstring1(doc1)
					local r_6971 = n1(r_6941)
					local r_6951 = nil
					r_6951 = (function(r_6961)
						if (r_6961 <= r_6971) then
							local tok2 = r_6941[r_6961]
							if (type1(tok2) == "link") then
								if Scope1["get"](var25["scope"], tok2["contents"]) then
								else
									putNodeWarning_21_1(state27["logger"], format1("%s is not defined.", quoted1(tok2["contents"])), node41, nil, getSource1(node41), "Referenced in docstring.")
								end
							end
							return r_6951((r_6961 + 1))
						else
							return nil
						end
					end)
					r_6951(1)
				else
				end
			else
			end
			return r_6831((r_6841 + 1))
		else
			return nil
		end
	end)
	return r_6831(1)
end)})
analyse1 = (function(nodes22, state28)
	local r_6541 = state28["pass"]["normal"]
	local r_6571 = n1(r_6541)
	local r_6551 = nil
	r_6551 = (function(r_6561)
		if (r_6561 <= r_6571) then
			runPass1(r_6541[r_6561], state28, nil, nodes22)
			return r_6551((r_6561 + 1))
		else
			return nil
		end
	end)
	r_6551(1)
	local lookup15 = ({["vars"]=({}),["nodes"]=({})})
	runPass1(tagUsage1, state28, nil, nodes22, lookup15)
	local r_6881 = state28["pass"]["usage"]
	local r_6911 = n1(r_6881)
	local r_6891 = nil
	r_6891 = (function(r_6901)
		if (r_6901 <= r_6911) then
			runPass1(r_6881[r_6901], state28, nil, nodes22, lookup15)
			return r_6891((r_6901 + 1))
		else
			return nil
		end
	end)
	return r_6891(1)
end)
create2 = (function()
	return ({["out"]=({tag = "list", n = 0}),["indent"]=0,["tabs-pending"]=false,["line"]=1,["lines"]=({}),["node-stack"]=({tag = "list", n = 0}),["active-pos"]=nil})
end)
append_21_1 = (function(writer1, text2)
	local r_7101 = type1(text2)
	if (r_7101 ~= "string") then
		error1(format1("bad argument %s (expected %s, got %s)", "text", "string", r_7101), 2)
	end
	local pos8 = writer1["active-pos"]
	if pos8 then
		local line1 = writer1["lines"][writer1["line"]]
		if line1 then
		else
			line1 = ({})
			writer1["lines"][writer1["line"]] = line1
		end
		line1[pos8] = true
	end
	if writer1["tabs-pending"] then
		writer1["tabs-pending"] = false
		pushCdr_21_1(writer1["out"], rep1("\9", writer1["indent"]))
	end
	return pushCdr_21_1(writer1["out"], text2)
end)
line_21_1 = (function(writer2, text3, force1)
	if text3 then
		append_21_1(writer2, text3)
	end
	if (force1 or not writer2["tabs-pending"]) then
		writer2["tabs-pending"] = true
		writer2["line"] = (writer2["line"] + 1)
		return pushCdr_21_1(writer2["out"], "\n")
	else
		return nil
	end
end)
indent_21_1 = (function(writer3)
	writer3["indent"] = (writer3["indent"] + 1)
	return nil
end)
unindent_21_1 = (function(writer4)
	writer4["indent"] = (writer4["indent"] - 1)
	return nil
end)
beginBlock_21_1 = (function(writer5, text4)
	line_21_1(writer5, text4)
	writer5["indent"] = (writer5["indent"] + 1)
	return nil
end)
nextBlock_21_1 = (function(writer6, text5)
	writer6["indent"] = (writer6["indent"] - 1)
	line_21_1(writer6, text5)
	writer6["indent"] = (writer6["indent"] + 1)
	return nil
end)
endBlock_21_1 = (function(writer7, text6)
	writer7["indent"] = (writer7["indent"] - 1)
	return line_21_1(writer7, text6)
end)
pushNode_21_1 = (function(writer8, node42)
	local range2 = getSource1(node42)
	if range2 then
		pushCdr_21_1(writer8["node-stack"], node42)
		writer8["active-pos"] = range2
		return nil
	else
		return nil
	end
end)
popNode_21_1 = (function(writer9, node43)
	if getSource1(node43) then
		local stack1 = writer9["node-stack"]
		local previous1 = last1(stack1)
		if (previous1 == node43) then
		else
			error1("Incorrect node popped")
		end
		popLast_21_1(stack1)
		writer9["arg-pos"] = last1(stack1)
		return nil
	else
		return nil
	end
end)
estimateLength1 = (function(node44, max4)
	local tag8 = node44["tag"]
	if ((tag8 == "string") or ((tag8 == "number") or ((tag8 == "symbol") or (tag8 == "key")))) then
		return n1(tostring1(node44["contents"]))
	elseif (tag8 == "list") then
		local sum2 = 2
		local i7 = 1
		local r_7021 = nil
		r_7021 = (function()
			if ((sum2 <= max4) and (i7 <= n1(node44))) then
				sum2 = (sum2 + estimateLength1(node44[i7], (max4 - sum2)))
				if (i7 > 1) then
					sum2 = (sum2 + 1)
				end
				i7 = (i7 + 1)
				return r_7021()
			else
				return nil
			end
		end)
		r_7021()
		return sum2
	else
		return error1(_2e2e_2("Unknown tag ", tag8), 0)
	end
end)
expression1 = (function(node45, writer10)
	local tag9 = node45["tag"]
	if (tag9 == "string") then
		return append_21_1(writer10, quoted1(node45["value"]))
	elseif (tag9 == "number") then
		return append_21_1(writer10, tostring1(node45["value"]))
	elseif (tag9 == "key") then
		return append_21_1(writer10, _2e2e_2(":", node45["value"]))
	elseif (tag9 == "symbol") then
		return append_21_1(writer10, node45["contents"])
	elseif (tag9 == "list") then
		append_21_1(writer10, "(")
		if empty_3f_1(node45) then
			return append_21_1(writer10, ")")
		else
			local newline1 = false
			local max5 = (60 - estimateLength1(car1(node45), 60))
			expression1(car1(node45), writer10)
			if (max5 <= 0) then
				newline1 = true
				writer10["indent"] = (writer10["indent"] + 1)
			end
			local r_7141 = n1(node45)
			local r_7121 = nil
			r_7121 = (function(r_7131)
				if (r_7131 <= r_7141) then
					local entry4 = node45[r_7131]
					if (not newline1 and (max5 > 0)) then
						max5 = (max5 - estimateLength1(entry4, max5))
						if (max5 <= 0) then
							newline1 = true
							writer10["indent"] = (writer10["indent"] + 1)
						end
					end
					if newline1 then
						line_21_1(writer10)
					else
						append_21_1(writer10, " ")
					end
					expression1(entry4, writer10)
					return r_7121((r_7131 + 1))
				else
					return nil
				end
			end)
			r_7121(2)
			if newline1 then
				writer10["indent"] = (writer10["indent"] - 1)
			end
			return append_21_1(writer10, ")")
		end
	else
		return error1(_2e2e_2("Unknown tag ", tag9), 0)
	end
end)
block1 = (function(list4, writer11)
	local r_7081 = n1(list4)
	local r_7061 = nil
	r_7061 = (function(r_7071)
		if (r_7071 <= r_7081) then
			expression1(list4[r_7071], writer11)
			line_21_1(writer11)
			return r_7061((r_7071 + 1))
		else
			return nil
		end
	end)
	return r_7061(1)
end)
cat3 = (function(category1, ...)
	local args10 = _pack(...) args10.tag = "list"
	return struct1("category", category1, unpack1(args10, 1, n1(args10)))
end)
partAll1 = (function(xs12, i8, e1, f3)
	while true do
		if (i8 > e1) then
			return true
		elseif f3(xs12[i8]) then
			i8 = (i8 + 1)
		else
			return false
		end
	end
end)
visitNode2 = (function(lookup16, node46, stmt1, test2, recur1)
	local cat4
	local r_7271 = type1(node46)
	if (r_7271 == "string") then
		cat4 = cat3("const")
	elseif (r_7271 == "number") then
		cat4 = cat3("const")
	elseif (r_7271 == "key") then
		cat4 = cat3("const")
	elseif (r_7271 == "symbol") then
		cat4 = cat3("const")
	elseif (r_7271 == "list") then
		local head4 = car1(node46)
		local r_7281 = type1(head4)
		if (r_7281 == "symbol") then
			local func7 = head4["var"]
			local funct3 = func7["tag"]
			if (func7 == builtins1["lambda"]) then
				visitNodes1(lookup16, node46, 3, true)
				cat4 = cat3("lambda")
			elseif (func7 == builtins1["cond"]) then
				local r_7571 = n1(node46)
				local r_7551 = nil
				r_7551 = (function(r_7561)
					if (r_7561 <= r_7571) then
						local case3 = node46[r_7561]
						visitNode2(lookup16, car1(case3), true, true)
						visitNodes1(lookup16, case3, 2, true, test2, recur1)
						return r_7551((r_7561 + 1))
					else
						return nil
					end
				end)
				r_7551(2)
				local temp6
				if (n1(node46) == 3) then
					local temp7
					local sub2 = node46[2]
					temp7 = ((n1(sub2) == 2) and builtin_3f_1(sub2[2], "false"))
					if temp7 then
						local sub3 = node46[3]
						temp6 = ((n1(sub3) == 2) and (builtin_3f_1(sub3[1], "true") and builtin_3f_1(sub3[2], "true")))
					else
						temp6 = false
					end
				else
					temp6 = false
				end
				if temp6 then
					cat4 = cat3("not", "stmt", lookup16[car1(node46[2])]["stmt"])
				else
					local temp8
					if (n1(node46) == 3) then
						local first6 = node46[2]
						local second1 = node46[3]
						local branch1 = car1(first6)
						local last5 = second1[2]
						temp8 = ((n1(first6) == 2) and ((n1(second1) == 2) and (not lookup16[first6[2]]["stmt"] and (builtin_3f_1(car1(second1), "true") and ((type1(last5) == "symbol") and (((type1(branch1) == "symbol") and (branch1["var"] == last5["var"])) or (test2 and (not lookup16[branch1]["stmt"] and (last5["var"] == builtins1["false"])))))))))
					else
						temp8 = false
					end
					if temp8 then
						cat4 = cat3("and")
					else
						local temp9
						if (n1(node46) >= 3) then
							if partAll1(node46, 2, (n1(node46) - 1), (function(branch2)
								local head5 = car1(branch2)
								local tail1 = branch2[2]
								return ((n1(branch2) == 2) and ((type1(tail1) == "symbol") and (((type1(head5) == "symbol") and (head5["var"] == tail1["var"])) or (test2 and (not lookup16[head5]["stmt"] and (tail1["var"] == builtins1["true"]))))))
							end)) then
								local branch3 = last1(node46)
								temp9 = ((n1(branch3) == 2) and (builtin_3f_1(car1(branch3), "true") and not lookup16[branch3[2]]["stmt"]))
							else
								temp9 = false
							end
						else
							temp9 = false
						end
						if temp9 then
							cat4 = cat3("or")
						else
							cat4 = cat3("cond", "stmt", true)
						end
					end
				end
			elseif (func7 == builtins1["set!"]) then
				visitNode2(lookup16, node46[3], true)
				cat4 = cat3("set!")
			elseif (func7 == builtins1["quote"]) then
				visitQuote2(lookup16, node46)
				cat4 = cat3("quote")
			elseif (func7 == builtins1["syntax-quote"]) then
				visitSyntaxQuote1(lookup16, node46[2], 1)
				cat4 = cat3("syntax-quote")
			elseif (func7 == builtins1["unquote"]) then
				cat4 = error1("unquote should never appear", 0)
			elseif (func7 == builtins1["unquote-splice"]) then
				cat4 = error1("unquote should never appear", 0)
			elseif ((func7 == builtins1["define"]) or (func7 == builtins1["define-macro"])) then
				local def5 = node46[(n1(node46))]
				if ((type1(def5) == "list") and builtin_3f_1(car1(def5), "lambda")) then
					local recur2 = ({["var"]=node46["defVar"],["def"]=def5})
					visitNodes1(lookup16, def5, 3, true, nil, recur2)
					lookup16[def5] = (function()
						if recur2["tail"] then
							return cat3("lambda", "recur", recur2)
						else
							return cat3("lambda")
						end
					end)()
				else
					visitNode2(lookup16, def5, true)
				end
				cat4 = cat3("define")
			elseif (func7 == builtins1["define-native"]) then
				cat4 = cat3("define-native")
			elseif (func7 == builtins1["import"]) then
				cat4 = cat3("import")
			elseif (func7 == builtins1["struct-literal"]) then
				visitNodes1(lookup16, node46, 2, false)
				cat4 = cat3("struct-literal")
			elseif (func7 == builtins1["true"]) then
				visitNodes1(lookup16, node46, 1, false)
				cat4 = cat3("call-literal")
			elseif (func7 == builtins1["false"]) then
				visitNodes1(lookup16, node46, 1, false)
				cat4 = cat3("call-literal")
			elseif (func7 == builtins1["nil"]) then
				visitNodes1(lookup16, node46, 1, false)
				cat4 = cat3("call-literal")
			else
				visitNodes1(lookup16, node46, 1, false)
				if (recur1 and (func7 == recur1["var"])) then
					recur1["tail"] = true
					cat4 = cat3("call-symbol", "recur", recur1)
				else
					cat4 = cat3("call-symbol")
				end
			end
		elseif (r_7281 == "list") then
			if ((n1(node46) == 2) and (builtin_3f_1(car1(head4), "lambda") and ((n1(head4) == 3) and ((n1(head4[2]) == 1) and ((type1((head4[3])) == "symbol") and (head4[3]["var"] == car1(head4[2])["var"])))))) then
				if visitNode2(lookup16, node46[2], stmt1, test2)["stmt"] then
					visitNode2(lookup16, head4, true)
					if stmt1 then
						cat4 = cat3("call-lambda", "stmt", true)
					else
						cat4 = cat3("call")
					end
				else
					cat4 = cat3("wrap-value")
				end
			else
				local temp10
				if (n1(node46) == 2) then
					if builtin_3f_1(car1(head4), "lambda") then
						if (n1(head4) == 3) then
							if (n1(head4[2]) == 1) then
								local elem7 = head4[3]
								temp10 = ((type1(elem7) == "list") and (builtin_3f_1(car1(elem7), "cond") and ((type1((car1(elem7[2]))) == "symbol") and (car1(elem7[2])["var"] == car1(head4[2])["var"]))))
							else
								temp10 = false
							end
						else
							temp10 = false
						end
					else
						temp10 = false
					end
				else
					temp10 = false
				end
				if temp10 then
					if visitNode2(lookup16, node46[2], stmt1, test2)["stmt"] then
						lookup16[head4] = cat3("lambda")
						local r_8011 = n1(head4)
						local r_7991 = nil
						r_7991 = (function(r_8001)
							if (r_8001 <= r_8011) then
								visitNode2(lookup16, head4[r_8001], true, test2)
								return r_7991((r_8001 + 1))
							else
								return nil
							end
						end)
						r_7991(3)
						if stmt1 then
							cat4 = cat3("call-lambda", "stmt", true)
						else
							cat4 = cat3("call")
						end
					else
						local res7 = visitNode2(lookup16, head4[3], true, test2)
						local ty5 = res7["category"]
						lookup16[head4] = cat3("lambda")
						if (ty5 == "and") then
							cat4 = cat3("and-lambda")
						elseif (ty5 == "or") then
							cat4 = cat3("or-lambda")
						elseif stmt1 then
							cat4 = cat3("call-lambda", "stmt", true)
						else
							cat4 = cat3("call")
						end
					end
				elseif (stmt1 and builtin_3f_1(car1(head4), "lambda")) then
					visitNodes1(lookup16, car1(node46), 3, true, test2, recur1)
					local lam4 = car1(node46)
					local args11 = lam4[2]
					local offset3 = 1
					local r_8061 = n1(args11)
					local r_8041 = nil
					r_8041 = (function(r_8051)
						if (r_8051 <= r_8061) then
							if args11[r_8051]["var"]["isVariadic"] then
								local count3 = (n1(node46) - n1(args11))
								if (count3 < 0) then
									count3 = 0
								end
								local r_8101 = count3
								local r_8081 = nil
								r_8081 = (function(r_8091)
									if (r_8091 <= r_8101) then
										visitNode2(lookup16, node46[((r_8051 + r_8091))], false)
										return r_8081((r_8091 + 1))
									else
										return nil
									end
								end)
								r_8081(1)
								offset3 = count3
							else
								local val16 = node46[((r_8051 + offset3))]
								if val16 then
									visitNode2(lookup16, val16, true)
								end
							end
							return r_8041((r_8051 + 1))
						else
							return nil
						end
					end)
					r_8041(1)
					local r_8141 = n1(node46)
					local r_8121 = nil
					r_8121 = (function(r_8131)
						if (r_8131 <= r_8141) then
							visitNode2(lookup16, node46[r_8131], true)
							return r_8121((r_8131 + 1))
						else
							return nil
						end
					end)
					r_8121((n1(args11) + (offset3 + 1)))
					cat4 = cat3("call-lambda", "stmt", true)
				elseif (builtin_3f_1(car1(head4), "quote") or builtin_3f_1(car1(head4), "syntax-quote")) then
					visitNodes1(lookup16, node46, 1, false)
					cat4 = cat3("call-literal")
				else
					visitNodes1(lookup16, node46, 1, false)
					cat4 = cat3("call")
				end
			end
		elseif eq_3f_1(r_7281, true) then
			visitNodes1(lookup16, node46, 1, false)
			cat4 = cat3("call-literal")
		else
			cat4 = error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_7281), ", but none matched.\n", "  Tried: `\"symbol\"`\n  Tried: `\"list\"`\n  Tried: `true`"))
		end
	else
		cat4 = error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_7271), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
	end
	if (cat4 == nil) then
		error1(_2e2e_2("Node returned nil ", pretty1(node46)), 0)
	end
	lookup16[node46] = cat4
	return cat4
end)
visitNodes1 = (function(lookup17, nodes23, start6, stmt2, test3, recur3)
	local len9 = n1(nodes23)
	local r_7291 = nil
	r_7291 = (function(r_7301)
		if (r_7301 <= len9) then
			visitNode2(lookup17, nodes23[r_7301], stmt2, (test3 and (r_7301 == len9)), ((r_7301 == len9) and recur3))
			return r_7291((r_7301 + 1))
		else
			return nil
		end
	end)
	return r_7291(start6)
end)
visitSyntaxQuote1 = (function(lookup18, node47, level4)
	if (level4 == 0) then
		return visitNode2(lookup18, node47, false)
	else
		local cat5
		local r_7351 = type1(node47)
		if (r_7351 == "string") then
			cat5 = cat3("quote-const")
		elseif (r_7351 == "number") then
			cat5 = cat3("quote-const")
		elseif (r_7351 == "key") then
			cat5 = cat3("quote-const")
		elseif (r_7351 == "symbol") then
			cat5 = cat3("quote-const")
		elseif (r_7351 == "list") then
			local r_7361 = car1(node47)
			if eq_3f_1(r_7361, ({ tag="symbol", contents="unquote"})) then
				visitSyntaxQuote1(lookup18, node47[2], (level4 - 1))
				cat5 = cat3("unquote")
			elseif eq_3f_1(r_7361, ({ tag="symbol", contents="unquote-splice"})) then
				visitSyntaxQuote1(lookup18, node47[2], (level4 - 1))
				cat5 = cat3("unquote-splice")
			elseif eq_3f_1(r_7361, ({ tag="symbol", contents="syntax-quote"})) then
				local r_7411 = n1(node47)
				local r_7391 = nil
				r_7391 = (function(r_7401)
					if (r_7401 <= r_7411) then
						visitSyntaxQuote1(lookup18, node47[r_7401], (level4 + 1))
						return r_7391((r_7401 + 1))
					else
						return nil
					end
				end)
				r_7391(1)
				cat5 = cat3("quote-list")
			else
				local hasSplice1 = false
				local r_7471 = n1(node47)
				local r_7451 = nil
				r_7451 = (function(r_7461)
					if (r_7461 <= r_7471) then
						if (visitSyntaxQuote1(lookup18, node47[r_7461], level4)["category"] == "unquote-splice") then
							hasSplice1 = true
						end
						return r_7451((r_7461 + 1))
					else
						return nil
					end
				end)
				r_7451(1)
				if hasSplice1 then
					cat5 = cat3("quote-splice", "stmt", true)
				else
					cat5 = cat3("quote-list")
				end
			end
		else
			cat5 = error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_7351), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"key\"`\n  Tried: `\"symbol\"`\n  Tried: `\"list\"`"))
		end
		if (cat5 == nil) then
			error1(_2e2e_2("Node returned nil ", pretty1(node47)), 0)
		end
		lookup18[node47] = cat5
		return cat5
	end
end)
visitQuote2 = (function(lookup19, node48)
	if (type1(node48) == "list") then
		local r_7531 = n1(node48)
		local r_7511 = nil
		r_7511 = (function(r_7521)
			if (r_7521 <= r_7531) then
				visitQuote2(lookup19, (node48[r_7521]))
				return r_7511((r_7521 + 1))
			else
				return nil
			end
		end)
		r_7511(1)
		lookup19[node48] = cat3("quote-list")
		return nil
	else
		lookup19[node48] = cat3("quote-const")
		return nil
	end
end)
categoriseNodes1 = ({["name"]="categorise-nodes",["help"]="Categorise a group of NODES, annotating their appropriate node type.",["cat"]=({tag = "list", n = 1, "categorise"}),["run"]=(function(r_49217, state29, nodes24, lookup20)
	return visitNodes1(lookup20, nodes24, 1, true)
end)})
categoriseNode1 = ({["name"]="categorise-node",["help"]="Categorise a NODE, annotating it's appropriate node type.",["cat"]=({tag = "list", n = 1, "categorise"}),["run"]=(function(r_49218, state30, node49, lookup21, stmt3)
	return visitNode2(lookup21, node49, stmt3)
end)})
keywords1 = createLookup1(({tag = "list", n = 21, "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}))
escape1 = (function(name12)
	if (name12 == "") then
		return "_e"
	elseif keywords1[name12] then
		return _2e2e_2("_e", name12)
	elseif find1(name12, "^%w[_%w%d]*$") then
		return name12
	else
		local out11
		if find1(sub1(name12, 1, 1), "%d") then
			out11 = "_e"
		else
			out11 = ""
		end
		local upper2 = false
		local esc1 = false
		local r_8191 = n1(name12)
		local r_8171 = nil
		r_8171 = (function(r_8181)
			if (r_8181 <= r_8191) then
				local char2 = sub1(name12, r_8181, r_8181)
				if ((char2 == "-") and (find1((function(x25)
					return sub1(name12, x25, x25)
				end)((r_8181 - 1)), "[%a%d']") and find1((function(x26)
					return sub1(name12, x26, x26)
				end)((r_8181 + 1)), "[%a%d']"))) then
					upper2 = true
				elseif find1(char2, "[^%w%d]") then
					char2 = format1("%02x", (byte1(char2)))
					if esc1 then
					else
						esc1 = true
						out11 = _2e2e_2(out11, "_")
					end
					out11 = _2e2e_2(out11, char2)
				else
					if esc1 then
						esc1 = false
						out11 = _2e2e_2(out11, "_")
					end
					if upper2 then
						upper2 = false
						char2 = upper1(char2)
					end
					out11 = _2e2e_2(out11, char2)
				end
				return r_8171((r_8181 + 1))
			else
				return nil
			end
		end)
		r_8171(1)
		if esc1 then
			out11 = _2e2e_2(out11, "_")
		end
		return out11
	end
end)
escapeVar1 = (function(var26, state31)
	if builtinVars1[var26] then
		return var26["name"]
	else
		local v5 = escape1(var26["name"])
		local id2 = state31["var-lookup"][var26]
		if id2 then
		else
			id2 = ((state31["ctr-lookup"][v5] or 0) + 1)
			state31["ctr-lookup"][v5] = id2
			state31["var-lookup"][var26] = id2
		end
		return _2e2e_2(v5, tostring1(id2))
	end
end)
truthy_3f_1 = (function(node50)
	return ((type1(node50) == "symbol") and (builtins1["true"] == node50["var"]))
end)
boringCategories1 = ({["const"]=true,["quote"]=true,["not"]=true,["cond"]=true})
compileNative1 = (function(out12, meta2)
	local ty6 = type1(meta2)
	if (ty6 == "var") then
		return append_21_1(out12, meta2["contents"])
	elseif ((ty6 == "expr") or (ty6 == "stmt")) then
		append_21_1(out12, "function(")
		local r_8351 = meta2["count"]
		local r_8331 = nil
		r_8331 = (function(r_8341)
			if (r_8341 <= r_8351) then
				if (r_8341 == 1) then
				else
					append_21_1(out12, ", ")
				end
				append_21_1(out12, _2e2e_2("v", tonumber1(r_8341)))
				return r_8331((r_8341 + 1))
			else
				return nil
			end
		end)
		r_8331(1)
		if meta2["fold"] then
			append_21_1(out12, ", ...")
		end
		append_21_1(out12, ") ")
		if (meta2["tag"] == "stmt") then
		elseif meta2["fold"] then
			append_21_1(out12, "local t = ")
		else
			append_21_1(out12, "return ")
		end
		local r_8381 = meta2["contents"]
		local r_8411 = n1(r_8381)
		local r_8391 = nil
		r_8391 = (function(r_8401)
			if (r_8401 <= r_8411) then
				local entry5 = r_8381[r_8401]
				if number_3f_1(entry5) then
					append_21_1(out12, _2e2e_2("v", tonumber1(entry5)))
				else
					append_21_1(out12, entry5)
				end
				return r_8391((r_8401 + 1))
			else
				return nil
			end
		end)
		r_8391(1)
		local r_8431 = meta2["fold"]
		if eq_3f_1(r_8431, nil) then
		elseif (r_8431 == "l") then
			append_21_1(out12, " for i = 1, _select('#', ...) do t = ")
			local r_8451 = meta2["contents"]
			local r_8481 = n1(r_8451)
			local r_8461 = nil
			r_8461 = (function(r_8471)
				if (r_8471 <= r_8481) then
					local node51 = r_8451[r_8471]
					if (node51 == 1) then
						append_21_1(out12, "t")
					elseif (node51 == 2) then
						append_21_1(out12, "_select(i, ...)")
					elseif string_3f_1(node51) then
						append_21_1(out12, node51)
					else
						error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(node51), ", but none matched.\n", "  Tried: `1`\n  Tried: `2`\n  Tried: `string?`"))
					end
					return r_8461((r_8471 + 1))
				else
					return nil
				end
			end)
			r_8461(1)
			append_21_1(out12, " end return t")
		elseif (r_8431 == "r") then
			append_21_1(out12, " for i = _select('#', ...), 1, -1 do t = ")
			local r_8521 = meta2["contents"]
			local r_8551 = n1(r_8521)
			local r_8531 = nil
			r_8531 = (function(r_8541)
				if (r_8541 <= r_8551) then
					local node52 = r_8521[r_8541]
					if (node52 == 1) then
						append_21_1(out12, "_select(i, ...)")
					elseif (node52 == 2) then
						append_21_1(out12, "t")
					elseif string_3f_1(node52) then
						append_21_1(out12, node52)
					else
						error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(node52), ", but none matched.\n", "  Tried: `1`\n  Tried: `2`\n  Tried: `string?`"))
					end
					return r_8531((r_8541 + 1))
				else
					return nil
				end
			end)
			r_8531(1)
			append_21_1(out12, " end return t")
		else
			error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_8431), ", but none matched.\n", "  Tried: `nil`\n  Tried: `\"l\"`\n  Tried: `\"r\"`"))
		end
		return append_21_1(out12, " end")
	else
		_error("unmatched item")
	end
end)
compileExpression1 = (function(node53, out13, state32, ret1)
	local catLookup1 = state32["cat-lookup"]
	local cat6 = catLookup1[node53]
	local _5f_2
	if cat6 then
		_5f_2 = nil
	else
		_5f_2 = print1("Cannot find", pretty1(node53), formatNode1(node53))
	end
	local catTag1 = cat6["category"]
	if boringCategories1[catTag1] then
	else
		pushNode_21_1(out13, node53)
	end
	if (catTag1 == "const") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out13, ret1)
			end
			if (type1(node53) == "symbol") then
				append_21_1(out13, escapeVar1(node53["var"], state32))
			elseif string_3f_1(node53) then
				append_21_1(out13, quoted1(node53["value"]))
			elseif number_3f_1(node53) then
				append_21_1(out13, tostring1(node53["value"]))
			elseif (type1(node53) == "key") then
				append_21_1(out13, quoted1(node53["value"]))
			else
				error1(_2e2e_2("Unknown type: ", type1(node53)))
			end
		end
	elseif (catTag1 == "lambda") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out13, ret1)
			end
			local args12 = node53[2]
			local variadic1 = nil
			local i9 = 1
			append_21_1(out13, "(function(")
			local r_8591 = nil
			r_8591 = (function()
				if ((i9 <= n1(args12)) and not variadic1) then
					if (i9 > 1) then
						append_21_1(out13, ", ")
					end
					local var27 = args12[i9]["var"]
					if var27["isVariadic"] then
						append_21_1(out13, "...")
						variadic1 = i9
					else
						append_21_1(out13, escapeVar1(var27, state32))
					end
					i9 = (i9 + 1)
					return r_8591()
				else
					return nil
				end
			end)
			r_8591()
			line_21_1(out13, ")")
			out13["indent"] = (out13["indent"] + 1)
			if variadic1 then
				local argsVar1 = escapeVar1(args12[variadic1]["var"], state32)
				if (variadic1 == n1(args12)) then
					line_21_1(out13, _2e2e_2("local ", argsVar1, " = _pack(...) ", argsVar1, ".tag = \"list\""))
				else
					local remaining1 = (n1(args12) - variadic1)
					line_21_1(out13, _2e2e_2("local _n = _select(\"#\", ...) - ", tostring1(remaining1)))
					append_21_1(out13, _2e2e_2("local ", argsVar1))
					local r_8631 = n1(args12)
					local r_8611 = nil
					r_8611 = (function(r_8621)
						if (r_8621 <= r_8631) then
							append_21_1(out13, ", ")
							append_21_1(out13, escapeVar1(args12[r_8621]["var"], state32))
							return r_8611((r_8621 + 1))
						else
							return nil
						end
					end)
					r_8611((variadic1 + 1))
					line_21_1(out13)
					line_21_1(out13, "if _n > 0 then")
					out13["indent"] = (out13["indent"] + 1)
					append_21_1(out13, argsVar1)
					line_21_1(out13, " = { tag=\"list\", n=_n, _unpack(_pack(...), 1, _n)}")
					local r_8671 = n1(args12)
					local r_8651 = nil
					r_8651 = (function(r_8661)
						if (r_8661 <= r_8671) then
							append_21_1(out13, escapeVar1(args12[r_8661]["var"], state32))
							if (r_8661 < n1(args12)) then
								append_21_1(out13, ", ")
							end
							return r_8651((r_8661 + 1))
						else
							return nil
						end
					end)
					r_8651((variadic1 + 1))
					line_21_1(out13, " = select(_n + 1, ...)")
					out13["indent"] = (out13["indent"] - 1)
					line_21_1(out13, "else")
					out13["indent"] = (out13["indent"] + 1)
					append_21_1(out13, argsVar1)
					line_21_1(out13, " = { tag=\"list\", n=0}")
					local r_8711 = n1(args12)
					local r_8691 = nil
					r_8691 = (function(r_8701)
						if (r_8701 <= r_8711) then
							append_21_1(out13, escapeVar1(args12[r_8701]["var"], state32))
							if (r_8701 < n1(args12)) then
								append_21_1(out13, ", ")
							end
							return r_8691((r_8701 + 1))
						else
							return nil
						end
					end)
					r_8691((variadic1 + 1))
					line_21_1(out13, " = ...")
					out13["indent"] = (out13["indent"] - 1)
					line_21_1(out13, "end")
				end
			end
			if cat6["recur"] then
				line_21_1(out13, "while true do")
				out13["indent"] = (out13["indent"] + 1)
			end
			compileBlock1(node53, out13, state32, 3, "return ")
			if cat6["recur"] then
				out13["indent"] = (out13["indent"] - 1)
				line_21_1(out13, "end")
			end
			out13["indent"] = (out13["indent"] - 1)
			append_21_1(out13, "end)")
		end
	elseif (catTag1 == "cond") then
		local closure1 = not ret1
		local hadFinal1 = false
		local ends1 = 1
		if closure1 then
			line_21_1(out13, "(function()")
			out13["indent"] = (out13["indent"] + 1)
			ret1 = "return "
		end
		local i10 = 2
		local r_8731 = nil
		r_8731 = (function()
			if (not hadFinal1 and (i10 <= n1(node53))) then
				local item1 = node53[i10]
				local case4 = item1[1]
				local isFinal1 = truthy_3f_1(case4)
				if ((i10 > 2) and (not isFinal1 or ((ret1 ~= "") or (n1(item1) ~= 1)))) then
					append_21_1(out13, "else")
				end
				if isFinal1 then
					if (i10 == 2) then
						append_21_1(out13, "do")
					end
				elseif catLookup1[case4]["stmt"] then
					if (i10 > 2) then
						out13["indent"] = (out13["indent"] + 1)
						line_21_1(out13)
						ends1 = (ends1 + 1)
					end
					local tmp1 = escapeVar1(({["name"]="temp"}), state32)
					line_21_1(out13, _2e2e_2("local ", tmp1))
					compileExpression1(case4, out13, state32, _2e2e_2(tmp1, " = "))
					line_21_1(out13)
					line_21_1(out13, _2e2e_2("if ", tmp1, " then"))
				else
					append_21_1(out13, "if ")
					compileExpression1(case4, out13, state32)
					append_21_1(out13, " then")
				end
				out13["indent"] = (out13["indent"] + 1)
				line_21_1(out13)
				compileBlock1(item1, out13, state32, 2, ret1)
				out13["indent"] = (out13["indent"] - 1)
				if isFinal1 then
					hadFinal1 = true
				end
				i10 = (i10 + 1)
				return r_8731()
			else
				return nil
			end
		end)
		r_8731()
		if hadFinal1 then
		else
			append_21_1(out13, "else")
			out13["indent"] = (out13["indent"] + 1)
			line_21_1(out13)
			append_21_1(out13, "_error(\"unmatched item\")")
			out13["indent"] = (out13["indent"] - 1)
			line_21_1(out13)
		end
		local r_8801 = ends1
		local r_8781 = nil
		r_8781 = (function(r_8791)
			if (r_8791 <= r_8801) then
				append_21_1(out13, "end")
				if (r_8791 < ends1) then
					out13["indent"] = (out13["indent"] - 1)
					line_21_1(out13)
				end
				return r_8781((r_8791 + 1))
			else
				return nil
			end
		end)
		r_8781(1)
		if closure1 then
			line_21_1(out13)
			out13["indent"] = (out13["indent"] - 1)
			line_21_1(out13, "end)()")
		end
	elseif (catTag1 == "not") then
		if ret1 then
			ret1 = _2e2e_2(ret1, "not ")
		else
			append_21_1(out13, "not ")
		end
		compileExpression1(car1(node53[2]), out13, state32, ret1)
	elseif (catTag1 == "or") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "(")
		local len10 = n1(node53)
		local r_8821 = nil
		r_8821 = (function(r_8831)
			if (r_8831 <= len10) then
				if (r_8831 > 2) then
					append_21_1(out13, " or ")
				end
				compileExpression1(node53[r_8831][(function(idx6)
					return idx6
				end)((function()
					if (r_8831 == len10) then
						return 2
					else
						return 1
					end
				end)()
				)], out13, state32)
				return r_8821((r_8831 + 1))
			else
				return nil
			end
		end)
		r_8821(2)
		append_21_1(out13, ")")
	elseif (catTag1 == "or-lambda") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "(")
		compileExpression1(node53[2], out13, state32)
		local branch4 = car1(node53)[3]
		local len11 = n1(branch4)
		local r_8861 = nil
		r_8861 = (function(r_8871)
			if (r_8871 <= len11) then
				append_21_1(out13, " or ")
				compileExpression1(branch4[r_8871][(function(idx7)
					return idx7
				end)((function()
					if (r_8871 == len11) then
						return 2
					else
						return 1
					end
				end)()
				)], out13, state32)
				return r_8861((r_8871 + 1))
			else
				return nil
			end
		end)
		r_8861(3)
		append_21_1(out13, ")")
	elseif (catTag1 == "and") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "(")
		compileExpression1(node53[2][1], out13, state32)
		append_21_1(out13, " and ")
		compileExpression1(node53[2][2], out13, state32)
		append_21_1(out13, ")")
	elseif (catTag1 == "and-lambda") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "(")
		compileExpression1(node53[2], out13, state32)
		append_21_1(out13, " and ")
		compileExpression1(car1(node53)[3][2][2], out13, state32)
		append_21_1(out13, ")")
	elseif (catTag1 == "set!") then
		compileExpression1(node53[3], out13, state32, _2e2e_2(escapeVar1(node53[2]["var"], state32), " = "))
		if (ret1 and (ret1 ~= "")) then
			line_21_1(out13)
			append_21_1(out13, ret1)
			append_21_1(out13, "nil")
		end
	elseif (catTag1 == "struct-literal") then
		if (ret1 == "") then
			append_21_1(out13, "local _ = ")
		elseif ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "({")
		local r_8931 = n1(node53)
		local r_8911 = nil
		r_8911 = (function(r_8921)
			if (r_8921 <= r_8931) then
				if (r_8921 > 2) then
					append_21_1(out13, ",")
				end
				append_21_1(out13, "[")
				compileExpression1(node53[r_8921], out13, state32)
				append_21_1(out13, "]=")
				compileExpression1(node53[((r_8921 + 1))], out13, state32)
				return r_8911((r_8921 + 2))
			else
				return nil
			end
		end)
		r_8911(2)
		append_21_1(out13, "})")
	elseif (catTag1 == "define") then
		compileExpression1(node53[(n1(node53))], out13, state32, _2e2e_2(escapeVar1(node53["defVar"], state32), " = "))
	elseif (catTag1 == "define-native") then
		local meta3 = state32["meta"][node53["defVar"]["fullName"]]
		if (meta3 == nil) then
			append_21_1(out13, format1("%s = _libs[%q]", escapeVar1(node53["defVar"], state32), node53["defVar"]["fullName"]))
		else
			append_21_1(out13, format1("%s = ", escapeVar1(node53["defVar"], state32)))
			compileNative1(out13, meta3)
		end
	elseif (catTag1 == "quote") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out13, ret1)
			end
			compileExpression1(node53[2], out13, state32)
		end
	elseif (catTag1 == "quote-const") then
		if (ret1 == "") then
		else
			if ret1 then
				append_21_1(out13, ret1)
			end
			local r_8951 = type1(node53)
			if (r_8951 == "string") then
				append_21_1(out13, quoted1(node53["value"]))
			elseif (r_8951 == "number") then
				append_21_1(out13, tostring1(node53["value"]))
			elseif (r_8951 == "symbol") then
				append_21_1(out13, _2e2e_2("({ tag=\"symbol\", contents=", quoted1(node53["contents"])))
				if node53["var"] then
					append_21_1(out13, _2e2e_2(", var=", quoted1(tostring1(node53["var"]))))
				end
				append_21_1(out13, "})")
			elseif (r_8951 == "key") then
				append_21_1(out13, _2e2e_2("({tag=\"key\", value=", quoted1(node53["value"]), "})"))
			else
				error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_8951), ", but none matched.\n", "  Tried: `\"string\"`\n  Tried: `\"number\"`\n  Tried: `\"symbol\"`\n  Tried: `\"key\"`"))
			end
		end
	elseif (catTag1 == "quote-list") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, _2e2e_2("({tag = \"list\", n = ", tostring1(n1(node53))))
		local r_9001 = n1(node53)
		local r_8981 = nil
		r_8981 = (function(r_8991)
			if (r_8991 <= r_9001) then
				local sub4 = node53[r_8991]
				append_21_1(out13, ", ")
				compileExpression1(sub4, out13, state32)
				return r_8981((r_8991 + 1))
			else
				return nil
			end
		end)
		r_8981(1)
		append_21_1(out13, "})")
	elseif (catTag1 == "quote-splice") then
		if ret1 then
		else
			line_21_1(out13, "(function()")
			out13["indent"] = (out13["indent"] + 1)
		end
		line_21_1(out13, "local _offset, _result, _temp = 0, {tag=\"list\",n=0}")
		local offset4 = 0
		local r_9041 = n1(node53)
		local r_9021 = nil
		r_9021 = (function(r_9031)
			if (r_9031 <= r_9041) then
				local sub5 = node53[r_9031]
				local cat7 = state32["cat-lookup"][sub5]
				if cat7 then
				else
					print1("Cannot find", pretty1(sub5), formatNode1(sub5))
				end
				if (cat7["category"] == "unquote-splice") then
					offset4 = (offset4 + 1)
					append_21_1(out13, "_temp = ")
					compileExpression1(sub5[2], out13, state32)
					line_21_1(out13)
					line_21_1(out13, _2e2e_2("for _c = 1, _temp.n do _result[", tostring1((r_9031 - offset4)), " + _c + _offset] = _temp[_c] end"))
					line_21_1(out13, "_offset = _offset + _temp.n")
				else
					append_21_1(out13, _2e2e_2("_result[", tostring1((r_9031 - offset4)), " + _offset] = "))
					compileExpression1(sub5, out13, state32)
					line_21_1(out13)
				end
				return r_9021((r_9031 + 1))
			else
				return nil
			end
		end)
		r_9021(1)
		line_21_1(out13, _2e2e_2("_result.n = _offset + ", tostring1((n1(node53) - offset4))))
		if (ret1 == "") then
		elseif ret1 then
			append_21_1(out13, _2e2e_2(ret1, "_result"))
		else
			line_21_1(out13, "return _result")
			out13["indent"] = (out13["indent"] - 1)
			line_21_1(out13, "end)()")
		end
	elseif (catTag1 == "syntax-quote") then
		compileExpression1(node53[2], out13, state32, ret1)
	elseif (catTag1 == "unquote") then
		compileExpression1(node53[2], out13, state32, ret1)
	elseif (catTag1 == "unquote-splice") then
		error1("Should neve have explicit unquote-splice", 0)
	elseif (catTag1 == "import") then
		if (ret1 == nil) then
			append_21_1(out13, "nil")
		elseif (ret1 ~= "") then
			append_21_1(out13, ret1)
			append_21_1(out13, "nil")
		end
	elseif (catTag1 == "call-symbol") then
		local head6 = car1(node53)
		local meta4 = ((type1(head6) == "symbol") and ((head6["var"]["tag"] == "native") and state32["meta"][head6["var"]["fullName"]]))
		local metaTy1 = type1(meta4)
		if (metaTy1 == "nil") then
		elseif (metaTy1 == "boolean") then
		elseif (metaTy1 == "expr") then
		elseif (metaTy1 == "stmt") then
			if ret1 then
			else
				meta4 = nil
			end
		elseif (metaTy1 == "var") then
			meta4 = nil
		else
			_error("unmatched item")
		end
		local temp11
		if meta4 then
			if meta4["fold"] then
				temp11 = ((n1(node53) - 1) >= meta4["count"])
			else
				temp11 = ((n1(node53) - 1) == meta4["count"])
			end
		else
			temp11 = false
		end
		if temp11 then
			if (meta4["tag"] == "expr") then
				if (ret1 == "") then
					append_21_1(out13, "local _ = ")
				elseif ret1 then
					append_21_1(out13, ret1)
				end
			end
			local contents1 = meta4["contents"]
			local fold1 = meta4["fold"]
			local count4 = meta4["count"]
			local build1
			build1 = (function(start7, _eend1)
				local r_9211 = n1(contents1)
				local r_9191 = nil
				r_9191 = (function(r_9201)
					if (r_9201 <= r_9211) then
						local entry6 = contents1[r_9201]
						if string_3f_1(entry6) then
							append_21_1(out13, entry6)
						elseif ((fold1 == "l") and ((entry6 == 1) and (start7 < _eend1))) then
							build1(start7, (_eend1 - 1))
							start7 = _eend1
						elseif ((fold1 == "r") and ((entry6 == 2) and (start7 < _eend1))) then
							build1((start7 + 1), _eend1)
						else
							compileExpression1(node53[((entry6 + start7))], out13, state32)
						end
						return r_9191((r_9201 + 1))
					else
						return nil
					end
				end)
				return r_9191(1)
			end)
			build1(1, (n1(node53) - count4))
			if ((meta4["tag"] ~= "expr") and (ret1 ~= "")) then
				line_21_1(out13)
				append_21_1(out13, ret1)
				append_21_1(out13, "nil")
				line_21_1(out13)
			end
		elseif cat6["recur"] then
			local head7 = cat6["recur"]["def"]
			local args13 = head7[2]
			if (n1(args13) > 0) then
				local packName1 = nil
				local offset5 = 1
				local done1 = false
				local r_9301 = n1(args13)
				local r_9281 = nil
				r_9281 = (function(r_9291)
					if (r_9291 <= r_9301) then
						local var28 = args13[r_9291]["var"]
						if var28["isVariadic"] then
							local count5 = (n1(node53) - n1(args13))
							if (count5 < 0) then
								count5 = 0
							end
							if done1 then
								append_21_1(out13, ", ")
							else
								done1 = true
							end
							append_21_1(out13, escapeVar1(var28, state32))
							offset5 = count5
						else
							local expr1 = node53[((r_9291 + offset5))]
							if (expr1 and (not (type1(expr1) == "symbol") or (expr1["var"] ~= var28))) then
								if done1 then
									append_21_1(out13, ", ")
								else
									done1 = true
								end
								append_21_1(out13, escapeVar1(var28, state32))
							end
						end
						return r_9281((r_9291 + 1))
					else
						return nil
					end
				end)
				r_9281(1)
				append_21_1(out13, " = ")
				local offset6 = 1
				local done2 = false
				local r_9361 = n1(args13)
				local r_9341 = nil
				r_9341 = (function(r_9351)
					if (r_9351 <= r_9361) then
						local var29 = args13[r_9351]["var"]
						if var29["isVariadic"] then
							local count6 = (n1(node53) - n1(args13))
							if (count6 < 0) then
								count6 = 0
							end
							if done2 then
								append_21_1(out13, ", ")
							else
								done2 = true
							end
							if compilePack1(node53, out13, state32, r_9351, count6) then
								packName1 = escapeVar1(var29, state32)
							end
							offset6 = count6
						else
							local expr2 = node53[((r_9351 + offset6))]
							if (expr2 and (not (type1(expr2) == "symbol") or (expr2["var"] ~= var29))) then
								if done2 then
									append_21_1(out13, ", ")
								else
									done2 = true
								end
								compileExpression1(node53[((r_9351 + offset6))], out13, state32)
							end
						end
						return r_9341((r_9351 + 1))
					else
						return nil
					end
				end)
				r_9341(1)
				local r_9421 = n1(node53)
				local r_9401 = nil
				r_9401 = (function(r_9411)
					if (r_9411 <= r_9421) then
						if (r_9411 > 1) then
							append_21_1(out13, ", ")
						end
						compileExpression1(node53[r_9411], out13, state32)
						return r_9401((r_9411 + 1))
					else
						return nil
					end
				end)
				r_9401((n1(args13) + (offset6 + 1)))
				line_21_1(out13)
				if packName1 then
					line_21_1(_2e2e_2(packName1, ".tag = \"list\""))
				end
			else
				local r_9461 = n1(node53)
				local r_9441 = nil
				r_9441 = (function(r_9451)
					if (r_9451 <= r_9461) then
						if (r_9451 > 1) then
							append_21_1(out13, ", ")
						end
						compileExpression1(node53[r_9451], out13, state32, "")
						line_21_1(out13)
						return r_9441((r_9451 + 1))
					else
						return nil
					end
				end)
				r_9441(1)
			end
		else
			if ret1 then
				append_21_1(out13, ret1)
			end
			compileExpression1(head6, out13, state32)
			append_21_1(out13, "(")
			local r_9501 = n1(node53)
			local r_9481 = nil
			r_9481 = (function(r_9491)
				if (r_9491 <= r_9501) then
					if (r_9491 > 2) then
						append_21_1(out13, ", ")
					end
					compileExpression1(node53[r_9491], out13, state32)
					return r_9481((r_9491 + 1))
				else
					return nil
				end
			end)
			r_9481(2)
			append_21_1(out13, ")")
		end
	elseif (catTag1 == "wrap-value") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "(")
		compileExpression1(node53[2], out13, state32)
		append_21_1(out13, ")")
	elseif (catTag1 == "call-lambda") then
		if (ret1 == nil) then
			print1(pretty1(node53), " marked as call-lambda for ", ret1)
		end
		local head8 = car1(node53)
		local args14 = head8[2]
		local argIdx1 = 1
		local valIdx1 = 2
		local argLen2 = n1(args14)
		local valLen1 = n1(node53)
		local r_9541 = nil
		r_9541 = (function()
			if ((argIdx1 <= argLen2) or (valIdx1 <= valLen1)) then
				local arg24 = args14[argIdx1]
				if not arg24 then
					compileExpression1(node53[argIdx1], out13, state32, "")
					argIdx1 = (argIdx1 + 1)
				elseif arg24["var"]["isVariadic"] then
					local esc2 = escapeVar1(arg24["var"], state32)
					local count7 = (valLen1 - argLen2)
					append_21_1(out13, _2e2e_2("local ", esc2))
					if (count7 < 0) then
						count7 = 0
					end
					append_21_1(out13, " = ")
					if compilePack1(node53, out13, state32, argIdx1, count7) then
						append_21_1(out13, _2e2e_2(" ", esc2, ".tag = \"list\""))
					end
					line_21_1(out13)
					argIdx1 = (argIdx1 + 1)
					valIdx1 = (count7 + valIdx1)
				elseif (valIdx1 == valLen1) then
					local argList1 = ({tag = "list", n = 0})
					local val17 = node53[valIdx1]
					local ret2 = nil
					local r_9561 = nil
					r_9561 = (function()
						if (argIdx1 <= argLen2) then
							pushCdr_21_1(argList1, escapeVar1(args14[argIdx1]["var"], state32))
							argIdx1 = (argIdx1 + 1)
							return r_9561()
						else
							return nil
						end
					end)
					r_9561()
					append_21_1(out13, "local ")
					append_21_1(out13, concat1(argList1, ", "))
					if catLookup1[val17]["stmt"] then
						ret2 = _2e2e_2(concat1(argList1, ", "), " = ")
						line_21_1(out13)
					else
						append_21_1(out13, " = ")
					end
					compileExpression1(val17, out13, state32, ret2)
					valIdx1 = (valIdx1 + 1)
				else
					local expr3 = node53[valIdx1]
					local var30 = arg24["var"]
					local esc3 = escapeVar1(var30, state32)
					local ret3 = nil
					append_21_1(out13, _2e2e_2("local ", esc3))
					if expr3 then
						if catLookup1[expr3]["stmt"] then
							ret3 = _2e2e_2(esc3, " = ")
							line_21_1(out13)
						else
							append_21_1(out13, " = ")
						end
						compileExpression1(expr3, out13, state32, ret3)
						line_21_1(out13)
					else
						line_21_1(out13)
					end
					argIdx1 = (argIdx1 + 1)
					valIdx1 = (valIdx1 + 1)
				end
				line_21_1(out13)
				return r_9541()
			else
				return nil
			end
		end)
		r_9541()
		compileBlock1(head8, out13, state32, 3, ret1)
	elseif (catTag1 == "call-literal") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		append_21_1(out13, "(")
		compileExpression1(car1(node53), out13, state32)
		append_21_1(out13, ")(")
		local r_9591 = n1(node53)
		local r_9571 = nil
		r_9571 = (function(r_9581)
			if (r_9581 <= r_9591) then
				if (r_9581 > 2) then
					append_21_1(out13, ", ")
				end
				compileExpression1(node53[r_9581], out13, state32)
				return r_9571((r_9581 + 1))
			else
				return nil
			end
		end)
		r_9571(2)
		append_21_1(out13, ")")
	elseif (catTag1 == "call") then
		if ret1 then
			append_21_1(out13, ret1)
		end
		compileExpression1(car1(node53), out13, state32)
		append_21_1(out13, "(")
		local r_9631 = n1(node53)
		local r_9611 = nil
		r_9611 = (function(r_9621)
			if (r_9621 <= r_9631) then
				if (r_9621 > 2) then
					append_21_1(out13, ", ")
				end
				compileExpression1(node53[r_9621], out13, state32)
				return r_9611((r_9621 + 1))
			else
				return nil
			end
		end)
		r_9611(2)
		append_21_1(out13, ")")
	else
		error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(catTag1), ", but none matched.\n", "  Tried: `\"const\"`\n  Tried: `\"lambda\"`\n  Tried: `\"cond\"`\n  Tried: `\"not\"`\n  Tried: `\"or\"`\n  Tried: `\"or-lambda\"`\n  Tried: `\"and\"`\n  Tried: `\"and-lambda\"`\n  Tried: `\"set!\"`\n  Tried: `\"struct-literal\"`\n  Tried: `\"define\"`\n  Tried: `\"define-native\"`\n  Tried: `\"quote\"`\n  Tried: `\"quote-const\"`\n  Tried: `\"quote-list\"`\n  Tried: `\"quote-splice\"`\n  Tried: `\"syntax-quote\"`\n  Tried: `\"unquote\"`\n  Tried: `\"unquote-splice\"`\n  Tried: `\"import\"`\n  Tried: `\"call-symbol\"`\n  Tried: `\"wrap-value\"`\n  Tried: `\"call-lambda\"`\n  Tried: `\"call-literal\"`\n  Tried: `\"call\"`"))
	end
	if boringCategories1[catTag1] then
		return nil
	else
		return popNode_21_1(out13, node53)
	end
end)
compilePack1 = (function(node54, out14, state33, start8, count8)
	if ((count8 <= 0) or atom_3f_1(node54[((start8 + count8))])) then
		append_21_1(out14, "{ tag=\"list\", n=")
		append_21_1(out14, tostring1(count8))
		local r_9061 = nil
		r_9061 = (function(r_9071)
			if (r_9071 <= count8) then
				append_21_1(out14, ", ")
				compileExpression1(node54[((start8 + r_9071))], out14, state33)
				return r_9061((r_9071 + 1))
			else
				return nil
			end
		end)
		r_9061(1)
		append_21_1(out14, "}")
		return false
	else
		append_21_1(out14, " _pack(")
		local r_9101 = nil
		r_9101 = (function(r_9111)
			if (r_9111 <= count8) then
				if (r_9111 > 1) then
					append_21_1(out14, ", ")
				end
				compileExpression1(node54[((start8 + r_9111))], out14, state33)
				return r_9101((r_9111 + 1))
			else
				return nil
			end
		end)
		r_9101(1)
		append_21_1(out14, ")")
		return true
	end
end)
compileBlock1 = (function(nodes25, out15, state34, start9, ret4)
	local r_7251 = n1(nodes25)
	local r_7231 = nil
	r_7231 = (function(r_7241)
		if (r_7241 <= r_7251) then
			local ret_27_1
			if (r_7241 == n1(nodes25)) then
				ret_27_1 = ret4
			else
				ret_27_1 = ""
			end
			compileExpression1(nodes25[r_7241], out15, state34, ret_27_1)
			line_21_1(out15)
			return r_7231((r_7241 + 1))
		else
			return nil
		end
	end)
	r_7231(start9)
	if ((n1(nodes25) < start9) and (ret4 and (ret4 ~= ""))) then
		append_21_1(out15, ret4)
		return line_21_1(out15, "nil")
	else
		return nil
	end
end)
prelude1 = (function(out16)
	line_21_1(out16, "if not table.pack then table.pack = function(...) return { n = select(\"#\", ...), ... } end end")
	line_21_1(out16, "if not table.unpack then table.unpack = unpack end")
	line_21_1(out16, "local load = load if _VERSION:find(\"5.1\") then load = function(x, n, _, env) local f, e = loadstring(x, n) if not f then error(e, 2) end if env then setfenv(f, env) end return f end end")
	return line_21_1(out16, "local _select, _unpack, _pack, _error = select, table.unpack, table.pack, error")
end)
expression2 = (function(node55, out17, state35, ret5)
	runPass1(categoriseNode1, state35, nil, node55, state35["cat-lookup"], (ret5 ~= nil))
	return compileExpression1(node55, out17, state35, ret5)
end)
block2 = (function(nodes26, out18, state36, start10, ret6)
	runPass1(categoriseNodes1, state36, nil, nodes26, state36["cat-lookup"])
	return compileBlock1(nodes26, out18, state36, start10, ret6)
end)
getinfo1 = debug.getinfo
sethook1 = debug.sethook
traceback1 = debug.traceback
unmangleIdent1 = (function(ident1)
	local esc4 = match1(ident1, "^(.-)%d+$")
	if (esc4 == nil) then
		return ident1
	elseif (sub1(esc4, 1, 2) == "_e") then
		return sub1(ident1, 3)
	else
		local buffer2 = ({tag = "list", n = 0})
		local pos9 = 0
		local len12 = n1(esc4)
		local r_9651 = nil
		r_9651 = (function()
			if (pos9 <= len12) then
				local char3
				local x27 = pos9
				char3 = sub1(esc4, x27, x27)
				if (char3 == "_") then
					local r_9661 = list1(find1(esc4, "^_[%da-z]+_", pos9))
					if ((type1(r_9661) == "list") and ((n1(r_9661) >= 2) and ((n1(r_9661) <= 2) and true))) then
						local start11 = r_9661[1]
						local _eend2 = r_9661[2]
						pos9 = (pos9 + 1)
						local r_9721 = nil
						r_9721 = (function()
							if (pos9 < _eend2) then
								pushCdr_21_1(buffer2, char1(tonumber1(sub1(esc4, pos9, (pos9 + 1)), 16)))
								pos9 = (pos9 + 2)
								return r_9721()
							else
								return nil
							end
						end)
						r_9721()
					else
						pushCdr_21_1(buffer2, "_")
					end
				elseif between_3f_1(char3, "A", "Z") then
					pushCdr_21_1(buffer2, "-")
					pushCdr_21_1(buffer2, lower1(char3))
				else
					pushCdr_21_1(buffer2, char3)
				end
				pos9 = (pos9 + 1)
				return r_9651()
			else
				return nil
			end
		end)
		r_9651()
		return concat1(buffer2)
	end
end)
remapError1 = (function(msg23)
	return (gsub1(gsub1(gsub1(gsub1(msg23, "local '([^']+)'", (function(x28)
		return _2e2e_2("local '", unmangleIdent1(x28), "'")
	end)), "global '([^']+)'", (function(x29)
		return _2e2e_2("global '", unmangleIdent1(x29), "'")
	end)), "upvalue '([^']+)'", (function(x30)
		return _2e2e_2("upvalue '", unmangleIdent1(x30), "'")
	end)), "function '([^']+)'", (function(x31)
		return _2e2e_2("function '", unmangleIdent1(x31), "'")
	end)))
end)
remapMessage1 = (function(mappings1, msg24)
	local r_9771 = list1(match1(msg24, "^(.-):(%d+)(.*)$"))
	if ((type1(r_9771) == "list") and ((n1(r_9771) >= 3) and ((n1(r_9771) <= 3) and true))) then
		local file1 = r_9771[1]
		local line2 = r_9771[2]
		local extra1 = r_9771[3]
		local mapping1 = mappings1[file1]
		if mapping1 then
			local range3 = mapping1[tonumber1(line2)]
			if range3 then
				return _2e2e_2(range3, " (", file1, ":", line2, ")", remapError1(extra1))
			else
				return msg24
			end
		else
			return msg24
		end
	else
		return msg24
	end
end)
remapTraceback1 = (function(mappings2, msg25)
	return gsub1(gsub1(gsub1(gsub1(gsub1(gsub1(gsub1(msg25, "^([^\n:]-:%d+:[^\n]*)", (function(r_9911)
		return remapMessage1(mappings2, r_9911)
	end)), "\9([^\n:]-:%d+:)", (function(msg26)
		return _2e2e_2("\9", remapMessage1(mappings2, msg26))
	end)), "<([^\n:]-:%d+)>\n", (function(msg27)
		return _2e2e_2("<", remapMessage1(mappings2, msg27), ">\n")
	end)), "in local '([^']+)'\n", (function(x32)
		return _2e2e_2("in local '", unmangleIdent1(x32), "'\n")
	end)), "in global '([^']+)'\n", (function(x33)
		return _2e2e_2("in global '", unmangleIdent1(x33), "'\n")
	end)), "in upvalue '([^']+)'\n", (function(x34)
		return _2e2e_2("in upvalue '", unmangleIdent1(x34), "'\n")
	end)), "in function '([^']+)'\n", (function(x35)
		return _2e2e_2("in function '", unmangleIdent1(x35), "'\n")
	end))
end)
generateMappings1 = (function(lines4)
	local outLines1 = ({})
	iterPairs1(lines4, (function(line3, ranges1)
		local rangeLists1 = ({})
		iterPairs1(ranges1, (function(pos10)
			local file2 = pos10["name"]
			local rangeList1 = rangeLists1["file"]
			if rangeList1 then
			else
				rangeList1 = ({["n"]=0,["min"]=huge1,["max"]=(0 - huge1)})
				rangeLists1[file2] = rangeList1
			end
			local r_9941 = pos10["finish"]["line"]
			local r_9921 = nil
			r_9921 = (function(r_9931)
				if (r_9931 <= r_9941) then
					if rangeList1[r_9931] then
					else
						rangeList1["n"] = (rangeList1["n"] + 1)
						rangeList1[r_9931] = true
						if (r_9931 < rangeList1["min"]) then
							rangeList1["min"] = r_9931
						end
						if (r_9931 > rangeList1["max"]) then
							rangeList1["max"] = r_9931
						end
					end
					return r_9921((r_9931 + 1))
				else
					return nil
				end
			end)
			return r_9921(pos10["start"]["line"])
		end))
		local bestName1 = nil
		local bestLines1 = nil
		local bestCount1 = 0
		iterPairs1(rangeLists1, (function(name13, lines5)
			if (lines5["n"] > bestCount1) then
				bestName1 = name13
				bestLines1 = lines5
				bestCount1 = lines5["n"]
				return nil
			else
				return nil
			end
		end))
		outLines1[line3] = (function()
			if (bestLines1["min"] == bestLines1["max"]) then
				return format1("%s:%d", bestName1, bestLines1["min"])
			else
				return format1("%s:%d-%d", bestName1, bestLines1["min"], bestLines1["max"])
			end
		end)()
		return nil
	end))
	return outLines1
end)
loaded1["tacky.traceback"] = ({["remapTraceback"]=remapTraceback1})
createState1 = (function(meta5)
	return ({["level"]=1,["override"]=({}),["timer"]=void1,["count"]=0,["mappings"]=({}),["cat-lookup"]=({}),["ctr-lookup"]=({}),["var-lookup"]=({}),["meta"]=(meta5 or ({}))})
end)
file3 = (function(compiler1, shebang1)
	local state37 = createState1(compiler1["libMeta"])
	local out19 = create2()
	if shebang1 then
		line_21_1(out19, _2e2e_2("#!/usr/bin/env ", shebang1))
	end
	state37["trace"] = true
	prelude1(out19)
	line_21_1(out19, "local _libs = {}")
	local r_10171 = compiler1["libs"]
	local r_10201 = n1(r_10171)
	local r_10181 = nil
	r_10181 = (function(r_10191)
		if (r_10191 <= r_10201) then
			local lib1 = r_10171[r_10191]
			local prefix1 = quoted1(lib1["prefix"])
			local native1 = lib1["native"]
			if native1 then
				line_21_1(out19, "local _temp = (function()")
				local r_10231 = split1(native1, "\n")
				local r_10261 = n1(r_10231)
				local r_10241 = nil
				r_10241 = (function(r_10251)
					if (r_10251 <= r_10261) then
						local line4 = r_10231[r_10251]
						if (line4 ~= "") then
							append_21_1(out19, "\9")
							line_21_1(out19, line4)
						end
						return r_10241((r_10251 + 1))
					else
						return nil
					end
				end)
				r_10241(1)
				line_21_1(out19, "end)()")
				line_21_1(out19, _2e2e_2("for k, v in pairs(_temp) do _libs[", prefix1, ".. k] = v end"))
			end
			return r_10181((r_10191 + 1))
		else
			return nil
		end
	end)
	r_10181(1)
	local count9 = 0
	local r_10291 = compiler1["out"]
	local r_10321 = n1(r_10291)
	local r_10301 = nil
	r_10301 = (function(r_10311)
		if (r_10311 <= r_10321) then
			if r_10291[r_10311]["defVar"] then
				count9 = (count9 + 1)
			end
			return r_10301((r_10311 + 1))
		else
			return nil
		end
	end)
	r_10301(1)
	if between_3f_1(count9, 1, 150) then
		append_21_1(out19, "local ")
		local first7 = true
		local r_10351 = compiler1["out"]
		local r_10381 = n1(r_10351)
		local r_10361 = nil
		r_10361 = (function(r_10371)
			if (r_10371 <= r_10381) then
				local node56 = r_10351[r_10371]
				local var31 = node56["defVar"]
				if var31 then
					if first7 then
						first7 = false
					else
						append_21_1(out19, ", ")
					end
					append_21_1(out19, escapeVar1(var31, state37))
				end
				return r_10361((r_10371 + 1))
			else
				return nil
			end
		end)
		r_10361(1)
		line_21_1(out19)
	else
		line_21_1(out19, "local _ENV = setmetatable({}, {__index=ENV or (getfenv and getfenv()) or _G}) if setfenv then setfenv(0, _ENV) end")
	end
	block2(compiler1["out"], out19, state37, 1, "return ")
	return out19
end)
executeStates1 = (function(backState1, states1, global1, logger8)
	local stateList1 = ({tag = "list", n = 0})
	local nameList1 = ({tag = "list", n = 0})
	local exportList1 = ({tag = "list", n = 0})
	local escapeList1 = ({tag = "list", n = 0})
	local r_7171 = nil
	r_7171 = (function(r_7181)
		if (r_7181 >= 1) then
			local state38 = states1[r_7181]
			if (state38["stage"] == "executed") then
			else
				local node57
				if state38["node"] then
					node57 = nil
				else
					node57 = error1(_2e2e_2("State is in ", state38["stage"], " instead"), 0)
				end
				local var32 = (state38["var"] or ({["name"]="temp"}))
				local escaped1 = escapeVar1(var32, backState1)
				local name14 = var32["name"]
				pushCdr_21_1(stateList1, state38)
				pushCdr_21_1(exportList1, _2e2e_2(escaped1, " = ", escaped1))
				pushCdr_21_1(nameList1, name14)
				pushCdr_21_1(escapeList1, escaped1)
			end
			return r_7171((r_7181 + -1))
		else
			return nil
		end
	end)
	r_7171(n1(states1))
	if empty_3f_1(stateList1) then
		return nil
	else
		local out20 = create2()
		local id3 = backState1["count"]
		local name15 = concat1(nameList1, ",")
		backState1["count"] = (id3 + 1)
		if (n1(name15) > 20) then
			name15 = _2e2e_2(sub1(name15, 1, 17), "...")
		end
		name15 = _2e2e_2("compile#", id3, "{", name15, "}")
		prelude1(out20)
		line_21_1(out20, _2e2e_2("local ", concat1(escapeList1, ", ")))
		local r_10531 = n1(stateList1)
		local r_10511 = nil
		r_10511 = (function(r_10521)
			if (r_10521 <= r_10531) then
				local state39 = stateList1[r_10521]
				expression2(state39["node"], out20, backState1, (function()
					if state39["var"] then
						return ""
					else
						return _2e2e_2(escapeList1[r_10521], "= ")
					end
				end)()
				)
				line_21_1(out20)
				return r_10511((r_10521 + 1))
			else
				return nil
			end
		end)
		r_10511(1)
		line_21_1(out20, _2e2e_2("return { ", concat1(exportList1, ", "), "}"))
		local str4 = concat1(out20["out"])
		backState1["mappings"][name15] = generateMappings1(out20["lines"])
		local r_10551 = list1(load1(str4, _2e2e_2("=", name15), "t", global1))
		if ((type1(r_10551) == "list") and ((n1(r_10551) >= 2) and ((n1(r_10551) <= 2) and (eq_3f_1(r_10551[1], nil) and true)))) then
			local msg28 = r_10551[2]
			local buffer3 = ({tag = "list", n = 0})
			local lines6 = split1(str4, "\n")
			local format2 = _2e2e_2("%", n1(tostring1(n1(lines6))), "d | %s")
			local r_10641 = n1(lines6)
			local r_10621 = nil
			r_10621 = (function(r_10631)
				if (r_10631 <= r_10641) then
					pushCdr_21_1(buffer3, format1(format2, r_10631, lines6[r_10631]))
					return r_10621((r_10631 + 1))
				else
					return nil
				end
			end)
			r_10621(1)
			return error1(_2e2e_2(msg28, ":\n", concat1(buffer3, "\n")), 0)
		elseif ((type1(r_10551) == "list") and ((n1(r_10551) >= 1) and ((n1(r_10551) <= 1) and true))) then
			local fun1 = r_10551[1]
			local r_10691 = list1(xpcall1(fun1, traceback1))
			if ((type1(r_10691) == "list") and ((n1(r_10691) >= 2) and ((n1(r_10691) <= 2) and (eq_3f_1(r_10691[1], false) and true)))) then
				local msg29 = r_10691[2]
				return error1(remapTraceback1(backState1["mappings"], msg29), 0)
			elseif ((type1(r_10691) == "list") and ((n1(r_10691) >= 2) and ((n1(r_10691) <= 2) and (eq_3f_1(r_10691[1], true) and true)))) then
				local tbl1 = r_10691[2]
				local r_10821 = n1(stateList1)
				local r_10801 = nil
				r_10801 = (function(r_10811)
					if (r_10811 <= r_10821) then
						local state40 = stateList1[r_10811]
						local escaped2 = escapeList1[r_10811]
						local res8 = tbl1[escaped2]
						require"tacky.analysis.state".executed(state40, res8)
						if state40["var"] then
							global1[escaped2] = res8
						end
						return r_10801((r_10811 + 1))
					else
						return nil
					end
				end)
				return r_10801(1)
			else
				return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10691), ", but none matched.\n", "  Tried: `(false ?msg)`\n  Tried: `(true ?tbl)`"))
			end
		else
			return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10551), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
		end
	end
end)
native2 = (function(meta6, global2)
	local out21 = create2()
	prelude1(out21)
	append_21_1(out21, "return ")
	compileNative1(out21, meta6)
	local r_10411 = list1(load1(concat1(out21["out"]), _2e2e_2("=", meta6["name"]), "t", global2))
	if ((type1(r_10411) == "list") and ((n1(r_10411) >= 2) and ((n1(r_10411) <= 2) and (eq_3f_1(r_10411[1], nil) and true)))) then
		local msg30 = r_10411[2]
		return error1(_2e2e_2("Cannot compile meta ", meta6["name"], ":\n", msg30), 0)
	elseif ((type1(r_10411) == "list") and ((n1(r_10411) >= 1) and ((n1(r_10411) <= 1) and true))) then
		return r_10411[1]()
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_10411), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
	end
end)
emitLua1 = ({["name"]="emit-lua",["setup"]=(function(spec6)
	addArgument_21_1(spec6, ({tag = "list", n = 1, "--emit-lua"}), "help", "Emit a Lua file.")
	addArgument_21_1(spec6, ({tag = "list", n = 1, "--shebang"}), "value", (arg1[-1] or (arg1[0] or "lua")), "help", "Set the executable to use for the shebang.", "narg", "?")
	return addArgument_21_1(spec6, ({tag = "list", n = 1, "--chmod"}), "help", "Run chmod +x on the resulting file")
end),["pred"]=(function(args15)
	return args15["emit-lua"]
end),["run"]=(function(compiler2, args16)
	if empty_3f_1(args16["input"]) then
		self1(compiler2["log"], "put-error!", "No inputs to compile.")
		exit_21_1(1)
	end
	local out22 = file3(compiler2, args16["shebang"])
	local handle1 = open1(_2e2e_2(args16["output"], ".lua"), "w")
	self1(handle1, "write", concat1(out22["out"]))
	self1(handle1, "close")
	if args16["chmod"] then
		return execute1(_2e2e_2("chmod +x ", quoted1(_2e2e_2(args16["output"], ".lua"))))
	else
		return nil
	end
end)})
emitLisp1 = ({["name"]="emit-lisp",["setup"]=(function(spec7)
	return addArgument_21_1(spec7, ({tag = "list", n = 1, "--emit-lisp"}), "help", "Emit a Lisp file.")
end),["pred"]=(function(args17)
	return args17["emit-lisp"]
end),["run"]=(function(compiler3, args18)
	if empty_3f_1(args18["input"]) then
		self1(compiler3["log"], "put-error!", "No inputs to compile.")
		exit_21_1(1)
	end
	local writer12 = create2()
	block1(compiler3["out"], writer12)
	local handle2 = open1(_2e2e_2(args18["output"], ".lisp"), "w")
	self1(handle2, "write", concat1(writer12["out"]))
	return self1(handle2, "close")
end)})
passArg1 = (function(arg25, data4, value10, usage_21_4)
	local val18 = tonumber1(value10)
	local name16 = _2e2e_2(arg25["name"], "-override")
	local override2 = data4[name16]
	if override2 then
	else
		override2 = ({})
		data4[name16] = override2
	end
	if val18 then
		data4[arg25["name"]] = val18
		return nil
	elseif (sub1(value10, 1, 1) == "-") then
		override2[sub1(value10, 2)] = false
		return nil
	elseif (sub1(value10, 1, 1) == "+") then
		override2[sub1(value10, 2)] = true
		return nil
	else
		return usage_21_4(_2e2e_2("Expected number or enable/disable flag for --", arg25["name"], " , got ", value10))
	end
end)
passRun1 = (function(fun2, name17, passes1)
	return (function(compiler4, args19)
		return fun2(compiler4["out"], ({["track"]=true,["level"]=args19[name17],["override"]=(args19[_2e2e_2(name17, "-override")] or ({})),["pass"]=compiler4[name17],["max-n"]=args19[_2e2e_2(name17, "-n")],["max-time"]=args19[_2e2e_2(name17, "-time")],["compiler"]=compiler4,["meta"]=compiler4["libMeta"],["libs"]=compiler4["libs"],["logger"]=compiler4["log"],["timer"]=compiler4["timer"]}))
	end)
end)
warning1 = ({["name"]="warning",["setup"]=(function(spec8)
	return addArgument_21_1(spec8, ({tag = "list", n = 2, "--warning", "-W"}), "help", "Either the warning level to use or an enable/disable flag for a pass.", "default", 1, "narg", 1, "var", "LEVEL", "many", true, "action", passArg1)
end),["pred"]=(function(args20)
	return (args20["warning"] > 0)
end),["run"]=passRun1(analyse1, "warning")})
optimise2 = ({["name"]="optimise",["setup"]=(function(spec9)
	addArgument_21_1(spec9, ({tag = "list", n = 2, "--optimise", "-O"}), "help", "Either the optimiation level to use or an enable/disable flag for a pass.", "default", 1, "narg", 1, "var", "LEVEL", "many", true, "action", passArg1)
	addArgument_21_1(spec9, ({tag = "list", n = 2, "--optimise-n", "--optn"}), "help", "The maximum number of iterations the optimiser should run for.", "default", 10, "narg", 1, "action", setNumAction1)
	return addArgument_21_1(spec9, ({tag = "list", n = 2, "--optimise-time", "--optt"}), "help", "The maximum time the optimiser should run for.", "default", -1, "narg", 1, "action", setNumAction1)
end),["pred"]=(function(args21)
	return (args21["optimise"] > 0)
end),["run"]=passRun1(optimise1, "optimise")})
Scope2 = require1("tacky.analysis.scope")
formatRange2 = (function(range4)
	return format1("%s:%s", range4["name"], (function(pos11)
		return _2e2e_2(pos11["line"], ":", pos11["column"])
	end)(range4["start"]))
end)
sortVars_21_1 = (function(list5)
	return sort1(list5, (function(a2, b2)
		return (car1(a2) < car1(b2))
	end))
end)
formatDefinition1 = (function(var33)
	local ty7 = type1(var33)
	if (ty7 == "builtin") then
		return "Builtin term"
	elseif (ty7 == "macro") then
		return _2e2e_2("Macro defined at ", formatRange2(getSource1(var33["node"])))
	elseif (ty7 == "native") then
		return _2e2e_2("Native defined at ", formatRange2(getSource1(var33["node"])))
	elseif (ty7 == "defined") then
		return _2e2e_2("Defined at ", formatRange2(getSource1(var33["node"])))
	else
		_error("unmatched item")
	end
end)
formatSignature1 = (function(name18, var34)
	local sig1 = extractSignature1(var34)
	if (sig1 == nil) then
		return name18
	elseif empty_3f_1(sig1) then
		return _2e2e_2("(", name18, ")")
	else
		return _2e2e_2("(", name18, " ", concat1(map1((function(r_10861)
			return r_10861["contents"]
		end), sig1), " "), ")")
	end
end)
writeDocstring1 = (function(out23, str5, scope2)
	local r_10881 = parseDocstring1(str5)
	local r_10911 = n1(r_10881)
	local r_10891 = nil
	r_10891 = (function(r_10901)
		if (r_10901 <= r_10911) then
			local tok3 = r_10881[r_10901]
			local ty8 = type1(tok3)
			if (ty8 == "text") then
				append_21_1(out23, tok3["contents"])
			elseif (ty8 == "boldic") then
				append_21_1(out23, tok3["contents"])
			elseif (ty8 == "bold") then
				append_21_1(out23, tok3["contents"])
			elseif (ty8 == "italic") then
				append_21_1(out23, tok3["contents"])
			elseif (ty8 == "arg") then
				append_21_1(out23, _2e2e_2("`", tok3["contents"], "`"))
			elseif (ty8 == "mono") then
				append_21_1(out23, tok3["whole"])
			elseif (ty8 == "link") then
				local name19 = tok3["contents"]
				local ovar1 = Scope2["get"](scope2, name19)
				if (ovar1 and ovar1["node"]) then
					local loc1 = gsub1(gsub1(getSource1((ovar1["node"]))["name"], "%.lisp$", ""), "/", ".")
					local sig2 = extractSignature1(ovar1)
					append_21_1(out23, format1("[`%s`](%s.md#%s)", name19, loc1, gsub1((function()
						if (sig2 == nil) then
							return ovar1["name"]
						elseif empty_3f_1(sig2) then
							return ovar1["name"]
						else
							return _2e2e_2(name19, " ", concat1(map1((function(r_10941)
								return r_10941["contents"]
							end), sig2), " "))
						end
					end)()
					, "%A+", "-")))
				else
					append_21_1(out23, format1("`%s`", name19))
				end
			else
				_error("unmatched item")
			end
			return r_10891((r_10901 + 1))
		else
			return nil
		end
	end)
	r_10891(1)
	return line_21_1(out23)
end)
exported1 = (function(out24, title1, primary1, vars2, scope3)
	local documented1 = ({tag = "list", n = 0})
	local undocumented1 = ({tag = "list", n = 0})
	iterPairs1(vars2, (function(name20, var35)
		return pushCdr_21_1((function()
			if var35["doc"] then
				return documented1
			else
				return undocumented1
			end
		end)()
		, list1(name20, var35))
	end))
	sortVars_21_1(documented1)
	sortVars_21_1(undocumented1)
	line_21_1(out24, "---")
	line_21_1(out24, _2e2e_2("title: ", title1))
	line_21_1(out24, "---")
	line_21_1(out24, _2e2e_2("# ", title1))
	if primary1 then
		writeDocstring1(out24, primary1, scope3)
		line_21_1(out24, "", true)
	end
	local r_11031 = n1(documented1)
	local r_11011 = nil
	r_11011 = (function(r_11021)
		if (r_11021 <= r_11031) then
			local entry7 = documented1[r_11021]
			local name21 = car1(entry7)
			local var36 = entry7[2]
			line_21_1(out24, _2e2e_2("## `", formatSignature1(name21, var36), "`"))
			line_21_1(out24, _2e2e_2("*", formatDefinition1(var36), "*"))
			line_21_1(out24, "", true)
			if var36["deprecated"] then
				line_21_1(out24, (function()
					if string_3f_1(var36["deprecated"]) then
						return format1("> **Warning:** %s is deprecated: %s", name21, var36["deprecated"])
					else
						return format1("> **Warning:** %s is deprecated.", name21)
					end
				end)()
				)
				line_21_1(out24, "", true)
			end
			writeDocstring1(out24, var36["doc"], var36["scope"])
			line_21_1(out24, "", true)
			return r_11011((r_11021 + 1))
		else
			return nil
		end
	end)
	r_11011(1)
	if empty_3f_1(undocumented1) then
	else
		line_21_1(out24, "## Undocumented symbols")
	end
	local r_11091 = n1(undocumented1)
	local r_11071 = nil
	r_11071 = (function(r_11081)
		if (r_11081 <= r_11091) then
			local entry8 = undocumented1[r_11081]
			local name22 = car1(entry8)
			local var37 = entry8[2]
			line_21_1(out24, _2e2e_2(" - `", formatSignature1(name22, var37), "` *", formatDefinition1(var37), "*"))
			return r_11071((r_11081 + 1))
		else
			return nil
		end
	end)
	return r_11071(1)
end)
docs1 = (function(compiler5, args22)
	if empty_3f_1(args22["input"]) then
		self1(compiler5["log"], "put-error!", "No inputs to generate documentation for.")
		exit_21_1(1)
	end
	local r_11121 = args22["input"]
	local r_11151 = n1(r_11121)
	local r_11131 = nil
	r_11131 = (function(r_11141)
		if (r_11141 <= r_11151) then
			local path1 = r_11121[r_11141]
			if (sub1(path1, -5) == ".lisp") then
				path1 = sub1(path1, 1, -6)
			end
			local lib2 = compiler5["libCache"][path1]
			local writer13 = create2()
			exported1(writer13, lib2["name"], lib2["docs"], lib2["scope"]["exported"], lib2["scope"])
			local handle3 = open1(_2e2e_2(args22["docs"], "/", gsub1(path1, "/", "."), ".md"), "w")
			self1(handle3, "write", concat1(writer13["out"]))
			self1(handle3, "close")
			return r_11131((r_11141 + 1))
		else
			return nil
		end
	end)
	return r_11131(1)
end)
task1 = ({["name"]="docs",["setup"]=(function(spec10)
	return addArgument_21_1(spec10, ({tag = "list", n = 1, "--docs"}), "help", "Specify the folder to emit documentation to.", "default", nil, "narg", 1)
end),["pred"]=(function(args23)
	return (nil ~= args23["docs"])
end),["run"]=docs1})
create3 = coroutine.create
resume1 = coroutine.resume
status1 = coroutine.status
yield1 = coroutine.yield
local discard1 = (function()
	return nil
end)
void2 = ({["put-error!"]=discard1,["put-warning!"]=discard1,["put-verbose!"]=discard1,["put-debug!"]=discard1,["put-time!"]=discard1,["put-node-error!"]=discard1,["put-node-warning!"]=discard1})
hexDigit_3f_1 = (function(char4)
	return (between_3f_1(char4, "0", "9") or (between_3f_1(char4, "a", "f") or between_3f_1(char4, "A", "F")))
end)
binDigit_3f_1 = (function(char5)
	return ((char5 == "0") or (char5 == "1"))
end)
terminator_3f_1 = (function(char6)
	return ((char6 == "\n") or ((char6 == " ") or ((char6 == "\9") or ((char6 == ";") or ((char6 == "(") or ((char6 == ")") or ((char6 == "[") or ((char6 == "]") or ((char6 == "{") or ((char6 == "}") or (char6 == "")))))))))))
end)
digitError_21_1 = (function(logger9, pos12, name23, char7)
	return doNodeError_21_1(logger9, format1("Expected %s digit, got %s", name23, (function()
		if (char7 == "") then
			return "eof"
		else
			return quoted1(char7)
		end
	end)()
	), pos12, nil, pos12, "Invalid digit here")
end)
eofError_21_1 = (function(cont1, logger10, msg31, node58, explain4, ...)
	local lines7 = _pack(...) lines7.tag = "list"
	if cont1 then
		return error1(({["msg"]=msg31,["cont"]=true}), 0)
	else
		return doNodeError_21_1(logger10, msg31, node58, explain4, unpack1(lines7, 1, n1(lines7)))
	end
end)
lex1 = (function(logger11, str6, name24, cont2)
	str6 = gsub1(str6, "\13\n?", "\n")
	local lines8 = split1(str6, "\n")
	local line5 = 1
	local column1 = 1
	local offset7 = 1
	local length1 = n1(str6)
	local out25 = ({tag = "list", n = 0})
	local consume_21_1 = (function()
		if ((function(xs13, x36)
			return sub1(xs13, x36, x36)
		end)(str6, offset7) == "\n") then
			line5 = (line5 + 1)
			column1 = 1
		else
			column1 = (column1 + 1)
		end
		offset7 = (offset7 + 1)
		return nil
	end)
	local range5 = (function(start12, finish2)
		return ({["start"]=start12,["finish"]=(finish2 or start12),["lines"]=lines8,["name"]=name24})
	end)
	local appendWith_21_1 = (function(data5, start13, finish3)
		local start14 = (start13 or ({["line"]=line5,["column"]=column1,["offset"]=offset7}))
		local finish4 = (finish3 or ({["line"]=line5,["column"]=column1,["offset"]=offset7}))
		data5["range"] = range5(start14, finish4)
		data5["contents"] = sub1(str6, start14["offset"], finish4["offset"])
		return pushCdr_21_1(out25, data5)
	end)
	local parseBase1 = (function(name25, p2, base1)
		local start15 = offset7
		local char8
		local xs14 = str6
		local x37 = offset7
		char8 = sub1(xs14, x37, x37)
		if p2(char8) then
		else
			digitError_21_1(logger11, range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), name25, char8)
		end
		local xs15 = str6
		local x38 = (offset7 + 1)
		char8 = sub1(xs15, x38, x38)
		local r_11851 = nil
		r_11851 = (function()
			if p2(char8) then
				consume_21_1()
				local xs16 = str6
				local x39 = (offset7 + 1)
				char8 = sub1(xs16, x39, x39)
				return r_11851()
			else
				return nil
			end
		end)
		r_11851()
		return tonumber1(sub1(str6, start15, offset7), base1)
	end)
	local r_11551 = nil
	r_11551 = (function()
		if (offset7 <= length1) then
			local char9
			local xs17 = str6
			local x40 = offset7
			char9 = sub1(xs17, x40, x40)
			if ((char9 == "\n") or ((char9 == "\9") or (char9 == " "))) then
			elseif (char9 == "(") then
				appendWith_21_1(({["tag"]="open",["close"]=")"}))
			elseif (char9 == ")") then
				appendWith_21_1(({["tag"]="close",["open"]="("}))
			elseif (char9 == "[") then
				appendWith_21_1(({["tag"]="open",["close"]="]"}))
			elseif (char9 == "]") then
				appendWith_21_1(({["tag"]="close",["open"]="["}))
			elseif (char9 == "{") then
				appendWith_21_1(({["tag"]="open-struct",["close"]="}"}))
			elseif (char9 == "}") then
				appendWith_21_1(({["tag"]="close",["open"]="{"}))
			elseif (char9 == "'") then
				local start16
				local finish5
				appendWith_21_1(({["tag"]="quote"}), nil, nil)
			elseif (char9 == "`") then
				local start17
				local finish6
				appendWith_21_1(({["tag"]="syntax-quote"}), nil, nil)
			elseif (char9 == "~") then
				local start18
				local finish7
				appendWith_21_1(({["tag"]="quasiquote"}), nil, nil)
			elseif (char9 == ",") then
				if ((function(xs18, x41)
					return sub1(xs18, x41, x41)
				end)(str6, (offset7 + 1)) == "@") then
					local start19 = ({["line"]=line5,["column"]=column1,["offset"]=offset7})
					consume_21_1()
					local finish8
					appendWith_21_1(({["tag"]="unquote-splice"}), start19, nil)
				else
					local start20
					local finish9
					appendWith_21_1(({["tag"]="unquote"}), nil, nil)
				end
			elseif find1(str6, "^%-?%.?[#0-9]", offset7) then
				local start21 = ({["line"]=line5,["column"]=column1,["offset"]=offset7})
				local negative1 = (char9 == "-")
				if negative1 then
					consume_21_1()
					local xs19 = str6
					local x42 = offset7
					char9 = sub1(xs19, x42, x42)
				end
				local val19
				if ((char9 == "#") and (lower1((function(xs20, x43)
					return sub1(xs20, x43, x43)
				end)(str6, (offset7 + 1))) == "x")) then
					consume_21_1()
					consume_21_1()
					local res9 = parseBase1("hexadecimal", hexDigit_3f_1, 16)
					if negative1 then
						res9 = (0 - res9)
					end
					val19 = res9
				elseif ((char9 == "#") and (lower1((function(xs21, x44)
					return sub1(xs21, x44, x44)
				end)(str6, (offset7 + 1))) == "b")) then
					consume_21_1()
					consume_21_1()
					local res10 = parseBase1("binary", binDigit_3f_1, 2)
					if negative1 then
						res10 = (0 - res10)
					end
					val19 = res10
				elseif ((char9 == "#") and terminator_3f_1(lower1((function(xs22, x45)
					return sub1(xs22, x45, x45)
				end)(str6, (offset7 + 1))))) then
					val19 = doNodeError_21_1(logger11, "Expected hexadecimal (#x) or binary (#b) digit.", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "The '#' character is used for various number representations, such as binary\nand hexadecimal digits.\n\nIf you're looking for the '#' function, this has been replaced with 'n'. We\napologise for the inconvenience.", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "# must be followed by x or b")
				elseif (char9 == "#") then
					consume_21_1()
					val19 = doNodeError_21_1(logger11, "Expected hexadecimal (#x) or binary (#b) digit specifier.", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "The '#' character is used for various number representations, namely binary\nand hexadecimal digits.", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "# must be followed by x or b")
				else
					local r_11691 = nil
					r_11691 = (function()
						if between_3f_1((function(xs23, x46)
							return sub1(xs23, x46, x46)
						end)(str6, (offset7 + 1)), "0", "9") then
							consume_21_1()
							return r_11691()
						else
							return nil
						end
					end)
					r_11691()
					if ((function(xs24, x47)
						return sub1(xs24, x47, x47)
					end)(str6, (offset7 + 1)) == ".") then
						consume_21_1()
						local r_11701 = nil
						r_11701 = (function()
							if between_3f_1((function(xs25, x48)
								return sub1(xs25, x48, x48)
							end)(str6, (offset7 + 1)), "0", "9") then
								consume_21_1()
								return r_11701()
							else
								return nil
							end
						end)
						r_11701()
					end
					local xs26 = str6
					local x49 = (offset7 + 1)
					char9 = sub1(xs26, x49, x49)
					if ((char9 == "e") or (char9 == "E")) then
						consume_21_1()
						local xs27 = str6
						local x50 = (offset7 + 1)
						char9 = sub1(xs27, x50, x50)
						if ((char9 == "-") or (char9 == "+")) then
							consume_21_1()
						end
						local r_11731 = nil
						r_11731 = (function()
							if between_3f_1((function(xs28, x51)
								return sub1(xs28, x51, x51)
							end)(str6, (offset7 + 1)), "0", "9") then
								consume_21_1()
								return r_11731()
							else
								return nil
							end
						end)
						r_11731()
					end
					val19 = tonumber1(sub1(str6, start21["offset"], offset7))
				end
				appendWith_21_1(({["tag"]="number",["value"]=val19}), start21)
				local xs29 = str6
				local x52 = (offset7 + 1)
				char9 = sub1(xs29, x52, x52)
				if terminator_3f_1(char9) then
				else
					consume_21_1()
					doNodeError_21_1(logger11, format1("Expected digit, got %s", (function()
						if (char9 == "") then
							return "eof"
						else
							return char9
						end
					end)()
					), range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), nil, range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "Illegal character here. Are you missing whitespace?")
				end
			elseif (char9 == "\"") then
				local start22 = ({["line"]=line5,["column"]=column1,["offset"]=offset7})
				local startCol1 = (column1 + 1)
				local buffer4 = ({tag = "list", n = 0})
				consume_21_1()
				local xs30 = str6
				local x53 = offset7
				char9 = sub1(xs30, x53, x53)
				local r_11741 = nil
				r_11741 = (function()
					if (char9 ~= "\"") then
						if (column1 == 1) then
							local running3 = true
							local lineOff1 = offset7
							local r_11751 = nil
							r_11751 = (function()
								if (running3 and (column1 < startCol1)) then
									if (char9 == " ") then
										consume_21_1()
									elseif (char9 == "\n") then
										consume_21_1()
										pushCdr_21_1(buffer4, "\n")
										lineOff1 = offset7
									elseif (char9 == "") then
										running3 = false
									else
										putNodeWarning_21_1(logger11, format1("Expected leading indent, got %q", char9), range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "You should try to align multi-line strings at the initial quote\nmark. This helps keep programs neat and tidy.", range5(start22), "String started with indent here", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "Mis-aligned character here")
										pushCdr_21_1(buffer4, sub1(str6, lineOff1, (offset7 - 1)))
										running3 = false
									end
									local xs31 = str6
									local x54 = offset7
									char9 = sub1(xs31, x54, x54)
									return r_11751()
								else
									return nil
								end
							end)
							r_11751()
						end
						if (char9 == "") then
							local start23 = range5(start22)
							local finish10 = range5(({["line"]=line5,["column"]=column1,["offset"]=offset7}))
							eofError_21_1(cont2, logger11, "Expected '\"', got eof", finish10, nil, start23, "string started here", finish10, "end of file here")
						elseif (char9 == "\\") then
							consume_21_1()
							local xs32 = str6
							local x55 = offset7
							char9 = sub1(xs32, x55, x55)
							if (char9 == "\n") then
							elseif (char9 == "a") then
								pushCdr_21_1(buffer4, "\7")
							elseif (char9 == "b") then
								pushCdr_21_1(buffer4, "\8")
							elseif (char9 == "f") then
								pushCdr_21_1(buffer4, "\12")
							elseif (char9 == "n") then
								pushCdr_21_1(buffer4, "\n")
							elseif (char9 == "r") then
								pushCdr_21_1(buffer4, "\13")
							elseif (char9 == "t") then
								pushCdr_21_1(buffer4, "\9")
							elseif (char9 == "v") then
								pushCdr_21_1(buffer4, "\11")
							elseif (char9 == "\"") then
								pushCdr_21_1(buffer4, "\"")
							elseif (char9 == "\\") then
								pushCdr_21_1(buffer4, "\\")
							elseif ((char9 == "x") or ((char9 == "X") or between_3f_1(char9, "0", "9"))) then
								local start24 = ({["line"]=line5,["column"]=column1,["offset"]=offset7})
								local val20
								if ((char9 == "x") or (char9 == "X")) then
									consume_21_1()
									local start25 = offset7
									if hexDigit_3f_1((function(xs33, x56)
										return sub1(xs33, x56, x56)
									end)(str6, offset7)) then
									else
										digitError_21_1(logger11, range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "hexadecimal", (function(xs34, x57)
											return sub1(xs34, x57, x57)
										end)(str6, offset7))
									end
									if hexDigit_3f_1((function(xs35, x58)
										return sub1(xs35, x58, x58)
									end)(str6, (offset7 + 1))) then
										consume_21_1()
									end
									val20 = tonumber1(sub1(str6, start25, offset7), 16)
								else
									local start26 = ({["line"]=line5,["column"]=column1,["offset"]=offset7})
									local ctr1 = 0
									local xs36 = str6
									local x59 = (offset7 + 1)
									char9 = sub1(xs36, x59, x59)
									local r_11801 = nil
									r_11801 = (function()
										if ((ctr1 < 2) and between_3f_1(char9, "0", "9")) then
											consume_21_1()
											local xs37 = str6
											local x60 = (offset7 + 1)
											char9 = sub1(xs37, x60, x60)
											ctr1 = (ctr1 + 1)
											return r_11801()
										else
											return nil
										end
									end)
									r_11801()
									val20 = tonumber1(sub1(str6, start26["offset"], offset7))
								end
								if (val20 >= 256) then
									doNodeError_21_1(logger11, "Invalid escape code", range5(start24), nil, range5(start24, ({["line"]=line5,["column"]=column1,["offset"]=offset7})), _2e2e_2("Must be between 0 and 255, is ", val20))
								end
								pushCdr_21_1(buffer4, char1(val20))
							elseif (char9 == "") then
								eofError_21_1(cont2, logger11, "Expected escape code, got eof", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), nil, range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "end of file here")
							else
								doNodeError_21_1(logger11, "Illegal escape character", range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), nil, range5(({["line"]=line5,["column"]=column1,["offset"]=offset7})), "Unknown escape character")
							end
						else
							pushCdr_21_1(buffer4, char9)
						end
						consume_21_1()
						local xs38 = str6
						local x61 = offset7
						char9 = sub1(xs38, x61, x61)
						return r_11741()
					else
						return nil
					end
				end)
				r_11741()
				appendWith_21_1(({["tag"]="string",["value"]=concat1(buffer4)}), start22)
			elseif (char9 == ";") then
				local r_11821 = nil
				r_11821 = (function()
					if ((offset7 <= length1) and ((function(xs39, x62)
						return sub1(xs39, x62, x62)
					end)(str6, (offset7 + 1)) ~= "\n")) then
						consume_21_1()
						return r_11821()
					else
						return nil
					end
				end)
				r_11821()
			else
				local start27 = ({["line"]=line5,["column"]=column1,["offset"]=offset7})
				local key10 = (char9 == ":")
				local xs40 = str6
				local x63 = (offset7 + 1)
				char9 = sub1(xs40, x63, x63)
				local r_11841 = nil
				r_11841 = (function()
					if not terminator_3f_1(char9) then
						consume_21_1()
						local xs41 = str6
						local x64 = (offset7 + 1)
						char9 = sub1(xs41, x64, x64)
						return r_11841()
					else
						return nil
					end
				end)
				r_11841()
				if key10 then
					appendWith_21_1(({["tag"]="key",["value"]=sub1(str6, (start27["offset"] + 1), offset7)}), start27)
				else
					local finish11
					appendWith_21_1(({["tag"]="symbol"}), start27, nil)
				end
			end
			consume_21_1()
			return r_11551()
		else
			return nil
		end
	end)
	r_11551()
	local start28
	local finish12
	appendWith_21_1(({["tag"]="eof"}), nil, nil)
	return out25
end)
parse1 = (function(logger12, toks1, cont3)
	local head9 = ({tag = "list", n = 0})
	local stack2 = ({tag = "list", n = 0})
	local push_21_1 = (function()
		local next1 = ({tag = "list", n = 0})
		pushCdr_21_1(stack2, head9)
		pushCdr_21_1(head9, next1)
		head9 = next1
		return nil
	end)
	local pop_21_1 = (function()
		head9["open"] = nil
		head9["close"] = nil
		head9["auto-close"] = nil
		head9["last-node"] = nil
		head9 = last1(stack2)
		return popLast_21_1(stack2)
	end)
	local r_11621 = n1(toks1)
	local r_11601 = nil
	r_11601 = (function(r_11611)
		if (r_11611 <= r_11621) then
			local tok4 = toks1[r_11611]
			local tag10 = tok4["tag"]
			local autoClose1 = false
			local previous2 = head9["last-node"]
			local tokPos1 = tok4["range"]
			local temp12
			if (tag10 ~= "eof") then
				if (tag10 ~= "close") then
					if head9["range"] then
						temp12 = (tokPos1["start"]["line"] ~= head9["range"]["start"]["line"])
					else
						temp12 = true
					end
				else
					temp12 = false
				end
			else
				temp12 = false
			end
			if temp12 then
				if previous2 then
					local prevPos1 = previous2["range"]
					if (tokPos1["start"]["line"] ~= prevPos1["start"]["line"]) then
						head9["last-node"] = tok4
						if (tokPos1["start"]["column"] ~= prevPos1["start"]["column"]) then
							putNodeWarning_21_1(logger12, "Different indent compared with previous expressions.", tok4, "You should try to maintain consistent indentation across a program,\ntry to ensure all expressions are lined up.\nIf this looks OK to you, check you're not missing a closing ')'.", prevPos1, "", tokPos1, "")
						end
					end
				else
					head9["last-node"] = tok4
				end
			end
			if ((tag10 == "string") or ((tag10 == "number") or ((tag10 == "symbol") or (tag10 == "key")))) then
				pushCdr_21_1(head9, tok4)
			elseif (tag10 == "open") then
				push_21_1()
				head9["open"] = tok4["contents"]
				head9["close"] = tok4["close"]
				head9["range"] = ({["start"]=tok4["range"]["start"],["name"]=tok4["range"]["name"],["lines"]=tok4["range"]["lines"]})
			elseif (tag10 == "open-struct") then
				push_21_1()
				head9["open"] = tok4["contents"]
				head9["close"] = tok4["close"]
				head9["range"] = ({["start"]=tok4["range"]["start"],["name"]=tok4["range"]["name"],["lines"]=tok4["range"]["lines"]})
				local node59 = ({["tag"]="symbol",["contents"]="struct-literal",["range"]=head9["range"]})
				pushCdr_21_1(head9, node59)
			elseif (tag10 == "close") then
				if empty_3f_1(stack2) then
					doNodeError_21_1(logger12, format1("'%s' without matching '%s'", tok4["contents"], tok4["open"]), tok4, nil, getSource1(tok4), "")
				elseif head9["auto-close"] then
					doNodeError_21_1(logger12, format1("'%s' without matching '%s' inside quote", tok4["contents"], tok4["open"]), tok4, nil, head9["range"], "quote opened here", tok4["range"], "attempting to close here")
				elseif (head9["close"] ~= tok4["contents"]) then
					doNodeError_21_1(logger12, format1("Expected '%s', got '%s'", head9["close"], tok4["contents"]), tok4, nil, head9["range"], format1("block opened with '%s'", head9["open"]), tok4["range"], format1("'%s' used here", tok4["contents"]))
				else
					head9["range"]["finish"] = tok4["range"]["finish"]
					pop_21_1()
				end
			elseif ((tag10 == "quote") or ((tag10 == "unquote") or ((tag10 == "syntax-quote") or ((tag10 == "unquote-splice") or (tag10 == "quasiquote"))))) then
				push_21_1()
				head9["range"] = ({["start"]=tok4["range"]["start"],["name"]=tok4["range"]["name"],["lines"]=tok4["range"]["lines"]})
				local node60 = ({["tag"]="symbol",["contents"]=tag10,["range"]=tok4["range"]})
				pushCdr_21_1(head9, node60)
				autoClose1 = true
				head9["auto-close"] = true
			elseif (tag10 == "eof") then
				if (0 ~= n1(stack2)) then
					eofError_21_1(cont3, logger12, format1("Expected '%s', got 'eof'", head9["close"]), tok4, nil, head9["range"], "block opened here", tok4["range"], "end of file here")
				end
			else
				error1(_2e2e_2("Unsupported type", tag10))
			end
			if autoClose1 then
			else
				local r_11961 = nil
				r_11961 = (function()
					if head9["auto-close"] then
						if empty_3f_1(stack2) then
							doNodeError_21_1(logger12, format1("'%s' without matching '%s'", tok4["contents"], tok4["open"]), tok4, nil, getSource1(tok4), "")
						end
						head9["range"]["finish"] = tok4["range"]["finish"]
						pop_21_1()
						return r_11961()
					else
						return nil
					end
				end)
				r_11961()
			end
			return r_11601((r_11611 + 1))
		else
			return nil
		end
	end)
	r_11601(1)
	return head9
end)
read2 = (function(x65, path2)
	return parse1(void2, lex1(void2, x65, (path2 or "")))
end)
compile1 = require1("tacky.compile")["compile"]
Scope3 = require1("tacky.analysis.scope")
requiresInput1 = (function(str7)
	local r_11171 = list1(pcall1((function()
		return parse1(void2, lex1(void2, str7, "<stdin>", true), true)
	end)))
	if ((type1(r_11171) == "list") and ((n1(r_11171) >= 2) and ((n1(r_11171) <= 2) and (eq_3f_1(r_11171[1], true) and true)))) then
		return false
	elseif ((type1(r_11171) == "list") and ((n1(r_11171) >= 2) and ((n1(r_11171) <= 2) and (eq_3f_1(r_11171[1], false) and (type_23_1((r_11171[2])) == "table"))))) then
		if r_11171[2]["cont"] then
			return true
		else
			return false
		end
	elseif ((type1(r_11171) == "list") and ((n1(r_11171) >= 2) and ((n1(r_11171) <= 2) and (eq_3f_1(r_11171[1], false) and true)))) then
		local x66 = r_11171[2]
		print1(("x = " .. pretty1(x66)))
		return nil
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_11171), ", but none matched.\n", "  Tried: `(true _)`\n  Tried: `(false (table? @ ?x))`\n  Tried: `(false ?x)`"))
	end
end)
doResolve1 = (function(compiler6, scope4, str8)
	local logger13 = compiler6["log"]
	local lexed1 = lex1(logger13, str8, "<stdin>")
	return car1(cdr1((list1(compile1(compiler6, executeStates1, parse1(logger13, lexed1), scope4)))))
end)
if getenv1 then
	local clrs1 = getenv1("URN_COLOURS")
	if clrs1 then
		replColourScheme1 = (read2(clrs1) or nil)
	else
		replColourScheme1 = nil
	end
else
	replColourScheme1 = nil
end
colourFor1 = (function(elem8)
	if assoc_3f_1(replColourScheme1, ({["tag"]="symbol",["contents"]=elem8})) then
		return constVal1(assoc1(replColourScheme1, ({["tag"]="symbol",["contents"]=elem8})))
	else
		if (elem8 == "text") then
			return 0
		elseif (elem8 == "arg") then
			return 36
		elseif (elem8 == "mono") then
			return 97
		elseif (elem8 == "bold") then
			return 1
		elseif (elem8 == "italic") then
			return 3
		elseif (elem8 == "link") then
			return 94
		else
			return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(elem8), ", but none matched.\n", "  Tried: `\"text\"`\n  Tried: `\"arg\"`\n  Tried: `\"mono\"`\n  Tried: `\"bold\"`\n  Tried: `\"italic\"`\n  Tried: `\"link\"`"))
		end
	end
end)
printDocs_21_1 = (function(str9)
	local docs2 = parseDocstring1(str9)
	local r_11381 = n1(docs2)
	local r_11361 = nil
	r_11361 = (function(r_11371)
		if (r_11371 <= r_11381) then
			local tok5 = docs2[r_11371]
			local tag11 = tok5["tag"]
			if (tag11 == "bolic") then
				write1(colored1(colourFor1("bold"), colored1(colourFor1("italic"), tok5["contents"])))
			else
				write1(colored1(colourFor1(tag11), tok5["contents"]))
			end
			return r_11361((r_11371 + 1))
		else
			return nil
		end
	end)
	r_11361(1)
	return print1()
end)
execCommand1 = (function(compiler7, scope5, args24)
	local logger14 = compiler7["log"]
	local command1 = car1(args24)
	if ((command1 == "help") or (command1 == "h")) then
		return print1("REPL commands:\n[:d]oc NAME        Get documentation about a symbol\n:scope             Print out all variables in the scope\n[:s]earch QUERY    Search the current scope for symbols and documentation containing a string.\n:module NAME       Display a loaded module's docs and definitions.")
	elseif ((command1 == "doc") or (command1 == "d")) then
		local name26 = args24[2]
		if name26 then
			local var38 = Scope3["get"](scope5, name26)
			if (var38 == nil) then
				return self1(logger14, "put-error!", (_2e2e_2("Cannot find '", name26, "'")))
			elseif not var38["doc"] then
				return self1(logger14, "put-error!", (_2e2e_2("No documentation for '", name26, "'")))
			else
				local sig3 = extractSignature1(var38)
				local name27 = var38["fullName"]
				if sig3 then
					local buffer5 = list1(name27)
					local r_12051 = n1(sig3)
					local r_12031 = nil
					r_12031 = (function(r_12041)
						if (r_12041 <= r_12051) then
							pushCdr_21_1(buffer5, sig3[r_12041]["contents"])
							return r_12031((r_12041 + 1))
						else
							return nil
						end
					end)
					r_12031(1)
					name27 = _2e2e_2("(", concat1(buffer5, " "), ")")
				end
				print1(colored1(96, name27))
				return printDocs_21_1(var38["doc"])
			end
		else
			return self1(logger14, "put-error!", ":doc <variable>")
		end
	elseif (command1 == "module") then
		local name28 = args24[2]
		if name28 then
			local mod1 = compiler7["libNames"][name28]
			if (mod1 == nil) then
				return self1(logger14, "put-error!", (_2e2e_2("Cannot find '", name28, "'")))
			else
				print1(colored1(96, mod1["name"]))
				if mod1["docs"] then
					printDocs_21_1(mod1["docs"])
					print1()
				end
				print1(colored1(92, "Exported symbols"))
				local vars3 = ({tag = "list", n = 0})
				iterPairs1(mod1["scope"]["exported"], (function(name29)
					return pushCdr_21_1(vars3, name29)
				end))
				sort1(vars3)
				return print1(concat1(vars3, "  "))
			end
		else
			return self1(logger14, "put-error!", ":module <variable>")
		end
	elseif (command1 == "scope") then
		local vars4 = ({tag = "list", n = 0})
		local varsSet1 = ({})
		local current1 = scope5
		local r_12071 = nil
		r_12071 = (function()
			if current1 then
				iterPairs1(current1["variables"], (function(name30, var39)
					if varsSet1[name30] then
						return nil
					else
						pushCdr_21_1(vars4, name30)
						varsSet1[name30] = true
						return nil
					end
				end))
				current1 = current1["parent"]
				return r_12071()
			else
				return nil
			end
		end)
		r_12071()
		sort1(vars4)
		return print1(concat1(vars4, "  "))
	elseif ((command1 == "search") or (command1 == "s")) then
		if (n1(args24) > 1) then
			local keywords2 = map1(lower1, cdr1(args24))
			local nameResults1 = ({tag = "list", n = 0})
			local docsResults1 = ({tag = "list", n = 0})
			local vars5 = ({tag = "list", n = 0})
			local varsSet2 = ({})
			local current2 = scope5
			local r_12091 = nil
			r_12091 = (function()
				if current2 then
					iterPairs1(current2["variables"], (function(name31, var40)
						if varsSet2[name31] then
							return nil
						else
							pushCdr_21_1(vars5, name31)
							varsSet2[name31] = true
							return nil
						end
					end))
					current2 = current2["parent"]
					return r_12091()
				else
					return nil
				end
			end)
			r_12091()
			local r_12141 = n1(vars5)
			local r_12121 = nil
			r_12121 = (function(r_12131)
				if (r_12131 <= r_12141) then
					local var41 = vars5[r_12131]
					local r_12201 = n1(keywords2)
					local r_12181 = nil
					r_12181 = (function(r_12191)
						if (r_12191 <= r_12201) then
							if find1(var41, (keywords2[r_12191])) then
								pushCdr_21_1(nameResults1, var41)
							end
							return r_12181((r_12191 + 1))
						else
							return nil
						end
					end)
					r_12181(1)
					local docVar1 = Scope3["get"](scope5, var41)
					if docVar1 then
						local tempDocs1 = docVar1["doc"]
						if tempDocs1 then
							local docs3 = lower1(tempDocs1)
							if docs3 then
								local keywordsFound1 = 0
								if keywordsFound1 then
									local r_12261 = n1(keywords2)
									local r_12241 = nil
									r_12241 = (function(r_12251)
										if (r_12251 <= r_12261) then
											if find1(docs3, (keywords2[r_12251])) then
												keywordsFound1 = (keywordsFound1 + 1)
											end
											return r_12241((r_12251 + 1))
										else
											return nil
										end
									end)
									r_12241(1)
									if eq_3f_1(keywordsFound1, n1(keywords2)) then
										pushCdr_21_1(docsResults1, var41)
									end
								else
								end
							else
							end
						else
						end
					else
					end
					return r_12121((r_12131 + 1))
				else
					return nil
				end
			end)
			r_12121(1)
			if (empty_3f_1(nameResults1) and empty_3f_1(docsResults1)) then
				return self1(logger14, "put-error!", "No results")
			else
				if not empty_3f_1(nameResults1) then
					print1(colored1(92, "Search by function name:"))
					if (n1(nameResults1) > 20) then
						print1(_2e2e_2(concat1(slice1(nameResults1, 1, 20), "  "), "  ..."))
					else
						print1(concat1(nameResults1, "  "))
					end
				end
				if not empty_3f_1(docsResults1) then
					print1(colored1(92, "Search by function docs:"))
					if (n1(docsResults1) > 20) then
						return print1(_2e2e_2(concat1(slice1(docsResults1, 1, 20), "  "), "  ..."))
					else
						return print1(concat1(docsResults1, "  "))
					end
				else
					return nil
				end
			end
		else
			return self1(logger14, "put-error!", ":search <keywords>")
		end
	else
		return self1(logger14, "put-error!", (_2e2e_2("Unknown command '", command1, "'")))
	end
end)
execString1 = (function(compiler8, scope6, string1)
	local state41 = doResolve1(compiler8, scope6, string1)
	if (n1(state41) > 0) then
		local current3 = 0
		local exec1 = create3((function()
			local r_12511 = n1(state41)
			local r_12491 = nil
			r_12491 = (function(r_12501)
				if (r_12501 <= r_12511) then
					local elem9 = state41[r_12501]
					current3 = elem9
					require"tacky.analysis.state".get(current3)
					return r_12491((r_12501 + 1))
				else
					return nil
				end
			end)
			return r_12491(1)
		end))
		local compileState1 = compiler8["compileState"]
		local rootScope1 = compiler8["rootScope"]
		local global3 = compiler8["global"]
		local logger15 = compiler8["log"]
		local run1 = true
		local r_11401 = nil
		r_11401 = (function()
			if run1 then
				local res11 = list1(resume1(exec1))
				if not car1(res11) then
					self1(logger15, "put-error!", (car1(cdr1(res11))))
					run1 = false
				elseif (status1(exec1) == "dead") then
					local lvl1 = require"tacky.analysis.state".get(last1(state41))
					print1(_2e2e_2("out = ", colored1(96, pretty1(lvl1))))
					global3[escapeVar1(Scope3["add"](scope6, "out", "defined", lvl1), compileState1)] = lvl1
					run1 = false
				else
					local states2 = car1(cdr1(res11))["states"]
					local latest1 = car1(states2)
					local co1 = create3(executeStates1)
					local task2 = nil
					local r_12291 = nil
					r_12291 = (function()
						if (run1 and (status1(co1) ~= "dead")) then
							compiler8["active-node"] = latest1["node"]
							compiler8["active-scope"] = latest1["scope"]
							local res12
							if task2 then
								res12 = list1(resume1(co1))
							else
								res12 = list1(resume1(co1, compileState1, states2, global3, logger15))
							end
							compiler8["active-node"] = nil
							compiler8["active-scope"] = nil
							if ((type1(res12) == "list") and ((n1(res12) >= 2) and ((n1(res12) <= 2) and (eq_3f_1(res12[1], false) and true)))) then
								error1((res12[2]), 0)
							elseif ((type1(res12) == "list") and ((n1(res12) >= 1) and ((n1(res12) <= 1) and eq_3f_1(res12[1], true)))) then
							elseif ((type1(res12) == "list") and ((n1(res12) >= 2) and ((n1(res12) <= 2) and (eq_3f_1(res12[1], true) and true)))) then
								local arg26 = res12[2]
								if (status1(co1) ~= "dead") then
									task2 = arg26
									local r_12461 = task2["tag"]
									if (r_12461 == "execute") then
										executeStates1(compileState1, task2["states"], global3, logger15)
									else
										_2e2e_2("Cannot handle ", r_12461)
									end
								end
							else
								error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(res12), ", but none matched.\n", "  Tried: `(false ?msg)`\n  Tried: `(true)`\n  Tried: `(true ?arg)`"))
							end
							return r_12291()
						else
							return nil
						end
					end)
					r_12291()
				end
				return r_11401()
			else
				return nil
			end
		end)
		return r_11401()
	else
		return nil
	end
end)
repl1 = (function(compiler9)
	local scope7 = compiler9["rootScope"]
	local logger16 = compiler9["log"]
	local buffer6 = ""
	local running4 = true
	local r_11411 = nil
	r_11411 = (function()
		if running4 then
			write1(colored1(92, (function()
				if empty_3f_1(buffer6) then
					return "> "
				else
					return ". "
				end
			end)()
			))
			flush1()
			local line6 = read1("*l")
			if (not line6 and empty_3f_1(buffer6)) then
				running4 = false
			else
				local data6
				if line6 then
					data6 = _2e2e_2(buffer6, line6, "\n")
				else
					data6 = buffer6
				end
				if (sub1(data6, 1, 1) == ":") then
					buffer6 = ""
					execCommand1(compiler9, scope7, map1(trim1, split1(sub1(data6, 2), " ")))
				elseif (line6 and ((n1(line6) > 0) and requiresInput1(data6))) then
					buffer6 = data6
				else
					buffer6 = ""
					scope7 = Scope3["child"](scope7)
					scope7["isRoot"] = true
					local res13 = list1(pcall1(execString1, compiler9, scope7, data6))
					compiler9["active-node"] = nil
					compiler9["active-scope"] = nil
					if car1(res13) then
					else
						self1(logger16, "put-error!", (car1(cdr1(res13))))
					end
				end
			end
			return r_11411()
		else
			return nil
		end
	end)
	return r_11411()
end)
exec2 = (function(compiler10)
	local data7 = read1("*a")
	local scope8 = compiler10["rootScope"]
	local logger17 = compiler10["log"]
	local res14 = list1(pcall1(execString1, compiler10, scope8, data7))
	if car1(res14) then
	else
		self1(logger17, "put-error!", (car1(cdr1(res14))))
	end
	return exit1(0)
end)
replTask1 = ({["name"]="repl",["setup"]=(function(spec11)
	return addArgument_21_1(spec11, ({tag = "list", n = 1, "--repl"}), "help", "Start an interactive session.")
end),["pred"]=(function(args25)
	return args25["repl"]
end),["run"]=repl1})
execTask1 = ({["name"]="exec",["setup"]=(function(spec12)
	return addArgument_21_1(spec12, ({tag = "list", n = 1, "--exec"}), "help", "Execute a program without compiling it.")
end),["pred"]=(function(args26)
	return args26["exec"]
end),["run"]=exec2})
profileCalls1 = (function(fn3, mappings3)
	local stats1 = ({})
	local callStack1 = ({tag = "list", n = 0})
	sethook1((function(action1)
		local info1 = getinfo1(2, "Sn")
		local start29 = clock1()
		if (action1 == "call") then
			local previous3 = callStack1[(n1(callStack1))]
			if previous3 then
				previous3["sum"] = (previous3["sum"] + (start29 - previous3["innerStart"]))
			end
		end
		if (action1 ~= "call") then
			if empty_3f_1(callStack1) then
			else
				local current4 = popLast_21_1(callStack1)
				local hash1 = (current4["source"] .. current4["linedefined"])
				local entry9 = stats1[hash1]
				if entry9 then
				else
					entry9 = ({["source"]=current4["source"],["short-src"]=current4["short_src"],["line"]=current4["linedefined"],["name"]=current4["name"],["calls"]=0,["totalTime"]=0,["innerTime"]=0})
					stats1[hash1] = entry9
				end
				entry9["calls"] = (1 + entry9["calls"])
				entry9["totalTime"] = (entry9["totalTime"] + (start29 - current4["totalStart"]))
				entry9["innerTime"] = (entry9["innerTime"] + (current4["sum"] + (start29 - current4["innerStart"])))
			end
		end
		if (action1 ~= "return") then
			info1["totalStart"] = start29
			info1["innerStart"] = start29
			info1["sum"] = 0
			pushCdr_21_1(callStack1, info1)
		end
		if (action1 == "return") then
			local next2 = last1(callStack1)
			if next2 then
				next2["innerStart"] = start29
				return nil
			else
				return nil
			end
		else
			return nil
		end
	end), "cr")
	fn3()
	sethook1()
	local out26 = values1(stats1)
	sort1(out26, (function(a3, b3)
		return (a3["innerTime"] > b3["innerTime"])
	end))
	print1("|               Method | Location                                                     |    Total |    Inner |   Calls |")
	print1("| -------------------- | ------------------------------------------------------------ | -------- | -------- | ------- |")
	local r_12691 = n1(out26)
	local r_12671 = nil
	r_12671 = (function(r_12681)
		if (r_12681 <= r_12691) then
			local entry10 = out26[r_12681]
			print1(format1("| %20s | %-60s | %8.5f | %8.5f | %7d | ", (function()
				if entry10["name"] then
					return unmangleIdent1(entry10["name"])
				else
					return "<unknown>"
				end
			end)()
			, remapMessage1(mappings3, _2e2e_2(entry10["short-src"], ":", entry10["line"])), entry10["totalTime"], entry10["innerTime"], entry10["calls"]))
			return r_12671((r_12681 + 1))
		else
			return nil
		end
	end)
	r_12671(1)
	return stats1
end)
buildStack1 = (function(parent1, stack3, i11, history1, fold2)
	parent1["n"] = (parent1["n"] + 1)
	if (i11 >= 1) then
		local elem10 = stack3[i11]
		local hash2 = _2e2e_2(elem10["source"], "|", elem10["linedefined"])
		local previous4 = (fold2 and history1[hash2])
		local child2 = parent1[hash2]
		if previous4 then
			parent1["n"] = (parent1["n"] - 1)
			child2 = previous4
		end
		if child2 then
		else
			child2 = elem10
			elem10["n"] = 0
			parent1[hash2] = child2
		end
		if previous4 then
		else
			history1[hash2] = child2
		end
		buildStack1(child2, stack3, (i11 - 1), history1, fold2)
		if previous4 then
			return nil
		else
			history1[hash2] = nil
			return nil
		end
	else
		return nil
	end
end)
buildRevStack1 = (function(parent2, stack4, i12, history2, fold3)
	parent2["n"] = (parent2["n"] + 1)
	if (i12 <= n1(stack4)) then
		local elem11 = stack4[i12]
		local hash3 = _2e2e_2(elem11["source"], "|", elem11["linedefined"])
		local previous5 = (fold3 and history2[hash3])
		local child3 = parent2[hash3]
		if previous5 then
			parent2["n"] = (parent2["n"] - 1)
			child3 = previous5
		end
		if child3 then
		else
			child3 = elem11
			elem11["n"] = 0
			parent2[hash3] = child3
		end
		if previous5 then
		else
			history2[hash3] = child3
		end
		buildRevStack1(child3, stack4, (i12 + 1), history2, fold3)
		if previous5 then
			return nil
		else
			history2[hash3] = nil
			return nil
		end
	else
		return nil
	end
end)
finishStack1 = (function(element1)
	local children1 = ({tag = "list", n = 0})
	iterPairs1(element1, (function(k4, child4)
		if (type_23_1(child4) == "table") then
			return pushCdr_21_1(children1, child4)
		else
			return nil
		end
	end))
	sort1(children1, (function(a4, b4)
		return (a4["n"] > b4["n"])
	end))
	element1["children"] = children1
	local r_12751 = n1(children1)
	local r_12731 = nil
	r_12731 = (function(r_12741)
		if (r_12741 <= r_12751) then
			finishStack1((children1[r_12741]))
			return r_12731((r_12741 + 1))
		else
			return nil
		end
	end)
	return r_12731(1)
end)
showStack_21_1 = (function(out27, mappings4, total1, stack5, remaining2)
	line_21_1(out27, format1("└ %s %s %d (%2.5f%%)", (function()
		if stack5["name"] then
			return unmangleIdent1(stack5["name"])
		else
			return "<unknown>"
		end
	end)()
	, remapMessage1(mappings4, _2e2e_2(stack5["short_src"], ":", stack5["linedefined"])), stack5["n"], ((stack5["n"] / total1) * 100)))
	local temp13
	if remaining2 then
		temp13 = (remaining2 >= 1)
	else
		temp13 = true
	end
	if temp13 then
		out27["indent"] = (out27["indent"] + 1)
		local r_12781 = stack5["children"]
		local r_12811 = n1(r_12781)
		local r_12791 = nil
		r_12791 = (function(r_12801)
			if (r_12801 <= r_12811) then
				showStack_21_1(out27, mappings4, total1, r_12781[r_12801], (remaining2 and (remaining2 - 1)))
				return r_12791((r_12801 + 1))
			else
				return nil
			end
		end)
		r_12791(1)
		out27["indent"] = (out27["indent"] - 1)
		return nil
	else
		return nil
	end
end)
showFlame_21_1 = (function(mappings5, stack6, before1, remaining3)
	local renamed1 = _2e2e_2((function()
		if stack6["name"] then
			return unmangleIdent1(stack6["name"])
		else
			return "?"
		end
	end)()
	, "`", remapMessage1(mappings5, _2e2e_2(stack6["short_src"], ":", stack6["linedefined"])))
	print1(format1("%s%s %d", before1, renamed1, stack6["n"]))
	local temp14
	if remaining3 then
		temp14 = (remaining3 >= 1)
	else
		temp14 = true
	end
	if temp14 then
		local whole1 = _2e2e_2(before1, renamed1, ";")
		local r_12591 = stack6["children"]
		local r_12621 = n1(r_12591)
		local r_12601 = nil
		r_12601 = (function(r_12611)
			if (r_12611 <= r_12621) then
				showFlame_21_1(mappings5, r_12591[r_12611], whole1, (remaining3 and (remaining3 - 1)))
				return r_12601((r_12611 + 1))
			else
				return nil
			end
		end)
		return r_12601(1)
	else
		return nil
	end
end)
profileStack1 = (function(fn4, mappings6, args27)
	local stacks1 = ({tag = "list", n = 0})
	local top1 = getinfo1(2, "S")
	sethook1((function(action2)
		local pos13 = 3
		local stack7 = ({tag = "list", n = 0})
		local info2 = getinfo1(2, "Sn")
		local r_12841 = nil
		r_12841 = (function()
			if info2 then
				if ((info2["source"] == top1["source"]) and (info2["linedefined"] == top1["linedefined"])) then
					info2 = nil
				else
					pushCdr_21_1(stack7, info2)
					pos13 = (pos13 + 1)
					info2 = getinfo1(pos13, "Sn")
				end
				return r_12841()
			else
				return nil
			end
		end)
		r_12841()
		return pushCdr_21_1(stacks1, stack7)
	end), "", 100000.0)
	fn4()
	sethook1()
	local folded1 = ({["n"]=0,["name"]="<root>"})
	local r_12901 = n1(stacks1)
	local r_12881 = nil
	r_12881 = (function(r_12891)
		if (r_12891 <= r_12901) then
			local stack8 = stacks1[r_12891]
			if (args27["stack-kind"] == "reverse") then
				buildRevStack1(folded1, stack8, 1, ({}), args27["stack-fold"])
			else
				buildStack1(folded1, stack8, n1(stack8), ({}), args27["stack-fold"])
			end
			return r_12881((r_12891 + 1))
		else
			return nil
		end
	end)
	r_12881(1)
	finishStack1(folded1)
	if (args27["stack-show"] == "flame") then
		return showFlame_21_1(mappings6, folded1, "", (args27["stack-limit"] or 30))
	else
		local writer14 = create2()
		showStack_21_1(writer14, mappings6, n1(stacks1), folded1, (args27["stack-limit"] or 10))
		return print1(concat1(writer14["out"]))
	end
end)
runLua1 = (function(compiler11, args28)
	if empty_3f_1(args28["input"]) then
		self1(compiler11["log"], "put-error!", "No inputs to run.")
		exit_21_1(1)
	end
	local out28 = file3(compiler11, false)
	local lines9 = generateMappings1(out28["lines"])
	local logger18 = compiler11["log"]
	local name32 = _2e2e_2((args28["output"] or "out"), ".lua")
	local r_12941 = list1(load1(concat1(out28["out"]), _2e2e_2("=", name32)))
	if ((type1(r_12941) == "list") and ((n1(r_12941) >= 2) and ((n1(r_12941) <= 2) and (eq_3f_1(r_12941[1], nil) and true)))) then
		local msg32 = r_12941[2]
		self1(logger18, "put-error!", "Cannot load compiled source.")
		print1(msg32)
		print1(concat1(out28["out"]))
		return exit_21_1(1)
	elseif ((type1(r_12941) == "list") and ((n1(r_12941) >= 1) and ((n1(r_12941) <= 1) and true))) then
		local fun3 = r_12941[1]
		_5f_G1["arg"] = args28["script-args"]
		_5f_G1["arg"][0] = car1(args28["input"])
		local exec3 = (function()
			local r_13051 = list1(xpcall1(fun3, traceback1))
			if ((type1(r_13051) == "list") and ((n1(r_13051) >= 1) and (eq_3f_1(r_13051[1], true) and true))) then
				local res15 = slice1(r_13051, 2)
				return nil
			elseif ((type1(r_13051) == "list") and ((n1(r_13051) >= 2) and ((n1(r_13051) <= 2) and (eq_3f_1(r_13051[1], false) and true)))) then
				local msg33 = r_13051[2]
				self1(logger18, "put-error!", "Execution failed.")
				print1(remapTraceback1(({[name32]=lines9}), msg33))
				return exit_21_1(1)
			else
				return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13051), ", but none matched.\n", "  Tried: `(true . ?res)`\n  Tried: `(false ?msg)`"))
			end
		end)
		local r_13041 = args28["profile"]
		if (r_13041 == "none") then
			return exec3()
		elseif eq_3f_1(r_13041, nil) then
			return exec3()
		elseif (r_13041 == "call") then
			return profileCalls1(exec3, ({[name32]=lines9}))
		elseif (r_13041 == "stack") then
			return profileStack1(exec3, ({[name32]=lines9}), args28)
		else
			self1(logger18, "put-error!", (_2e2e_2("Unknown profiler '", r_13041, "'")))
			return exit_21_1(1)
		end
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_12941), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
	end
end)
task3 = ({["name"]="run",["setup"]=(function(spec13)
	addArgument_21_1(spec13, ({tag = "list", n = 2, "--run", "-r"}), "help", "Run the compiled code.")
	addArgument_21_1(spec13, ({tag = "list", n = 2, "--profile", "-p"}), "help", "Run the compiled code with the profiler.", "var", "none|call|stack", "default", nil, "value", "stack", "narg", "?")
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-kind"}), "help", "The kind of stack to emit when using the stack profiler. A reverse stack shows callers of that method instead.", "var", "forward|reverse", "default", "forward", "narg", 1)
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-show"}), "help", "The method to use to display the profiling results.", "var", "flame|term", "default", "term", "narg", 1)
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-limit"}), "help", "The maximum number of call frames to emit.", "var", "LIMIT", "default", nil, "action", setNumAction1, "narg", 1)
	addArgument_21_1(spec13, ({tag = "list", n = 1, "--stack-fold"}), "help", "Whether to fold recursive functions into themselves. This hopefully makes deep graphs easier to understand, but may result in less accurate graphs.", "value", true, "default", false)
	return addArgument_21_1(spec13, ({tag = "list", n = 1, "--"}), "name", "script-args", "help", "Arguments to pass to the compiled script.", "var", "ARG", "all", true, "default", ({tag = "list", n = 0}), "action", addAction1, "narg", "*")
end),["pred"]=(function(args29)
	return (args29["run"] or args29["profile"])
end),["run"]=runLua1})
dotQuote1 = (function(prefix2, name33)
	if find1(name33, "^[%w_][%d%w_]*$") then
		if string_3f_1(prefix2) then
			return _2e2e_2(prefix2, ".", name33)
		else
			return name33
		end
	else
		if string_3f_1(prefix2) then
			return _2e2e_2(prefix2, "[", quoted1(name33), "]")
		else
			return _2e2e_2("_ENV[", quoted1(name33), "]")
		end
	end
end)
genNative1 = (function(compiler12, args30)
	if (n1(args30["input"]) ~= 1) then
		self1(compiler12["log"], "put-error!", "Expected just one input")
		exit_21_1(1)
	end
	local prefix3 = args30["gen-native"]
	local lib3 = compiler12["libCache"][gsub1(last1(args30["input"]), "%.lisp$", "")]
	local escaped3
	if string_3f_1(prefix3) then
		escaped3 = escape1(last1(split1(lib3["name"], "/")))
	else
		escaped3 = nil
	end
	local maxName1 = 0
	local maxQuot1 = 0
	local maxPref1 = 0
	local natives1 = ({tag = "list", n = 0})
	local r_13181 = lib3["out"]
	local r_13211 = n1(r_13181)
	local r_13191 = nil
	r_13191 = (function(r_13201)
		if (r_13201 <= r_13211) then
			local node61 = r_13181[r_13201]
			if ((type1(node61) == "list") and ((type1((car1(node61))) == "symbol") and (car1(node61)["contents"] == "define-native"))) then
				local name34 = node61[2]["contents"]
				pushCdr_21_1(natives1, name34)
				maxName1 = max2(maxName1, n1(quoted1(name34)))
				maxQuot1 = max2(maxQuot1, n1(quoted1(dotQuote1(prefix3, name34))))
				maxPref1 = max2(maxPref1, n1(dotQuote1(escaped3, name34)))
			end
			return r_13191((r_13201 + 1))
		else
			return nil
		end
	end)
	r_13191(1)
	sort1(natives1)
	local handle4 = open1(_2e2e_2(lib3["path"], ".meta.lua"), "w")
	local format3 = _2e2e_2("\9[%-", tostring1((maxName1 + 3)), "s { tag = \"var\", contents = %-", tostring1((maxQuot1 + 1)), "s value = %-", tostring1((maxPref1 + 1)), "s },\n")
	if handle4 then
	else
		self1(compiler12["log"], "put-error!", (_2e2e_2("Cannot write to ", lib3["path"], ".meta.lua")))
		exit_21_1(1)
	end
	if string_3f_1(prefix3) then
		self1(handle4, "write", format1("local %s = %s or {}\n", escaped3, prefix3))
	end
	self1(handle4, "write", "return {\n")
	local r_13291 = n1(natives1)
	local r_13271 = nil
	r_13271 = (function(r_13281)
		if (r_13281 <= r_13291) then
			local native3 = natives1[r_13281]
			self1(handle4, "write", format1(format3, _2e2e_2(quoted1(native3), "] ="), _2e2e_2(quoted1(dotQuote1(prefix3, native3)), ","), _2e2e_2(dotQuote1(escaped3, native3), ",")))
			return r_13271((r_13281 + 1))
		else
			return nil
		end
	end)
	r_13271(1)
	self1(handle4, "write", "}\n")
	return self1(handle4, "close")
end)
task4 = ({["name"]="gen-native",["setup"]=(function(spec14)
	return addArgument_21_1(spec14, ({tag = "list", n = 1, "--gen-native"}), "help", "Generate native bindings for a file", "var", "PREFIX", "narg", "?")
end),["pred"]=(function(args31)
	return args31["gen-native"]
end),["run"]=genNative1})
scope_2f_child2 = require1("tacky.analysis.scope")["child"]
compile2 = require1("tacky.compile")["compile"]
simplifyPath1 = (function(path3, paths1)
	local current5 = path3
	local r_13351 = n1(paths1)
	local r_13331 = nil
	r_13331 = (function(r_13341)
		if (r_13341 <= r_13351) then
			local search1 = paths1[r_13341]
			local sub6 = match1(path3, _2e2e_2("^", gsub1(search1, "%?", "(.*)"), "$"))
			if (sub6 and (n1(sub6) < n1(current5))) then
				current5 = sub6
			end
			return r_13331((r_13341 + 1))
		else
			return nil
		end
	end)
	r_13331(1)
	return current5
end)
readMeta1 = (function(state42, name35, entry11)
	if (((entry11["tag"] == "expr") or (entry11["tag"] == "stmt")) and string_3f_1(entry11["contents"])) then
		local buffer7 = ({tag = "list", n = 0})
		local str10 = entry11["contents"]
		local idx8 = 0
		local max6 = 0
		local len13 = n1(str10)
		local r_13401 = nil
		r_13401 = (function()
			if (idx8 <= len13) then
				local r_13411 = list1(find1(str10, "%${(%d+)}", idx8))
				if ((type1(r_13411) == "list") and ((n1(r_13411) >= 2) and true)) then
					local start30 = r_13411[1]
					local finish13 = r_13411[2]
					if (start30 > idx8) then
						pushCdr_21_1(buffer7, sub1(str10, idx8, (start30 - 1)))
					end
					local val21 = tonumber1(sub1(str10, (start30 + 2), (finish13 - 1)))
					pushCdr_21_1(buffer7, val21)
					if (val21 > max6) then
						max6 = val21
					end
					idx8 = (finish13 + 1)
				else
					pushCdr_21_1(buffer7, sub1(str10, idx8, len13))
					idx8 = (len13 + 1)
				end
				return r_13401()
			else
				return nil
			end
		end)
		r_13401()
		if entry11["count"] then
		else
			entry11["count"] = max6
		end
		entry11["contents"] = buffer7
	end
	local fold4 = entry11["fold"]
	if fold4 then
		if (entry11["tag"] ~= "expr") then
			error1(_2e2e_2("Cannot have fold for non-expression ", name35), 0)
		end
		if ((fold4 ~= "l") and (fold4 ~= "r")) then
			error1(_2e2e_2("Unknown fold ", fold4, " for ", name35), 0)
		end
		if (entry11["count"] ~= 2) then
			error1(_2e2e_2("Cannot have fold for length ", entry11["count"], " for ", name35), 0)
		end
	end
	entry11["name"] = name35
	if (entry11["value"] == nil) then
		local value11 = state42["libEnv"][name35]
		if (value11 == nil) then
			local r_13481 = list1(pcall1(native2, entry11, state42["global"]))
			if ((type1(r_13481) == "list") and ((n1(r_13481) >= 1) and (eq_3f_1(r_13481[1], true) and true))) then
				value11 = car1((slice1(r_13481, 2)))
			elseif ((type1(r_13481) == "list") and ((n1(r_13481) >= 2) and ((n1(r_13481) <= 2) and (eq_3f_1(r_13481[1], false) and true)))) then
			else
				error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13481), ", but none matched.\n", "  Tried: `(true . ?res)`\n  Tried: `(false _)`"))
			end
			state42["libEnv"][name35] = value11
		end
		entry11["value"] = value11
	elseif (state42["libEnv"][name35] ~= nil) then
		error1(_2e2e_2("Duplicate value for ", name35, ": in native and meta file"), 0)
	else
		state42["libEnv"][name35] = entry11["value"]
	end
	state42["libMeta"][name35] = entry11
	return entry11
end)
readLibrary1 = (function(state43, name36, path4, lispHandle1)
	self1(state43["log"], "put-verbose!", (_2e2e_2("Loading ", path4, " into ", name36)))
	local prefix4 = _2e2e_2(name36, "-", n1(state43["libs"]), "/")
	local lib4 = ({["name"]=name36,["prefix"]=prefix4,["path"]=path4})
	local contents2 = self1(lispHandle1, "read", "*a")
	self1(lispHandle1, "close")
	local handle5 = open1(_2e2e_2(path4, ".lua"), "r")
	if handle5 then
		local contents3 = self1(handle5, "read", "*a")
		self1(handle5, "close")
		lib4["native"] = contents3
		local r_13591 = list1(load1(contents3, _2e2e_2("@", name36)))
		if ((type1(r_13591) == "list") and ((n1(r_13591) >= 2) and ((n1(r_13591) <= 2) and (eq_3f_1(r_13591[1], nil) and true)))) then
			error1((r_13591[2]), 0)
		elseif ((type1(r_13591) == "list") and ((n1(r_13591) >= 1) and ((n1(r_13591) <= 1) and true))) then
			local fun4 = r_13591[1]
			local res16 = fun4()
			if (type_23_1(res16) == "table") then
				iterPairs1(res16, (function(k5, v6)
					state43["libEnv"][_2e2e_2(prefix4, k5)] = v6
					return nil
				end))
			else
				error1(_2e2e_2(path4, ".lua returned a non-table value"), 0)
			end
		else
			error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13591), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
		end
	end
	local handle6 = open1(_2e2e_2(path4, ".meta.lua"), "r")
	if handle6 then
		local contents4 = self1(handle6, "read", "*a")
		self1(handle6, "close")
		local r_13691 = list1(load1(contents4, _2e2e_2("@", name36)))
		if ((type1(r_13691) == "list") and ((n1(r_13691) >= 2) and ((n1(r_13691) <= 2) and (eq_3f_1(r_13691[1], nil) and true)))) then
			error1((r_13691[2]), 0)
		elseif ((type1(r_13691) == "list") and ((n1(r_13691) >= 1) and ((n1(r_13691) <= 1) and true))) then
			local fun5 = r_13691[1]
			local res17 = fun5()
			if (type_23_1(res17) == "table") then
				iterPairs1(res17, (function(k6, v7)
					return readMeta1(state43, _2e2e_2(prefix4, k6), v7)
				end))
			else
				error1(_2e2e_2(path4, ".meta.lua returned a non-table value"), 0)
			end
		else
			error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_13691), ", but none matched.\n", "  Tried: `(nil ?msg)`\n  Tried: `(?fun)`"))
		end
	end
	startTimer_21_1(state43["timer"], _2e2e_2("[parse] ", path4), 2)
	local lexed2 = lex1(state43["log"], contents2, _2e2e_2(path4, ".lisp"))
	local parsed1 = parse1(state43["log"], lexed2)
	local scope9 = scope_2f_child2(state43["rootScope"])
	scope9["isRoot"] = true
	scope9["prefix"] = prefix4
	lib4["scope"] = scope9
	stopTimer_21_1(state43["timer"], _2e2e_2("[parse] ", path4))
	local compiled1 = compile2(state43, executeStates1, parsed1, scope9, path4)
	pushCdr_21_1(state43["libs"], lib4)
	if string_3f_1(car1(compiled1)) then
		lib4["docs"] = constVal1(car1(compiled1))
		removeNth_21_1(compiled1, 1)
	end
	lib4["out"] = compiled1
	local r_13831 = n1(compiled1)
	local r_13811 = nil
	r_13811 = (function(r_13821)
		if (r_13821 <= r_13831) then
			local node62 = compiled1[r_13821]
			pushCdr_21_1(state43["out"], node62)
			return r_13811((r_13821 + 1))
		else
			return nil
		end
	end)
	r_13811(1)
	self1(state43["log"], "put-verbose!", (_2e2e_2("Loaded ", path4, " into ", name36)))
	return lib4
end)
pathLocator1 = (function(state44, name37)
	local searched1
	local paths2
	local searcher1
	searched1 = ({tag = "list", n = 0})
	paths2 = state44["paths"]
	searcher1 = (function(i13)
		if (i13 > n1(paths2)) then
			return list1(nil, _2e2e_2("Cannot find ", quoted1(name37), ".\nLooked in ", concat1(searched1, ", ")))
		else
			local path5 = gsub1(paths2[i13], "%?", name37)
			local cached1 = state44["libCache"][path5]
			pushCdr_21_1(searched1, path5)
			if (cached1 == nil) then
				local handle7 = open1(_2e2e_2(path5, ".lisp"), "r")
				if handle7 then
					state44["libCache"][path5] = true
					state44["libNames"][name37] = true
					local lib5 = readLibrary1(state44, simplifyPath1(path5, paths2), path5, handle7)
					state44["libCache"][path5] = lib5
					state44["libNames"][name37] = lib5
					return list1(lib5)
				else
					return searcher1((i13 + 1))
				end
			elseif (cached1 == true) then
				return list1(nil, _2e2e_2("Already loading ", name37))
			else
				return list1(cached1)
			end
		end
	end)
	return searcher1(1)
end)
loader1 = (function(state45, name38, shouldResolve1)
	if shouldResolve1 then
		local cached2 = state45["libNames"][name38]
		if (cached2 == nil) then
			return pathLocator1(state45, name38)
		elseif (cached2 == true) then
			return list1(nil, _2e2e_2("Already loading ", name38))
		else
			return list1(cached2)
		end
	else
		name38 = gsub1(name38, "%.lisp$", "")
		local r_13581 = state45["libCache"][name38]
		if eq_3f_1(r_13581, nil) then
			local handle8 = open1(_2e2e_2(name38, ".lisp"))
			if handle8 then
				state45["libCache"][name38] = true
				local lib6 = readLibrary1(state45, simplifyPath1(name38, state45["paths"]), name38, handle8)
				state45["libCache"][name38] = lib6
				return list1(lib6)
			else
				return list1(nil, _2e2e_2("Cannot find ", quoted1(name38)))
			end
		elseif eq_3f_1(r_13581, true) then
			return list1(nil, _2e2e_2("Already loading ", name38))
		else
			return list1(r_13581)
		end
	end
end)
printError_21_1 = (function(msg34)
	if string_3f_1(msg34) then
	else
		msg34 = pretty1(msg34)
	end
	local lines10 = split1(msg34, "\n", 1)
	print1(colored1(31, _2e2e_2("[ERROR] ", car1(lines10))))
	if car1(cdr1(lines10)) then
		return print1(car1(cdr1(lines10)))
	else
		return nil
	end
end)
printWarning_21_1 = (function(msg35)
	local lines11 = split1(msg35, "\n", 1)
	print1(colored1(33, _2e2e_2("[WARN] ", car1(lines11))))
	if car1(cdr1(lines11)) then
		return print1(car1(cdr1(lines11)))
	else
		return nil
	end
end)
printVerbose_21_1 = (function(verbosity1, msg36)
	if (verbosity1 > 0) then
		return print1(_2e2e_2("[VERBOSE] ", msg36))
	else
		return nil
	end
end)
printDebug_21_1 = (function(verbosity2, msg37)
	if (verbosity2 > 1) then
		return print1(_2e2e_2("[DEBUG] ", msg37))
	else
		return nil
	end
end)
printTime_21_1 = (function(maximum1, name39, time1, level5)
	if (level5 <= maximum1) then
		return print1(_2e2e_2("[TIME] ", name39, " took ", time1))
	else
		return nil
	end
end)
printExplain_21_1 = (function(explain5, lines12)
	if explain5 then
		local r_13931 = split1(lines12, "\n")
		local r_13961 = n1(r_13931)
		local r_13941 = nil
		r_13941 = (function(r_13951)
			if (r_13951 <= r_13961) then
				print1(_2e2e_2("  ", (r_13931[r_13951])))
				return r_13941((r_13951 + 1))
			else
				return nil
			end
		end)
		return r_13941(1)
	else
		return nil
	end
end)
create4 = (function(verbosity3, explain6, time2)
	return ({["verbosity"]=(verbosity3 or 0),["explain"]=(explain6 == true),["time"]=(time2 or 0),["put-error!"]=putError_21_2,["put-warning!"]=putWarning_21_2,["put-verbose!"]=putVerbose_21_2,["put-debug!"]=putDebug_21_2,["put-time!"]=putTime_21_1,["put-node-error!"]=putNodeError_21_2,["put-node-warning!"]=putNodeWarning_21_2})
end)
putError_21_2 = (function(logger19, msg38)
	return printError_21_1(msg38)
end)
putWarning_21_2 = (function(logger20, msg39)
	return printWarning_21_1(msg39)
end)
putVerbose_21_2 = (function(logger21, msg40)
	return printVerbose_21_1(logger21["verbosity"], msg40)
end)
putDebug_21_2 = (function(logger22, msg41)
	return printDebug_21_1(logger22["verbosity"], msg41)
end)
putTime_21_1 = (function(logger23, name40, time3, level6)
	return printTime_21_1(logger23["time"], name40, time3, level6)
end)
putNodeError_21_2 = (function(logger24, msg42, node63, explain7, lines13)
	printError_21_1(msg42)
	putTrace_21_1(node63)
	if explain7 then
		printExplain_21_1(logger24["explain"], explain7)
	end
	return putLines_21_1(true, lines13)
end)
putNodeWarning_21_2 = (function(logger25, msg43, node64, explain8, lines14)
	printWarning_21_1(msg43)
	putTrace_21_1(node64)
	if explain8 then
		printExplain_21_1(logger25["explain"], explain8)
	end
	return putLines_21_1(true, lines14)
end)
putLines_21_1 = (function(range6, entries2)
	if empty_3f_1(entries2) then
		error1("Positions cannot be empty")
	end
	if ((n1(entries2) % 2) ~= 0) then
		error1(_2e2e_2("Positions must be a multiple of 2, is ", n1(entries2)))
	end
	local previous6 = -1
	local file4 = entries2[1]["name"]
	local maxLine1 = foldl1((function(max7, node65)
		if string_3f_1(node65) then
			return max7
		else
			return max2(max7, node65["start"]["line"])
		end
	end), 0, entries2)
	local code3 = _2e2e_2(colored1(92, _2e2e_2(" %", n1(tostring1(maxLine1)), "s │")), " %s")
	local r_13891 = n1(entries2)
	local r_13871 = nil
	r_13871 = (function(r_13881)
		if (r_13881 <= r_13891) then
			local position1 = entries2[r_13881]
			local message1 = entries2[(r_13881 + 1)]
			if (file4 ~= position1["name"]) then
				file4 = position1["name"]
				print1(colored1(95, _2e2e_2(" ", file4)))
			elseif ((previous6 ~= -1) and (abs1((position1["start"]["line"] - previous6)) > 2)) then
				print1(colored1(92, " ..."))
			end
			previous6 = position1["start"]["line"]
			print1(format1(code3, tostring1(position1["start"]["line"]), position1["lines"][position1["start"]["line"]]))
			local pointer1
			if not range6 then
				pointer1 = "^"
			elseif (position1["finish"] and (position1["start"]["line"] == position1["finish"]["line"])) then
				pointer1 = rep1("^", ((position1["finish"]["column"] - position1["start"]["column"]) + 1))
			else
				pointer1 = "^..."
			end
			print1(format1(code3, "", _2e2e_2(rep1(" ", (position1["start"]["column"] - 1)), pointer1, " ", message1)))
			return r_13871((r_13881 + 2))
		else
			return nil
		end
	end)
	return r_13871(1)
end)
putTrace_21_1 = (function(node66)
	local previous7 = nil
	local r_13911 = nil
	r_13911 = (function()
		if node66 then
			local formatted1 = formatNode1(node66)
			if (previous7 == nil) then
				print1(colored1(96, _2e2e_2("  => ", formatted1)))
			elseif (previous7 ~= formatted1) then
				print1(_2e2e_2("  in ", formatted1))
			else
			end
			previous7 = formatted1
			node66 = node66["parent"]
			return r_13911()
		else
			return nil
		end
	end)
	return r_13911()
end)
Scope4 = require1("tacky.analysis.scope")
createPluginState1 = (function(compiler13)
	local logger26 = compiler13["log"]
	local variables1 = compiler13["variables"]
	local states3 = compiler13["states"]
	local warnings1 = compiler13["warning"]
	local optimise3 = compiler13["optimise"]
	local activeScope1 = (function()
		return compiler13["active-scope"]
	end)
	local activeNode1 = (function()
		return compiler13["active-node"]
	end)
	return ({["add-categoriser!"]=(function()
		return error1("add-categoriser! is not yet implemented", 0)
	end),["categorise-node"]=visitNode2,["categorise-nodes"]=visitNodes1,["cat"]=cat3,["writer/append!"]=append_21_1,["writer/line!"]=line_21_1,["writer/indent!"]=indent_21_1,["writer/unindent!"]=unindent_21_1,["writer/begin-block!"]=beginBlock_21_1,["writer/next-block!"]=nextBlock_21_1,["writer/end-block!"]=endBlock_21_1,["add-emitter!"]=(function()
		return error1("add-emitter! is not yet implemented", 0)
	end),["emit-node"]=expression2,["emit-block"]=block2,["logger/put-error!"]=(function(r_14001)
		return self1(logger26, "put-error!", r_14001)
	end),["logger/put-warning!"]=(function(r_14011)
		return self1(logger26, "put-warning!", r_14011)
	end),["logger/put-verbose!"]=(function(r_14021)
		return self1(logger26, "put-verbose!", r_14021)
	end),["logger/put-debug!"]=(function(r_14031)
		return self1(logger26, "put-debug!", r_14031)
	end),["logger/put-node-error!"]=(function(msg44, node67, explain9, ...)
		local lines15 = _pack(...) lines15.tag = "list"
		return putNodeError_21_1(logger26, msg44, node67, explain9, unpack1(lines15, 1, n1(lines15)))
	end),["logger/put-node-warning!"]=(function(msg45, node68, explain10, ...)
		local lines16 = _pack(...) lines16.tag = "list"
		return putNodeWarning_21_1(logger26, msg45, node68, explain10, unpack1(lines16, 1, n1(lines16)))
	end),["logger/do-node-error!"]=(function(msg46, node69, explain11, ...)
		local lines17 = _pack(...) lines17.tag = "list"
		return doNodeError_21_1(logger26, msg46, node69, explain11, unpack1(lines17, 1, n1(lines17)))
	end),["range/get-source"]=getSource1,["visit-node"]=visitNode1,["visit-nodes"]=visitBlock1,["traverse-nodes"]=traverseNode1,["traverse-nodes"]=traverseList1,["symbol->var"]=(function(x67)
		local var42 = x67["var"]
		if string_3f_1(var42) then
			return variables1[var42]
		else
			return var42
		end
	end),["var->symbol"]=makeSymbol1,["builtin?"]=builtin_3f_1,["constant?"]=constant_3f_1,["node->val"]=urn_2d3e_val1,["val->node"]=val_2d3e_urn1,["fusion/add-rule!"]=addRule_21_1,["add-pass!"]=(function(pass3)
		local r_14041 = type1(pass3)
		if (r_14041 ~= "table") then
			error1(format1("bad argument %s (expected %s, got %s)", "pass", "table", r_14041), 2)
		end
		if string_3f_1(pass3["name"]) then
		else
			error1(_2e2e_2("Expected string for name, got ", type1(pass3["name"])))
		end
		if invokable_3f_1(pass3["run"]) then
		else
			error1(_2e2e_2("Expected function for run, got ", type1(pass3["run"])))
		end
		if (type1((pass3["cat"])) == "list") then
		else
			error1(_2e2e_2("Expected list for cat, got ", type1(pass3["cat"])))
		end
		local func8 = pass3["run"]
		pass3["run"] = (function(...)
			local args32 = _pack(...) args32.tag = "list"
			local r_14051 = list1(xpcall1((function()
				return func8(unpack1(args32, 1, n1(args32)))
			end), traceback1))
			if ((type1(r_14051) == "list") and ((n1(r_14051) >= 2) and ((n1(r_14051) <= 2) and (eq_3f_1(r_14051[1], false) and true)))) then
				local msg47 = r_14051[2]
				return error1(remapTraceback1(compiler13["compileState"]["mappings"], msg47), 0)
			elseif ((type1(r_14051) == "list") and ((n1(r_14051) >= 1) and (eq_3f_1(r_14051[1], true) and true))) then
				local rest1 = slice1(r_14051, 2)
				return unpack1(rest1, 1, n1(rest1))
			else
				return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_14051), ", but none matched.\n", "  Tried: `(false ?msg)`\n  Tried: `(true . ?rest)`"))
			end
		end)
		local cats1 = pass3["cat"]
		local group1
		if elem_3f_1("usage", cats1) then
			group1 = "usage"
		else
			group1 = "normal"
		end
		if elem_3f_1("opt", cats1) then
			pushCdr_21_1(optimise3[group1], pass3)
		elseif elem_3f_1("warn", cats1) then
			pushCdr_21_1(warnings1[group1], pass3)
		else
			error1(_2e2e_2("Cannot register ", pretty1(pass3["name"]), " (do not know how to process ", pretty1(cats1), ")"))
		end
		return nil
	end),["var-usage"]=getVar1,["active-scope"]=activeScope1,["active-node"]=activeNode1,["active-module"]=(function()
		local get1
		get1 = (function(scp1)
			if scp1["isRoot"] then
				return scp1
			else
				return get1(scp1["parent"])
			end
		end)
		return get1(compiler13["active-scope"])
	end),["scope-vars"]=(function(scp2)
		if not scp2 then
			return compiler13["active-scope"]["variables"]
		else
			return scp2["variables"]
		end
	end),["var-lookup"]=(function(symb2, scope10)
		local r_14151 = type1(symb2)
		if (r_14151 ~= "symbol") then
			error1(format1("bad argument %s (expected %s, got %s)", "symb", "symbol", r_14151), 2)
		end
		if (compiler13["active-node"] == nil) then
			error1("Not currently resolving")
		end
		if scope10 then
		else
			scope10 = compiler13["active-scope"]
		end
		return Scope4["getAlways"](scope10, symbol_2d3e_string1(symb2), compiler13["active-node"])
	end),["var-definition"]=(function(var43)
		if (compiler13["active-node"] == nil) then
			error1("Not currently resolving")
		end
		local state46 = states3[var43]
		if state46 then
			if (state46["stage"] == "parsed") then
				yield1(({["tag"]="build",["state"]=state46}))
			end
			return state46["node"]
		else
			return nil
		end
	end),["var-value"]=(function(var44)
		if (compiler13["active-node"] == nil) then
			error1("Not currently resolving")
		end
		local state47 = states3[var44]
		if state47 then
			return require"tacky.analysis.state".get(state47)
		else
			return nil
		end
	end),["var-docstring"]=(function(var45)
		return var45["doc"]
	end)})
end)
rootScope2 = require1("tacky.analysis.resolve")["rootScope"]
scope_2f_child3 = require1("tacky.analysis.scope")["child"]
scope_2f_import_21_1 = require1("tacky.analysis.scope")["import"]
local spec15 = create1()
local directory1
local dir1 = arg1[0]
dir1 = gsub1(dir1, "\\", "/")
dir1 = gsub1(dir1, "urn/cli%.lisp$", "")
dir1 = gsub1(dir1, "urn/cli$", "")
dir1 = gsub1(dir1, "tacky/cli%.lua$", "")
if ((dir1 ~= "") and (sub1(dir1, -1, -1) ~= "/")) then
	dir1 = _2e2e_2(dir1, "/")
end
local r_14791 = nil
r_14791 = (function()
	if (sub1(dir1, 1, 2) == "./") then
		dir1 = sub1(dir1, 3)
		return r_14791()
	else
		return nil
	end
end)
r_14791()
directory1 = dir1
local paths3 = list1("?", "?/init", _2e2e_2(directory1, "lib/?"), _2e2e_2(directory1, "lib/?/init"))
local tasks1 = list1(warning1, optimise2, emitLisp1, emitLua1, task1, task4, task3, execTask1, replTask1)
addHelp_21_1(spec15)
addArgument_21_1(spec15, ({tag = "list", n = 2, "--explain", "-e"}), "help", "Explain error messages in more detail.")
addArgument_21_1(spec15, ({tag = "list", n = 2, "--time", "-t"}), "help", "Time how long each task takes to execute. Multiple usages will show more detailed timings.", "many", true, "default", 0, "action", (function(arg27, data8)
	data8[arg27["name"]] = ((data8[arg27["name"]] or 0) + 1)
	return nil
end))
addArgument_21_1(spec15, ({tag = "list", n = 2, "--verbose", "-v"}), "help", "Make the output more verbose. Can be used multiple times", "many", true, "default", 0, "action", (function(arg28, data9)
	data9[arg28["name"]] = ((data9[arg28["name"]] or 0) + 1)
	return nil
end))
addArgument_21_1(spec15, ({tag = "list", n = 2, "--include", "-i"}), "help", "Add an additional argument to the include path.", "many", true, "narg", 1, "default", ({tag = "list", n = 0}), "action", addAction1)
addArgument_21_1(spec15, ({tag = "list", n = 2, "--prelude", "-p"}), "help", "A custom prelude path to use.", "narg", 1, "default", _2e2e_2(directory1, "lib/prelude"))
addArgument_21_1(spec15, ({tag = "list", n = 3, "--output", "--out", "-o"}), "help", "The destination to output to.", "narg", 1, "default", "out")
addArgument_21_1(spec15, ({tag = "list", n = 2, "--wrapper", "-w"}), "help", "A wrapper script to launch Urn with", "narg", 1, "action", (function(a5, b5, value12)
	local args33 = map1(id1, arg1)
	local i14 = 1
	local len14 = n1(args33)
	local r_14181 = nil
	r_14181 = (function()
		if (i14 <= len14) then
			local item2 = args33[i14]
			if ((item2 == "--wrapper") or (item2 == "-w")) then
				removeNth_21_1(args33, i14)
				removeNth_21_1(args33, i14)
				i14 = (len14 + 1)
			elseif find1(item2, "^%-%-wrapper=.*$") then
				removeNth_21_1(args33, i14)
				i14 = (len14 + 1)
			elseif find1(item2, "^%-[^-]+w$") then
				args33[i14] = sub1(item2, 1, -2)
				removeNth_21_1(args33, (i14 + 1))
				i14 = (len14 + 1)
			end
			return r_14181()
		else
			return nil
		end
	end)
	r_14181()
	local command2 = list1(value12)
	local interp1 = arg1[-1]
	if interp1 then
		pushCdr_21_1(command2, interp1)
	end
	pushCdr_21_1(command2, arg1[0])
	local r_14201 = list1(execute1(concat1(append1(command2, args33), " ")))
	if ((type1(r_14201) == "list") and ((n1(r_14201) >= 1) and (number_3f_1(r_14201[1]) and true))) then
		return exit1((r_14201[1]))
	elseif ((type1(r_14201) == "list") and ((n1(r_14201) >= 3) and ((n1(r_14201) <= 3) and true))) then
		return exit1((r_14201[3]))
	else
		return error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_14201), ", but none matched.\n", "  Tried: `((number? @ ?code) . _)`\n  Tried: `(_ _ ?code)`"))
	end
end))
addArgument_21_1(spec15, ({tag = "list", n = 1, "--plugin"}), "help", "Specify a compiler plugin to load.", "var", "FILE", "default", ({tag = "list", n = 0}), "narg", 1, "many", true, "action", addAction1)
addArgument_21_1(spec15, ({tag = "list", n = 1, "input"}), "help", "The file(s) to load.", "var", "FILE", "narg", "*")
local r_14351 = n1(tasks1)
local r_14331 = nil
r_14331 = (function(r_14341)
	if (r_14341 <= r_14351) then
		local task5 = tasks1[r_14341]
		task5["setup"](spec15)
		return r_14331((r_14341 + 1))
	else
		return nil
	end
end)
r_14331(1)
local args34 = parse_21_1(spec15)
local logger27 = create4(args34["verbose"], args34["explain"], args34["time"])
local r_14381 = args34["include"]
local r_14411 = n1(r_14381)
local r_14391 = nil
r_14391 = (function(r_14401)
	if (r_14401 <= r_14411) then
		local path6 = r_14381[r_14401]
		path6 = gsub1(path6, "\\", "/")
		path6 = gsub1(path6, "^%./", "")
		if find1(path6, "%?") then
		else
			path6 = _2e2e_2(path6, (function()
				if (sub1(path6, -1, -1) == "/") then
					return "?"
				else
					return "/?"
				end
			end)()
			)
		end
		pushCdr_21_1(paths3, path6)
		return r_14391((r_14401 + 1))
	else
		return nil
	end
end)
r_14391(1)
self1(logger27, "put-verbose!", (_2e2e_2("Using path: ", pretty1(paths3))))
if empty_3f_1(args34["input"]) then
	args34["repl"] = true
else
	args34["emit-lua"] = true
end
local compiler14 = ({["log"]=logger27,["timer"]=({["callback"]=(function(r_14751, r_14761, r_14771)
	return self1(logger27, "put-time!", r_14751, r_14761, r_14771)
end),["timers"]=({})}),["paths"]=paths3,["libEnv"]=({}),["libMeta"]=({}),["libs"]=({tag = "list", n = 0}),["libCache"]=({}),["libNames"]=({}),["warning"]=({["normal"]=list1(documentation1),["usage"]=list1(checkArity1, deprecated1)}),["optimise"]=default1(),["rootScope"]=rootScope2,["variables"]=({}),["states"]=({}),["out"]=({tag = "list", n = 0})})
compiler14["compileState"] = createState1(compiler14["libMeta"])
compiler14["loader"] = (function(name41)
	return loader1(compiler14, name41, true)
end)
compiler14["global"] = setmetatable1(({["_libs"]=compiler14["libEnv"],["_compiler"]=createPluginState1(compiler14)}), ({["__index"]=_5f_G1}))
iterPairs1(compiler14["rootScope"]["variables"], (function(_5f_3, var46)
	compiler14["variables"][tostring1(var46)] = var46
	return nil
end))
startTimer_21_1(compiler14["timer"], "loading")
local r_14431 = loader1(compiler14, args34["prelude"], false)
if ((type1(r_14431) == "list") and ((n1(r_14431) >= 2) and ((n1(r_14431) <= 2) and (eq_3f_1(r_14431[1], nil) and true)))) then
	local errorMessage1 = r_14431[2]
	self1(logger27, "put-error!", errorMessage1)
	exit_21_1(1)
elseif ((type1(r_14431) == "list") and ((n1(r_14431) >= 1) and ((n1(r_14431) <= 1) and true))) then
	local lib7 = r_14431[1]
	compiler14["rootScope"] = scope_2f_child3(compiler14["rootScope"])
	iterPairs1(lib7["scope"]["exported"], (function(name42, var47)
		return scope_2f_import_21_1(compiler14["rootScope"], name42, var47)
	end))
	local r_14541 = append1(args34["plugin"], args34["input"])
	local r_14571 = n1(r_14541)
	local r_14551 = nil
	r_14551 = (function(r_14561)
		if (r_14561 <= r_14571) then
			local input1 = r_14541[r_14561]
			local r_14591 = loader1(compiler14, input1, false)
			if ((type1(r_14591) == "list") and ((n1(r_14591) >= 2) and ((n1(r_14591) <= 2) and (eq_3f_1(r_14591[1], nil) and true)))) then
				local errorMessage2 = r_14591[2]
				self1(logger27, "put-error!", errorMessage2)
				exit_21_1(1)
			elseif ((type1(r_14591) == "list") and ((n1(r_14591) >= 1) and ((n1(r_14591) <= 1) and true))) then
			else
				error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_14591), ", but none matched.\n", "  Tried: `(nil ?error-message)`\n  Tried: `(_)`"))
			end
			return r_14551((r_14561 + 1))
		else
			return nil
		end
	end)
	r_14551(1)
else
	error1(_2e2e_2("Pattern matching failure!\nTried to match the following patterns against ", pretty1(r_14431), ", but none matched.\n", "  Tried: `(nil ?error-message)`\n  Tried: `(?lib)`"))
end
stopTimer_21_1(compiler14["timer"], "loading")
local r_14731 = n1(tasks1)
local r_14711 = nil
r_14711 = (function(r_14721)
	if (r_14721 <= r_14731) then
		local task6 = tasks1[r_14721]
		if task6["pred"](args34) then
			startTimer_21_1(compiler14["timer"], task6["name"], 1)
			task6["run"](compiler14, args34)
			stopTimer_21_1(compiler14["timer"], task6["name"])
		end
		return r_14711((r_14721 + 1))
	else
		return nil
	end
end)
return r_14711(1)
