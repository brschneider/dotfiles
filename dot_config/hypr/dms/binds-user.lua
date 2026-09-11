-- Optional per-user keybind overrides (managed by DMS). Loaded after default binds.

-- Float and pin active window so it stays visible across workspaces (toggle)
hl.bind("SUPER + SHIFT + O", function()
	local w = hl.get_active_window()
	if not w then
		return
	end

	if w.pinned then
		hl.dispatch(hl.dsp.window.pin({ action = "off" }))
		hl.dispatch(hl.dsp.window.float({ action = "off" }))
	else
		if not w.floating then
			hl.dispatch(hl.dsp.window.float({ action = "on" }))
		end
		hl.dispatch(hl.dsp.window.pin({ action = "on" }))
	end
end)

-- Clipboard Copy (SUPER + C sends CTRL + C to focused window)
hl.bind("SUPER + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "c" }))

