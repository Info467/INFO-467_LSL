list completed_list = [];
integer REZ_CHANNEL = -9347;
default
{
    collision_start(integer num)
    {
        integer length = llStringLength((string)llDetectedName(0));
        string name = llDeleteSubString((string)llDetectedName(0), length-9, length);
        if(!~llListFindList(completed_list, (list)name))
            {
                completed_list += (list)name;
                key user = llDetectedKey(0);
                llRezObject("Scavenger Hunt HUD", llGetPos() + <0.0,0.0,1.0>, <0.0,0.0,0.0>, <0.0,0.0,0.0,1.0>, 0);
                llWhisper(REZ_CHANNEL, (string)user);
            }
    }
}