function GetPlayOrEditCursorPos()
	local play_state = reaper.GetPlayState()
	local cursor_pos
	if play_state == 1 then
		cursor_pos = reaper.GetPlayPosition()
	else
		cursor_pos = reaper.GetCursorPosition()
	end
	return cursor_pos
end

function GetCurrentMeasureLength() -- from edit cursor or play position
	local cursor_pos = GetPlayOrEditCursorPos()
	local retval, measures, cml, fullbeats, cdenom = reaper.TimeMap2_timeToBeats(0, cursor_pos)
	local current_measure = reaper.TimeMap2_beatsToTime(0, retval, measures)
	local next_beat = reaper.TimeMap2_beatsToTime(0, retval + 1, measures + 1)
	return next_measure - current_measure
end
