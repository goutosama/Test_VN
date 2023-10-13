VAR name = ""
VAR ill = "None"
VAR charChiaki = "Chiaki"
VAR charNanami = "Nanami"

Once upon a time...
There was a girl named {charChiaki} {charNanami}. She was a test character in a very simple game. It had no objects, no backgrounds, nothing, except for her sprite and little dialogue window at the bottom of the screen.
Firstly, we will test how {charChiaki} will respond to my questions. {charChiaki}, tell us about yourself.
~ name = "{charChiaki}"
Okay, I'm 18 years old girl and I like to play games. It's cool to see an unreleased game with my own two eyes.

~ name = ""
That was kind of short speech, but still pretty good. Well then, {charNanami}, how did you even get here in the first place? Isn't that a serious crime to crawl inside someone's unreleased games? 
Now, you, Player. Does she deserve the punishment? Or we could leave her as she is? Or maybe you have some other thoughts about it?
    * Make her apologise for her sins
        -> apologise
    * Forgive ger
        -> forgiveness
    * Force her to suck your cock
        -> youareapervmonster


=== apologise ===
~ name = "Player"
~ ill = "Images/bg30a0.jpg"
She could be punished, but that's not nessecary. What really must be done is apologise: she snuck into my game without asking my permission. {ill}

~ name = "{charChiaki}"
Oh my! How things have turned! Okay, if you really need my apologies, here I am: 
I AM SO SORRY! # centered
Are you satisfied?

~ name = ""
And with those words, here ends this little story. It has no value as a book, nor does it have any meaning underneath it. This story just tests our funny little visual novel engine, nothing more and nothing less. 
-> END

=== forgiveness ===
~ name = "Player"
She should stay here and have fun. I will allow it.

~ name = ""
The girl in front of you stays on her place. Happy as any little 2D character could be. Who knows, maybe that was the best choice in this little story? Only the time will tell. -> END
=== youareapervmonster ===
~ name = "{charChiaki}"
What? He started to move? Did he choose anything? What's with this look in his eyes?

~ name = ""
Indeed, he stares at her with a hungry eyes like how starving people look at lunch table. The whole his body starved for a pretty girl and existence of this choice was a miracle, an answered pray from heavens, as he sees it. 
This monster approaches the shivering girl, grabs her shoulder and pushes, forcing {charChiaki} to land on her knees. Now her face is on the same level as his crotch is. 
The rest is up to your imagination. I'm not going to describe all of this. In the end you guys are still too young for that, and umm.. Actually, I just don't want to tell you about it.
-> END
