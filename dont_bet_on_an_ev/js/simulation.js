addSimulation({name: "time", title: "Time average", n_max: 500, n_players: 1});
addSimulation({name: "ensemble", title: "Ensemble average"});

function addSimulation(options) {
    const {name, title, n_max = 500, n_players = n_max * 1000, w0 = 1, odds = 0.5, multiplier_loss = 0.6,  multiplier_win = 1.5} = options
    let play = false;
    let stop = false;

    let step = 0;
    let ev = w0;
    
    document.getElementById("startAnimation-" + name).addEventListener("click", () => {
        play = true;
    }); 
    document.getElementById("pauseAnimation-" + name).addEventListener("click", () => {
        play = false;
    });
    document.getElementById("stopAnimation-" + name).addEventListener("click", () => {
        stop = true;
    });

    const vlSpec = {
        $schema: 'https://vega.github.io/schema/vega-lite/v4.json',
        title: {
            text: title,
        },
        data: {
            name: name
        },
        padding:
        {"left": 50, "top": 5, "right": 5, "bottom": 5},
        width: "container",
        height: 250,
        config: {
            background: "#fffff8"
        },
        mark: {
            type: "line",
            tooltip: true
        },
        encoding: {
            x: {
                field: 'x',
                type: 'quantitative',
                scale: {domain: [0, n_max]},
                title: "n bets"
            },
            y: {
                field: 'y',
                type: 'quantitative',
                scale: {type: "log"},
                title: "Wealth Wn"
            }
        }
    };

    vegaEmbed("#chart-" + name, vlSpec, {actions: false}).then(function(res) {
        function bet(wealth) {
            let new_wealth = 0;

            if (Math.random() < odds) {
                new_wealth = wealth * multiplier_loss;
            } else {
                new_wealth = wealth * multiplier_win;
            }
            
            return new_wealth
        }

        function ensemble_average(wealths) {
            let total = 0;
            for(let i = 0; i < wealths.length; i++) {
                total += wealths[i];
            }
            
            return (total / wealths.length);
        }
        
        function simulation_generator() {
            let counter = -1;
            let previousY = Array.from({length: n_players },
                                       (v, i) => w0);
            
            return () => {
                let wealths = previousY.map((v, c) => {
                    return bet(v)
                });

                previousY = wealths;
                
                return wealths;
            };
        }

        let simulation = simulation_generator();
        
        window.setInterval(function() {
            if (stop) {
                step = 0;
                play  = false;
                stop = false;

                simulation = simulation_generator();
                let changeSet = vega
                    .changeset()
                    .remove(() => true)
                res.view.change(name, changeSet).run();
            }
            
            if (step <= n_max && play) {
                wealths = simulation();
                ev = ensemble_average(wealths);
                
                let changeSet = vega
                    .changeset()
                    .insert({x: step,
                             y: ev,
                             category: 0})
                res.view.change(name, changeSet).run();
                step++;
            }
        }, 50);
    });
}
