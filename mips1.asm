.data
    msg_fib30: .asciiz "O 30º termo da sequência de Fibonacci é: "
    msg_fib41: .asciiz "O 41º termo da sequência de Fibonacci é: "
    msg_fib40: .asciiz "O 40º termo da sequência de Fibonacci é: "
    msg_phi: .asciiz "A razão áurea (?) calculada é: "

.text
.globl main

main:
    # Calcular o 30º termo da sequência de Fibonacci
    li $a0, 30          # n = 30
    jal fibonacci       # Chama a função Fibonacci
    move $s1, $v0       # Armazena o resultado em $s1

    # Calcular o 41º termo da sequência de Fibonacci
    li $a0, 41          # n = 41
    jal fibonacci       # Chama a função Fibonacci
    move $s2, $v0       # Armazena o resultado em $s2

    # Calcular o 40º termo da sequência de Fibonacci
    li $a0, 40          # n = 40
    jal fibonacci       # Chama a função Fibonacci
    move $s3, $v0       # Armazena o resultado em $s3

    # Calcular a razão áurea (?)
    move $a0, $s2       # Passa F_41 como argumento
    move $a1, $s3       # Passa F_40 como argumento
    jal calcula_phi     # Chama a função para calcular ?

    # Imprimir os resultados
    li $v0, 4
    la $a0, msg_fib30
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, msg_fib41
    syscall

    li $v0, 1
    move $a0, $s2
    syscall

    li $v0, 4
    la $a0, msg_fib40
    syscall

    li $v0, 1
    move $a0, $s3
    syscall

    li $v0, 4
    la $a0, msg_phi
    syscall

    li $v0, 2
    mov.s $f12, $f0
    syscall

    # Encerrar o programa
    li $v0, 10
    syscall

# Função para calcular o n-ésimo termo da sequência de Fibonacci
fibonacci:
    li $t0, 0          # F_0 = 0
    li $t1, 1          # F_1 = 1
    beq $a0, 0, fib_done
    beq $a0, 1, fib_done

fib_loop:
    sub $a0, $a0, 1
    add $t2, $t0, $t1  # F_n = F_(n-1) + F_(n-2)
    move $t0, $t1
    move $t1, $t2
    bne $a0, 1, fib_loop

    move $v0, $t1

fib_done:
    move $v0, $t0
    jr $ra

# Função para calcular a razão áurea (?)
calcula_phi:
    mtc1 $a0, $f4       # F_41 em $f4
    mtc1 $a1, $f6       # F_40 em $f6
    div.s $f0, $f4, $f6 # ? = F_41 / F_40
    jr $ra

