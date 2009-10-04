#|

The vector in my-month-quotient was generated using:

(define (gen-month-quotients)
  (list->vector
   (map one-day-quotients (range 367))))

(define (one-day-quotients j)
  (bind ((q1 r1 (my-quotient j '(31 28 31 30 31 30 31 31 30 31 30 31 1)))
	 (q2 r2 (my-quotient j '(31 29 31 30 31 30 31 31 30 31 30 31))))
    (+ (logical-shift-left q2 24)
       (logical-shift-left r2 16)
       (logical-shift-left q1 8)
       r1)))
|#

(define (my-month-quotient n leap?)
  (let (((val <fixnum>) (vector-ref
			 '#(16777472 16843009 16908546 16974083
				    17039620 17105157 17170694
				    17236231 17301768 17367305
				    17432842 17498379 17563916
				    17629453 17694990 17760527
				    17826064 17891601 17957138
				    18022675 18088212 18153749
				    18219286 18284823 18350360
				    18415897 18481434 18546971
				    18612508 18678045 18743582
				    18809119 33620481 33686018
				    33751555 33817092 33882629
				    33948166 34013703 34079240
				    34144777 34210314 34275851
				    34341388 34406925 34472462
				    34537999 34603536 34669073
				    34734610 34800147 34865684
				    34931221 34996758 35062295
				    35127832 35193369 35258906
				    35324443 35389980 35455745
				    50397954 50463491 50529028
				    50594565 50660102 50725639
				    50791176 50856713 50922250
				    50987787 51053324 51118861
				    51184398 51249935 51315472
				    51381009 51446546 51512083
				    51577620 51643157 51708694
				    51774231 51839768 51905305
				    51970842 52036379 52101916
				    52167453 52232990 52298527
				    52364289 67175426 67240963
				    67306500 67372037 67437574
				    67503111 67568648 67634185
				    67699722 67765259 67830796
				    67896333 67961870 68027407
				    68092944 68158481 68224018
				    68289555 68355092 68420629
				    68486166 68551703 68617240
				    68682777 68748314 68813851
				    68879388 68944925 69010462
				    69076225 83952898 84018435
				    84083972 84149509 84215046
				    84280583 84346120 84411657
				    84477194 84542731 84608268
				    84673805 84739342 84804879
				    84870416 84935953 85001490
				    85067027 85132564 85198101
				    85263638 85329175 85394712
				    85460249 85525786 85591323
				    85656860 85722397 85787934
				    85853471 85919233 100730370
				    100795907 100861444 100926981
				    100992518 101058055 101123592
				    101189129 101254666 101320203
				    101385740 101451277 101516814
				    101582351 101647888 101713425
				    101778962 101844499 101910036
				    101975573 102041110 102106647
				    102172184 102237721 102303258
				    102368795 102434332 102499869
				    102565406 102631169 117507842
				    117573379 117638916 117704453
				    117769990 117835527 117901064
				    117966601 118032138 118097675
				    118163212 118228749 118294286
				    118359823 118425360 118490897
				    118556434 118621971 118687508
				    118753045 118818582 118884119
				    118949656 119015193 119080730
				    119146267 119211804 119277341
				    119342878 119408415 119474177
				    134285314 134350851 134416388
				    134481925 134547462 134612999
				    134678536 134744073 134809610
				    134875147 134940684 135006221
				    135071758 135137295 135202832
				    135268369 135333906 135399443
				    135464980 135530517 135596054
				    135661591 135727128 135792665
				    135858202 135923739 135989276
				    136054813 136120350 136185887
				    136251649 151062786 151128323
				    151193860 151259397 151324934
				    151390471 151456008 151521545
				    151587082 151652619 151718156
				    151783693 151849230 151914767
				    151980304 152045841 152111378
				    152176915 152242452 152307989
				    152373526 152439063 152504600
				    152570137 152635674 152701211
				    152766748 152832285 152897822
				    152963585 167840258 167905795
				    167971332 168036869 168102406
				    168167943 168233480 168299017
				    168364554 168430091 168495628
				    168561165 168626702 168692239
				    168757776 168823313 168888850
				    168954387 169019924 169085461
				    169150998 169216535 169282072
				    169347609 169413146 169478683
				    169544220 169609757 169675294
				    169740831 169806593 184617730
				    184683267 184748804 184814341
				    184879878 184945415 185010952
				    185076489 185142026 185207563
				    185273100 185338637 185404174
				    185469711 185535248 185600785
				    185666322 185731859 185797396
				    185862933 185928470 185994007
				    186059544 186125081 186190618
				    186256155 186321692 186387229
				    186452766 186518529 201395202
				    201460739 201526276 201591813
				    201657350 201722887 201788424
				    201853961 201919498 201985035
				    202050572 202116109 202181646
				    202247183 202312720 202378257
				    202443794 202509331 202574868
				    202640405 202705942 202771479
				    202837016 202902553 202968090
				    203033627 203099164 203164701
				    203230238 203295775 203361537)
			 n)))
    (if leap?
	(set! val (logical-shift-right val 16)))
    (values (bitwise-and (logical-shift-right val 8) #b1111)
	    (bitwise-and val #b11111))))