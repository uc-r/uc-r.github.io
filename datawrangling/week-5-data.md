---
layout: tutorial
title: NULL
permalink: data_wrangling/week-5-assignment-data
---

The following provides a short description of the variables in each data sets provided for week 5's homework:

__Bomber data sets:__ These data provide the following information regarding the United States Air Force bomber aircraft:

- Type: Represents the type of aircraft. In this case, all aircraft in these data sets are United States Air Force [bomber aircraft](https://en.wikipedia.org/wiki/List_of_United_States_bomber_aircraft).
- MD: Represents the "Mission Design." The letter represents the basic mission of the aircraft (B for bomber) and the number represents the design number.  So all aircraft with a B are bombers but a [B-1](https://en.wikipedia.org/wiki/Rockwell_B-1_Lancer) is different than a [B-2](https://en.wikipedia.org/wiki/Northrop_Grumman_B-2_Spirit) which is different than a [B-52](https://en.wikipedia.org/wiki/Boeing_B-52_Stratofortress).
- FY: Fiscal year. The data available ranges from fiscal year 1996-2014.
- Cost: Represents the total operational cost for flying, maintaining, repairing, and managing the aircraft.
- FH: Represents the flying hours, which is the total time the aircraft is in the air flying a mission or in training.
- Gallons: Represents the total gallons of fuel burned by the aircraft.

__ws_programmatics:__ This data provides weapon system programmatics information:

- Base: Represents the Air Force installation. Provides the name of the installation followed by the state the base is located in.
- MD: Represents the "Mission Design." The letter represents the basic mission of the weapon system (A for attack, C for cargo, B for bomber, F for fighter, etc) and the number represents the design number.
- Manpower_Ops: Represents cost of pilots and operators required to operate the weapon system
- Manpower_Mx: Represents cost of maintenance personnel required to maintain the weapon system
- Manpower_Support_Staff: Represents cost of support staff required to support the weapon system
- Operating_Material: Represents cost of operating material such as fuel, oil, etc. required to run the weapon system
- Mx_Consumables: Represents cost of small consumable parts (nuts, bolts, wire, etc.) required to maintain the weapon system
- Mx_DLR: Represents cost of large parts (engine fans, aircraft seats, etc.) required to maintain the weapon system
- Mx_Depot: Represents cost of sending the weapon system to the depot for a large scale maintenance check.
- CLS: Represents cost of contractor logistics support services
- Total_O.S: Represents the total operational cost for flying, maintaining, repairing, and managing the aircraft (summation of all previously outlined cost elements).
- Avg_Inv: Represents total number of weapon systems at the specified location
- TAI: Represents total authorized weapon systems at the specified location
- End_Strength: Represents total personnel (head count) operating and supporting the weapon system at the specified location
- FH: Represents the flying hours, which is the total time the aircraft is in the air flying a mission or in training.


__ws_categorization:__ This data provides the system categorization for each aircraft:

- Base: Represents the Air Force installation. Provides the name of the installation followed by the state the base is located in.
- System: Represents the system classification of the weapon system. The major classifications for the different weapon systems includes *aircraft, missiles, munitions, space systems, ground control,* and *other*.
- MD: Represents the "Mission Design." The letter represents the basic mission of the weapon system (A for attack, C for cargo, B for bomber, F for fighter, etc) and the number represents the design number.
