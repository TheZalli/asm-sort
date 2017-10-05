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

    # first iterator/pointer
    movq -0x8(%rbp), %rax

    # the loop from start to end
    main_loop:
        # second iterator/pointer
        movq %rax, %rcx
        # the value
        movq (%rax), %rdx

        # the insertion loop
        cmp_loop:
            subq $0x8, %rcx        # move 2nd iterator to left by quad

            cmpq -0x8(%rbp), %rcx  # check if we are inside bounds
            jle cmp_loop_break     # if at border (or outside), break

            cmpq %rdx, (%rcx)      # compare with the chosen value
            jge cmp_loop           # if value is greater than compared, continue
            # otherwise break
        cmp_loop_break:

        # 2nd iterator is now on the the place to be inserted
        # TODO

        addq $0x8, %rax  # advance iterator by one quad
        cmpq -0x18(%rbp), %rax  # check if we are inside bounds
    jl main_loop

    # delete stackframe
    movq %rbp, %rsp
    popq %rbp

    ret
