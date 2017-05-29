# BattleshipAI

A 0/1/2-player battleship game implemented in Ruby:

**Features**

* Random placement of ships for both players
* Human vs human mode
* Human vs PC mode
* PC vs PC mode
* PC guessing algorithm
* Continuous play option

**To Play**

* Clone or download repository
* With Ruby installed on your machine, navigate to directory of app.rb
  > ruby app.rb

**PC vs PC Mode**

* When asked 'Will you play the PC? (yes/no)' reply:
  > pcpc

![](res/Ruby_BSAI.gif "BattleshipAI in Ruby")

**PC Guessing**

PC players will randomly choose a coordinate pair on the opposing player's game board that has not yet been fired at. In the event of a hit, the PC player will add the adjacent (not yet fired upon) 4 coordinate pairs to a queue. When another hit occurs along the same ship's segment, the adjacent (4 - 1) coordinate pairs are added to the queue. Random guessing occurs again once an entire ship of the opponent's board is hit and surrounded by misses.

![](res/Hits.gif "Hits Surrounded By Misses")

---

© 2016 [Matt D'Arcy](http://linkedin.mathewdarcy.com), shared under the [MIT License](http://www.opensource.org/licenses/MIT).
