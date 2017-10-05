.section .text

.globl sort # for linker

sort: # the sorting function
    # array pointer is %rdi
    # array length is %rsi

    # create stackframe
    pushq %rbp
    movq %rsp, %rbp

    # stack is now: return address, old stack base pointer
    
    subq $0x18, %rsp
    movq %rdi, -0x8(%rbp)  # array ptr
    movq %rsi, -0x10(%rbp) # array len

    shl $0x3, %rsi  # quad count to byte count, *2^3 <=> *8
    addq %rsi, %rdi # end pointer, one past last quad
    movq %rdi, -0x18(%rbp) # array end ptr

    # + <=> -                     (%rbp) -8   -10  -18 (%rsp)
    # stack is now: ret addr, old %rbp | ptr, len, end |

    # iterator/pointer
    movq -0x8(%rbp), %rax
    loop:
        movq $0, (%rax) # TODO

        addq $0x8, %rax  # advance iterator by one quad
        cmpq -0x18(%rbp), %rax
    jl loop

    # delete stackframe
    movq %rbp, %rsp
    popq %rbp

    ret

# void shift_insert(int64_t* start, int64_t value, int64_t* end)
# start (ptr): %rdi
# value (quad): %rsi
# end (ptr): %rdx
#
# Requires the sort function's input parameters to be in the stack
shift_insert:
    # byte count
    subq %rdi, %rdx

    ret
