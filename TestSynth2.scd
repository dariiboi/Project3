(
SynthDef.new(\PrettySounds, {
	arg ampHz=4, baseFreq = 40, maxMultiplier = 6, width = 1;
	var amp1,amp2,freq1,freq2,sig1,sig2;
	amp1=LFPulse.kr(ampHz, 0, 0.82);
	amp2=LFPulse.kr(ampHz, 0.5, 0.82);
	freq1=LFNoise0.kr(8).exprange(baseFreq, baseFreq*maxMultiplier).round(baseFreq);
	freq2=LFNoise0.kr(8).exprange(baseFreq, baseFreq*maxMultiplier).round(baseFreq);
	freq1 =freq1 * LFPulse.kr(8,add:1);
	freq2 = freq2 * LFPulse.kr(6,add:1);
	sig1 = SinOsc.ar(freq1,width,amp1);
	sig2 = SinOsc.ar(freq2,width,amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8,0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8,0.25);
	Out.ar(0,sig1);
	Out.ar(1,sig2);
}).add
)

x= Synth.new(\PrettySounds);
x.set (\baseFreq,50);
x.set(\maxMultiplier, 6);
x.set(\ampHz, 1);
x.set(\maxMultiplier, 10);
x.free;