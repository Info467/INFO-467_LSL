integer CHANNEL = -9783;
integer TOT_TIME = 3600;
integer COUNTER = 0;
string NAME = "";

default
{
    on_rez(integer start_param) 
    {
        llResetScript();
    }

    state_entry()
    {
    		//Get the name of the owner
        NAME = (string)(llKey2Name(llGetOwner()));
    	  //  PUBLIC_CHANNEL has the integer value 0
        llListen(CHANNEL, "", llGetObjectName(),  "");
        llSetText("Minutes Remaining: " + (string)((TOT_TIME - COUNTER)/60), <1, 1, 1>, 1.0);
        llSetTimerEvent(1.0);
   }

   listen(integer CHANNEL, string name, key id, string message)
    {
        if (message == NAME + " restart")
        {
        		llResetScript();
        } 
        else if (message == NAME + " stop")
        {
        		llSetTimerEvent(0.0);
        		llSetText("Complete!", <1, 1, 1>, 1.0);
        }
    }

   timer()
   {
   	COUNTER = COUNTER + 1;
   	llSetText("Minutes Remaining: " + (string)((TOT_TIME - COUNTER)/60), <1, 1, 1>, 1.0);

   	if (COUNTER == TOT_TIME)
   	{
   		llSay(0, "Time's up! Scavenger Hunt Restarting. If you wish to exit, detach the HUD from your Avatar.");
   		llWhisper(CHANNEL,NAME + " restart");
   	}
   }
}
