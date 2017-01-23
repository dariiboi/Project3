
(
y=Env.new([0.1,1,0.2,0.01],[0.5,1,2],\exp);
x = {
	var sig, env, freq1;
	freq1 = ExpRand(80, 80*10).round(80);
	env = EnvGen.kr(y,doneAction:2);
	sig = Pulse.ar(freq1)*env;
}.play;
)

Env.new([0.01,1,0.2,0.01],[0.5,1,2], \exp).plot;