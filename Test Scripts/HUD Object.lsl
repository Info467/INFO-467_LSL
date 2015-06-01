integer CHANNEL = -9783;
string msg = "Object ";
integer ITEM_NUM = 1;

default
{
    on_rez(integer start_param) {
        llResetScript();
    }

    touch_start(integer num_detected)
    {
        string TOUCHER = llDetectedName(0);
        llSay(CHANNEL, TOUCHER + " " + msg + (string)ITEM_NUM);  
    }
}   