//Channel to listen on
integer CHANNEL = -9783;
//Status of hunt
integer FOUND = FALSE;
//References the button, change with each object
integer ITEM_NUM = 1;
//Clue for the specific item
string CLUE = "I am a Seattle icon!";
//Status of if clue is being shown
integer CLUE_STATUS = FALSE;
//Name of owner
string NAME = "";
//Name of the texture in the inventory of the object 
//that is used as an initial texture
string OUTLINE_TEXTURE = "";

//Parse the message
message_parse(string message) 
{
    //Object has been found
    if (message == NAME + " Object " + (string)ITEM_NUM && (FOUND == FALSE))
    {
        FOUND = TRUE;
        //Tell the HUD Master object was found
        llWhisper(CHANNEL, "TOT++");
        //Update text
        llSetText("FOUND" , <1.0, 1.0, 1.0>, 1.0);
        //Set the color to white
        llSetColor(<1, 1, 1>, -1);
        //Set and scale the completed texture
        llSetTexture("Button Completed", ALL_SIDES);
        llScaleTexture(1, 1, ALL_SIDES);
    }
    //Master says to reset
    else if (message == "res")
    {
        llResetScript();
    }
}

//Changes based on status of constants
touch_parse()
{
    //Clue is not shown & object has not been found
    if (CLUE_STATUS == FALSE && FOUND == FALSE)
    {
        //Set status to true & show clue
        CLUE_STATUS = TRUE;
        llSetText(CLUE , <1.0, 1.0, 1.0>, 1.0);
    }
    //Clue is shown & object has not been found
    else if (CLUE_STATUS == TRUE && FOUND == FALSE)
    {
        //Set status to false & hide clue
        CLUE_STATUS = FALSE;
        llSetText("", ZERO_VECTOR, 0);
    }
}

default
{
    on_rez(integer start_param) 
    {
        llResetScript();
    }

    state_entry()
    {
        //Start listening
        llListen(CHANNEL, "", llGetObjectName(),  "");
        //Set blank texture
        llSetTexture(TEXTURE_BLANK, ALL_SIDES);
        //Set the color white
        llSetColor(<0.294, 0.18, 0.514>, -1);
        //Set the text blank
        llSetText("", ZERO_VECTOR, 0);
        //Get the name of the owner
        NAME = (string)(llKey2Name(llGetOwner()));
    }

    listen(integer CHANNEL, string name, key id, string message)
    {
        message_parse(message);
    }

    touch_start(integer num_detected)
    {
        touch_parse();
    }
}