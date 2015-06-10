default
{

    state_entry()
    {
        llSetText("", ZERO_VECTOR, 0);
    }
    
    touch_start(integer total_number)
    {

        // Grab the first name of the resident
        key id = llDetectedKey(0);
        string name = llDetectedName(0);
        integer spaceIndex = llSubStringIndex(name, " ");
        string  firstName  = llGetSubString(name, 0, spaceIndex - 1);

        llInstantMessage(id, "Hello " + firstName + ", you are new here maybe? Turn around and go into our Orientation Longhouse.");
    }
}
