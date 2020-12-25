#!/usr/bin/lua

local io = require("io")
local socket = require("socket")
local http = require("socket.http")
local ltn12 = require("ltn12")

function decompress1(str)
        local hc = 0
        local comp = ""
--      print("Resto",str:len() % 16)
        if (str:len() % 16) > 0 then
                str = str.."00"
        end
        str = string.gsub(str, "(%x%x)", function (h)
                hc                              = hc + 1
                local bin               = hex2bin(h)
                local subin             = bin:sub(hc+1)
                local toconv    = "0"..subin..comp
                local rslt              = string.char(bin2dec(toconv:sub(1,8)))
--              print(rslt, h, hc, bin, subin, comp, toconv)
                comp                    = bin:sub(1,hc)
                if hc == 8 then
                        hc              = 1
                        comp    = ""
                        bin             = hex2bin(h)
                        subin   = bin:sub(hc+1)
                        toconv  = "0"..subin..comp
                        rslt    = rslt .. string.char(bin2dec(toconv:sub(1,8)))
                        comp    = bin:sub(1,hc)
                end
                return rslt
        end)
        
        return str
end

function decompress(str)
        local hc = 0
        local comp = ""
        str = string.gsub(str, "(%x%x)", function (h)
                hc                              = hc + 1
                local bin               = hex2bin(h)
                local subin     = bin:sub(hc+1)
                local toconv    = "0"..subin..comp
                local rslt              = string.char(bin2dec(toconv:sub(1,8)))
--              print(rslt, h, hc, bin, subin, comp, toconv)
                comp                    = bin:sub(1,hc)
                if hc == 8 then
                        hc = 0
                        comp = ""
                end
                return rslt
        end)
        
        return str
end

function getReg(str,len)
        return str:sub(1,len), str:sub(len+1)
end

function decode(str)
        local trspta = {}
        hl, str                                 = getReg(str,2)
        hl                                      = tonumber(hl,16)
        numbering_plan, str                     = getReg(str,2)
        numbering_plan = tonumber(numbering_plan,16)
        gateway, str                            = getReg(str,((hl-1)*2))
        first_oct_sms, str                      = getReg(str,2)
        len_of_add, str                         = getReg(str,2)
        len_of_add                              = tonumber(len_of_add,16)
        address_type, str                       = getReg(str,2)
        sender, str                             = getReg(str,len_of_add)
        protocol_identifier, str                = getReg(str,2)
        coding_scheme, str                      = getReg(str,2)
        fecha, str                              = getReg(str,14)
        len_of_data, str                        = getReg(str,2)
        len_of_data                             = tonumber(len_of_data, 16)

        gateway = gateway:gsub("%d%d", function(s)
                return s:reverse()
                end)
        sender = sender:gsub("%d%d", function(s)
                return s:reverse()
                end)
        fecha = fecha:gsub("%d%d", function(s)
                return s:reverse()
                end)
        fecha = fecha:gsub("(%d%d)(%d%d)(%d%d)(%d%d)(%d%d)(%d%d)(%d%d)", "20%1-%2-%3 %4:%5:%6+%7")
        --print("Header Len: "..hl)
        --print("Numbering Plan: "..numbering_plan)
        --print("GateWay:",gateway)
        --print("first_oct_sms",first_oct_sms,tonumber(first_oct_sms,16))
        --print("len_of_add",len_of_add)
        --print("address_type",address_type)
        --print("Print Sender: ",sender)
        --print("Protocol Id: ",protocol_identifier)
        --print("Codificacion: ",coding_scheme)
        --print("Fecha:",fecha)
        --print("len_of_data",len_of_data)
        trspta.coding_scheme = coding_scheme
        trspta.sender = sender
        trspta.fecha = fecha
        trspta.concat= "0,0,0"
        trspta.id = 0
        trspta.parts = 1
        trspta.idx = 1
        local i = 1
        local msg = ""
        if tonumber(first_oct_sms,16) >= 64 then
                udhline = str:sub(i,i+15)
                udh_bytes, udhline = getReg(udhline,2)
                udh_concat_indicator, udhline = getReg(udhline,2)
                udh_bytes_follows, udhline = getReg(udhline, 2)
                udh_id, udhline = getReg(udhline, 2)
                udh_parts, udhline = getReg(udhline, 2)
                udh_idx, udhline = getReg(udhline, 2)
                trspta.concat= string.format("%s,%s,%s",udh_bytes,udh_concat_indicator,udh_bytes_follows)
                trspta.part_id = udh_id
                trspta.parts = udh_parts
                trspta.part_idx = udh_idx
                --print("udh_bytes", tonumber(udh_bytes,16))
                --print("udh_concat_indicator", tonumber(udh_concat_indicator,16))
                --print("udh_bytes_follows", tonumber(udh_bytes_follows,16))
                --print("udh_id", tonumber(udh_id,16))
                --print("udh_parts", tonumber(udh_parts,16))
                --print("udh_idx", tonumber(udh_idx,16))
                tmpline = decompress(str:sub(i,i+15))
                i = i + 14
                if coding_scheme == "00" then
                for z=tonumber(udh_bytes,16)+3, tmpline:len()-1 do
                      --print(tmpline:sub(z,z))
                        msg = msg..tmpline:sub(z,z)
                end
                end
        end
        if coding_scheme == "08" then
                msg = msg .. hex162char(str:sub(i-2))
        elseif coding_scheme == "04" then
                msg = msg .. hex82char(str:sub(i-2))
        elseif coding_scheme == "00" then
                msg = msg..decompress1(str:sub(i))
        end
