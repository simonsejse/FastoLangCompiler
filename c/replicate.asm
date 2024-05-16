# DISCLAIMER: this is just psuedo-ish risc-v to help make CodeGen.fs from replicate.c :)

#int n = 10; 
#bool a = true;
#
#bool* bools = malloc(sizeof(a) * n); 
#
#for(int i = 0; i < n; i++){
#    *(bools + i) = a; 
#}


li t1, 10                   #n
li t2, 1                    #a

li t3, 4                    #sizeof(a)
mul t3, t3, t1              #sizeof(a) * n

mv a0, t3                   #a0 = sizeof(a) * n
call malloc                 #t5 = malloc(sizeof(a) * n)
mv t5, a0                   #t5 = address of bools

li t4, 0                #i

loop:
    beq t4, t1, end

    slli t6, t4, 2          #i * 4
    add t6, t6, t5          #bools + i * 4

    sw t2, 0(t6)            #*(bools + i) = a

    addi t4, t4, 1 

    j loop
end:
