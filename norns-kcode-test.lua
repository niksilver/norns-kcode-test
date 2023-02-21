-- Manually test potential changes.
-- See https://github.com/monome/norns/issues/1657

local state = {
    kcode.key = nil,
    kcode.value = nil,
    kcode.code_to_char = nil,

    kchar.ch = nil,
    kchar.char_to_code = nil
}

function redraw()
    screen.move(0, 8)
    screen.text("Last calls to...")

    screen.move(0, 24)
    screen.text("keyboard.code(" ..
        tostring(state.kcode.key) .. ", " ..
        tostring(state.kcode.value) .. ")"
    )

    screen.move(0, 32)
    screen.text("    code_to_char(" ..
        tostring(state.kcode.key) .. ") = " ..
        tostring(kchar.char_to_code)
    )

    screen.move(0, 48)
    screen.text("keyboard.char('" ..
        tostring(state.kchar.ch) .. "')"
    )

    screen.move(0, 48)
    screen.text("    code_to_char(" ..
        tostring(state.kchar.ch) .. ") = " ..
        tostring(kchar.char_to_code)
    )
end

function keyboard.code(key, value)
    state.kcode.key = key
    state.kcode.value = value
    state.kcode.code_to_char = keyboard.code_to_char(key)
    redraw()
end

function keyboard.char(ch)
    state.kchar = ch
    state.kchar.char_to_code = keyboard.char_to_code(ch)
    redraw()
end
