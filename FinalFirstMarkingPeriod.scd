
(
SynthDef.new(\iter, {
	arg freq = 440,atk = 0.007, rel = 1, amp = 0.7, pan =0;
	var temp, sig, env;
	env = EnvGen.kr(Env.new([0,1,0],[atk,rel],[1,-1]),doneAction:2);
	sig = 0;
	4.do{
		temp = VarSaw.ar(freq*{Rand(0.99,1.02)},{Rand(0,1)},{ExpRand(0.4,0.5)}!2);
		sig = sig + temp*env;
	};
	sig = Pan2.ar(sig,pan,amp);
	sig = Splay.ar(sig)*0.2;
	sig = FreeVerb.ar(sig,0.6,0.8,0.2);
	Out.ar(0,sig);
}).add;
)
(
x=Pdef(
	\pattern1,
	Pbind(
		\type, \note,
		\instrument, \iter,
		\dur, 0.2,
		\atk, Pseq([0.007,0.07,0.7,1],inf),
		\amp, 1,
		\midinote, Pfunc({a})*Pseq([60,64,69 ,76], inf)-Pfunc({b}),
	);
)
)
(
Pdefn(\midinote, Pn(Pseq([60,64,69,38], inf)));
y=Pdef(
	\pattern2,
	Pbind(
		\type, \note,
		\instrument, \iter,
		\dur, 0.2-Pfunc({c}),
		\amp, 1,
		\pan, Pwhite(-0.9,0.9, inf),
		\midinote, Pfunc({a})*Pseq([60,64,69,38], inf)-Pfunc({b}),
		\harmonic, Pexprand(1,4, inf).round.trace,

	);
)
)
a = 1;
b = 0;
c = 0;
x.play;
y.play;
a= 0.75;
b = 4;
c = 0.1;

