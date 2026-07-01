started_story = false;
alarm_triggered = false;
show_objective_text = false;

if (variable_global_exists("load_data") && global.load_data != undefined) {
    if (variable_struct_exists(global.load_data, "started_story")) {
        started_story = global.load_data.started_story;
    }
}


CreateInteract(500, 330, "WARDROBE", "I really should organize this wardrobe. I'm getting old, still living alone... and god, what a disaster.", c_white, 50);
CreateInteract(700, 590, "WINDOW", "* You approach the window and the world answers. 'It's a waste to have you trapped in here...'", c_aqua, 50);
CreateInteract(850, 300, "DRAWERS", "Ugh... so many clothes to fold. Just looking at this makes me tired.", c_white, 50);
scr_show_location("Abby's Bedroom", c_white, true, 1);

if (!started_story) {
    dialogue("Abby", "Finally, the last box is stacked in the corner. This apartment feels like a breath held too long.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "The echo of your own footsteps answers back within the cold white walls of the new city.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "Leaving behind everything I knew was supposed to be liberating. Instead, it just feels like a different kind of cage.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "The air here is heavier. More suffocating. Or maybe I'm just carrying the weight of my own expectations.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "The transition to the new routine brought barriers you did not anticipate. Simple tasks become monuments.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("", "The ceaseless noise of the avenues outside does not let you forget how alone you truly are.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "The first few days were the worst. My wallet is thinner than my patience, and the deadlines are breathing down my neck.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "And to make things worse, all my projects seem stuck. If I see one more build error, I swear I'll throw this monitor out the window.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "Consecutive failures and error screens began to pile up on your workspace table like tombstones.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "I spent the entire afternoon chasing a bug that turned out to be a semicolon I forgot. A semicolon. It's almost poetic.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "Laughing to keep from crying is my new survival skill in this concrete jungle.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "It feels like the more I try to settle down here, the more this city tries to push me out.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "My mind doesn't stop for a single second. It's a flood of internal pressure, a scream without sound.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "Social isolation begins to take its toll in the silence of the early morning.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "It's been days since I had a real conversation with someone outside of professional text messages.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "If the delivery guy knew how much his 'good night' meant to me, he'd probably start charging extra.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "The feeling that I'm failing before I even begin is constant. It lives in my chest like a second heartbeat.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "Every corner of the new bedroom seems to carry a shadow of uncertainty about the future.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "I look at these walls and wonder if I made the right choice, or if I just ran away from my old problems.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "And the worst part of all is the fatigue. A tiredness that doesn't go away even if I spend hours lying down.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "My eyes burn, my body feels heavy, but my brain simply refuses the command to stop. I think I forgot where the power button is.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "Mental exhaustion became an invisible barrier between you and sleep.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "I'm afraid to sleep because I know what awaits me when I close my eyes.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "The nightmares changed too. They became more vivid since I arrived here. More real.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "Distorted memories of what was left behind take grotesque shapes in the dark.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "Sometimes I feel like there's something watching me from the corner of the wardrobe. But it's probably just the monster of overdue rent.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "It must be just the paranoia of sleep deprivation. I need to focus on real things.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "Suddenly, the static vibration of your phone breaks the monotony of silence. A phone rings.", 0.15, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "An incoming call. It's my mother. I better take a deep breath and pretend sanity before answering.", 0.3, c_white, global.fonteNormal, -1)

    dialogue("Mom", "Hi, my dear. Did you manage to set up everything there? How are things going, really?", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue_choice("How are you going to respond about the move?", 0.3, c_white, global.fonteNormal, "LIE", "VENT", "Abby: Everything is great, mom. I already organized the room and projects are running smoothly.", "Abby: To be honest, it's pretty hard. The city is huge and I feel suffocated.")

    dialogue("Mom", "That's good, my daughter. I feel more relieved knowing that you are handling it well.", 0.3, c_yellow, global.fonteNormal, -1)
    dialogue("Mom", "You have always been strong, but do not push yourself too hard. Things take time to fall into place.", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue("Mom", "But tell me, have you been eating well? You know I worry about your health. Do not live on instant noodles, please.", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue_choice("What to say about your food?", 0.3, c_white, global.fonteNormal, "HIDE IT", "TRUTH", "Abby: I'm cooking every day, eating vegetables and everything, mom.", "Abby: To be honest, I barely have an appetite to eat properly lately.")

    dialogue("Mom", "I am glad. Eating well is the secret to keeping the mind focused.", 0.3, c_yellow, global.fonteNormal, -1)
    dialogue("Mom", "You will end up sick that way. Please make an effort for me.", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue("Mom", "And your insomnia attacks? Have you been able to sleep well at night?", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue_choice("How to answer about your sleep?", 0.3, c_white, global.fonteNormal, "SAY YES", "ADMIT IT", "Abby: I'm sleeping like a rock. The exhaustion of the day knocks me out.", "Abby: The nightmares came back, mom. They are stronger than before.")

    dialogue("Mom", "Thank God. Sleep is the best medicine for the soul.", 0.3, c_yellow, global.fonteNormal, -1)
    dialogue("Mom", "Ah, my dear. Remember to take a deep breath and relax before going to bed.", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue("Mom", "Honey, I need to hang up now. Do you regret moving out there?", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue_choice("Your final response to her.", 0.3, c_white, global.fonteNormal, "NO", "MAYBE", "Abby: Not at all. I needed this. Everything will work out fine.", "Abby: Sometimes I feel like I made the biggest mistake of my life.")

    dialogue("Mom", "I trust you. I love you so much. Take care and call me tomorrow.", 0.3, c_yellow, global.fonteNormal, -1)
    dialogue("Mom", "Do not think like that. The beginning is painful. It will pass. I love you. Stay well.", 0.3, c_yellow, global.fonteNormal, -1)

    dialogue("", "The call ends. The phone screen goes blank, returning the room to twilight.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "I miss her voice. But now the silence feels even bigger.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "The digital clock marks late hours of the night. Your eyelids feel heavy like lead.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("", "The day was excessively long, exhausting, and full of trials.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("", "Your body begs for a truce against your own thoughts.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "I cannot fight this anymore. My eyes are closing on their own.", 0.3, c_white, global.fonteNormal, -1)
    dialogue("", "You walk slowly to the bed, leaving the weight of the world on the bedroom floor.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("", "The cold sheet welcomes you as you finally give up resisting.", 0.3, c_aqua, global.fonteNormal, -1)
    dialogue("Abby", "Whatever awaits me in the void of my mind...", 0.3, c_white, global.fonteNormal, -1)
    dialogue("Abby", "It doesn't matter. Tomorrow will be a good day.", 0.2, c_yellow, global.fonteNormal, -1)
    
    started_story = true;
}

alarm_triggered = false;
show_objective_text = false;