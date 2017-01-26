//Demo of random numbers, arrays, duplication, evelopes, and oscillation
//press shift + enter over s.boot to boot server (necessary)
s.boot;
(
SynthDef.new(\multi, { //this line defines a new synthesizer \multi meaning multi channel
	var sig, amp, env; //the synth signal, amplitude, and evelope respectively
	env = EnvGen.kr(// define the envelope:
		Env.new([0,1,0],[10,10],[1,-1]),doneAction:2);//attack and release 10.

	amp = SinOsc.kr({ExpRand(0.5,50)}!8).range(0,1);//create an array of
	// 8 random frequencies  between 0.5 and 50 to oscillate the volume of the synth to.

	sig = SinOsc.ar({ExpRand(40,1700)}!8);//makes an arrays of 8 synths which have random frequency.
    sig = sig*amp*env;//multiply synth frequency with oscillation frequency with envelope
	//splay takes an 8 channel output and compresses it to 2 channels (l and r)
	sig = Splay.ar(sig) * 0.5;
	Out.ar(0,sig);
}).add;
)

x = Synth.new(\multi);//to play the sounds first shift return on the .add then shiftreturn  on this line above
x.free;//shift return here to STOP