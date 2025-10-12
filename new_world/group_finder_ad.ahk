#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir% 

; Wait 2s
Sleep, 5000

message := "Join the Public Lilliput group finder! Use us in addition to your faction discords to find a group for end-game content! Join at discord.gg/semWUXBG"
PrintString(message)


PrintString(msg) {
	len := StrLen(msg)
	i := 1
	while i <= len {
		char := substr(msg, i, 1)
		CharToKeyPress(char)
		i := i + 1
	}
}

CharToKeyPress(chr) {
	if (chr == "A") {
		Send, {Shift down}
		Send, a
		Send, {Shift up}
	} else if (chr == "a") {
		Send, a
	} else if (chr == "B") {
		Send, {Shift down}
		Send, b
		Send, {Shift up}
	} else if (chr == "b") {
		Send, b
	} else if (chr == "C") {
		Send, {Shift down}
		Send, c
		Send, {Shift up}
	} else if (chr == "c") {
		Send, c
	} else if (chr == "D") {
		Send, {Shift down}
		Send, d
		Send, {Shift up}
	} else if (chr == "d") {
		Send, d
	} else if (chr == "E") {
		Send, {Shift down}
		Send, e
		Send, {Shift up}
	} else if (chr == "e") {
		Send, e
	} else if (chr == "F") {
		Send, {Shift down}
		Send, f
		Send, {Shift up}
	} else if (chr == "f") {
		Send, f
	} else if (chr == "G") {
		Send, {Shift down}
		Send, g
		Send, {Shift up}
	} else if (chr == "g") {
		Send, g
	} else if (chr == "H") {
		Send, {Shift down}
		Send, h
		Send, {Shift up}
	} else if (chr == "h") {
		Send, h
	} else if (chr == "I") {
		Send, {Shift down}
		Send, i
		Send, {Shift up}
	} else if (chr == "i") {
		Send, i
	} else if (chr == "J") {
		Send, {Shift down}
		Send, j
		Send, {Shift up}
	} else if (chr == "j") {
		Send, j
	} else if (chr == "K") {
		Send, {Shift down}
		Send, k
		Send, {Shift up}
	} else if (chr == "k") {
		Send, k
	} else if (chr == "L") {
		Send, {Shift down}
		Send, l
		Send, {Shift up}
	} else if (chr == "l") {
		Send, l
	} else if (chr == "M") {
		Send, {Shift down}
		Send, m
		Send, {Shift up}
	} else if (chr == "m") {
		Send, m
	} else if (chr == "N") {
		Send, {Shift down}
		Send, n
		Send, {Shift up}
	} else if (chr == "n") {
		Send, n
	} else if (chr == "O") {
		Send, {Shift down}
		Send, o
		Send, {Shift up}
	} else if (chr == "o") {
		Send, o
	} else if (chr == "P") {
		Send, {Shift down}
		Send, p
		Send, {Shift up}
	} else if (chr == "p") {
		Send, p
	} else if (chr == "Q") {
		Send, {Shift down}
		Send, q
		Send, {Shift up}
	} else if (chr == "q") {
		Send, q
	} else if (chr == "R") {
		Send, {Shift down}
		Send, r
		Send, {Shift up}
	} else if (chr == "r") {
		Send, r
	} else if (chr == "S") {
		Send, {Shift down}
		Send, s
		Send, {Shift up}
	} else if (chr == "s") {
		Send, s
	} else if (chr == "T") {
		Send, {Shift down}
		Send, t
		Send, {Shift up}
	} else if (chr == "t") {
		Send, t
	} else if (chr == "U") {
		Send, {Shift down}
		Send, u
		Send, {Shift up}
	} else if (chr == "u") {
		Send, u
	} else if (chr == "V") {
		Send, {Shift down}
		Send, v
		Send, {Shift up}
	} else if (chr == "v") {
		Send, v
	} else if (chr == "W") {
		Send, {Shift down}
		Send, w
		Send, {Shift up}
	} else if (chr == "w") {
		Send, w
	} else if (chr == "X") {
		Send, {Shift down}
		Send, x
		Send, {Shift up}
	} else if (chr == "x") {
		Send, x
	} else if (chr == "Y") {
		Send, {Shift down}
		Send, y
		Send, {Shift up}
	} else if (chr == "y") {
		Send, y
	} else if (chr == "Z") {
		Send, {Shift down}
		Send, z
		Send, {Shift up}
	} else if (chr == "z") {
		Send, z
	} else if (chr == "0") {
		Send, 0
	} else if (chr == "1") {
		Send, 1
	} else if (chr == "2") {
		Send, 2
	} else if (chr == "3") {
		Send, 3
	} else if (chr == "4") {
		Send, 4
	} else if (chr == "5") {
		Send, 5
	} else if (chr == "6") {
		Send, 6
	} else if (chr == "7") {
		Send, 7
	} else if (chr == "8") {
		Send, 8
	} else if (chr == "9") {
		Send, 9
	} else if (chr == " ") {
		Send, {Shift down}
		Send, {Space}
		Send, {Shift up}
	} else if (chr == "!") {
		Send, {Shift down}
		Send, {!}
		Send, {Shift up}
	} else if (chr == "?") {
		Send, {Shift down}
		Send, {?}
		Send, {Shift up}
	} else if (chr == "/") {
		Send, {/}
	} else if (chr == "(") {
		Send, {Shift down}
		Send, {(}
		Send, {Shift up}
	} else if (chr == ")") {
		Send, {Shift down}
		Send, {)}
		Send, {Shift up}
	} else if (chr == "[") {
		Send, {[}
	} else if (chr == "]") {
		Send, {]}
	} else if (chr == "{") {
		Send, {Shift down}
		Send, {{}
		Send, {Shift up}
	} else if (chr == "}") {
		Send, {Shift down}
		Send, {}}
		Send, {Shift up}
	} else if (chr == "}") {
		Send, {Shift down}
		Send, {}}
		Send, {Shift up}
	} else if (chr == ".") {
		Send, {.}
	} else if (chr == ",") {
		Send, {,}
	} else if (chr == ";") {
		Send, {;}
	} else if (chr == ":") {
		Send, {Shift down}
		Send, {:}
		Send, {Shift up}
	} else if (chr == "<") {
		Send, {Shift down}
		Send, {,}
		Send, {Shift up}
	} else if (chr == ">") {
		Send, {Shift down}
		Send, {.}
		Send, {Shift up}
	} else if (chr == "'") {
		Send, {Shift down}
		Send, {'}
		Send, {Shift up}
	}
	Random, slp, 30, 60
	Sleep, slp
}
