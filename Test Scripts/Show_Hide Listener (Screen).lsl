//Channel to listen on
integer CHANNEL = -9;

default
{
    on_rez(integer start_param) {
        llResetScript();
        llSetPrimMediaParams(3, [PRIM_MEDIA_AUTO_ZOOM, 1]);
    }
    state_entry()
    {
        //Listen on channel -9
        llListen(CHANNEL, "", llGetObjectName(),  "");
    }

    listen(integer CHANNEL, string name, key id, string message)
    {
        string thing = message;
        if (message == "off") {
            // off means visible
            llSetLinkAlpha(LINK_SET, 1.0, ALL_SIDES);
            llSetStatus(STATUS_PHANTOM, FALSE);
            llSetPrimMediaParams(3, [PRIM_MEDIA_AUTO_ZOOM, 1]);
        } else if (message == "on") {
            //on means invisible
            llSetStatus(STATUS_PHANTOM, TRUE);
            llSetLinkAlpha(LINK_SET, 0.0, ALL_SIDES);
            llSetPrimMediaParams(3, [PRIM_MEDIA_AUTO_ZOOM, 0]);
        }
    }
    //For debugging
    touch_start(integer num_detected){
        integer face = llDetectedTouchFace(0);
        llSay(PUBLIC_CHANNEL, (string)face);
    }
}