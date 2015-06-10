default
{
    touch_start(integer total_number)
    {
        // Grab the first name of the resident
        key id = llDetectedKey(0);
        string name = llDetectedName(0);
        integer spaceIndex = llSubStringIndex(name, " ");
        string  firstName  = llGetSubString(name, 0, spaceIndex - 1);

        llInstantMessage(id, "Hello " + firstName + ", do you want to play a game? Find our Scavenger Hunt sign and stand on the platform.");
    }
}
