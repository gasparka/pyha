# intro

Pyha is a project that simplifies development/testing of hardware with Python.

Main function for main entrance...however you can make more functions if needed.


# demo 1 -> FIR MODEL MAIN, muud asjad on hidden

Main design unit is a Python class.
Currently focus on 

* Fir filter -> Usual demo.
* Golden reference -> Pyha has this merged into the main design unit.
* Unit testing -> Edge cases..


'Main' has the hardware implementation but before details i want to talk about testing, 
which i think is the best part of Pyha. Will later show that you can pass much complex
objects into the simulator.

Go over different simulations.

HW simulatsiooni juures peaks katma:
**Debugging?**
**Fixed point?**
**Registers?**

# demo 2 - component reuse

Make FIR instances and connect in parallel and serial.

Maybe implementing the FIR in hardware is harder than in 
software(show scipy implementaion?, that may actullay be harder) but using the already implemented
component is easy in Pyha.

One thing i wanted to simplify in hardware desing was component reuse.

Show CORDIC?



# limitations and problems

Clock domains -> show in next video.

Resource sharing -> Convert to HLS? Soma ways possible in Pyha.

Micrpython -> would be cool.