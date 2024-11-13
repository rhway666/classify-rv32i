.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate
    blt a3, t0, error_terminate
    blt a4, t0, error_terminate

    li t0, 0    # t0 = final result
    li t1, 0    # t1 = count index i

loop_start:
    bge t1, a2, loop_end
    # TODO: Add your own implementation

    # count arr0 index [i * stride0]
    li t2, 0   # t2 = final result of i*stride0
    li t3, 0    # t3 = count mul times

mul_arr0_idx:
    bge t3, t1, end_arr0_idx_and_load    # when (count(t3) >= i(t1) )-->break
    add t2, t2, a3              # accum stride0
    addi t3, t3, 1              # count + 1
    j mul_arr0_idx

end_arr0_idx_and_load:
    slli t2, t2, 2  # 1w 4byte
    add t2, t2, a0  # t2 = arr0[t1 * stride0] address
    lw t6, 0(t2)    # t6 = arr0[t1 * stride0]
    # t6 = arr0[t1 * stride0]


    # count arr0 index [i * stride0]
    li t2, 0   # t2 = final result of i*stride1
    li t3, 0    # t3 = count mul times

mul_arr1_idx:
    bge t3, t1, end_arr1_idx_and_load    # when (count(t3) >= i(t1) )-->break
    add t2, t2, a4              # accum stride1
    addi t3, t3, 1              # count + 1
    j mul_arr1_idx

end_arr1_idx_and_load:
    slli t2, t2, 2  # 1w 4byte
    add t2, t2, a1  # t2 = arr1[t1 * stride1] address
    lw t5, 0(t2)    # t5 = arr1[t1 * stride1]
    # t5 = arr1[t1 * stride1]


    # mul arr1[t1 * stride1]*arr0[t1 * stride0]   (t5*t6)
    li t2, 0   # t2 = final result of arr1[t1 * stride1]*arr0[t1 * stride0]
    li t3, 0    # t3 = count mul times
    # check if t6 is neg
    blt t6, x0, neg_operand

mul_values:
    # check pos neg
    bge t3, t6, end_mul_values   # break if   count >=  t6
    add t2, t2, t5               # accum t5
    addi t3, t3, 1               # count + 1
    j mul_values


neg_operand:
    sub t6, x0, t6
neg_mul:
    bge t3, t6, neg_handle   # break if   count >=  t6
    add t2, t2, t5               # accum t5
    addi t3, t3, 1               # count + 1
    j neg_mul

neg_handle:
    sub t2, x0, t2

end_mul_values:
    add t0, t0 ,t2              # add this iter result to final sum

    # iter + 1 and jump back
    addi t1, t1, 1
    j loop_start


loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit


