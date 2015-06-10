integer CHANNEL = -9783;
integer REZ_CHANNEL = -9347;
integer TOT_FOUND = 0;
integer MAX = 10;
string NAME = "";
string real_name = "";
integer internalListenHandle;
integer interactionListenHandle;

default
{
    attach(key id)
    {
        if(id)
        {
            llListenRemove(internalListenHandle);
        }
    }
    on_rez(integer start_param) {
        state default;
    }
    
    run_time_permissions( integer vBitPermissions )
    {
        if ( vBitPermissions & PERMISSION_ATTACH )  
        {   
            llAttachToAvatarTemp(ATTACH_HUD_TOP_RIGHT);   
        }
        else     
        {
            llDie();
        }
    }

    state_entry()
    { 
        //Get the name of the owner
        NAME = (string)(llKey2Name(llGetOwner()));
        MAX = 10;
        TOT_FOUND = 0;
        internalListenHandle = llListen(REZ_CHANNEL, "", "", "");  
        interactionListenHandle = llListen(CHANNEL, "", "",  "");
        //llWhisper(CHANNEL, "res");
        integer length = llStringLength(NAME);
        real_name = llDeleteSubString(NAME, length-9, length);
    }

    listen(integer channel, string name, key id, string message)
    {
        if (channel == -9347)
        {
            llRequestPermissions((key)message, PERMISSION_ATTACH); 
        }
        else if (message == NAME + " TOT++")
        {
            TOT_FOUND = TOT_FOUND + 1;

            if (TOT_FOUND >= MAX)
            {
                llShout(0, real_name + " has completed the scavenger hunt!");
                llWhisper(CHANNEL, NAME + " stop");
            }
        }
        else if (message == NAME + " restart")
        {
                llResetScript();
        }
   }
     
    state_exit()
   {
        llListenRemove(internalListenHandle);
    }
}