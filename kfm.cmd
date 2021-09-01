;-| 超必殺技 |--------------------------------------------------------
;ここには超必殺技を記述してください、同じ名前を「name =」欄に書けますが
;コマンドは絶対に違ったものにしてください。
;カンフーマンは弱パンチと強パンチで技が出せるように同じ名前のコマンドで
;内容が弱と強になっています。
;「time=20」と書くことで「コマンドを20フレーム以内に入力」と設定できます。
[Command]
name = "TripleKFPalm"
command = ~D, DF, F, D, DF, F, x
time = 30

[Command] 
name = "TripleKFPalm"   ;Same name as above
command = ~D, DF, F, D, DF, F, y
time = 20

;-| 必殺技 |------------------------------------------------------
[Command]
name = "QCF_x"
command = ~D, DF, F, x

[Command]
name = "QCF_y"
command = ~D, DF, F, y

[Command]
name = "QCF_xy"
command = ~D, DF, F, x+y

[Command]
name = "QCB_a"
command = ~D, DF, F, a

[Command]
name = "QCB_b"
command = ~D, DF, F, b

[Command]
name = "QCB_c"
command = ~D, DF, F, c

[Command]
name = "FF_ab"
command = B, B, a+b

[Command]
name = "FF_a"
command = F, F, a

[Command]
name = "FF_b"
command = F, F, b

;※※※※※※※※※※※※※※※※※※※※ハイジャンプコマンド
;下をちょっと押して上を押す、と言う意味。
[Command]
name = "jump"    
command = ~D,$U
time = 10

;※※※※※※※※※※※※※※※※※※※※前避け
;前を押しながらＡ＋Ｂ、という意味
[Command]
name = "away-f"    
command = /F,a+b
time = 10

;※※※※※※※※※※※※※※※※※※※※前避け
;後を押しながらＡ＋Ｂ、という意味
[Command]
name = "away-b"    
command = /B,a+b
time = 10

;-| ２回押し技 |-----------------------------------------------------------
[Command]
name = "FF"     
command = F, F
time = 10

[Command]
name = "BB"     
command = B, B
time = 10

;-| ２・３個の同時押し技 |-----------------------------------------------
[Command]
name = "recovery"
command = x+y
time = 1

;-| 方向とボタンで出す技 |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| ボタン設定（いじらない）|---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

;-| 押しっぱなし設定（いじらない）-------------------------------------------------------
[Command]
name = "holdfwd"
command = /$F
time = 1

[Command]
name = "holdback"
command = /$B
time = 1

[Command]
name = "holdup" 
command = /$U
time = 1

[Command]
name = "holddown"
command = /$D
time = 1

[Command]
name = "holdx"
command = /$x
time = 1

[Command]
name = "holdy"
command = /$y
time = 1

; 下の記述↓は絶対に消さないでください。
[Statedef -1]

[State -1]
type = ChangeState
triggerall = var(59) != 0
trigger1 = (p2bodydist X>= 0) && (ctrl) && (random = [0,300])
value = 333

[State -1]
type = ChangeState
triggerall = var(53) != 0
trigger1 = (p2bodydist X<= 20) && (ctrl) && (random = [0,530])
value = 123

[State -1]
type = ChangeState
triggerall = var(59) != 0
trigger1 = (p2bodydist X<= 20) && (ctrl) && (random = [0,530])
value = 126

[State -1]
type = VarSet
trigger1 = command = "FF_ab"
var(59) = 1

[State -1, Triple Kung Fu Palm]
type = ChangeState
value = 300
triggerall = command = "TripleKFPalm"
triggerall = power >= 1000
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = statetype != A
trigger2 = hitdefattr = SC, NA, SA
trigger2 = movecontact

;===========================================================================
;---------------------------------------------------------------------------
;ダッシュ
[State -1, Run Fwd]
type = ChangeState
value = 100
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;後退ダッシュ
[State -1, Run Back]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;空中前ダッシュ
;普通のステート、この中では一番簡単なステート
;ただし空中ダッシュを連続でできないように「stateno ! = 2300」としています
;詳細はairdash.cnsで

[State -1, airrun]
type = ChangeState
value = 2300
trigger1 = command = "FF"
triggerall = statetype = A
trigger1 = ctrl
trigger1 = stateno != 2300

;---------------------------------------------------------------------------
;前避け
;とても簡単なステートです。
;ここでやってる特殊なことは「効率化」です。
;詳細はaway.cnsで

[State -1, Run Back]
type = ChangeState
value = 2200
triggerall = command = "away-f"
triggerall = statetype = S
trigger1 = ctrl
trigger2 = (stateno = [200,299]) || (stateno = [400,499])
trigger2 = movecontact

;---------------------------------------------------------------------------
;後避け
;とても簡単なステートです。
;ここでやってる特殊なことは「効率化」です。
;詳細はaway.cnsで

