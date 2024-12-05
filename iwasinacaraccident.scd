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
