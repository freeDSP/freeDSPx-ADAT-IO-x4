EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "FreeDSP I8S-ADAT INTERFACE BOARD SCHEMATIC"
Date "2021-02-14"
Rev "0.1"
Comp "Designed by CyberPit HILO. 2020"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 6400 1500 3450 1400
U 60262604
F0 "ADATx4TX-Part" 100
F1 "ADATx4TX-Part.sch" 50
$EndSheet
$Sheet
S 6500 4200 3450 1425
U 60262E22
F0 "ADATx4RX-Part" 100
F1 "ADATx4RX-Part.sch" 50
$EndSheet
$Comp
L AZ1117CH-3.3TRG1DICT-ND:AZ1117CH-3.3TRG1DICT-ND U?
U 1 1 6286CBC6
P 3800 2050
AR Path="/60262604/6286CBC6" Ref="U?"  Part="1" 
AR Path="/6286CBC6" Ref="U2"  Part="1" 
F 0 "U2" H 3850 2350 60  0000 C CNN
F 1 "AZ1117CH-3.3TRG1DICT-ND" H 4250 2200 60  0000 C CNN
F 2 "digikey-footprints:SOT-223" H 4100 2200 60  0001 L CNN
F 3 "" H 4100 2350 60  0001 L CNN
	1    3800 2050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack_Switch J?
U 1 1 6286CBCC
P 2650 2150
AR Path="/60262604/6286CBCC" Ref="J?"  Part="1" 
AR Path="/6286CBCC" Ref="J1"  Part="1" 
F 0 "J1" H 2500 2350 50  0000 C CNN
F 1 "Barrel_Jack_Switch" H 2500 1900 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2700 2110 50  0001 C CNN
F 3 "~" H 2700 2110 50  0001 C CNN
	1    2650 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 2250 3200 2800
$Comp
L Device:C C?
U 1 1 6286CBDA
P 3450 2400
AR Path="/60262604/6286CBDA" Ref="C?"  Part="1" 
AR Path="/6286CBDA" Ref="C2"  Part="1" 
F 0 "C2" H 3475 2500 50  0000 L CNN
F 1 "100n" H 3475 2300 50  0000 L CNN
F 2 "fdsp_capacitor:C_0805_HandSoldering" H 3488 2250 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B300/X7R-G0805%23YAG.pdf" H 3450 2400 50  0001 C CNN
F 4 "X7R-G0805 100N" H 3450 2400 60  0001 C CNN "Reichelt_Best_Nr"
	1    3450 2400
	-1   0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 6286CBE0
P 4100 2500
AR Path="/60262604/6286CBE0" Ref="R?"  Part="1" 
AR Path="/6286CBE0" Ref="R6"  Part="1" 
F 0 "R6" V 4000 2450 50  0000 C CNN
F 1 "NOP" V 4100 2500 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 4030 2500 50  0001 C CNN
F 3 "~" H 4100 2500 50  0001 C CNN
	1    4100 2500
	0    1    1    0   
$EndComp
Wire Wire Line
	4400 2050 4400 2150
$Comp
L Device:C C?
U 1 1 6286CBE9
P 4400 2400
AR Path="/60262604/6286CBE9" Ref="C?"  Part="1" 
AR Path="/6286CBE9" Ref="C4"  Part="1" 
F 0 "C4" H 4550 2450 50  0000 L CNN
F 1 "100n" H 4500 2350 50  0000 L CNN
F 2 "fdsp_capacitor:C_0805_HandSoldering" H 4438 2250 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B300/X7R-G0805%23YAG.pdf" H 4400 2400 50  0001 C CNN
F 4 "X7R-G0805 100N" H 4400 2400 60  0001 C CNN "Reichelt_Best_Nr"
	1    4400 2400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 6286CBF0
P 3800 2650
AR Path="/60262604/6286CBF0" Ref="R?"  Part="1" 
AR Path="/6286CBF0" Ref="R4"  Part="1" 
F 0 "R4" V 3700 2650 50  0000 C CNN
F 1 "0R" V 3800 2650 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 3730 2650 50  0001 C CNN
F 3 "~" H 3800 2650 50  0001 C CNN
	1    3800 2650
	1    0    0    -1  
