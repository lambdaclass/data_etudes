add_simulation("time", "Time average", 500, 1);
add_simulation("ensemble", "Ensemble average");

function add_simulation(name, title, n_max = 500, n_players = n_max * 1000, w0 = 1, odds = 0.5, multiplier_loss = 0.6,  multiplier_win = 1.5) {
    
    var play = false;
    var stop = false;

    var step = 0;
    var ev = w0;
    update_average(ev);

    document.getElementById("startAnimation-" + name).addEventListener("click", function(){
        play = true;
    }); 
    document.getElementById("pauseAnimation-" + name).addEventListener("click", function(){
        play = false;
    });

    document.getElementById("stopAnimation-" + name).addEventListener("click", function(){
        stop = true;
    });

    function update_average(value) {
        var element = document.getElementById("show-" + name);
        element.innerHTML = value.toFixed(2);
    }

    var vlSpec = {
        $schema: 'https://vega.github.io/schema/vega-lite/v4.json',
        title: {
            text: title,
        },
        data: {name: name},
        padding: 20,
        width: "container",
        height: 250,
        config: {
            background: "#fffff8"
        },
        mark: 'line',

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

            var new_wealth = 0;

            if (Math.random() < odds) {
                new_wealth = wealth * multiplier_loss;
            } else {
                new_wealth = wealth * multiplier_win;
            }
            
            return new_wealth
        }

        function ensemble_average(wealths) {
            var total = 0;
            for(var i = 0; i < wealths.length; i++) {
                total += wealths[i];
            }
            
            return (total / wealths.length);
        }
        
        function newGenerator() {
            var counter = -1;
            var previousY = Array.from({length: n_players }, (v, i) => w0);
            
            return function() {
                var wealths = previousY.map(function(v, c) {
                    return bet(v)
                });

                previousY = wealths;
                
                return wealths;
            };
        }

        var valueGenerator = newGenerator();
        
        window.setInterval(function() {
            if (stop) {
                step = 0;
                play  = false;
                stop = false;
                update_average(w0);

                valueGenerator = newGenerator();
                var changeSet = vega
                    .changeset()
                    .remove(function(){return true;})
                res.view.change(name, changeSet).run();
            }
            
            if (step <= n_max && play) {
                
                wealths = valueGenerator();
                ev = ensemble_average(wealths);
                update_average(ev);
                
                var changeSet = vega
                    .changeset()
                    .insert({x: step, y: ev, category: 0})
                res.view.change(name, changeSet).run();
                step++;
            }

        }, 50);
    });
}
