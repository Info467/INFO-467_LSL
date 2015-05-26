integer CHANNEL = -9;
integer status = TRUE; //True means Visible

default
{
    state_entry() {
        llSetText("Click to Remove Contents", ZERO_VECTOR, 1.0);
    }
    touch_start(integer num_detected)
    {
        if (status == TRUE) {
            string msg = "off";
            llWhisper(CHANNEL, msg);
            status = FALSE;
        } else {
            string msg = "on"; 
            llWhisper(CHANNEL, msg);
            status = TRUE;
        }   
    }
}