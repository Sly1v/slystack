-- Keyboard layout & Language switching (English US + Arabic with Left+Right Shift)
hl.config({ input = { kb_layout = "us, ara" } })
hl.config({ input = { kb_variant = "," } })
hl.config({ input = { kb_model = "" } })
hl.config({ input = { kb_options = "grp:shifts_toggle" } })
hl.config({ input = { kb_rules = "" } })
hl.config({ input = { follow_mouse = 1 } })
hl.config({ input = { sensitivity = 0 } })

-- Laptop Touchpad optimization (Dell Touchpad)
hl.config({
    input = {
        touchpad = {
            natural_scroll = false,
            tap_to_click = true,
            scroll_factor = 0.45,
            disable_while_typing = true,
            clickfinger_behavior = true,
        }
    }
})
