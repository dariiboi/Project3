//Final Project 1st Marking Period

Env.new([0.1,1,0.1,0.01],[0.007,2,1],\exp).plot;//test envelope. evualte this to plot it.
(
SynthDef.new(\iter, {//new synth iteration.
	//freq - pitch, rel - duration of note, amp - volume, pan - l or r speaker, width - synth timbre
	arg freq = 440,atk = 0.01, rel = 0.03, amp = 0.7, pan =0, width = 0.4;
	var temp, sig, env;
	//generate exponential envelope
	env = EnvGen.kr(Env.new([0.01,1rel,0.01],[atk,2,1],\exp),doneAction:2);
	sig = 0;
	//create 4 synths and give them variable pitch and timbre -creates chorus effect
	4.do{
		temp = VarSaw.ar(freq*{Rand(0.99,1.02)},{Rand(0,1)},{ExpRand(width,0.5)}!2);
		sig = sig + temp*env;
	};
	//add pan functionality
	sig = Pan2.ar(sig,pan,amp);
	//condense 4 synths to a 2 channel output
	sig = Splay.ar(sig)*0.2;
	// add reverb
	sig = FreeVerb.ar(sig,0.6,0.8,0.2);
	// mix to audio bus 0
	Out.ar(0,sig);
}).add;
)
(
//first pattern def
x=Pdef(
	\pattern1,
	Pbind(
		\type, \note,
		\instrument, \iter,
		//speed of pattern
		\dur, 0.2,
		//volume
		\amp, 1,
		//the midinotes which by default get  converted to frequencies
		//this is a 4 midi note long pattern, it get repeated indefinitely
		\midinote, Pfunc({a})*Pseq([60,64,69 ,76], inf)-Pfunc({b}),
	);
)
)
(
//second pattern def
y=Pdef(
	\pattern2,
	Pbind(
		\type, \note,
		\instrument, \iter,
		//c varies the speed of the note
		\dur, 0.2-Pfunc({c}),
		\amp, 1,
		//random pan
		\pan, Pwhite(-0.9,0.9, inf),
		//a and b transpose the notes
		\midinote, Pfunc({a})*Pseq([60,64,69,38], inf)-Pfunc({b}),
		//add randomized overtones from the midinotes
		\harmonic, Pexprand(1,4, inf).round.trace,

	);
)
)
(
z=Pdef(
	\pattern3,
	Pbind(
		\type, \note,
		\instrument, \iter,
		//duration is not constant
		\dur, Pseq([0.4,0.4,0.4,0.2,0.2,0.4,0.2,0.2,0.4],inf),
		\amp, 0.8,
		\atk, 0.01,
		\pan, Pseq([-0.99,0.99],inf),
		\rel, 0.1,
		//alternative timbre
		\width, 0.04,
		\midinote, Pfunc({a})*Pseq([81,64,69,71,71,50,60,64,53], inf)-Pfunc({b}),

	);
)
)
//transposition multiplier = 1
a = 1;
//semitone transposition = 0
b = 0;
//spped increase = 0
c = 0;
//play first synth
x.play;
//stop first synth
x.stop;
//play second synth
y.play;
//stop second synth
y.stop;
//play third synth
z.play;
//stop third synth
z.stop;
//transposition multiplier = 0.75 to all midinotes
a= 0.75;
//transpose all midi notes 4 semitones down
b = 4;
//increase speed of pattern2
c = 0.1;


