-- Manually test potential changes.
-- See https://github.com/monome/norns/issues/1657

local state = {
    kcode = {
        key = nil,
        value = nil,
        code_to_char = nil
    },

    kchar = {
        ch = nil,
    }
}

function init()
    redraw()
end

function redraw()
    screen.clear()

    screen.move(0, 8)
    screen.text("Last calls to...")

    screen.move(0, 24)
    screen.text("keyboard.code(" ..
        stringify(state.kcode.key) .. ", " ..
        stringify(state.kcode.value) .. ")"
    )

    screen.move(0, 32)
    screen.text("    code_to_char(...) = " ..
        stringify(state.kcode.code_to_char)
    )

    screen.move(0, 48)
    screen.text("keyboard.char(" ..
        stringify(state.kchar.ch) .. ")"
    )

    screen.update()
end

function stringify(s)
    if type(s) ~= "string" then
        return tostring(s)
    end

    local prefix = (s == '\\' or s == "'") and '\\' or ''

    return "'" .. prefix .. s .. "'"
end

function keyboard.code(key, value)
    state.kcode.key = key
    state.kcode.value = value
    state.kcode.code_to_char = keyboard.code_to_char(key)
    redraw()
end

function keyboard.char(ch)
    state.kchar.ch = ch
    redraw()
end
