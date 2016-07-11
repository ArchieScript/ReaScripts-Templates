function Open_URL(url)
  if not OS then local OS = reaper.GetOS() end
  if OS=="OSX32" or OS=="OSX64" then
    os.execute("open ".. url)
   else
    os.execute("start ".. url)
  end
end

function CheckSWS()
  if reaper.NamedCommandLookup("_BR_VERSION_CHECK") == 0 then 
    local retval = reaper.ShowMessageBox("SWS extension is required by this script.\nHowever, it doesn't seem to be present for this REAPER installation.\n\nDo you want to download it now ?", "Warning", 1)
    if retval == 1 then
      Open_URL("http://www.sws-extension.org/download/pre-release/")
    end
  else
    return true
  end
end

sws = CheckSWS()
