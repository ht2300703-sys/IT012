# Ma nguon mr -Tran Gia Huy-25520737– tinh tien dien
.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
mb:      .asciiz "Bac "
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
cnt:     .word 0, 0, 0, 0

.text
.globl main
main:
  la   $s0, reading
  la   $s1, usage
  addi $s2, $zero, 0
  addi $s3, $zero, 12
  addi $s4, $zero, 0
  addi $s5, $zero, -1
  addi $s6, $zero, 0

LoopCalc:
  beq  $s2, $s3, PrintResult
  sll  $t1, $s2, 2
  add  $t2, $s0, $t1
  lw   $t3, 0($t2)
  lw   $t4, 4($t2)
  sub  $t5, $t4, $t3

  add  $t6, $s1, $t1
  sw   $t5, 0($t6)
  add  $s4, $s4, $t5

  slt  $t7, $s5, $t5
  beq  $t7, $zero, NextItem
  add  $s5, $t5, $zero
  addi $s6, $s2, 1

NextItem:
  li   $v0, 4
  la   $a0, m1
  syscall
  li   $v0, 1
  addi $a0, $s2, 1
  syscall
  li   $v0, 4
  la   $a0, m2
  syscall
  li   $v0, 1
  add  $a0, $t5, $zero
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall

  addi $s2, $s2, 1
  j    LoopCalc

PrintResult:
  li   $v0, 4
  la   $a0, mt
  syscall
  li   $v0, 1
  add  $a0, $s4, $zero
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall

  li   $v0, 4
  la   $a0, mm
  syscall
  li   $v0, 1
  add  $a0, $s6, $zero
  syscall
  li   $v0, 4
  la   $a0, lp
  syscall
  li   $v0, 1
  add  $a0, $s5, $zero
  syscall
  li   $v0, 4
  la   $a0, rp
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall

  addi $s2, $zero, 0
  la   $s7, cnt

LoopCount:
  beq  $s2, $s3, PrintCount
  sll  $t1, $s2, 2
  add  $t6, $s1, $t1
  lw   $t5, 0($t6)

  slti $t0, $t5, 101
  bne  $t0, $zero, C_B1
  slti $t0, $t5, 151
  bne  $t0, $zero, C_B2
  slti $t0, $t5, 201
  bne  $t0, $zero, C_B3
  li   $t8, 3
  j    IncCount

C_B1:
  li   $t8, 0
  j    IncCount
C_B2:
  li   $t8, 1
  j    IncCount
C_B3:
  li   $t8, 2

IncCount:
  sll  $t9, $t8, 2
  add  $t9, $t9, $s7
  lw   $t0, 0($t9)
  addi $t0, $t0, 1
  sw   $t0, 0($t9)

  addi $s2, $s2, 1
  j    LoopCount

PrintCount:
  addi $s2, $zero, 0
  addi $s3, $zero, 4

LoopPrintCnt:
  beq  $s2, $s3, ExitAll
  sll  $t1, $s2, 2
  add  $t9, $s7, $t1
  lw   $t0, 0($t9)

  li   $v0, 4
  la   $a0, mb
  syscall
  li   $v0, 1
  addi $a0, $s2, 1
  syscall
  li   $v0, 4
  la   $a0, m2
  syscall
  li   $v0, 1
  add  $a0, $t0, $zero
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall

  addi $s2, $s2, 1
  j    LoopPrintCnt

ExitAll:
  li   $v0, 10
  syscall