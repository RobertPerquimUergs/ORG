----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Newton Jr
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
library mito;
use mito.mito_pkg.all;

entity data_path is
  Port (
    clk                 : in  std_logic;
    rst_n               : in  std_logic;
    adress_sel          : in  std_logic;
    jmp_sel             : in  std_logic;
    alu_mem_sel         : in  std_logic;
    alu_b_ind           : in  std_logic;
    pc_en               : in  std_logic;
    ir_en               : in  std_logic;
    data_en             : in  std_logic;
    write_reg_en        : in  std_logic;
    alu_op              : in  std_logic_vector (5 downto 0);
    adress_pc           : out std_logic_vector (8 downto 0);
    decoded_inst        : out decoded_instruction_type;
    
    flag_z              : out std_logic;
    flag_n              : out std_logic;
    
    mem_write_sel       : in  std_logic;
    alu_a_ind           : in  std_logic;
    saida_memoria       : in  std_logic_vector (31 downto 0);       -- memory to instruction register and/or data register
    entrada_memoria     : out std_logic_vector (31 downto 0)        -- ula_out or reg_out to memory
  );

end data_path;

architecture rtl of data_path is

  -- REGISTRADORES PRO MULTICICLO
  signal instruction_register     : std_logic_vector (31 downto 0);   -- instrucao da memoria
  signal memory_data_register     : std_logic_vector (31 downto 0);   -- dado da memoria
  signal ALUout                   : std_logic_vector (31 downto 0);   -- registrador da saida da alu
  signal REG_A                    : std_logic_vector (31 downto 0);
  signal REG_B                    : std_logic_vector (31 downto 0); 

  -- ENDERECO DOS REGISTRADORES
  signal a_addr                   : std_logic;                        -- endereco registrador a
  signal b_addr                   : std_logic;                        -- endereco registrador b
  signal c_addr                   : std_logic;                        -- endereco registrador c

  -- OPERADORES DA ALU
  signal A_operand                : std_logic_vector (31 downto 0);
  signal B_operand                : std_logic_vector (31 downto 0);
  signal alu_out                  : std_logic_vector (31 downto 0); 

  -- DADO A SER ESCRITO NOS REGISTRADORES
  signal write_data               : std_logic_vector (31 downto 0);

  -- OUTROS SINAIS
  signal program_counter          : std_logic_vector (8  downto 0);


  -- REGISTRADORES
  signal reg0                     : std_logic_vector (31 downto 0);
  signal reg1                     : std_logic_vector (31 downto 0);
  signal reg2                     : std_logic_vector (31 downto 0);
  signal reg3                     : std_logic_vector (31 downto 0);
  signal reg4                     : std_logic_vector (31 downto 0);
  signal reg5                     : std_logic_vector (31 downto 0);
  signal reg6                     : std_logic_vector (31 downto 0);
  signal reg7                     : std_logic_vector (31 downto 0);
  signal reg8                     : std_logic_vector (31 downto 0);
  signal reg9                     : std_logic_vector (31 downto 0);
  signal reg10                    : std_logic_vector (31 downto 0);
  signal reg11                    : std_logic_vector (31 downto 0);
  signal reg12                    : std_logic_vector (31 downto 0);
  signal reg13                    : std_logic_vector (31 downto 0);
  signal reg14                    : std_logic_vector (31 downto 0);
  signal reg15                    : std_logic_vector (31 downto 0);
  signal reg16                    : std_logic_vector (31 downto 0);
  signal reg20                    : std_logic_vector (31 downto 0);
  signal reg21                    : std_logic_vector (31 downto 0);
  signal reg22                    : std_logic_vector (31 downto 0);
  signal reg23                    : std_logic_vector (31 downto 0);
  signal reg24                    : std_logic_vector (31 downto 0);
  signal reg25                    : std_logic_vector (31 downto 0);
  signal reg26                    : std_logic_vector (31 downto 0);
  signal reg27                    : std_logic_vector (31 downto 0);
  signal reg28                    : std_logic_vector (31 downto 0);
  signal reg29                    : std_logic_vector (31 downto 0);
  signal reg30                    : std_logic_vector (31 downto 0);
  signal reg31                    : std_logic_vector (31 downto 0);

  begin
  
  -- MUX ALU-A
  if (alu_a_ind = '0') then
    A_operand <= REG_A;
  else
    A_operand <= program_counter;
  end if;
  
  -- MUX ALU-B
  if (alu_b_ind = '0') then
    B_operand <= REG_B;
  else
    B_operand (31 downto 16) <= instruction_register(15 downto 0);
    B_operand (15 downto  0) <= "0000000000000000";
  end if;


  -- MUX REG
  if (write_reg_en) then
    c_addr <= b_addr;
  else
    c_addr <= instruction_register(15 downto 0);
  end if;
    
  -- Banco de registradores
  process(clk)
  begin
    case (a_addr) is
      when "00000" =>   REG_A <= reg0;
      when "00001" =>   REG_A <= reg1;
      when "00010" =>   REG_A <= reg2;
      when "00011" =>   REG_A <= reg3;
      when "00100" =>   REG_A <= reg4;  
      when "00101" =>   REG_A <= reg5;
      when "00110" =>   REG_A <= reg6;
      when "00111" =>   REG_A <= reg7;
      when "01000" =>   REG_A <= reg8;
      when "01001" =>   REG_A <= reg9;
      when "01010" =>   REG_A <= reg10;
      when "01011" =>   REG_A <= reg11;
      when "01100" =>   REG_A <= reg12;
      when "01101" =>   REG_A <= reg13;
      when "01110" =>   REG_A <= reg14;
      when "01111" =>   REG_A <= reg15;
      when "10000" =>   REG_A <= reg16;
      when "10001" =>   REG_A <= reg17;
      when "10010" =>   REG_A <= reg18;
      when "10011" =>   REG_A <= reg19;
      when "10100" =>   REG_A <= reg20;
      when "10101" =>   REG_A <= reg21;
      when "10110" =>   REG_A <= reg22;
      when "10111" =>   REG_A <= reg23;
      when "11000" =>   REG_A <= reg24;
      when "11001" =>   REG_A <= reg25;
      when "11010" =>   REG_A <= reg26;
      when "11011" =>   REG_A <= reg27;
      when "11100" =>   REG_A <= reg28;
      when "11101" =>   REG_A <= reg29;
      when "11110" =>   REG_A <= reg30;
      when "11111" =>   REG_A <= reg31;
    end case;

    case (b_addr) is
      when "00000" =>   REG_B <= reg0;
      when "00001" =>   REG_B <= reg1;
      when "00010" =>   REG_B <= reg2;
      when "00011" =>   REG_B <= reg3;
      when "00100" =>   REG_B <= reg4;  
      when "00101" =>   REG_B <= reg5;
      when "00110" =>   REG_B <= reg6;
      when "00111" =>   REG_B <= reg7;
      when "01000" =>   REG_B <= reg8;
      when "01001" =>   REG_B <= reg9;
      when "01010" =>   REG_B <= reg10;
      when "01011" =>   REG_B <= reg11;
      when "01100" =>   REG_B <= reg12;
      when "01101" =>   REG_B <= reg13;
      when "01110" =>   REG_B <= reg14;
      when "01111" =>   REG_B <= reg15;
      when "10000" =>   REG_B <= reg16;
      when "10001" =>   REG_B <= reg17;
      when "10010" =>   REG_B <= reg18;
      when "10011" =>   REG_B <= reg19;
      when "10100" =>   REG_B <= reg20;
      when "10101" =>   REG_B <= reg21;
      when "10110" =>   REG_B <= reg22;
      when "10111" =>   REG_B <= reg23;
      when "11000" =>   REG_B <= reg24;
      when "11001" =>   REG_B <= reg25;
      when "11010" =>   REG_B <= reg26;
      when "11011" =>   REG_B <= reg27;
      when "11100" =>   REG_B <= reg28;
      when "11101" =>   REG_B <= reg29;
      when "11110" =>   REG_B <= reg30;
      when "11111" =>   REG_B <= reg31;
    end case;

    if (write_reg_en) then
      case (c_addr) is
        when "00000" =>   reg0  <= write_data;
        when "00001" =>   reg1  <= write_data;
        when "00010" =>   reg2  <= write_data;
        when "00011" =>   reg3  <= write_data;
        when "00100" =>   reg4  <= write_data;  
        when "00101" =>   reg5  <= write_data;
        when "00110" =>   reg6  <= write_data;
        when "00111" =>   reg7  <= write_data;
        when "01000" =>   reg8  <= write_data;
        when "01001" =>   reg9  <= write_data;
        when "01010" =>   reg10 <= write_data;
        when "01011" =>   reg11 <= write_data;
        when "01100" =>   reg12 <= write_data;
        when "01101" =>   reg13 <= write_data;
        when "01110" =>   reg14 <= write_data;
        when "01111" =>   reg15 <= write_data;
        when "10000" =>   reg16 <= write_data;
        when "10001" =>   reg17 <= write_data;
        when "10010" =>   reg18 <= write_data;
        when "10011" =>   reg19 <= write_data;
        when "10100" =>   reg20 <= write_data;
        when "10101" =>   reg21 <= write_data;
        when "10110" =>   reg22 <= write_data;
        when "10111" =>   reg23 <= write_data;
        when "11000" =>   reg24 <= write_data;
        when "11001" =>   reg25 <= write_data;
        when "11010" =>   reg26 <= write_data;
        when "11011" =>   reg27 <= write_data;
        when "11100" =>   reg28 <= write_data;
        when "11101" =>   reg29 <= write_data;
        when "11110" =>   reg30 <= write_data;
        when "11111" =>   reg31 <= write_data;
      end case;
    end if;

  end process

end rtl;
