library verilog;
use verilog.vl_types.all;
entity CU is
    port(
        OpCode          : in     vl_logic_vector(5 downto 0);
        RegWre          : out    vl_logic;
        RegDst          : out    vl_logic;
        J               : out    vl_logic_vector(1 downto 0);
        MEM_Read        : out    vl_logic;
        MEM_Write       : out    vl_logic;
        MEMtoReg        : out    vl_logic;
        ExtSign         : out    vl_logic;
        ALUOp           : out    vl_logic_vector(2 downto 0)
    );
end CU;