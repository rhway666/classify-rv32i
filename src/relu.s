.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1
    blt a1, t0, error
    li t1, 0            # t1 = count
    li t2, 0            # now  index address shift


loop_start:
    # TODO: Add your own implementation
    bge t1, a1, loop_end

    # lw from arr
    add t3, t2, a0
    lw t4, 0(t3)

    # t4 > 0 ?
    bgt t4, x0, pass
    # t4 < 0 -> return 0
    sw x0, 0(t3)
    addi t1, t1, 1  # next count
    addi t2, t2, 4  # next mem
    j loop_start

pass:
    addi t1, t1, 1  # next count
    addi t2, t2, 4  # next mem
    j loop_start

loop_end:
    jr ra

error:
    li a0, 36
    j exit
