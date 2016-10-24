#!/usr/bin/ruby
# vim: set sw=4 sts=4 et tw=80 :

require 'bigdecimal'

ps = ARGV[0].to_i
ts = ARGV[1].to_i

0.upto(ps - 1) do | x |
    pd = BigDecimal.new(x) / BigDecimal.new(ps - 1);

    tdupper = 500
    tdlower = 0
    expsols = 0

    0.upto(100) do | y |
        td = BigDecimal.new(tdupper + tdlower) / 1000;

        cliqueedges = BigDecimal.new(ps * (ps - 1) / 2);
        nedges = pd * cliqueedges;
        nnonedges = (1 - pd) * cliqueedges;

        edgesokprob = td ** nedges;

        solprob = edgesokprob;

        nstates = BigDecimal.new(1);
        1.upto(ps) do | n |
            nstates *= (ts - n + 1);
        end

        expsols = nstates * solprob;

        if (expsols < 1)
            tdlower = (tdupper + tdlower) / 2
        elsif (expsols > 1)
            tdupper = (tdupper + tdlower) / 2
        else
            break
        end
    end

    puts(pd.to_f.to_s + " " + ((tdupper + tdlower) / 1000.0).to_s + " " + expsols.to_s)
end

