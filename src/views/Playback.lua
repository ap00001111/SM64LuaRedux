local recording_index = nil

return {
    name = "TAS Playback ROM Manager",
    draw = function()
        local theme = Styles.theme()

        BreitbandGraphics.draw_text(grid_rect(1, 0, 6, 1), 'center', 'center',
            { aliased = not theme.cleartype },
            BreitbandGraphics.invert_color(theme.background_color),
            theme.font_size * Drawing.scale * 1.5,
            'Consolas',
            "Manage ROM")

        if (ugui.button({
            uid = 901,
            rectangle = grid_rect(1, 1, 6, 1),
            text = "Load ROM",

        })) then
            Playback.load_rom()
        end

        if (ugui.button({
            uid = 902,
            rectangle = grid_rect(0, 2, 4, 1),
            text = "Save ROM",
            is_enabled = Playback.rom_loaded and not Playback.is_saved
        })) then
            Playback.save_rom()
        end
        if (ugui.button({
            uid = 903,
            rectangle = grid_rect(4, 2, 4, 1),
            text = "Save ROM As",
            is_enabled = Playback.rom_loaded
        })) then
            Playback.save_rom_as()
        end
        ugui.listbox({
            uid = 900,
            rectangle = grid_rect(1, 3, 6, 2),
            items = Playback.get_rom_info()
        })

        BreitbandGraphics.draw_text(grid_rect(1, 5, 6, 1), 'center', 'center',
            { aliased = not theme.cleartype },
            BreitbandGraphics.invert_color(theme.background_color),
            theme.font_size * Drawing.scale * 1.5,
            'Consolas',
            "Manage Recordings")

        if Playback.is_recording then
            if (ugui.button({
                uid = 912,
                rectangle = grid_rect(0, 6, 4, 1),
                text = "Cancel Recording"
            })) then
                Playback.cancel_recording()
            end
            if (ugui.button({
                uid = 913,
                rectangle = grid_rect(4, 6, 4, 1),
                text = "Stop Recording",
                is_enabled = Playback.recorded_start_state
            })) then
                Playback.stop_recording()
            end
        else
            if (ugui.button({
                uid = 911,
                rectangle = grid_rect(1, 6, 6, 1),
                text = "Start Recording",
                is_enabled = Playback.rom_loaded
            })) then
                Playback.start_recording()
            end
        end

        ugui.listbox({
            uid = 910,
            rectangle = grid_rect(1, 7, 6, 1),
            items = Playback.get_recording_info()
        })

        local recording_names = Playback.get_recording_names()
        recording_index = ugui.listbox({
            uid = 920,
            rectangle = grid_rect(1, 8, 6, 6),
            items = recording_names,
            selected_index = recording_index
        })
        local recording_selected = (recording_index ~= nil)

        if (ugui.button({
            uid = 921,
            rectangle = grid_rect(7, 10, 1, 1),
            text = "^",
            is_enabled = (recording_selected and (recording_index > 1))
        })) then
            Playback.move_recording_up(recording_index)
            recording_index = recording_index - 1
        end
        if (ugui.button({
            uid = 922,
            rectangle = grid_rect(7, 11, 1, 1),
            text = "v",
            is_enabled = (recording_selected and (recording_index < #recording_names))
        })) then
            Playback.move_recording_down(recording_index)
            recording_index = recording_index + 1
        end
        
        if (ugui.button({
            uid = 923,
            rectangle = grid_rect(0, 14, 4, 1),
            text = "Delete Recording",
            is_enabled = recording_selected
        })) then
            Playback.delete_recording(recording_index)
            recording_index = nil
        end
        if (ugui.button({
            uid = 924,
            rectangle = grid_rect(4, 14, 4, 1),
            text = "Rename Recording",
            is_enabled = recording_selected
        })) then
            Playback.rename_recording(recording_index)
        end
        
        if (ugui.button({
            uid = 925,
            rectangle = grid_rect(0, 15, 4, 1),
            text = "Save Recording",
            is_enabled = recording_selected
        })) then
            Playback.save_recording(recording_index)
        end
        if (ugui.button({
            uid = 926,
            rectangle = grid_rect(4, 15, 4, 1),
            text = "Load Recording",
            is_enabled = Playback.rom_loaded
        })) then
            Playback.load_recording(recording_index)
        end
    end
}
