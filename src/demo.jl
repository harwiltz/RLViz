export make_gif, make_gif_from
export make_flat_demo, make_flat_demo_from

using ReinforcementLearning

function make_gif(pi::AbstractPolicy, env::AbstractEnv; len = 10_000, path="/tmp/demo.gif")
    reset!(env)
    score = 0
    anim = @animate for _ in 1:len
        a = pi(env)
        env(a)
        score = score + reward(env)
        plot(env)
        if is_terminated(env)
            break
        end
    end every 5
    println("Score: $(score)")
    gif(anim, path)
end

make_gif_from(ex::Experiment; len = 10_000, path="/tmp/demo.gif") =
    make_gif(ex.policy, ex.env; len = len, path = path)

function make_flat_demo(pi::AbstractPolicy, env::AbstractEnv; skip = 5, len = 10_000)
    reset!(env)
    plot(env, alpha=0.1)

    len′ = Int(floor(len / skip))

    score = 0f0

    k = 0.6 / len′
    
    for i in 1:len′
        for _ in 1:skip
            a = pi(env)
            env(a)
            score = score + reward(env)
        end
        α = min(1f0, 0.1 + k^2 * i)
        plot!(env, alpha=α)
    end
    plot!(env)
    println("Score: $(score)")
    gui()
end

make_flat_demo_from(ex::Experiment; len = 10_000, skip = 5) =
    make_flat_demo(ex.policy, ex.env; len = len, skip = skip)