[State -1, Run Back]
type = ChangeState
value = 2250
triggerall = command = "away-b"
triggerall = statetype = S
trigger1 = ctrl
trigger2 = (stateno = [200,299]) || (stateno = [400,499])
trigger2 = movecontact

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 315
triggerall = command = "QCF_x"
triggerall = command != "holddown"
trigger1 = (statetype = S)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 260) && time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 291
triggerall = command = "QCB_a"
triggerall = command != "holddown"
trigger1 = (statetype = S)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 292
triggerall = command = "QCB_b"
triggerall = command != "holddown"
trigger1 = (statetype = S)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 294
triggerall = command = "QCB_c"
triggerall = command != "holddown"
trigger1 = (statetype = S)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6
;===========================================================================
;---------------------------------------------------------------------------
;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = command = "x"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 260
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = command = "holdfwd"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 210) && time > 6
trigger4 = (stateno = 240) && time > 6

;---------------------------------------------------------------------------
;立ち強パンチ
[State -1, Stand Strong Punch]
type = ChangeState
value = 240
triggerall = command = "z"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 210) && time > 6

;---------------------------------------------------------------------------
;立ち強パンチ
[State -1, Stand Strong Punch]
type = ChangeState
value = 293
triggerall = command = "z"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 210) && time > 6

;---------------------------------------------------------------------------
;立ち強パンチ
[State -1, Stand Strong Punch]
type = ChangeState
value = 290
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 210) && time > 6

;---------------------------------------------------------------------------
;立ち強パンチ
[State -1, Stand Strong Punch]
type = ChangeState
value = 210
triggerall = command = "y"
triggerall = command != "holdfwd"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;立ち強パンチ
[State -1, Stand Strong Punch]
type = ChangeState
value = 330
triggerall = command = "y"
triggerall = command = "holdfwd"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6
;---------------------------------------------------------------------------
;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 230
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = time > 6
trigger3 = (stateno = 210) && time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 261
triggerall = command = "a"
triggerall = command = "holddown"
trigger1 = (statetype = C)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 262
triggerall = command = "b"
triggerall = command = "holddown"
trigger1 = (statetype = C)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 263
triggerall = command = "c"
triggerall = command = "holddown"
trigger1 = (statetype = C)
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;---------------------------------------------------------------------------
;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 231
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = time > 6
trigger3 = (stateno = 210) && time > 6

;---------------------------------------------------------------------------
;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 232
triggerall = command = "c"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = time > 6
trigger3 = (stateno = 210) && time > 6

;---------------------------------------------------------------------------
;立ち弱パンチ
[State -1, Stand Light Punch]
type = ChangeState
value = 400
triggerall = (command = "x")||(command = "y")||(command = "z")||(command = "a")||(command = "b")||(command = "c")
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = stateno = 400
trigger2 = time > 6
trigger3 = (stateno = 200) && time > 5
trigger4 = (stateno = 210) && time > 6

[State -1, Jump Light Punch]
type = ChangeState
value = 1600
triggerall = command = "QCB_a"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7

[State -1, Jump Light Punch]
type = ChangeState
value = 1601
triggerall = command = "QCB_b"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7

[State -1, Jump Light Punch]
type = ChangeState
value = 1602
triggerall = command = "QCB_c"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7
;---------------------------------------------------------------------------
;空中弱パンチ
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7

;---------------------------------------------------------------------------
;空中強パンチ
[State -1, Jump Strong Punch]
type = ChangeState
value = 610
triggerall = command = "y"
triggerall = command != "holdfwd"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600 || stateno = 630 ;jump_x or jump_a
trigger2 = movecontact

;空中強パンチ
[State -1, Jump Strong Punch]
type = ChangeState
value = 630
triggerall = command = "y"
triggerall = command = "holdfwd"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600 || stateno = 630 ;jump_x or jump_a
trigger2 = movecontact
;---------------------------------------------------------------------------
;空中強パンチ
[State -1, Jump Strong Punch]
type = ChangeState
value = 630
triggerall = command = "z"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600 || stateno = 630 ;jump_x or jump_a
trigger2 = movecontact

;---------------------------------------------------------------------------
;空中弱パンチ
[State -1, Jump Light Punch]
type = ChangeState
value = 621
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7

;---------------------------------------------------------------------------
;空中弱パンチ
[State -1, Jump Light Punch]
type = ChangeState
value = 622
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7

;---------------------------------------------------------------------------
;空中弱パンチ
[State -1, Jump Light Punch]
type = ChangeState
value = 623
triggerall = command = "c"
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = statetime >= 7

[State AssertSpecial]
type = AssertSpecial
trigger1 = var(33) = 1
flag = NoMusic

[State Snd]
type = PlaySnd
triggerall = command = "start"
trigger1 = var(33) = 0
triggerall = statetype = S
value = 803,0
volume = 800
channel = 2
loop = 1

[State -1]
type = varset
triggerall = command = "start"
trigger1 = var(33) = 0
triggerall = statetype = S
v = 33
value = 1