default
{
    touch_start(integer num_detected)
    {
        // transparent
        llSetStatus(STATUS_PHANTOM, TRUE);
        llSetLinkAlpha(LINK_SET, 0.0, ALL_SIDES);
        llSetTimerEvent(5.0);
    }
 
    timer()
    {
        // opaque
        llSetLinkAlpha(LINK_SET, 1.0, ALL_SIDES);
        llSetTimerEvent(0.0);
        llSetStatus(STATUS_PHANTOM, FALSE);
    }
}