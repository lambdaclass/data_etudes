To play or not to play?
-----------------------

Imagine a game where you toss a fair coin and bet an initial wealth
$w_0$. If it comes up heads your monetary wealth increases by 50%;
otherwise, it is reduced by 40%. You're not only doing this once, but
many times; for example, once per week for the rest of your life. Would
you accept the rules of our game? Would you play this game if given the
opportunity?
    
Solution
--------

Every run of the game is independent and success equally likely. Thus
$X_i$, a random variable returning 1 on success and 0 on failure, is
nothing else than a $Bernoulli(1/2)$. $X_n$, the random variable that
counts the number of successful outcomes in $n$ runs of the game, would
be defined as: $$X_n = \sum\limits_{k=1}^{n} X_i$$

Then $X_n \sim Bin(n, 1/2)$.

After $n$ coin tosses, our random variable final wealth $W_n$ can be
modeled as:
$$\begin{aligned}
    \begin{equation*}
      W_n = w_0 \left(1.5^{X_n}\right)\left(0.6^{n-X_n}\right)
    \end{equation*}
  \end{aligned}$$

In order to decide if we would accept to play this game for the rest of
our lives we have to check how $W_n$ behaves when
$n \rightarrow \infty$.\
\
Let's rearrange things a bit, apply $log()$ on both sides to make things
simpler and then take the limit, which we'll later use to make
deductions on $W_n$ itself:

$$\begin{aligned}
    \begin{equation*}
        W_n = w_0 \left(\left(1.5/0.6\right)^{X_n}\right) \left(0.6^{n}\right)
    \end{equation*}\end{aligned}$$
$$\begin{aligned}
    \begin{equation*}
        \log{W_n} = \log{\left[w_0 \left(1.5/0.6\right)^{X_n} \left(0.6^{n}\right)\right]}
  \end{equation*}
  \end{aligned}$$ 
$$\begin{split}
     \lim_{n\to\infty} \log{W_n} &= \lim_{n\to\infty} \log{\left[w_0 \left(1.5/0.6\right)^{X_n} \left(0.6^{n}\right)\right]}\\
    &= \log{w_0} + \lim_{n\to\infty} \log{\left(1.5/0.6\right)^{X_n}} + \log{0.6^{n}}\\
    &= \log{w_0} + \lim_{n\to\infty} X_n \log{\left(1.5/0.6\right)} + n \log{0.6}\\
    &= \log{w_0} + \lim_{n\to\infty} n \left(\tfrac{X_n}{n} \log{\left(1.5/0.6\right)} + \log{0.6}\right)\\
  \end{split}$$

Thanks to the Strong Law of Large Numbers we know that
$$\lim_{n\to\infty}{\frac{X_n}{n} = \mathbb{E}[X_i] = p = \frac{1}{2}}$$
almost surely (i.e. with probability equal to 1). So, as a consequence:
$$\begin{split}
      \lim_{n\to\infty} \log{W_n} &= \log{w_0} + \lim_{n\to\infty} n \left(\tfrac{X_n}{n} \log{\left(1.5/0.6\right)} + \log{0.6}\right) \\
      &= \log{w_0} + \lim_{n\to\infty} n \left(\tfrac{1}{2} \log{\left(1.5/0.6\right)} + \log{0.6}\right) \\
      &= \log{w_0} + \lim_{n\to\infty} n \left(\log{\left(1.5/0.6\right)^{1/2}} + \log{0.6}\right) \\
      &= \log{w_0} + \lim_{n\to\infty} n \log{\left(\sqrt{\left(1.5/0.6\right)} \cdot 0.6\right)}\\
      &= \log{w_0} + \lim_{n\to\infty} n \log{\left(\sqrt{\left(1.5/0.6\right) \cdot 0.6 \cdot 0.6}\right)}\\
      &= \log{w_0} + \lim_{n\to\infty} n \log{\left(\sqrt{1.5 \cdot 0.6}\right)}\\
      &= \log{w_0} + \lim_{n\to\infty} n \log{\left(\sqrt{0.9}\right)}\\
      &\approx \log{w_0} + \lim_{n\to\infty} n \log{0.95}\\
      &\approx \log{w_0} + \lim_{n\to\infty} n \cdot \left(-0.0229 \right) \\
      &= -\infty
  \end{split}$$

Now, since: $$\begin{aligned}
    \begin{equation*}
        \lim_{n\to\infty} \log{W_n} = -\infty
    \end{equation*}    \end{aligned}$$

we can finally conclude: $$\begin{aligned}
    \begin{equation*}
        \lim_{n\to\infty} {W_n} = 0
    \end{equation*}    \end{aligned}$$

Our wealth will decrease to 0 when $n\to\infty$ regardless of our
starting wealth. The answer to our initial question should be: no, I do
not want to play since I'm certain to go bust.

<div class="button-container-time">
<button id="startAnimation-time">Play</button>
<button id="pauseAnimation-time">Pause</button>
<button id="stopAnimation-time">Stop</button>
</div>
<div class="chart-container">
<div id="chart-time" style="width: 100%;"></div>
</div>

The expected value
------------------

A common erroneous way of approaching the problem is to calculate the
expected value of your wealth: $$\begin{split}
    \mathbb{E}[W_n] &= \mathbb{E}[w_0 \left(1.5^{X_n}\right) \left(0.6^{n-X_n}\right)]\\
    & = w_0  \left(0.6^n\right) \left(\mathbb{E}[(1.5/0.6)^{X_n}]\right)\\
    & = w_0 \left(0.6^n\right) \left(\mathbb{E}[(2.5)^{X_n}]\right)
  \end{split}$$

