function [theta, p, err] = LearnWeakClassifier(ws, fs, ys)

    a = ws .* ys;
    b = ws .* (1-ys);
	mu_p = sum(a .* fs) / sum(a);
	mu_n = sum(b .* fs) / sum(b);

	theta = .5 * (mu_p + mu_n);

	errs(1) = sum(ws .* abs(ys - h(fs,-1,theta)));
	errs(2) = sum(ws .* abs(ys - h(fs,1,theta)));

	[err, ind] = min(errs);

	p = sign(ind - 1.1);  

end


function cls = h(f,p,theta)
	cls = p.*f < p*theta;
end