$EndComp
Connection ~ 3800 2800
Wire Wire Line
	4400 2550 4400 2800
Wire Wire Line
	4400 2800 3800 2800
Wire Wire Line
	4200 2050 4400 2050
Wire Wire Line
	3450 2550 3450 2800
Wire Wire Line
	4400 2050 4800 2050
Connection ~ 4400 2050
$Comp
L Device:CP1_Small C?
U 1 1 6286CC06
P 4800 2300
AR Path="/60262604/6286CC06" Ref="C?"  Part="1" 
AR Path="/6286CC06" Ref="C6"  Part="1" 
F 0 "C6" H 4900 2350 50  0000 L CNN
F 1 "10uF" H 4900 2250 50  0000 L CNN
F 2 "fdsp_capacitor:C_0805_HandSoldering" H 4800 2300 50  0001 C CNN
F 3 "~" H 4800 2300 50  0001 C CNN
	1    4800 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 2050 4800 2200
Connection ~ 4800 2050
Wire Wire Line
	4800 2400 4800 2800
Wire Wire Line
	4800 2800 4400 2800
Connection ~ 4400 2800
Text Notes 5265 1760 0    50   ~ 0
3.3V POWER SUPPLY
Wire Notes Line
	5100 1650 5100 1800
Wire Notes Line
	6150 1800 6150 1650
Wire Notes Line
	6150 1650 5100 1650
Wire Notes Line
	5100 1800 6150 1800
Wire Wire Line
	3200 2800 3450 2800
Connection ~ 3450 2800
Wire Wire Line
	3450 2800 3800 2800
Wire Wire Line
	3450 2250 3450 2050
Connection ~ 3450 2050
Wire Wire Line
	3450 2050 3500 2050
Connection ~ 4400 2150
Wire Wire Line
	4400 2150 4400 2250
$Comp
L Device:LED D?
U 1 1 6286CC1E
P 5300 2600
AR Path="/60262604/6286CC1E" Ref="D?"  Part="1" 
AR Path="/6286CC1E" Ref="D2"  Part="1" 
F 0 "D2" V 5350 2450 50  0000 R CNN
F 1 "BLU_LED" V 5250 2450 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5300 2600 50  0001 C CNN
F 3 "~" H 5300 2600 50  0001 C CNN
	1    5300 2600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R?
U 1 1 6286CC24
P 5300 2200
AR Path="/60262604/6286CC24" Ref="R?"  Part="1" 
AR Path="/6286CC24" Ref="R8"  Part="1" 
F 0 "R8" V 5250 2000 50  0000 C CNN
F 1 "3.3k" V 5300 2200 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 5230 2200 50  0001 C CNN
F 3 "~" H 5300 2200 50  0001 C CNN
	1    5300 2200
	1    0    0    -1  
$EndComp
Wire Wire Line
	5300 2050 4800 2050
Wire Wire Line
	5300 2350 5300 2450
Wire Wire Line
	5300 2750 5300 2800
Wire Wire Line
	5300 2800 4800 2800
Connection ~ 4800 2800
Text GLabel 3550 1650 2    51   BiDi ~ 0
+5V
Wire Wire Line
	3200 2250 2950 2250
Wire Wire Line
	3550 1650 3450 1650
Wire Wire Line
	3450 1650 3450 2050
Wire Wire Line
	5300 2800 5750 2800
Text GLabel 5750 2800 2    51   BiDi ~ 0
GND
Connection ~ 5300 2050
$Comp
L AZ1117CH-3.3TRG1DICT-ND:AZ1117CH-3.3TRG1DICT-ND U?
U 1 1 6288EE09
P 3550 4750
AR Path="/60262604/6288EE09" Ref="U?"  Part="1" 
AR Path="/60262E22/6288EE09" Ref="U?"  Part="1" 
AR Path="/6288EE09" Ref="U1"  Part="1" 
F 0 "U1" H 3600 5050 60  0000 C CNN
F 1 "AZ1117CH-3.3TRG1DICT-ND" H 3850 4900 60  0000 C CNN
F 2 "digikey-footprints:SOT-223" H 3850 4900 60  0001 L CNN
F 3 "" H 3850 5050 60  0001 L CNN
	1    3550 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 4750 3200 4750
