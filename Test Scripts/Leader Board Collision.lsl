list completed_list = [];
integer CHANNEL = -2734;
 
default {
    state_entry()
    {
        llVolumeDetect(TRUE);
        llParticleSystem([]);
    }
         
    collision_start(integer c) {
        integer length = llStringLength((string)llDetectedName(0));
        string name = llDeleteSubString((string)llDetectedName(0), length-9, length);
        if(!~llListFindList(completed_list, (list)name))
            {
                completed_list += (list)name;
                //for debugging
                //llSay(0, llList2String(completed_list));
                llSay(CHANNEL, name);
            }
       // else
       //     {
       //         llWhisper(0, "You have already completed orientation!");
       //     }
    }
}