 /*
AUTHOR: Vextatic
A gambling game by Vextatic, that allows users to gamble for a chance
to win a jackpot amount.
*/
 
integer hasBeenGrantedDebitPerms;
 
integer BASE_JACKPOT = 50;
integer jackpot;
integer increaseJackpot;

integer listenHandle;
 
play_game(key id) {
    string name = llKey2Name(id);
    float random = llFrand(1.0);
    // Winning case, 1% chance
    if (random > 0.99) {
        // Notify winner
        llInstantMessage(id, "Congratulations, you've won! $" + (string)jackpot + " is being transferred to your avatar.");
        llTransferLindenDollars(id, jackpot);

        // Notify global chat
        llSay(0, "--------------WINNER!---------------");
        llSay(0, "WINNER! " + name + " won the jackpot of $" + (string)jackpot + " by rolling " + (string)random + "!");
        llSay(0, "The jackpot has been reset to " + (string)BASE_JACKPOT);
        llSay(0, "------------------------------------");

        jackpot = BASE_JACKPOT;
    } else { // Losing case
        integer increased = increase_jackpot_check();

        llSay(0, name + " tried their luck at the gamblers drum but lost, rolling a " + (string)random);
        
        if(increased) {
            llSay(0, "The jackpot has increased to $" + (string)jackpot + "!");
        }
    }

    update_floattext();
}

update_floattext()
{
    string floattext = "The game is currently disabled.";
 
 
    if (hasBeenGrantedDebitPerms)
    {
        floattext = "Pay 1 Linden for a 1% change to win the current jackpot of $"+ (string)jackpot + "!";
    }
 
    llSetText(floattext, <1.0, 1.0, 1.0>, (float)TRUE);
}
 
// Increases the jackpot every other roll
integer increase_jackpot_check() {
    if(increaseJackpot) { 
        jackpot++; 
        increaseJackpot = FALSE;
    } else {
        increaseJackpot = TRUE;
    }

    return increaseJackpot == FALSE; // We increased the jackpot
}
 
default
{
    on_rez(integer start_param)
    {
        llResetScript();
    }
 
 
    changed(integer change)
    {
        if (change & CHANGED_OWNER)
            llResetScript();
    }
 
    // Set the initial jackpot and start game.
    state_entry()
    {
        // Set the initial jackpot
        jackpot = 50;
        update_floattext();
        increaseJackpot = FALSE;
        
        // request permissions to give away money from the owner
        key owner = llGetOwner();
        llRequestPermissions(owner, PERMISSION_DEBIT);

        // Listens for the owner on public channel to reset script
        listenHandle = llListen(0, "", llGetOwner(), "reset");
    }
 
    // Resets the script upon owners command
    listen(integer channel, string name, key id, string message) 
    {
        llResetScript();
    }

    // Instant messages a simple tutorial on touch
    touch_start(integer num_detected)
    {
        key id = llDetectedKey(0);
        llInstantMessage(id, "Welcome to the Gamblers Drum.");
        llInstantMessage(id, "Simply right click and 'pay' any amount of Linden. For each $1 you recieve a random roll between 0 and 1");
        llInstantMessage(id, "Roll above a 0.99 and you win the entire jackpot!");
    }
 
    // Plays the game one time for each Linden paid.
    money(key id, integer amount)
    {
        integer i;
        for(i = 0; i < amount; i++) {
            play_game(id);
        }
    }
 

    // Enables the game upon getting proper permissions
    run_time_permissions (integer perm) {
        if(perm & PERMISSION_DEBIT) {
            hasBeenGrantedDebitPerms = TRUE;
        }
        update_floattext();
    }
}