$Comp
L Connector:Barrel_Jack_Switch J?
U 1 1 6288EE10
P 2650 4850
AR Path="/60262604/6288EE10" Ref="J?"  Part="1" 
AR Path="/60262E22/6288EE10" Ref="J?"  Part="1" 
AR Path="/6288EE10" Ref="J2"  Part="1" 
F 0 "J2" H 2500 5050 50  0000 C CNN
F 1 "Barrel_Jack_Switch" H 2500 4600 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2700 4810 50  0001 C CNN
F 3 "~" H 2700 4810 50  0001 C CNN
	1    2650 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	2950 4950 2950 5500
$Comp
L Device:C C?
U 1 1 6288EE18
P 3200 5100
AR Path="/60262604/6288EE18" Ref="C?"  Part="1" 
AR Path="/60262E22/6288EE18" Ref="C?"  Part="1" 
AR Path="/6288EE18" Ref="C1"  Part="1" 
F 0 "C1" H 3225 5200 50  0000 L CNN
F 1 "100n" H 3225 5000 50  0000 L CNN
F 2 "fdsp_capacitor:C_0805_HandSoldering" H 3238 4950 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B300/X7R-G0805%23YAG.pdf" H 3200 5100 50  0001 C CNN
F 4 "X7R-G0805 100N" H 3200 5100 60  0001 C CNN "Reichelt_Best_Nr"
	1    3200 5100
	-1   0    0    1   
$EndComp
$Comp
L Device:R R?
U 1 1 6288EE1E
P 3800 5200
AR Path="/60262604/6288EE1E" Ref="R?"  Part="1" 
AR Path="/60262E22/6288EE1E" Ref="R?"  Part="1" 
AR Path="/6288EE1E" Ref="R5"  Part="1" 
F 0 "R5" V 3700 5150 50  0000 C CNN
F 1 "NOP" V 3800 5200 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 3730 5200 50  0001 C CNN
F 3 "~" H 3800 5200 50  0001 C CNN
	1    3800 5200
	0    1    1    0   
$EndComp
Wire Wire Line
	4150 4750 4150 4850
$Comp
L Device:C C?
U 1 1 6288EE27
P 4150 5100
AR Path="/60262604/6288EE27" Ref="C?"  Part="1" 
AR Path="/60262E22/6288EE27" Ref="C?"  Part="1" 
AR Path="/6288EE27" Ref="C3"  Part="1" 
F 0 "C3" H 4300 5150 50  0000 L CNN
F 1 "100n" H 4250 5050 50  0000 L CNN
F 2 "fdsp_capacitor:C_0805_HandSoldering" H 4188 4950 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B300/X7R-G0805%23YAG.pdf" H 4150 5100 50  0001 C CNN
F 4 "X7R-G0805 100N" H 4150 5100 60  0001 C CNN "Reichelt_Best_Nr"
	1    4150 5100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 6288EE2E
P 3550 5350
AR Path="/60262604/6288EE2E" Ref="R?"  Part="1" 
AR Path="/60262E22/6288EE2E" Ref="R?"  Part="1" 
AR Path="/6288EE2E" Ref="R3"  Part="1" 
F 0 "R3" V 3450 5350 50  0000 C CNN
F 1 "0R" V 3550 5350 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 3480 5350 50  0001 C CNN
F 3 "~" H 3550 5350 50  0001 C CNN
	1    3550 5350
	1    0    0    -1  
$EndComp
Connection ~ 3550 5500
Wire Wire Line
	4150 5250 4150 5500
Wire Wire Line
	4150 5500 3550 5500
Wire Wire Line
	3950 4750 4150 4750
Wire Wire Line
	3200 5250 3200 5500
