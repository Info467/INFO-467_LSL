/*************************************
Author: Vextatic
Q/A Voting Script

Tracks answers by nearby avatars in public chat.

***************************************/



// Add the possible answers to your question here
// Remember that it is case sensitive.

list POSSIBLE_ANSWERS = ["a", "b", "c", "d"];

/****************************************
Other examples:

list POSSIBLE_ANSWERS = ["yes", "no", "maybe"];
list POSSIBLE_ANSWERS = ["cat", "dog", "mouse"];


Are you going to have multiple of these scripts within 20m of each other?
Are they going to have overlapping answers? 

Append a unique identifier:

list POSSIBLE_ANSWERS = ["q1. yes", "q1. no", "q1. maybe"];
list POSSIBLE_ANSWERS = ["q2. yes", "q2. no", "q2. maybe"];
*******************************************/


/***************************
DO NOT EDIT BELOW THIS LINE
****************************/
list answerTally;
list acceptedIDs;

integer listenHandle;

// Adds one to an answer
tallyAnswer(string answer) {
    // Grabs the index of the possible answer, which coincides with the index of the answer tally
    integer index = llListFindList(POSSIBLE_ANSWERS, [answer]);

    // Grabs the current value of the tally for the answer
    integer currentValue = llList2Integer(answerTally, index);
    currentValue++;
    if (index != -1) {
        answerTally = llListReplaceList(answerTally, [(integer)currentValue], index, index);
    }
}

// Sets the float text to format 'Possible Answers: yes(2) no(4)'
setFloatText() {
    string result = "Possible Answers (Case Sensitive):";
    integer length = llGetListLength(POSSIBLE_ANSWERS);

    integer index;
    while(index < length) {
        result += " " + llList2String(POSSIBLE_ANSWERS, index) + 
        "(" + llList2String(answerTally, index) + ")";
        index++;
    }
    
    llSetText(result, <1.0, 1.0, 1.0>, (float)TRUE);
}

// Creates listen handlers for each possible answer
createListenHandlers() {
    integer length = llGetListLength(POSSIBLE_ANSWERS);

    integer index;
    while(index < length) {
        string item = llList2String(POSSIBLE_ANSWERS, index);
        llListen(0, "", "", item);
        index++;
    }
}

// Creates the tally list to keep track of number of answers
createTallyList() {
    integer length = llGetListLength(POSSIBLE_ANSWERS);

    integer index;
    while(index < length) {
        answerTally += 0;
        index++;
    }
}

default
{
    state_entry()
    {
        createListenHandlers();
        createTallyList();
        setFloatText();
    }

    // Adds answers to the tally and updates floattext
    listen (integer channel, string name, key id, string message)
    {
        // User has already answered
        if(~llListFindList(acceptedIDs, (list)id)) {
            llInstantMessage(id, "Sorry you've already answered this question.");
        } else {
            llInstantMessage(id, "Your answer of " + message + " is being added...");
            acceptedIDs += id;
            tallyAnswer(message);
            setFloatText();
            llInstantMessage(id, "Your answer of " + message + " has been added!");
        }
    }

    touch_start(integer total_number)
    {
        key id = llDetectedKey(0);
        llInstantMessage(id, "Simply type one of the possible answers in chat to cast your vote (it's case sensitive).");
    }

    on_rez(integer start_param)
    {
        llResetScript();
    }

    changed(integer change)
    {
        if(change & CHANGED_OWNER) 
        {
            llResetScript();
        }
    }
}
