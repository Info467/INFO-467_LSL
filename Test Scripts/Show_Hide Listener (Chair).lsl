//Channel to listen on
integer CHANNEL = -9;

default
{
    on_rez(integer start_param) {
        llResetScript();
        llSetClickAction(1);
    }
    state_entry()
    {
        //  PUBLIC_CHANNEL has the integer value 0
        llListen(CHANNEL, "", llGetObjectName(),  "");
    }

    listen(integer CHANNEL, string name, key id, string message)
    {
        string thing = message;
        if (message == "off") {
            // off means visible
            llSetLinkAlpha(LINK_SET, 1.0, ALL_SIDES);
            llSetStatus(STATUS_PHANTOM, FALSE);
            //set sit icon
            llSetClickAction(1);
        } else if (message == "on") {
            //on means invisible
            llSetStatus(STATUS_PHANTOM, TRUE);
            llSetLinkAlpha(LINK_SET, 0.0, ALL_SIDES);
            //remove sit icon
            llSetClickAction(0);
        }
    }
}