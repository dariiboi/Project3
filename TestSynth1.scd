(
z = {
	arg noiseHz=3;
	var freq, sig, amp;
	freq = LFNoise0.kr(8).exprange(100,1000);
	amp = LFNoise1.kr(12).exprange(0.02,1);
	sig = SinOsc.ar(freq,noiseHz,1,0)*amp;
}.play;
)
z.set(\noiseHz,290);
z.free;