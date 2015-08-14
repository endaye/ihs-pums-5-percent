* Import PUMA 5% data;
* by Yuancheng Zhang;
* Aug 14, 2015;

libname raw "../raw_file/revised/";
libname ds "../dataset/";
libname final "../final_dataset/";
libname f "./";

option compress=yes;

*initialized two empty datasets for combined result;
data final.pums_5p_all_H; stop; run;
data final.pums_5p_all_P; stop; run;

* in order to keep the blank charactor in the record; 
* set the delimiter as other charactor rather than blank;
%macro import_single(num);
	
	* replace all blanks by period '.' in each raw file and save it into sas_code folder;
	%put ~~~ copying RAW_FILE_&num. into sas_code directory .... ~~~;
	data _null_;
    	*e.g: sed 's/ /./g' < ../raw_file/revised/REVISEDPUMS5_02.TXT > tmp2.TXT ;
    	*ref: http://www.grymoire.com/Unix/Sed.html ;
    	cmd = "sed 's/ /./g' < ../raw_file/revised/REVISEDPUMS5_" || "&num." ||".TXT > tmp.TXT";
    	call system(cmd);
	run;
    
    * import data by HOUSE formate;
	%put ~~~ start importing H_&num. .... ~~~;
	data tmp_h;
		infile "./tmp.TXT" DLM='090D'x pad truncover lrecl=266;
		input
			RECTYPE: $1-1
			SERIALNO: $2-8
			SAMPLE: $9-9
			STATE: $10-11
			REGION: $12-12
			DIVISION: $13-13
			PUMA5: $14-18
			PUMA1: $19-23
			MSACMSA5: $24-27
			MSAPMSA5: $28-31
			MSACMSA1: $32-35
			MSAPMSA1: $36-39
			AREATYP5: $40-41
			AREATYP1: $42-43
			TOTPUMA5: $44-57
			LNDPUMA5: $58-71
			TOTPUMA1: $72-85
			LNDPUMA1: $86-99
			SUBSAMPL: $100-101
			HWEIGHT: $102-105
			PERSONS: $106-107
			UNITTYPE: $108-108
			HSUB: $109-109
			HAUG: $110-110
			VACSTAT: $111-111
			VACSTATA: $112-112
			TENURE: $113-113
			TENUREA: $114-114
			BLDGSZ: $115-116
			BLDGSZA: $117-117
			YRBUILT: $118-118
			YRBUILTA: $119-119
			YRMOVED: $120-120
			YRMOVEDA: $121-121
			ROOMS: $122-122
			ROOMSA: $123-123
			BEDRMS: $124-124
			BEDRMSA: $125-125
			CPLUMB: $126-126
			CPLUMBA: $127-127
			CKITCH: $128-128
			CKITCHA: $129-129
			PHONE: $130-130
			PHONEA: $131-131
			FUEL: $132-132
			FUELA: $133-133
			VEHICL: $134-134
			VEHICLA: $135-135
			BUSINES: $136-136
			BUSINESA: $137-137
			ACRES: $138-138
			ACRESA: $139-139
			AGSALES: $140-140
			AGSALESA: $141-141
			ELEC: $142-145
			ELECA: $146-146
			GAS: $147-150
			GASA: $151-151
			WATER: $152-155
			WATERA: $156-156
			OIL: $157-160
			OILA: $161-161
			RENT: $162-165
			RENTA: $166-166
			MEALS: $167-167
			MEALSA: $168-168
			MORTG1: $169-169
			MORTG1A: $170-170
			MRT1AMT: $171-175
			MRT1AMTA: $176-176
			MORTG2: $177-177
			MORTG2A: $178-178
			MRT2AMT: $179-183
			MRT2AMTA: $184-184
			TAXINCL: $185-185
			TAXINCLA: $186-186
			TAXAMT: $187-188
			TAXAMTA: $189-189
			INSINCL: $190-190
			INSINCLA: $191-191
			INSAMT: $192-195
			INSAMTA: $196-196
			CONDFEE: $197-200
			CONDFEEA: $201-201
			VALUE: $202-203
			VALUEA: $204-204
			MHLOAN: $205-205
			MHLOANA: $206-206
			MHCOST: $207-211
			MHCOSTA: $212-212
			HHT: $213-213
			P65: $214-215
			P18: $216-217
			NPF: $218-219
			NOC: $220-221
			NRC: $222-223
			PSF: $224-224
			PAOC: $225-225
			PARC: $226-226
			SVAL: $227-227
			SMOC: $228-232
			SMOCAPI: $233-235
			SRNT: $236-236
			GRENT: $237-240
			GRAPI: $241-243
			FNF: $244-244
			HHL: $245-245
			LNGI: $246-246
			WIF: $247-247
			EMPSTAT: $248-248
			WORKEXP: $249-250
			HINC: $251-258
			FINC: $259-266
		;
		if RECTYPE ='H';
	run;

	* clean periods '.' in HOUSE dataset. replace them by blanks;
	data ds.pums_5p_&num._H;
		set tmp_h;
		array change _character_;
            do over change;
            change = STRIP(tranwrd(change, '.', ' '));
            if missing(change) then change='.';
            end;
   	run ;

   	%put ~~~ H_&num. import completed here. ~~~;
   	


   	* import data by POP formate;
   	%put ~~~ start importing P_&num. .... ~~~;
	data tmp_p;
		infile "./tmp.TXT" DLM='090D'x pad truncover lrecl=316;
		input
			RECTYPE: $1-1
			SERIALNO: $2-8
			PNUM: $9-10
			PAUG: $11-11
			DDP: $12-12
			PWEIGHT: $13-16
			RELATE: $17-18
			RELATEA: $19-19
			OC: $20-20
			RC: $21-21
			PAOCF: $22-22
			SEX: $23-23
			SEXA: $24-24
			AGE: $25-26
			AGEA: $27-27
			HISPAN: $28-29
			HISPANA: $30-30
			NUMRACE: $31-31
			WHITE: $32-32
			BLACK: $33-33
			AIAN: $34-34
			ASIAN: $35-35
			NHPI: $36-36
			OTHER: $37-37
			RACE1: $38-38
			RACE2: $39-40
			RACE3: $41-42
			RACEA: $43-43
			MARSTAT: $44-44
			MARSTATA: $45-45
			MSP: $46-46
			SFN: $47-47
			SFREL: $48-48
			ENROLL: $49-49
			ENROLLA: $50-50
			GRADE: $51-51
			GRADEA: $52-52
			EDUC: $53-54
			EDUCA: $55-55
			ANCFRST5: $56-58
			ANCFRST1: $56-58
			ANCSCND5: $59-61
			ANCSCND1: $59-61
			ANCA: $62-62
			ANCR: $63-63
			SPEAK: $64-64
			SPEAKA: $65-65
			LANG5: $66-68
			LANG1: $66-68
			LANGA: $69-69
			ENGABIL: $70-70
			ENGABILA: $71-71
			POB5: $72-74
			POB1: $72-74
			POBA: $75-75
			CITIZEN: $76-76
			CITIZENA: $77-77
			YR2US: $78-81
			YR2USA: $82-82
			MOB: $83-83
			MOBA: $84-84
			MIGST5: $85-87
			MIGST1: $85-87
			MIGSTA: $88-88
			MIGPUMA5: $89-93
			MIGPUMA1: $94-98
			MIGAREA5: $99-100
			MIGAREA1: $101-102
			MIGCMA5: $103-106
			MIGCMA1: $107-110
			MIGPMA5: $111-114
			MIGPMA1: $115-118
			SENSORY: $119-119
			SENSORYA: $120-120
			PHYSCL: $121-121
			PHYSCLA: $122-122
			MENTAL: $123-123
			MENTALA: $124-124
			SLFCARE: $125-125
			SLFCAREA: $126-126
			ABGO: $127-127
			ABGOA: $128-128
			ABWORK: $129-129
			ABWORKA: $130-130
			DISABLE: $131-131
			GRANDC: $132-132
			GRANDCA: $133-133
			RSPNSBL: $134-134
			RSPNSBLA: $135-135
			HOWLONG: $136-136
			HOWLONGA: $137-137
			MILTARY: $138-138
			MILTARYA: $139-139
			VPS1: $140-140
			VPS2: $141-141
			VPS3: $142-142
			VPS4: $143-143
			VPS5: $144-144
			VPS6: $145-145
			VPS7: $146-146
			VPS8: $147-147
			VPS9: $148-148
			VPSA: $149-149
			MILYRS: $150-150
			MILYRSA: $151-151
			VPSR: $152-153
			VPSR: $152-153
			ESR: $154-154
			ESRA: $155-155
			ESP: $156-156
			POWST5: $157-159
			POWST1: $157-159
			POWSTA: $160-160
			POWPUMA5: $161-165
			POWPUMA1: $166-170
			POWAREA5: $171-172
			POWAREA1: $173-174
			POWCMA5: $175-178
			POWCMA1: $179-182
			POWPMA5: $183-186
			POWPMA1: $187-190
			TRVMNS: $191-192
			TRVMNSA: $193-193
			CARPOOL: $194-194
			CARPOOLA: $195-195
			LVTIME: $196-198
			LVTIMEA: $199-199
			TRVTIME: $200-202
			TRVTIMEA: $203-203
			LAYOFF: $204-204
			ABSENT: $205-205
			RECALL: $206-206
			LOOKWRK: $207-207
			BACKWRK: $208-208
			LASTWRK: $209-209
			LASTWRKA: $210-210
			INDCEN: $211-213
			INDCENA: $214-214
			INDNAICS: $215-222
			OCCCEN5: $223-225
			OCCCEN1: $223-225
			OCCCENA: $226-226
			OCCSOC5: $227-233
			OCCSOC1: $227-233
			CLWKR: $234-234
			CLWKRA: $235-235
			WRKLYR: $236-236
			WRKLYRA: $237-237
			WEEKS: $238-239
			WEEKSA: $240-240
			HOURS: $241-242
			HOURSA: $243-243
			INCWS: $244-249
			INCWSA: $250-250
			INCSE: $251-256
			INCSEA: $257-257
			INCINT: $258-263
			INCINTA: $264-264
			INCSS: $265-269
			INCSSA: $270-270
			INCSSI: $271-275
			INCSSIA: $276-276
			INCPA: $277-281
			INCPAA: $282-282
			INCRET: $283-288
			INCRETA: $289-289
			INCOTH: $290-295
			INCOTHA: $296-296
			INCTOT: $297-303
			INCTOTA: $304-304
			EARNS: $305-311
			POVERTY: $312-314
			FILLER: $315 -316
		;
		if RECTYPE ='P';
	run;

   	* pick out those HOUSE vars need to add into POP dataset;
   	data tmp_h2;
		set tmp_h;
		keep SERIALNO STATE REGION DIVISION PUMA5 PUMA1 MSACMSA5 MSAPMSA5 MSACMSA1 MSAPMSA1 AREATYP5 AREATYP1 TOTPUMA5 LNDPUMA5 TOTPUMA1 LNDPUMA1;
		rename SERIALNO = SERIALNO_H;
	run;
	
	* merge above vars with POP dataset by serial number;
	PROC SQL;
		CREATE TABLE tmp_p2 AS
			SELECT * 
			FROM tmp_p p, tmp_h2 h
			WHERE p.SERIALNO = h.SERIALNO_H;
	QUIT;

   	* clean periods '.' in POP dataset. replace them by blanks;
   	* POP import completed;
	data ds.pums_5p_&num._P;
		set tmp_p2;
		array change _character_;
            do over change;
            change = STRIP(tranwrd(change, '.', ' '));
            if missing(change) then change='.';
            end;
        drop SERIALNO_H FILLER;
   	run ;

   	%put ~~~ P_&num. import completed here. ~~~;

%mend import_single;

%macro combine(num);
	%put ~~~ combine ALL_HOS(&num.) in final directory ~~~;
	data final.pums_5p_all_H;
		set final.pums_5p_all_H ds.pums_5p_&num._H;
	run;

	%put ~~~ combine ALL_POP(&num.) in final directory ~~~;
	data final.pums_5p_all_P;
		set final.pums_5p_all_P ds.pums_5p_&num._P;
	run;
%mend combine;

%macro import_all();
	* from 1 to 56;
	%do i=1 %to 56;
		* these 5 state codes have no data;
		%if &i.^=3 & &i.^=7 & &i.^=14 & &i.^=43 & &i.^=52 %then %do; 
			%if &i.<10 %then %do;
				%import_single(0&i.);
				%combine(0&i.);
			%end;
			%else %do;
				%import_single(&i.);
				%combine(&i.);
			%end;
		%end;
	%end;

	* remove temp files;
	%put ~~~ rm tmp.TXT ~~~;
	data _null_;
    	cmd = "rm tmp.TXT";
    	call system(cmd);
	run;
%mend import_all;



%import_all;