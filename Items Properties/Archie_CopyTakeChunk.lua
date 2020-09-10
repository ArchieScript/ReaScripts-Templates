    --item: userdata - source item
    --idxTake: number - index of the take that will be copied
    --destItem: userdata - item into which the copied take will be inserted
    --newItem: boolean - false insert as a new take, true insert as a new one item
    -------------------------------------------------------
    
    
    
    
    local function copyTake(item,idxTake,destItem,newItem);
        --POOL=true;
        local _,str = reaper.GetItemStateChunk(item,'',false);
        if idxTake == 0 then;
        ----------
            local STR,TK,X,X2 = '',nil,nil,nil;
            for val in string.gmatch(str,".-\n")do;
                if val:match('^TAKE%s-\n')or val:match('^TAKE%s+SEL%s-\n')then;X=true;end;
                if val:match('^NAME.*\n')then;X2=true;end;
                ---
                if X2==true and X~=true then;
                    if POOL ~= true then;
                        val = val:gsub('^%s-POOLEDEVTS%s+%{.+%}','POOLEDEVTS '..reaper.genGuid(''));
                    end;
                    val = val:gsub('^%s-GUID%s+%{.+%}','GUID '..reaper.genGuid(''));
                    STR = STR..val;
                end;
                if val:match('^TAKE%s+SEL%s-\n')then;TK='TAKE\n'break end;
            end;
            if X == true then;STR = STR..'\n>\n'; end;
            ----
            local _,str2 = reaper.GetItemStateChunk(destItem,'',false);
            local STR2 = '';
            if newItem == true then;
                for val in string.gmatch(str2,".-\n")do;
                    if val:match('^NAME.*\n')then;val=STR;end;
                    STR2 = STR2..val;
                    if val == STR then;break;end;
                end;
            else;
                TK = TK or 'TAKE SEL\n';
                STR = TK..STR;
                STR2 = str2:gsub('>%s-\n-%s-$',STR..'\n%0');
            end;
            reaper.SetItemStateChunk(destItem,STR2,false);
        ----------
        elseif idxTake > 0 then;
        ----------
            local STR,x = '',0;
            for val in string.gmatch(str,".-\n")do;
                if val:match('^TAKE%s-\n')or val:match('^TAKE%s+SEL%s-\n')then;x=x+1;end;
                if x == idxTake then;
                    if POOL ~= true then;
                        val = val:gsub('^%s-POOLEDEVTS%s+%{.+%}','POOLEDEVTS '..reaper.genGuid(''));
                    end;
                    val = val:gsub('^%s-GUID%s+%{.+%}','GUID '..reaper.genGuid(''));
                    STR = STR..val;
                end;
                if x > idxTake then break end;
            end;
            ---
            if STR and STR ~= '' then;
                local retval,str = reaper.GetItemStateChunk(destItem,'',false);
                local STR2 = '';
                if newItem == true then;
                    for val in string.gmatch(str,".-\n")do;
                        if val:match('^NAME.*\n')then;break;end;
                        STR2 = STR2..val;
                    end;
                    STR = STR:gsub('^%s-TAKE%s-[SEL]*%s-\n','');
                    STR2 = STR2..'\n'..STR..'\n>';
                else;
                    STR2 = str:gsub('>%s-\n-%s-$',STR..'\n%0');
                end;
                reaper.SetItemStateChunk(destItem,STR2,false);
            end;
        --------
        end;
    end;