--        while i < str:len() do
--                --print(i, i+15, str:sub(i,i+15))
--                msg = msg..'|'..decompress(str:sub(i,i+15))
--                i = i + 14
--        end
        --print(i, i+15, str:sub(i,i+15))
--        msg = msg..'|'..decompress(str:sub(i,i+15))
        trspta.msg = msg
        --print (msg)
        return trspta
end

local thex2bin = {
        ["0"] = "0000",
        ["1"] = "0001",
        ["2"] = "0010",
        ["3"] = "0011",
        ["4"] = "0100",
        ["5"] = "0101",
        ["6"] = "0110",
        ["7"] = "0111",
        ["8"] = "1000",
        ["9"] = "1001",
        ["a"] = "1010",
        ["b"] = "1011",
        ["c"] = "1100",
        ["d"] = "1101",
        ["e"] = "1110",
        ["f"] = "1111"
        }
local tbin2hex = {
        ["0000"] = "0",
        ["0001"] = "1",
        ["0010"] = "2",
        ["0011"] = "3",
        ["0100"] = "4",
        ["0101"] = "5",
        ["0110"] = "6",
        ["0111"] = "7",
        ["1000"] = "8",
        ["1001"] = "9",
        ["1010"] = "a",
        ["1011"] = "b",
        ["1100"] = "c",
        ["1101"] = "d",
        ["1110"] = "e",
        ["1111"] = "f"
        }

function trim (str)
        if str == nil then return "" end
        return string.gsub(str, "^%s*(.-)%s*$", "%1")
end

