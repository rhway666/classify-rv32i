# Assignment 2: Classify

TODO: Add your own descriptions here.
## Part A:
### abs
The abs function calculates the absolute value of an integer. The implementation involves loading the value from memory, checking if it is negative, and if so, it substraces zero. The final value is then stored back in memory. This approach ensures that the input value is transformed to its non-negative equivalent.
### argmax
The argmax function scans an integer array to find its maximum value and returns the index of its first occurrence. The implementation begins by loading the first element as the initial maximum value (t0) and initializes the maximum index (t1). It then iterates through the array using a loop, loading each element and comparing it to the current maximum. If a larger value is found, the maximum value and index are updated. Finally, it returns the index of the maximum element.
### dot
The dot function calculates the dot product of two arrays, considering different strides for each array. The implementation involves iterating through the elements, calculating their product, and accumulating the results. A custom multiplication loop was added to replace the mul instruction to adhere to RV32I constraints, ensuring compatibility with the instruction set.
### matmul
The implementation uses an output stationary data flow and applies dot.s in the inner loop. The inner loop iterates through the entire column, using dot.s with a stride of 1 for matrix A and a stride equal to the column number for matrix B. So we have to Move matirxA memory address to the next row after the iteration of inner loop is done and and the output martix count. After the outer loop is done we have too load the callee registers back.
### relu
The loop iterates through each element, loads the value, and compares it with zero. If the value is greater than zero, it remains unchanged; otherwise, it is updated to zero. This ensures that all negative values in the array are replaced with zeros, following the ReLU activation behavior.

## Part B:
### read_matrix

### write_matrix
