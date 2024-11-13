.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)    # t0 = max value

    li t1, 0        # t1 = max index
    li t2, 1        # t2 = curr index
    # t3 = array address shift
    # t4 = curr value
loop_start:
    # TODO: Add your own implementation
    bge t2, a1, done    # if t2 >＝ a1 (int):  Number of elements in the array  ->  break

    # load curr value
    slli t3, t2, 2       # t3 = t2 * 4 (calculate byte offset, assuming int is 4 bytes)
    add t3, a0, t3      # t3 = address of a[t2]
    # t4 = curr value
    lw t4, 0(t3)         # t4 = a[t2]

    # Compare current element with the current max
    bgt t4, t0, update_max  # If a[t2] > current max, update max value and index

    # Increment loop index
    addi t2, t2, 1
    j loop_start

update_max:
    mv t0, t4            # Update current max value
    mv t1, t2            # Update current max index
    addi t2, t2, 1
    j loop_start

handle_error:
    li a0, 36
    j exit

done:
    mv a0, t1            # Return the index of the first maximum element
    jr ra
