default
{
    touch_start(integer num_detected)
    {
        // transparent
        llSetLinkAlpha(LINK_SET, 0.0, ALL_SIDES);
        llSetTimerEvent(5.0);
    }
 
    timer()
    {
        // opaque
        llSetLinkAlpha(LINK_SET, 1.0, ALL_SIDES);
        llSetTimerEvent(0.0);
    }
}