Wire Wire Line
	4150 4750 4550 4750
Connection ~ 4150 4750
$Comp
L Device:CP1_Small C?
U 1 1 6288EE3E
P 4550 5000
AR Path="/60262604/6288EE3E" Ref="C?"  Part="1" 
AR Path="/60262E22/6288EE3E" Ref="C?"  Part="1" 
AR Path="/6288EE3E" Ref="C5"  Part="1" 
F 0 "C5" H 4650 5050 50  0000 L CNN
F 1 "10uF" H 4650 4950 50  0000 L CNN
F 2 "fdsp_capacitor:C_0805_HandSoldering" H 4550 5000 50  0001 C CNN
F 3 "~" H 4550 5000 50  0001 C CNN
	1    4550 5000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 4750 4550 4900
Connection ~ 4550 4750
Wire Wire Line
	4550 5100 4550 5500
Wire Wire Line
	4550 5500 4150 5500
Connection ~ 4150 5500
Text Notes 4765 4460 0    50   ~ 0
3.3V POWER SUPPLY
Wire Notes Line
	4600 4350 4600 4500
Wire Notes Line
	5650 4500 5650 4350
Wire Notes Line
	5650 4350 4600 4350
Wire Notes Line
	4600 4500 5650 4500
Wire Wire Line
	2950 5500 3200 5500
Connection ~ 3200 5500
Wire Wire Line
	3200 5500 3550 5500
Wire Wire Line
	3200 4950 3200 4750
Connection ~ 3200 4750
Wire Wire Line
	3200 4750 3250 4750
Connection ~ 4150 4850
Wire Wire Line
	4150 4850 4150 4950
$Comp
L Device:LED D?
U 1 1 6288EE56
P 5100 5300
AR Path="/60262604/6288EE56" Ref="D?"  Part="1" 
AR Path="/60262E22/6288EE56" Ref="D?"  Part="1" 
AR Path="/6288EE56" Ref="D1"  Part="1" 
F 0 "D1" V 5150 5150 50  0000 R CNN
F 1 "BLU_LED" V 5250 5140 50  0000 R CNN
F 2 "LED_SMD:LED_0603_1608Metric_Pad1.05x0.95mm_HandSolder" H 5100 5300 50  0001 C CNN
F 3 "~" H 5100 5300 50  0001 C CNN
	1    5100 5300
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R?
U 1 1 6288EE5C
P 5100 4900
AR Path="/60262604/6288EE5C" Ref="R?"  Part="1" 
AR Path="/60262E22/6288EE5C" Ref="R?"  Part="1" 
AR Path="/6288EE5C" Ref="R7"  Part="1" 
F 0 "R7" V 5050 4700 50  0000 C CNN
F 1 "3.3k" V 5100 4900 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 5030 4900 50  0001 C CNN
F 3 "~" H 5100 4900 50  0001 C CNN
	1    5100 4900
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 4750 4550 4750
Wire Wire Line
	5100 5050 5100 5150
Wire Wire Line
	5100 5450 5100 5500
Wire Wire Line
	5100 5500 4550 5500
Connection ~ 4550 5500
Text Notes 4670 5380 0    79   ~ 16
PWR
Wire Notes Line style solid
	4605 5220 4605 5420
Wire Notes Line style solid
	4605 5420 5005 5420
Wire Notes Line style solid
	5005 5420 5005 5220
Wire Notes Line style solid
	5005 5220 4605 5220
Text Notes 1910 4910 0    79   ~ 16
DC5V
Wire Notes Line style solid
	1875 4750 1875 4950
Wire Notes Line style solid
	1875 4950 2275 4950
Wire Notes Line style solid
	2275 4950 2275 4750
Wire Notes Line style solid
	2275 4750 1875 4750
