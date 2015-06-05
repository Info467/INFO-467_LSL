integer CHANNEL = -9783;
integer TOT_FOUND = 0;
integer MAX = 10;
string NAME = "";
string real_name = "";

default
{
    on_rez(integer start_param) {
        llWhisper(CHANNEL, NAME + " restart");
        llResetScript();
        if (!llGetAttached() )        //reset the script if it's not attached.
            llResetScript(); 
    }

    run_time_permissions( integer vBitPermissions )
    {
        if ( vBitPermissions & PERMISSION_ATTACH )     
            llAttachToAvatar( ATTACH_HUD_TOP_RIGHT );     
        else     
            llOwnerSay( "Permission to attach denied" );
    }

    state_entry()
    {
        //Get the name of the owner
        NAME = (string)(llKey2Name(llGetOwner()));
        MAX = 10;
        TOT_FOUND = 0;
        //  PUBLIC_CHANNEL has the integer value 0
        llListen(CHANNEL, "", llGetObjectName(),  "");
        llWhisper(CHANNEL, "res");
        integer length = llStringLength(NAME);
        real_name = llDeleteSubString(NAME, length-9, length);
        llRequestPermissions( llGetOwner(), PERMISSION_ATTACH );
    }

    listen(integer channel, string name, key id, string message)
    {
        if (message == NAME + " TOT++")
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
}