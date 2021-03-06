function sc = ApplyDetectorAdapted(Cparams, patch, sigma, mu, L)

    sc = 0;
    for t = 1:length(Cparams.alphas)

        % Feature response
        switch Cparams.all_ftypes(Cparams.Thetas(t,1))
            case 3
                f = patch(:)' * ((Cparams.fmat(:,Cparams.Thetas(t,1)) - mu * Cparams.all_ftypes(Cparams.Thetas(t,1),4)*Cparams.all_ftypes(Cparams.Thetas(t,1),5)) / sigma);
            case 4
                f = patch(:)' * (Cparams.fmat(:,Cparams.Thetas(t,1)) / sigma);
            case 2
                f = patch(:)' * (Cparams.fmat(:,Cparams.Thetas(t,1)) / sigma);
            case 1
                f = patch(:)' * (Cparams.fmat(:,Cparams.Thetas(t,1)) / sigma);
        end
        % Parity
        p = Cparams.Thetas(t,3);
        % threshold
        theta = Cparams.Thetas(t,2);
        % score
        sc = sc + Cparams.alphas(t) * h(f,p,theta);
    end
end

% Weak classifier.
function cls = h(f,p,theta)
    cls = p.*f < p*theta;
end