Text GLabel 3600 4200 2    51   BiDi ~ 0
+5V
$Comp
L Device:R R?
U 1 1 6288EE8A
P 3350 4200
AR Path="/60262E22/6288EE8A" Ref="R?"  Part="1" 
AR Path="/6288EE8A" Ref="R1"  Part="1" 
F 0 "R1" V 3300 4350 50  0000 C CNN
F 1 "NOP" V 3350 4200 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 3280 4200 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/SMD-1206_SMD-0805_SMD-0603%23YAG.pdf" H 3350 4200 50  0001 C CNN
F 4 "SMD-0805 33.0" V 3350 4200 60  0001 C CNN "Reichelt_Best_Nr"
	1    3350 4200
	0    1    1    0   
$EndComp
Connection ~ 3200 4200
Wire Wire Line
	3200 4200 3200 4750
Wire Wire Line
	3500 4200 3600 4200
Connection ~ 5100 4750
Text GLabel 5600 5500 2    51   BiDi ~ 0
GND
$Comp
L Device:R R?
U 1 1 6288EE96
P 5350 5500
AR Path="/60262E22/6288EE96" Ref="R?"  Part="1" 
AR Path="/6288EE96" Ref="R2"  Part="1" 
F 0 "R2" V 5300 5650 50  0000 C CNN
F 1 "NOP" V 5350 5500 50  0000 C CNN
F 2 "fdsp_resistor:R_0805_HandSoldering" V 5280 5500 50  0001 C CNN
F 3 "http://cdn-reichelt.de/documents/datenblatt/B400/SMD-1206_SMD-0805_SMD-0603%23YAG.pdf" H 5350 5500 50  0001 C CNN
F 4 "SMD-0805 33.0" V 5350 5500 60  0001 C CNN "Reichelt_Best_Nr"
	1    5350 5500
	0    1    1    0   
$EndComp
Wire Wire Line
	5500 5500 5600 5500
Wire Wire Line
	5100 5500 5200 5500
Wire Notes Line
	1600 3650 10500 3650
Wire Notes Line
	10500 3650 10500 6000
Wire Notes Line
	10500 6000 1550 6000
Wire Notes Line
	1550 6000 1550 3650
Wire Notes Line
	1550 3250 10500 3250
Wire Notes Line
	10500 3250 10500 1000
Wire Notes Line
	10500 1000 1550 1000
Wire Notes Line
	1550 1000 1550 3250
NoConn ~ 2950 4850
NoConn ~ 2950 2150
Wire Wire Line
	3800 2450 3800 2500
Wire Wire Line
	3950 2500 3800 2500
Wire Wire Line
	4200 2150 4250 2150
Connection ~ 3800 2500
Wire Wire Line
	4250 2150 4250 2500
Connection ~ 4250 2150
Wire Wire Line
	4250 2150 4400 2150
Wire Wire Line
	3550 5150 3550 5200
Wire Wire Line
	3950 4850 4000 4850
Wire Wire Line
	3550 5200 3650 5200
Connection ~ 3550 5200
Wire Wire Line
	3950 5200 4000 5200
Wire Wire Line
	4000 5200 4000 4850
Connection ~ 4000 4850
Wire Wire Line
	4000 4850 4150 4850
Connection ~ 5100 5500
Connection ~ 5300 2800
Text Notes 1960 2210 0    79   ~ 16
DC5V
Wire Notes Line style solid
	1925 2050 1925 2250
Wire Notes Line style solid
	1925 2250 2325 2250
Wire Notes Line style solid
	2325 2250 2325 2050
Wire Notes Line style solid
	2325 2050 1925 2050
Text GLabel 5600 5700 2    51   BiDi ~ 0
GNDD
Wire Wire Line
	5600 5700 5100 5700
Wire Wire Line
	5100 5700 5100 5500
Wire Wire Line
	5100 4750 5550 4750
Text GLabel 5550 4750 2    51   BiDi ~ 0
VDD
Text GLabel 3600 3950 2    51   BiDi ~ 0
+5VD
Wire Wire Line
	3600 3950 3200 3950
Wire Wire Line
	3200 3950 3200 4200
Wire Wire Line
	5300 2050 5750 2050
Text GLabel 5750 2050 2    51   BiDi ~ 0
+3V3
Wire Wire Line
	2950 2050 3450 2050
$EndSCHEMATC
