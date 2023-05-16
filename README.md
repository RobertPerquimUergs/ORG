# ORG
Projeto e desenvolvimento de um processador Mips

# Caminho de Dados
    ![image](dataforwarding.png?raw=true "title")

# Instruções com 32 bits
    //Operações dentro do processador: 
    Tipo R =>   | 6-opcode | 5-reg1 | 5-reg2 | 5-reg3 | 5- shampt | 6-func |
    
    //Operações com endereço imediato:
    Tipo I =>   | 6-opcode | 5-reg1 | 5-reg2 |         16- dest            |
    
    //Operações de desvio:
    Tipo J =>   | 6-opcode |               26-destino                      |

# Registradores 
