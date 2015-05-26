//Channel to listen on
integer CHANNEL = -2734;
integer face = 2;
list names = [];

display_name()
{
    integer length = 6;
    integer x;
    string html;

    do
        html = html + "<h2>" + llList2String(names, x) + "</h2>";
    while(++x < length);

    string externalCSS = "http://students.washington.edu/arm38/OrientationBoardStyle.css";
    llSetPrimMediaParams(face, [PRIM_MEDIA_CURRENT_URL, "data:text/html,<head><link href='" +
                externalCSS + "' rel='stylesheet' type='text/css' /></head><h1><u>Orientation Completed</u></h1>" + html + "<p>Return to The Plaza to begin the Scavenger Hunt.</p>"]);
}

default
{

   state_entry()
    {
        llSetText("Click to view media", <0.0, 1.0, 0.0>, 1.0);
        //Listen on channel -2734
        llListen(CHANNEL, "", llGetObjectName(),  "");
        display_name();
    }
    
    listen(integer CHANNEL, string name, key id, string message)
    {
        names = message + names;
        display_name();
    }
}