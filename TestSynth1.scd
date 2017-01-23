(
z = {
	arg noiseHz=3;
	var freq, sig, amp;
	freq = LFNoise0.kr(8);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq)*amp;
}.play;
)

z.free;

(
SynthDef.new(\sineTest, {
	arg noiseHz=8;
	var freq, sig, amp;
	freq = LFNoise0.kr(noiseHz).exprange(100,1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq)*amp;
	Out.ar(0,sig);
}).add
)

x= Synth.new(\sineTest,[\noiseHz,3]);
