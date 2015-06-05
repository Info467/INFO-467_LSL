integer CHANNEL = -9783;
string NAME = "";

default
{
    on_rez(integer start_param) 
    {
        llResetScript();
    }

    state_entry()
    {
    	NAME = (string)(llKey2Name(llGetOwner()));
    }

    touch_start(integer num_detected)
    {
        llWhisper(CHANNEL, NAME + " restart");
    }
}