To calculate the expected value of $k^X$, we'll use the theorem known as
the Law of the Unconscious Statistician for discrete random variables:
$$\mathbb{E}[g(X_n)] = \sum\limits_{x \in X_n} g(x_i) p_X(x_i)$$

With the binomial pmf being: $$p_X(x) = {n \choose x} p^x (1-p)^{n-x}$$

Then, seeing that the sum is nothing else than Newton's binomial formula
for the expansion of $(a+b)^n$: $$\begin{split}
    \mathbb{E}[(2.5)^{X_n}] &= \sum\limits_{x=0}^{n} 2.5^x {n \choose x} p^x (1-p)^{n-x}\\
    &= \sum\limits_{x=0}^{n} {n \choose x} (2.5p)^x (1-p)^{n-x}\\
    &= (2.5p + 1 - p)^n \\ 
    &= (2.5 \cdot \dfrac{1}{2} + 1 - \dfrac{1}{2})^n\\
    & = 1.75^n
  \end{split}$$

Finally: $$\begin{split}
    \mathbb{E}[W_n] &= w_0 \left(0.6^n\right) \left(\mathbb{E}[(2.5)^{X_n}]\right)\\
    &= w_0 \left(0.6^n\right) \left(1.75^n\right)\\
    &= w_0 \cdot 1.05^n
  \end{split}$$

This might lead us to conclude that the gamble is worth taking since we
$expect$ our wealth to increase indefinitely at a rate of $1.05$ every
time we flip the coin. Actually, we've already proven before that is not
true at all.\
\
Expected value won't tell us if a gamble is worth taking. It tells us
what would happen on average if a group of people were to take the bet
on parallel, and there are some conditions that need to be satisfied to
be certain that this coincides with what will happen to one individual
taking the bet repeatedly over time. The expected value, or ensemble
average, tell us what would happen to an individual in multiple parallel
universes and not what would happen to an individual over time.

<div class="button-container-ensemble">
<button id="startAnimation-ensemble">Play</button>
<button id="pauseAnimation-ensemble">Pause</button>
<button id="stopAnimation-ensemble">Stop</button>
</div>
<div class="chart-container">
<div id="chart-ensemble" style="width: 100%;"></div>
</div>

Repetition matters
------------------

Calculating the average return of a hundred people that go to the casino
one night and place just one bet is not the same than calculating
what happens to the wealth of an individual who visits the casino a
hundred times in a row. Nowadays we use the average return of a hundred people going
to the casino once to predict what would to a person going over and over again.
The problem does not lie with the expected value per se but with the interpretation 
we assign to it.

The consequences of this error in microeconomics, macroeconomics, psychology and
game theory are enormous. Any conclusion that uses the ensemble average
instead of the time average should be taken with great caution. New behavioral experiments show
that agents prefer their wealth to grow faster and that this preference is stable. That 
means that they prefer to maximize the time average. Maximizing the expected value can not be
considered rational for an individual. Adding arbitrary utility functions on top of this 
error does not solve it.

The error of using ensemble average instead of time averages has been propagated for the last
two hundred years. Claude Shannon, Edward Oakley Thorp and John Larry Kelly Jr, fathers of
information theory, and Harald Cramér, father of insurance mathematics, were exceptions
in that they did not make the same mistake.

Ole Peters was the first to systematize, generalize and extend the study of economic theory without parallel
universes. With Murray Gell-Mann, Nobel prize winner and founder of modern particle physics, he co-authored a 
paper on the time resolution of the St. Petersburg paradox. The London Mathematical Laboratory,
where Ole Peterss is a fellow, has published the incredibly profound
[lecture notes](https://ergodicityeconomics.com/lecture-notes/) on this subject. Young economists who are eager
to study economics with solid foundations should read it.

Bibliography
------------

- [The Logic of Risk Taking](https://medium.com/incerto/the-logic-of-risk-taking-107bf41029d3) - Nassim Nicholas Taleb

- [Time to move beyond average thinking](https://www.nature.com/articles/s41567-019-0758-3) - Nature Physics volume

- [The ergodicity problem in economics](https://www.nature.com/articles/s41567-019-0732-0) - Ole Peters

- [The time resolution of the St. Petersburg paradox](https://arxiv.org/abs/1011.4404) - Ole Peters

- [Evaluating gambles using dynamics](https://arxiv.org/abs/1405.0585) - Ole Peters, Murray Gell-Mann

- [Optimal leverage from non-ergodicity](https://arxiv.org/abs/0902.2965) - Ole Peters

- [A New Interpretation of Information Rate](https://www.princeton.edu/~wbialek/rome/refs/kelly_56.pdf) - John Kelly

- [The Kelly Criterion in Blackjack, Sports Betting, and the Stock Market](https://www.researchgate.net/publication/247922818_The_Kelly_Criterion_in_Blackjack_Sports_Betting_and_the_Stock_Market) - Eduward Oakley Thorp

- [Ergodicity-breaking reveals time optimal economic behavior in humans](https://arxiv.org/abs/1906.04652) - David Meder, Finn Rabe, Tobias Morville, Kristoffer H. Madsen, Magnus T. Koudahl, Ray J. Dolan, Hartwig R. Siebner, Oliver J. Hulme

