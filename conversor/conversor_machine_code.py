
instruction_dict = { 
    "nop": "000000",
    "hlt": "111111", 
    "jmp": "000000", ##TIPO J --
    "add": "000011", ##TIPO R 
    "sub": "000000", ##TIPO R
    "sll": "000000", ##TIPO R
    "srl": "000000", ##TIPO R
    "and": "000000", ##TIPO R
    "or" : "000000", ##TIPO R   
    "slt": "000000", ##TIPO R   
    "lw" : "000000", ##TIPO I --  
    "sw" : "000000", ##TIPO I   
    "bqe": "000000", ##TIPO I   
    "bne": "000000"  ##TIPO I  
    }

register_dict = {
    "R00": "00000",
    "R01": "00001",
    "R02": "00010",
    "R03": "00011",
    "R04": "00100",
    "R05": "00101",
    "R06": "00110",
    "R07": "00111",
    "R08": "01000",
    "R09": "01001",
    "R10": "01010",
    "R11": "01011",
    "R12": "01100",
    "R13": "01101",
    "R14": "01110",
    "R15": "01111",
    "R16": "10000",
    "R17": "10001",
    "R18": "10010",
    "R19": "10011",
    "R20": "10100"
}

def escreve_arquivo(arquivo):
    a=a

def ler_arquivo(arquivo):
    arq = open(arquivo, "+r")
    return arq.readlines()

if __name__ =="__main__":
    print("TESTE DE FUNCIONAMENTO")

    arq   = ler_arquivo("program.txt")
    