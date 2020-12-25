#!/usr/bin/lua

local io = require("io")
local socket = require("socket")
local http = require("socket.http")
local ltn12 = require("ltn12")


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

	res=os.capture('python2 /root/smasolarbluetoothdebugtool-master/SMA_Bluetooth_Inverter_Monitoring_p27.py',true)
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
