library verilog;
use verilog.vl_types.all;
entity EX_MEM_Reg is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        MEM_Signal      : in     vl_logic_vector(1 downto 0);
        MEM_WB_Signal   : in     vl_logic_vector(1 downto 0);
        ALUOut          : in     vl_logic_vector(31 downto 0);
        EX_Reg_RD       : in     vl_logic_vector(4 downto 0);
        EX_MEM_Write_Con: out    vl_logic;
        EX_MEM_Read_Con : out    vl_logic;
        EX_MEM_ALUOut   : out    vl_logic_vector(31 downto 0);
        EX_MEM_MEMtoReg : out    vl_logic;
        EX_MEM_RegWre   : out    vl_logic;
        EX_MEM_Reg_RD   : out    vl_logic_vector(4 downto 0)
    );
end EX_MEM_Reg;