function split(str,sep)
        local t = {}
        local ini = 1
        local seplen = string.len(sep)
        local len = string.len(str)
        local iend= string.find(str,sep,ini,true)
        if iend == nil then iend = len+1 end
        repeat
                t[#t+1] = trim(string.sub(str,ini,iend-1))
                ini = iend+seplen
                iend = string.find(str,sep,ini,true)
        until iend == nil
        if ini <= len+1 then 
                t[#t+1] = trim(string.sub(str,ini))
        end
        return t
end

function capital(s)
        return s:gsub("%a", string.upper, 1)
end

function addslashes(s)
        s = string.gsub(s,"'", function (b) 
                return "\\"..b 
                end)
        s = string.gsub(s,'"', function (b) 
                return "\\"..b 
                end)
        return s
end

function unescape (s)
        s = string.gsub(s, "+", " ")
        s = string.gsub(s, "%%(%x%x)", function (h)
                                return string.char(tonumber(h, 16))
                                end)
        return s
end

function escape (s)
        s = string.gsub(s, "([&=+%c])", function (c)
                                        return string.format("%%%02X", string.byte(c))
                                        end)
        s = string.gsub(s, " ", "+")
        return s
end

function hex2bin(s)
        return (string.gsub(s, ".", function (c)
                                                return thex2bin[string.lower(c)]
         end))
end

function bin2hex(s)
        local len = string.len(s)
        local rem = len % 4
        if (rem > 0) then
                s = string.rep("0", 4 - rem)..s
        end
        return (string.gsub(s, "....", function (c)
                                                return tbin2hex[string.lower(c)]
         end))
end

function bin2dec(s)

-- s    -> binary string

local num = 0
local ex = string.len(s) - 1
local l = 0

        l = ex + 1
        for i = 1, l do
                b = string.sub(s, i, i)
                if b == "1" then
                        num = num + 2^ex
                end
                ex = ex - 1
        end

        return string.format("%u", num)

end



function dec2bin(s, num)

-- s    -> Base10 string
-- num  -> string length to extend to

local n

        if (num == nil) then
                n = 0
        else
                n = num
        end
        
        s = string.format("%x", s)

        s = string.hex2bin(s)

        while string.len(s) < n do
                s = "0"..s
        end

        return s

end

function hex2dec(s)
-- s    -> hexadecimal string
        local s = string.hex2bin(s)
        return string.bin2dec(s)
end

function dec2hex(s)
-- s    -> Base10 string
        s = string.format("%x", s)
        return s
end
--------------------------------------------------------------------------------
function hexOr(v, m)
-- v    -> hex string to be masked
-- m    -> hex string mask

-- s    -> hex string as masked
-- bv   -> binary string of v
-- bm   -> binary string mask
        local bv = Hex2Bin(v)
        local bm = Hex2Bin(m)
        return string.bin2hex(string.binOr(bv,bm))
end


function binOr(bv, bm)
        while ((string.len(bv) %4) ~= 0) do
                bv = "0"..bv
        end
        while ((string.len(bm) %4) ~= 0) do
                bm = "0"..bm
        end
        local lbv = string.len(bv)
        local lbm = string.len(bm)
        local lt = lbv
        local i = 0
        local s = ""

        if lbm > lt then lt = lbm end
        for i = 1, lt do
                cv = string.sub(bv, i, i)
                cm = string.sub(bm, i, i)
                if i > lbv then cv="0" end
                if i > lbm then cm="0" end
                if cv == "1" then
                                s = s.."1"
                elseif cm == "1" then
                                s = s.."1"
                else
                        s = s.."0"
                end
        end
        return s
end

function hexXOr(v, m)
-- v    -> hex string to be masked
-- m    -> hex string mask

-- s    -> hex string as masked

-- bv   -> binary string of v
-- bm   -> binary string mask

        local bv = string.hex2bin(v)
        local bm = string.hex2bin(m)
        return string.bin2hex(string.binXOr(bv,bm))
end

function binXOr(bv,bm)
        while ((string.len(bv) %4) ~= 0) do
                bv = "0"..bv
        end

        while ((string.len(bm) %4) ~= 0) do
                bm = "0"..bm
        end

        local lbv = string.len(bv)
        local lbm = string.len(bm)
        local lt = lbv
        if lbm > lbv then lt = lbm  end

        local i = 0
        local s = ""

        for i = 1, lt do
                local cv = string.sub(bv, i, i)
                local cm = string.sub(bm, i, i)
                if i > lbv then cv="0" end
                if i > lbm then cm="0" end
                if cv == "1" then
                        if cm == "0" then
                                s = s.."1"
                        else
                                s = s.."0"
                        end
                elseif cm == "1" then
                        if cv == "0" then
                                s = s.."1"
                        else
                                s = s.."0"
                        end
                else
                        -- cv and cm == "0"
                        s = s.."0"
                end
        end
        return s
end

function hexNot(v, m)

-- v    -> hex string to be masked
-- m    -> hex string mask

-- s    -> hex string as masked

-- bv   -> binary string of v
-- bm   -> binary string mask

        local bv = string.hex2bin(v)
        local bm = string.hex2bin(m)
        return string.bin2hex(string.binNot(bv,bm))
end

function binNot(bv, bm)
        while ((string.len(bv) %4) ~= 0) do
                bv = "0"..bv
        end

        while ((string.len(bm) %4) ~= 0) do
                bm = "0"..bm
        end

        local lbv = string.len(bv)
        local lbm = string.len(bm)
        local lt = lbv
        if lbm > lbv then lt = lbm  end

        local i = 0
        local s = ""
        
        for i = 1, lt do
                local cv = string.sub(bv, i, i)
                local cm = string.sub(bm, i, i)
                if i > lbv then cv="0" end
                if i > lbm then cm="0" end
                if cm == "1" then
                        if cv == "1" then
                                -- turn off
                                s = s.."0"
                        else
                                -- turn on
                                s = s.."1"
                        end
                else
                        -- leave untouched
                        s = s..cv

                end
        end

        return s

end


-- these functions shift right and left, adding zeros to lost or gained bits
-- returned values are 32 bits long

-- BShRight(v, nb)
-- BShLeft(v, nb)


function BShRight(v, nb)

-- v    -> hexstring value to be shifted
-- nb   -> number of bits to shift to the right

-- s    -> binary string of v

        local s = Hex2Bin(v)

        while (string.len(s) < 32) do
                s = "0000"..s
        end

        s = string.sub(s, 1, 32 - nb)

        while (string.len(s) < 32) do
                s = "0"..s
        end

        return Bin2Hex(s)

end

function BShLeft(v, nb)

-- v    -> hexstring value to be shifted
-- nb   -> number of bits to shift to the right

-- s    -> binary string of v

        local s = Hex2Bin(v)

        while (string.len(s) < 32) do
                s = "0000"..s
        end

        s = string.sub(s, nb + 1, 32)

        while (string.len(s) < 32) do
                s = s.."0"
        end

        return Bin2Hex(s)

end

--http://stackoverflow.com/questions/132397/get-back-the-output-of-os-execute-in-lua
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

--http://stackoverflow.com/questions/4990990/lua-check-if-a-file-exists
function fex(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function loger(msg)
  strg=os.date('%Y-%m-%d %H:%M:%S ')..msg;
--  print(strg);
  os.execute('echo "'..strg..'" >> /root/loger.txt');
end

function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return string.gsub(v,'"', '\\"' )
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return table.val_to_str( k )
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "\t" .. table.val_to_str( v ) )
    end
  end
  return table.concat( result, "," )
end

function reversebit(x)
  local y;
  if (1*x==0) then y=1;end;
  if (1*x==1) then y=0;end;
  return y;
end

function sendsms(alarmname,phones,msg,user,pass,from)
  for i=1,table.getn(phones) do
--http://www.senditnow.gr/webservice/sms/sendSMSHTTP.php?username=hatziliontos&password=ggol|12_&destination=306985164896&sender=GGOL&message=testing_testing&pricecat=1
    url_='"http://api.smsgateway.gr/sendsms.asp?user='..user..'&pass='..pass..'&action=sendsms&from='..from..'&to='..phones[i]..'&text='..msg..'&sendtype=5"';
    log(alarmname,"url="..url_,'/root/alarms/smslog.txt');
    local curlres=os.execute('curl --max-time 8 --request GET '..url_);
    log(alarmname,"curlres="..curlres,'/root/alarms/smslog.txt');
    log(alarmname,"sms="..msg.." to phone="..phones[i],'/root/alarms/smslog.txt');
    os.execute('sleep 5');
    log(alarmname,"slept for 5secs",'/root/alarms/smslog.txt');
  end
end

function wgetsendsms(logfile,alarmname,phones,msg)
  for i=1,table.getn(phones) do
    url_='http://api.smsgateway.gr/sendsms.asp?user=akazal&pass=72626&action=sendsms&from=press10&to='..phones[i]..'&text='..msg..'&sendtype=5';
    t = {};
    http.TIMEOUT=60;
    respt=http.request{url=url_,sink=ltn12.sink.table(t)};
    html=table.concat(t);
    logsms(logfile,alarmname.." sms="..msg.." to phone="..phones[i]..' response='..html);
    if (html=='OK 1') then
      retv='ok';
    else
      retv='error';
    end;
    os.execute('sleep 5');
  end
  return retv;
end

function log(msg,file)
  strg=os.date('%Y-%m-%d %H:%M:%S ')..msg;
  os.execute('echo "'..strg..'" >> '..file);
end

function logsms(file,msg)
  strg=os.date('%Y-%m-%d %H:%M:%S ')..msg;
  os.execute('echo "'..strg..'" >> '..file);
end

function bool2bin(x)
  local y=0
  if (x==true) then y=1 else y=0 end
  return y
end

function print_r ( t )  
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

function get_payload(param,report,row)
  if (report:find(param)~=nil) then
    payload=split( split( split( report , param )[2] , "\n" )[row] , "payload=" )[2]
	else
	  payload="" 
	end
  return payload
end

function payload_value(payload,bst,bend)
  return string.sub(payload,bst,bend)
end

res=os.capture('hciconfig',true)
if string.find(res, "DOWN") then
  print("hci0 is down")
  os.capture('hciconfig hci0 up',true)
else
	if string.find(res, "UP RUNNING") then
		print("hci0 is up")
	else
		print("hci0 is nil")
	end
end

	res=os.capture('python2 /root/smasolarbluetoothdebugtool-master/SMASolarInverterPacketDebug_p27.py',true)
	Inverter_Temperature4=tonumber(payload_value( get_payload('Inverter Temperature',res, 32 ) , 9 , 16 ) , 16 )/100; if (Inverter_Temperature4>1000) then Inverter_Temperature4='' end
	Inverter_Temperature3=tonumber(payload_value( get_payload('Inverter Temperature',res, 32 ) , 17 , 24 ) , 16 )/100; if (Inverter_Temperature3>1000) then Inverter_Temperature3='' end
	Inverter_Temperature2=tonumber(payload_value( get_payload('Inverter Temperature',res, 32 ) , 25 , 32 ) , 16 )/100; if (Inverter_Temperature2>1000) then Inverter_Temperature2='' end
	Inverter_Temperature1=tonumber(payload_value( get_payload('Inverter Temperature',res, 32 ) , 33 , 40 ) , 16 )/100; if (Inverter_Temperature1>1000) then Inverter_Temperature1='' end
	Daily_Yield          =tonumber(payload_value( get_payload('DailyYield',res, 29 ) , 9 , 16 ) , 16 )/1000
	Total_Yield3         =tonumber(payload_value( get_payload('TotalYield',res, 33 ) , 9 , 16 ) , 16 )/1000
	Total_Yield2         =tonumber(payload_value( get_payload('TotalYield',res, 33 ) , 25 , 32 ) , 16 )/1000
	Total_Yield1         =tonumber(payload_value( get_payload('TotalYield',res, 33 ) , 41 , 48 ) , 16 )/1000
	Hz                   =tonumber(payload_value( get_payload('SpotGridFrequency',res, 32 ) , 33 , 40 ) , 16 )/100; if (Hz>1000) then Hz='' end
	SpotAC               =tonumber(payload_value( get_payload('SpotACInstantPower',res, 32 ) , 33 , 40 ) , 16 )/1000; if (SpotAC>1000) then SpotAC='' end
	SpotDCA2             =tonumber(payload_value( get_payload('SpotDCVoltage',res, 53 ) , 9 , 16 ) , 16 )/1000; if (SpotDCA2>1000) then SpotDCA2='' end
	SpotDCA1             =tonumber(payload_value( get_payload('SpotDCVoltage',res, 53 ) , 65 , 72 ) , 16 )/1000; if (SpotDCA1>1000) then SpotDCA1='' end
	SpotDCV2             =tonumber(payload_value( get_payload('SpotDCVoltage',res, 53 ) , 121 , 128 ) , 16 )/100; if (SpotDCV2>1000) then SpotDCV2='' end
	SpotDCV1             =tonumber(payload_value( get_payload('SpotDCVoltage',res, 53 ) , 177 , 184 ) , 16 )/100; if (SpotDCV1>1000) then SpotDCV1='' end
	if (SpotDCV1~='') and (SpotDCA1~='') then SpotDCW1=math.floor(SpotDCV1*SpotDCA1) / 1000 else SpotDCW1='' end
	if (SpotDCV2~='') and (SpotDCA2~='') then SpotDCW2=math.floor(SpotDCV2*SpotDCA2) / 1000 else SpotDCW2='' end
	if (SpotDCW1~='') and (SpotDCW2~='') then SpotDCW=SpotDCW1+SpotDCW2 else SpotDCW='' end
	SpotACV1             =tonumber(payload_value( get_payload('SpotACVoltage2',res, 67 ) , 289 , 296 ) , 16 )/100; if (SpotACV1>1000) then SpotACV1='' end
	SpotACA1             =tonumber(payload_value( get_payload('SpotACVoltage2',res, 67 ) , 121 , 128 ) , 16 )/1000; if (SpotACA1>1000) then SpotACA1='' end
	if (SpotACV1~='') and (SpotACA1~='') then SpotACW1=math.floor(SpotACV1*SpotACA1) / 1000 else SpotACW1='' end
	print("Inverter_Temperature1="..Inverter_Temperature1)
	print("Inverter_Temperature2="..Inverter_Temperature2)
	print("Inverter_Temperature3="..Inverter_Temperature3)
	print("Inverter_Temperature4="..Inverter_Temperature4)
	print("Daily_Yield="..Daily_Yield)
	print("Total_Yield1="..Total_Yield1)
	print("Total_Yield2="..Total_Yield2)
	print("Total_Yield3="..Total_Yield3)
	print("Hz="..Hz)
	print("SpotAC="..SpotAC)
	print("SpotDCA1="..SpotDCA1)
	print("SpotDCA2="..SpotDCA2)
	print("SpotDCV1="..SpotDCV1)
	print("SpotDCV2="..SpotDCV2)
	print("SpotDCW1="..SpotDCW1)
	print("SpotDCW2="..SpotDCW2)
	print("SpotDCW="..SpotDCW)
	print("SpotACA1="..SpotACA1)
	print("SpotACV1="..SpotACV1)
	print("SpotACW1="..SpotACW1)
	--print(split( res , 'OperationTime' )[2] )
http.TIMEOUT=10; t={};
  url_='http://thingspeak.ath.cx/update?api_key=O9QMKMEBZ8XLQ25Q&field1='..SpotAC..'&field2='..SpotDCA1..'&field3='..SpotDCA2..'&field4='..SpotDCV1..'&field5='..SpotDCV2..'&field6='..SpotDCW1..'&field7='..SpotDCW2..'&field8='..SpotDCW;
  --print(url_);
  --result, statuscode, content=http.request{url=url_,method='GET',sink=ltn12.sink.table(t),headers={["X-THINGSPEAKAPIKEY"]="O9QMKMEBZ8XLQ25Q", ["Content-Type"]="application/x-www-form-urlencoded"}};
  --print(result);
  --print(statuscode);
  html=table.concat(t);
  --print(html);
http.TIMEOUT=10; t={};
  url_='http://thingspeak.ath.cx/update?api_key=SMVBLVYCW287WBI2&field1='..Inverter_Temperature1..'&field2='..Daily_Yield..'&field3='..Total_Yield1..'&field4='..Hz..'&field5='..SpotACA1..'&field6='..SpotACV1..'&field7='..'&field8='..SpotACW1;
  --print(url_);
  --result, statuscode, content=http.request{url=url_,method='GET',sink=ltn12.sink.table(t),headers={["X-THINGSPEAKAPIKEY"]="SMVBLVYCW287WBI2", ["Content-Type"]="application/x-www-form-urlencoded"}};
  --print(result);
  --print(statuscode);
  html=table.concat(t);
  --print(html);
