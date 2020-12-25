# SMA Bluetooth Inverter Monitoring
Python and lua code in order to monitor my SMA 4000TL Photovoltaic Inverter. Python code based on https://github.com/stuartpittaway/smasolarbluetoothdebugtool. The code runs on a DLINK DIR 505 (mips_24kc) with OpenWrt 19.07.4 (see https://github.com/hatziliontos/Openwrt-Bluetooth-C-Header-Files), r11208-ce6496d796 with a 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode). A sample output by executing python code is given below. Tests showed 14-17 seconds execution time (obviously because of small system capabilities).
```
date; python2 SMA_Bluetooth_Inverter_Monitoring_p27.py; date
Fri Dec 25 09:08:44 EET 2020
Connecting to SMA Inverter over Bluetooth
mylocalBTAddress=00:15:83:4D:6C:FC
Wait for 1st message from inverter to arrive (should be an 0002 command)
netid=02
     inverter address:B6 37 25 25 80 00
[Reply to 0x02 cmd] [**RAW** Packet dump]
    00000000: 7e Header
    00000001: 00 1f Length
    00000003: 61 Checksum
    00000004: 0015834d6cfc Source address
    0000000a: 0080252537b6 Destination address
    00000010: 0002 Command

    00000000: 00 04 70 00 02 00 00 00 00 01 00 00 00

     Sending message :7E 1F 00 61 FC 6C 4D 83 15 00 B6 37 25 25 80 00 02 00 00 04 70 00 02 00 00 00 00 01 00 00 00
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 00 80 00 02 00 00 00 00 00 00 00 00 00 00 CC 79 7E
L2  ARRAY LENGTH = 80
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 13  =84 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= 00
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0080
Command= 0201
  First= 0000
   Last= 0000
  L2 Payload=
    00000028: 00 03 00 00
    0000002c: 00 ff 00 00
    00000030: 3c 74 00 20
    00000034: 01 00 8a 00
    00000038: 45 bd f5 7e
    0000003c: 00 00 0a 00
    00000040: 0c 00 00 00
    00000044: 00 00 00 00
    00000048: 03 00 00 00
    0000004c: 01 01 00 00
L2 Checksu= f1 48
L2    END = 7e
payload=0000010100000003000000000000000c000a00007ef5bd45008a00012000743c0000ff0000000300
None
Logon to inverter
     Sending message :7E 52 00 2C FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 0E A0 FF FF FF FF FF FF 00 01 83 00 5C AF F0 1D 00 01 00 00 00 00 00 80 0C 04 FD FF 07 00 00 00 84 03 00 00 07 90 E5 5F 00 00 00 00 CF EF F7 F4 B9 BA BB BC 88 88 88 88 2C BC 7E
L2  ARRAY LENGTH = 60
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 0e  =64 bytes
L2 0005       ?= d0
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= 01
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 01
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0080
Command= fffd040d
  First= 0007
   Last= 0384
  L2 Payload=
    00000028: 07 90 e5 5f
    0000002c: 00 00 00 00
    00000030: cf ef f7 f4
    00000034: b9 ba bb bc
    00000038: 88 88 88 88
L2 Checksu= e2 a0
L2    END = 7e
payload=88888888bcbbbab9f4f7efcf000000005fe59007
None


SpotDCVoltage
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 80 53 00 1F 45 00 FF 21 45 00 9E F7 7E
L2  ARRAY LENGTH = 152
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 25  =156 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 53800201
  First= 0002
   Last= 0005
  L2 Payload=
    00000028: 01 1f 45 40
    0000002c: 43 90 e5 5f
    00000030: b9 6c 00 00
    00000034: b9 6c 00 00
    00000038: b9 6c 00 00
    0000003c: b9 6c 00 00
    00000040: 01 00 00 00
    00000044: 02 1f 45 40
    00000048: 43 90 e5 5f
    0000004c: a4 68 00 00
    00000050: a4 68 00 00
    00000054: a4 68 00 00
    00000058: a4 68 00 00
    0000005c: 01 00 00 00
    00000060: 01 21 45 40
    00000064: 43 90 e5 5f
    00000068: dd 01 00 00
    0000006c: dd 01 00 00
    00000070: dd 01 00 00
    00000074: dd 01 00 00
    00000078: 01 00 00 00
    0000007c: 02 21 45 40
    00000080: 43 90 e5 5f
    00000084: 1d 02 00 00
    00000088: 1d 02 00 00
    0000008c: 1d 02 00 00
    00000090: 1d 02 00 00
    00000094: 01 00 00 00
L2 Checksu= 22 7d
L2    END = 7e
payload=000000010000021d0000021d0000021d0000021d5fe590434045210200000001000001dd000001dd000001dd000001dd5fe590434045210100000001000068a4000068a4000068a4000068a45fe5904340451f020000000100006cb900006cb900006cb900006cb95fe5904340451f01
None


SpotDCVoltage


GetTypeLabel
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 80 53 00 1E 82 00 FF 20 82 00 97 AE 7E
L2  ARRAY LENGTH = 40
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 09  =44 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= e0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 15 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 53800201
  First= 821e00
   Last= 8220ff
  L2 Payload=
L2 Checksu= 81 51
L2    END = 7e
payload=
None
***** L2 Error code returned *****


GetTypeLabel


TotalYield
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 54 00 01 26 00 FF 22 26 00 F7 A4 7E
L2  ARRAY LENGTH = 72
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 11  =76 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 54000201
  First= 0000
   Last= 0001
  L2 Payload=
    00000028: 01 01 26 00
    0000002c: 43 90 e5 5f
    00000030: 39 16 9f 02
    00000034: 00 00 00 00
    00000038: 01 22 26 00
    0000003c: 3f 90 e5 5f
    00000040: 02 01 00 00
    00000044: 00 00 00 00
L2 Checksu= 13 af
L2    END = 7e
payload=00000000000001025fe5903f0026220100000000029f16395fe5904300260101
None


TotalYield


SpotACVoltage
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 40 46 00 FF 42 46 00 95 69 7E
L2  ARRAY LENGTH = 124
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 1e  =128 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 0007
   Last= 0009
  L2 Payload=
    00000028: 01 40 46 40
    0000002c: 43 90 e5 5f
    00000030: 03 01 00 00
    00000034: 03 01 00 00
    00000038: 03 01 00 00
    0000003c: 03 01 00 00
    00000040: 01 00 00 00
    00000044: 01 41 46 40
    00000048: 43 90 e5 5f
    0000004c: 00 00 00 80
    00000050: 00 00 00 80
    00000054: 00 00 00 80
    00000058: 00 00 00 80
    0000005c: 01 00 00 00
    00000060: 01 42 46 40
    00000064: 43 90 e5 5f
    00000068: 00 00 00 80
    0000006c: 00 00 00 80
    00000070: 00 00 00 80
    00000074: 00 00 00 80
    00000078: 01 00 00 00
L2 Checksu= e4 c5
L2    END = 7e
payload=00000001800000008000000080000000800000005fe590434046420100000001800000008000000080000000800000005fe590434046410100000001000001030000010300000103000001035fe5904340464001
None


SpotACVoltage


SpotACVoltage2
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 48 46 00 FF 55 46 00 E9 BE 7E
L2  ARRAY LENGTH = 208
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 33  =212 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 000a
   Last= 000f
  L2 Payload=
    00000028: 01 48 46 00
    0000002c: 43 90 e5 5f
    00000030: 6d 5a 00 00
    00000034: 6d 5a 00 00
    00000038: 6d 5a 00 00
    0000003c: 6d 5a 00 00
    00000040: 01 00 00 00
    00000044: 01 49 46 00
    00000048: 43 90 e5 5f
    0000004c: ff ff ff ff
    00000050: ff ff ff ff
    00000054: ff ff ff ff
    00000058: ff ff ff ff
    0000005c: 01 00 00 00
    00000060: 01 4a 46 00
    00000064: 43 90 e5 5f
    00000068: ff ff ff ff
    0000006c: ff ff ff ff
    00000070: ff ff ff ff
    00000074: ff ff ff ff
    00000078: 01 00 00 00
    0000007c: 01 53 46 40
    00000080: 43 90 e5 5f
    00000084: 60 04 00 00
    00000088: 60 04 00 00
    0000008c: 60 04 00 00
    00000090: 60 04 00 00
    00000094: 01 00 00 00
    00000098: 01 54 46 40
    0000009c: 43 90 e5 5f
    000000a0: 00 00 00 80
    000000a4: 00 00 00 80
    000000a8: 00 00 00 80
    000000ac: 00 00 00 80
    000000b0: 01 00 00 00
    000000b4: 01 55 46 40
    000000b8: 43 90 e5 5f
    000000bc: 00 00 00 80
    000000c0: 00 00 00 80
    000000c4: 00 00 00 80
    000000c8: 00 00 00 80
    000000cc: 01 00 00 00
L2 Checksu= 7a e3
L2    END = 7e
payload=00000001800000008000000080000000800000005fe590434046550100000001800000008000000080000000800000005fe590434046540100000001000004600000046000000460000004605fe590434046530100000001ffffffffffffffffffffffffffffffff5fe5904300464a0100000001ffffffffffffffffffffffffffffffff5fe59043004649010000000100005a6d00005a6d00005a6d00005a6d5fe5904300464801
None


SpotACVoltage2


SpotACInstantPower
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 3F 26 00 FF 3F 26 00 6E FC 7E
L2  ARRAY LENGTH = 68
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 10  =72 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 0000
   Last= 0000
  L2 Payload=
    00000028: 01 3f 26 40
    0000002c: 43 90 e5 5f
    00000030: 03 01 00 00
    00000034: 03 01 00 00
    00000038: 03 01 00 00
    0000003c: 03 01 00 00
    00000040: 01 00 00 00
L2 Checksu= 4a 35
L2    END = 7e
payload=00000001000001030000010300000103000001035fe5904340263f01
None


SpotACInstantPower


MaxACPower
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 1E 41 00 FF 20 41 00 57 7C 7E
L2  ARRAY LENGTH = 124
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 1e  =128 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 0001
   Last= 0003
  L2 Payload=
    00000028: 01 1e 41 00
    0000002c: 3f 90 e5 5f
    00000030: a0 0f 00 00
    00000034: a0 0f 00 00
    00000038: a0 0f 00 00
    0000003c: a0 0f 00 00
    00000040: 01 00 00 00
    00000044: 01 1f 41 00
    00000048: 3f 90 e5 5f
    0000004c: a0 0f 00 00
    00000050: a0 0f 00 00
    00000054: 00 00 00 00
    00000058: a0 0f 00 00
    0000005c: 00 00 00 00
    00000060: 01 20 41 00
    00000064: 3f 90 e5 5f
    00000068: a0 0f 00 00
    0000006c: a0 0f 00 00
    00000070: 00 00 00 00
    00000074: a0 0f 00 00
    00000078: 00 00 00 00
L2 Checksu= aa f3
L2    END = 7e
payload=0000000000000fa00000000000000fa000000fa05fe5903f004120010000000000000fa00000000000000fa000000fa05fe5903f00411f010000000100000fa000000fa000000fa000000fa05fe5903f00411e01
None


MaxACPower


MaxACPower2
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 2A 83 00 FF 2A 83 00 2E 40 7E
L2  ARRAY LENGTH = 40
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 09  =44 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= e0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 15 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 832a00
   Last= 832aff
  L2 Payload=
L2 Checksu= 38 bf
L2    END = 7e
payload=
None
***** L2 Error code returned *****


MaxACPower2


ChargeStatus
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 5A 29 00 FF 5A 29 00 F9 2A 7E
L2  ARRAY LENGTH = 40
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 09  =44 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= e0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 15 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 295a00
   Last= 295aff
  L2 Payload=
L2 Checksu= ef d5
L2    END = 7e
payload=
None
***** L2 Error code returned *****


ChargeStatus


SpotGridFrequency
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 51 00 57 46 00 FF 57 46 00 6C A7 7E
L2  ARRAY LENGTH = 68
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 10  =72 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51000201
  First= 0010
   Last= 0010
  L2 Payload=
    00000028: 01 57 46 00
    0000002c: 44 90 e5 5f
    00000030: 87 13 00 00
    00000034: 87 13 00 00
    00000038: 87 13 00 00
    0000003c: 87 13 00 00
    00000040: 01 00 00 00
L2 Checksu= 49 97
L2    END = 7e
payload=00000001000013870000138700001387000013875fe5904400465701
None


SpotGridFrequency


OperationTime
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 54 00 2E 46 00 FF 2F 46 00 1B C3 7E
L2  ARRAY LENGTH = 72
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 11  =76 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 54000201
  First= 0003
   Last= 0004
  L2 Payload=
    00000028: 01 2e 46 00
    0000002c: 45 90 e5 5f
    00000030: eb ad a6 07
    00000034: 00 00 00 00
    00000038: 01 2f 46 00
    0000003c: 45 90 e5 5f
    00000040: 44 54 6a 07
    00000044: 00 00 00 00
L2 Checksu= 2a 0d
L2    END = 7e
payload=00000000076a54445fe5904500462f010000000007a6adeb5fe5904500462e01
None


OperationTime


Inverter Temperature
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 52 00 77 23 00 FF 77 23 00 08 99 7E
L2  ARRAY LENGTH = 68
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 10  =72 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 52000201
  First= 0000
   Last= 0000
  L2 Payload=
    00000028: 01 77 23 40
    0000002c: 1c 8f e5 5f
    00000030: 2e 08 00 00
    00000034: 4e 08 00 00
    00000038: 40 08 00 00
    0000003c: 40 08 00 00
    00000040: 01 00 00 00
L2 Checksu= df 8f
L2    END = 7e
payload=0000000100000840000008400000084e0000082e5fe58f1c40237701
None


Inverter Temperature


DeviceStatus
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 80 51 00 48 21 00 FF 48 21 00 C8 D5 7E
L2  ARRAY LENGTH = 80
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 13  =84 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51800201
  First= 0000
   Last= 0000
  L2 Payload=
    00000028: 01 48 21 08
    0000002c: 45 90 e5 5f
    00000030: 23 00 00 00
    00000034: 2f 01 00 00
    00000038: 33 01 00 01
    0000003c: c7 01 00 00
    00000040: fe ff ff 00
    00000044: 00 00 00 00
    00000048: 00 00 00 00
    0000004c: 00 00 00 00
L2 Checksu= 34 02
L2    END = 7e
payload=00000000000000000000000000fffffe000001c7010001330000012f000000235fe5904508214801
None


DeviceStatus


GridRelayStatus
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 80 51 00 64 41 00 FF 64 41 00 AD 43 7E
L2  ARRAY LENGTH = 80
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 13  =84 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 51800201
  First= 0008
   Last= 0008
  L2 Payload=
    00000028: 01 64 41 08
    0000002c: 45 90 e5 5f
    00000030: 33 00 00 01
    00000034: 37 01 00 00
    00000038: fd ff ff 00
    0000003c: fe ff ff 00
    00000040: 00 00 00 00
    00000044: 00 00 00 00
    00000048: 00 00 00 00
    0000004c: 00 00 00 00
L2 Checksu= 64 70
L2    END = 7e
payload=0000000000000000000000000000000000fffffe00fffffd00000137010000335fe5904508416401
None


GridRelayStatus


DailyYield
     Sending message :7E 3E 00 40 FC 6C 4D 83 15 00 FF FF FF FF FF FF 01 00 7E FF 03 60 65 09 A0 FF FF FF FF FF FF 00 00 83 00 5C AF F0 1D 00 00 00 00 00 00 02 80 00 02 00 54 00 22 26 00 FF 22 26 00 1A 6F 7E
L2  ARRAY LENGTH = 56
L2 0000  START = 7e
L2 0000  Header= ff 03 60 65
0xFF036065 SMA Net Telegram Frame (SMADATA2+)
L2 0004  Length= 0d  =60 bytes
L2 0005       ?= 90
L2 0006  susyid= 83 00
L2 0008    Add1= 5c af f0 1d
L2 000c  ArchCd= 00
L2 000d    zero= a0
L2 000e  susyid= 8a 00
L2 0010    Add2= 45 bd f5 7e
L2 0014    zero= 00 00
L2 0016   ERROR= 00 00
L2 0018 Fragmnt= 00
L2 0019       ?= 00
L2 001a Counter= 0280
Command= 54000201
  First= 0001
   Last= 0001
  L2 Payload=
    00000028: 01 22 26 00
    0000002c: 45 90 e5 5f
    00000030: 03 01 00 00
    00000034: 00 00 00 00
L2 Checksu= 26 9b
L2    END = 7e
payload=00000000000001035fe5904500262201
None


DailyYield
Fri Dec 25 09:08:58 EET 2020
```
The lua code prints a summary of results:
```
date;lua SMA_Bluetooth_Inverter_Monitoring_p27.lua; date
Fri Dec 25 09:16:49 EET 2020
hci0 is up
Inverter_Temperature1=21.26
Inverter_Temperature2=21.47
Inverter_Temperature3=21.38
Inverter_Temperature4=21.38
Daily_Yield=0.295
Total_Yield1=43980.381
Total_Yield2=2499.073
Total_Yield3=0.295
Hz=50.02
SpotAC=0.232
SpotDCA1=0.444
SpotDCA2=0.489
SpotDCV1=275.59
SpotDCV2=266.46
SpotDCW1=0.122
SpotDCW2=0.13
SpotDCW=0.252
SpotACA1=1.01
SpotACV1=229.97
SpotACW1=0.232
Fri Dec 25 09:17:05 EET 2020
```
