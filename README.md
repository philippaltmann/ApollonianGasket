# ApollonianGasket

## Project setup
```
yarn install
```

### Compiles and hot-reloads for development
```
yarn run serve
```

### Run the Prolog API 
```
yarn run api
```

### Compiles and minifies for production
```
yarn run build
```

### Run your tests
```
yarn run test
```

### Lints and fixes files
```
yarn run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

## Time & Performance Measures:
```
?- statistics(walltime, [TimeSinceStart | [TimeSinceLastCall]]),
    writeGasket((550, 400, 140.68037487175553),(820, 450, 133.91022948316407),(650, 650, 128.57786548496966), 12, '../../public/gasket.json'),
    statistics(walltime, [NewTimeSinceStart | [ExecutionTime]]),
    write('Execution took '), write(ExecutionTime), write(' ms.'), nl.
```

fetch
1 17 | 0
2 13 | 0
3 8 | 0
4 21 | 0
5 32 | 1
6 71 | 3
7 178 | 7
8 563 | 17
9 1551 | 46
10 4263 | 122
11 13411 | 398
12 39393 | 1081


### Results:
Execution Times in Milliseconds
Tau Custom : Write to Webstorage instead of Direct return
<!-- |    | Execution Time [ms]                 |||   |  |  | -->
|Depth    | SWIPL | SWIPL HTTP | Tau-Custom | Tau-Prolog | Num Circles | Load JSON | Draw |
|--------:|------:|-----------:|-----------:|-----------:|------------:|----------:|-----:|
|  1      |     1 |         17 |        100 |         74 |           2 |        41 |    1 |
|  2      |     1 |         13 |        246 |        208 |           8 |        33 |    0 |
|  3      |     1 |          8 |       1068 |        714 |          26 |        19 |    0 |
|  4      |     3 |         21 |       5316 |       3255 |          80 |        25 |    0 |
|  5      |     8 |         32 |      46297 |      31995 |         242 |        38 |    1 |
|  6      |    20 |         71 |     921455 |     601856 |         728 |        33 |    2 |
|  7      |    74 |        178 | _OoR_      | _OoR_      |        2186 |        31 |    8 |
|  8      |   180 |        563 | _OoR_      | _OoR_      |        6560 |        53 |   18 |
|  9      |   656 |       1551 | _OoR_      | _OoR_      |       19682 |       101 |   43 |
| 10      |  1373 |       4263 | _OoR_      | _OoR_      |       59048 |       228 |  125 |
| 11      |  7618 |      13411 | _OoR_      | _OoR_      |      177146 |       412 |  375 |
| 12      | 15276 |      39393 | _OoR_      | _OoR_      |      531440 |      1119 |  926 |
| 13      | _OoS_ | _OoS_      | _OoR_      | _OoR_      | ----------- | --------- | ---- |

_OoS_: Out of Global Stack (SWIPL Error)

_OoR_ : Out of Range (Execution >> 15 Minutes)
