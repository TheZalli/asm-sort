.section .text

.globl sort # for linker

sort: # the sorting function
    # array pointer is %rdi
    # array length is %rsi

    # create stackframe
    pushq %rbp
    movq %rsp, %rbp

    # stack is now: return address, old stack base pointer
    
    subq $0x10, %rsp
    movq %rdi, -0x8(%rbp)
    movq %rsi, -0x10(%rbp)

    #                                (%rbp)     (%rsp)
    # stack is now: ret addr, old %rbp | ptr, len |

    # count
    shr $0x1, %rsi # div by 2
    shl $0x3, %rsi # int count to byte count
    movq %rsi, %rdx
    
    # src
    movq %rdi, %rsi

    # dest
    addq %rdx, %rdi

    call memmove

    # set 0th to 2
    movq -0x8(%rbp), %rdi
    movq $0x2, (%rdi)

    # delete stackframe
    movq %rbp, %rsp
    popq %rbp

    ret
