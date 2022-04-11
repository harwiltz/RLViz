export continue_ex

using ReinforcementLearning

function continue_ex(ex::Experiment, steps::Int)
    sc = StopAfterStep(steps)
    Experiment(ex.policy, ex.env, sc, ex.hook, "")
end
