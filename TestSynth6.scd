
(
SynthDef.new(\iter, {
	arg baseFreq = 440, out=20;
	var temp, sig, env;
	env = EnvGen.kr(
		Env.perc(0.01,3,1,-4),doneAction:2);
	sig = 0;
	10.do{
		temp = VarSaw.ar(baseFreq*{Rand(0.99,1.01)},{Rand(0,1)},{Rand(0,1)});
		sig = sig +temp*env;
	};
	//sig = Mix.ar(sig);
	sig = Splay.ar(sig)*4;
	sig = sig*0.03;
	Out.ar(out,sig);

}).add;

SynthDef.new(\reverb, {
	arg in;
	var sig;
	sig =In.ar(in,2);
	sig = FreeVerb.ar(sig,0.5,0.8,0.2)!2;
	Out.ar(0, sig);
}).add;
)

(
y=Synth.new(\reverb,[\in,20]);
x=[88,66,50,57].do{
	arg midiNote;
	Synth.new(\iter,[\baseFreq,midiNote.midicps]);
}
)
(
y=Synth.new(\reverb,[\in,20]);
x=[78,61,50,27].do{
	arg midiNote;
	Synth.new(\iter,[\baseFreq,midiNote.midicps]);
}
)

