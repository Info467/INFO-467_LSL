integer CHANNEL = -9783;
integer TOT_FOUND = 0;
integer MAX = 10;
integer listenHandle_a;
integer listenHandle_b;

default
{
    on_rez(integer start_param) {
        llResetScript();
    }

    state_entry()
    {
        //Get the name of the owner
        key owner = llGetOwner();
        MAX = 10;
        TOT_FOUND = 0;
        listenHandle_a = llListen(0, "", owner, "");
        //  PUBLIC_CHANNEL has the integer value 0
        listenHandle_b = llListen(CHANNEL, "", llGetObjectName(),  "");
        llWhisper(CHANNEL, "res");
    }

    listen(integer channel, string name, key id, string message)
    {
    		if (channel == 0)
    		{
    			if (message == "restart")
    			{
    				llWhisper(CHANNEL, "res");
        			llResetScript();
    			}
    		}
        if (message == "TOT++")
        {
            TOT_FOUND = TOT_FOUND + 1;

            if (TOT_FOUND >= MAX)
            {
            	llSay(0, "You have completed the scavenger hunt!");
            	llWhisper(CHANNEL, "stop");
            }
        }
        else if (message == "restart")
        {
        		llWhisper(CHANNEL, "res");
        		llResetScript();
        }
   }
}