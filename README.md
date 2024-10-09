## Starvation
This contract demonstrates the possibility of calling the maximum amount of assertion adopters within one transaction.
This is a specific attack to the credible layer in which as many as possible assertion adopters are called in a 
single transaction.

Assertion adopters are stored in a linked set, which is technically a set structure (No entry can be there twice).

By sending 1 Wei to each assertion adopter, it is the minimum attack cost to require a validation of assertions by
the assertion enforcer.

The tests are mainly used to display the gas usage of transactions depending on the number of registered assertion
adopters.
It shows that the correct formula is:

$` N = (G_b - 20000) / G_c `$

## How to run

run

`forge test --isolate` 

(--isolate will treat top level calls as actual transactions to a separate EVM thus adding 20k gas for each call)

Expected result:
```
Ran 5 tests for test/Starvation.t.sol:StarvationTest
[PASS] test_StarvationFiveHundred() (gas: 5857155)
[PASS] test_StarvationHundred() (gas: 1190355)
[PASS] test_StarvationOne() (gas: 35673)
[PASS] test_StarvationTen() (gas: 140325)
[PASS] test_StarvationZero() (gas: 28292)
```

You can see that relative cost to number of adopters decreases over time,approaching ~11.7k asymptotically.

## Optimizations
The tx cost mainly come from reading storage during the execution of the attack. This cost can be significantly 
reduced by using calldata for the assertion adopter addresses (It's actually quite inefficient to store these values
in storage). Calldata consume much less gas than reading from cold storage.