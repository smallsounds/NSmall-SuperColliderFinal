# SuperColliderFinal
## Day 1
I created the syths that will be used for the project. Using the [week 2 class notes](https://github.com/rdwrome/347fa24/blob/main/02.effects/CODEALONG.scd), I created these synths:

    (
    SynthDef(\sineSeq, {
        arg freq, dur, amp, pan;
        var sound;
        sound = SinOsc.ar(freq, 0, amp);
        sound = sound * EnvGen.kr(Env.perc(0.01, 0.1), doneAction: 2);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    SynthDef(\perc, {
        arg freq, dur, amp, pan;
        var sound;
        sound = WhiteNoise.ar(amp);
        sound = sound * EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    SynthDef(\robotSynth, {
        arg freq = 440, amp = 0.5, pan = 0;
        var sound;
        sound = Mix([
            SinOsc.ar(freq * 1.5, 0, 0.1),
            Pulse.ar(freq * 0.8, 0.25, 0.1),
            Blip.ar(freq * 2, 0.05)
        ]);
        sound = sound * EnvGen.kr(Env.perc(0.01, 0.3), doneAction: 2);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    SynthDef(\whiteNoiseSynth, {
        arg amp = 0.1, pan = 0;
        var sound;
        sound = WhiteNoise.ar(amp);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;
    )

I added an envelope to the sineSeq and the percussion to add a plucky/percussive element to the sound. For the robot synth, I asked my friend Ela for help on what kind of elements I needed to make to create a robot-y synth. She doesn't know a lot about SuperCollider, but she was helpful in explaining what kinds of sounds result from certain Ugens in plain language. Using that information, I created the robotSynth. Finally, I made a synth for white noise. I honestly, I could've just added white noise when it's supposed to play in the piece, but I kinda like stating it up top. C language moment. 

I then created the beginning portion of section 1

    (
    ~seq1 = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([500, 600, 700, 800, 900], inf),
        \dur, Pseq([0.2, 0.25, 0.3, 0.15], inf),
        \amp, 0.3
    ).play;

    ~seq2 = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([100, 150, 200, 250, 300], inf),
        \dur, Pseq([0.4, 0.45, 0.5, 0.35], inf),
        \amp, 0.3
    ).play;

    ~seq3 = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([1000, 1100, 1200, 1300], inf),
        \dur, Pseq([0.3, 0.35, 0.4], inf),
        \amp, 0.5
    ).play;
    )

I was reading a little bit of the [SuperCollider Book code on GitHub](https://github.com/supercollider/scbookcode/blob/3d70674fa4577bc37b717e2ec8b5ef859206dfb5/Ch%203%20Composing/Ch3code.scd) and was inspired by the way they notate events (~event) and call events with .value. I created three sequencers moving up in pitch at different frequency ranges and rhythmimc intervals. 

## Day 2
I didn't have much time, but I created this:

    (
    ~whiteNoise = {
        Synth(\whiteNoiseSynth, [\amp, 0.025, \pan, 0]);
    };
    ~whiteNoise.value;
    )

    (
    ~robotSeq = Pbind(
        \instrument, \robotSynth,
        \freq, Pseq([200, 300, 400, 500], inf),
        \amp, 0.9,
        \dur, 0.5,
        \pan, Pwhite(-1, 1)
    ).play;
    )

    (
    ~seq1.stop;
    ~seq2.stop;
    ~seq3.stop;
    )

    ~robotSeq.stop;

With the way I set up the whiteNoise event, I needed to use .value to play it with the given arguments. I then created the robot sound sequencer. I decided to keep section 1's sequencers running throughout and stop them after a couple of robot noise rounds. I also added a robotSeq.stop so that the player can start and stop the sequencer whenever they want. 

## Day 3
I was on my way to a recording session, and my Uber was rear-ended. I have a concussion, and I'm not supposed to be looking at screens. Using the other two sections as a template, I created this:

    (
    ~percussion = Pbind(
        \instrument, \perc,
        \freq, Pseq([400, 300, 350, 450], inf),
        \dur, Pseq([0.3, 0.25, 0.4, 0.5], inf),
        \amp, 0.2
    ).play;
    )

    (
    ~sparkles = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([1500, 1200, 1300, 1400], inf),
        \dur, 0.1,
        \amp, 0.1
    ).play;
    )

It's pretty self-explanatory. I'm going to avoid typing too much going forward because doing the SuperCollider project and documentation files are not helping my migraines.

## Day 4
I expanded my 140 character assignment into this:

    (
    s = SynthDef.new(\mysynth, {
        Out.ar(0,
            VarSaw.ar(Duty.ar(1/4, 0, Dxrand([99, 130, 147, 185, 220, 247, 146], inf)), 0, 0.4, 0.3) +
            (LFCub.ar(LFSaw.kr(LFPulse.kr(1/4, 1/4, 1/4) * 2, 1, -20, 50))!2))
    });
    s.add;

    x = Synth(\mysynth);
    )

    x.free;

to create a new section of the piece. At this point, I don't know if I can do more for this project because of my health stuff. Will try arranging the material into a three-minute composition tomorrow. 

# Day 5
I asked Joe Gatti how to fade out audio in SuperCollider, and he said that it involves making really long envelopes. I have decided not to fade out my piece because that is a lot of reading for someone with a concussion.

I rearranged all the elements I have so far to represent the day I got into a car accident.

    //iwasinacaraccident
    ----------------------------------------------
    (
    SynthDef(\sineSeq, {
        arg freq, dur, amp, pan;
        var sound;
        sound = SinOsc.ar(freq, 0, amp);
        sound = sound * EnvGen.kr(Env.perc(0.01, 0.1), doneAction: 2);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    SynthDef(\perc, {
        arg freq, dur, amp, pan;
        var sound;
        sound = WhiteNoise.ar(amp);
        sound = sound * EnvGen.kr(Env.perc(0.01, 0.2), doneAction: 2);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    SynthDef(\robotSynth, {
        arg freq = 440, amp = 0.5, pan = 0;
        var sound;
        sound = Mix([
            SinOsc.ar(freq * 1.5, 0, 0.1),
            Pulse.ar(freq * 0.8, 0.25, 0.1),
            Blip.ar(freq * 2, 0.05)
        ]);
        sound = sound * EnvGen.kr(Env.perc(0.01, 0.3), doneAction: 2);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    SynthDef(\whiteNoiseSynth, {
        arg amp = 0.1, pan = 0;
        var sound;
        sound = WhiteNoise.ar(amp);
        sound = Pan2.ar(sound, pan);
        Out.ar(0, sound);
    }).add;

    ~tbl = IdentityDictionary[
        $1 -> [[697, 1209]],
        $2 -> [[770, 1209]],
        $3 -> [[852, 1209]],
        $4 -> [[697, 1336]],
        $5 -> [[770, 1336]],
        $6 -> [[852, 1336]],
        $7 -> [[697, 1477]],
        $8 -> [[770, 1477]],
        $9 -> [[852, 1477]],
        $* -> [[697, 1633]],
        $0 -> [[770, 1633]],
        $# -> [[852, 1633]],
        $A -> [[941, 1209]],
        $B -> [[941, 1336]],
        $C -> [[941, 1477]],
        $D -> [[941, 1633]]
    ];

    SynthDef(\dtmf, {|freq=#[770, 1633], out=0, amp=0.2, gate=1|
        var son, env;
        son = SinOsc.ar(freq, 0, amp).sum;
        env = EnvGen.ar(Env.asr(0.001, 1, 0.001), gate, doneAction: 2);
        Out.ar(out, Pan2.ar(son * env * amp));
    }).add;

    )

    // Section 1: Getting Ready for the Day
    ----------------------------------------------
    (
    ~robotSeq = Pbind(
        \instrument, \robotSynth,
        \freq, Pseq([200, 300, 400, 500], inf),
        \amp, 0.9,
        \dur, 0.5,
        \pan, Pwhite(-1, 1)
    ).play;
    )

    //x8

    (
    ~percussion = Pbind(
        \instrument, \perc,
        \freq, Pseq([400, 300, 350, 450], inf),
        \dur, Pseq([0.3, 0.25, 0.4, 0.5], inf),
        \amp, 0.2
    ).play;
    )

    //Trigger whenever you feel is right, remember to stop when you feel there's too much going on--don't play twice!
    (
    ~sparkles = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([1500, 1200, 1300, 1400], inf),
        \dur, 0.1,
        \amp, 0.1
    ).play;
    )

    ~sparkles.stop;

    // Section 2: Demo Day ~1:00
    ----------------------------------------------
    (
    ~seq1 = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([500, 600, 700, 800, 900], inf),
        \dur, Pseq([0.2, 0.25, 0.3, 0.15], inf),
        \amp, 0.3
    ).play;

    ~seq2 = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([100, 150, 200, 250, 300], inf),
        \dur, Pseq([0.4, 0.45, 0.5, 0.35], inf),
        \amp, 0.3
    ).play;

    ~seq3 = Pbind(
        \instrument, \sineSeq,
        \freq, Pseq([1000, 1100, 1200, 1300], inf),
        \dur, Pseq([0.3, 0.35, 0.4], inf),
        \amp, 0.5
    ).play;
    )

    //Wait a few cycles before moving forward--play some sparkles from the other section!

    (
    ~whiteNoise = {
        ~currentSynth = Synth(\whiteNoiseSynth, [\amp, 0.025, \pan, 0]);
    };
    ~whiteNoise.value;
    )

    //Alright, Demo Day is done. Let's order the Uber
    (
    ~seq1.stop;
    ~seq2.stop;
    ~seq3.stop;
    ~sparkles.stop;
    )


    ~robotSeq.stop;

    //Sit in this moment, no need to rush. Just chilling in the car :)


    // Section 3: Crash (feel it out)
    ----------------------------------------------
    (
    //Call Uber support!
    ~currentSynth.free;
    ~percussion.stop;
    Pbind(
        \instrument, \dtmf,
        \dur, Pwhite(0.2, 0.5, inf),
        \sustain, 0.15,
        \amp, 0.3,
        \freq, Pseq("8002856172".collectAs({|digit| ~tbl[digit] }, Array))
    ).play;
    )

    (
    Ndef(\dialtone, {
        Pan2.ar(SinOsc.ar([350, 440], 0, 0.2).sum)
    }).play
    )

    (
    Ndef(\dialtone).free;
    s = SynthDef.new(\mysynth, {
        Out.ar(0,
            VarSaw.ar(Duty.ar(1/4, 0, Dxrand([99, 130, 147, 185, 220, 247, 146], inf)), 0, 0.4, 0.3) +
            (LFCub.ar(LFSaw.kr(LFPulse.kr(1/4, 1/4, 1/4) * 2, 1, -20, 50))!2))
    });
    s.add;

    x = Synth(\mysynth);

    w = {	|period=0.7|
        var change, rate, sig, carrierFreq, cfRamp, carrierLvl, clRamp,
        modulatorRatio, mrRamp, modulatorIndex, miRamp, outputAmplitude, oaRamp;

        period = period * 600 + 100;

        change = Impulse.kr(LocalIn.kr(1,10));
        rate = CoinGate.kr(1/3, change);
        rate = (TChoose.kr(rate, period/((0..1) + 1))/1000).reciprocal;
        LocalOut.kr(rate);

        # carrierFreq, cfRamp = TIRand.kr(0, [1000, 1], change);
        carrierFreq = Ramp.kr( carrierFreq / 1000, (cfRamp * period) / 1000 ) * 0.6;

        # carrierLvl, clRamp = TIRand.kr(0, [9000, 1], CoinGate.kr(1/3, change));
        carrierLvl = Ramp.kr( carrierLvl, (clRamp * period) / 1000) + 100;

        # modulatorRatio, mrRamp = TIRand.kr([800,1], CoinGate.kr(1/4, change));
        modulatorRatio = Ramp.kr(modulatorRatio, (mrRamp * period) / 1000) + 20;

        # modulatorIndex, miRamp = TIRand.kr(0, [100, 1], CoinGate.kr(1/4, change));
        modulatorIndex = Ramp.kr(modulatorIndex / 200, (miRamp * period) / 1000) + 0.2;

        # outputAmplitude, oaRamp = TIRand.kr(0!2, 1!2, CoinGate.kr(1/2, change));
        outputAmplitude = Ramp.kr(outputAmplitude, (oaRamp * period + 3) / 1000);

        sig = LFSaw.ar(carrierFreq, 1, 0.5, 0.5) * carrierLvl;
        sig = sig + SinOsc.ar(carrierFreq * modulatorRatio) * modulatorIndex;
        sig = cos(sig * 2pi) * outputAmplitude;

        sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
        sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
        sig = (sig - OnePole.ar(sig, exp(-2pi * (100 * SampleDur.ir))));
        sig = (sig - OnePole.ar(sig, exp(-2pi * (100 * SampleDur.ir))));
        sig = sig!2 * 0.06;
    }.play;
    )

    //Are you okay? (Choose as many as you need)
    w.set(\period, 1);
    w.set(\period, 0.7);
    w.set(\period, 0.3);



    //It's a long call with Uber.



    //Semester ruined :(
    (
    ~whiteNoise = {
        Synth(\whiteNoiseSynth, [\amp, 0.025, \pan, 0]);
    };
    ~whiteNoise.value;

    w.free;

    x.free;
    )

I added the dial tone, phone numbers, and R2D2 noises from the modeling lesson. As you can see, I flipped a lot of elements around and added context/light directions embedded in the piece. I recorded how much time it would take me to play, and it came in somewhere between 2:45 and 3:30, so I think it's ready to be rehearsed tomorrow.